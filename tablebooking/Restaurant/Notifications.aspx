<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Restaurant/RestaurantMaster.Master" CodeBehind="Notifications.aspx.cs" Inherits="tablebooking.Restaurant.Notifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .chkpadding label {
        margin-left:5px;
        margin-top:3px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel ID="update" runat="server">
        <ContentTemplate>
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-md-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Notifications</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <asp:CheckBoxList ID="chknotifications" runat="server" CssClass="chkpadding">
                                            </asp:CheckBoxList>
                                        </div>
                                    </div>
                                    <asp:Label ID="lblmsg" runat="server" CssClass="auth-link"
                                        ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btnupdate" runat="server" TabIndex="7"
                                        CausesValidation="true" UseSubmitBehavior="false" Text="Update"
                                        OnClientClick="this.disabled=true;this.value='Updating..';"
                                        OnClick="btnupdate_Click" class="btn btn-primary me-2" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnupdate" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="upprogprofile" runat="server" AssociatedUpdatePanelID="update">
        <ProgressTemplate>
            <div id="loadmodal">
                <span id="loadercenter">
                    <img src="assets/ring.gif" alt="loading" /></span>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script src="assets/js/dashboard.js"></script>
    <script src="assets/js/todolist.js"></script>
</asp:Content>
