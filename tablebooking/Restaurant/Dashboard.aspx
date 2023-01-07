<%@ Page Title="" Language="C#" MasterPageFile="~/Restaurant/RestaurantMaster.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="tablebooking.Restaurant.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">
                <span class="page-title-icon bg-gradient-primary text-white mr-2">
                    <i class="mdi mdi-home"></i>
                </span>Dashboard
            </h3>
            <nav aria-label="breadcrumb">
                <ul class="breadcrumb">
                    <li class="breadcrumb-item active" aria-current="page">
                        <span></span>Overview <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>
                    </li>
                </ul>
            </nav>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="card-body">
                    <h4 class="card-title">Performance (Expiry Date:
                        <asp:Label ID="lblexpdate" runat="server"></asp:Label>)</h4>
                    <asp:Label ID="lbldash" runat="server"></asp:Label>
                    <div>
                        <br />
                        Embed this code in your Website to start booking<br />
                        <asp:TextBox ID="txtlink" runat="server" ReadOnly="true" Width="100%" Height="100" TextMode="MultiLine"></asp:TextBox><br />
                        <br />
                        or Simply Goto link for Booking
                        <br />
                        <br />
                        <asp:Label ID="lbllink" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script src="assets/js/dashboard.js"></script>
    <script src="assets/js/todolist.js"></script>
</asp:Content>
