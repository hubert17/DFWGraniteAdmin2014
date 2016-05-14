<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserLog.ascx.cs" Inherits="DFWGraniteAdmin2014.UserControl.UserLog" %>

<li><asp:LinkButton ID="LoggedInUserName" runat="server" Text="Hello, " /></li>
<li><asp:LinkButton ID="LogoutLinkButton" runat="server" OnClick="LogoutLinkButton_Click">Logout</asp:LinkButton></li>
