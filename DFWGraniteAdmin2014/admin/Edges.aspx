<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Edges.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.Edges" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
    </style>    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>


<div class="panel panel-default">
  <div class="panel-heading"><h3 class="panel-title">Edges</h3></div>
  <div class="panel-body">
      <div class="row">
    <div class="col-md-6">        
        <div class="form-search">
            <div class="input-group">                
                <asp:TextBox ID="txtSearch" runat="server" onClick="this.select();" class="form-control" placeholder="Search" />
                <span class="input-group-btn">
                    <asp:LinkButton ID="btnSearch" runat="server" class="btn btn-default" OnClick="btnSearch_Click"><i class="glyphicon glyphicon-search"></i></asp:LinkButton>
                </span>
            </div>
        </div>
    </div>
</div>
   <div class="row">               
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
        <ContentTemplate>
            <div class="table-responsive">
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="EdgeId" DataSourceID="SqlDataSource1" GridLines="None" CssClass="table table-striped table-hover table-condensed" OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AllowSorting="True" OnDataBound="GridView1_DataBound" OnPreRender="GridView1_PreRender">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%#Eval("EdgeId") %>' OnClick="btnEdit_Click" Text='<%#Eval("EdgeName") %>' data-toggle="modal" data-target="#EditModal" data-backdrop="static" data-keyboard="false"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowSelectButton="true" SelectText=""  />


                    <asp:BoundField DataField="EdgeName" Visible="false" HeaderText="EdgeName" SortExpression="EdgeName" />
                    <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                    <asp:BoundField DataField="ImageFilename" HeaderText="ImageFilename" SortExpression="ImageFilename" />
                    <asp:CheckBoxField DataField="InActive" HeaderText="InActive" SortExpression="InActive" />
                </Columns>
                <PagerStyle CssClass="PagerCSS" />
            </asp:GridView>
                </div>
         </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</div>
   </div>
</div>

<asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:DFW_DB_Connection %>" SelectCommand="SELECT EdgeId, EdgeName, Price, ImageFilename, InActive FROM Edges WHERE (EdgeName LIKE '%' + @EdgeName + '%')">
    <SelectParameters>
        <asp:ControlParameter ControlID="txtSearch" Name="EdgeName" PropertyName="Text" />
    </SelectParameters>
    </asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DFW_DB_Connection %>" SelectCommand="SELECT [EdgeId], [EdgeName], [Price], [ImageFilename], [InActive] FROM [Edges]"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DFW_DB_Connection %>" DeleteCommand="DELETE FROM [Edges] WHERE [EdgeId] = @EdgeId" InsertCommand="INSERT INTO [Edges] ([EdgeName], [Price], [ImageFilename], [InActive]) VALUES (@EdgeName, @Price, @ImageFilename, @InActive)" SelectCommand="SELECT [EdgeId], [EdgeName], [Price], [ImageFilename], [InActive] FROM [Edges] WHERE ([EdgeId] = @EdgeId)" UpdateCommand="UPDATE [Edges] SET [EdgeName] = @EdgeName, [Price] = @Price, [ImageFilename] = @ImageFilename, [InActive] = @InActive WHERE [EdgeId] = @EdgeId">
        <DeleteParameters>
            <asp:Parameter Name="EdgeId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="EdgeName" Type="String" />
            <asp:Parameter Name="Price" Type="Decimal" />
            <asp:Parameter Name="ImageFilename" Type="String" />
            <asp:Parameter Name="InActive" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="EdgeId" PropertyName="SelectedValue" Type="Int32" DefaultValue="4" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="EdgeName" Type="String" />
            <asp:Parameter Name="Price" Type="Decimal" />
            <asp:Parameter Name="ImageFilename" Type="String" />
            <asp:Parameter Name="InActive" Type="Boolean" />
            <asp:Parameter Name="EdgeId" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>



                                          <asp:LinkButton ID="btnEdit" runat="server" CommandName="Select" CommandArgument='<%#Eval("EdgeId") %>' Text='<%# "Edit " + DateTime.Now.ToString("mm:ss") %>'  data-toggle="modal" data-target="#EditModal" data-backdrop="static" data-keyboard="false" OnClick="btnEdit_Click" />
  


 


        <div class="row text-center">
            <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-lg btn-success" data-toggle="modal" data-target="#InsertModal" data-backdrop="static" data-keyboard="false" >Click to open Modal</asp:LinkButton>
        </div>

        
  
<div class="modal fade" id="InsertModal" tabindex="-1" role="dialog" aria-labelledby="InsertModal" aria-hidden="true">
      <div class="modal-dialog">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="EdgeId" DataSourceID="SqlDataSource2" DefaultMode="Insert" RenderOuterTable="False" OnItemInserted="FormView1_ItemInserted">                
                <InsertItemTemplate>
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">Add New Record</h4>
          </div>
          <div class="modal-body">
              <div id="bsform" class="form-horizontal" role="form">
                <div class="form-group">
                    EdgeName:
                    <asp:TextBox ID="EdgeNameTextBox" runat="server" Text='<%# Bind("EdgeName") %>' class="form-control" />
                    <br />
                    Price:
                    <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>'  class="form-control" />
                    <br />
                    ImageFilename:
                    <asp:TextBox ID="ImageFilenameTextBox" runat="server" Text='<%# Bind("ImageFilename") %>' class="form-control" />
                    <br />
                    InActive:
                    <asp:CheckBox ID="InActiveCheckBox" runat="server" Checked='<%# Bind("InActive") %>' />
                    <br />
                    </div>
                  </div>
          </div>
          <div class="modal-footer">
                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"  class="btn btn-default" data-dismiss="modal"/>
              <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" class="btn btn-primary" />
          </div>
        </div>
                </InsertItemTemplate>                
            </asp:FormView>
      </div>
    </div>

<div class="modal fade" id="EditModal" tabindex="-1" role="dialog" aria-labelledby="EditModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Edit Record</h4>
                </div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" style="visibility:hidden;">
                    <ContentTemplate>
                        <asp:FormView ID="FormView2" runat="server" DataKeyNames="EdgeId" DataSourceID="SqlDataSource2" DefaultMode="Edit" RenderOuterTable="False" OnItemUpdated="FormView2_ItemUpdated" OnDataBound="FormView2_DataBound">
                            <EditItemTemplate>
                                <div class="modal-body">
                                    <div id="bsform" class="form-horizontal" role="form">
                                        <div class="form-group">
                                            EdgeId:
                    <asp:Label ID="EdgeIdLabel1" runat="server" Text='<%# Eval("EdgeId") %>' class="form-control" />
                                            <br />
                                            EdgeName:
                    <asp:TextBox ID="EdgeNameTextBox" runat="server" Text='<%# Bind("EdgeName") %>' class="form-control" />
                                            <br />
                                            Price:
                    <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' class="form-control" />
                                            <br />
                                            ImageFilename:
                    <asp:TextBox ID="ImageFilenameTextBox" runat="server" Text='<%# Bind("ImageFilename") %>' class="form-control" />
                                            <br />
                                            InActive:
                    <asp:CheckBox ID="InActiveCheckBox" runat="server" Checked='<%# Bind("InActive") %>' />
                                            <br />
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" class="btn btn-default" data-dismiss="modal" />
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" class="btn btn-primary" OnClientClick="hideEditModal();" />
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



</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="postformtag" runat="server">
    <script type="text/javascript">
        function hideEditModal() {
            $('#EditModal').modal('hide');
        }

        function FreezeColumn1() {
            var $table = $('.table');
            var $fixedColumn = $table.clone().insertBefore($table).addClass('fixed-column');

            //$fixedColumn.find('th:not(:first-child),td:not(:first-child)').remove();
            $fixedColumn.find('th:not(:nth-child(1)),td:not(:nth-child(1))').remove();

            $fixedColumn.find('tr').each(function (i, elem) {
                $(this).height($table.find('tr:eq(' + i + ')').height());
            });
        }

        $(window).load(function () {            

        });

        //document.ready - Best for onetime initialization.
        $(document).ready(function () {
            //$('#scroller').closest('div').attr('id','parent_div');
            $(".form-search").keypress(function (e) {
                if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
                    var div = $(".form-search");
                    var firstInput = div.find("a");
                    firstInput.click();
                    return false;
                } else {
                    return true;
                }
            });
        });


    </script>

    <script type="text/JavaScript">
        //pageLoad() - Best to re-attach the functionality to elements/controls of the page affected by partial postbacks with UpdatePanel.
        function pageLoad() {
            var manager = Sys.WebForms.PageRequestManager.getInstance();
            manager.add_endRequest(endRequest);
            manager.add_beginRequest(OnBeginRequest);
            FreezeColumn1();
        }
        function OnBeginRequest(sender, args) {
            //$get('ParentDiv').className = 'Background';
            $get('<%= this.UpdatePanel2.ClientID %>').style.visibility = "hidden";
            }
            function endRequest(sender, args) {
                //$get('ParentDiv').className = '';
                $get('<%= this.UpdatePanel2.ClientID %>').style.visibility = "visible";
        }
    </script>

</asp:Content>


