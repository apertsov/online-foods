<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="search.aspx.cs" Inherits="search" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <link href="../Styles/Site.css" rel="stylesheet" type="text/css" />
<link href="../SiteMenu/SiteMenu.css" rel="stylesheet" type="text/css" />
    <!-- Basket links -->
<script type="text/javascript" src="/WebProject/Basket/js/jquery-1.5.2.min.js"></script> 
<script type="text/javascript" src="/WebProject/Basket/js/jquery.jgrowl.js"></script> 
<link href="/WebProject/Basket/css/jquery.jgrowl.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/WebProject/Basket/js/jquery.cookie.js"></script> 
<link href="/WebProject/Basket/css/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/WebProject/Basket/js/jquery-ui.min.js"></script>
<link href="/WebProject/Basket/css/basket.css" rel="stylesheet" type="text/css"/>
<link href="/WebProject/Styles/Site.css" rel="stylesheet" type="text/css" />
    <!-- Basket links -->
    <!-- End Basket Links -->
<script type="text/javascript">

    // Simply changes the information 

    // in the display text boxes to 

    // demonstrate how to obtain meta-data 

    // from the selected node's 

    // NodeData property on the client.

    //sss

    function DishGroupClick() {
        var treeNode = GetSelectedNode();
        window.alert("!!!");
        if (null == treeNode || undefined == treeNode) {
            return;
        }

        var nodeData =
          treeNode.getAttribute('nodeData').split(';');

        var id = GetKeyValue('id_dish_group');
        var name = GetKeyValue('name');
    }

    // Gets the value of the searchKey 

    // from the NodeData of a TreeNode.

    //

    function GetKeyValue(searchKey) {
        // Get a handle to the selected TreeNode.

        var treenode = GetSelectedNode();

        // Validate the node handle.

        if (null == treenode || undefined == treenode)
            return null;

        // Get the node's NodeData property's value.

        var nodeDataAry = treenode.getAttribute('nodeData');

        if (null == nodeDataAry || undefined == nodeDataAry)
            return null;

        nodeDataAry = nodeDataAry.split(';');

        if (null == nodeDataAry || undefined == nodeDataAry ||
         0 >= nodeDataAry.length)
            return null;

        var count = 0;
        var returnValue = null;

        while (count < nodeDataAry.length) {
            var workingItem = nodeDataAry[count];

            if (0 >= workingItem.length) {
                count++;
                continue;
            }

            // Split the string into its key value pairs.

            var kv = workingItem.split('=');

            if (1 >= kv.length) {
                count++;
                continue;
            }

            var key = kv[0];
            var kValue = kv[1];

            if (key != searchKey) {
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

    function GetTreeHandle() {
        var tree;
        var treeName = 'MainContent_DishGroupsTreeView_DishGroupTreeView';

        // Get a handle to the TreeView.

        tree = document.getElementById(treeName);

        if (null == tree || undefined == tree)
            return null;

        return tree;
    }

    // Gets a handle to the TreeView's selected node.

    //

    function GetSelectedNode() {
        var tree = GetTreeHandle();
        var treeNode;

        if (null == tree || undefined == tree)
            return null;

        treeNode = tree.getTreeNode(tree.selectedNodeIndex);

        if (null == treeNode || undefined == treeNode)
            return null;

        return treeNode;
    }   
    </script>
    <!--Loading dishs-->
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
    <script type="text/javascript" src="../Basket/js/BasketControls.js"></script>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            &nbsp;&nbsp;<asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:Panel ID="Panel1" runat="server">
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" Height="21px" onclick="Button1_Click" 
                    Text="Пошук" />
                <asp:Button ID="Button3" runat="server" Height="21px" onclick="Button3_Click" 
                    Text="Розширений пошук" Width="127px" />
            </asp:Panel>
            <asp:Panel ID="Panel2" runat="server" Visible="False">
                <table style="width:100%;">
                    <tr>
                        <td>
                            <asp:Label ID="Label11" runat="server" Text="Ім'я"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox13" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Інформація</td>
                        <td>
                            <asp:TextBox ID="TextBox14" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Теги</td>
                        <td>
                            <asp:TextBox ID="TextBox15" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td>
                            <asp:Button ID="Button5" runat="server" onclick="Button5_Click" Text="Шукати" />
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </asp:Panel>
            &nbsp;<br />
            <asp:GridView ID="GridView1" runat="server" BackColor="White" 
                BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" 
                GridLines="Horizontal" onselectedindexchanged="GridView1_SelectedIndexChanged">
                <FooterStyle BackColor="White" ForeColor="#333333" />
                <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="White" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#487575" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#275353" />
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
