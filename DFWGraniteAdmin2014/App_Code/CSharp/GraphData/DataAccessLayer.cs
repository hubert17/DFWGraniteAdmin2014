using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;

namespace BusinessManagementPortal.Data
{
    public class DataAccessLayer
    {
        public GraphDataList GetGraphData(string graphName, string dateidFrom, string dateidTo)
        {
            GraphData graphData = null;
            GraphDataList graphDataList = new GraphDataList();
            graphDataList.ListOfGraphData = new List<GraphData>();

            try
            {
                string query5 = "SELECT InstallYear, InstallMonth, MonthYear, TotalSales, TotalGrossProfit FROM tblSalesChart  WHERE (((tblSalesChart.ID)<>(SELECT MAX(ID) FROM tblSalesChart) ";
                if (!String.IsNullOrEmpty(dateidFrom) && !String.IsNullOrEmpty(dateidTo)) query5 += " AND ([ID] Between " + dateidFrom.ToString() + " And " + dateidTo.ToString() + ")))";

                string connect5 = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + HttpContext.Current.Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
                OleDbConnection conn5 = new OleDbConnection(connect5);
                OleDbCommand cmd5 = new OleDbCommand(query5, conn5);
                conn5.Open();
                OleDbDataReader dReader = cmd5.ExecuteReader();

                while (dReader.Read())
                {
                    graphData = new GraphData();

                    //DateTime dt = DateTime.ParseExact(dReader.GetString(2), "yyyy-MM", System.Globalization.CultureInfo.InvariantCulture);
                    //graphData.label = dt.ToString();
                    //graphData.label =Convert.ToString(DateTime.ParseExact((dReader.GetValue(2)).ToString(), "yyyy-MM", System.Globalization.CultureInfo.InvariantCulture));
                    graphData.label = Convert.ToString(dReader.GetValue(2));
                    graphData.value = Convert.ToString(dReader.GetValue(3));
                    graphData.value2 = Convert.ToString(dReader.GetValue(4));
                    graphDataList.ListOfGraphData.Add(graphData);

                }
                dReader.Close();
                conn5.Close();

            }
            catch (Exception ex)
            {
                Logging.LogError(ex);
            }

            return graphDataList;
        }
    }
}