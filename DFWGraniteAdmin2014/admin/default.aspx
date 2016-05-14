<%@ Page Title="ADMIN PANEL" Language="C#" MasterPageFile="~/Site.master" UnobtrusiveValidationMode="None" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="DFWGraniteAdmin2014.admin._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css' />

    <script type="text/javascript">
        /*
         * Image preview script
         * powered by jQuery (http://www.jquery.com)
         *
         * written by Alen Grakalic (http://cssglobe.com)
         *
         * for more info visit http://cssglobe.com/post/1695/easiest-tooltip-and-image-preview-using-jquery
         *
         */

        this.imagePreview = function () { /* CONFIG */

            xOffset = 10;
            yOffset = 30;

            // these 2 variable determine popup's distance from the cursor
            // you might want to adjust to get the right result
            /* END CONFIG */
            $("a.preview").hover(function (e) {
                var t = $(this).attr('data-initiatedby');
                var c = (t != "") ? "<br/>Initiated by " + t : "";
                var insT = $(this).attr('data-installdate');
                var insC = (insT.trim() != "") ? "<br /><span style=\"color: #7FD2FF\">Install/Task Date:</span>&nbsp;&nbsp;&nbsp;&nbsp;" + insT : "";
                $("body").append("<p id='preview'><span style=\"color: #7FD2FF\">Date Created:</span>&nbsp;&nbsp;&nbsp;&nbsp;" + $(this).attr('data-createddate') + insC + "<br /><span style=\"color: #7FD2FF\">Granite:</span>&nbsp;&nbsp;&nbsp;&nbsp;" + $(this).attr('data-granitename') + "<em>" + c + "</em></p>");
                $("#preview").css("top", (e.pageY - xOffset) + "px").css("left", (e.pageX + yOffset) + "px").fadeIn("fast");
            }, function () {
                $("#preview").remove();
            });
            $("a.preview").mousemove(function (e) {
                $("#preview").css("top", (e.pageY - xOffset) + "px").css("left", (e.pageX + yOffset) + "px");
            });
        };


        // starting the script on page load
        $(document).ready(function () {
            imagePreview();
        });
    </script>

    <style type="text/css">
        body{
	        background: #e0e3ec url(/admin2014/css/images/bgnoise_lg.jpg) repeat top left;
            color: #393b40;
        }
        a{
	        color: #333;
	        text-decoration: none;
        }
        td{text-align: center;}
        p.codrops-demos{
	        text-align:center;
	        display: block;
	        padding: 14px;
        }
        p.codrops-demos a,
        p.codrops-demos a.current-demo,
        p.codrops-demos a.current-demo:hover{
            display: inline-block;
	        border: 1px solid #7FB2C1;
	        padding: 4px 10px 3px;
	        font-size: 13px;
	        line-height: 18px;
	        margin: 2px 3px;
	        font-weight: 800;
	        -webkit-box-shadow: 0px 1px 1px rgba(0,0,0,0.1);
	        -moz-box-shadow:0px 1px 1px rgba(0,0,0,0.1);
	        box-shadow: 0px 1px 1px rgba(0,0,0,0.1);
	        color: #fff;
	        text-shadow: 1px 1px 1px rgba(0,0,0,0.6);
	        -webkit-border-radius: 5px;
	        -moz-border-radius: 5px;
	        border-radius: 5px;
	        background: #b0d4e3;
	        background: -moz-linear-gradient(top, #b0d4e3 0%, #88bacf 100%);
	        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#b0d4e3), color-stop(100%,#88bacf));
	        background: -webkit-linear-gradient(top, #b0d4e3 0%,#88bacf 100%);
	        background: -o-linear-gradient(top, #b0d4e3 0%,#88bacf 100%);
	        background: -ms-linear-gradient(top, #b0d4e3 0%,#88bacf 100%);
	        background: linear-gradient(top, #b0d4e3 0%,#88bacf 100%);
	        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#b0d4e3', endColorstr='#88bacf',GradientType=0 );
        }
        p.codrops-demos a:hover{
	        background: #80B8CE;
            text-decoration:none;
        }
        p.codrops-demos a:active{
	        -webkit-box-shadow: 0px 1px 1px rgba(255,255,255,0.4);
	        -moz-box-shadow: 0px 1px 1px rgba(255,255,255,0.4);
	        box-shadow: 0px 1px 1px rgba(255,255,255,0.4);
        }
        p.codrops-demos a.current-demo{
	        color: #3d7489;
	        text-shadow: 0px 1px 1px rgba(255,255,255,0.3);
        }
        p.codrops-demos a.current-demo:hover{
            background: #b0d4e3;
            color: #3d7489;
            text-shadow: 0px 1px 1px rgba(255,255,255,0.1);
        }
    </style>

        <style type="text/css">
            
 /* Table 3 Style */
table.table3{
    font-family: 'Droid Sans', Arial, sans-serif; 
    font-size: 18px;
    font-style: normal;
    font-weight: bold;
    text-transform: uppercase;
    letter-spacing: -1px;
    line-height: 1.7em;
    border-collapse:collapse;

}
.th{
    padding:6px 10px;
    text-transform:uppercase;
    color:#444;
    font-weight:bold;
    text-shadow:1px 1px 1px #fff;
    border-bottom:5px solid #444;
    background-color: #7FD2FF;
    width:20%;
    min-width:70px;
    text-align:center;
}

.th2{
    padding:6px 10px;
    text-transform:uppercase;
    color:#444;
    font-weight:bold;
    text-shadow:1px 1px 1px #fff;
    border-bottom:5px solid #444;
    background-color: #45A8DF;
    text-align:center;
}
.thempty{
    background:transparent;
    border:none;
}

.table3 thead :nth-child(2),
.table3 tfoot :nth-child(2){
    background-color: #7FD2FF;
}
.table3 tfoot :nth-child(2){
    -moz-border-radius:0px 0px 0px 5px;
    -webkit-border-bottom-left-radius:5px;
    border-bottom-left-radius:5px;
}
.table3 thead :nth-child(2){
    -moz-border-radius:5px 0px 0px 0px;
    -webkit-border-top-left-radius:5px;
    border-top-left-radius:5px;
}


.table3 thead :nth-child(3),
.table3 tfoot :nth-child(3){
    background-color: #45A8DF;
}
.table3 thead :nth-child(4),
.table3 tfoot :nth-child(4){
    background-color: #2388BF;
}
.table3 thead :nth-child(5),
.table3 tfoot :nth-child(5){
    background-color: #096A9F;
}
.table3 thead :nth-child(5){
    -moz-border-radius:0px 5px 0px 0px;
    -webkit-border-top-right-radius:5px;
    border-top-right-radius:5px;
}
.table3 tfoot :nth-child(5){
    -moz-border-radius:0px 0px 5px 0px;
    -webkit-border-bottom-right-radius:5px;
    border-bottom-right-radius:5px;
}
.table3 tfoot td{
    padding:15px 0px;
    text-shadow:1px 1px 1px #fff;
}
.table3 tbody td{
    padding:10px;
}
.table3 tbody tr:not(:last-child):hover td{
    font-size:26px;
    font-weight:bold;
}
.table3 tbody td:nth-child(even){
    background-color:#444;
    color:#444;
    border-bottom:1px solid #444;
    background:-webkit-gradient(
        linear,
        left bottom,
        left top,
        color-stop(0.39, rgb(189,189,189)),
        color-stop(0.7, rgb(224,224,224))
        );
    background:-moz-linear-gradient(
        center bottom,
        rgb(189,189,189) 39%,
        rgb(224,224,224) 70%
        );
    text-shadow:1px 1px 1px #fff;
}
.table3 tbody td:nth-child(odd){
    background-color:#555;
    color:#f0f0f0;
    border-bottom:1px solid #444;
    background:-webkit-gradient(
        linear,
        left bottom,
        left top,
        color-stop(0.39, rgb(85,85,85)),
        color-stop(0.7, rgb(105,105,105))
        );
    background:-moz-linear-gradient(
        center bottom,
        rgb(85,85,85) 39%,
        rgb(105,105,105) 70%
        );
    text-shadow:1px 1px 1px #000;
}
.table3 tbody td:nth-last-child(1){
    border-right:1px solid #222;
}
.table3 tbody th{
    color:#696969;
    padding:0px 10px;
    border-right:1px solid #aaa;
}
.table3 tbody span.check::before{
    content : url(../images/check2.png)
}
 
input[type=submit]{
            margin: 8px 1px;
            padding: 5px 15px;
		}	
 .codrops-demos input[type=text]{
            font-size:large;
            margin: 5px;
		}	
 
 #preview{
    position:absolute;
    border:1px solid #ccc;
    background:#333;
    padding:5px;
    display:none;
    color:#fff;
}            
 
         @media screen and (max-width: 767px) {
            table.table3{
                font-family: 'Droid Sans', Arial, sans-serif; 
                font-size: 14px;
	            }
            .table3 tbody tr:hover td:not(:last-child){
                font-size:14px;
            }
        }                          
    </style>

    

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="col-sm-6 col-sm-offset-3">
			<header>
                <asp:Panel ID="Panel1" DefaultButton="SearchButton" runat="server">
				<p class="codrops-demos">
					               <asp:Label ID="Label1" runat="server" Text="Search Job:"></asp:Label>
                <asp:TextBox ID="JobSearchTextBox" runat="server" Width="200px" ForeColor="Gray"></asp:TextBox>
                <asp:LinkButton ID="SearchButton" runat="server" Text="Search" OnClick="RecentCheckBox_CheckedChanged"  />
                <a id="CreateJobButton" class="current-demo" data-toggle="modal" href="#InsertModal" data-backdrop="static" data-keyboard="false">Create Job Quote</a>

				<br />
                    <asp:CheckBox ID="RecentCheckBox" runat="server" Text=" Show Recent Quotes" AutoPostBack="True" OnCheckedChanged="RecentCheckBox_CheckedChanged" />
                                   &nbsp;&nbsp;

                        <label class="text-nowrap">
                           <asp:CheckBox ID="AdminInitCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="AdminInitCheckBox_CheckedChanged" Checked="True" />Admin Initiated Only
                        </label>


                </p>

                </asp:Panel>

			</header>
			<section>
                <div>



                <asp:ListView ID="ListView1" runat="server" DataKeyNames="OnlineQuoteID" DataSourceID="SqlDataSource2">
                
                <EmptyDataTemplate>
                    <table id="Table1" runat="server" style="" >
                        <tr>
                            <td>Quote does not exist.<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="/admin/CreateJob.aspx"> Create Job Quote.</asp:HyperLink></td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="OnlineQuoteIDLabel" runat="server" Text='<%# Eval("OnlineQuoteID") %>' />
                        </td>
                        <td>
                            <a class="preview" href='<%# Eval("OnlineQuoteID", "/admin/EditJob.aspx?OnlineQuoteID={0}") %>' data-createddate='<%# Eval("DateCreated","{0:MMM/dd/yyyy}") %>' data-installdate='<%# Eval("InstallDate","{0:MMM/dd/yyyy}") + " " + Eval("InstallTime")  %>' data-initiatedby='<%# Eval("InitiatedBy") %>' data-granitename='<%# Eval("SlabColorName") %>' ><asp:Label ID="CustomerNameLabel" runat="server" Text='<%# Eval("CustomerName") %>' Height="100%" Width="100%" /></a>
                        </td></tr></ItemTemplate>
                 <LayoutTemplate>
                        <table id="itemPlaceholderContainer" runat="server" border="0" style="" class="table3 table">
                        <thead>
                            <tr id="Tr2" runat="server" >
                                <th id="Th1" runat="server" class="th">Quote #</th>
                                <th id="Th2" runat="server" class="th2">Customer Name</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </tbody>
                            <table>
                                <tr>
                                    <td colspan="2">
                                        <asp:DataPager ID="DataPager1" runat="server" PageSize="20">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ButtonCssClass="btn-default" />
                                            </Fields>
                                        </asp:DataPager>
                                    </td>
                                </tr>
                            </table>
                        </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Label ID="OnlineQuoteIDLabel" runat="server" Text='<%# Eval("OnlineQuoteID") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CustomerNameLabel" runat="server" Text='<%# Eval("CustomerName") %>' />
                        </td>
                    </tr>
                </SelectedItemTemplate>
               </asp:ListView>


                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True" ProviderName="System.Data.OleDb" SelectCommand="SELECT tblOnlineQuotes.OnlineQuoteID, tblOnlineQuotes.CustomerFirstName + ' ' + tblOnlineQuotes.CustomerLastName AS CustomerName, tblOnlineQuotes.Email, tblOnlineQuotes.DateCreated, iif(ISNULL(tblOnlineQuotes.InstallDate), tblOnlineQuotes.TaskDate, tblOnlineQuotes.InstallDate) AS InstallDate, iif(ISNULL(tblOnlineQuotes.InstallTime), tblOnlineQuotes.TaskTime, tblOnlineQuotes.InstallTime) AS InstallTime, tblOnlineQuotes.InitiatedBy, SlabColorsQry.SlabColorName FROM ((SlabColorsQry INNER JOIN tblOnlineQuoteStone ON SlabColorsQry.SlabColorID = tblOnlineQuoteStone.SlabColorID) INNER JOIN tblOnlineQuotes ON tblOnlineQuoteStone.OnlineQuoteID = tblOnlineQuotes.OnlineQuoteID) WHERE (tblOnlineQuotes.CustomerFirstName + ' ' + tblOnlineQuotes.CustomerLastName LIKE '%' + ? + '%') AND (tblOnlineQuotes.Email IS NOT NULL) ORDER BY tblOnlineQuotes.OnlineQuoteID DESC">
                   <SelectParameters>
                       <asp:ControlParameter ControlID="JobSearchTextBox" DefaultValue="%" Name="?" PropertyName="Text" />
                   </SelectParameters>
               </asp:SqlDataSource>

                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True" ProviderName="System.Data.OleDb" SelectCommand="SELECT tblOnlineQuotes.OnlineQuoteID, tblOnlineQuotes.CustomerFirstName + ' ' + tblOnlineQuotes.CustomerLastName AS CustomerName, tblOnlineQuotes.Email, tblOnlineQuotes.DateCreated, iif(ISNULL(tblOnlineQuotes.InstallDate), tblOnlineQuotes.TaskDate, tblOnlineQuotes.InstallDate) AS InstallDate, iif(ISNULL(tblOnlineQuotes.InstallTime), tblOnlineQuotes.TaskTime, tblOnlineQuotes.InstallTime) AS InstallTime, tblOnlineQuotes.InitiatedBy, SlabColorsQry.SlabColorName FROM ((SlabColorsQry INNER JOIN tblOnlineQuoteStone ON SlabColorsQry.SlabColorID = tblOnlineQuoteStone.SlabColorID) INNER JOIN tblOnlineQuotes ON tblOnlineQuoteStone.OnlineQuoteID = tblOnlineQuotes.OnlineQuoteID) WHERE (tblOnlineQuotes.CustomerFirstName + ' ' + tblOnlineQuotes.CustomerLastName LIKE '%' + ? + '%') AND (tblOnlineQuotes.Email IS NOT NULL) AND (tblOnlineQuotes.InitiatedBy = 'admin') ORDER BY tblOnlineQuotes.OnlineQuoteID DESC">
                   <SelectParameters>
                       <asp:ControlParameter ControlID="JobSearchTextBox" DefaultValue="%" Name="?" PropertyName="Text" />
                   </SelectParameters>
               </asp:SqlDataSource>

                </div>
            </section>
    </div>

    
<div class="modal fade" id="InsertModal" tabindex="-1" role="dialog" aria-labelledby="InsertModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel2">Create New JOB QUOTE</h4>
                </div>
<asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSourceNewQuote" DefaultMode="Insert" RenderOuterTable="False" >                
                <InsertItemTemplate>
          
          <div class="modal-body">
                   <asp:RequiredFieldValidator Display="Dynamic"  runat="server" ControlToValidate="CustomerFirstNameTextBox" ValidationGroup="vg1">
                      <div class="alert alert-danger col-sm-12">The "customer's firstname" is required and cannot be empty.</div>
                  </asp:RequiredFieldValidator>
                   <asp:RequiredFieldValidator Display="Dynamic"  runat="server" ControlToValidate="SurnameTextBox" ValidationGroup="vg1">
                      <div class="alert alert-danger col-sm-12">The "customer's surname" is required and cannot be empty.</div>
                  </asp:RequiredFieldValidator>
                   <asp:RequiredFieldValidator Display="Dynamic"  runat="server" ControlToValidate="PhoneTextBox" ValidationGroup="vg1">
                      <div class="alert alert-danger col-sm-12">The "phone number" is required and cannot be empty.</div>
                  </asp:RequiredFieldValidator>
                   <asp:RequiredFieldValidator Display="Dynamic"  runat="server" ControlToValidate="EmailTextBox" ValidationGroup="vg1">
                      <div class="alert alert-danger col-sm-12">The "email address" is required and cannot be empty.</div>
                  </asp:RequiredFieldValidator>
                   <asp:RegularExpressionValidator Display="Dynamic"  runat="server" ControlToValidate="EmailTextBox" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="vg1" >
                       <div class="alert alert-danger col-sm-12">The "email address" is invalid.</div>
                   </asp:RegularExpressionValidator>

                      <div class="row">
                          <div class="col-md-6">
                            <h4>Customer Info</h4>
                            <p>Firstname<asp:TextBox ID="CustomerFirstNameTextBox" runat="server" Text='<%# Bind("CustomerFirstName") %>' class="form-control" /></p>
                            <p>Surname<asp:TextBox ID="SurnameTextBox" runat="server" Text='<%# Bind("CustomerLastName") %>' class="form-control" /></p>
                            <p>Phone Number<asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' class="form-control" /></p>
                            <p>Email<asp:TextBox ID="EmailTextBox" runat="server" Text='<%# Bind("Email") %>' class="form-control" /></p>
                          </div>
                          <div class="col-md-6">
                            <h4>Job Site Info</h4>
                            <p>Address<asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' class="form-control" /></p>
                            <p>City<asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' class="form-control" /></p>
                            <p>State<asp:TextBox ID="StateTextBox" runat="server" Text='<%# Bind("State") %>' class="form-control" value="Tx" /></p>
                            <p>Zip<asp:TextBox ID="ZipCodeTextBox" runat="server" Text='<%# Bind("ZipCode") %>' class="form-control" /></p>
                          </div>
                        </div>
                    </div>
          <div class="modal-footer">
                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"  class="btn btn-default" data-dismiss="modal"/>
              <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" ValidationGroup="vg1"  CommandName="Insert" Text="Continue..." class="btn btn-primary" />
          </div>
                </InsertItemTemplate>                
            </asp:FormView>
            </div>
        </div>
    </div>

<asp:SqlDataSource ID="SqlDataSourceNewQuote" runat="server" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True" InsertCommand="INSERT INTO tblOnlineQuotes(CustomerLastName, CustomerFirstName, Address, City, State, ZipCode, Phone, Email, InitiatedBy, InitiatedDate, Edge) VALUES (StrConv(?, 3), StrConv(?, 3), ?, ?, ?, ?, ?, ?, 'admin', NOW(), - 1)" ProviderName="System.Data.OleDb" OnInserted="SqlDataSourceNewQuote_Inserted">
                
                <InsertParameters>
                    <asp:Parameter Name="CustomerLastName" Type="String" />
                    <asp:Parameter Name="CustomerFirstName" Type="String" />
                    <asp:Parameter Name="Address" Type="String" />
                    <asp:Parameter Name="City" Type="String" />
                    <asp:Parameter Name="State" Type="String" />
                    <asp:Parameter Name="ZipCode" Type="String" />
                    <asp:Parameter Name="Phone" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                </InsertParameters>
                
            </asp:SqlDataSource>

    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="postformtag" runat="server">
<script type="text/javascript">
    $('div.modal').on('show.bs.modal', function () {
        var modal = this;
        var hash = modal.id;
        window.location.hash = hash;
        window.onhashchange = function () {
            if (!location.hash) {
                $(modal).modal('hide');
            }
        }
    });

    $('div.modal').on('hide', function () {
        var hash = this.id;
        history.pushState('', document.title, window.location.pathname);
    });
    </script>
</asp:Content>
