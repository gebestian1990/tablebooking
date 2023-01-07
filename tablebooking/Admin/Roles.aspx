<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NXDAdminMaster.Master" AutoEventWireup="true" CodeBehind="Roles.aspx.cs" Inherits="nextdoormarket.Admin.Roles" %>
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
    <asp:UpdatePanel ID="updateroles" runat="server">
        <ContentTemplate>
            <div class="content-wrapper">
                <div class="page-header">
                    <h3 class="page-title">Roles </h3>
                </div>
                <div class="row">
                    <div class="col-md-3 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Add Roles</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Roll*</label>
                                        <asp:TextBox ID="txtroll" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="20" TabIndex="1" placeholder="Roll"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqroll" runat="server" ControlToValidate="txtroll" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="roll" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="regroll" SetFocusOnError="true" ValidationExpression="^([a-zA-Z]+\s)*[a-zA-Z]+$" runat="server" Display="Dynamic" ControlToValidate="txtroll" Text="* Character Only" ValidationGroup="roll" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Remarks (If Any)</label>
                                        <asp:TextBox ID="txtremarks" CssClass="form-control" runat="server" Rows="40" Height="80px" Columns="40" TabIndex="2" MaxLength="50" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                    <asp:Label ID="lblmsg" runat="server" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btnsubmit" runat="server" ValidationGroup="roll" CausesValidation="true" UseSubmitBehavior="false" Text="Submit" OnClientClick="if(!Page_ClientValidate('roll')){return false;}this.disabled=true;this.value='Submitting..';" OnClick="btnsubmit_Click" class="btn btn-primary me-2" />
                                    <asp:Button ID="btncancel" runat="server" CausesValidation="false" class="btn btn-light" OnClick="btncancel_Click" Text="Cancel" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Roles List</h4>
                                <div class="table-responsive">
                                    <asp:GridView ID="grddata" CssClass="table table-striped" EmptyDataText="No Data Found.." AlternatingRowStyle-CssClass="py-1" runat="server" OnRowCommand="grddata_RowCommand" OnRowDeleting="grddata_RowDeleting" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sno.">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                    <asp:HiddenField ID="hfrid" Visible="false" runat="server" Value='<%#Eval("rid") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Roll">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblroll" runat="server" Text='<%#Eval("roll") %>'></asp:Label>
                                                    <asp:HiddenField ID="hfremarks" runat="server" Visible="false" Value='<%#Eval("remarks") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <%#Eval("stat") %>
                                                    <asp:HiddenField ID="hfstat" runat="server" Value='<%#Eval("isactive") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date">
                                                <ItemTemplate>
                                                    <%#Eval("addedon") %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbnedit" CausesValidation="false" CssClass="badge badge-success" runat="server" Text="Edit" CommandName="delete" CommandArgument="edititem"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>

                    <asp:Button ID="btnShowPopup" runat="server" Style="display: none" CausesValidation="false" />
                    <cc1:modalpopupextender id="mperoll" runat="server" targetcontrolid="btnShowPopup" popupcontrolid="pnlpopup"
                        cancelcontrolid="btnclose" backgroundcssclass="modalBackground">
                </cc1:modalpopupextender>
                    <asp:Panel ID="pnlpopup" runat="server" Style="display: none; width: auto;">
                        <div class="col-md-12 grid-margin stretch-card">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title">Edit Roles</h4>
                                    <div class="forms-sample">
                                        <div class="form-group">
                                            <label for="exampleInputUsername1">Edit Roll*   </label>
                                            <asp:TextBox ID="txteditroll" runat="server" AutoCompleteType="Disabled" CssClass="form-control" MaxLength="30" TabIndex="1" placeholder="Edit Roll"></asp:TextBox>
                                            <asp:HiddenField ID="hferid" runat="server" Visible="false" />
                                            <asp:RequiredFieldValidator ID="rfveditroll" runat="server" ControlToValidate="txteditroll" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="ecdit" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="regeditroll" SetFocusOnError="true" ValidationExpression="^([a-zA-Z]+\s)*[a-zA-Z]+$" runat="server" Display="Dynamic" ControlToValidate="txteditroll" Text="* Character Only" ValidationGroup="ecdit" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputEmail1">Edit Remarks (If Any)</label>
                                            <asp:TextBox ID="txteditreamrks" CssClass="form-control" runat="server" Height="80px" Rows="10" Columns="40" TabIndex="2" MaxLength="50" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputEmail1">Status</label>
                                            <asp:DropDownList ID="drpstatus" runat="server" CssClass="form-control form-control-lg">
                                                <asp:ListItem Value="0" Text="-Select Status-"></asp:ListItem>
                                                <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="InActive"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvstatus" runat="server" InitialValue="0" ControlToValidate="drpstatus" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="ecdit" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        </div>
                                        <asp:Label ID="lblmsg2" runat="server" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                        <asp:Button ID="btnupdate" runat="server" ValidationGroup="ecdit" CausesValidation="true" UseSubmitBehavior="false" Text="Update" OnClick="btnupdate_Click" OnClientClick="if(!Page_ClientValidate('ecdit')){return false;}this.disabled=true;this.value='Updating..';" class="btn btn-primary me-2" />
                                        <asp:Button ID="btnclose" runat="server" class="btn btn-light" Text="Close" />
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
    <asp:UpdateProgress ID="upprogprofile" runat="server" AssociatedUpdatePanelID="updateroles">
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
