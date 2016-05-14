using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;

public partial class Site : System.Web.UI.MasterPage
{
    string strEnableCalendarUpdate;

    protected void Page_Load(object sender, EventArgs e)
    {
        strEnableCalendarUpdate = String.Empty;
        if (Context.User.Identity.IsAuthenticated)
        {            
            string oleQuery = "SELECT SessionCodeSettings FROM tblUsers WHERE ((UserName)='" + Context.User.Identity.Name + "')";
            string oleConnect = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            using (OleDbConnection oleConn = new OleDbConnection(oleConnect))
            {
                using (OleDbCommand oleCmd = new OleDbCommand(oleQuery, oleConn))
                {
                    oleConn.Open();
                    strEnableCalendarUpdate = oleCmd.ExecuteScalar().ToString();
                    LinkButton EnableCalendarUpdateButton = (LinkButton)Page.Master.FindControl("EnableCalendarUpdateButton");
                    if (strEnableCalendarUpdate == "1")
                        EnableCalendarUpdateButton.Text = "Enable Install Calendar Update";
                    else
                        EnableCalendarUpdateButton.Text = "Disable Install Calendar Update";
                    //oleConn.Close();
                }
            }
        }
    }

    protected void EnableCalendarUpdateButton_Click(object sender, EventArgs e)
    {
        
        string strSessionCodeSettings;
        if (strEnableCalendarUpdate == "1")
            strSessionCodeSettings= "0";
        else
            strSessionCodeSettings= "1";
        
        string oleQuery = "UPDATE tblUsers SET SessionCodeSettings=" + strSessionCodeSettings + " WHERE ((UserName)='" + Context.User.Identity.Name + "')";
        string oleConnect = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
        using (OleDbConnection oleConn = new OleDbConnection(oleConnect))
        {
            using (OleDbCommand oleCmd = new OleDbCommand(oleQuery, oleConn))
            {
                oleConn.Open();
                oleCmd.ExecuteNonQuery();
                //oleConn.Close();
            }
        }

        
    }
}
