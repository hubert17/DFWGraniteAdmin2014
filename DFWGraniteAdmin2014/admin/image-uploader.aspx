<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="image-uploader.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.image_uploader" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>


    <!-- Bootstrap Core CSS -->
    <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <!-- jQuery Version 1.11.0 -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

    <style>
         img, svg, canvas {
          max-width: 100%;
          max-height: 70%;
          margin-left:15px;
          margin-top: 5px;
        }
         body {
            overflow:hidden;
        }
         .pad-top {
             margin-top: 10px;
         }
         .showimage {
             padding-right:30px;
         }
    </style>

  <style type='text/css'>
        div.show-image {
            position: relative;
            float:left;
        }
        div.show-image:hover img{
            opacity:0.5;
        }
        div.show-image:hover input {
            display: block;
        }
        div.show-image input {
            position:absolute;
            display:none;
        }
        div.show-image .close {
            top:10px;
            left:6%;
        }
      </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container">
        <asp:FormView ID="FormView1" runat="server" RenderOuterTable="false"  DataKeyNames="SlabColorID" DataSourceID="SqlDataSource1" DefaultMode="Edit">
            <EditItemTemplate>
                <h3><strong><asp:Label ID="SlabColorTextBox" runat="server" Text='<%# Eval("SlabColorName") %>' /></strong></h3>
                <div style="visibility: hidden;">
                    <asp:TextBox ID="ImageFilenameTextBox" runat="server" Text='<%# Bind("ImageFilename") %>' />
                </div>
                <asp:TextBox ID="ImageFilenameOldTextBox" runat="server" Visible="false" Text='<%# Eval("ImageFilenameOld") %>' />
                <asp:Label ID="SlabColorIDLabel1" runat="server" Visible="false" Text='<%# Eval("SlabColorID") %>' />
            </EditItemTemplate>
        </asp:FormView>

        <div>
            <asp:Panel ID="pnlUpload" runat="server" CssClass="row">
                <div class="col-sm-6 pull-left"><asp:FileUpload ID="Upload" runat="server" onchange="GetFileName(this.value)" style="width:100%;margin-bottom:5px;" CssClass="btn btn-sm btn-warning"/></div>
                <div class="col-sm-3 pull-left"><asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" Text="Upload" CssClass="btn btn-sm btn-success" /></div>
            </asp:Panel>
            <div class="row col-sm-6">
                    <asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert alert-danger alert pad-top pull-left" />
            </div>
            <asp:Panel ID="pnlCrop" runat="server" Visible="false" CssClass="row showimage">
                <div class="show-image">
                    <asp:Image ID="imgCrop" runat="server" CssClass="pull-left" /> 
                    <asp:Button ID="btnRemoveImg" runat="server" Text="&times;" ToolTip="Remove Picture" class="close" OnClick="btnRemoveImg_Click" OnClientClick="return confirm('You are about to remove the picture. Are you sure?');"/>
                </div>               
            </asp:Panel>
            <asp:Panel ID="pnlCropped" runat="server" Visible="false">
            </asp:Panel>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\DFWwebsiteDB.accdb;Persist Security Info=True" DeleteCommand="DELETE FROM [tblSlabColors] WHERE [SlabColorID] = ?" InsertCommand="INSERT INTO [tblSlabColors] ([SlabColorID], [SlabColor], [ImageFilename], [ImageFilenameOld]) VALUES (?, ?, ?, ?)" ProviderName="System.Data.OleDb" SelectCommand="SELECT SlabColorID, SlabColor &amp; IIf(IsNull(DaltilePrice2cm), ' 3cm', ' 2cm') AS SlabColorName, ImageFilename, ImageFilenameOld FROM tblSlabColors WHERE (SlabColorID = ?)" UpdateCommand="UPDATE tblSlabColors SET ImageFilename = ? WHERE (SlabColorID = ?)">
        <DeleteParameters>
            <asp:Parameter Name="SlabColorID" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="290" Name="SlabColorID" QueryStringField="SlabColorID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ImageFilename" Type="String" />
            <asp:Parameter Name="SlabColorID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>    
    
    </form>

    <script>
        // Prevent the backspace key from navigating back.
        $(document).unbind('keydown').bind('keydown', function (event) {
            var doPrevent = false;
            if (event.keyCode === 8) {
                var d = event.srcElement || event.target;
                if ((d.tagName.toUpperCase() === 'INPUT' &&
                     (
                         d.type.toUpperCase() === 'TEXT' ||
                         d.type.toUpperCase() === 'PASSWORD' ||
                         d.type.toUpperCase() === 'FILE' ||
                         d.type.toUpperCase() === 'EMAIL' ||
                         d.type.toUpperCase() === 'SEARCH' ||
                         d.type.toUpperCase() === 'DATE')
                     ) ||
                     d.tagName.toUpperCase() === 'TEXTAREA') {
                    doPrevent = d.readOnly || d.disabled;
                }
                else {
                    doPrevent = true;
                }
            }

            if (doPrevent) {
                event.preventDefault();
            }
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".alert").delay(4000).slideUp(500, function () {
                $(this).alert('close');
            });
        });
    </script>
</body>
</html>
