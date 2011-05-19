<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SendOrder.aspx.cs" Inherits="SendOrder" %>
<%@ Register TagName="orderState" TagPrefix="ordst" Src="~/Controls/OrderState.ascx" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <link href="/WebProject/Styles/Site.css" rel="stylesheet" type="text/css" />
    <!-- Basket links -->
    <!-- End Basket Links -->

    <!--Loading dishs-->
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
	                }
	            } else {
	            }
	        }
	        request.send(null);
	    }
	        
   </script>
    <script type="text/javascript" src="Basket/js/BasketControls.js"></script>

<table class="main-content">
<tr>
<td class="left-column">

</td>
<td class="centr-column">
<div>  
    <table>
    <tr><td>
        <asp:Label ID="Label1" runat="server" Text="Адреса"></asp:Label>
        <td><asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Label ID="Label2" runat="server" Text="Телефон"></asp:Label></td>
        <td><asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Label ID="Label3" runat="server" Text="Дата виконання"></asp:Label></td>
        <td><asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Label ID="Label4" runat="server" Text="Час виконання"></asp:Label></td>
        <td><asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Label ID="Label5" runat="server" Text="Знижка"></asp:Label></td>
        <td><asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Label ID="Label6" runat="server" Text="Сума замовлення"></asp:Label></td>
        <td><asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Label ID="Label7" runat="server" Text="Інфомація"></asp:Label></td>
        <td><asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
    </td></tr>
    <tr><td>
        <asp:Button ID="Button1" runat="server" Text="Відправити" 
            onclick="Button1_Click1" />
    </td></tr>
    </table>
    </div>
</td>
<td class="right-column">   
        <asp:Timer ID="CheckStateTimer" runat="server" Enabled="False" Interval="10000" 
            ontick="CheckStateTimer_Tick">
        </asp:Timer>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
            <Services>
                
            </Services>
        </asp:ScriptManager>
        
<asp:UpdatePanel ID="StausUpdatePanel" runat="server">
            <ContentTemplate>
                <asp:PlaceHolder ID=PlaceHolder1 runat="server">
                    <asp:Label ID="textbox" runat="server" Text="Status" />        
                </asp:PlaceHolder> 
            </ContentTemplate>
</asp:UpdatePanel> 
</td>

    <asp:Label ID="txt" runat="server" Text="" Visible="false"></asp:Label>

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" Visible="False">
    <Columns>
        <asp:BoundField DataField="IdUser" HeaderText="IdUser" 
            SortExpression="IdUser" />
        <asp:BoundField DataField="Address" HeaderText="Address" 
            SortExpression="Address" />
        <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
        <asp:BoundField DataField="Info" HeaderText="Info" SortExpression="Info" />
    </Columns>
</asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:food_usersConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:food_usersConnectionString.ProviderName %>" 
        SelectCommand="SELECT * FROM my_Address"
        FilterExpression="IdUser='{0}'">
                <FilterParameters>
                    <asp:ControlParameter Name="IdUser" ControlId="txt" PropertyName="text"/>
                </FilterParameters>
    </asp:SqlDataSource>
</div> 
   
</asp:Content>
