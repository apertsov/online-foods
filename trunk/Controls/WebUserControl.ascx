<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WebUserControl.ascx.cs" Inherits="WebUserControl" %>
 <link href="/WebProject/Styles/Site.css" rel="stylesheet" type="text/css" />
<div id="dishBox">
    <asp:Label ID="Label1" runat="server" Text="Label" Font-Bold="True"></asp:Label>
    <br />
    <asp:Image ID="Image1" runat="server" Height="105px" Width="152px" />
    <br />
    <asp:Label ID="Label2" runat="server" ForeColor="#666699" Text="Ціна"></asp:Label>
    :
    <asp:Label ID="Label3" runat="server" Text="д4245"></asp:Label>
    &nbsp;<asp:TextBox ID="TextBox1" runat="server" Width="23px">0</asp:TextBox>
    &nbsp;<asp:Button ID="Button1" runat="server" Height="20px" Text="&gt;" 
        Width="20px" onclick="Button1_Click" />
</div>

