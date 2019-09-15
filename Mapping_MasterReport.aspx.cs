using ServiceDesk.controller;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServiceDesk.model;
using System.IO;
using System.Data.OleDb;
using ClosedXML.Excel;

namespace ServiceDesk.view
{
    public partial class Mapping_MasterReport : System.Web.UI.Page
    {
        ControllerWFMRequestor _Objwfm = new ControllerWFMRequestor();
        ModelWFMRequestor _objmodel = new ModelWFMRequestor();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Hdeditval.Value = "0";
            }
        }

        protected void BindGrid(DataTable dt)
        {
           // DataTable dt = _Objwfm.Show_MappingMasterUsers();
            if (dt!=null && dt.Rows.Count>0)
	        {
		        Grddata.DataSource=dt;
                Grddata.DataBind();
	        }
        }

        protected void ClearAllfields()
        {
            txtCallminerID.Text = "";
            txtDefaultPass.Text = "";
            txtDomain.Text = "";
            txtEmployeeID.Text = "";
            txtEmpName.Text = "";
            txtNTID.Text = "";
            txtLOB.Text = "";
            txtLocation.Text = "";
            txtPostion.Text = "";
            txtCompany.Text = "";
            txtTenant.Text = "";
            ddlType.SelectedValue = "0";
            txtSearch.Text = "";
            ddlSearchType.SelectedValue = "0";

        }

        protected void lnkdelete_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = ((LinkButton)sender).NamingContainer as GridViewRow;
                Label lblID = row.FindControl("lblid") as Label;
                _Objwfm.Delete_MappingMasterUsers(Convert.ToInt32(lblID.Text));
                Utility.MessageBox("Record Deleted Successfully.");
                DataTable dt = (DataTable)ViewState["SearchData"];
                BindGrid(dt);
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "ConvertJsonToCsv.aspx", "lnkdelete_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { }
        }

        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            try
            {
                ClearAllfields();
                GridViewRow row = ((LinkButton)sender).NamingContainer as GridViewRow;
                Label lblID = row.FindControl("lblid") as Label;
                Hdeditval.Value = lblID.Text;
                DataTable dt = _Objwfm.BindEditMappingMasterUser(Convert.ToInt32(Hdeditval.Value));
                if (dt != null && dt.Rows.Count > 0)
                {
                    txtCallminerID.Text = dt.Rows[0]["CallMiner_UserID"].ToString();
                    txtDefaultPass.Text = dt.Rows[0]["DefaultPassword"].ToString();
                    txtDomain.Text = dt.Rows[0]["Domain"].ToString();
                    txtEmployeeID.Text = dt.Rows[0]["EmployeeID"].ToString();
                    txtEmpName.Text = dt.Rows[0]["EmployeeName"].ToString();
                    txtNTID.Text = dt.Rows[0]["NTID"].ToString();

                    txtLOB.Text = dt.Rows[0]["LOB"].ToString();
                    txtLocation.Text = dt.Rows[0]["Location"].ToString();
                    txtPostion.Text = dt.Rows[0]["Position"].ToString();
                    txtCompany.Text = dt.Rows[0]["Company"].ToString();
                    txtTenant.Text = dt.Rows[0]["Tenant"].ToString();
                    ddlType.SelectedValue = dt.Rows[0]["Type"].ToString();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "LoadWaiverModalPopup();", true);
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "none", "<script>$('#deleteFileModal').modal('show');</script>", false);
                }
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "Mapping_MasterReport.aspx", "lnkEdit_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { }
        }

        protected void Grddata_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Grddata.PageIndex = e.NewPageIndex;
            DataTable dt = (DataTable)ViewState["SearchData"];
            BindGrid(dt);
        }

        protected void btnADD_Click(object sender, EventArgs e)
        {
            try
            {
                int count = 0;
                _objmodel.CallMiner_UserID = txtCallminerID.Text;
                _objmodel.Password = txtDefaultPass.Text;
                _objmodel.Domain = txtDomain.Text;
                _objmodel.EmployeeID = txtEmployeeID.Text;
                _objmodel.EmployeeName = txtEmpName.Text;
                _objmodel.NTID = txtNTID.Text;

                _objmodel.LOB = txtLOB.Text;
                _objmodel.Location = txtLocation.Text;
                _objmodel.Position = txtPostion.Text;
                _objmodel.Company = txtCompany.Text;
                _objmodel.Tenant = txtTenant.Text;
                _objmodel.Insert_Type = ddlType.SelectedValue;
                if (Hdeditval.Value == "0")
                {
                    count = _Objwfm.InsertMappingMasterUser(_objmodel);
                    if (count > 0)
                    {
                        Utility.MessageBox("Data Saved Successfully.");
                        //  BindGrid();
                        ClearAllfields();
                    }
                }
                else
                {
                    count = _Objwfm.Edit_MappingMasterUser(Convert.ToInt32(Hdeditval.Value), _objmodel);
                    if (count > 0)
                    {
                        Utility.MessageBox("Data Updated Successfully.");
                        DataTable dt = (DataTable)ViewState["SearchData"];
                        BindGrid(dt);
                        ClearAllfields();
                    }

                }
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "Mapping_MasterReport.aspx", "btnADD_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = new DataTable();

                _objmodel.Search_Type = ddlSearchType.SelectedValue;
                _objmodel.Search_Value = txtSearch.Text;
                dt = _Objwfm.SearchMappingMasterUser(_objmodel);
                if (dt.Rows.Count > 0)
                {
                    btnexport.Visible = true;
                    ViewState["SearchData"] = dt;
                    BindGrid(dt);
                    ClearAllfields();
                }
                else
                {
                    btnexport.Visible = false;
                    Utility.MessageBox("No Record found", "Mapping_MasterReport.aspx");
                }
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "Mapping_MasterReport.aspx", "btnSearch_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally

            { }
        }

        protected void btn_Export(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)ViewState["SearchData"];
            using (XLWorkbook wb = new XLWorkbook())
            {
                wb.Worksheets.Add(dt, "Customers");

                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=ExportAgentsReport"+DateTime.Now.ToString("dd/mm/yyyy")+"_.xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }
        }
    }
}