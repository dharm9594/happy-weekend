using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using Telerik.Web.UI;
using System.Reflection;
using System.Net;
using CWFM.Model;
using CWFM.Controller;
using ServiceDesk.model;

namespace ServiceDesk.view
{
    public partial class InactiveUser : System.Web.UI.Page
    {
        ControllerAddUser ObjPriController = new ControllerAddUser();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                bind_GV();
                FunCheckAddUserRights();
            }
        }

        private void FunCheckAddUserRights()
        {
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["connstr"].ConnectionString))
            {
                con.Open();
                string Query = "select RoleID from Risk_userMaster where uid =" + Convert.ToInt64(Session["UserID"]) + "";
                SqlCommand cmd = new SqlCommand(Query, con);
                string values = cmd.ExecuteScalar().ToString(); ;
                if (values.Contains("2") == false)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        #region "View/Update/Delete User Details"
        public void bind_GV()
        {
            userGV.DataSource = ObjPriController.PopulateData("no");
            userGV.DataBind();
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("InactiveUser.aspx");
        }

        protected void userGV_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridDataItem item = (GridDataItem)e.Item;
                string IPAddress = Utility.GetIPAddress();
                string LoginID = item.OwnerTableView.DataKeyValues[item.ItemIndex]["Login_ID"].ToString();
                ObjPriController.ActiveUser(IPAddress, LoginID);
                Response.Redirect("InactiveUser.aspx");
            }
            catch (Exception)
            {
                e.Canceled = true;
                throw;
            }
        }

        protected void userGV_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem && e.Item.IsInEditMode)
            {
                GridEditableItem editFormItem = (GridEditableItem)e.Item;
                TextBox TxtNTID = editFormItem.FindControl("TxtNTID") as TextBox;
                userGV.Controls.Add(new LiteralControl("<script type='text/javascript'>window['TxtNTID_ID'] = '" + TxtNTID.ClientID + "';</script>"));
                TextBox TxtFirstName = editFormItem.FindControl("TxtFirstName") as TextBox;
                userGV.Controls.Add(new LiteralControl("<script type='text/javascript'>window['TxtFirstName_ID'] = '" + TxtFirstName.ClientID + "';</script>"));
                TextBox TxtLastName = editFormItem.FindControl("TxtLastName") as TextBox;
                userGV.Controls.Add(new LiteralControl("<script type='text/javascript'>window['TxtLastName_ID'] = '" + TxtLastName.ClientID + "';</script>"));
            }
        }

        protected void userGV_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem && e.Item.IsInEditMode)
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                Label LblStatus = (Label)item.FindControl("LblHdnStatus");
                if (LblStatus != null)
                {
                    if (Convert.ToString(LblStatus.Text).ToLower().Equals("active"))
                    {
                        RadioButton RdoActive = (RadioButton)item.FindControl("RdoStatusActive");
                        RdoActive.Checked = true;
                    }
                    else
                    {
                        RadioButton RdoInActive = (RadioButton)item.FindControl("RdoStatusInActive");
                        RdoInActive.Checked = true;
                    }
                }
            }
        }
        #endregion

        #region "Filter Grid"
        protected void userGV_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            this.userGV.DataSource = ObjPriController.PopulateData("no");
        }
        #endregion
    }
}