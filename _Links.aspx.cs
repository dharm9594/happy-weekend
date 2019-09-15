
using ServiceDesk.controller;
using ServiceDesk.model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace adminTemp
{
    public partial class _Links : System.Web.UI.Page
    {
        ControllerWFMRequestor SSMSBL = new ControllerWFMRequestor();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                bindgrid();
               
            }
        }
   
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string id1 = "";
                id1 = GridView1.Rows[e.RowIndex].Cells[1].Text;
                Session["LinkID"] = id1;
                SSMSBL.delete_usefulLinks(Session["LinkID"].ToString());
                bindgrid();
                //Utility.MessageBox("Data Deleted");
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "_Links.aspx", "GridView1_RowDeleting", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { }
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            bindgrid();
        }
        protected void bindgrid()
        {
            DataTable dtagentdata = new DataTable();
            dtagentdata = SSMSBL.Get_UseFul_Links();
            GridView1.DataSource = dtagentdata;
            GridView1.DataBind();
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton del = e.Row.Cells[0].Controls[0] as LinkButton;
                del.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this Record?');");
                del.Attributes.Add("Text", "<i class='fa fa-trash-o'></i>");
            }
        }
    }
}