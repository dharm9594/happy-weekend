using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServiceDesk.controller;
using ServiceDesk.model;
using System.Text;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

namespace ServiceDesk.view
{
    public partial class DashboardNew : System.Web.UI.Page
    {
        //ControllerDashboard objCtrl = null;
        string strCon = System.Configuration.ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadBarChartForStatigic_Partner();
            }
        }
        public void LoadBarChartForStatigic_Partner()
        {
            try
            {
                using (SqlConnection SqlCon = new SqlConnection(strCon))
                {
                    SqlCon.Open();
                    SqlCommand SqlCmdBar = new SqlCommand("Get_Chart_Stretigic", SqlCon);
                    SqlCmdBar.CommandType = CommandType.StoredProcedure;
                    // SqlCmdBar.Parameters.Add("@RequestorNTID", SqlDbType.VarChar).Value = Convert.ToString(HttpContext.Current.Session["NTID"]);
                    //  SqlCmdBar.Parameters.Add("@RollID", SqlDbType.VarChar).Value = Convert.ToString(HttpContext.Current.Session["RollID"]);
                    DataSet dsBar = new DataSet();
                    SqlDataAdapter daBar = new SqlDataAdapter(SqlCmdBar);
                    daBar.Fill(dsBar);
                    SqlCon.Close();
                    if (dsBar.Tables[0].Rows.Count > 0)
                    {
                        //ColumnChart.DataSource = dsBar.Tables[0];
                        //ColumnChart.DataBind();
                        //GrdStatusPass.DataSource = dsBar.Tables[0];
                        //GrdStatusPass.DataBind();
                    }
                    if (dsBar.Tables[1].Rows.Count > 0)
                    {
                        grdIssueLevelWise.DataSource = dsBar.Tables[1];
                        grdIssueLevelWise.DataBind();
                        ColumnForIssueWise.DataSource = dsBar.Tables[1];
                        ColumnForIssueWise.DataBind();
                    }
                    if (dsBar.Tables[2].Rows.Count > 0)
                    {
                        lblResolveTicket.InnerText = dsBar.Tables[2].Rows[0]["Resolved"].ToString();
                        lblPendingTicket.InnerText = dsBar.Tables[2].Rows[0]["Pending"].ToString();
                        lblRepliedTicket.InnerText = dsBar.Tables[2].Rows[0]["Replied"].ToString();
                        lblTotalTicket.InnerText = dsBar.Tables[2].Rows[0]["Total"].ToString();
                    }
                    if (dsBar.Tables[3].Rows.Count > 0)
                    {
                        Pie_ChartSLA_Meet.DataSource = dsBar.Tables[3];
                        Pie_ChartSLA_Meet.DataBind();
                        grdPie_ChartSLA_Meet.DataSource = dsBar.Tables[3];
                        grdPie_ChartSLA_Meet.DataBind();
                    }
                    if (dsBar.Tables[4].Rows.Count > 0)
                    {
                        Pie_Chart_Tenant.DataSource = dsBar.Tables[4];
                        Pie_Chart_Tenant.DataBind();
                        grdTenantSelf.DataSource = dsBar.Tables[4];
                        grdTenantSelf.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {

                Utility.CreateErrorLog(ex.Message.ToString(), "DashboardNew.aspx", "LoadBarChartForStatigic_Partner", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
            }
            finally
            { 
            
            }
        }
    }
}