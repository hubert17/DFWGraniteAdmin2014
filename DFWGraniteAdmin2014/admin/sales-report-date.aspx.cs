using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

namespace DFWGraniteAdmin2014.admin
{
    public partial class sales_report_date : System.Web.UI.Page
    {
        double totSF;
        decimal totSales, totGranite, totWorkOrder, totGrossProfit;

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            

            totSF = 0; totSales = 0; totGranite = 0; totWorkOrder = 0; totGrossProfit = 0;

            if (!IsPostBack)
            {
                DateTime now = DateTime.Now;
                DateTime firstDay = new DateTime(now.Year, now.Month, 1);
                string dayOfFirstDay = firstDay.ToShortDateString();
                string dayOfLasttDay = ((firstDay.AddMonths(1)).AddDays(-1)).ToShortDateString();

                SqlDataSource1.SelectParameters["DateFrom"].DefaultValue =  dayOfFirstDay;
                SqlDataSource1.SelectParameters["DateTo"].DefaultValue = dayOfLasttDay;
                txtDateFrom.Text = dayOfFirstDay;
                txtDateTo.Text = dayOfLasttDay;
            }

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                double rowtotSF = Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Total_SF") as double? ?? 0.0);
                decimal rowtotSales = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalSales"));
                decimal rowtotGranite = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalGranite"));
                decimal rowtotWorkOrder = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalWorkOrder"));
                decimal rowtotGrossProfit = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalGrossProfit"));

                totSF += rowtotSF;
                totSales += rowtotSales; totGranite += rowtotGranite; totWorkOrder += rowtotWorkOrder; totGrossProfit += rowtotGrossProfit;
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[2].Text = "<em>No. of Jobs</em><br>" + GridView1.Rows.Count;
                e.Row.Cells[3].Text = "Totals:<br>Averages:";
                e.Row.Cells[4].Text = String.Format("{0:0.##}", totSF) + "<br>" + String.Format("{0:0.##}", Math.Round(totSF / GridView1.Rows.Count));
                e.Row.Cells[5].Text = String.Format("{0:c}", totSales) + "<br>" + String.Format("{0:c}", Math.Round(totSales / GridView1.Rows.Count));
                e.Row.Cells[6].Text = String.Format("{0:c}", totGranite) + "<br>" + String.Format("{0:c}", Math.Round(totGranite / GridView1.Rows.Count));
                e.Row.Cells[7].Text = String.Format("{0:c}", totWorkOrder) + "<br>" + String.Format("{0:c}", Math.Round(totWorkOrder / GridView1.Rows.Count));
                e.Row.Cells[8].Text = String.Format("{0:c}", totGrossProfit) + "<br>" + String.Format("{0:c}", Math.Round(totGrossProfit / GridView1.Rows.Count));
            }

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue == "Yearly")
                Response.Redirect("/admin2014/admin/sales-report-yearly.aspx");
            else if (DropDownList1.SelectedValue == "Monthly")
                Response.Redirect("/admin2014/admin/sales-report-monthly.aspx");
        }

        protected void LogoutLinkButton_Click(object sender, EventArgs e)
        {
            System.Web.Security.FormsAuthentication.SignOut();
            Response.Redirect("~/admin/Login.aspx");
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            try
            {
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
                GridView1.FooterRow.TableSection = TableRowSection.TableFooter;
            }
            catch(Exception ex)
            { 
            }
        }


    }
}