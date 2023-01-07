<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddRestaurant.aspx.cs" MasterPageFile="~/Admin/NXDAdminMaster.Master" Inherits="tablebooking.Admin.AddRestaurant" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:ScriptManager ID="script" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="update" runat="server">
        <ContentTemplate>
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-md-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Add Restaurant</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Restaurant Name*</label>
                                        <asp:TextBox ID="txtrname" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Name"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requname" runat="server" ControlToValidate="txtrname" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="reguname" SetFocusOnError="true" ValidationExpression="^([a-zA-Z]+\s)*[a-zA-Z]+$" runat="server" Display="Dynamic" ControlToValidate="txtrname" Text="* Character Only" ValidationGroup="user" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Contact Person*</label>
                                        <asp:TextBox ID="txtcpname" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Contact Person"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtcpname" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" SetFocusOnError="true" ValidationExpression="^([a-zA-Z]+\s)*[a-zA-Z]+$" runat="server" Display="Dynamic" ControlToValidate="txtcpname" Text="* Character Only" ValidationGroup="user" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Email-ID*</label>
                                        <asp:TextBox ID="txtmailid" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="2" placeholder="Email-ID"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvmailid" runat="server" ControlToValidate="txtmailid" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="regmailid" SetFocusOnError="true" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" runat="server" Display="Dynamic" ControlToValidate="txtmailid" Text="* Invalid Email-ID" ValidationGroup="user" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Mobile Number*</label>
                                        <asp:TextBox ID="txtmno" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="10" TabIndex="3" placeholder="Mobile Number"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvmno" runat="server" ControlToValidate="txtmno" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Password*</label>
                                        <asp:TextBox ID="txtpswd" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="15" TabIndex="4" placeholder="Password" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtpswd" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Expiry Days*</label>
                                        <asp:TextBox ID="txtexpdays" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Expiry Days"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtexpdays" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" SetFocusOnError="true" ValidationExpression="^-?[1-9]+([0-9]+)*$" runat="server" Display="Dynamic" ControlToValidate="txtexpdays" Text="* Integers Only" ValidationGroup="user" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                    </div>
                                    <asp:Label ID="lblmsg" runat="server" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btnsubmit" runat="server" ValidationGroup="user" TabIndex="7" CausesValidation="true" UseSubmitBehavior="false" Text="Submit" OnClientClick="if(!Page_ClientValidate('user')){return false;}this.disabled=true;this.value='Submitting..';" OnClick="btnsubmit_Click" class="btn btn-primary me-2" />
                                    <asp:Button ID="btncancel" runat="server" class="btn btn-light" CausesValidation="false" OnClick="btncancel_Click" Text="Cancel" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnsubmit" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btncancel" EventName="Click" />
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
