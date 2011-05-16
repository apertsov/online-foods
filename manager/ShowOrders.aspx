<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="ShowOrders.aspx.cs" Inherits="ShowOrders" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
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
    <script type="text/javascript"  src="Checker.js"> </script>
    <form id="form1" runat="server" method="post" >
    <div>
        <asp:Label ID="Label1" runat="server" Font-Italic="True" Font-Size="XX-Large" 
            Text="New Orders For Today:"></asp:Label>
<asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
        <asp:Timer ID="Timer1" runat="server" ontick="Timer1_Tick" Interval="15000">
        </asp:Timer>
        &nbsp;&nbsp;&nbsp;
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" >
            <ContentTemplate>
                <asp:Label ID="Label2" runat="server"></asp:Label>
                
               <asp:gridview ID="GridView2" runat="server" CellPadding="4" ForeColor="#333333" 
                    GridLines="None" >
                    
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="CheckBox2" runat="server" AutoPostBack="true" oncheckedchanged="CheckBox2_CheckedChanged"  />
                            </HeaderTemplate>

                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" 
                                   AutoPostBack="true"
                                     />
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">View Details</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    
                </asp:gridview>
        
            </ContentTemplate>
        </asp:UpdatePanel>
    
       <asp:Button ID="Accepted" runat="server" onclick="Accepted_Click" 
            Text="Accepted" />
            <asp:Button ID="GettingReady" runat="server"
            Text="Getting Ready" Width="102px" onclick="GettingReady_Click" />
            <asp:Button ID="Sent" runat="server" 
            Text="Sent" Width="70px" onclick="Sent_Click" />
            <asp:Button ID="Refused" runat="server" 
            Text="Refused" onclick="Refused_Click" />  

    </div>
    <div>

        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <br />
                <asp:Label ID="Label4" runat="server" Font-Italic="True" Font-Size="XX-Large" 
                    Text="Products Included in:" Visible="False"></asp:Label>
                <asp:GridView ID="GridView3" runat="server" BackColor="White" 
                    BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" 
                    GridLines="Horizontal">
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

    </div>
    <div>
        <p style="margin-left: 280px">
            <br />
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Bold="True" 
                    Font-Size="Medium" Target="_blank" NavigateUrl="~/Manager/AllOrders.aspx">View all orders</asp:HyperLink>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" 
                    Font-Size="Medium" Target="_blank" NavigateUrl="~/Manager/ShowOrders.aspx">View Stock</asp:HyperLink>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:HyperLink ID="HyperLink3" runat="server" Font-Bold="True" 
                    Font-Size="Medium" Target="_blank" NavigateUrl="~/Manager/ShowOrders.aspx">View Cash Register</asp:HyperLink>
        </p>
    </div>
    </form>
</asp:Content>