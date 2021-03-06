﻿<%@ Page Title="Sales Report by Date" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="sales-report-date.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.sales_report_date" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <script type="text/javascript" src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
        <link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />

    <style> 
        tfoot > tr > td {font-weight:bold; } 
        tfoot > tr > td.month-footer {font-style:italic;text-align:right;}
        .control-padding {
            padding-top: 3px;
            padding-bottom: 4px;
        }
    </style>

    <!--Fix Firefox and fieldsets issues-->
    <style>
        @-moz-document url-prefix() {
          fieldset { display: table-cell; }
        }
    </style>

    <script type="text/javascript">
            $(function () {
                $("#<%= txtDateFrom.ClientID %>").datepicker();
                $("#<%= txtDateTo.ClientID  %>").datepicker();
            });

            function disablePrint() {
                document.getElementById('<% =btnPrint.ClientID %>').style.visibility = "hidden";
            }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="print-only text-center">
        <strong>DFW WHOLESALE GRANITE</strong><br /><em>10011 Harmon Road #101, Fort Worth, TX 76177</em>
        <h3>Sales Report by Date</h3>
    </div>

    <div class="panel panel-info print-not">
        <div class="panel-heading">
            <h3 class="panel-title">Sales Report</h3>            
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-9">
                    <div class="col-sm-3 control-padding">
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" class="form-control">
                            <asp:ListItem Value="Date">by Date</asp:ListItem>
                            <asp:ListItem Value="Monthly">by Month</asp:ListItem>
                            <asp:ListItem Value="Yearly">by Year</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="clearfix visible-xs-block"></div>
                    <div class="col-xs-6 col-sm-3 control-padding">
                        <asp:TextBox ID="txtDateFrom" runat="server" onchange="disablePrint();" class="date-picker form-control"></asp:TextBox>
                    </div>
                    <div class="col-xs-6 col-sm-3 control-padding">
                        <asp:TextBox ID="txtDateTo" runat="server" onchange="disablePrint();" class="date-picker form-control"></asp:TextBox>
                    </div>
                    <div class="clearfix visible-xs-block"></div>
                    <div class="col-xs-6 col-sm-3 control-padding">
                        <asp:Button ID="Button1" runat="server" Text="Go" class="btn btn-success" />
                        <asp:Button ID="btnPrint" runat="server" Text="Print" OnClientClick="window.print();" class="btn btn-inverse" />
                    </div>
                </div>
            </div>
        </div>
    </div>


<div class="table-responsive">
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  DataSourceID="SqlDataSource1" OnRowDataBound="GridView1_RowDataBound" ShowFooter="True" GridLines="None" CssClass="table table-striped table-hover table-condensed" OnPreRender="GridView1_PreRender">
            <Columns>
                <asp:BoundField DataField="OnlineQuoteID" HeaderText="OnlineQuoteID" InsertVisible="False" SortExpression="OnlineQuoteID" Visible="False" />
                <asp:BoundField DataField="CustomerName" HeaderText="CUSTOMER" SortExpression="CustomerName" ItemStyle-CssClass="text-nowrap" />
                <asp:BoundField DataField="Lead" HeaderText="LEAD" SortExpression="Lead" FooterStyle-CssClass="text-right" />
                <asp:BoundField DataField="InstallDate" HeaderText="DATE" SortExpression="InstallDate" DataFormatString="{0:d}" HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-nowrap month-footer"/>
                <asp:BoundField DataField="Total_SF" HeaderText="SF" SortExpression="Total_SF" DataFormatString="{0:0.00}" HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right"  />
                <asp:BoundField DataField="TotalSales" HeaderText="SALES" SortExpression="TotalSales" DataFormatString="{0:#,0.00}" HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right"  />
                <asp:BoundField DataField="TotalGranite" HeaderText="GRANITE" SortExpression="TotalGranite" DataFormatString="{0:#,0.00}" HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right"  />
                <asp:BoundField DataField="TotalWorkOrder" HeaderText="WORK ORDER" SortExpression="TotalWorkOrder" DataFormatString="{0:#,0.00}" HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right"  />
                <asp:BoundField DataField="TotalGrossProfit" HeaderText="GROSS PROFIT" SortExpression="TotalGrossProfit" DataFormatString="{0:#,0.00}"  HeaderStyle-CssClass="text-right" ItemStyle-CssClass="text-right" FooterStyle-CssClass="text-right" />
            </Columns>
            <EmptyDataTemplate>
                <span class="alert alert-error" style="color:red;font-style:italic;">
                    <a href="#" class="close" data-dismiss="alert">&times;</a>
                    <strong>Oops!</strong> Sorry. We do not have sales information on date specified. Please try other dates.
                </span>
            </EmptyDataTemplate>
        </asp:GridView>
</div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True" ProviderName="System.Data.OleDb" SelectCommand="SELECT DISTINCT OnlineQuoteID, CustomerName, Lead, TotalSF AS Total_SF, TotalJob AS TotalSales, IIF(ISNULL(TotSlabsSum), 0, TotSlabsSum) AS TotalGranite, IIF(ISNULL(WorkOrderSum), 0, WorkOrderSum) AS TotalWorkOrder, IIF(ISNULL(TotalSales - GrossProfit), 0, TotalSales - GrossProfit) AS TotalGrossProfit, InstallDate FROM SalesTotalJobsTbl WHERE (InstallDate BETWEEN ? AND ?) ORDER BY InstallDate">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtDateFrom" DbType="Date" Name="DateFrom" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtDateTo" DbType="Date" Name="DateTo" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="postformtag" runat="server">
</asp:Content>
