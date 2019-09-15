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

namespace ServiceDesk.view
{
    public partial class Mapping_MasterUser : System.Web.UI.Page
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

        protected void BindGrid()
        {
            DataTable dt = _Objwfm.Show_MappingMasterUsers();
            if (dt!=null && dt.Rows.Count>0)
	        {
		        Grddata.DataSource=dt;
                Grddata.DataBind();
                Griddiv.Visible = true;
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

        }

        protected void lnkdelete_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = ((LinkButton)sender).NamingContainer as GridViewRow;
                Label lblID = row.FindControl("lblid") as Label;
                _Objwfm.Delete_MappingMasterUsers(Convert.ToInt32(lblID.Text));
                Utility.MessageBox("Record Deleted Successfully.");
                BindGrid();
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "Mapping_masterUser.aspx", "lnkdelete_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { }
        }

        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            try
            {
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
                }
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "Mapping_masterUser.aspx", "lnkEdit_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { }
        }

        protected void Grddata_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Grddata.PageIndex = e.NewPageIndex;
            BindGrid();
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
                        BindGrid();
                        ClearAllfields();
                    }
                }
                else
                {
                    count = _Objwfm.Edit_MappingMasterUser(Convert.ToInt32(Hdeditval.Value), _objmodel);
                    if (count > 0)
                    {
                        Utility.MessageBox("Data Updated Successfully.");
                        BindGrid();
                        ClearAllfields();
                    }

                }
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "Mapping_masterUser.aspx", "btnADD_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { }
        }

        protected void DDLRequestType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdbselection.SelectedValue == "Single")
            {
                SingleInsert.Visible = true;
                MultipleInsert.Visible = false;
            }
            else if (rdbselection.SelectedValue == "Multiple")
            {
                SingleInsert.Visible = false;
                MultipleInsert.Visible = true;
            }

        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            try
            {
                if (updUpload.HasFile)
                {

                    string conString = string.Empty;
                    DataTable dtExcelData = new DataTable();
                    string Ext = Path.GetExtension(updUpload.PostedFile.FileName);
                    if (Ext == ".xls" || Ext == ".xlsx")
                    {
                        string FilePath = Server.MapPath(updUpload.PostedFile.FileName);
                        updUpload.SaveAs(FilePath);
                        dtExcelData = FillGridFromExcelSheet(FilePath, Ext, "Sheet1");
                        int count = 0;
                        for (int i = 0; i < dtExcelData.Rows.Count; i++)
                        {

                            _objmodel = new ModelWFMRequestor();
                            _objmodel.EmployeeID = Convert.ToString(dtExcelData.Rows[i]["EmployeeID"]);
                            _objmodel.EmployeeName = Convert.ToString(dtExcelData.Rows[i]["EmployeeName"]);
                            _objmodel.Domain = Convert.ToString(dtExcelData.Rows[i]["NT Domain"]);
                            _objmodel.NTID = Convert.ToString(dtExcelData.Rows[i]["NTID"]);
                            _objmodel.CallMiner_UserID = Convert.ToString(dtExcelData.Rows[i]["CallMiner_UserID"]);
                            _objmodel.LOB = Convert.ToString(dtExcelData.Rows[i]["LOB"]);
                            _objmodel.Location = Convert.ToString(dtExcelData.Rows[i]["Location"]);
                            _objmodel.Position = Convert.ToString(dtExcelData.Rows[i]["Position"]);
                            _objmodel.Company = Convert.ToString(dtExcelData.Rows[i]["Company"]);
                            _objmodel.Tenant = Convert.ToString(dtExcelData.Rows[i]["Tenant"]);
                            _objmodel.Password = Convert.ToString(dtExcelData.Rows[i]["Password"]);
                            _objmodel.Insert_Type = Convert.ToString(dtExcelData.Rows[i]["Insert_Type"]);
                            count = _Objwfm.InsertMappingMasterUser(_objmodel);

                            //Utility.MessageBox("Data Saved Successfully.");
                        }
                        BindGrid();
                        ClearAllfields();
                        Utility.MessageBox("Data Saved Successfully.");
                    }
                    else
                    {
                        Utility.MessageBox("Upload .xls OR .xlsx file only");
                    }

                }
                else
                {
                    Utility.MessageBox("Choose File to Upload!!!");
                }
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "Mapping_MsterUser.aspx", "btnUpload_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
        }

        private DataTable FillGridFromExcelSheet(string FilePath, string ext, string isHader)
        {
            string connectionString = "";
            if (ext == ".xls")
            {   //For Excel 97-03
                connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties='Excel 8.0;HDR={1}'";
            }
            else if (ext == ".xlsx")
            {    //For Excel 07 and greater
                connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 8.0;HDR={1}'";
            }
            connectionString = String.Format(connectionString, FilePath, isHader);
            OleDbConnection conn = new OleDbConnection(connectionString);
            OleDbCommand cmd = new OleDbCommand();
            OleDbDataAdapter dataAdapter = new OleDbDataAdapter();
            DataTable dt = new DataTable();
            cmd.Connection = conn;
            conn.Open();
            DataTable dtSchema;
            dtSchema = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            string ExcelSheetName = dtSchema.Rows[0]["TABLE_NAME"].ToString();
            cmd.CommandText = "SELECT * From [" + ExcelSheetName + "]";
            dataAdapter.SelectCommand = cmd;
            dataAdapter.Fill(dt);
            conn.Close();
            return dt;
        }


        protected void DownloadFile(object sender, EventArgs e)
        {
            string filePath = (sender as LinkButton).CommandArgument;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
            Response.WriteFile(filePath);
            Response.End();
        }
    }
}