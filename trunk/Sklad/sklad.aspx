<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="sklad.aspx.cs" Inherits="sklad" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <script type="text/javascript" src="Basket/js/BasketControls.js"></script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Усе" />
            <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
                Text="Операції" />
            <asp:Button ID="Button3" runat="server" onclick="Button3_Click" 
                Text="Детально" />
            <br />
            <asp:ListBox ID="ListBox1" runat="server" AutoPostBack="True" 
                onselectedindexchanged="ListBox1_SelectedIndexChanged" Visible="False">
            </asp:ListBox>
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
            <br />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

