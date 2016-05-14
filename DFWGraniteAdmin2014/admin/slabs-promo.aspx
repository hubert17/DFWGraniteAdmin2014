<%@ Page Title="Manage Slab Promo" Language="C#" MasterPageFile="~/Site.master" UnobtrusiveValidationMode="None"  AutoEventWireup="true" CodeBehind="slabs-promo.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.slabs_promo" %>
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
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:FormView ID="FormView4" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourcePromoLabel" RenderOuterTable="False" DefaultMode="Edit" OnItemUpdated="FormView4_ItemUpdated">
                    <EditItemTemplate>
                            <h3 class="page-header" style="margin-top:5px;">
                                <asp:TextBox ID="SlabPromoLabelTextBox" runat="server" Text='<%# Bind("SlabPromoLabel") %>' Width="70%" BorderStyle="None" />
                                <span class="pull-right"><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" CssClass="btn btn-success" ToolTip="Update Slab Promo Label and Description">Update<span class="hidden-xs"> Promo Label</span></asp:LinkButton></span>
                            </h3>
                        <h4 class="page-header" style="margin-top:5px;" ><asp:TextBox ID="SlabPromoDescTextBox" runat="server" Text='<%# Bind("SlabPromoDesc") %>' Width="100%" BorderStyle="None" /></h4>
                        <asp:Label ID="IDLabel1" runat="server" Visible="false" Text='<%# Eval("ID") %>' />                
                    </EditItemTemplate>
                </asp:FormView>
            </ContentTemplate>
        </asp:UpdatePanel>

            <asp:SqlDataSource ID="SqlDataSourcePromoLabel" runat="server" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True" DeleteCommand="DELETE FROM [tblSETTINGS] WHERE [ID] = ?" InsertCommand="INSERT INTO [tblSETTINGS] ([ID], [SlabPromoLabel], [SlabPromoDesc]) VALUES (?, ?, ?)" ProviderName="System.Data.OleDb" SelectCommand="SELECT [ID], [SlabPromoLabel], [SlabPromoDesc] FROM [tblSETTINGS]" UpdateCommand="UPDATE [tblSETTINGS] SET [SlabPromoLabel] = ?, [SlabPromoDesc] = ? WHERE [ID] = ?">
                <UpdateParameters>
                    <asp:Parameter Name="SlabPromoLabel" Type="String" />
                    <asp:Parameter Name="SlabPromoDesc" Type="String" />
                    <asp:Parameter Name="ID" Type="Int32" />
                </UpdateParameters>
        </asp:SqlDataSource>
    </div>  

<div class="row col-lg-12">               
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
        <ContentTemplate>
            <div class="table-responsive">
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="SlabPromoID" GridLines="None" CssClass="table table-striped table-hover table-condensed" OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnDataBound="GridView1_DataBound" OnPreRender="GridView1_PreRender" >
                <Columns>
                    
                    <asp:TemplateField HeaderText="SLAB ON PROMO">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%#Eval("SlabPromoID") %>' OnClick="btnEdit_Click" Text='<%#Eval("SlabColor") %>' data-toggle="modal" data-target="#EditModal" data-backdrop="static" data-keyboard="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowSelectButton="True" SelectText="" />                    
                    <asp:TemplateField HeaderText="LOT #">
                        <ItemTemplate>
                            <a data-id='<%#Eval("SlabColorID") %>' data-promoid='<%#Eval("SlabPromoID") %>' title="Click to view Remnants for <%#Eval("SlabColor") %> slab" class="open-RemnantModal" data-toggle="modal" href="#RemnantModal" data-keyboard="false" ><%#Eval("LotNo") %></a>
                        </ItemTemplate>
                    </asp:TemplateField>                    
                    <asp:BoundField DataField="SlabPromoPrice" HeaderText="PRICE" SortExpression="SlabPromoPrice"  DataFormatString="{0:c}" ItemStyle-CssClass="text-right" HeaderStyle-CssClass="text-right" />
                    <asp:BoundField DataField="SlabLength" HeaderText="LENGTH" SortExpression="SlabLength" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />                    
                    <asp:BoundField DataField="SlabWidth" HeaderText="WIDTH" SortExpression="SlabWidth" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
                    <asp:BoundField DataField="SlabOnHand" HeaderText="INVENTORY" SortExpression="SlabOnHand" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" DataFormatString="{0:0.00}" />
                    <asp:TemplateField HeaderText="PICTURE">
                        <ItemTemplate>
                            <a data-id='<%#Eval("SlabColorID") %>' class="btn btn-xs btn-info open-uploadImageModal" data-toggle="modal" href="#uploadImageModal" data-backdrop="static" data-keyboard="false" >Upload</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PROMOTIONAL NOTES">
                        <ItemTemplate>
                            <asp:TextBox ID="SlabPromoNotes" runat="server" Text='<%#Eval("SlabPromoNotes") %>' ReadOnly="true" ToolTip='<%#Eval("SlabPromoNotes") %>' ></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CheckBoxField DataField="Inactive" HeaderText="INACTIVE?" SortExpression="Inactive" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
                                        
                                        
                </Columns>
                <PagerStyle CssClass="PagerCSS" />
            </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ProviderName="System.Data.OleDb" SelectCommand="SELECT SlabPromoID, SlabColorID, SlabColor, iif(isnull(LotNo), 'n/a', LotNo) AS LotNo, SlabPromoPrice, SlabLength, SlabWidth, SlabOnHand, SlabPromoNotes, Inactive FROM SlabPromoQry WHERE (Inactive = false)" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True">
                </asp:SqlDataSource>                                
                </div>
         </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="FormView2" EventName="ItemDeleted" />
        </Triggers>        
    </asp:UpdatePanel>
</div>

    <asp:HiddenField ID="hfShowAllSlab" runat="server" Value="SELECT SlabPromoID, SlabColorID, SlabColor, iif(isnull(LotNo), 'n/a', LotNo) AS LotNo, SlabPromoPrice, SlabLength, SlabWidth, SlabOnHand, SlabPromoNotes, Inactive FROM SlabPromoQry" />

    <div class="row col-lg-12" style="margin-bottom:25px;padding-left:0px;">
                             <div class="col-xs-3">
                            <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-success" data-toggle="modal" data-target="#InsertModal" data-backdrop="static" data-keyboard="false">Add Slab Promo</asp:LinkButton>                  
                                </div>
        <div class="col-xs-3 pull-right">
            <span class="pull-right"><asp:CheckBox ID="chkInactive" runat="server" OnCheckedChanged="chkInactive_CheckedChanged" Checked="false" AutoPostBack="True" /> Show Inactive</span>
        </div>
            <asp:FormView ID="FormView3" runat="server" DataKeyNames="ID" RenderOuterTable="false" DataSourceID="SqlDataSource3" DefaultMode="Edit">
                <EditItemTemplate>
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
                    <h4 class="modal-title" id="myModalLabel2">ADD NEW SLAB PROMO</h4>
                </div>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server" >
                    <ContentTemplate>
 <asp:FormView ID="FormView1" runat="server" DataKeyNames="SlabPromoID" DataSourceID="SqlDataSource2" DefaultMode="Insert" RenderOuterTable="False" OnItemInserted="FormView1_ItemInserted">                
                <InsertItemTemplate>
          
          <div class="modal-body">
              <div id="bsform1" class="form-horizontal" role="form">

                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-8">
                            Slab On Promo:
                            <asp:DropDownList ID="SlabColorIDDropDownList" runat="server" SelectedValue='<%# Bind("SlabColorID") %>' DataSourceID="SqlDataSourceSlabNames" DataTextField="SlabColorName" DataValueField="SlabColorID" AppendDataBoundItems="true" class="form-control">
                                <asp:ListItem Value=""></asp:ListItem>
                            </asp:DropDownList>        
                        </div>
                        <div class="col-xs-4">
                            <span class="hidden-xs">Promo </span>Price:
                            <asp:TextBox ID="SlabPromoPriceTextBox" runat="server" Text='<%# Bind("SlabPromoPrice") %>'  class="form-control" />
                        </div>
                        <div class="col-xs-4">
                            Length:
                            <asp:TextBox ID="SlabLengthTextBox" runat="server" Text='<%# Bind("SlabLength") %>' class="form-control" />
                        </div>
                        <div class="col-xs-4">
                            Width:
                            <asp:TextBox ID="SlabWidthTextBox" runat="server" Text='<%# Bind("SlabWidth") %>' class="form-control" />
                        </div>
                        <div class="col-xs-4">
                            Inventory:
                            <asp:TextBox ID="SlabOnHandTextBox" runat="server" Text='<%# Bind("SlabOnHand") %>' class="form-control" />
                        </div>
                    <div class="col-xs-8">
                        Promotional Notes:
                        <asp:TextBox ID="SlabPromoNotesTextBox" runat="server" Text='<%# Bind("SlabPromoNotes") %>' class="form-control" />
                    </div>
                    <div class="col-xs-4">
                        LOT Number:
                        <asp:TextBox ID="LotNoTextBox" runat="server" Text='<%# Bind("LotNo") %>' class="form-control" />
                    </div>

                    </div>

                    </div>
                  </div>
          </div>
          <div class="modal-footer">
                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"  class="btn btn-default" data-dismiss="modal"/>
              <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" ValidationGroup="vg1" CommandName="Insert" class="btn btn-primary" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</asp:LinkButton>
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
        <asp:SqlDataSource ID="SqlDataSourceSlabNames" runat="server" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True" ProviderName="System.Data.OleDb" SelectCommand="SELECT [SlabColorID], [SlabColorName] FROM [SlabColorsQry]"></asp:SqlDataSource>


<div class="modal fade" id="EditModal" tabindex="-1" role="dialog" aria-labelledby="EditModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Edit Slab Promo</h4>
                </div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" style="visibility:hidden;">
                    <ContentTemplate>
<asp:FormView ID="FormView2" runat="server" DataKeyNames="SlabPromoID" DataSourceID="SqlDataSource2" DefaultMode="Edit" RenderOuterTable="False" OnItemUpdated="FormView2_ItemUpdated" OnDataBound="FormView2_DataBound" OnItemDeleted="FormView2_ItemDeleted">
                            <EditItemTemplate>
                                <div class="modal-body">
                                    <div id="bsform2" class="form-horizontal" role="form">
                                        <div class="form-group">
                <div class="row">
                        <div class="col-xs-8">
                            Slab On Promo:
                            <asp:TextBox ID="SlabColorIDTextBox" runat="server" Text='<%# Eval("SlabColor") %>' CssClass="form-control" ReadOnly />
                            <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("SlabColorID") %>' CssClass="form-control" Visible="false" />                         

                        </div>
                        <div class="col-xs-4">
                            <span class="hidden-xs">Promo </span>Price:
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("SlabPromoPrice") %>' CssClass="form-control" />                        

                        </div>
                        <div class="col-xs-4">
                            Length:
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("SlabLength") %>' CssClass="form-control" />                        

                        </div>
                        <div class="col-xs-4">
                            Width:
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SlabWidth") %>' CssClass="form-control" />                        

                        </div>
                        <div class="col-xs-2">
                            Inventory:
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("SlabOnHand") %>' CssClass="form-control" />                        
                        </div>
                        <div class="col-xs-2">
                            Lot #:
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("LotNo") %>' CssClass="form-control" />                        
                        </div>

                    <div class="col-xs-8">
                        Promotional Notes:
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("SlabPromoNotes") %>' CssClass="form-control" />                    

                    </div>
                    <div class="col-xs-4">
                        Inactive:
                        <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("Inactive") %>' CssClass="form-control" />                    
                    </div>
            </div>                    


                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:LinkButton ID="LinkButton2" runat="server"  CommandName="Delete" class="btn btn-danger pull-left" OnClientClick="hideEditModal();" ><span class="glyphicon glyphicon-trash"></span</asp:LinkButton>
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



        <div class="modal" id="RemnantModal" tabindex="-1" role="dialog" aria-labelledby="RemnantModal" aria-hidden="true">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Remnants</h4>
                        </div>

                        <div class="modal-body">
                           <iframe id="IframeRemnant" style="width:100%;" height="400" frameborder="0" seamless></iframe>  
                        </div>                        
                </div>
            </div>
        </div>



<asp:SqlDataSource ID="SqlDataSource2" runat="server"  
    InsertCommand="INSERT INTO tblSlabPromo(SlabColorID, LotNo, SlabPromoPrice, SlabLength, SlabWidth, SlabOnHand, SlabPromoNotes, Inactive) VALUES (?, ?, ?, ?, ?, ?, ?, ?)" 
    ProviderName="System.Data.OleDb" SelectCommand="SELECT SlabPromoID, SlabColorID, SlabColor, LotNo, SlabPromoPrice, SlabLength, SlabWidth, SlabOnHand, SlabPromoNotes, Inactive FROM SlabPromoQry WHERE (SlabPromoID = ?)" 
    UpdateCommand="UPDATE tblSlabPromo SET SlabColorID = ?, LotNo = ?, SlabPromoPrice = ?, SlabLength = ?, SlabWidth = ?, SlabOnHand = ?, SlabPromoNotes = ?, Inactive = ? WHERE (SlabPromoID = ?)" 
    DeleteCommand="DELETE FROM [tblSlabPromo] WHERE [SlabPromoID] = ?" 
    ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True">
            <DeleteParameters>
                <asp:Parameter Name="SlabPromoID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="SlabColorID" Type="Int32" />
                <asp:Parameter Name="LotNo" Type="String" />
                <asp:Parameter Name="SlabPromoPrice" Type="Decimal" />
                <asp:Parameter Name="SlabLength" Type="Int32" />
                <asp:Parameter Name="SlabWidth" Type="Int32" />
                <asp:Parameter Name="SlabOnHand" Type="Int32" />
                <asp:Parameter Name="SlabPromoNotes" Type="String" />
                <asp:Parameter Name="Inactive" Type="Boolean" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" Name="SlabPromoID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="SlabColorID" Type="Int32" />
                <asp:Parameter Name="LotNo" Type="String" />
                <asp:Parameter Name="SlabPromoPrice" Type="Decimal" />
                <asp:Parameter Name="SlabLength" Type="Int32" />
                <asp:Parameter Name="SlabWidth" Type="Int32" />
                <asp:Parameter Name="SlabOnHand" Type="Int32" />
                <asp:Parameter Name="SlabPromoNotes" Type="String" />
                <asp:Parameter Name="Inactive" Type="Boolean" />
                <asp:Parameter Name="SlabPromoID" Type="Int32" />
            </UpdateParameters>
     </asp:SqlDataSource>

    
            <div class="modal fade" id="uploadImageModal" tabindex="-1" role="dialog" aria-labelledby="uploadImageModal" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Image Uploader</h4>
                        </div>

                        <div class="modal-body">
                           <iframe id="IframeUploader" style="width:100%;" height="400" frameborder="0" seamless></iframe>  
                        </div>                        

                        <div class="modal-footer">
                            <a data-dismiss="modal" class="btn btn-default">Close</a>
                        </div>
                </div>
            </div>

        </div>

                <script type='text/javascript'>
                    closeuploadImageModal = function (slabID, imgFilename) {
                        //$('#' + slabID + '').val(imgFilename);
                        $('#uploadImageModal').modal('hide');
                    }
                    </script>

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


        $('#uploadImageModal').on('hidden.bs.modal', function () {
            $(this).removeData('bs.modal');
            $('#IframeUploader').removeAttr("src");
        });

        $('#RemnantModal').on('hidden.bs.modal', function () {
            $(this).removeData('bs.modal');
            $('#IframeRemnant').removeAttr("src");
        });

        $(window).load(function () {
            $(document).on("click", ".open-uploadImageModal", function (e) {
                e.preventDefault();

                var _self = $(this);

                var graniteId = _self.data('id');
                $('#IframeUploader').attr('src', 'image-uploader.aspx?SlabColorID=' + graniteId + '&iframe=true');
                //$(_self.attr('href')).modal('show');
            });

            $(document).on("click", ".open-RemnantModal", function (e) {
                e.preventDefault();

                var _self = $(this);

                var graniteId = _self.data('id');
                var promoId = _self.data('promoid');
                $('#IframeRemnant').attr('src', 'modal-remnant.aspx?SlabColorID=' + graniteId + '&SlabPromoID=' + promoId + '&iframe=true');
                //$(_self.attr('href')).modal('show');
            });
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

        }
    </script>

</asp:Content>
