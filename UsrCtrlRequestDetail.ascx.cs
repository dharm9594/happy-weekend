using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServiceDesk.model;
using ServiceDesk.controller;
using System.Data;

namespace ServiceDesk.view
{
    public partial class UsrCtrlRequestDetail : System.Web.UI.UserControl
    {
        string _RequestID = "";

        public string Requestor
        {
            get { return txtRequestor.Text; }
            set { txtRequestor.Text = value; }
        }

        public string EmailSubject
        {
            get { return LblCountryCode.Text; }
            set { LblCountryCode.Text = value; }
        }

        public string Email_Body
        {
            get { return EmailBody.InnerText; }
            set { EmailBody.InnerText = value; }
        }
        public string RequestorEmailID
        {
            get { return txtRequestorEmail.Text; }
            set { txtRequestorEmail.Text = value; }
        }

        public string RequestID
        {
            get { return _RequestID; }
            set { _RequestID = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
          //  scriptManager.RegisterPostBackControl(this.LnkRequestorUpld);
        }

        public void BindRequestorDetails(Int32 iRequestID, DataTable DT)
        {
            try
            {
                //RequestID = Convert.ToString(DT.Rows[0]["ID"]);
                lblDate.Text = Convert.ToString(DT.Rows[0]["RequestDate"]);
                txtRequestor.Text = Convert.ToString(DT.Rows[0]["RequestorName"]);
                txtRequestorEmail.Text = Convert.ToString(DT.Rows[0]["RequestorEmailAddress"]);
                LblCountryCode.Text = Convert.ToString(DT.Rows[0]["EmailSubject"]);
                EmailBody.InnerHtml = Convert.ToString(DT.Rows[0]["EmailBody"]);
            }
            catch (Exception ex) {
                Utility.CreateErrorLog(ex.Message.ToString(), "UsrCtrlRequestDetail.ascx", "BindRequestorDetails", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
        }

        protected void LnkRequestorUpld_Click(object sender, EventArgs e)
        {
            //if (LnkRequestorUpld.Text != "")
            //{
            //    //string path = Server.MapPath(LnkRequestorUpld.Text).Replace("view", "RequestorDocs");
            //    string path = "H:\\ServiceDesk\\RequestorDocs\\" + Convert.ToString(LnkRequestorUpld.Text).Trim();

            //    if (System.IO.File.Exists(path))
            //    {
            //        byte[] bts = System.IO.File.ReadAllBytes(path);
            //        Response.Clear(); Response.ClearHeaders();
            //        Response.AddHeader("Content-Type", "Application/octet-stream");
            //        Response.AddHeader("Content-Length", bts.Length.ToString());
            //        Response.AddHeader("Content-Disposition", "attachment; filename=" + LnkRequestorUpld.Text);
            //        Response.BinaryWrite(bts); Response.Flush(); Response.End();
            //    }
            //    else
            //    {
            //        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "LinkClick", "alert('File does not exist');", true);
            //    }
            //}
        }
    }
}