using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServiceDesk.controller;
using ServiceDesk.model;
using System.Data;
using System.Data.SqlClient;
using System.DirectoryServices.ActiveDirectory;
using System.DirectoryServices.Protocols;
using System.DirectoryServices.AccountManagement;

namespace ServiceDesk.view
{
    public partial class Main : System.Web.UI.MasterPage
    {
        public ClsHeaderNSubMenus HeaderAndSubMenu = new ClsHeaderNSubMenus();

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpContext.Current.Response.Cache.SetAllowResponseInBrowserHistory(false);
            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            HttpContext.Current.Response.Cache.SetNoStore();
            HttpContext.Current.Response.Cache.SetExpires(DateTime.Now);
            HttpContext.Current.Response.Cache.SetValidUntilExpires(true);

            string roll = Convert.ToString(Session["RollID"]);
            if (roll == "1" || roll == "1,")
            {
                Completed_Report.Visible = true;
                //WFM_Completed_Report.Visible = false;
                //VP_Completed_Report.Visible = false;
                //GM_Completed_Report.Visible = false;
            }

            if (string.IsNullOrEmpty(Convert.ToString(Session["UserName"])))
            {
                Response.Redirect("Login.aspx");
            }



            string userName = string.Empty;
            using (PrincipalContext pc = new PrincipalContext(ContextType.Domain, Convert.ToString(Session["DomainName"])))
            {
                UserPrincipal user = new UserPrincipal(pc);
                user = UserPrincipal.FindByIdentity(pc, Convert.ToString(Session["UserName"]));
                if (user != null)
                {
                    userName = user.GivenName + " " + user.Surname;

                }
                else
                {
                    //return string.Empty;
                    userName = Convert.ToString(Session["UserName"]);
                }
            }

            LblUserName.Text = userName;

            if (!IsPostBack)
            {
                if (Convert.ToString(Session["FullName"]) != "")
                {
                    LblUserName.Text = Convert.ToString(Session["FullName"]);

                }
                GetMenuData();
                CheckUserAcess();
                FunCheckMenuRights();
            }
        }

        private void FunCheckMenuRights()
        {
            List<Control> LstControl = new List<Control>();
            LstControl.Add(StratigicSites_Master);
            LstControl.Add(AddUser);
            LstControl.Add(StratigicPartner_master);
            LstControl.Add(EmailIDStrategicPartnerMaster);
            LstControl.Add(IssueMaster);
            LstControl.Add(ViewTicketRequestorData);
            LstControl.Add(ViewTicketResolveData);
            LstControl.Add(Mapping_MasterUser);
            LstControl.Add(ConvertJsonToCsv);
            LstControl.Add(Mapping_MasterReport);
            LstControl.Add(Self_PassReport);
            LstControl.Add(_Links);
            for (int i = 0; i < HeaderAndSubMenu.LstOfSubMenus.Count; i++)
            {
                for (int c = 0; c < LstControl.Count; c++)
                {
                    if (HeaderAndSubMenu.LstOfSubMenus[i].Url.Contains("$" + LstControl[c].ID + ".aspx"))
                    {
                        LstControl[c].Visible = true;
                    }
                    
                }
            }
        }

        private void CheckUserAcess()
        {
            string roll = Session["RollID"].ToString();
            string pageName = this.Page.ToString().Substring(9, this.Page.ToString().Substring(9).Length - 5) + ".aspx";
            string strCon = System.Configuration.ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            SqlConnection con = new SqlConnection(strCon);
            SqlCommand Cmd = new SqlCommand();
            Cmd.Connection = con;
            Cmd.Parameters.Clear();
            Cmd.Parameters.Add("@PageName", SqlDbType.VarChar, 1000).Value = pageName;
            Cmd.Parameters.Add("@RollID", SqlDbType.VarChar, 1000).Value = roll;
            Cmd.CommandType = CommandType.StoredProcedure;
            Cmd.CommandText = "Page_Authentication";
            con.Open();
            int IsAceessable = Convert.ToInt16(Cmd.ExecuteScalar());
            if (IsAceessable == 0)
            {
                Response.Redirect(Request.UrlReferrer.ToString());
                Utility.MessageBox("You are not authorize to view this page!", Request.UrlReferrer.ToString());
            }
        }
        private void GetMenuData()
        {
            string roll = Session["RollID"].ToString();
            string[] a = roll.Split(',');
            string subquery = "";
            for (int i = 0; i < a.Length; i++)
            {
                if (a[i].ToString().Trim() != "")
                {
                    subquery = subquery + "Or (Assigned_roll like '%," + a[i] + ",%' or Assigned_roll like '" + a[i] + ",%' or Assigned_roll like '" + a[i] + "%'  or Assigned_roll like '%," + a[i] + "' )";
                }
            }
            DataTable table = new DataTable();
            string strCon = System.Configuration.ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            SqlConnection conn = new SqlConnection(strCon);

            string sql = "select menu_id, menu_name, menu_parent_id, menu_url,status from menuMaster where status =1 and IsVisible=1 and ( (menu_parent_id is NULL) " + subquery + ") order by orderby";
            if (!(sql.Contains("update") || sql.Contains("delete")))
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(table);
                DataView view = new DataView(table);
                view.RowFilter = "menu_parent_id is NULL";
                foreach (DataRowView row in view)
                {
                    ClsHeader Header = new ClsHeader();
                    Header.Url = row["menu_url"].ToString().Replace("~/View/", "").Replace("View/", "");
                    Header.Text = row["menu_name"].ToString();
                    HeaderAndSubMenu.LstOfHeader.Add(Header);
                    ClsSubMenus SubMenu = new ClsSubMenus();
                    AddChildItems(table, row["menu_id"].ToString(), SubMenu);
                    HeaderAndSubMenu.LstOfSubMenus.Add(SubMenu);
                }
            }
        }

        private void AddChildItems(DataTable table, string Value, ClsSubMenus SubMenu)
        {
            DataView viewItem = new DataView(table);
            viewItem.RowFilter = "menu_parent_id=" + Value;

            foreach (DataRowView childView in viewItem)
            {
                string value = childView["menu_id"].ToString();
                SubMenu.Url = SubMenu.Url + "$" + childView["menu_url"].ToString().Replace("~/View/", "").Replace("View/", "");
                SubMenu.Text = SubMenu.Text + "$" + childView["menu_name"].ToString();
                AddChildItems(table, value, SubMenu);
            }
        }

        public class ClsHeader
        {
            public string Text = string.Empty;
            public string Url = string.Empty;
        }

        public class ClsSubMenus
        {
            public string Text = string.Empty;
            public string Url = string.Empty;
        }

        public class ClsHeaderNSubMenus
        {
            public List<ClsHeader> LstOfHeader = new List<ClsHeader>();
            public List<ClsSubMenus> LstOfSubMenus = new List<ClsSubMenus>();
        }
    }
}