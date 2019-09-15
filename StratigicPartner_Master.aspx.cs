
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
    public partial class StratigicPartner_Master : System.Web.UI.Page
    {
        ControllerWFMRequestor SSMSBL = new ControllerWFMRequestor();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindgrid();
                Bindddl();
            }
        }

        protected void Bindddl()
        {
            DataTable dtSite = new DataTable();
            dtSite = SSMSBL.Get_StregicSite();
            if (dtSite.Rows.Count > 0)
            {
                ddlSite.DataSource = dtSite;
                ddlSite.DataTextField = "Site";
                ddlSite.DataValueField = "Site_id";
                ddlSite.DataBind();
            }
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string id1 = "";
                id1 = GridView1.Rows[e.RowIndex].Cells[1].Text;
                Session["id1"] = id1;
                SSMSBL.delete_AddedPartner(Session["id1"].ToString());
                bindgrid();
                //Utility.MessageBox("Data Deleted");
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "StratigicPartner_Master.aspx", "GridView1_RowDeleting", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
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
            dtagentdata = SSMSBL.Get_StregicPartner();
            GridView1.DataSource = dtagentdata;
            GridView1.DataBind();
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string Partner_id = txtPartner_id.Text;
                string Partner_Name = txtPartner_Name.Text;
                string Site = ddlSite.SelectedValue;


                SSMSBL.Add_Stretigic_Partner(Partner_id, Partner_Name, Site);
                // Utility.MessageBox("Added Successfully");
                bindgrid();
                ddlSite.SelectedIndex = 0;
                txtPartner_Name.Text = "";
                txtPartner_id.Text = "";
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "StratigicPartner_Master.aspx", "btnAdd_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { }
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