<%@ Page Title="" Language="C#" MasterPageFile="~/Restaurant/RestaurantMaster.Master" AutoEventWireup="true" CodeBehind="DeliveryReport.aspx.cs" Inherits="tablebooking.Restaurant.DeliveryReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel ID="update" runat="server">
        <ContentTemplate>
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-md-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Search</h4>
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <asp:DropDownList ID="drpstatus" runat="server" CssClass="form-control">
                                                <asp:ListItem Value="0" Text="-Select-"></asp:ListItem>
                                                <asp:ListItem Value="1" Text="Pending"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="Approved"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtfdate" runat="server" CssClass="form-control" placeholder="From Date: dd/mm/yyyy"></asp:TextBox></td>
                                        <cc:CalendarExtender ID="clndrfrom" Format="dd/MM/yyyy" TargetControlID="txtfdate" runat="server" />
                                        <td>
                                            <asp:TextBox ID="txttodate" runat="server" CssClass="form-control" placeholder="To Date: dd/mm/yyyy"></asp:TextBox></td>
                                        <cc:CalendarExtender ID="clndrto" Format="dd/MM/yyyy" TargetControlID="txttodate" runat="server" />
                                        <td>
                                            <asp:Button ID="btnsearch" runat="server" CssClass="btn-dark" Text="Search" ValidationGroup="srch" OnClick="btnsearch_Click" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <h4 class="card-title">Delivery</h4>
                                <div class="table-responsive">
                                    <asp:GridView ID="grddata" CssClass="table table-striped" EmptyDataText="No Data Found.."
                                        OnRowCommand="grddata_RowCommand" OnRowDeleting="grddata_RowDeleting"
                                        AlternatingRowStyle-CssClass="py-1" runat="server" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sno.">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                    <asp:HiddenField ID="tblid" Visible="false" runat="server" Value='<%#Eval("ubookid") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Details">
                                                <ItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td>Booking</td>
                                                            <td>:</td>
                                                            <td>
                                                                <asp:Label ID="lblbookdt" runat="server" Text='<%#Eval("bookdt") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Name</td>
                                                            <td>:</td>
                                                            <td>
                                                                <%#Eval("ufname") %> <%#Eval("ulname") %>
                                                        </tr>
                                                        <tr>
                                                            <td>Contact</td>
                                                            <td>:</td>
                                                            <td>
                                                                <%#Eval("ucpno") %>
                                                        </tr>
                                                        <tr>
                                                            <td>Mail</td>
                                                            <td>:</td>
                                                            <td>
                                                                <%#Eval("umailid") %>
                                                        </tr>
                                                        <tr>
                                                            <td>Company</td>
                                                            <td>:</td>
                                                            <td>
                                                                <%#Eval("company") %>
                                                        </tr>
                                                        </tr>
                                                           <tr>
                                                               <td>Notes</td>
                                                               <td>:</td>
                                                               <td>
                                                                   <%#Eval("notes") %>
                                                           </tr>
                                                        </tr>
                                                           <tr>
                                                               <td>Special Arrangements</td>
                                                               <td>:</td>
                                                               <td>
                                                                   <%#Eval("specarrange") %>
                                                           </tr>
                                                        <tr>
                                                            <td>Booked On</td>
                                                            <td>:</td>
                                                            <td>
                                                                <%#Eval("addedon") %>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Order">
                                                <ItemTemplate>
                                                    <%#Eval("orders") %><br />
                                                    <table>
                                                        <tr>
                                                            <td>--Update Status</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:HiddenField ID="hfstatus" runat="server" Value='<%#Eval("reqtype") %>' />
                                                                <asp:DropDownList ID="drpstatus" runat="server">
                                                                    <asp:ListItem Value="1" Text="Pending"></asp:ListItem>
                                                                    <asp:ListItem Value="2" Text="Approved"></asp:ListItem>
                                                                </asp:DropDownList></td>
                                                            <td>
                                                                <asp:Button ID="btnupdatestatus" runat="server" Text="Update"
                                                                    CommandName="delete" CommandArgument="upstatus" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnsearch" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="upprogprofile" runat="server" AssociatedUpdatePanelID="update">
        <ProgressTemplate>
            <div id="loadmodal">
                <span id="loadercenter">
                    <img src="images/Fidget-spinner.gif" alt="loading" /></span>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
