<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Register.aspx.cs" Inherits="Mega_shop_mysql3.Account.Register" %>

<script runat="server">

    protected void RegisterUser_CreatedUser(object sender, EventArgs e)
    {
        FormsAuthentication.SetAuthCookie(RegisterUser.UserName, false /* createPersistentCookie */);

        string continueUrl = RegisterUser.ContinueDestinationPageUrl;
        if (String.IsNullOrEmpty(continueUrl))
        {
            continueUrl = "~/Account/addAddress.aspx";
        }
        Response.Redirect(continueUrl);
    }
</script>
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
    <asp:CreateUserWizard ID="RegisterUser" runat="server" EnableViewState="false" OnCreatedUser="RegisterUser_CreatedUser">
        <LayoutTemplate>
            <asp:PlaceHolder ID="wizardStepPlaceholder" runat="server"></asp:PlaceHolder>
            <asp:PlaceHolder ID="navigationPlaceholder" runat="server"></asp:PlaceHolder>
        </LayoutTemplate>
        <WizardSteps>
            <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                <ContentTemplate>
                    <h2>
                        Сzтворити новий профіль.
                    </h2>
                    <p>
                        Використовуйте форму для створення профілю.
                    </p>
                    <p>
                        Пароль повинен містити мінімум <%= Membership.MinRequiredPasswordLength %> символів.
                    </p>
                    <span class="failureNotification">
                        <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                    </span>
                    <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification" 
                         ValidationGroup="RegisterUserValidationGroup"/>
                    <div class="accountInfo">
                        <fieldset class="register">
                            <legend>Дані</legend>
                            <p>
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Ім'я:</asp:Label>
                                <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                                     CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                            <p>
                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                                <asp:TextBox ID="Email" runat="server" CssClass="textEntry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" 
                                     CssClass="failureNotification" ErrorMessage="E-mail is required." ToolTip="E-mail is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                            <p>
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Пароль:</asp:Label>
                                <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                                     CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                            </p>
                            <p>
                                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Підтвердити пароль:</asp:Label>
                                <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="ConfirmPassword" CssClass="failureNotification" Display="Dynamic" 
                                     ErrorMessage="Confirm Password is required." ID="ConfirmPasswordRequired" runat="server" 
                                     ToolTip="Confirm Password is required." ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                                     CssClass="failureNotification" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match."
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator>
                            </p>
                        </fieldset>
                        <p class="submitButton">
                            <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="Створити" 
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
                    </div>
                </ContentTemplate>
                <CustomNavigationTemplate>
                </CustomNavigationTemplate>
            </asp:CreateUserWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
</asp:Content>
