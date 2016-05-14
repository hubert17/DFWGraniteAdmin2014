<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserLogBS.ascx.cs" Inherits="DFWGraniteAdmin2014.UserControl.UserLogBS" %>

<asp:LinkButton ID="LoggedInUserName" runat="server" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <asp:Literal ID="UserNameLiteral" runat="server"></asp:Literal> <b class="caret"></b></asp:LinkButton>
<ul class="dropdown-menu">
    <li>
        <a href="#"><i class="fa fa-fw fa-user"></i> Profile</a>
    </li>
    <li>
        <a href="#"><i class="fa fa-fw fa-envelope"></i> Inbox</a>
    </li>
    <li>
        <a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a>
    </li>
    <li class="divider"></li>
    <li>
        <asp:LinkButton ID="LogoutLinkButton" runat="server" OnClick="LogoutLinkButton_Click"><i class="fa fa-fw fa-power-off"></i> Log Out</asp:LinkButton>
    </li>
</ul>