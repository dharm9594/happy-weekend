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
using ServiceDesk.controller;
using System.Text;

namespace ServiceDesk.view
{
    public partial class AddUser : System.Web.UI.Page
    {
        ControllerAddUser ObjPriController = new ControllerAddUser();
        ControllerWFMRequestor objCtrlReq = new ControllerWFMRequestor();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                bind_GV();
                BindRoles(AddChkRolesList);
                FunCheckAddUserRights();
            }
        }

        private void FunCheckAddUserRights()
        {
            if (Session["UserID"] != null)
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
            else
            { 
            
            }
        }

        #region "View/Update/Delete User Details"
        public void bind_GV()
        {
            userGV.DataSource = ObjPriController.PopulateData("yes");
            userGV.DataBind();
            DataTable dt = objCtrlReq.Get_StregicPartner();
            if (dt.Rows.Count > 0)
            {
                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "Stratigic_Partner_Name";
                ddlCategory.DataValueField = "ID";
                ddlCategory.DataBind();
                //ddlCategory.Items.Insert(0, "--Select--");
            }
        }

        private static string ShowCheckedItems(RadComboBox comboBox)
        {
            string str = "";
            var sb = new StringBuilder();
            var collection = comboBox.CheckedItems;

            if (collection.Count != 0)
            {
                //  sb.Append("<h3>Checked Items:</h3><ul class=\"results\">");

                foreach (var item in collection)
                    sb.Append(item.Value + ",");
                str = sb.ToString();
                str = str.Remove(str.Length - 1);
            }
            else
            {
                str = "";
                //comboBox.Items.Clear();
            }
            return str;
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddUser.aspx");
        }

        protected void userGV_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridDataItem item = (GridDataItem)e.Item;
                string IPAddress = Utility.GetIPAddress();
                string LoginID = item.OwnerTableView.DataKeyValues[item.ItemIndex]["Login_ID"].ToString();
                ObjPriController.FunDelete(IPAddress, LoginID);
                Response.Redirect("AddUser.aspx");
            }
            catch (Exception)
            {
                e.Canceled = true;
                throw;
            }
        }

        protected void userGV_EditCommand(object sender, GridCommandEventArgs e)
        {
            userGV.EditIndexes.Add(e.Item.ItemIndex);
            bind_GV();
        }

        protected void userGV_CancelCommand(object sender, GridCommandEventArgs e)
        {
            userGV.EditIndexes.Add(-1);
            bind_GV();
        }

        protected void userGV_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            string IPAddress = Utility.GetIPAddress();
            GridEditableItem item = (GridEditableItem)e.Item;
            string LoginID = item.GetDataKeyValue("Login_ID").ToString();
            string sTxtNTID = (item.FindControl("TxtNTID") as TextBox).Text;
            string sTxtFirstName = (item.FindControl("TxtFirstName") as TextBox).Text;
           // string sTxtLastName = (item.FindControl("TxtLastName") as TextBox).Text;
            RadioButton RdoActive = (RadioButton)item.FindControl("RdoStatusActive");
            int Status = 0;
            if (RdoActive.Checked == true)
                Status = 1;

            Int64 iRetVal = ObjPriController.FunUpdate(IPAddress, LoginID, sTxtNTID, sTxtFirstName,"", Status);
            if (iRetVal > 0)
                MessageBoxRedirect("User Updated Successfully.", "AddUser.aspx");
            else
                MessageBoxRedirect("User Already Exist.", "AddUser.aspx");
        }

        protected void userGV_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem && e.Item.IsInEditMode)
            {
                //GridEditFormItem editFormItem = (GridEditFormItem)e.Item;
                GridEditableItem editFormItem = (GridEditableItem)e.Item;
                TextBox TxtNTID = editFormItem.FindControl("TxtNTID") as TextBox;
                userGV.Controls.Add(new LiteralControl("<script type='text/javascript'>window['TxtNTID_ID'] = '" + TxtNTID.ClientID + "';</script>"));
                TextBox TxtFirstName = editFormItem.FindControl("TxtFirstName") as TextBox;
                userGV.Controls.Add(new LiteralControl("<script type='text/javascript'>window['TxtFirstName_ID'] = '" + TxtFirstName.ClientID + "';</script>"));
               // TextBox TxtLastName = editFormItem.FindControl("TxtLastName") as TextBox;
               // userGV.Controls.Add(new LiteralControl("<script type='text/javascript'>window['TxtLastName_ID'] = '" + TxtLastName.ClientID + "';</script>"));
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

        #region "Insert User"
        public void BindRoles(CheckBoxList ChkLst)
        {
            List<CWFM.Model.Roles> LstRoles = new List<CWFM.Model.Roles>();
            LstRoles = ObjPriController.GetAllRoles();
            ChkLst.DataSource = LstRoles.ToList();
            ChkLst.DataValueField = "RollID";
            ChkLst.DataTextField = "RollName";
            ChkLst.DataBind();
        }

        public string GetUsersUpdatedRole(CheckBoxList ChkLst)
        {
            string sRolesValue = "", sRolesText = "";
            try
            {
                for (int k = 0; k <= ChkLst.Items.Count - 1; k++)
                {
                    if (ChkLst.Items[k].Selected == true)
                    {
                        sRolesValue += Convert.ToString(ChkLst.Items[k].Value) + ",";
                        sRolesText += Convert.ToString(ChkLst.Items[k].Text) + ",";
                    }
                }
            }
            catch (Exception Ex) { throw Ex; }
            return sRolesValue + "@" + sRolesText;
        }

        protected void BtnAddUser_Click(object sender, EventArgs e)
        {
            string Stretigic_Partner = ShowCheckedItems(ddlCategory);
            string IPAddress = Utility.GetIPAddress();
            string[] ArrRoleValueText = GetUsersUpdatedRole(AddChkRolesList).Split(Convert.ToChar("@"));
            string sRolesValue = "", sRolesText = "";
            sRolesValue = ArrRoleValueText[0].ToString();
            sRolesText = ArrRoleValueText[1].ToString();

            int UserStatus = 0;
            if (AddRdoStatusActive.Checked == true)
                UserStatus = 1;

            Int64 iRetVal = ObjPriController.FunAddUser(TxtLawsonID.Text, AddTxtNTID.Text, AddTxtFirstName.Text, AddTxtLastName.Text, sRolesValue, sRolesText, UserStatus, IPAddress, Stretigic_Partner);
            if (iRetVal > 0)
                MessageBox("User Added Successfully.");
            else
                MessageBox("User Already Exist.");
            ClearFields();
            bind_GV();
        }

        public void ClearFields()
        {
            AddTxtNTID.Text = "";
            AddTxtFirstName.Text = "";
            AddTxtLastName.Text = "";
            foreach (ListItem LstItem in AddChkRolesList.Items)
            {
                LstItem.Selected = false;
            }
        }

        protected void BtnCancel_Click(object sender, EventArgs e)
        {
            ClearFields();
        }
        #endregion

        #region "Message Box"
        private void MessageBox(string Msg)
        {
            string jScript = "<script type='text/javascript' language='javascript'>alert('" + Msg + "');</script>";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Info", jScript);
        }

        private void MessageBoxRedirect(string Msg, string URL)
        {
            string jScript = "<script type='text/javascript' language='javascript'>alert('" + Msg + "'); window.parent.location='" + URL + "';</script>";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Info", jScript);
        }
        #endregion

        #region "Edit Roles"
        public void CheckUserRoles(string LoginID)
        {
            string sUserRoles = ObjPriController. GetUserRoleID(LoginID);
            string[] SplitRoles = sUserRoles.Split(Convert.ToChar(","));

            for (int j = 0; j <= SplitRoles.Length - 1; j++)
            {
                for (int k = 0; k <= ChkRolesList.Items.Count - 1; k++)
                {
                    if (Convert.ToString(SplitRoles[j]).Equals(Convert.ToString(ChkRolesList.Items[k].Value)))
                    {
                        ChkRolesList.Items[k].Selected = true;
                        break;
                    }
                }
            }
        }

        protected void BtnUpdateRole_Click(object sender, EventArgs e)
        {
            string[] ArrRoleValueText = GetUsersUpdatedRole(ChkRolesList).Split(Convert.ToChar("@"));
            string sRolesValue = "", sRolesText = "";
            sRolesValue = ArrRoleValueText[0].ToString();
            sRolesText = ArrRoleValueText[1].ToString();
            string IPAddress = Utility.GetIPAddress();
            ObjPriController.FunUpdateRole(IPAddress, sRolesText, TxtHdnLoginID.Text, sRolesValue);
            bind_GV();
        }

        protected void LnkViewRoles_Click(object sender, EventArgs e)
        {
            BindRoles(ChkRolesList);
            string sLoginID = Convert.ToString(((LinkButton)sender).CommandArgument);
            TxtHdnLoginID.Text = sLoginID;

            LinkButton LnkView = ((LinkButton)sender);
            Telerik.Web.UI.GridDataItem gr = (Telerik.Web.UI.GridDataItem)LnkView.NamingContainer;
            string fname = (gr.FindControl("LblFirstName") as Label).Text;
           // string lname = (gr.FindControl("LblLastName") as Label).Text;

           // LblPopupUserName.Text = "View Roles For : " + Convert.ToString(fname + " " + lname);
            LblPopupUserName.Text = "View Roles For : " + Convert.ToString(fname);
            CheckUserRoles(Convert.ToString(sLoginID));
            ModalPopupExtender1.Show();
        }
        #endregion

        #region "Filter Grid"
        protected void userGV_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            this.userGV.DataSource = ObjPriController. PopulateData("yes");
        }
        #endregion

    }
}