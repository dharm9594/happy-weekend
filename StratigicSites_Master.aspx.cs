
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
    public partial class StratigicSites_Master : System.Web.UI.Page
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
                Session["id1"] = id1;
                SSMSBL.delete_AddedSite(Session["id1"].ToString());
                bindgrid();
                //Utility.MessageBox("Data Deleted");
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "StratigicSites_Master.aspx", "GridView1_RowDeleting", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { }
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            bindgrid();
        }
        //protected void lnkEdit_Click(object sender, EventArgs e)
        //{
        //    LinkButton lb = (LinkButton)sender;
        //    GridViewRow row = (GridViewRow)lb.NamingContainer;
        //    string id = lb.ID;
        //    if (row != null)
        //    {
        //            txtCategory.Text = row.Cells[2].Text;
        //            ViewState["id"] = id;
        //            btnADD.Text = "Update";
        //    }

        //}
        protected void bindgrid()
        {
            DataTable dtagentdata = new DataTable();
            dtagentdata = SSMSBL.Get_StregicSite();
            GridView1.DataSource = dtagentdata;
            GridView1.DataBind();
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string Site = txtSite.Text;
                string ddlRegions = ddlRegion.SelectedItem.Text;
                string ddlCountrys = ddlCountry.SelectedItem.Text;


                SSMSBL.Add_Stretigic_Site(Site, ddlRegions, ddlCountrys);
                // Utility.MessageBox("Added Successfully");
                bindgrid();
                ddlRegion.SelectedIndex = 0;
                ddlCountry.SelectedIndex = 0;
                txtSite.Text = "";
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "StrategicSites_Master.aspx", "btnAdd_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
           
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