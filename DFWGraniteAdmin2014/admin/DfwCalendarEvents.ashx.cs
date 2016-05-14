using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.OleDb;

namespace DFWGraniteAdmin2014.admin
{
    /// <summary>
    /// Summary description for DfwCalendarEvents
    /// </summary>
    public class DfwCalendarEvents : IHttpHandler
    {
        //string accdbConnection = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\\DFWwebsiteDB.accdb;Persist Security Info=True";
        string accdbConnection = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + HttpContext.Current.Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";

        public void ProcessRequest(HttpContext context)
        {
            var jsonSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            //var jsonString = String.Empty;

            //context.Request.InputStream.Position = 0;
            //using (var inputStream = new System.IO.StreamReader(context.Request.InputStream))
            //{
            //    jsonString = inputStream.ReadToEnd();
            //}

            //var emplList = jsonSerializer.Deserialize<List<Employee>>(jsonString);
            List<InstallEvent> dfwInstallEvents = getInstallEvents(DateTime.Parse(context.Request["start"]),DateTime.Parse(context.Request["end"]));


            context.Response.ContentType = "application/json";
            context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            context.Response.AppendHeader("Access-Control-Allow-Origin", "*");
            context.Response.Write(jsonSerializer.Serialize(dfwInstallEvents));
        }

        public class InstallEvent
        {
            public int id { get; set; }
            public string title { get; set; }
            //public string Address { get; set; }
            //public string City { get; set; }
            //public string State { get; set; }
            //public string ZipCode { get; set; }
            //public string Edge { get; set; }
            public string start { get; set; }
            public string end { get; set; }
            public string intallsched { get; set; }
            public string location { get; set; }
            public string edge { get; set; }
            public string slabs { get; set; }
            public string sinks { get; set; }
            public string notes { get; set; }
            public string color { get; set; }
            //public string url { get; set; }
        }

        public List<InstallEvent> getInstallEvents(DateTime startDate, DateTime endDate)
        {
            List<InstallEvent> installEvents = new List<InstallEvent>();

            string query = "SELECT OnlineQuoteID, CustomerFirstName, CustomerLastName, Address, City, State, ZipCode, InstallDate, InstallTime, Edge, Notes, StatusID FROM tblOnlineQuotes WHERE   (((tblOnlineQuotes.InstallDate) Is Not Null And (tblOnlineQuotes.InstallDate) Between #" + startDate.ToString("yyyy-MM-dd") + "# And #" + endDate.ToString("yyyy-MM-dd") + "#) AND ((tblOnlineQuotes.StatusID)=6 Or (tblOnlineQuotes.StatusID)=7 Or (tblOnlineQuotes.StatusID)=8)) ";

            using (OleDbConnection conn = new OleDbConnection(accdbConnection))
            {
                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    conn.Open();
                    OleDbDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        InstallEvent insEv = new InstallEvent();
                        insEv.id = reader.GetInt32(0);
                        insEv.title = reader.GetString(1) + " " + reader.GetString(2) + " Install";
                        insEv.start = Convert.ToDateTime(reader.GetValue(7)).ToString("yyyy-MM-dd");
                        insEv.end = insEv.start;
                        insEv.location = reader.GetValue(3).ToString() + ", " + reader.GetValue(4).ToString() + ", " + reader.GetValue(5).ToString() + " " + reader.GetValue(6).ToString();
                        insEv.intallsched = Convert.ToDateTime(reader.GetValue(7)).ToString("D") + " " + reader.GetValue(8).ToString();
                        insEv.edge = reader.GetValue(9).ToString();
                        if (!String.IsNullOrEmpty(insEv.edge))
                        {
                            try { insEv.edge = getInstallEdge(insEv.edge); }
                            catch (Exception ex) { insEv.edge = "?"; }
                        }
                        insEv.slabs = getInstallSlabs(insEv.id);
                        insEv.sinks = getInstallSinks(insEv.id);
                        insEv.notes = reader.GetValue(10).ToString();
                        switch(reader.GetValue(11).ToString())
                        {
                            case "7": insEv.color = "#FFAD33";
                                break;
                            case "8": insEv.color = "#33AD5C";
                                break;
                        }
                        installEvents.Add(insEv);
                    }
                    //conn.Close();
                }
            }

            return installEvents;
        }

        private string getInstallSlabs(int OnlineQuoteID)
        {
            string query = "SELECT SlabColorName AS SLABNAME, str(SF) + 'sf ) ' AS SFVAL FROM SummaryStoneQry WHERE OnlineQuoteID = " + OnlineQuoteID;
            string strSlabs = String.Empty;

            using (OleDbConnection conn = new OleDbConnection(accdbConnection))
            {
                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    conn.Open();
                    OleDbDataReader reader = cmd.ExecuteReader();

                    int c = 1;
                    while (reader.Read())
                    {
                        if (c > 1)
                            strSlabs += "<br />(" + reader.GetValue(1).ToString() + reader.GetValue(0).ToString();
                        else
                            strSlabs += "(" + reader.GetValue(1).ToString() + reader.GetValue(0).ToString();
                        c++;
                    }
                    //conn.Close();
                }
            }

            return strSlabs;
        }

        private string getInstallSinks(int OnlineQuoteID)
        {
            string query = "SELECT SinkName, Quantity FROM SummarySinksQry WHERE OnlineQuoteID = " + OnlineQuoteID;
            string strSinks = String.Empty;

            using (OleDbConnection conn = new OleDbConnection(accdbConnection))
            {
                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    conn.Open();
                    OleDbDataReader reader = cmd.ExecuteReader();

                    int c = 1;
                    while (reader.Read())
                    {
                        if (c > 1)
                            strSinks += "<br />( " + reader.GetValue(1).ToString() + " ) " + reader.GetValue(0).ToString();
                        else
                            strSinks += "( " + reader.GetValue(1).ToString() + " ) " + reader.GetValue(0).ToString();
                        c++;
                    }
                    //conn.Close();
                }
            }

            return strSinks;
        }

        private string getInstallEdge(string EdgeID)
        {
            string query = "SELECT EdgeName FROM tblEdges WHERE EdgeID = " + EdgeID;
            string strEdge = String.Empty;

            using (OleDbConnection conn = new OleDbConnection(accdbConnection))
            {
                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    conn.Open();
                    strEdge = cmd.ExecuteScalar().ToString();
                    //conn.Close();
                }
            }

            return strEdge;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}