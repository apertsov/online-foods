<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="MainPage.aspx.cs" Inherits="MainPage" %>

<%@ Register Namespace="TreeViewBinding" TagPrefix="user"  %>
<%@ Register src="~/Controls/WebUserControl.ascx" TagName="dishPanel" TagPrefix="dish" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
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
	                    WebService.SetDishsByIDs("1,2,3", CallSuccess);
	                    PageMethods.SetDishsByIDs("1,2,3")
	                   
	                }
	            } else {
	            }
	        }
	        request.send(null);
	    }
	    function CallSuccess(res) {
        alert("Success!")
	    }
	    // alert message on some failure
	    function CallFailed(res, destCtrl) {
	        alert(res.get_message());
	    }    
   </script>
<table class="main-content">
<tr>
<td class="left-column">
  <user:DishGroupsTreeView ID="DishGroupsTreeView" runat="server" />
</td>
<td class="centr-column">
<div id="temp">
			<asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <br />
            <asp:UpdatePanel ID="DishsUpdatePanel" runat="server" >
            <ContentTemplate>
                <asp:PlaceHolder ID="DishsPlaceHolder" runat="server" 
                   >
                </asp:PlaceHolder>
            </ContentTemplate>
            </asp:UpdatePanel>
			Страви:<br />
            <div id="resultContainer">
            <dish:dishPanel ID="Dish1" runat="server" dish_id=1 />
            <dish:dishPanel ID="Dish2" runat="server" dish_id=2 />
            <dish:dishPanel ID="Dish3" runat="server" dish_id=3 />
            //
			<a id="good-1-300" href="#" class="addCart">Супер пивоer" dish_id=3 />
            //
			<a id="good-2-300" href="#" class="addCart">Супер пиво</a> 300 грн<br/> 
			<a id="good-3-700" href="#" class="addCart">Супер серветки</a> 700 грн<br/>  
            </div>
			
		</div> 
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
</td>
<td class="right-column">
		   
</td>
</tr>
</table>

</asp:Content>
