<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SendOrder.aspx.cs" Inherits="SendOrder" %>
<%@ Register TagName="orderState" TagPrefix="ordst" Src="~/Controls/OrderState.ascx" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <link href="/WebProject/Styles/Site.css" rel="stylesheet" type="text/css" />
    <!-- Basket links -->
    <!-- End Basket Links -->

    <!--Loading dishs-->
<script type="text/javascript">

	    function createAjaxRequest() {
	        var httpRequest;
	        if (window.XMLHttpRequest) { // Mozilla, Safari, ...
	            httpRequest = new XMLHttpRequest();
	            if (httpRequest.overrideMimeType) {
	                httpRequest.overrideMimeType('text/xml');
	            }
	        }
	        else if (window.ActiveXObject) { // IE
	            try {
	                httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
	            }
	            catch (e) {
	                try {
	                    httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
	                }
	                catch (e) { }
	            }
	        }
	        return httpRequest;
	    }
	    //
	    // Here is an instance method that computes a circle's area.
	    function getInfo(id_group) {
	        var request = createAjaxRequest();
	        var serviceUrl = "Handler/LoadDishsByGroup.ashx?id_group=";
	        request.open("GET", serviceUrl + id_group, true);
	        request.onreadystatechange = function () {
	            if (request.readyState == 4) {
	                if (request.status == 200) {
	                    $("#resultContainer").html(this.responseText);
	                }
	            } else {
	            }
	        }
	        request.send(null);
	    }
	        
   </script>
<script type="text/javascript">
       $(document).ready(function () {
           $("#basketDialog").hide();
           msg = new Array();
           var basket = '';
           var totalprice = 0;
           var totalCountGoods = 0;
           if (!$.cookie("basket")) { $.cookie("basket", '', { path: "/" }); }
           basket = decodeURI($.cookie("basket"));
           basketArray = basket.split(",");
           for (var i = 0; i < basketArray.length - 1; i++) {
               goodsId = basketArray[i].split(":");
               totalCountGoods += parseInt(goodsId[1]);
               totalprice += parseInt(goodsId[1]) * parseInt(goodsId[2]);
           }
           if (totalprice > 0) {
               $('#clearBasket').show();
               $('#checkOut').show();
               $('.hPb').show();
               $('.hPe').hide();
           }
           if (!totalprice) { totalprice = 0; }
           $('#totalPrice').text(totalprice);
           $('#totalGoods').text(totalCountGoods);
       });

       $('#basket').click(function () {
           showBasketDialog(true);
       });

       function showBasketDialog(show) {
           $('#goodsTable').empty();
           if (!$.cookie("basket")) { $.cookie("basket", '', { path: "/" }); }
           basket = decodeURI($.cookie("basket"));
           basketArray = basket.split(",");
           if (basketArray.length == 1) {
               $('#goodsTable').hide();
               //$('#basketDialog').empty();
               //$('#basketDialog').append($('#bTable').clone());
               //if (show) $('#basketDialog').dialog();
               $.jGrowl('Кошик пустий');
               return;
           }
           $('#goodsTable').show();
           $('#goodsTable').append('<table><tr><td>Товар</td><td>Ціна</td><td>Кількість</td></tr>');
           for (var i = 0; i < basketArray.length - 1; i++) {
               goodsId = basketArray[i].split(":");
               goodId = parseInt(goodsId[0]);
               goodTitle = goodsId[3];
               goodsCount = parseInt(goodsId[1]);
               goodsTotalPrice = parseInt(goodsId[1]) * parseInt(goodsId[2]);
               $('#goodsTable').append('<tr><td>' + goodTitle + '</td>' + '<td>' + goodsTotalPrice + '</td>' + '<td>' + goodsCount + '</td></tr>');
           }
           $('#goodsTable').append('</table>');
           if (show) $('#basketDialog').dialog();
       }

       $('a.addCart').click(function () {
           data = $(this).attr('id').split('-');
           addCart(data[1], data[2], data[3], $(this).html());
           showBasketDialog(false);
           return false;
       });

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


       function addCart(p1, p2, p3, p4) {
           if (!p3 || p3 == 0) { p3 = 1; }
           msg.id = p1;
           msg.price = parseInt(p2);
           msg.count = parseInt(p3);
           msg.title = p4;
           var check = false;
           var cnt = false;
           var totalCountGoods = 0;
           var totalprice = 0;
           var goodsId = 0;
           var basket = '';
           $('#clearBasket').show();
           $('#checkOut').show();
           $('.hPb').show();
           $('.hPe').hide();
           basket = decodeURI($.cookie("basket"));
           newbasket = '';
           if (basket == 'null') { basket = ''; }
           basketArray = basket.split(",");
           for (var i = 0; i < basketArray.length - 1; i++) {
               goodsId = basketArray[i].split(":");
               if (goodsId[0] == msg.id) {
                   check = true;
                   cnt = goodsId[1];
                   newbasket += goodsId[0] + ':' + (parseInt(goodsId[1]) + msg.count) + ':' + goodsId[2] + ':' + goodsId[3] + ',';
               } else {
                   newbasket += basketArray[i] + ',';
               }
           }
           if (!check) {
               newbasket += msg.id + ':' + msg.count + ':' + msg.price + ':' + msg.title + ',';
           }
           $.jGrowl('Додано!');
           basketArray = newbasket.split(",");
           for (var i = 0; i < basketArray.length - 1; i++) {
               goodsId = basketArray[i].split(":");
               totalCountGoods += parseInt(goodsId[1]);
               totalprice += parseInt(goodsId[1]) * parseInt(goodsId[2]);
           }
           $('#totalGoods').text(totalCountGoods);
           $('#totalPrice').text(totalprice);
           $.cookie("totalPrice", totalprice, { path: "/" });
           $.cookie("basket", newbasket, { path: "/" });
       }

       function clearBasketF() {
           $('#goodsTable').hide();
           $.cookie("totalPrice", '', { path: "/" });
           $.cookie("basket", '', { path: "/" });
           $('#totalPrice').text('0');
           $('#totalGoods').text('0');
           $('.hPb').hide();
           $('.hPe').show();
           $('#clearBasket').hide();
           $('#checkOut').hide();
       }

       $('#clearBasket').click(function () {
           clearBasketF();
           showBasketDialog(false);
           return false;
       });
       $('#checkOutButton').click(function () {
           $.jGrowl(debugGetGoods());
           $.jGrowl('Замовлення відправлене!');
           clearBasketF();
           return false;
       });		 
		</script>   
<div>

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
        <asp:Button ID="Button1" runat="server" Text="Відправити" 
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
                <asp:PlaceHolder ID=PlaceHolder1 runat="server">
                    <asp:Label ID="textbox" runat="server" Text="Status" />        
                </asp:PlaceHolder> 
            </ContentTemplate>
</asp:UpdatePanel> 
</td>
</div>    
</asp:Content>