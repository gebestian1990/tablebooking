<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NXDAdminMaster.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="nextdoormarket.Admin.Users" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/loader.css" />
    <style>
        .modalBackground {
            background-color: Gray;
            filter: alpha(opacity=80);
            opacity: 0.8;
            z-index: 10000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:ScriptManager ID="script" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="update" runat="server">
        <ContentTemplate>
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-md-3 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Add User</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Name*</label>
                                        <asp:TextBox ID="txtusername" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Name"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requname" runat="server" ControlToValidate="txtusername" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="reguname" SetFocusOnError="true" ValidationExpression="^([a-zA-Z]+\s)*[a-zA-Z]+$" runat="server" Display="Dynamic" ControlToValidate="txtusername" Text="* Character Only" ValidationGroup="user" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
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
                                        <asp:RegularExpressionValidator ID="regmno" SetFocusOnError="true" ValidationExpression="^([0-9]{10})$" runat="server" Display="Dynamic" ControlToValidate="txtmno" Text="* Numbers With Length 10" ValidationGroup="user" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Password*</label>
                                        <asp:TextBox ID="txtpswd" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="15" TabIndex="4" placeholder="Password" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtpswd" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Roll*</label>
                                        <asp:DropDownList ID="drproll" runat="server" CssClass="form-control" TabIndex="5"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="drproll" InitialValue="0" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Remarks (If Any)</label>
                                        <asp:TextBox ID="txtremarks" CssClass="form-control" runat="server" Rows="40" Height="80px" Columns="40" TabIndex="6" MaxLength="50" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                    <asp:Label ID="lblmsg" runat="server" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btnsubmit" runat="server" ValidationGroup="user" TabIndex="7" CausesValidation="true" UseSubmitBehavior="false" Text="Submit" OnClientClick="if(!Page_ClientValidate('user')){return false;}this.disabled=true;this.value='Submitting..';" OnClick="btnsubmit_Click" class="btn btn-primary me-2" />
                                    <asp:Button ID="btncancel" runat="server" class="btn btn-light" CausesValidation="false" OnClick="btncancel_Click" Text="Cancel" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">User List</h4>
                                <div class="table-responsive">
                                    <asp:GridView ID="grddata" CssClass="table table-striped" EmptyDataText="No Data Found.." AlternatingRowStyle-CssClass="py-1" runat="server" OnRowCommand="grddata_RowCommand" OnRowDeleting="grddata_RowDeleting" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sno.">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                    <asp:HiddenField ID="hfaid" Visible="false" runat="server" Value='<%#Eval("aid") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblname" runat="server" Text='<%#Eval("aname") %>'></asp:Label>
                                                    <asp:HiddenField ID="hfremarks" runat="server" Visible="false" Value='<%#Eval("remarks") %>' />
                                                    <asp:HiddenField ID="hfmail" runat="server" Visible="false" Value='<%#Eval("amail") %>' />
                                                    <asp:HiddenField ID="hfmno" runat="server" Visible="false" Value='<%#Eval("amno") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Roll">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblroll" runat="server" Text='<%#Eval("roll") %>'></asp:Label>
                                                    <asp:HiddenField ID="hfroll" runat="server" Visible="false" Value='<%#Eval("isadmin") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Added By" Visible="false">
                                                <ItemTemplate>
                                                    <%#Eval("mname") %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <%#Eval("astat") %>
                                                    <asp:HiddenField ID="hfstat" runat="server" Value='<%#Eval("isactive") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date">
                                                <ItemTemplate>
                                                    <%#Eval("addedon") %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbnedit" CausesValidation="false" CssClass="badge badge-success" runat="server" Text="Edit" CommandName="delete" CommandArgument="edititem"></asp:LinkButton>
                                                    <asp:LinkButton ID="lnkrights" CausesValidation="false" CssClass="badge badge-dark" runat="server" Text="Rights" CommandName="delete" CommandArgument="editrights"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>

                    <asp:Button ID="btnShowPopup" runat="server" Style="display: none" CausesValidation="false" />
                    <cc1:ModalPopupExtender ID="mpeuser" runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlpopup"
                        CancelControlID="btnclose" BackgroundCssClass="modalBackground">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="pnlpopup" runat="server" Style="display: none; width: auto;">
                        <div class="col-md-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title">Edit User</h4>
                                    <div class="forms-sample">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Name*</label>
                                                    <div class="col-sm-9">
                                                        <asp:HiddenField ID="hfeaid" runat="server" Visible="false" />
                                                        <asp:TextBox ID="txtename" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Name"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvename" runat="server" ControlToValidate="txtename" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="euser" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="regename" SetFocusOnError="true" ValidationExpression="^([a-zA-Z]+\s)*[a-zA-Z]+$" runat="server" Display="Dynamic" ControlToValidate="txtename" Text="* Character Only" ValidationGroup="txtename" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Email-ID*</label>
                                                    <div class="col-sm-9">
                                                        <asp:TextBox ID="txteemail" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="2" placeholder="Email-ID"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfveemail" runat="server" ControlToValidate="txteemail" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="euser" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="regeemail" SetFocusOnError="true" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" runat="server" Display="Dynamic" ControlToValidate="txteemail" Text="* Invalid Email-ID" ValidationGroup="euser" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Mobile Number*</label>
                                                    <div class="col-sm-9">
                                                        <asp:TextBox ID="txtemno" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="10" TabIndex="3" placeholder="Mobile Number"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvemno" runat="server" ControlToValidate="txtemno" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="euser" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="regemno" SetFocusOnError="true" ValidationExpression="^([0-9]{10})$" runat="server" Display="Dynamic" ControlToValidate="txtemno" Text="* Numbers With Length 10" ValidationGroup="euser" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Password*</label>
                                                    <div class="col-sm-9">
                                                        <asp:TextBox ID="txtepswd" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="15" TabIndex="4" placeholder="Password" TextMode="Password"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Roll*</label>
                                                    <div class="col-sm-9">
                                                        <asp:DropDownList ID="drperoll" runat="server" CssClass="form-control" TabIndex="5"></asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfperoll" runat="server" ControlToValidate="drperoll" InitialValue="0" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="euser" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Remarks (If Any)</label>
                                                    <div class="col-sm-9">
                                                        <asp:TextBox ID="txteremarks" CssClass="form-control" runat="server" Rows="40" Height="80px" Columns="40" TabIndex="6" MaxLength="50" TextMode="MultiLine"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Status*</label>
                                                    <div class="col-sm-9">
                                                        <asp:DropDownList ID="drpstatus" runat="server" TabIndex="7" CssClass="form-control form-control-lg">
                                                            <asp:ListItem Value="0" Text="-Select Status-"></asp:ListItem>
                                                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                                            <asp:ListItem Value="2" Text="InActive"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfvstatus" runat="server" InitialValue="0" ControlToValidate="drpstatus" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="euser" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Actions*</label>
                                                    <div class="col-sm-9">
                                                        <asp:Label ID="lblmsg2" runat="server" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                                        <asp:Button ID="btnupdate" runat="server" ValidationGroup="ecdit" CausesValidation="true" TabIndex="8" UseSubmitBehavior="false" Text="Update" OnClick="btnupdate_Click" OnClientClick="if(!Page_ClientValidate('euser')){return false;}this.disabled=true;this.value='Updating..';" class="btn btn-primary me-2" />
                                                        <asp:Button ID="btnclose" runat="server" class="btn btn-light" Text="Close" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
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
                    <img src="images/Fidget-spinner.gif" alt="loading" /></span>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
