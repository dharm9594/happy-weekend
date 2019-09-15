using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Runtime.InteropServices;
using System.Data;
using System.Web.Security;
using ServiceDesk.model;
using ServiceDesk.controller;
using System.DirectoryServices.ActiveDirectory;
using System.DirectoryServices.Protocols;
using System.DirectoryServices.AccountManagement;

namespace ServiceTracker.view
{
    public partial class Login : System.Web.UI.Page
    {
        ControllerLogin objControllerLogin = null;

        [DllImport("ADVAPI32.dll", EntryPoint = "LogonUserW", SetLastError = true, CharSet = CharSet.Auto)]
        public static extern bool LogonUser(string lpszUsername, string lpszDomain, string lpszPassword, int dwLogonType, int dwLogonProvider, ref IntPtr phToken);

        public static string GetUsername(string usernameDomain)
        {
            if (string.IsNullOrEmpty(usernameDomain))
            {
                throw (new ArgumentException("Argument can't be null.", "usernameDomain"));
            }

            if (usernameDomain.Contains("\\"))
            {
                int index = usernameDomain.IndexOf("\\");
                return usernameDomain.Substring(index + 1);
            }
            else if (usernameDomain.Contains("@"))
            {
                int index = usernameDomain.IndexOf("@");
                return usernameDomain.Substring(0, index);
            }
            else
                return usernameDomain;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.Cookies["userid"] != null)
                    TxtUserName.Value = Request.Cookies["userid"].Value;
                if (Request.Cookies["pwd"] != null)
                    TxtPassword.Value = Request.Cookies["pwd"].Value;
            }

            if (Request.QueryString["logout"] == "true")
                ShowDivAlert("You have been successfully logged out!");
            else if (Request.QueryString["logout"] == "false")
                ShowDivAlert("Session expired. kindly login again.");
        }

        private bool Get_User_Detail(string username)
        {
            objControllerLogin = new ControllerLogin();
            return objControllerLogin.GetUserDetails(username);
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string domainName = DDL_Domain.SelectedValue;
                string userName = GetUsername(TxtUserName.Value);
                IntPtr token = IntPtr.Zero;
                bool bLogonUser;
                objControllerLogin = new ControllerLogin();
                DataTable dtAcccess = objControllerLogin.GetAccess(domainName, userName);
                if (dtAcccess.Rows.Count > 0)
                    bLogonUser = true;
                else
                    bLogonUser = LogonUser(userName, domainName, TxtPassword.Value.ToString(), 2, 0, ref token);
                bool bGetUserDetail = Get_User_Detail(userName);
               // bool bLogonUser = LogonUser(userName, domainName, TxtPassword.Value, 2, 0, ref token);
                if (bLogonUser)
                {
                    HttpContext.Current.Session["UserName"] = userName;
                    HttpContext.Current.Session["DomainName"] = domainName;


                    if (bGetUserDetail)
                    {


                        if (string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                        {
                            Response.Cookies["userid"].Expires = DateTime.Now.AddDays(-1);
                            Response.Cookies["pwd"].Expires = DateTime.Now.AddDays(-1);
                            FormsAuthentication.RedirectFromLoginPage(TxtUserName.Value, false);
                            InsertLoginLog();
                            Response.Redirect("DashboardNew.aspx");
                        }
                        else
                        {
                            FormsAuthentication.SetAuthCookie(TxtUserName.Value, false);
                            Response.Redirect("Login.aspx");
                        }
                    }
                    else
                    {
                        ShowDivAlert("You dont have Access. Contact to Administrator");
                    }
                }
                else
                {
                    ShowDivAlert("Invalid username or password.");
                }
            }
            catch (Exception Ex) { ShowDivAlert("Invalid username or password."); }
        }

        private void InsertLoginLog()
        {
            objControllerLogin = new ControllerLogin();

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
                    userName = Convert.ToString(Session["UserName"]);
                }
            }

            objControllerLogin.InsertLoginLog(Convert.ToString(Session["NTID"]), Convert.ToString(Session["DomainName"]), Convert.ToString(userName));
        }

        private void ShowDivAlert(string Msg)
        {
            DivAlert.Style.Add("display", "block");
            DivAlert.InnerHtml = Convert.ToString(Msg);
        }
    }
}