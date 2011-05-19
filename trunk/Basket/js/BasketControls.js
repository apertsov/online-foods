$(document).ready(function(){
					<!----------------------------------->
					$("#basketDialog").hide();
					$("#basketCountDialog").hide();
					<!----------------------------------->
					msg = new Array();
					var basket = '';
					var totalprice = 0;
					var totalCountGoods = 0;
					if (!$.cookie("basket")) {$.cookie("basket", '', {path: "/"});}
					basket = decodeURI($.cookie("basket"));
					basketArray = basket.split(",");
					for(var i=0;i<basketArray.length-1;i++) {
						goodsId = basketArray[i].split(":");
						totalCountGoods+=parseInt(goodsId[1]);
						totalprice+=parseInt(goodsId[1])*parseInt(goodsId[2]);
					}
					if (totalprice > 0) {
						$('#clearBasket').show();
						$('#checkOut').show();
						$('.hPb').show();
						$('.hPe').hide();
					}
					if (!totalprice) {totalprice = 0;}
					$('#totalPrice').text(totalprice);
					$('#totalGoods').text(totalCountGoods);
			});
			
			$('#basket').click(function() {			
				showBasketDialog(true);
			});
			
			function showBasketDialog(show){
				$('#goodsTable').empty();
				if (!$.cookie("basket")) {$.cookie("basket", '', {path: "/"});}
				basket = decodeURI($.cookie("basket"));
				basketArray = basket.split(",");
				if (basketArray.length == 1){
					$('#goodsTable').hide();
					//$('#basketDialog').empty();
					//$('#basketDialog').append($('#bTable').clone());
					//if (show) $('#basketDialog').dialog();
					$.jGrowl('Кошик пустий');
					return;
				}
				$('#goodsTable').show();
				<!---------->
				$('#goodsTable').append('<tbody><tr><td>Товар</td><td>Ціна</td><td>Кількість</td><td/></tr>');
				<!---------->
				for(var i=0;i<basketArray.length-1;i++) {
					goodsId = basketArray[i].split(":");
					goodId = parseInt(goodsId[0]);
					goodTitle = goodsId[3];
					goodsCount=parseInt(goodsId[1]);
					goodsTotalPrice=parseInt(goodsId[1])*parseInt(goodsId[2]);
					<!------------->
					$('#goodsTable').append(
						'<tr><td>'+goodTitle+'</td>'+
						'<td>'+goodsTotalPrice+'</td>'+
						//'<td>'+goodsCount+'</td>'+
						'<td>'+'<a id="ctch-'+goodId+'-'+parseInt(goodsId[2])+'-'+goodsCount+'-'+goodTitle+'" href="#" class="changeCountGood">'+goodsCount+'</a>'+'</td>'+
						'<td>'+'<a id="'+goodId+'" href="#" class="delGood"><img src="/WebProject/Basket/images/gtk-close.png"/></a>'+'</td></tr>'
						);
					<!------------->
				}
				$('#goodsTable').append('</table>');
				if (show) $('#basketDialog').dialog();
			}
			
			$('a.addCart').click(function() {
				$('#idInfo').val($(this).attr('id'));
				data = $(this).attr('id').split('-');
			   <!----------->
			   $('#goodNameCd').text($(this).html());
			   $('#goodCount').val("1");
			   $("#basketCountDialog").dialog();
			   <!----------->			   
			   <!--дел--------->
			   /*addCart(data[1], data[2], data[3], $(this).html());
			   showBasketDialog(false);*/
			   <!--дел--------->
			   return false;			   
			});
			<!------------------>
			$('a.bcdOK').click(function() {
				count = $('#goodCount').val();
				name = $('#goodNameCd').text();
				if (count > 0 && count < 1000)
				{
					data = $('#idInfo').val().split('-');
					addCart(data[1], data[2], count, name);
					$("#basketCountDialog").dialog("close");
					$('#goodNameCd').text("");
					$('#goodCount').val("1");
				}
				showBasketDialog(false);
			});
			$('a.bcdCancel').click(function() {
				$("#basketCountDialog").dialog("close");
				$('#goodNameCd').text("");
				$('#goodCount').val("1");
			});
			<!------------------>
			<!--------------->
			$('a.delGood').live('click', function() {
				idtodel = $(this).attr('id');				
				delCart(idtodel);
				showBasketDialog(true);
			});
			<!--------------->
			<!--------------->
			$('a.changeCountGood').live('click', function() {
				data = $(this).attr('id').split('-');
				idtochange = data[1];
				price = data[2];
				count = data[3];
				title = data[4];
				delCart(idtochange);
				$('#idInfo').val($(this).attr('id'));
				$('#goodNameCd').text(title);
				$('#goodCount').val(count);
				$("#basketCountDialog").dialog();
				$.jGrowl("Введіть нову кількість!");
				showBasketDialog(true);
			});
			<!--------------->
			<!--------------->
			function delCart(id){
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
				if (basket=='null') {basket = '';}
				basketArray = basket.split(",");
				for(var i=0; i<basketArray.length-1;i++) {
					goodsId = basketArray[i].split(":");
					if(goodsId[0]!=id) {
						newbasket+=basketArray[i] + ',';
					}					
				}
				$.jGrowl('Видалено!');
				basketArray = newbasket.split(",");
				for(var i=0; i<basketArray.length-1;i++) {
					goodsId = basketArray[i].split(":");
					totalCountGoods+=parseInt(goodsId[1]);
					totalprice+=parseInt(goodsId[1])*parseInt(goodsId[2]);
				}
				$('#totalGoods').text(totalCountGoods);
				$('#totalPrice').text(totalprice);
				$.cookie("totalPrice", totalprice, {path: "/"});
				$.cookie("basket", newbasket, {path: "/"});					
			}
			<!--------------->
			function debugGetGoods(){//повертає дані замовлення для відправки
				var result = "";
				if (!$.cookie("basket")) {$.cookie("basket", '', {path: "/"});}
					basket = decodeURI($.cookie("basket"));
					basketArray = basket.split(",");
					for(var i=0;i<basketArray.length-1;i++) {
						goodsId = basketArray[i].split(":");
						goodId = parseInt(goodsId[0]);
						goodsCount=parseInt(goodsId[1]);
						result += '$' + goodId + '$' + goodsCount;
					}
				return result;
			}
			
			
			function addCart(p1, p2, p3, p4){
				if (!p3 || p3==0) {p3=1;}			
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
				if (basket=='null') {basket = '';}
				basketArray = basket.split(",");
				for(var i=0; i<basketArray.length-1;i++) {
					goodsId = basketArray[i].split(":");
					if(goodsId[0]==msg.id)
					{
						check = true;
						cnt   = goodsId[1];
						newbasket+=goodsId[0]+':'+(parseInt(goodsId[1])+msg.count)+':'+goodsId[2]+':'+goodsId[3]+',';
					} else {
						newbasket+=basketArray[i] + ',';
					}					
				}
				if(!check) {
					newbasket+= msg.id + ':' + msg.count + ':' + msg.price + ':' + msg.title + ',';
				}
				$.jGrowl('Додано!');
				basketArray = newbasket.split(",");
				for(var i=0; i<basketArray.length-1;i++) {
					goodsId = basketArray[i].split(":");
					totalCountGoods+=parseInt(goodsId[1]);
					totalprice+=parseInt(goodsId[1])*parseInt(goodsId[2]);
				}
				$('#totalGoods').text(totalCountGoods);
				$('#totalPrice').text(totalprice);
				$.cookie("totalPrice", totalprice, {path: "/"});
				$.cookie("basket", newbasket, {path: "/"});					
			}
			
			
			function clearBasketF(){
				$('#goodsTable').hide();
				$.cookie("totalPrice", '', {path: "/"});
				$.cookie("basket", '', {path: "/"});
				$('#totalPrice').text('0');
				$('#totalGoods').text('0');
				$('.hPb').hide();
				$('.hPe').show();
				$('#clearBasket').hide();
				$('#checkOut').hide();
			}
			
			$('#clearBasket').click(function() {
				clearBasketF();
				showBasketDialog(false);
				return false;
			});			
			$('#checkOutButton').click(function() {				
				$.jGrowl(debugGetGoods());
				$.jGrowl('Замовлення відправлене!');				
				clearBasketF();
				return false;
			});		 
