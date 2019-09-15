using ServiceDesk.controller;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServiceDesk.model;

namespace ServiceDesk.view
{
    public partial class IssueMaster : System.Web.UI.Page
    {
        ControllerWFMRequestor _Objwfm = new ControllerWFMRequestor();
        ModelWFMRequestor _objmodel = new ModelWFMRequestor();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindIssueLevel();
                BindIssueType();
                BindGrid();
                Hdeditval.Value = "0";
            }
        }

        protected void BindIssueLevel()
        {
            DataTable dt = _Objwfm.BindIssue_Level();
            if (dt!=null && dt.Rows.Count>0)
            {
                ddlIssuelevel.DataSource = dt;
                ddlIssuelevel.DataTextField = "Issue_level";
                ddlIssuelevel.DataValueField = "Issue_level";
                ddlIssuelevel.DataBind();
                ddlIssuelevel.Items.Insert(0, new ListItem("--Select--", "0"));                     
            }
        }

        protected void BindIssueType()
        {
            DataTable dt = _Objwfm.BindIssue_Type();
            if (dt != null && dt.Rows.Count > 0)
            {
                ddlIssuetype.DataSource = dt;
                ddlIssuetype.DataTextField = "Issue_Type";
                ddlIssuetype.DataValueField = "Issue_Type";
                ddlIssuetype.DataBind();
                ddlIssuetype.Items.Insert(0, new ListItem("--Select--", "0"));
            }
        }

        protected void BindGrid()
        {
            DataTable dt = _Objwfm.Show_IssueLevelData();
            if (dt!=null && dt.Rows.Count>0)
	        {
		        Grddata.DataSource=dt;
                Grddata.DataBind();
	        }
        }

        protected void ClearAllfields()
        {
            ddlIssuelevel.SelectedValue = "0";
            ddlIssuetype.SelectedValue = "0";
            txtIssuesubtype.Text = "";
            txtPriority.Text = "";
            txtSLA.Text = "";
        }

        protected void lnkdelete_Click(object sender, EventArgs e)
        {
            GridViewRow row = ((LinkButton)sender).NamingContainer as GridViewRow;
            Label lblID = row.FindControl("lblid") as Label;
            _Objwfm.Delete_IssueMaster(Convert.ToInt32(lblID.Text));
            Utility.MessageBox("Record Deleted Successfully.");
            BindGrid();
        }

        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            GridViewRow row = ((LinkButton)sender).NamingContainer as GridViewRow;
            Label lblID = row.FindControl("lblid") as Label;
            Hdeditval.Value=lblID.Text;
            DataTable dt = _Objwfm.BindEditMaster(Convert.ToInt32(Hdeditval.Value));
            if (dt!=null && dt.Rows.Count>0)
            {
                ddlIssuelevel.Text = dt.Rows[0]["Issue_level"].ToString();
                ddlIssuetype.Text = dt.Rows[0]["Issue_Type"].ToString();
                txtIssuesubtype.Text = dt.Rows[0]["Issue_SubType"].ToString();
                txtPriority.Text = dt.Rows[0]["Priority"].ToString();
                txtSLA.Text = dt.Rows[0]["SLA"].ToString();
            }
        }

        protected void Grddata_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Grddata.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void btnADD_Click(object sender, EventArgs e)
        {
            int count = 0;
            _objmodel._Issue_Level = ddlIssuelevel.Text;
            _objmodel._Issue_Type = ddlIssuetype.Text;
            _objmodel._Issue_SubType = txtIssuesubtype.Text;
            _objmodel._Issue_Priority = txtPriority.Text;
            _objmodel._Issue_SLA = txtSLA.Text;
            if (Hdeditval.Value == "0")
            {
                count = _Objwfm.InsertIssueMaster(_objmodel);
                if (count > 0)
                {
                    Utility.MessageBox("Data Saved Successfully.");
                    BindGrid();
                    ClearAllfields();
                }
            }
            else
            {
                count = _Objwfm.Edit_IssueMaster(Convert.ToInt32(Hdeditval.Value), _objmodel);
                if (count > 0)
                {
                    Utility.MessageBox("Data Updated Successfully.");
                    BindGrid();
                    ClearAllfields();
                }
                
            }
        }
    }
}