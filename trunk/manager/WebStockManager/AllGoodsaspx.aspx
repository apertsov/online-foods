<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeFile="AllGoodsaspx.aspx.cs" Inherits="AllGoodsaspx" %>
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
    
    
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Label ID="Label1" runat="server" Font-Bold="False" Font-Italic="True" 
                    Font-Size="XX-Large" Text="Current Date: "></asp:Label>
                <asp:Timer ID="Timer1" runat="server" ontick="Timer1_Tick" Interval="15000">
                </asp:Timer>
                <asp:GridView ID="GridView1" runat="server" BackColor="#DEBA84"
                    BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                    CellSpacing="2"
                    >

                    
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
                            <HeaderTemplate>
                                <asp:LinkButton ID="LinkButton3" runat="server" onclick="LinkButton3_Click">Purchase</asp:LinkButton>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">Edit</asp:LinkButton>
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

        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="Label8" runat="server" Font-Italic="True" Font-Size="X-Large" 
                            Text="Edit Goods"></asp:Label>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton2" runat="server" onclick="LinkButton2_Click">Hide</asp:LinkButton>
                        <br />
                        <table ID="TableForm" Visible="false">
                            <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text="Good id"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label6" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text="Good name"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label4" runat="server" Text="Count"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label7" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label5" runat="server" Text="Price"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="Confirm" runat="server" Text="Confirm changes" 
                                        onclick="Confirm_Click" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
    
        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
            <ContentTemplate>


                <asp:Label ID="Label9" runat="server" Font-Italic="True" Font-Size="X-Large" 
                    Text="Purchase Goods"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="LinkButton4" runat="server" onclick="LinkButton4_Click">Hide</asp:LinkButton>
                <br />

                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="True">
                    <Columns>
                        
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="Label11" runat="server" Text="Count"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <asp:LinkButton ID="Purchase" runat="server" onclick="Purchase_Click" 
                    Text="Purchase" />

                <br />
            </ContentTemplate>
        </asp:UpdatePanel>
    
        <br />
    
    </div>
</asp:Content>
