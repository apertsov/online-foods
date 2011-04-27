<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SendOrder.aspx.cs" Inherits="SendOrder" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <script type="text/javascript">
    function debugGetGoods() {//повертає дані замовлення для відправки
        var result = "";
        if (!$.cookie("basket")) { $.cookie("basket", '', { path: "/" }); }
        basket = decodeURI($.cookie("basket"));
        basketArray = basket.split(",");
        for (var i = 0; i < basketArray.length - 1; i++) {
            goodsId = basketArray[i].split(":");
            goodId = parseInt(goodsId[0]);
            goodsCount = parseInt(goodsId[1]);
            result += '$' + goodId + '$' + goodsCount;
        }
        return result;
    }
            $('#checkOutButton').click(function () {
                $.jGrowl(debugGetGoods());
                $.jGrowl('Замовлення відправлене!');
                clearBasketF();
                return false;
            function clearBasketF() {
                $('#goodsTable').hide();
                $.cookie("totalPrice", '', { path: "/" });
                $.cookie("basket", '', { path: "/" });
                $('#totalPrice').text('0');
                $('#totalGoods').text('0');
                $('.hPb').hide();
                $('.hPe').show();
                $('#clearBasket').hide();
                $('#checkOutLink').hide();
</script>
    <script type="text/javascript" src="Basket/js/BasketControls.js"></script>
<table class="main-content">
<tr>
<td class="left-column">

</td>
<td class="centr-column">
<div>  
    <table>
    <tr><td>
        <asp:Label ID="Label1" runat="server" Text="Адреса"></asp:Label>
        <td><asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Label ID="Label2" runat="server" Text="Телефон"></asp:Label></td>
        <td><asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Label ID="Label3" runat="server" Text="Дата виконання"></asp:Label></td>
        <td><asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Label ID="Label4" runat="server" Text="Час виконання"></asp:Label></td>
        <td><asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Label ID="Label5" runat="server" Text="Знижка"></asp:Label></td>
        <td><asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Label ID="Label6" runat="server" Text="Сума замовлення"></asp:Label></td>
        <td><asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Label ID="Label7" runat="server" Text="Інфомація"></asp:Label></td>
        <td><asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Button ID="Button1" runat="server" Text="Button" 
            onclick="Button1_Click1" />
    </td></tr>
        
    </table>
    </div>
</td>
<td class="right-column">   
        <asp:Timer ID="CheckStateTimer" runat="server" Enabled="False" Interval="10000" 
            ontick="CheckStateTimer_Tick">
        </asp:Timer>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
            <Services>
                
            </Services>
        </asp:ScriptManager>
<asp:UpdatePanel ID="StausUpdatePanel" runat="server">
            <ContentTemplate>
                <asp:Label ID="lbStatus" runat="server" Text="Status" ForeColor="Maroon" />
                <br />
                <asp:Button ID="btnCheck" runat="server" Text="Check" 
                    onclick="btnCheck_Click" />
            </ContentTemplate>
</asp:UpdatePanel> 
</td>
    
</asp:Content>