using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Globalization;


namespace DFWGraniteAdmin2014.admin
{
    public partial class sales_report_yearly : System.Web.UI.Page
    {
        // To keep track of the previous row Group Identifier
        string strPreviousRowID = string.Empty;
        // To keep track the Index of Group Total
        int intSubTotalIndex = 1;
        // Datarow count (excludes totals and non-data row)
        int intDataRowCount = 0;

        double totSF = 0;
        double subtotSF = 0;
        decimal totSales = 0, totGranite = 0, totWorkOrder = 0, totGrossProfit = 0;
        decimal subtotSales = 0, subtotGranite = 0, subtotWorkOrder = 0, subtotGrossProfit = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            SqlDataSource2.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";

            if (GroupCheckBox.Checked)
            {
                GridView1.DataSourceID = SqlDataSource1.ID;
                GridView1.ShowFooter = false;
            }
            else
            {
                GridView1.DataSourceID = SqlDataSource2.ID;
                GridView1.ShowFooter = true;
            }



            if (!IsPostBack)
            {
                SqlDataSource1.SelectParameters["Year"].DefaultValue = DateTime.Now.Year.ToString();
                //SqlDataSource1.SelectParameters["Month"].DefaultValue = DateTime.Now.Month.ToString();

                var YearRange = Enumerable.Range(2010, DateTime.Now.Year - 2009);
                DropDownListYear.DataSource = YearRange;
                DropDownListYear.DataBind();

                DropDownListYear.SelectedValue = DateTime.Now.Year.ToString();
                //.SelectedValue = DateTime.Now.Month.ToString();
            }

            //MonthLabel.Text = DropDownListMonth.SelectedItem.Text;
            YearLabel.Text = DropDownListYear.SelectedItem.Text;

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // This is for cumulating the values
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                double rowtotSF; try { rowtotSF = Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Total_SF")); }
                catch (Exception ex) { rowtotSF = 0; }
                decimal rowtotSales; try { rowtotSales = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalSales")); }
                catch (Exception ex) { rowtotSales = 0; }
                decimal rowtotGranite; try { rowtotGranite = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalGranite")); }
                catch (Exception ex) { rowtotGranite = 0; }
                decimal rowtotWorkOrder; try { rowtotWorkOrder = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalWorkOrder")); }
                catch (Exception ex) { rowtotWorkOrder = 0; }
                decimal rowtotGrossProfit; try { rowtotGrossProfit = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalGrossProfit")); }
                catch (Exception ex) { rowtotGrossProfit = 0; }

                // Cumulating Grand Total
                totSF += rowtotSF;
                totSales += rowtotSales;
                totGranite += rowtotGranite;
                totWorkOrder += rowtotWorkOrder;
                totGrossProfit += rowtotGrossProfit;

                if (GroupCheckBox.Checked)
                {
                    strPreviousRowID = DataBinder.Eval(e.Row.DataItem, "InstallMonthName").ToString();

                    // Cumulating Sub Total
                    subtotSF += rowtotSF;
                    subtotSales += rowtotSales;
                    subtotGranite += rowtotGranite;
                    subtotWorkOrder += rowtotWorkOrder;
                    subtotGrossProfit += rowtotGrossProfit;
                }

                intDataRowCount++;
            }

            if (!GroupCheckBox.Checked)
            {
                if (e.Row.RowType == DataControlRowType.Footer)
                {
                    //e.Row.Cells[1].ColumnSpan = 2;
                    e.Row.Cells[1].Text = "<em>No. of Jobs<br></em>" + intDataRowCount;
                    e.Row.Cells[2].Text = "<em>Grand Total:<br>Averages:</em>";
                    e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Right;
                    e.Row.Cells[3].Text = String.Format("{0:0.##}", totSF) + "<br>" + String.Format("{0:0.##}", Math.Round(totSF / intDataRowCount));
                    e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Right;
                    e.Row.Cells[4].Text = String.Format("{0:c}", totSales) + "<br>" + String.Format("{0:c}", Math.Round(totSales / intDataRowCount));
                    e.Row.Cells[5].Text = String.Format("{0:c}", totGranite) + "<br>" + String.Format("{0:c}", Math.Round(totGranite / intDataRowCount));
                    e.Row.Cells[6].Text = String.Format("{0:c}", totWorkOrder) + "<br>" + String.Format("{0:c}", Math.Round(totWorkOrder / intDataRowCount));
                    e.Row.Cells[7].Text = String.Format("{0:c}", totGrossProfit) + "<br>" + String.Format("{0:c}", Math.Round(totGrossProfit / intDataRowCount));
                    //e.Row.Attributes.Add("style", "line-height: 36px;");
                    //e.Row.CssClass = "GrandSubTotalRowStyle";
                }
            }
        }

        protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {

            if (GroupCheckBox.Checked)
            {
                bool IsSubTotalRowNeedToAdd = false;
                bool IsGrandTotalRowNeedtoAdd = false;

                if ((strPreviousRowID != string.Empty) && (DataBinder.Eval(e.Row.DataItem, "InstallMonthName") != null))
                    if (strPreviousRowID != DataBinder.Eval(e.Row.DataItem, "InstallMonthName").ToString())
                        IsSubTotalRowNeedToAdd = true;

                if ((strPreviousRowID != string.Empty) && (DataBinder.Eval(e.Row.DataItem, "InstallMonthName") == null))
                {
                    IsSubTotalRowNeedToAdd = true;
                    IsGrandTotalRowNeedtoAdd = true;
                    intSubTotalIndex = 0;
                }

                #region Inserting first Row and populating fist Group Header details
                if ((strPreviousRowID == string.Empty) && (DataBinder.Eval(e.Row.DataItem, "InstallMonthName") != null))
                {
                    GridView grdViewSales = (GridView)sender;

                    GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);

                    string InstallMonthName = DataBinder.Eval(e.Row.DataItem, "InstallMonthName").ToString();
                    TableCell cell = new TableCell();
                    // Span the row across all of the columns in the Gridview
                    //cell.ColumnSpan = this.GridView1.Columns.Count;
                    cell.ColumnSpan = grdViewSales.Columns.Count;

                    cell.Width = Unit.Percentage(100);
                    cell.Style.Add("font-weight", "bold");
                    cell.Style.Add("font-size", "medium");
                    cell.Style.Add("border-bottom", "solid 1px");
                    cell.Style.Add("border-bottom-color", "black");
                    //cell.Style.Add("background-color", "#c0c0c0");
                    cell.Style.Add("color", "black");
                    cell.Style.Add("vertical-align", "bottom");

                    HtmlGenericControl span = new HtmlGenericControl("span");
                    span.InnerHtml = InstallMonthName;

                    cell.Controls.Add(span);
                    row.Cells.Add(cell);

                    grdViewSales.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
                    intSubTotalIndex++;
                }
                #endregion

                if (IsSubTotalRowNeedToAdd)
                {
                    #region Adding Sub Total Row
                    GridView grdViewSales = (GridView)sender;

                    // Creating a Row
                    GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);


                    //Adding Total Cell 
                    TableCell cell = new TableCell();
                    cell.ColumnSpan = 2;
                    cell.Text = "Subtotal";
                    cell.CssClass = "SubTotalLabelStyle";
                    row.Cells.Add(cell);

                    //Adding Unit Price Column
                    cell = new TableCell();
                    cell.Text = string.Format("{0:0.##}", subtotSF);
                    cell.CssClass = "SubTotalRowStyle";
                    row.Cells.Add(cell);

                    //Adding Quantity Column
                    cell = new TableCell();
                    cell.Text = string.Format("{0:c}", subtotSales);
                    cell.CssClass = "SubTotalRowStyle";
                    row.Cells.Add(cell);

                    //Adding Discount Column
                    cell = new TableCell();
                    cell.Text = string.Format("{0:c}", subtotGranite);
                    cell.CssClass = "SubTotalRowStyle";
                    row.Cells.Add(cell);

                    //Adding Amount Column
                    cell = new TableCell();
                    cell.Text = string.Format("{0:c}", subtotWorkOrder);
                    cell.CssClass = "SubTotalRowStyle";
                    row.Cells.Add(cell);

                    //Adding Amount Column
                    cell = new TableCell();
                    cell.Text = string.Format("{0:c}", subtotGrossProfit);
                    cell.CssClass = "SubTotalRowStyle";
                    row.Cells.Add(cell);

                    //Adding the Row at the RowIndex position in the Grid
                    grdViewSales.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
                    intSubTotalIndex++;
                    #endregion

                    #region Adding Next Group Header Details
                    if (DataBinder.Eval(e.Row.DataItem, "InstallMonthName") != null)
                    {
                        row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);

                        string InstallMonthName = DataBinder.Eval(e.Row.DataItem, "InstallMonthName").ToString();
                        cell = new TableCell();
                        // Span the row across all of the columns in the Gridview
                        cell.ColumnSpan = grdViewSales.Columns.Count;

                        cell.Width = Unit.Percentage(100);
                        cell.Style.Add("font-weight", "bold");
                        cell.Style.Add("font-size", "medium");
                        cell.Style.Add("border-bottom", "solid 1px");
                        cell.Style.Add("border-bottom-color", "black");
                        //cell.Style.Add("background-color", "#c0c0c0");
                        cell.Style.Add("color", "black");
                        cell.Style.Add("vertical-align", "bottom");

                        HtmlGenericControl span = new HtmlGenericControl("span");
                        span.InnerHtml = InstallMonthName != String.Empty ? "<br />" + InstallMonthName : InstallMonthName;

                        cell.Controls.Add(span);
                        row.Cells.Add(cell);

                        grdViewSales.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
                        intSubTotalIndex++;
                    }
                    #endregion

                    #region Reseting the Sub Total Variables
                    subtotSF = 0;
                    subtotSales = 0;
                    subtotGranite = 0;
                    subtotWorkOrder = 0;
                    subtotGrossProfit = 0;
                    #endregion
                }
                if (IsGrandTotalRowNeedtoAdd)
                {
                    #region Grand Total Row
                    GridView grdViewSales = (GridView)sender;

                    // Creating a Row
                    GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);

                    //Adding Total Cell 
                    TableCell cell = new TableCell();
                    cell.Text = "<em>No. of Jobs<br></em>" + intDataRowCount;
                    cell.HorizontalAlign = HorizontalAlign.Right;
                    cell.Attributes.Add("style", "padding-top: 30px;");
                    cell.CssClass = "GrandSubTotalRowStyle";
                    row.Cells.Add(cell);

                    cell = new TableCell();
                    cell.Text = "<em>Grand Total:<br>Averages:</em>";
                    cell.HorizontalAlign = HorizontalAlign.Right;
                    cell.Attributes.Add("style", "padding-top: 30px;");
                    cell.CssClass = "GrandSubTotalRowStyle";
                    row.Cells.Add(cell);

                    //Adding Unit Price Column
                    cell = new TableCell();
                    cell.Text = String.Format("{0:0.##}", totSF) + "<br>" + String.Format("{0:0.##}", Math.Round(totSF / intDataRowCount));
                    cell.HorizontalAlign = HorizontalAlign.Right;
                    cell.Attributes.Add("style", "padding-top: 30px;");
                    cell.CssClass = "GrandSubTotalRowStyle";
                    row.Cells.Add(cell);

                    //Adding Quantity Column
                    cell = new TableCell();
                    cell.Text = String.Format("{0:c}", totSales) + "<br>" + String.Format("{0:c}", Math.Round(totSales / intDataRowCount));
                    cell.HorizontalAlign = HorizontalAlign.Right;
                    cell.Attributes.Add("style", "padding-top: 30px;");
                    cell.CssClass = "GrandSubTotalRowStyle";
                    row.Cells.Add(cell);

                    //Adding Discount Column
                    cell = new TableCell();
                    cell.Text = String.Format("{0:c}", totGranite) + "<br>" + String.Format("{0:c}", Math.Round(totGranite / intDataRowCount));
                    cell.HorizontalAlign = HorizontalAlign.Right;
                    cell.Attributes.Add("style", "padding-top: 30px;");
                    cell.CssClass = "GrandSubTotalRowStyle";
                    row.Cells.Add(cell);

                    //Adding Amount Column
                    cell = new TableCell();
                    cell.Text = String.Format("{0:c}", totWorkOrder) + "<br>" + String.Format("{0:c}", Math.Round(totWorkOrder / intDataRowCount));
                    cell.HorizontalAlign = HorizontalAlign.Right;
                    cell.Attributes.Add("style", "padding-top: 30px;");
                    cell.CssClass = "GrandSubTotalRowStyle";
                    row.Cells.Add(cell);

                    //Adding Amount Column
                    cell = new TableCell();
                    cell.Text = String.Format("{0:c}", totGrossProfit) + "<br>" + String.Format("{0:c}", Math.Round(totGrossProfit / intDataRowCount));
                    cell.HorizontalAlign = HorizontalAlign.Right;
                    cell.Attributes.Add("style", "padding-top: 30px;");
                    cell.CssClass = "GrandSubTotalRowStyle";
                    row.Cells.Add(cell);

                    //Adding the Row at the RowIndex position in the Grid
                    grdViewSales.Controls[0].Controls.AddAt(e.Row.RowIndex, row);
                    #endregion
                }
            }

        }


        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue == "Monthly")
                Response.Redirect("/admin2014/admin/sales-report-monthly.aspx");
            else if (DropDownList1.SelectedValue == "Date")
                Response.Redirect("/admin2014/admin/sales-report-date.aspx");
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            try
            {
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
                GridView1.FooterRow.TableSection = TableRowSection.TableFooter;
            }
            catch (Exception ex)
            {
            }
        }

    }
}