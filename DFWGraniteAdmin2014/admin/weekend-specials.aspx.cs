using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DFWGraniteAdmin2014.admin
{
    public partial class weekend_specials : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            SqlDataSource2.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            SqlDataSource3.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
        }

        protected void ShowWeekendSpecialsCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            FormView1.UpdateItem(false);
        }

        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            GridView1.DataBind();
        }
        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            GridView1.DataBind();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Pop", "hideInsertModal();", true);
        }
        protected void FormView2_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            GridView1.DataBind();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Pop", "hideEditModal();", true);
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            //FormView1.ChangeMode(FormViewMode.Insert);
        }


        protected void btnEdit_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)((LinkButton)sender).NamingContainer;
            ((GridView)row.NamingContainer).SelectedIndex = row.RowIndex;
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            FormView2.DataBind();
        }

        protected void FormView2_DataBound(object sender, EventArgs e)
        {
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.RowIndex);               
                //e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
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