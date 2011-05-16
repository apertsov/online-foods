<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="CreateFood.aspx.cs" Inherits="manager_Default" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <script type="text/javascript" src="~/Basket/js/BasketControls.js"></script>
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
    
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Додати" 
            Width="61px" />
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="name"></asp:Label>
&nbsp;&nbsp;
        <asp:TextBox ID="TextBox1" runat="server" Width="94px"></asp:TextBox>
&nbsp;
        <asp:Label ID="Label4" runat="server" Text="time"></asp:Label>
&nbsp;
        <asp:TextBox ID="TextBox2" runat="server" Width="103px"></asp:TextBox>
&nbsp;
        <asp:Label ID="Label6" runat="server" Text="tags"></asp:Label>
&nbsp;
        <asp:TextBox ID="TextBox4" runat="server" Width="106px"></asp:TextBox>
        <br />
        <asp:Label ID="Label5" runat="server" Text="information"></asp:Label>
&nbsp;<br />
        <asp:TextBox ID="TextBox3" runat="server" TextMode="MultiLine" Width="458px"></asp:TextBox>
        <br />
&nbsp;<asp:Label ID="Label7" runat="server" Text="receip"></asp:Label>
        <br />
        <asp:TextBox ID="TextBox5" runat="server" TextMode="MultiLine" Width="458px"></asp:TextBox>
        <br />
        <br />
    
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
            DataKeyNames="id_dish" DataSourceID="SqlDataSource1" ForeColor="#333333" 
            GridLines="None" onselectedindexchanged="GridView1_SelectedIndexChanged">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="id_dish" HeaderText="id" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id_dish" />
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                <asp:BoundField DataField="time" HeaderText="time" SortExpression="time" />
                <asp:BoundField DataField="info" HeaderText="info" SortExpression="info" />
                <asp:BoundField DataField="tags" HeaderText="tags" SortExpression="tags" />
                <asp:BoundField DataField="receipt" HeaderText="receipt" 
                    SortExpression="receipt" />
                <asp:CommandField ShowEditButton="True" 
                    ShowSelectButton="True" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:online_foodsConnectionString %>" 
            DeleteCommand="DELETE FROM dish 
                           WHERE id_dish = @id_dish" 
            InsertCommand="INSERT INTO dish 
                           (name, time, info, tags, receipt) 
                           VALUES (@name, @time, @info, @tags, @receipt)" 
            ProviderName="<%$ ConnectionStrings:online_foodsConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM dish"
            UpdateCommand="UPDATE dish SET 
                           name = @name, 
                           time = @time, 
                           info = @info,
                           tags = @tags,
                           receipt = @receipt
                           WHERE id_dish = @id_dish">
            <InsertParameters>
            <asp:Parameter Name="name" Type="String" DefaultValue = "null" />
            <asp:Parameter Name="time" Type="String" DefaultValue="00:00:00" />
            <asp:Parameter Name="info" Type="String" DefaultValue = "null"/>
            <asp:Parameter Name="tags" Type="String" DefaultValue = "null"/>
            <asp:Parameter Name="receipt" Type="String" DefaultValue = "null"/>
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:online_foodsConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:online_foodsConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM ingredients" 
            InsertCommand="INSERT INTO dish_ingredients 
                           (id_dish, id_ingredient) 
                           VALUES (@id_dish, @id_ingredient )">
            <InsertParameters>
            <asp:Parameter Name="id_dish" Type="String" DefaultValue="0" />
            <asp:Parameter Name="id_ingredient" Type="String" DefaultValue="0" />
            </InsertParameters>
            </asp:SqlDataSource>
    
        <br />
        &nbsp;<asp:Button ID="Button4" runat="server" onclick="Button4_Click" 
            Text="edit" Visible="False" Height="33px" Width="84px" />
        <asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="Add" 
            Visible="False" Height="33px" Width="86px" />
        <asp:ListBox ID="ListBox1" runat="server" DataSourceID="SqlDataSource2" 
            DataTextField="full_name" DataValueField="id_ingredients" 
            SelectionMode="Multiple" Visible="False" Width="146px"></asp:ListBox>
        <asp:Label ID="Label2" runat="server"></asp:Label>
    
        <asp:GridView ID="GridView2" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" DataKeyNames="id_dish_ingredients" 
            DataSourceID="SqlDataSource3" Visible="False" CellPadding="4" 
            ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="id_dish" HeaderText="id_dish" 
                    SortExpression="id_dish" />
                <asp:BoundField DataField="id_ingredient" HeaderText="id_ingredient" 
                    SortExpression="id_ingredient" />
                <asp:BoundField DataField="count" HeaderText="count" SortExpression="count" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:online_foodsConnectionString %>" 
            DeleteCommand="DELETE FROM dish_ingredients WHERE id_dish_ingredients=@id_dish_ingredients" 
            ProviderName="<%$ ConnectionStrings:online_foodsConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM dish_ingredients WHERE id_dish = @i"
            UpdateCommand="UPDATE dish_ingredients 
                            SET id_dish = @id_dish,
                                id_ingredient = @id_ingredient,
                                count = @count
                            WHERE id_dish_ingredients = @id_dish_ingredients">
            <SelectParameters>
            <asp:Parameter Name="i" Type="String" />
            </SelectParameters>

        </asp:SqlDataSource>
        <br />
    
    </div>
</asp:Content>
