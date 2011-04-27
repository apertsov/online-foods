<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="ChangePassword.aspx.cs" Inherits="Mega_shop_mysql3.Account.ChangePassword" %>

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
    $('#checkOut').click(function () {
        $.jGrowl(debugGetGoods());
        $.jGrowl('Замовлення відправлене!');
        clearBasketF();
        return false;
    });		 
		</script>   
    <h2>
        Змінити пароль
    </h2>
    <p>
        Використайте форму для зміни пароля.
    </p>
    <p>
        Новий пароль повинний містити мінімум <%= Membership.MinRequiredPasswordLength %> символів.
    </p>
    <asp:ChangePassword ID="ChangeUserPassword" runat="server" CancelDestinationPageUrl="~/" EnableViewState="false" RenderOuterTable="false" 
         SuccessPageUrl="ChangePasswordSuccess.aspx">
        <ChangePasswordTemplate>
            <span class="failureNotification">
                <asp:Literal ID="FailureText" runat="server"></asp:Literal>
            </span>
            <asp:ValidationSummary ID="ChangeUserPasswordValidationSummary" runat="server" CssClass="failureNotification" 
                 ValidationGroup="ChangeUserPasswordValidationGroup"/>
            <div class="accountInfo">
                <fieldset class="changePassword">
                    <legend>Дані</legend>
                    <p>
                        <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Старий пароль:</asp:Label>
                        <asp:TextBox ID="CurrentPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" 
                             CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Old Password is required." 
                             ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p>
                        <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">Новий пароль:</asp:Label>
                        <asp:TextBox ID="NewPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" 
                             CssClass="failureNotification" ErrorMessage="New Password is required." ToolTip="New Password is required." 
                             ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                    </p>
                    <p>
                        <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Підтвердити новий пароль:</asp:Label>
                        <asp:TextBox ID="ConfirmNewPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" 
                             CssClass="failureNotification" Display="Dynamic" ErrorMessage="Confirm New Password is required."
                             ToolTip="Confirm New Password is required." ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" 
                             CssClass="failureNotification" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry."
                             ValidationGroup="ChangeUserPasswordValidationGroup">*</asp:CompareValidator>
                    </p>
                </fieldset>
                <p class="submitButton">
                    <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"/>
                    <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword" Text="Change Password" 
                         ValidationGroup="ChangeUserPasswordValidationGroup"/>
                </p>
            </div>
        </ChangePasswordTemplate>
    </asp:ChangePassword>
</asp:Content>
