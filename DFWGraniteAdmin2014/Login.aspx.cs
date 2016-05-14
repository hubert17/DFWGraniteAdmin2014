using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Web.Security;

namespace DFWGraniteAdmin2014
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack) 
            Session.Abandon();
            SqlDataSource1.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("/") + "App_Data\\DFWwebsiteDB.accdb;Persist Security Info=True";
            //SqlDataSource1.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\\DFWwebsiteDB.accdb;Persist Security Info=True";

            this.Form.DefaultButton = LoginButton.UniqueID;
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string connect = SqlDataSource1.ConnectionString;
            OleDbConnection conn = new OleDbConnection(connect);
            string query = "Select count(*) from tblUsers WHERE UserName = '" + UsernameTextBox.Text + "' AND UserPassword= '" + PasswordTextBox.Text + "' AND Inactive=false";
            OleDbCommand cmd = new OleDbCommand(query, conn);
            conn.Open();
            int intResult;
            try
            {
                intResult = Convert.ToInt16(Convert.ToString(cmd.ExecuteScalar()));
            }
            catch (Exception ex)
            {
                intResult = 0;
                LoginAlertLiteral.Visible = true;
            }
            conn.Close();

            if (intResult > 0)
                ValidLogin();
            else
                InvalidLogin();
        }

        protected void ValidLogin()
        {
            string query3 = "UPDATE tblUsers SET InvalidLoginAttempts=0, LastSuccessfulLogin=#" + DateTime.Now.ToString() + "#  WHERE UserName = '" + UsernameTextBox.Text + "'";
            string connect3 = SqlDataSource1.ConnectionString;
            OleDbConnection conn3 = new OleDbConnection(connect3);
            OleDbCommand cmd3 = new OleDbCommand(query3, conn3);
            conn3.Open();
            cmd3.ExecuteNonQuery();
            conn3.Close();

            //if (Request.QueryString["ReturnUrl"] != null)
                //FormsAuthentication.SetAuthCookie(UsernameTextBox.Text, PersistCheckBox.Checked);
                FormsAuthentication.RedirectFromLoginPage(UsernameTextBox.Text, PersistCheckBox.Checked);

        }

        protected void InvalidLogin()
        {
            LoginAlertLiteral.Visible = true;

            //Retrieve current invalid login count
            string query0 = "Select InvalidLoginAttempts from tblUsers WHERE UserName = '" + UsernameTextBox.Text + "'";
            string connect0 = SqlDataSource1.ConnectionString;
            OleDbConnection conn0 = new OleDbConnection(connect0);
            OleDbCommand cmd0 = new OleDbCommand(query0, conn0);
            conn0.Open();
            int intResult0;
            try
            {
                intResult0 = Convert.ToInt16(Convert.ToString(cmd0.ExecuteScalar()));
            }
            catch (Exception ex)
            {
                intResult0 = 0;
                LoginAlertLiteral.Visible = true;
            }
            conn0.Close();


            //Update invalid login count
            string query1 = "UPDATE tblUsers SET InvalidLoginAttempts=" + (intResult0 + 1) + " WHERE UserName = '" + UsernameTextBox.Text + "'";
            string connect1 = SqlDataSource1.ConnectionString;
            OleDbConnection conn1 = new OleDbConnection(connect1);
            OleDbCommand cmd1 = new OleDbCommand(query1, conn1);
            conn1.Open();
            cmd1.ExecuteNonQuery();
            conn1.Close();

        }

    }
}