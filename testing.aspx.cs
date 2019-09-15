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
using System.Configuration;
using DocumentFormat.OpenXml;
using ServiceDesk.model;

namespace ServiceDesk.view
{
    public partial class testing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           /// ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "LoadWaiverModalPopup();", true);
          //  Utility.MessageWithCopyToClipboard("Password Reset SuccessFully. Default password is : 444 for tenant : 4444", "ghgfh");
        }
        protected void JsonToCSV_Click(object sender, EventArgs e)
        {
            if (Page.IsValid == true)
            {
                try
                {
                    string JsonData = txtJson.Text;
                    DataTable dt = jsonStringToTable(JsonData);
                    //////////////////////////using (XLWorkbook wb = new XLWorkbook())
                    //////////////////////////{
                    //////////////////////////    wb.Worksheets.Add(dt);
                    //////////////////////////    wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                    //////////////////////////    wb.Style.Font.Bold = true;
                    //////////////////////////    Response.Clear();
                    //////////////////////////    Response.Buffer = true;
                    //////////////////////////    Response.Charset = "";
                    //////////////////////////    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    //////////////////////////    Response.AddHeader("content-disposition", "attachment;filename= JsonToExport.xlsx");
                    //////////////////////////    using (MemoryStream MyMemoryStream = new MemoryStream())
                    //////////////////////////    {
                    //////////////////////////        wb.SaveAs(MyMemoryStream);
                    //////////////////////////        MyMemoryStream.WriteTo(Response.OutputStream);
                    //////////////////////////        Response.Flush();
                    //////////////////////////        Response.End();
                    //////////////////////////    }
                    //////////////////////////}
                    string csv = string.Empty;

                    foreach (DataColumn column in dt.Columns)
                    {
                        //Add the Header row for CSV file.
                        csv += column.ColumnName + ',';
                    }

                    //Add new line.
                    csv += "\r\n";

                    foreach (DataRow row in dt.Rows)
                    {
                        foreach (DataColumn column in dt.Columns)
                        {
                            //Add the Data rows.
                            csv += row[column.ColumnName].ToString().Replace(",", ";") + ',';
                        }

                        //Add new line.
                        csv += "\r\n";
                    }
                    Response.Clear();
                    Response.Buffer = true;
                    Response.AddHeader("content-disposition", "attachment;filename=JsconToCSV.csv");
                    Response.Charset = "";
                    Response.ContentType = "application/text";
                    Response.Output.Write(csv);
                    Response.Flush();
                    Response.End();



                    //StringBuilder sb = new StringBuilder();
                    //IEnumerable<string> columnNames = dt.Columns.Cast<DataColumn>().
                    //                                  Select(column => column.ColumnName);
                    //sb.AppendLine(string.Join(",", columnNames));
                    //foreach (DataRow row in dt.Rows)
                    //{
                    //    IEnumerable<string> fields = row.ItemArray.Select(field =>
                    //      string.Concat("\"", field.ToString().Replace("\"", "\"\""), "\""));
                    //    sb.AppendLine(string.Join(",", fields));
                    //}
                    //Response.Clear();
                    //Response.Buffer = true;
                    //Response.AddHeader("content-disposition", "attachment;filename=JsconToCSV.csv");
                    //Response.Charset = "";
                    //Response.ContentType = "application/text";
                    //Response.Output.Write(sb);
                    //Response.Flush();
                    //Response.End();
                }
                catch (Exception Ex) { }
            }
        }

        public static DataTable jsonStringToTable(string jsonContent)
        {
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(jsonContent);
            return dt;
            return JsonConvert.DeserializeObject<DataTable>(jsonContent.ToString());
            var jsonLinq = JObject.Parse(jsonContent);
            var linqArray = jsonLinq.Descendants().Where(x => x is JArray).First();
            var jsonArray = new JArray();
            foreach (JObject row in linqArray.Children<JObject>())
            {
                var createRow = new JObject();
                foreach (JProperty column in row.Properties())
                {
                    // Only include JValue types
                    if (column.Value is JValue)
                    {
                        createRow.Add(column.Name, column.Value);
                    }
                }
                jsonArray.Add(createRow);
            }

            //return JsonConvert.DeserializeObject<DataTable>(jsonArray.ToString());
            //////// JArray jsonArray = JArray.Parse("[" + jsonContent.Trim() + "]");
            //var jsonLinq = JObject.Parse(jsonContent);

            //// Find the first array using Linq
            //var srcArray = jsonLinq.Descendants().Where(d => d is JArray).First();
            //var trgArray = new JArray();
            //foreach (JObject row in srcArray.Children<JObject>())
            //{
            //    var cleanRow = new JObject();
            //    foreach (JProperty column in row.Properties())
            //    {
            //        // Only include JValue types
            //        if (column.Value is JValue)
            //        {
            //            cleanRow.Add(column.Name, column.Value);
            //        }
            //    }
            //    trgArray.Add(cleanRow);
            //}

            //return JsonConvert.DeserializeObject<DataTable>(trgArray.ToString());

            //////////DataTable dtUsingMethodReturn = new DataTable();
            //////////string[] jsonStringArray = Regex.Split(jsonContent.Replace("[", "").Replace("]", ""), "},{");
            //////////List<string> ColumnsName = new List<string>();
            //////////foreach (string strJSONarr in jsonStringArray)
            //////////{
            //////////    string[] jsonStringData = Regex.Split(strJSONarr.Replace("{", "").Replace("}", ""), ",");
            //////////    foreach (string ColumnsNameData in jsonStringData)
            //////////    {
            //////////        try
            //////////        {
            //////////            int idx = ColumnsNameData.IndexOf(":");
            //////////            string ColumnsNameString = ColumnsNameData.Substring(0, idx).Replace("\"", "").Trim();
            //////////            if (!ColumnsName.Contains(ColumnsNameString))
            //////////            {
            //////////                ColumnsName.Add(ColumnsNameString);
            //////////            }
            //////////        }
            //////////        catch (Exception ex)
            //////////        {
            //////////            throw new Exception(string.Format("Error Parsing Column Name : {0}", ColumnsNameData));
            //////////        }
            //////////    }
            //////////    break;
            //////////}
            //////////foreach (string AddColumnName in ColumnsName)
            //////////{
            //////////    dtUsingMethodReturn.Columns.Add(AddColumnName);
            //////////}
            //////////foreach (string strJSONarr in jsonStringArray)
            //////////{
            //////////    string[] RowData = Regex.Split(strJSONarr.Replace("{", "").Replace("}", ""), ",");
            //////////    DataRow nr = dtUsingMethodReturn.NewRow();
            //////////    foreach (string rowData in RowData)
            //////////    {
            //////////        try
            //////////        {
            //////////            int idx = rowData.IndexOf(":");
            //////////            string RowColumns = rowData.Substring(0, idx).Replace("\"", "").Trim();
            //////////            string RowDataString = rowData.Substring(idx + 1).Replace("\"", "").Trim();
            //////////            nr[RowColumns] = RowDataString;
            //////////        }
            //////////        catch (Exception ex)
            //////////        {
            //////////            continue;
            //////////        }
            //////////    }
            //////////    dtUsingMethodReturn.Rows.Add(nr);
            //////////}
            //////////return dtUsingMethodReturn;
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
           // finaldt.Columns.Add(new DataColumn("Grouplist", typeof(string)));
            finaldt.Columns.Add(new DataColumn("Rolelist", typeof(string)));
            for (int i = 0; i < dt1.Rows.Count; i++)
            {

                string Table_id = Convert.ToString(dt1.Rows[i]["Record_id"]);
               // string GroupList = string.Empty;
                string RoleList = string.Empty;
                var row = dt1.Rows[i];
                finaldt.ImportRow(row);
                //for (int j = 0; j < dt2.Rows.Count; j++)
                //{
                //    //string table_dupled_id = Convert.ToString(dt2.Rows[j]["Record_id"]);
                //    //if (Table_id == table_dupled_id)
                //    //{
                //    //   // GroupList = Convert.ToString(dt2.Rows[j]["GroupList_Text"]);
                //    //    //  string test = 
                //    //    //  string test2 = test;
                //    //    GroupList = GroupList + dt2.Rows[j]["GroupList_Text"].ToString();
                //    //    GroupList += (j < dt2.Rows.Count) ? ";" : string.Empty;
                //    //}
                //}
                DataRow[] dr1; dr1 = dt3.Select("Record_id=" + Table_id + ""); 
                foreach( DataRow dd in dr1)
                {
                    if (Table_id == dd["Record_id"].ToString())
                {
                     RoleList += dd["RoleList_Text"].ToString() + ",";
                }
                }
                ////////////for (int k = 0; k < dr1.Length; k++)
                ////////////{
                ////////////    //string table_dupled_id = Convert.ToString(dt3.Rows[k]["Record_id"]);
                ////////////    if (Table_id == dr1[].ToString())
                ////////////    {
                ////////////       // RoleList = Convert.ToString(dt3.Rows[k]["RoleList"]);
                ////////////        RoleList = RoleList + dt3.Rows[k]["RoleList_Text"].ToString();
                ////////////        RoleList += (k < dt3.Rows.Count) ? ";" : string.Empty;
                ////////////    }
                ////////////}
                DataRow dr = finaldt.Select("Record_id=" + Table_id + "").FirstOrDefault(); 
                if (dr != null)
                {
                   // dr["Grouplist"] = GroupList;
                    dr["Rolelist"] = RoleList;
                }

            }
            //   var dtMerged = MergeTablesByIndex(dt1, dt2);
            // return dtMerged;
           // return dataSet;
            return finaldt;
            //return dataTable;
            ////Datatable to CSV
            //var lines = new List<string>();
            //string[] columnNames = dataTable.Columns.Cast<DataColumn>().
            //                                  Select(column => column.ColumnName).
            //                                  ToArray();
            //var header = string.Join(",", columnNames);
            //lines.Add(header);
            //var valueLines = dataTable.AsEnumerable()
            //                   .Select(row => string.Join(",", row.ItemArray));
            //lines.AddRange(valueLines);
            //File.WriteAllLines(@"D:/Export.csv", lines);

        }

        public static DataTable MergeTablesByIndex(DataTable t1, DataTable t2)
        {
            if (t1 == null || t2 == null) throw new ArgumentNullException("t1 or t2", "Both tables must not be null");

            DataTable t3 = t1.Clone();  // first add columns from table1
            foreach (DataColumn col in t2.Columns)
            {
                string newColumnName = col.ColumnName;
                int colNum = 1;
                while (t3.Columns.Contains(newColumnName))
                {
                    newColumnName = string.Format("{0}_{1}", col.ColumnName, ++colNum);
                }
                t3.Columns.Add(newColumnName, col.DataType);
            }
            var mergedRows = t1.AsEnumerable().Zip(t2.AsEnumerable(),
                (r1, r2) => r1.ItemArray.Concat(r2.ItemArray).ToArray());
            foreach (object[] rowFields in mergedRows)
                t3.Rows.Add(rowFields);

            return t3;
        }


        protected void test(object sender, EventArgs e)
        {
           // ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "myFunction();", false);
        }
    }
}