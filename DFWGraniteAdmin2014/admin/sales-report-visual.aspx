<%@ Page Title="Sales Report" Language="C#" MasterPageFile="~/Site.master"  AutoEventWireup="true" CodeBehind="sales-report-visual.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.sales_report_visual" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="http://cdn.oesmith.co.uk/morris-0.4.3.min.css" />
    <script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="http://cdn.oesmith.co.uk/morris-0.4.3.min.js"></script>

    <!-- Custom CSS -->
    <link href="http://startbootstrap.com/templates/sb-admin/css/sb-admin.css" rel="stylesheet"/>
     
    <!-- Custom Fonts -->
   <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet" />

    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/ladda-bootstrap/0.1.0/ladda-themeless.min.css"/>
    <link rel="stylesheet" href="/admin2014/css/plugins/ladda/prism.css"/>


    <style>
         svg, canvas {
          max-width: 100%;
        }
        body {
            padding-top: 70px;
            /* Required padding for .navbar-fixed-top. Remove if using .navbar-static-top. Change if height of navigation changes. */
        }  
        a[disabled] { pointer-events: none; }     

        @media (max-width: 768px){
            body {
                margin-top: 50px;
            }
        }
    </style>
  
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <div class="row">
        <div class="col-lg-12" style="color:gray;">
            <h2 class="page-header" style="margin-top:5px;" >Sales Chart
                <span class="pull-right"><asp:LinkButton runat="server" class="btn btn-primary" data-toggle="modal" data-target="#OptionModal" data-backdrop="static" data-keyboard="false" >Option</asp:LinkButton></span>
            </h2>
         </div>                   
    </div>
    <div class="row">
        <div class="col-xs-6"><p class="lead" style="color:gray;">See how the business is going!</p></div>                         
                            <div class="col-md-2 pull-right">
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"  class="form-control">
                            <asp:ListItem Value="">View by</asp:ListItem>
                            <asp:ListItem Value="Monthly">by Month</asp:ListItem>
                            <asp:ListItem Value="Yearly">by Year</asp:ListItem>
                            <asp:ListItem Value="Date">by Date</asp:ListItem>
                        </asp:DropDownList>
                        
                </div>

       </div>

    <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bar-chart-o"></i> DFW Wholesale Granite Sales</h3>
                            </div>
                            <div class="panel-body">

                                <div id="area-DFWSalesChart" style="position: relative; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></div>        
                                    
                            </div>
                        </div>
                    </div>
                </div>


    <div class="modal fade" id="OptionModal" tabindex="-1" role="dialog" aria-labelledby="OptionModal"" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel2">Chart Option</h4>
                </div>          
          <div class="modal-body">
<div class="row">
                             <div class="col-md-6">
                                <p>From<asp:DropDownList ID="DropDownFrom" runat="server" DataSourceID="SqlDataSource1" DataTextField="MonthYear" DataValueField="ID" DataTextFormatString="{0:MMMM yyyy}" CssClass="form-control" ></asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True" ProviderName="System.Data.OleDb" SelectCommand="SELECT ID, cdate(MonthYear) AS MonthYear FROM tblSalesChart " DeleteCommand="DELETE FROM tblSalesChart" InsertCommand="INSERT INTO tblSalesChart(InstallYear, InstallMonth, MonthYear, TotalSales, TotalGrossProfit, NoOfJobs) SELECT InstallYear, InstallMonth, MonthYear, TotalSales, SumOfTotalGrossProfit, NoOfJobs FROM SalesTotalJobsChartQry"></asp:SqlDataSource>
                                 </p>
                             </div>
                             <div class="col-md-6">
                                <p>To<asp:DropDownList ID="DropDownTo" runat="server" DataSourceID="SqlDataSource2" DataTextField="MonthYear" DataValueField="ID" DataTextFormatString="{0:MMMM yyyy}" CssClass="form-control"></asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True" ProviderName="System.Data.OleDb" SelectCommand="SELECT ID, cdate(MonthYear) AS MonthYear FROM tblSalesChart ORDER BY ID DESC"></asp:SqlDataSource>
                                 </p>
                             </div>
    </div>                    
                
           </div>
          <div class="modal-footer">
              <asp:LinkButton ID="btnRefreshSalesData" runat="server" class="btn btn-sm btn-warning ladda-button pull-left" data-style="zoom-out" OnClick="btnRefreshSalesData_Click" >
                  <span class="ladda-label">Refresh Sales Data</span>
              </asp:LinkButton>

              <asp:LinkButton ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" class="btn btn-sm btn-default"  data-dismiss="modal" >Cancel</asp:LinkButton>
              <asp:LinkButton ID="ApplyButton" runat="server" OnClientClick="Graph();" class="btn btn-sm btn- btn-primary" >Apply</asp:LinkButton>
          </div>
            </div>
        </div>
    </div>



    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="postformtag" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var monthNames = ["January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"];

            Date.prototype.MMMMyyyy = function () {
                var yyyy = this.getFullYear().toString();
                var MMMM = (monthNames[this.getMonth()]).toString(); // getMonth() is zero-based         
                return MMMM + " " + yyyy;
            };

            $(window).resize(function () { //on window resize... 
                window.m.redraw();
            });

            window.m = Morris.Area({
                element: 'area-DFWSalesChart',
                data: Graph(),
                xkey: 'label',
                ykeys: ['value', 'value2'],
                labels: ['Total Sales $', 'No of Jobs (/10K)'],
                behaveLikeLine: true,
                dateFormat: function (label) { return new Date(label).MMMMyyyy(); },
                xLabelFormat: function (label) {
                    return (monthNames[label.getMonth()]) + ' ' + label.getFullYear();
                },
                yLabelFormat: function (value) { return value.toString(); },
                redraw: true
            });

        });

        function Graph() {
            var data = "";

            $.ajax({
                type: 'GET',
                url: "http://www.granitesouthlake.com/admin2014/admin/GraphHandler.ashx",
                dataType: 'json',
                async: false,
                contentType: "application/json; charset=utf-8",
                data: { 'GraphName': 'line', 'dateidFrom': document.getElementById('<%= DropDownFrom.ClientID %>').value, 'dateidTo': document.getElementById('<%= DropDownTo.ClientID %>').value },
                success: function (result) {
                    data = result;
                },
                error: function (xhr, status, error) {
                    alert(error);
                }
            });

            return data;
        }

    </script>

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

    <script src="//cdnjs.cloudflare.com/ajax/libs/ladda-bootstrap/0.1.0/spin.min.js"></script> 
    <script src="//cdnjs.cloudflare.com/ajax/libs/ladda-bootstrap/0.1.0/ladda.min.js"></script> 

    <script type='text/javascript'>
        $(function () {
            $('#<%= btnRefreshSalesData.ClientID %>').click(function (e) {
                var l = Ladda.create(this);
                $('#<%= CancelButton.ClientID %>').addClass('disabled');
                $('#<%= ApplyButton.ClientID %>').addClass('disabled');
                l.start();

            });
        });

</script>

</asp:Content>
