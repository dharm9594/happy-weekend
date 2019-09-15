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
    public partial class TicketResolveDetails : System.Web.UI.Page
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
                DataTable dt = objCtrlReq.GetPassResetDetailsby_Ticketid(Convert.ToInt32(Session["RequestID"].ToString()));
                GrdStatusPass.DataSource = dt;
                GrdStatusPass.DataBind();
            }
        }

        public void BindRequestorDetails(Int32 iRequestID)
        {
            try
            {
                objCtrlReq = new ControllerWFMRequestor();
                DataTable dtRequest = objCtrlReq.GetRequestorDetailsByID_WFM(iRequestID);
                //Request
                UsrCtrlRequestDetail.BindRequestorDetails(iRequestID, dtRequest);
              //Update details
                DataTable DtUpdate = objCtrlReq.GetResolveDetailsByID_WFM(iRequestID);
                if (DtUpdate.Rows.Count > 0)
                {
                    ddlStratigic_Partner.Text = DtUpdate.Rows[0]["Stratigic_Partner"].ToString();
                    ddlIssue_Level.Text = DtUpdate.Rows[0]["Issue_Level"].ToString();
                    ddlIssue_Type.Text = DtUpdate.Rows[0]["Issue_Type"].ToString();
                    ddlIssue_SubType.Text = DtUpdate.Rows[0]["Issue_SubType"].ToString();
                    txtPriority.Text = DtUpdate.Rows[0]["Priority"].ToString();
                  //  txtMailContent.Text = DtUpdate.Rows[0]["Notes"].ToString();
                    if (DtUpdate.Rows[0]["Is_API_Checked"].ToString() == "True")
                    {
                        ShowIframe.Visible = true;
                        //ifarme11.Attributes.Add("src", DtUpdate.Rows[0]["Page_Url"].ToString());
                        iFrameHeader.InnerText = DtUpdate.Rows[0]["Issue_SubType"].ToString() + " API :";
                    }
                    else
                    {
                        ShowIframe.Visible = false;
                    }
                    txtMailContent.Text = DtUpdate.Rows[0]["Notes"].ToString();
                    txtResolved_Id.Text = DtUpdate.Rows[0]["Resolved_Comment"].ToString();
                    DDLWFMAction.SelectedValue = DtUpdate.Rows[0]["Status"].ToString();
                    lblWFMDate.Text = DtUpdate.Rows[0]["UpdateDate"].ToString();
                }
              
                }
            catch (Exception ex) {
                Utility.CreateErrorLog(ex.Message.ToString(), "TicketResolveDetails.aspx", "BindRequestorDetails", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
        }
        #region "Update Requestor Details"
        protected void btnSaveWFMRequestorData_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewTicketResolveData.aspx");
        }
        #endregion  

    }

}