using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;

namespace DFWGraniteAdmin2014.admin
{
    public partial class sales_report_visual : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            SqlDataSource2.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";

            if(!IsPostBack)
            { 
                string connect = SqlDataSource1.ConnectionString;
                OleDbConnection conn = new OleDbConnection(connect);
                string query = "SELECT MIN(ID) AS Expr1 FROM tblSalesChart HAVING (InstallYear = " + DateTime.Now.Year.ToString() + ")";
                OleDbCommand cmd = new OleDbCommand(query, conn);
                conn.Open();
                try
                {
                    DropDownFrom.SelectedValue = Convert.ToString(cmd.ExecuteScalar());
                }
                catch (Exception ex)
                {
                }
                conn.Close();

                OleDbConnection conn2 = new OleDbConnection(connect);
                string query2 = "SELECT MAX(ID) AS Expr1 FROM tblSalesChart WHERE (ID <> (SELECT MAX(ID) AS Expr1 FROM tblSalesChart tblSalesChart_1))";
                OleDbCommand cmd2 = new OleDbCommand(query2, conn2);
                conn2.Open();
                try
                {
                    DropDownTo.SelectedValue = Convert.ToString(cmd2.ExecuteScalar());
                }
                catch (Exception ex)
                {
                }
                conn2.Close();
            }
            

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue == "Monthly")
                Response.Redirect("/admin2014/admin/sales-report-monthly.aspx");
            else if (DropDownList1.SelectedValue == "Yearly")
                Response.Redirect("/admin2014/admin/sales-report-yearly.aspx");
            else if (DropDownList1.SelectedValue == "Date")
                Response.Redirect("/admin2014/admin/sales-report-date.aspx");

        }

        protected void btnRefreshSalesData_Click(object sender, EventArgs e)
        {
            SqlDataSource1.Delete();
            SqlDataSource1.Insert();
            Response.Redirect("/admin2014/admin/sales-report-visual.aspx");
        }

    }
}