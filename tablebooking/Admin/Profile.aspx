<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NXDAdminMaster.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="nextdoormarket.Admin.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="assets/css/loader.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:ScriptManager ID="profilescript" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="updateprofile" runat="server">
        <ContentTemplate>
            <div class="content-wrapper">
                <div class="page-header">
                    <h3 class="page-title">My Profile </h3>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Edit Profile</h4>
                                <div>
                                    <p class="card-description">Profile Details </p>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">Name*</label>
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtname" runat="server" CssClass="form-control"
                                                        MaxLength="30" TabIndex="1" AutoCompleteType="Disabled" placeholder="Name"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqname" runat="server"
                                                        ControlToValidate="txtname" Display="Dynamic"
                                                        ErrorMessage="* Required" ValidationGroup="profile"
                                                        ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="regname" SetFocusOnError="true"
                                                        ValidationExpression="^([a-zA-Z]+\s)*[a-zA-Z]+$" runat="server" Display="Dynamic"
                                                        ControlToValidate="txtname" Text="* Character Only" ValidationGroup="profile"
                                                        CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">Email*</label>
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtemail" runat="server" MaxLength="30" TabIndex="2"
                                                        CssClass="form-control" AutoCompleteType="Disabled" placeholder="Email"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqmail" runat="server"
                                                        ControlToValidate="txtemail" Display="Dynamic" ErrorMessage="* Required"
                                                        ForeColor="Red" Font-Bold="true" SetFocusOnError="true" ValidationGroup="profile"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="regemail" SetFocusOnError="true"
                                                        ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                                                        runat="server" Display="Dynamic" ControlToValidate="txtemail" Text="* Invalid Email"
                                                        ValidationGroup="profile" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">Mobile Number*</label>
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtmno" runat="server" TabIndex="3"
                                                        MaxLength="12" CssClass="form-control" AutoCompleteType="Disabled"
                                                        placeholder="Mobile Number"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqmno" runat="server"
                                                        ControlToValidate="txtmno" Display="Dynamic" ErrorMessage="* Required"
                                                        ForeColor="Red" Font-Bold="true" SetFocusOnError="true" ValidationGroup="profile"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="regmno" SetFocusOnError="true"
                                                        ValidationExpression="^([0-9]{10})$" runat="server" Display="Dynamic"
                                                        ControlToValidate="txtmno" Text="* Length Should Be 10 Numbers" ValidationGroup="profile"
                                                        CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">Old Password*</label>
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtoldpassword" runat="server" TabIndex="4"
                                                        MaxLength="15" CssClass="form-control" TextMode="Password"
                                                        AutoCompleteType="Disabled" placeholder="Old Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqoldpswd" runat="server"
                                                        ControlToValidate="txtoldpassword" Display="Dynamic" ErrorMessage="* Required"
                                                        ForeColor="Red" Font-Bold="true" SetFocusOnError="true" ValidationGroup="profile"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">New Password*</label>
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtnewpswd" runat="server" TabIndex="5" MaxLength="15"
                                                        CssClass="form-control" TextMode="Password" AutoCompleteType="Disabled"
                                                        placeholder="New Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                        ControlToValidate="txtnewpswd" Display="Dynamic" ErrorMessage="* Required"
                                                        ForeColor="Red" Font-Bold="true" SetFocusOnError="true" ValidationGroup="profile"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label">Confirm New Password*</label>
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtconfirmpswd" runat="server" TabIndex="6" MaxLength="15"
                                                        CssClass="form-control" TextMode="Password" AutoCompleteType="Disabled"
                                                        placeholder="New Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                        ControlToValidate="txtconfirmpswd" Display="Dynamic" ErrorMessage="* Required"
                                                        ForeColor="Red" Font-Bold="true" SetFocusOnError="true" ValidationGroup="profile"></asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="cmppswds" runat="server" ControlToValidate="txtnewpswd"
                                                        ControlToCompare="txtconfirmpswd" Display="Dynamic" SetFocusOnError="true"
                                                        ForeColor="Red" ErrorMessage="* New Password and Confirm New Password do not match."
                                                        ValidationGroup="profile" Operator="Equal" Type="String"></asp:CompareValidator>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <p class="card-description">Actions </p>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:Label ID="lblmsg" runat="server" CssClass="auth-link"
                                                Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                            <asp:Button ID="btnsubmit" runat="server" Text="Submit" TabIndex="7"
                                                ValidationGroup="profile" Style="margin-top: 10px;" OnClick="btnsubmit_Click"
                                                CssClass="btn btn-primary me-2" UseSubmitBehavior="false"
                                                OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Updating...';" />
                                            <asp:Button ID="btncancel" runat="server" Text="Cancel"
                                                OnClick="btncancel_Click" TabIndex="8" Style="margin-top: 10px;" CssClass="btn btn-light" />
                                        </div>
                                    </div>
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
    <asp:UpdateProgress ID="upprogprofile" runat="server" AssociatedUpdatePanelID="updateprofile">
        <ProgressTemplate>
            <div id="loadmodal">
                <span id="loadercenter">
                    <img src="assets/images/loading.gif" alt="loading" /></span>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
