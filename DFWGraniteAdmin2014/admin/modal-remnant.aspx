<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="modal-remnant.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.modal_remnant" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        * {
            text-align: center;
        }
        body {
            font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
            font-size:small;
            color:#777;
            overflow-x:hidden;
        }
        h3 {
            font-size:medium;
        }
        a, a:visited {
            text-decoration:none;
            color:#333;
        }
        table {
            width: 200px;
        }
        td {
            max-width:50px;
            min-width: 30px;
        }
        input[type=text] {
            max-width: 40px;
        }

        .idCol {
            color:antiquewhite;
        }

    </style>
</head>
<body>
<form id="form1" runat="server">
    <div>
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource2">
            <ItemTemplate>
               <h3><%# Eval("SlabColorName") %></h3>
            </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True" ProviderName="System.Data.OleDb" SelectCommand="SELECT SlabColorID, SlabColorName FROM SlabColorsQry WHERE (SlabColorID = ?)">
            <SelectParameters>
                <asp:QueryStringParameter Name="?" QueryStringField="SlabColorID" />
            </SelectParameters>
        </asp:SqlDataSource>

    </div>
    <div>
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="SlabRemnantID" DataSourceID="SqlDataSource1" InsertItemPosition="LastItem">
            <AlternatingItemTemplate>
                <tr style="">
                    <td>
                        <asp:LinkButton ID="SlabRemnantIDLabel" runat="server" CommandName="Edit" Text='<%# Eval("SlabRemnantID") %>' CssClass="idCol" />
                    </td>
                    <td>
                        <asp:LinkButton ID="LengthLabel" runat="server" Text='<%# Eval("Length") %>' CommandName="Edit" />
                    </td>
                    <td>x</td>
                    <td>
                        <asp:LinkButton ID="WidthLabel" runat="server" Text='<%# Eval("Width") %>' CommandName="Edit" />
                    </td>
                    <td>
                        <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="X" />
                    </td>                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="↺" />
                        <asp:Label ID="SlabRemnantIDLabel" runat="server" Text='<%# Eval("SlabRemnantID") %>' Visible="false" />
                    </td>
                    <td>
                        <asp:TextBox ID="LengthTextBox" runat="server" Text='<%# Bind("Length") %>' />
                    </td>
                    <td>x</td>
                    <td>
                        <asp:TextBox ID="WidthTextBox" runat="server" Text='<%# Bind("Width") %>' />
                    </td>
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="✔" />
                    </td>
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" style="">
                    <tr>
                        <td>No remnants for this slab.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <tr style="">
                    <td><span class="idCol">[*]</span></td>
                    <td>
                        <asp:TextBox ID="LengthTextBox" runat="server" Text='<%# Bind("Length") %>' />
                    </td>
                    <td>x</td>
                    <td>
                        <asp:TextBox ID="WidthTextBox" runat="server" Text='<%# Bind("Width") %>' />
                    </td>
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="✔" />
                    </td>
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="">
                    <td>
                        <asp:LinkButton ID="SlabRemnantIDLabel" runat="server" CommandName="Edit" Text='<%# Eval("SlabRemnantID") %>' CssClass="idCol" />
                    </td>
                    <td>
                        <asp:LinkButton ID="LengthLabel" runat="server" Text='<%# Eval("Length") %>' CommandName="Edit" />
                    </td>
                    <td>x</td>
                    <td>
                        <asp:LinkButton ID="WidthLabel" runat="server" Text='<%# Eval("Width") %>' CommandName="Edit" />
                    </td>
                    <td>
                        <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="X" />
                    </td>                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table id="itemPlaceholderContainer" runat="server" border="0" style="">
                                <tr runat="server" style="">
                                    <th runat="server"><span class="idCol">#</span></th>
                                    <th runat="server">Length</th>
                                    <th></th>
                                    <th runat="server">Width</th>
                                    <th runat="server"></th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style=""></td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <tr style="">
                    <td>
                        <asp:LinkButton ID="SlabRemnantIDLabel" runat="server" CommandName="Edit" Text='<%# Eval("SlabRemnantID") %>' />
                    </td>
                    <td>
                        <asp:LinkButton ID="LengthLabel" runat="server" Text='<%# Eval("Length") %>' CommandName="Edit" />
                    </td>
                    <td>
                        <asp:LinkButton ID="WidthLabel" runat="server" Text='<%# Eval("Width") %>' CommandName="Edit" />
                    </td>
                    <td>
                        <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                    </td>
                </tr>
            </SelectedItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" DeleteCommand="DELETE FROM [tblSlabRemnants] WHERE [SlabRemnantID] = ?" InsertCommand="INSERT INTO [tblSlabRemnants] ([SlabColorID], [Length], [Width]) VALUES (?, ?, ?)" ProviderName="System.Data.OleDb" SelectCommand="SELECT SlabRemnantID, SlabColorID, Length, Width FROM tblSlabRemnants WHERE (SlabColorID = ?)" UpdateCommand="UPDATE [tblSlabRemnants] SET [SlabColorID] = ?, [Length] = ?, [Width] = ? WHERE [SlabRemnantID] = ?" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True">
            <DeleteParameters>
                <asp:Parameter Name="SlabRemnantID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:QueryStringParameter Name="SlabColorID" QueryStringField="SlabColorID" Type="Int32" />
                <asp:Parameter Name="Length" Type="Int16" />
                <asp:Parameter Name="Width" Type="Int16" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="?" QueryStringField="SlabColorID" />
            </SelectParameters>
            <UpdateParameters>
                <asp:QueryStringParameter Name="SlabColorID" QueryStringField="SlabColorID" Type="Int32" />
                <asp:Parameter Name="Length" Type="Int16" />
                <asp:Parameter Name="Width" Type="Int16" />
                <asp:Parameter Name="SlabRemnantID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</form>
</body>
</html>
