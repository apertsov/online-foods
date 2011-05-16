<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeFile="CashRagistry.aspx.cs" Inherits="CashRagistry" %>
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
    <script type="text/javascript" src="Basket/js/BasketControls.js"></script>
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Timer ID="Timer1" runat="server" Interval="15000" ontick="Timer1_Tick">
        </asp:Timer>
        <asp:UpdatePanel ID="UpdatePanel7" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Label ID="Label1" runat="server" Font-Italic="True" Font-Size="XX-Large" 
                    Text="Current date:"></asp:Label>
                <br />
                <asp:Label ID="Label10" runat="server" Text="Label"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
    <table>
        <tr>
            <td >
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" 
                            onselectedindexchanged="DropDownList2_SelectedIndexChanged">
                            <asp:ListItem>Daily</asp:ListItem>
                            <asp:ListItem>Weekly</asp:ListItem>
                            <asp:ListItem>Monthly</asp:ListItem>
                            <asp:ListItem>Yearly</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;<asp:Label ID="Label4" runat="server" Text="Dates"></asp:Label>
&nbsp;<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                        &nbsp;-
                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                        <br />
                        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Show" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td >
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" 
                            onselectedindexchanged="DropDownList1_SelectedIndexChanged">
                            <asp:ListItem>Daily</asp:ListItem>
                            <asp:ListItem>Weekly</asp:ListItem>
                            <asp:ListItem>Monthly</asp:ListItem>
                            <asp:ListItem>Yearly</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;<asp:Label ID="Label5" runat="server" Text="Dates"></asp:Label>
&nbsp;<asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                        &nbsp;-
                        <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                        <br />
                        <asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="Show" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td >
                <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:DropDownList ID="DropDownList3" runat="server" 
                            onselectedindexchanged="DropDownList3_SelectedIndexChanged" 
                            style="height: 21px">
                            <asp:ListItem>Daily</asp:ListItem>
                            <asp:ListItem>Weekly</asp:ListItem>
                            <asp:ListItem>Monthly</asp:ListItem>
                            <asp:ListItem>Yearly</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;<asp:Label ID="Label6" runat="server" Text="Dates"></asp:Label>
&nbsp;<asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                        &nbsp;-
                        <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                        <br />
                        <asp:Button ID="Button3" runat="server" onclick="Button3_Click" Text="Show" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
             <td valign="top">
                 <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                     <ContentTemplate>
                        <asp:Label runat="server" Text="Spent money" />
                         <asp:GridView ID="GridView1" runat="server" BackColor="#CCCCCC" 
                             BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" 
                             CellSpacing="2" ForeColor="Black">
                             <Columns>
                                 <asp:TemplateField>
                                     <ItemTemplate>
                                         <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">Details</asp:LinkButton>
                                     </ItemTemplate>
                                 </asp:TemplateField>
                             </Columns>
                             <FooterStyle BackColor="#CCCCCC" />
                             <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                             <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                             <RowStyle BackColor="White" />
                             <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                             <SortedAscendingCellStyle BackColor="#F1F1F1" />
                             <SortedAscendingHeaderStyle BackColor="#808080" />
                             <SortedDescendingCellStyle BackColor="#CAC9C9" />
                             <SortedDescendingHeaderStyle BackColor="#383838" />
                         </asp:GridView>
                     </ContentTemplate>
                 </asp:UpdatePanel>
            </td>
            <td valign="top">
                <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="Label2" runat="server" Text="Recieved money" />
                        <asp:GridView ID="GridView2" runat="server" BackColor="#DEBA84" 
                            BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                            CellSpacing="2">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton2" runat="server" onclick="LinkButton2_Click">Details</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FFF1D4" />
                            <SortedAscendingHeaderStyle BackColor="#B95C30" />
                            <SortedDescendingCellStyle BackColor="#F1E5CE" />
                            <SortedDescendingHeaderStyle BackColor="#93451F" />
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td valign="top">
                <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="Label3" runat="server" Text="Lost money" />
                        <asp:GridView ID="GridView3" runat="server" BackColor="White" 
                            BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton3" runat="server" onclick="LinkButton3_Click">Details</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                            <RowStyle BackColor="White" ForeColor="#330099" />
                            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                            <SortedAscendingCellStyle BackColor="#FEFCEB" />
                            <SortedAscendingHeaderStyle BackColor="#AF0101" />
                            <SortedDescendingCellStyle BackColor="#F6F0C0" />
                            <SortedDescendingHeaderStyle BackColor="#7E0000" />
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <asp:UpdatePanel ID="UpdatePanel8" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="Label7" runat="server"></asp:Label>
                        <br />
                        <asp:GridView ID="GridView4" runat="server" BackColor="White" 
                            BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
                            ForeColor="Black" GridLines="Vertical">
                            <AlternatingRowStyle BackColor="White" />
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td valign="top">
                <asp:UpdatePanel ID="UpdatePanel9" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="Label8" runat="server"></asp:Label>
                        <br />
                        <asp:GridView ID="GridView5" runat="server" BackColor="White" 
                            BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
                            ForeColor="Black" GridLines="Vertical">
                            <AlternatingRowStyle BackColor="White" />
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td valign="top">
                <asp:UpdatePanel ID="UpdatePanel10" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="Label9" runat="server"></asp:Label>
                        <br />
                        <asp:GridView ID="GridView6" runat="server" BackColor="White" 
                            BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
                            ForeColor="Black" GridLines="Vertical">
                            <AlternatingRowStyle BackColor="White" />
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td valign="top">
        </tr>
    </table>
    </div>

</asp:Content>

