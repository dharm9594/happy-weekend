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
    public partial class EmailIDStrategicPartnerMaster : System.Web.UI.Page
    {
        ControllerWFMRequestor SSMSBL = new ControllerWFMRequestor();
        ModelWFMRequestor _objmodelwfm = new ModelWFMRequestor();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    Binddropdown();
                    Bindgrid();
                    Hdeditval.Value = "0";
                }
                catch (Exception ex)
                {                   
                    throw ex;
                }
                
            }
        }

        protected void Binddropdown()
        {
            try
            {
                DataTable dt = SSMSBL.Get_StregicPartner();
                if (dt != null && dt.Rows.Count > 0)
                {
                    ddlStrategicPatner.DataSource = dt;
                    ddlStrategicPatner.DataTextField = "Stratigic_Partner_Name";
                    ddlStrategicPatner.DataValueField = "Stratigic_Partner_ID";
                    ddlStrategicPatner.DataBind();
                    ddlStrategicPatner.Items.Insert(0, new ListItem("--Select--", "0"));
                }
            }
            catch (Exception ex)
            {

                Utility.CreateErrorLog(ex.Message.ToString(), "EmailIDStrategicPartnerMaster.aspx", "Binddropdown", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
           
        }

        protected void Bindgrid()
        {
            try
            {
                DataTable dtget = SSMSBL.Get_EmailIDStrategic_PatnerDetails();
                if (dtget != null && dtget.Rows.Count > 0)
                {
                    Grddata.DataSource = dtget;
                    Grddata.DataBind();
                }
                else
                {
                    Grddata.DataSource = null;
                    Grddata.DataBind();
                }
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "EmailIDStrategicPartnerMaster.aspx", "Bindgrid", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);

            }
           
        }

        public void cleartext()
        {
            ddlStrategicPatner.SelectedValue = "0";
            txtStrategicPatner_Emailadd.Text = "";
            Hdeditval.Value = "0";
        }

        protected void btnADD_Click(object sender, EventArgs e)
        {
            try
            {
                _objmodelwfm._StrategicID = ddlStrategicPatner.SelectedValue;
                _objmodelwfm._StrategicPatnerName = ddlStrategicPatner.SelectedItem.Text;
                _objmodelwfm._EmailAddressExtention = txtStrategicPatner_Emailadd.Text;

                int Count = 0;
                if (Hdeditval.Value == "0")
                {
                    Count = SSMSBL.InsertEmailIDStrategicPatnerMaster(_objmodelwfm);
                    if (Count > 0)
                    {
                        Utility.MessageBox("Data Saved Successfully.");
                        Bindgrid();
                    }
                }
                else
                {
                    Count = SSMSBL.Edit_EmailIDStrategic_Patner(Convert.ToInt32(Hdeditval.Value), _objmodelwfm);
                    if (Count > 0)
                    {
                        Utility.MessageBox("Data Updated Successfully.");
                        Bindgrid();
                    }
                }
                cleartext();
            }
            catch (Exception ex)
            {
                throw ex; 
            }      
        }

        protected void Grddata_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Grddata.PageIndex = e.NewPageIndex;
            Bindgrid();
        }

        protected void lnkdelete_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = ((LinkButton)sender).NamingContainer as GridViewRow;
                Label _Lblid = row.FindControl("lblid") as Label;
                SSMSBL.Delete_EmailIDStrategic_Patner(Convert.ToInt32(_Lblid.Text));
                Utility.MessageBox("Record Deleted Successfully.");
                Bindgrid();
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "EmailIDStrategicPartnerMaster.aspx", "lnkdelete_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }          
        }

        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = ((LinkButton)sender).NamingContainer as GridViewRow;
                Label _lblID = row.FindControl("lblid") as Label;
                Hdeditval.Value = _lblID.Text;
                DataTable dt = SSMSBL.BindEditdata(Convert.ToInt32(Hdeditval.Value));
                if (dt != null && dt.Rows.Count > 0)
                {
                    ddlStrategicPatner.SelectedValue = dt.Rows[0]["StrategicPartnerID"].ToString();
                    txtStrategicPatner_Emailadd.Text = dt.Rows[0]["EmailAddressExtention"].ToString();
                }
            }
            catch (Exception ex)
            {
                Utility.CreateErrorLog(ex.Message.ToString(), "EmailIDStrategicPartnerMaster.aspx", "lnkEdit_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { 
            }
            
        }       
    }
}