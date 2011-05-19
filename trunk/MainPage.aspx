<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="MainPage.aspx.cs" Inherits="MainPage" %>

<%@ Register Namespace="TreeViewBinding" TagPrefix="user"  %>
<%@ Register src="~/Controls/WebUserControl.ascx" TagName="dishPanel" TagPrefix="dish" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
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
	                    WebService.SetDishsByIDs("1,2,3", CallSuccess);
	                    PageMethods.SetDishsByIDs("1,2,3")
	                   
	                }
	            } else {
	            }
	        }
	        request.send(null);
	    }
	    function CallSuccess(res) {
        alert("Success!")
	    }
	    // alert message on some failure
	    function CallFailed(res, destCtrl) {
	        alert(res.get_message());
	    }    
   </script>
<table class="main-content">
<tr>
<td class="left-column">
  <user:DishGroupsTreeView ID="DishGroupsTreeView" runat="server" />
</td>
<td class="centr-column">
<div id="temp">
			<asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <br />
            <asp:UpdatePanel ID="DishsUpdatePanel" runat="server" >
            <ContentTemplate>
                <asp:PlaceHolder ID="DishsPlaceHolder" runat="server" 
                   >
                </asp:PlaceHolder>
            </ContentTemplate>
            </asp:UpdatePanel>
			Страви:<br />
            <div id="resultContainer">
            <dish:dishPanel ID="Dish1" runat="server" dish_id=1 />
            <dish:dishPanel ID="Dish2" runat="server" dish_id=2 />
            <dish:dishPanel ID="Dish3" runat="server" dish_id=3 />
            //
			<a id="good-1-300" href="#" class="addCart">Супер пивоer" dish_id=3 />
            //
			<a id="good-2-300" href="#" class="addCart">Супер пиво</a> 300 грн<br/> 
			<a id="good-3-700" href="#" class="addCart">Супер серветки</a> 700 грн<br/>  
            </div>
			
		</div> 
        <script type="text/javascript" src="Basket/js/BasketControls.js"></script>
</td>
<td class="right-column">
		   
</td>
</tr>
</table>

</asp:Content>
