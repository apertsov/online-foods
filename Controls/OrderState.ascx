<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrderState.ascx.cs" Inherits="Controls_OrderState" %>


<asp:Timer ID="StateTimer" Enabled="true" runat="server" Interval="1000" OnTick="StateTimerTick"></asp:Timer>
<asp:Label ID="StateLabel" runat="server" Text="Status"></asp:Label>
