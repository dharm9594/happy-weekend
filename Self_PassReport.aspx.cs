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
    public partial class Self_PassReport : System.Web.UI.Page
    {
        ControllerWFMRequestor _Objwfm = new ControllerWFMRequestor();
        ModelWFMRequestor _objmodel = new ModelWFMRequestor();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string Date = Convert.ToDateTime(DateTime.Today).ToString("yyyy-MM-dd");
                string[] td = Date.Split('-');
                string Expdate = td[0] + "-" + td[1] + "-" + td[2];
                txtFromDate.DateInput.DisplayText = Expdate;
                txtFromDate.SelectedDate = Convert.ToDateTime(DateTime.Today);
                txtToDate.DateInput.DisplayText = Expdate;
                txtToDate.SelectedDate = Convert.ToDateTime(DateTime.Today);
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
            txtFromDate.SelectedDate = null;
            txtToDate.SelectedDate = null;
            ddlRequestStatus.SelectedValue = "00";
            ddlRequestType.SelectedValue = "0";
        }
        protected void Grddata_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Grddata.PageIndex = e.NewPageIndex;
            DataTable dt = (DataTable)ViewState["SearchData"];
            BindGrid(dt);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = new DataTable();
                if (ddlRequestType.SelectedIndex > 0)
                _objmodel.Search_Type = ddlRequestType.SelectedValue;
                if (ddlRequestStatus.SelectedIndex > 0)
                _objmodel.Search_Value = ddlRequestStatus.SelectedValue;
                _objmodel.From_Date = Convert.ToString(Convert.ToDateTime(txtFromDate.SelectedDate).ToString("yyyy-MM-dd"));
                _objmodel.To_Date = Convert.ToString(Convert.ToDateTime(txtToDate.SelectedDate).ToString("yyyy-MM-dd"));

                dt = _Objwfm.SearchSelfUser(_objmodel);
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
                    Utility.MessageBox("No Record found", "Self_PassReport.aspx");
                }
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "Self_PassReport.aspx", "btnSearch_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
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
                Response.AddHeader("content-disposition", "attachment;filename=ExportSelfPasswordUsers.xlsx");
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