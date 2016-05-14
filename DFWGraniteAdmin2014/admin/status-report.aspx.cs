using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;

namespace DFWGraniteAdmin2014.admin
{
    public partial class status_report : System.Web.UI.Page
    {
        // Used to store the last Category Name between each RowDataBound
        private string tmpCategoryName = String.Empty;
        private string strJobID = String.Empty;
        private bool ShowAll = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            SqlDataSource2.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            SqlDataSource3.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            SqlDataSource4.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            SqlDataSource5.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";


            if (!IsPostBack) CategoryChange();

            this.GridView1.DataSourceID = SqlDataSource1.ID;
            this.GridView1.DataBind();
            SpanCategory.Style.Add("display", "none");
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (ShowAll)
            {
                // If the current row is a DataRow (and not a Header or Footer row), then do stuff.
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    strJobID = GridView1.DataKeys[e.Row.RowIndex].Values[0].ToString();
                    //e.Row.Cells[7].Text = strJobID;

                    if (strJobID != null)
                    {
                        string query2 = "Select SinkName from OnlineQuoteSinknameQry where SinkID>0 AND OnlineQuoteID = " + strJobID;
                        string connect2 = SqlDataSource1.ConnectionString;
                        OleDbConnection conn2 = new OleDbConnection(connect2);
                        OleDbCommand cmd2 = new OleDbCommand(query2, conn2);
                        conn2.Open();
                        OleDbDataReader SinkDataReader = cmd2.ExecuteReader();

                        int c = 1;
                        while (SinkDataReader.Read())
                        {
                            if (c > 1)
                                e.Row.Cells[7].Text += "<br />" + SinkDataReader.GetValue(0).ToString();
                            else
                                e.Row.Cells[7].Text += SinkDataReader.GetValue(0).ToString();
                            c++;
                        }
                        SinkDataReader.Close();
                        conn2.Close();
                    }

                    DataRowView drv = (DataRowView)e.Row.DataItem;

                    if (tmpCategoryName != drv[DropDownList1.SelectedValue].ToString())
                    {
                        tmpCategoryName = drv[DropDownList1.SelectedValue].ToString();

                        // Get a reference to the current row’s Parent, which is the Gridview (which happens to be a table)
                        Table tbl = e.Row.Parent as Table;
                        if (tbl != null)
                        {
                            GridViewRow row = new GridViewRow(-1, -1, DataControlRowType.DataRow, DataControlRowState.Normal);
                            TableCell cell = new TableCell();

                            // Span the row across all of the columns in the Gridview
                            cell.ColumnSpan = this.GridView1.Columns.Count;

                            cell.Width = Unit.Percentage(100);
                            cell.Style.Add("font-weight", "bold");
                            cell.Style.Add("font-size", "medium");
                            cell.Style.Add("border-bottom", "solid 1px");
                            cell.Style.Add("border-bottom-color", "black");
                            //cell.Style.Add("background-color", "#c0c0c0");
                            cell.Style.Add("color", "black");
                            cell.Style.Add("vertical-align", "bottom");

                            HtmlGenericControl span = new HtmlGenericControl("span");
                            span.InnerHtml = tmpCategoryName != String.Empty ? "<br />" + tmpCategoryName : tmpCategoryName;

                            cell.Controls.Add(span);
                            row.Cells.Add(cell);

                            tbl.Rows.AddAt(tbl.Rows.Count - 1, row);
                        }
                    }


                }
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            CategoryChange();
        }

        protected void CategoryChange()
        {
            ShowAll = true;

            if (DropDownList1.SelectedValue == "StatusNz")
            {
                SqlDataSource1.SelectCommand += " ORDER BY StatusID, TaskDateIns";
                GridView1.Columns[2].Visible = false;
                GridView1.Columns[3].Visible = true;
                RecentJobByLabel.Text = "by Task";
                DropDownSalesMan.Visible = false;
                DropDownStatus.Visible = true;
                DropDownStatus.SelectedValue = "sa";
            }
            else if (DropDownList1.SelectedValue == "SalesManNameNz")
            {
                SqlDataSource1.SelectCommand += " ORDER BY SalesManID, TaskDateIns";
                GridView1.Columns[3].Visible = false;
                GridView1.Columns[2].Visible = true;
                RecentJobByLabel.Text = "by Assignment";
                DropDownStatus.Visible = false;
                DropDownSalesMan.Visible = true;
                DropDownSalesMan.SelectedValue = "sa";
            }
            else if (DropDownList1.SelectedValue == "InstallDate")
                Response.Redirect("/admin/StatusInstallReport.aspx");
            else if (DropDownList1.SelectedValue == "Measure")
                Response.Redirect("/admin/StatusMeasureReport.aspx");
            else if (DropDownList1.SelectedValue == "Quote")
                Response.Redirect("/admin/StatusQuoteReport.aspx");
            else if (DropDownList1.SelectedValue == "Template")
                Response.Redirect("/admin/StatusTemplateReport.aspx");
            else if (DropDownList1.SelectedValue == "Repair")
                Response.Redirect("/admin/StatusRepairReport.aspx");
            else if (DropDownList1.SelectedValue == "Cabinets")
                Response.Redirect("/admin/StatusCabinetsReport.aspx");

        }

        protected void DropDownStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownStatus.SelectedValue == "sa")
            {
                ShowAll = true;
                SqlDataSource1.SelectCommand += " ORDER BY StatusID, TaskDateIns";
                this.GridView1.DataSourceID = SqlDataSource1.ID;
                SpanCategory.Style.Add("display", "none");
            }
            else
            {
                ShowAll = false;
                this.GridView1.DataSourceID = SqlDataSource3.ID;
                SpanCategory.Style.Add("display", "inline");
                CategoryLabel.Text = DropDownStatus.SelectedItem.Text;
            }

            this.GridView1.DataBind();
        }

        protected void DropDownSalesMan_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownSalesMan.SelectedValue == "sa")
            {
                ShowAll = true;
                SqlDataSource1.SelectCommand += " ORDER BY SalesManID, TaskDateIns";
                this.GridView1.DataSourceID = SqlDataSource1.ID;
                SpanCategory.Style.Add("display", "none");
            }
            else
            {
                ShowAll = false;
                this.GridView1.DataSourceID = SqlDataSource5.ID;
                SpanCategory.Style.Add("display", "inline");
                CategoryLabel.Text = DropDownSalesMan.SelectedItem.Text;
            }

            this.GridView1.DataBind();

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