using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;

namespace DFWGraniteAdmin2014.admin
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //ListView1.Visible = GoogleCalendarManager.GoogleAuthenticate();

            SqlDataSource1.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            SqlDataSource2.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            SqlDataSourceNewQuote.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";

            try
            {
                string myScript = "\n<script type=\"text/javascript\" language=\"Javascript\" id=\"EventScriptBlock\">\n";
                myScript += "var txtBox = document.getElementById('<%= JobSearchTextBox.ClientID %>');";
                myScript += "if (txtBox != null) txtBox.focus();";
                myScript += "\n\n </script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", myScript, false);

            }
            catch (Exception ex)
            { }
        }

        protected void RecentCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            int result = 0;
            if (int.TryParse(JobSearchTextBox.Text, out result))
            {
                if (RecentCheckBox.Checked)
                    SqlDataSource1.SelectCommand = "SELECT TOP 10 OnlineQuoteID, CustomerName, DateCreated, InstallDate, InstallTime, InitiatedBy, SlabColorName   FROM RecentOnlineQuoteQry WHERE (OnlineQuoteID = ?) ORDER BY CustomerName";
                else
                    SqlDataSource1.SelectCommand = "SELECT tblOnlineQuotes.[OnlineQuoteID], CustomerFirstName + ' ' + CustomerLastName AS CustomerName, Email, DateCreated, InstallDate, InstallTime, InitiatedBy, SlabColorsQry.[SlabColorName] FROM ((SlabColorsQry INNER JOIN tblOnlineQuoteStone ON SlabColorsQry.[SlabColorID] = tblOnlineQuoteStone.[SlabColorID]) INNER JOIN tblOnlineQuotes ON tblOnlineQuoteStone.[OnlineQuoteID] = tblOnlineQuotes.[OnlineQuoteID])  WHERE (tblOnlineQuotes.[OnlineQuoteID] = ?) AND (Email IS NOT NULL) ORDER BY CustomerFirstName + ' ' + CustomerLastName";
            }
            else
            {
                if (RecentCheckBox.Checked)
                {
                    if (AdminInitCheckBox.Checked)
                        SqlDataSource1.SelectCommand = "SELECT TOP 10 OnlineQuoteID, CustomerName, DateCreated, InstallDate, InstallTime, InitiatedBy, SlabColorName   FROM RecentOnlineQuoteQry WHERE (CustomerName LIKE '%' + ? + '%') AND (InitiatedBy = 'admin') ORDER BY CustomerName";
                    else
                        SqlDataSource1.SelectCommand = "SELECT TOP 10 OnlineQuoteID, CustomerName, DateCreated, InstallDate, InstallTime, InitiatedBy, SlabColorName   FROM RecentOnlineQuoteQry WHERE (CustomerName LIKE '%' + ? + '%') ORDER BY CustomerName";
                }
                else
                {
                    if (AdminInitCheckBox.Checked)
                        SqlDataSource1.SelectCommand = "SELECT tblOnlineQuotes.[OnlineQuoteID], CustomerFirstName + ' ' + CustomerLastName AS CustomerName, Email, DateCreated, InstallDate, InstallTime, InitiatedBy, SlabColorsQry.[SlabColorName] FROM ((SlabColorsQry INNER JOIN tblOnlineQuoteStone ON SlabColorsQry.[SlabColorID] = tblOnlineQuoteStone.[SlabColorID])  INNER JOIN  tblOnlineQuotes ON tblOnlineQuoteStone.[OnlineQuoteID] = tblOnlineQuotes.[OnlineQuoteID])  WHERE (CustomerFirstName + ' ' + CustomerLastName LIKE '%' + ? + '%') AND (Email IS NOT NULL) AND (InitiatedBy = 'admin') ORDER BY CustomerFirstName + ' ' + CustomerLastName";
                    else
                        SqlDataSource1.SelectCommand = "SELECT tblOnlineQuotes.[OnlineQuoteID], CustomerFirstName + ' ' + CustomerLastName AS CustomerName, Email, DateCreated, InstallDate, InstallTime, InitiatedBy, SlabColorsQry.[SlabColorName] FROM ((SlabColorsQry INNER JOIN tblOnlineQuoteStone ON SlabColorsQry.[SlabColorID] = tblOnlineQuoteStone.[SlabColorID])  INNER JOIN  tblOnlineQuotes ON tblOnlineQuoteStone.[OnlineQuoteID] = tblOnlineQuotes.[OnlineQuoteID]) WHERE (CustomerFirstName + ' ' + CustomerLastName LIKE '%' + ? + '%') AND (Email IS NOT NULL) ORDER BY CustomerFirstName + ' ' + CustomerLastName";
                }
            }

            SqlDataSource1.DataBind();

        }

        protected void AdminInitCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            RecentCheckBox.Checked = false;
            if (AdminInitCheckBox.Checked)
                ListView1.DataSourceID = SqlDataSource2.ID;
            //SqlDataSource1.SelectCommand = "SELECT OnlineQuoteID, CustomerFirstName + ' ' + CustomerLastName AS CustomerName, Email, DateCreated, InstallDate, InstallTime, InitiatedBy   FROM tblOnlineQuotes WHERE (CustomerFirstName + ' ' + CustomerLastName LIKE '%' + ? + '%') AND (Email IS NOT NULL) AND (InitiatedBy = 'admin') ORDER BY CustomerFirstName + ' ' + CustomerLastName";
            else
                ListView1.DataSourceID = SqlDataSource1.ID;
            //SqlDataSource1.SelectCommand = "SELECT OnlineQuoteID, CustomerFirstName + ' ' + CustomerLastName AS CustomerName, Email, DateCreated, InstallDate, InstallTime, InitiatedBy   FROM tblOnlineQuotes WHERE (CustomerFirstName + ' ' + CustomerLastName LIKE '%' + ? + '%') AND (Email IS NOT NULL) ORDER BY CustomerFirstName + ' ' + CustomerLastName";

            SqlDataSource1.DataBind();
        }

        protected void SqlDataSourceNewQuote_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            OleDbCommand cmd = new OleDbCommand("SELECT @@IDENTITY", (OleDbConnection)e.Command.Connection);
            int strOnlineQuoteID = (int)cmd.ExecuteScalar();
            Response.Redirect("/admin/EditJob.aspx?OnlineQuoteID=" + strOnlineQuoteID);
        }


    }
}