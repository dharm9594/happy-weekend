using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServiceDesk.controller;
using ServiceDesk.model;
using System.Data;
using System.Text;

namespace ServiceDesk.view
{
    public partial class TicketDetails : System.Web.UI.Page
    {
        #region "Class Objects"
        ControllerWFMRequestor objCtrlReq = new ControllerWFMRequestor();
        ModelWFMRequestor objMdlReq = null;
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                string strRawURL = Request.RawUrl;
                var strQueryString = Utility.Decrypt(HttpUtility.UrlDecode(strRawURL.Substring(strRawURL.IndexOf('?') + 1)));
                string[] RequestID = strQueryString.Split('=');
                Session["RequestID"] = Convert.ToInt32(RequestID[1]);
                BindRequestorDetails(Convert.ToInt32(RequestID[1]));
            }
        }

        public void BindRequestorDetails(Int32 iRequestID)
        {
            try
            {
                objCtrlReq = new ControllerWFMRequestor();
                DataTable DT = objCtrlReq.GetRequestorDetailsByID_WFM(iRequestID);
                //Request
                UsrCtrlRequestDetail.BindRequestorDetails(iRequestID, DT);
                //WFM
                lblWFMDate.Text = DateTime.Now.ToString("dd MMM yyyy HH:mm:ss");
                divWFMRejected.Visible = false;
                divResolved.Visible = false;
                ShowIframe.Visible = false;
                // txtWFMComments.Text = Convert.ToString(DT.Rows[0]["RequestorComments"]);
                DataTable dt = objCtrlReq.Get_StregicPartner();
                if (dt.Rows.Count > 0)
                {
                    ddlStratigic_Partner.DataSource = dt;
                    ddlStratigic_Partner.DataTextField = "Stratigic_Partner_Name";
                    ddlStratigic_Partner.DataValueField = "ID";
                    ddlStratigic_Partner.DataBind();
                    ddlStratigic_Partner.Items.Insert(0, "--Select--");
                }
                if (DT.Rows[0]["StratigicPartnerMasterID"] != null)
                {
                    ddlStratigic_Partner.SelectedValue = DT.Rows[0]["StratigicPartnerMasterID"].ToString();
                }
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "TicketDetails.aspx", "BindRequestorDetails", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { 
            }
        }

        #region "Bind All DropDownList"

        protected void DDLRequestType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string RequestType = ddlIssue_Level.SelectedValue.ToString();
            if (RequestType != "0")
            {
                BindIssueType(RequestType);
            }
        }
        protected void DDLIssueType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string RequestType = ddlIssue_Type.SelectedValue.ToString();
            if (RequestType != "--Select--")
            {
                BindIssueSubType(RequestType);
            }
        }

        protected void DDLIssue_SubType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string Issue_SubType = ddlIssue_SubType.SelectedValue.ToString();
            DataTable DT = (DataTable)ViewState["RequestedDT"];
            DataTable dt1 = new DataTable();
            dt1 = DT.Clone();
            if (Issue_SubType != "--Select--")
            {
                DataRow[] rowArray = DT.Select("Id=" + Issue_SubType + "");
                foreach (DataRow row in rowArray)
                {
                    dt1.ImportRow(row);
                }
            }
            if (dt1.Rows.Count > 0)
            {
                txtPriority.Text = dt1.Rows[0]["SLA"].ToString();
                if (dt1.Rows[0]["Is_API_Checked"].ToString() == "True")
                {
                    ShowIframe.Visible = true;
                    ifarme11.Attributes.Add("src", dt1.Rows[0]["Page_Url"].ToString());
                    iFrameHeader.InnerText = ddlIssue_SubType.SelectedItem.Text +" API :";
                }
                else
                {
                    ShowIframe.Visible = false;
                }
            }
          //  headerPass.InnerText = ddlIssue_SubType.SelectedItem.Text;
          //  showResetPassword.Visible = false;
          //  btnRaised.Visible = true;


        }


        protected void BindIssueType(string RequestType)
        {

            DataTable dt = objCtrlReq.GetRequestedType(RequestType);
            ViewState["RequestedDT"] = dt;
            ddlIssue_Type.Items.Clear();
            DataTable dtIssue_Type = dt.DefaultView.ToTable("Issue_Type", true, "Issue_Type");
            if (dtIssue_Type.Rows.Count > 0)
            {
                ddlIssue_Type.DataSource = dtIssue_Type;
                ddlIssue_Type.DataTextField = "Issue_Type";
                ddlIssue_Type.DataValueField = "Issue_Type";
                ddlIssue_Type.DataBind();
                ddlIssue_Type.Items.Insert(0, "--Select--");
            }
        }
        protected void BindIssueSubType(string IssueType)
        {
            if (ViewState["RequestedDT"] != null)
            {
                DataTable DT = (DataTable)ViewState["RequestedDT"];
                DataTable dt1 = new DataTable();
                dt1 = DT.Clone();

                DataRow[] rowArray = DT.Select("Issue_Type='" + IssueType + "'");

                foreach (DataRow row in rowArray)
                {
                    dt1.ImportRow(row);
                }
                if (dt1.Rows.Count > 0)
                {
                    ddlIssue_SubType.DataSource = dt1;
                    ddlIssue_SubType.DataTextField = "Issue_SubType";
                    ddlIssue_SubType.DataValueField = "Id";
                    ddlIssue_SubType.DataBind();
                    ddlIssue_SubType.Items.Insert(0, "--Select--");
                }
            }

        }
        #endregion

        #region "Update Requestor Details"
        protected void btnSaveWFMRequestorData_Click(object sender, EventArgs e)
        {
            if (Page.IsValid == true)
            {
                try
                {
                   
                    objMdlReq = new ModelWFMRequestor();
                    objMdlReq.Stretegic_partner_id = ddlStratigic_Partner.SelectedValue;
                    objMdlReq.Issue_Type_Name = ddlIssue_SubType.SelectedItem.Text;
                    objMdlReq.Issue_Type_id = ddlIssue_SubType.SelectedValue;
                    objMdlReq.Priority = txtPriority.Text;
                    objMdlReq.due_Date = lblWFMDate.Text;
                    objMdlReq.Ticket_id = Session["RequestID"].ToString();
                    objMdlReq.Status = DDLWFMAction.SelectedValue;
                    objMdlReq.Reply_Comment = TxtWFMRejectedComment.Text;
                    objMdlReq.Resolve_Comment = txtResolved_Id.Text;
                    objMdlReq.Notes = txtMailContent.Text;
 
                    string ogFileName = "", nFileName = "", nDirectory = "", nFullPath = "";
                    if (FileUpload_Attachment.HasFile)
                    {
                        ogFileName = System.IO.Path.GetFileName(FileUpload_Attachment.FileName).Replace(",", "");
                        nDirectory = Server.MapPath("../UploadFiles/");
                        if (!System.IO.Directory.Exists(nDirectory))
                            System.IO.Directory.CreateDirectory(nDirectory);
                       // string strRandon = System.IO.Path.GetFileNameWithoutExtension(System.IO.Path.GetRandomFileName().ToUpper()) + "_" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
                        nFileName = System.IO.Path.GetFileNameWithoutExtension(ogFileName).ToString() + "_" +Session["RequestID"].ToString()+ "_Ticket" + "_" + DateTime.Now.ToString("yyyyMMddHHmmssfff")+ System.IO.Path.GetExtension(ogFileName);
                        nFullPath = nDirectory + nFileName;
                        FileUpload_Attachment.SaveAs(nFullPath);
                        nFileName = "UploadFiles/" + nFileName;
                        objMdlReq.File_Attachment_Path = nFileName;
                    }

                    Int32 iRetVal = objCtrlReq.InsertRequestorDetails_WFM(objMdlReq);
                    if (iRetVal > 0)
                    {
                        string From = Convert.ToString(System.Configuration.ConfigurationManager.AppSettings["EmailFrom"]);
                        string To = Convert.ToString(UsrCtrlRequestDetail.RequestorEmailID);
                        string Bcc = Convert.ToString(System.Configuration.ConfigurationManager.AppSettings["EmailBcc"]);
                        string MailSubject = "RE:" + Convert.ToString(UsrCtrlRequestDetail.EmailSubject);
                        string MailBody = txtMailContent.Text;
                        if (FileUpload_Attachment.HasFile)
                        {
                            Utility.SendEmail(From, Convert.ToString(UsrCtrlRequestDetail.RequestorEmailID), "", Bcc, MailSubject, MailBody, nFullPath);
                        }
                        else
                        {
                            Utility.SendEmail(From, Convert.ToString(UsrCtrlRequestDetail.RequestorEmailID), "", Bcc, MailSubject, MailBody);
                        }
                        Utility.MessageBox("Request Saved Successfully.","ViewTicketRequestorData.aspx");
                    }
                    else
                        Utility.MessageBox("Fail To Save Request.");

                }
                catch (Exception ex) {
                    Utility.CreateErrorLog(ex.Message.ToString(), "TicketDetails.aspx", "btnSaveWFMRequestorData_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
                }
            }
        }
        #endregion  

    

        protected void ddlWFMExistingClient_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (ddlWFMExistingClient.SelectedValue == "No")
            //{
            //    DrpDwnAccountName.Visible = false;
            //    RFDrpDwnAccountName.Enabled = false;

            //    TxtWFMAccountName.Visible = true;
            //    RFTxtWFMAccountName.Enabled = true;
            //}
            //else
            //{
            //    DrpDwnAccountName.Visible = true;
            //    RFDrpDwnAccountName.Enabled = true;

            //    TxtWFMAccountName.Visible = false;
            //    RFTxtWFMAccountName.Enabled = false;
            //}
        }

        protected void DDLWFMAction_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDLWFMAction.SelectedItem.Text.Trim() == "Reply")
            {               
               // divWFMRejected.Attributes.Add("style", "display: block;");
                RFTxtWFMRejectedComment.Enabled = true;
              //  pnlRejectEnable.Enabled = false;
                divWFMRejected.Visible = true;
            }
            else
            {
                divWFMRejected.Visible = false;
               // divWFMRejected.Attributes.Add("style", "display: none;");
                RFTxtWFMRejectedComment.Enabled = false;
             //   pnlRejectEnable.Enabled = true;
            }

            if (DDLWFMAction.SelectedItem.Text.Trim() == "Resolved")
            {
              //  divResolved.Attributes.Add("style", "display: block;");
                RequiredFieldValidator2.Enabled = true;
                //  pnlRejectEnable.Enabled = false;
                divResolved.Visible = true;
            }
            else
            {
               // divResolved.Attributes.Add("style", "display: none;");
                RequiredFieldValidator2.Enabled = false;
                //   pnlRejectEnable.Enabled = true;
                divResolved.Visible = false;
            }
        }
    }

}