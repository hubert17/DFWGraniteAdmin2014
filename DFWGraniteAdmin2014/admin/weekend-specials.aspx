<%@ Page Title="Weekend Specials" Language="C#" MasterPageFile="~/Site.master" UnobtrusiveValidationMode="None" AutoEventWireup="true" CodeBehind="weekend-specials.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.weekend_specials" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-horizontal {
            padding-left:15px;
            padding-right:15px;
        }
    </style>
    <style type='text/css'>
        .table-responsive > div > .fixed-column {
            position: absolute;
            display:inline-block;
            width: auto;
            border-right: 1px solid #ddd;
            background-color: #fff;
        }
        .table td {
            white-space: nowrap;
        }
        @media(min-width:768px) {
            .table-responsive > div > .fixed-column {
                display: inline-block;
            }
            .table-responsive > div{padding:0px;margin:0px;}
        }
        .clsDatePicker {
            z-index: 100000 !important;
        }
    </style>
    <script type='text/javascript'>
        $(function () {
            $("#<%= FormView1.FindControl("ScheduleDateFromTextBox").ClientID %>").datepicker();
            $("#<%= FormView1.FindControl("ScheduleDateToTextBox").ClientID  %>").datepicker();
            $("#<%= FormView2.FindControl("ScheduleDateFromTextBox").ClientID %>").datepicker();
            $("#<%= FormView2.FindControl("ScheduleDateToTextBox").ClientID  %>").datepicker();

            // Since confModal is essentially a nested modal it's enforceFocus method
            // must be no-op'd or the following error results 
            // "Uncaught RangeError: Maximum call stack size exceeded"
            // But then when the nested modal is hidden we reset modal.enforceFocus
            var enforceModalFocusFn = $.fn.modal.Constructor.prototype.enforceFocus;

            $.fn.modal.Constructor.prototype.enforceFocus = function () { };

            $confModal.on('hidden', function () {
                $.fn.modal.Constructor.prototype.enforceFocus = enforceModalFocusFn;
            });

            $confModal.modal({ backdrop: false });
        });

</script>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
        <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>

    <div class="row col-lg-12">
            <h3 class="page-header" style="margin-top:5px;" >Weekend Specials</h3>
    </div>  

<div class="row col-lg-12">               
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
        <ContentTemplate>
            <div class="table-responsive">
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TickerTextID" DataSourceID="SqlDataSource1" GridLines="None" CssClass="table table-striped table-hover table-condensed" OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnDataBound="GridView1_DataBound" OnPreRender="GridView1_PreRender">
                <Columns>
                                                            
                    <asp:TemplateField HeaderText="TICKER TEXT">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%#Eval("TickerTextID") %>' OnClick="btnEdit_Click" Text='<%#Eval("TickerText") %>' data-toggle="modal" data-target="#EditModal" data-backdrop="static" data-keyboard="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowSelectButton="True" SelectText="" />
                    <asp:TemplateField HeaderText="NAVIGATE LINK">
                        <ItemTemplate>
                            <asp:TextBox ID="TickerLink" runat="server" Text='<%#Eval("TickerLink") %>' ReadOnly="true"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="TickerGroup" HeaderText="GROUP" SortExpression="TickerGroup" />
                    <asp:BoundField DataField="Display" HeaderText="DISPLAY" SortExpression="Display" />
                    <asp:BoundField DataField="ScheduleDateFrom" HeaderText="DATE FROM" SortExpression="ScheduleDateFrom" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="ScheduleDateTo" HeaderText="DATE TO" SortExpression="ScheduleDateTo" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="OrderSequence" HeaderText="SEQUENCE" SortExpression="OrderSequence"  />
                    
                </Columns>
                <PagerStyle CssClass="PagerCSS" />
            </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ProviderName="System.Data.OleDb" SelectCommand="SELECT [TickerTextID], [TickerText], [TickerLink], [TickerGroup], [Display], [ScheduleDateFrom], [ScheduleDateTo], [OrderSequence], [Archived] FROM [tblTickerText] WHERE ([Archived] = ?)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="False" Name="Archived" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>                                
                </div>
         </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>
</div>

    <div class="row col-lg-12">
            <asp:FormView ID="FormView3" runat="server" DataKeyNames="ID" RenderOuterTable="false" DataSourceID="SqlDataSource3" DefaultMode="Edit">
                <EditItemTemplate>
                             <div class="col-xs-3">
                            <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-success" data-toggle="modal" data-target="#InsertModal" data-backdrop="static" data-keyboard="false">Add Ticker Text</asp:LinkButton>                  
                                </div>

                                <div class="col-xs-5 pull-right"><label class="pull-right visible-print"><asp:CheckBox ID="ShowWeekendSpecialsCheckBox" runat="server" Checked='<%# Bind("ShowWeekendSpecials") %>' OnCheckedChanged="ShowWeekendSpecialsCheckBox_CheckedChanged" AutoPostBack="True" /> Show Weekend Specials</label></div>

                </EditItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True"  ProviderName="System.Data.OleDb" SelectCommand="SELECT ID, ShowWeekendSpecials FROM tblSETTINGS WHERE (ID = 1)" UpdateCommand="UPDATE tblSETTINGS SET ShowWeekendSpecials = ? WHERE (ID = 1)">
                <UpdateParameters>
                    <asp:Parameter Name="ShowWeekendSpecials" Type="Boolean" />
                </UpdateParameters>
            </asp:SqlDataSource>

    </div>


    

<div class="modal fade" id="InsertModal" tabindex="-1" role="dialog" aria-labelledby="InsertModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel2">Add New Weekend Specials</h4>
                </div>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server" >
                    <ContentTemplate>
 <asp:FormView ID="FormView1" runat="server" DataKeyNames="TickerTextID" DataSourceID="SqlDataSource2" DefaultMode="Insert" RenderOuterTable="False" OnItemInserted="FormView1_ItemInserted">                
                <InsertItemTemplate>
          
          <div class="modal-body">
                  <asp:RequiredFieldValidator Display="Dynamic"  runat="server" ControlToValidate="TickerTextTextBoxInsert" ValidationGroup="vg1">
                  <div class="alert alert-danger col-sm-12">The Ticker Text is required and cannot be empty.</div>
                  </asp:RequiredFieldValidator>
              <div id="bsform1" class="form-horizontal" role="form">

                <div class="form-group">
                    Text:
                    <asp:TextBox ID="TickerTextTextBoxInsert" runat="server" Text='<%# Bind("TickerText") %>' class="form-control" />
                    <br />
                    Link:
                    <asp:TextBox ID="TickerLinkTextBox" runat="server" Text='<%# Bind("TickerLink") %>'  class="form-control" />
                    <br />
                    Group:
                    <asp:TextBox ID="TickerGroupTextBox" runat="server" Text='<%# Bind("TickerGroup") %>' class="form-control" />
                    <br />
                    Display?:
                    <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("Display") %>' class="form-control" >
                            <asp:ListItem Selected="True" Value="Now">Now</asp:ListItem><asp:ListItem>Sched</asp:ListItem></asp:DropDownList>
                    <br />
                    Date: 
<div class="input-daterange input-group" id="datepicker">
                        <span class="input-group-addon">From</span>
                        <asp:TextBox ID="ScheduleDateFromTextBox" runat="server" Text='<%# Bind("ScheduleDateFrom","{0:MMM/dd/yy}") %>' class="form-control clsDatePicker" ReadOnly="true" />
                        <span class="input-group-addon">To</span>
                        <asp:TextBox ID="ScheduleDateToTextBox" runat="server" Text='<%# Bind("ScheduleDateTo","{0:MMM/dd/yy}") %>' class="form-control clsDatePicker" ReadOnly="true" />
                    </div>                    <br />
                    Order Sequence:
                    <asp:TextBox ID="OrderSequenceTextBox" runat="server" Text='<%# Bind("OrderSequence") %>' class="form-control"   />
                    </div>
                  </div>
          </div>
          <div class="modal-footer">
                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"  class="btn btn-default" data-dismiss="modal"/>
              <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" ValidationGroup="vg1" CommandName="Insert" Text="Insert" class="btn btn-primary" />
          </div>
                </InsertItemTemplate>                
            </asp:FormView>                       
                    </ContentTemplate>
                    <Triggers>
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>


<div class="modal fade" id="EditModal" tabindex="-1" role="dialog" aria-labelledby="EditModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Edit Weekend Specials</h4>
                </div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" style="visibility:hidden;">
                    <ContentTemplate>
<asp:FormView ID="FormView2" runat="server" DataKeyNames="TickerTextID" DataSourceID="SqlDataSource2" DefaultMode="Edit" RenderOuterTable="False" OnItemUpdated="FormView2_ItemUpdated" OnDataBound="FormView2_DataBound">
                            <EditItemTemplate>
                                <div class="modal-body">
                                    <asp:RequiredFieldValidator Display="Dynamic" runat="server" ControlToValidate="TickerTextTextBoxEdit" ValidationGroup="vg2">
                                        <div class="alert alert-danger col-sm-12">The Ticker Text is required and cannot be empty.</div>
                                    </asp:RequiredFieldValidator>
                                    <div id="bsform2" class="form-horizontal" role="form">
                                        <div class="form-group">
                    Text:
                    <asp:TextBox ID="TickerTextTextBoxEdit" runat="server" Text='<%# Bind("TickerText") %>' class="form-control" />
                    <br />
                    Link:
                    <asp:TextBox ID="TickerLinkTextBox" runat="server" Text='<%# Bind("TickerLink") %>'  class="form-control" />
                    <br />
                    Group:
                    <asp:TextBox ID="TickerGroupTextBox" runat="server" Text='<%# Bind("TickerGroup") %>' class="form-control" />
                    <br />
                    Display:
                    <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("Display") %>' class="form-control" >
                            <asp:ListItem Selected="True" Value="Now">Now</asp:ListItem><asp:ListItem>Sched</asp:ListItem></asp:DropDownList>
                    <br />
                    Date: 
                    <div class="input-daterange input-group" id="datepicker">
                        <span class="input-group-addon">From</span>
                        <asp:TextBox ID="ScheduleDateFromTextBox" runat="server" Text='<%# Bind("ScheduleDateFrom","{0:MMM/dd/yy}") %>' class="form-control clsDatePicker" ReadOnly="true" />
                        <span class="input-group-addon">To</span>
                        <asp:TextBox ID="ScheduleDateToTextBox" runat="server" Text='<%# Bind("ScheduleDateTo","{0:MMM/dd/yy}") %>' class="form-control clsDatePicker" ReadOnly="true" />
                    </div>

                    <br />
                    Order Sequence:
                    <asp:TextBox ID="OrderSequenceTextBox" runat="server" Text='<%# Bind("OrderSequence") %>' class="form-control"   />
                    <br />
                    <label><asp:CheckBox ID="TextBox1" runat="server" Checked='<%# Bind("Archived") %>' /> Archive</label>

                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" class="btn btn-default" data-dismiss="modal" >Cancel</asp:LinkButton>
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True"  ValidationGroup="vg2" CommandName="Update" Text="Update" class="btn btn-primary" OnClientClick="hideEditModal();" />
                                </div>
                            </EditItemTemplate>
                        </asp:FormView>                        
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>




<asp:SqlDataSource ID="SqlDataSource2" runat="server" DeleteCommand="DELETE FROM [tblTickerText] WHERE [TickerTextID] = ?" InsertCommand="INSERT INTO [tblTickerText] ([TickerText], [TickerLink], [TickerGroup], [Display], [ScheduleDateFrom], [ScheduleDateTo], [OrderSequence]) VALUES (?, ?, ?, ?, ?, ?, ?)" ProviderName="System.Data.OleDb" SelectCommand="SELECT [TickerTextID], [TickerText], [TickerLink], [TickerGroup], [Display], [ScheduleDateFrom], [ScheduleDateTo], [OrderSequence], [Archived] FROM [tblTickerText] WHERE ([TickerTextID] = ?)" UpdateCommand="UPDATE [tblTickerText] SET [TickerText] = ?, [TickerLink] = ?, [TickerGroup] = ?, [Display] = ?, [ScheduleDateFrom] = ?, [ScheduleDateTo] = ?, [OrderSequence] = ?, [Archived] = ? WHERE [TickerTextID] = ?" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True">
                    <DeleteParameters>
                        <asp:Parameter Name="TickerTextID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TickerText" Type="String" />
                        <asp:Parameter Name="TickerLink" Type="String" />
                        <asp:Parameter Name="TickerGroup" Type="String" />
                        <asp:Parameter Name="Display" Type="String" />
                        <asp:Parameter Name="ScheduleDateFrom" Type="DateTime" />
                        <asp:Parameter Name="ScheduleDateTo" Type="DateTime" />
                        <asp:Parameter Name="OrderSequence" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="TickerTextID" PropertyName="SelectedValue" Type="Int32" DefaultValue="10" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TickerText" Type="String" />
                        <asp:Parameter Name="TickerLink" Type="String" />
                        <asp:Parameter Name="TickerGroup" Type="String" />
                        <asp:Parameter Name="Display" Type="String" />
                        <asp:Parameter Name="ScheduleDateFrom" Type="DateTime" />
                        <asp:Parameter Name="ScheduleDateTo" Type="DateTime" />
                        <asp:Parameter Name="OrderSequence" Type="Int32" />
                        <asp:Parameter Name="Archived" Type="Boolean" />
                        <asp:Parameter Name="TickerTextID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>

    </asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="postformtag" runat="server">
    <script type="text/javascript">
        hideEditModal = function () {
            $('#EditModal').modal('hide');
        }
        hideInsertModal = function () {
            $('#InsertModal').modal('hide');
        }

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

    <script type="text/JavaScript">
        //pageLoad() - Best to re-attach the functionality to elements/controls of the page affected by partial postbacks with UpdatePanel.
        function pageLoad() {
            var manager = Sys.WebForms.PageRequestManager.getInstance();
            manager.add_endRequest(endRequest);
            manager.add_beginRequest(OnBeginRequest);
        }
        function OnBeginRequest(sender, args) {
            //$get('ParentDiv').className = 'Background';
            $get('<%= this.UpdatePanel2.ClientID %>').style.visibility = "hidden";
        }
        function endRequest(sender, args) {
            //$get('ParentDiv').className = '';
            $get('<%= this.UpdatePanel2.ClientID %>').style.visibility = "visible";
            $("#<%= FormView1.FindControl("ScheduleDateFromTextBox").ClientID %>").datepicker();
            $("#<%= FormView1.FindControl("ScheduleDateToTextBox").ClientID  %>").datepicker();
            $("#<%= FormView2.FindControl("ScheduleDateFromTextBox").ClientID %>").datepicker();
            $("#<%= FormView2.FindControl("ScheduleDateToTextBox").ClientID  %>").datepicker();

        }
    </script>

</asp:Content>

