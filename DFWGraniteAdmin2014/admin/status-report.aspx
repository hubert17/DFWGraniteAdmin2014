<%@ Page Title="Task Status Report" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="status-report.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.status_report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        @media print {
            a[href]:after {
                display: none;
            }
        }
    </style>

        <script type="text/javascript">
            function doneyet() {
                document.body.onmousemove = "";
                window.location.reload();
            }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="print-only text-center">
        <strong>DFW WHOLESALE GRANITE</strong><br /><em>10011 Harmon Road #101, Fort Worth, TX 76177</em>
        <h3>Task Report</h3>
        <h4><asp:Literal ID="RecentJobByLabel" runat="server" >by Zip</asp:Literal>
            <span runat="server" id="SpanCategory" ><asp:Literal ID="CategoryLabel" runat="server" ></asp:Literal></span>
            </h4>
    </div>

<div class="panel panel-info print-not">
        <div class="panel-heading">
            <h2 class="panel-title">Task Report</h2>            
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-2">
                <p>
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" class="form-control">
                        <asp:ListItem Value="StatusNz">by Task</asp:ListItem>
                        <asp:ListItem Value="SalesManNameNz">by Assignment</asp:ListItem>
                        <asp:ListItem Value="InstallDate">Install</asp:ListItem>
                        <asp:ListItem Value="Measure">Measure</asp:ListItem>
                        <asp:ListItem Value="Quote">Quote</asp:ListItem>
                        <asp:ListItem Value="Template">Template</asp:ListItem>
                        <asp:ListItem Value="Repair">Repair</asp:ListItem>
                        <asp:ListItem Value="Cabinets">Cabinets</asp:ListItem>
                    </asp:DropDownList>
                </p>
                </div>
                <div class="col-md-2">
                <p>
                    <asp:DropDownList ID="DropDownStatus" runat="server" DataSourceID="SqlDataSource2" DataTextField="Status" DataValueField="StatusID" OnSelectedIndexChanged="DropDownStatus_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="true" class="form-control">
                        <asp:ListItem Value="sa">Show All</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DFWGraniteDBConnectionString %>" ProviderName="<%$ ConnectionStrings:DFWGraniteDBConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT StatusID, Status FROM tblStatus WHERE (StatusID = 1) OR (StatusID = 2) OR (StatusID = 6) OR (StatusID = 4) OR (StatusID = 3) OR (StatusID = 10) OR (StatusID = 11)"></asp:SqlDataSource>
                    <asp:DropDownList ID="DropDownSalesMan" runat="server" style="width:100%;" DataSourceID="SqlDataSource4" DataTextField="SalesManName" DataValueField="SalesManID" OnSelectedIndexChanged="DropDownSalesMan_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="True" class="form-control">
                        <asp:ListItem Value="sa">Show All</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DFWGraniteDBConnectionString %>" ProviderName="<%$ ConnectionStrings:DFWGraniteDBConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT tblOnlineQuotes.SalesManID, tblSalesMen.SalesManName FROM (tblSalesMen LEFT OUTER JOIN tblOnlineQuotes ON tblSalesMen.SalesManID = tblOnlineQuotes.SalesManID)"></asp:SqlDataSource>

                </p>  
                </div>
                <div class="col-md-2 text-left">
                <p>
                    <asp:Button ID="btnPrint" runat="server" Text="Print" OnClientClick="window.print();document.body.onmousemove = doneyet;" class="btn btn-inverse" />
                </p>
                </div>
            </div>
            
        </div>
    </div>

<div class="table-responsive">
    <asp:GridView ID="GridView1"  runat="server" DataKeyNames="OnlineQuoteID" AutoGenerateColumns="False"  DataSourceID="SqlDataSource1" GridLines="None" CssClass="table table-hover table-condensed" OnPreRender="GridView1_PreRender" OnRowDataBound="GridView1_RowDataBound">            
            <Columns>
                <asp:BoundField DataField="TaskDate" HeaderText="DATE" ItemStyle-CssClass="text-nowrap" >
<ItemStyle CssClass="text-nowrap"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="TaskTimeIns" HeaderText="TIME" ItemStyle-CssClass="text-left text-nowrap" />
                <asp:BoundField DataField="Status" HeaderText="STATUS" Visible="False" ItemStyle-CssClass="text-nowrap" >
<ItemStyle CssClass="text-nowrap"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="SalesManName" HeaderText="ASS" ItemStyle-CssClass="text-nowrap" >
<ItemStyle CssClass="text-nowrap"></ItemStyle>
                </asp:BoundField>
                <asp:HyperLinkField DataNavigateUrlFields="OnlineQuoteID" DataNavigateUrlFormatString="/admin/EditJob.aspx?OnlineQuoteID={0}" DataTextField="OnlineQuoteID" HeaderText="JOB #" HeaderStyle-CssClass="text-nowrap" Target="_blank" >
<HeaderStyle CssClass="text-nowrap"></HeaderStyle>
                </asp:HyperLinkField>
                <asp:BoundField DataField="CustomerName" HeaderText="CUSTOMER" ItemStyle-CssClass="text-nowrap" HtmlEncode="False" >
<ItemStyle CssClass="text-nowrap"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="Phone" HeaderText="PHONE"   >                    
                </asp:BoundField>
                <asp:BoundField HeaderText="SINK" />
                 <asp:BoundField DataField="SquareFeetQty" HeaderText="SF" DataFormatString="{0:0.###}" />

                <asp:BoundField DataField="EdgeName" HeaderText="EDGE" ItemStyle-CssClass="text-nowrap" >
<ItemStyle CssClass="text-nowrap"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="SlabColor" HeaderText="GRANITE"  />
                <asp:BoundField DataField="StatusNz" HeaderText="STATUSnz" Visible="False" />
                <asp:BoundField DataField="SalesManNameNz" HeaderText="SALESMAN" Visible="False" />

            </Columns>
            <EmptyDataTemplate>
                <span class="alert alert-error" style="color:red;font-style:italic;">
                    <a href="#" class="close" data-dismiss="alert">&times;</a>
                    <strong>Oops!</strong> Sorry. We do not have a task on the status you specified.
                </span>
            </EmptyDataTemplate>


        </asp:GridView>
</div>



        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True" ProviderName="System.Data.OleDb" SelectCommand="SELECT OnlineQuoteID, iif(HasDeposited = 'D', CustomerFirstName + ' ' + CustomerLastName + '&lt;sup&gt;[&lt;/sup&gt;*&lt;sup&gt;]&lt;/sup&gt;', iif(HasDeposited = 'DV', CustomerFirstName + ' ' + CustomerLastName + '&lt;sup&gt;[&lt;/sup&gt;*&lt;sup&gt;v]&lt;/sup&gt;&lt;/sup&gt;', iif(HasDeposited = 'F', CustomerFirstName + ' ' + CustomerLastName + '&lt;sup&gt;[&lt;/sup&gt;&lt;sup&gt;F]&lt;/sup&gt;&lt;/sup&gt;', CustomerFirstName + ' ' + CustomerLastName))) AS CustomerName, Phone, StatusID, Status, iif(isnull(StatusID), 'Unknown Status', Status) AS StatusNz, EdgeName, SlabColor, SquareFeetQty, InstallDate, Format(TaskDateIns, 'Medium Date') AS TaskDate, TaskTimeIns, SalesManID, SalesManName, iif(isnull(SalesManID), 'No Salesman', SalesManName) AS SalesManNameNz, HasDeposited FROM StatusReportQry WHERE (StatusID = 1) OR (StatusID = 2) OR (StatusID = 6) OR (StatusID = 4) OR (StatusID = 3) OR (StatusID = 10) OR (StatusID = 11)">
        </asp:SqlDataSource>
 
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString8 %>" ProviderName="System.Data.OleDb" SelectCommand="SELECT OnlineQuoteID,  iif(HasDeposited = 'D', CustomerFirstName + ' ' + CustomerLastName + '&lt;sup&gt;[&lt;/sup&gt;*&lt;sup&gt;]&lt;/sup&gt;', iif(HasDeposited = 'DV', CustomerFirstName + ' ' + CustomerLastName + '&lt;sup&gt;[&lt;/sup&gt;*&lt;sup&gt;v]&lt;/sup&gt;&lt;/sup&gt;', CustomerFirstName + ' ' + CustomerLastName))  AS CustomerName, Phone, StatusID, Status, iif(isnull(StatusID), 'Unknown Status', Status) AS StatusNz, EdgeName, SlabColor, SquareFeetQty, InstallDate, Format(TaskDateIns, 'Medium Date') AS TaskDate, TaskTimeIns, SalesManID, SalesManName, iif(isnull(SalesManID), 'No Salesman', SalesManName) AS SalesManNameNz FROM StatusReportQry WHERE (StatusID = ?) ORDER BY TaskDateIns">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownStatus" Name="?" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString8 %>" ProviderName="System.Data.OleDb" SelectCommand="SELECT OnlineQuoteID, iif(HasDeposited = 'D', CustomerFirstName + ' ' + CustomerLastName + '&lt;sup&gt;[&lt;/sup&gt;*&lt;sup&gt;]&lt;/sup&gt;', iif(HasDeposited = 'DV', CustomerFirstName + ' ' + CustomerLastName + '&lt;sup&gt;[&lt;/sup&gt;*&lt;sup&gt;v]&lt;/sup&gt;&lt;/sup&gt;', CustomerFirstName + ' ' + CustomerLastName))  AS CustomerName, Phone, StatusID, Status, iif(isnull(StatusID), 'Unknown Status', Status) AS StatusNz, EdgeName, SlabColor, InstallDate, Format(TaskDateIns, 'Medium Date') AS TaskDate, TaskTimeIns, SalesManID, SalesManName, iif(isnull(SalesManID), 'No Salesman', SalesManName) AS SalesManNameNz FROM StatusReportQry WHERE (SalesManID = ?) AND (StatusID = 1 OR StatusID = 2 OR StatusID = 6 OR StatusID = 4 OR StatusID = 3 OR StatusID = 10 OR StatusID = 11) ORDER BY TaskDateIns">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownSalesMan" Name="?" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="postformtag" runat="server">
</asp:Content>
