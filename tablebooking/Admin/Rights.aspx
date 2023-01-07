<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NXDAdminMaster.Master" AutoEventWireup="true" CodeBehind="Rights.aspx.cs" Inherits="nextdoormarket.Admin.Rights" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/loader.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:ScriptManager ID="script" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="update" runat="server">
        <ContentTemplate>
            <div class="content-wrapper">
                <div class="page-header">
                    <h3 class="page-title">Allot Rights </h3>
                </div>
                <div class="row">
                    <div style="width: auto; overflow: scroll;">
                        <asp:HiddenField ID="hfaid" runat="server" Visible="false" />
                        <asp:DataList ID="dtlistheaders" runat="server" HorizontalAlign="Center" CellSpacing="0" CellPadding="0" CssClass="table table-striped" RepeatDirection="Horizontal">
                            <ItemTemplate>
                                <div class="col-md-3 grid-margin stretch-card" style="width: 100%">
                                    <div class="card">
                                        <div class="card-body">
                                            <h4 class="card-title">
                                                <asp:Label ID="lblheader" runat="server" Text='<%#Eval("header") %>'></asp:Label>
                                                <asp:HiddenField ID="hfheader" runat="server" Value='<%#Eval("hid") %>' />
                                            </h4>
                                            <div class="forms-sample">
                                                <div class="form-check form-check-success">
                                                    <asp:CheckBoxList ID="chksubheaders" BackColor="White" class="form-check-input" runat="server"></asp:CheckBoxList>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                    <div class="col-md-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Actions</h4>
                                <div class="forms-sample">
                                    <asp:Label ID="lblmsg" runat="server" CssClass="auth-link" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btnsubmit" runat="server" TabIndex="1" CausesValidation="true" Text="Allot Rights" OnClick="btnsubmit_Click" class="btn btn-primary me-2" />
                                    <a href="Users.aspx" class="btn btn-light">Back To Previous Page</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="upprogprofile" runat="server" AssociatedUpdatePanelID="update">
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
