<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Mega_shop_mysql3._Default" %>
<%@ Register Namespace="TreeViewBinding" TagPrefix="user"  %>
   
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
    <!-- Basket links -->
    <!-- End Basket Links -->
   <script type="text/javascript">
        
   // Simply changes the information 

   // in the display text boxes to 

   // demonstrate how to obtain meta-data 

   // from the selected node's 

   // NodeData property on the client.

   //sss

   function DishGroupClick()
   {
       var treeNode = GetSelectedNode();
       window.alert("!!!");
       if ( null == treeNode || undefined == treeNode )
       {
           return;
       }     
       
       var nodeData = 
          treeNode.getAttribute( 'nodeData' ).split( ';' );          
           
       var id = GetKeyValue( 'id_dish_group' );
       var name = GetKeyValue( 'name' );
   }
   
   // Gets the value of the searchKey 

   // from the NodeData of a TreeNode.

   //

   function GetKeyValue( searchKey )
   {   
       // Get a handle to the selected TreeNode.

       var treenode = GetSelectedNode();
     
       // Validate the node handle.

       if ( null == treenode || undefined == treenode )
           return null;
   
       // Get the node's NodeData property's value.

       var nodeDataAry = treenode.getAttribute( 'nodeData' );
   
       if ( null == nodeDataAry || undefined == nodeDataAry )
           return null;
    
       nodeDataAry = nodeDataAry.split( ';' );
   
       if ( null == nodeDataAry || undefined == nodeDataAry || 
         0 >= nodeDataAry.length )
           return null;
    
       var count = 0;
       var returnValue = null;
   
       while ( count < nodeDataAry.length )
       {
           var workingItem = nodeDataAry[ count ];
    
           if ( 0 >= workingItem.length )
           {
               count++;
               continue;
           }
     
           // Split the string into its key value pairs.

           var kv = workingItem.split( '=' );
   
           if ( 1 >= kv.length )
           {
               count++;
               continue;
           }
     
           var key = kv[ 0 ];
           var kValue = kv[ 1 ];
   
           if ( key != searchKey )
           {
               count++;
               continue;
           }
   
           returnValue = kValue;
           break;
       }       
    
       return returnValue;
   }
    
   // Gets a handle to the TreeView.

   //

   function GetTreeHandle()
   {
       var tree;
       var treeName = 'MainContent_DishGroupsTreeView_DishGroupTreeView';
      
       // Get a handle to the TreeView.

       tree = document.getElementById( treeName );
   
       if ( null == tree || undefined == tree )
           return null;
   
       return tree;
   }     
   
   // Gets a handle to the TreeView's selected node.

   //

   function GetSelectedNode()
   {
       var tree = GetTreeHandle();
       var treeNode;
   
       if ( null == tree || undefined == tree )
           return null;
   
       treeNode = tree.getTreeNode( tree.selectedNodeIndex );  
    
       if ( null == treeNode || undefined == treeNode )
           return null;
   
       return treeNode;
   }   
    </script>
    
<table class="main-content">
<tr>
<td class="left-column">
   <user:DishGroupsTreeView ID="DishGroupsTreeView" runat="server" />
</td>
<td class="centr-column">
<div id="temp">
			Товари:<br />
			<a id="good-2356-500" href="#" class="addCart">Супер піца</a> 500 грн<br/> 
			<a id="good-23586-300" href="#" class="addCart">Супер пиво</a> 300 грн<br/> 
			<a id="good-2357-700" href="#" class="addCart">Супер серветки</a> 700 грн<br/>  
		</div> 
        <script type="text/javascript">
            $(document).ready(function (){ 
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
