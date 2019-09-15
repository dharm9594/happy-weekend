using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Text.RegularExpressions;
using System.Text;
using System.Xml;
using ClosedXML.Excel;
using ServiceDesk.model;

namespace ServiceDesk.view.API
{
    public partial class ConvertJsonToCsv : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string script = "$(document).ready(function () { $('[id*=JsonToCSV]').click(); });";
                ClientScript.RegisterStartupScript(this.GetType(), "load", script, true);
            }
        }

        protected void JsonToCSV_Click(object sender, EventArgs e)
        {
            if (Page.IsValid == true)
            {
                try
                {
                    string JsonData = txtJson.Text;
                    DataTable ds = jsonStringToTable(JsonData);
                    using (XLWorkbook wb = new XLWorkbook())
                    {
                        wb.Worksheets.Add(ds);
                        wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                        wb.Style.Font.Bold = true;
                        Response.Clear();
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment;filename= JsonToExport.xlsx");
                        using (MemoryStream MyMemoryStream = new MemoryStream())
                        {
                            wb.SaveAs(MyMemoryStream);
                            MyMemoryStream.WriteTo(Response.OutputStream);
                            Response.Flush();
                            Response.End();
                        }
                    }
                }
                catch (Exception ex)
                {
                    Utility.CreateErrorLog(ex.Message.ToString(), "ConvertJsonToCsv.aspx", "JsonToCSV_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);

                }
                finally
                { 
                }
            }
        }

        public static DataTable jsonStringToTable(string jsonContent)
        {
            try
            {
                XmlNode xml = JsonConvert.DeserializeXmlNode("{records:{record:" + jsonContent + "}}");
                XmlDocument xmldoc = new XmlDocument();
                xmldoc.LoadXml(xml.InnerXml);
                XmlReader xmlReader = new XmlNodeReader(xml);
                DataSet dataSet = new DataSet();
                dataSet.ReadXml(xmlReader);


                var dt1 = dataSet.Tables[0];
                var dt2 = dataSet.Tables[1];
                var dt3 = dataSet.Tables[2];
                DataTable finaldt = dt1.Clone();
                finaldt.Columns.Add(new DataColumn("Rolelist", typeof(string)));
                for (int i = 0; i < dt1.Rows.Count; i++)
                {

                    string Table_id = Convert.ToString(dt1.Rows[i]["Record_id"]);
                    string RoleList = string.Empty;
                    var row = dt1.Rows[i];
                    finaldt.ImportRow(row);

                    DataRow[] dr1; dr1 = dt3.Select("Record_id=" + Table_id + "");
                    foreach (DataRow dd in dr1)
                    {
                        if (Table_id == dd["Record_id"].ToString())
                        {
                            RoleList += dd["RoleList_Text"].ToString() + ",";
                        }
                    }

                    DataRow dr = finaldt.Select("Record_id=" + Table_id + "").FirstOrDefault();
                    if (dr != null)
                    {
                        dr["Rolelist"] = RoleList;
                    }
                }
                return finaldt;
            }
            catch (Exception ex)
            {
                DataTable dtdd = new DataTable();
                Utility.CreateErrorLog(ex.Message.ToString(), "ConvertJsonToCsv.aspx", "JsonToCSV_Click", "", "", HttpContext.Current.Session["NTID"].ToString() + " / " + HttpContext.Current.Session["DomainName"].ToString() + " / " + HttpContext.Current.Session["LawsonID"], ex);
                return dtdd;
            }
            finally
            { }
        }

        protected void Clear_Click(object sender, EventArgs e)
        {
            Response.Redirect("ConvertJsonToCsv.aspx");
        }
    }
}
