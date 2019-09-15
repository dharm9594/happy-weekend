using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServiceDesk.controller;
using ServiceDesk.model;

namespace ServiceDesk.view
{
    public partial class ViewTicketRequestorData : System.Web.UI.Page
    {
        ControllerViewWFMRequestorData objCtrl = null;
        public Int32 iTotalPage = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindData(1);
            }
        }

        public void BindData(int iPageNbr)
        {
            try
            {
                TxtSearch.Text = "";
                DataSet DS = ViewWFMRequestorDetails(iPageNbr);
                if (Utility.HasRowsDS(DS, 0))
                {
                    GrdWFMRequest.DataSource = DS;
                    GrdWFMRequest.DataBind();
                    Int32 iTotalRecord = Convert.ToInt32(ViewWFMRequestorDetails(Convert.ToInt32(TxtPageNbr.Text)).Tables[0].Rows[0]["TotalCount"]);
                    iTotalPage = (iTotalRecord / 15) + ((iTotalRecord % 15) > 0 ? 1 : 0);
                    LblTotalPage.Text = iTotalPage.ToString();
                }
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "ViewTicketRequestorData.aspx", "BindData", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { }
        }

        public DataSet ViewWFMRequestorDetails(int iPageNbr)
        {
            objCtrl = new ControllerViewWFMRequestorData();
            DataSet DS = objCtrl.ViewWFMRequestorDetails(iPageNbr);
            return DS;
        }

        protected void BtnLoadData_Click(object sender, EventArgs e)
        {
            BindData(Convert.ToInt32(TxtPageNbr.Text));
        }

        protected void GrdWFMRequest_DataBound(object sender, EventArgs e)
        {
            //Required For Header
            if (GrdWFMRequest.Rows.Count > 0)
            {
                GrdWFMRequest.UseAccessibleHeader = true;
                GrdWFMRequest.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void GrdWFMRequest_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Update on Requestor Input
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label LblID = (Label)e.Row.FindControl("LblID");
                //ImageButton ImgBtnEditRequest = (ImageButton)e.Row.FindControl("ImgEditRequest");
                //ImgBtnEditRequest.ImageUrl = "~/images/edit.png";
                //ImgBtnEditRequest.PostBackUrl = "~/view/WFMRequestor.aspx?" + HttpUtility.UrlEncode(Utility.Encrypt(string.Format("RequestID={0}", LblID.Text.ToString())));

                LinkButton LnkEditRequest = (LinkButton)e.Row.FindControl("LnkEditRequest");
                LnkEditRequest.PostBackUrl = "~/view/TicketDetails.aspx?" + HttpUtility.UrlEncode(Utility.Encrypt(string.Format("RequestID={0}", LblID.Text.ToString().Trim())));
            }
        }
    }
}