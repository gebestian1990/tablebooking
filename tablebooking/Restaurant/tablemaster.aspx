<%@ Page Title="" Language="C#" MasterPageFile="~/Restaurant/RestaurantMaster.Master" AutoEventWireup="true" CodeBehind="tablemaster.aspx.cs" Inherits="tablebooking.Restaurant.tablemaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/loader.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel ID="update" runat="server">
        <ContentTemplate>
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-md-4 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Add Table</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Table No.*</label>
                                        <asp:TextBox ID="txttblname" runat="server" CssClass="form-control" Enabled="false" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Table Name"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Alias Table Name*</label>
                                        <asp:TextBox ID="txttblalias" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Alias Table Name"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requname" runat="server" ControlToValidate="txttblalias" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">
                                            Views Near Table (if any e.g Sea View, Window view etc)
                                            <asp:Button ID="btnviews" runat="server" Text="Add View" OnClick="btnviews_Click" /></label>
                                        <asp:DropDownList ID="drpviews" runat="server" CssClass="form-control" TabIndex="2"></asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Seats Available*</label>
                                        <asp:TextBox ID="txtseats" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="10" TabIndex="3" placeholder="Seats Available"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvmno" runat="server" ControlToValidate="txtseats" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="regmno" SetFocusOnError="true" ValidationExpression="^(0|[1-9]\d*)$" runat="server" Display="Dynamic" ControlToValidate="txtseats" Text="* Numbers only" ValidationGroup="user" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Seats Capping (if Any)</label>
                                        <asp:TextBox ID="txtseatscapping" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="10" TabIndex="3" placeholder="Seats Capping (if Any)"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" SetFocusOnError="true" ValidationExpression="^(0|[1-9]\d*)$" runat="server" Display="Dynamic" ControlToValidate="txtseatscapping" Text="* Numbers Only" ValidationGroup="user" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
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
                    <div class="col-md-8 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Table List</h4>
                                <div class="table-responsive">
                                    <asp:GridView ID="grddata" CssClass="table table-striped" EmptyDataText="No Data Found.." AlternatingRowStyle-CssClass="py-1" runat="server" OnRowCommand="grddata_RowCommand" OnRowDeleting="grddata_RowDeleting" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sno.">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                    <asp:HiddenField ID="tblid" Visible="false" runat="server" Value='<%#Eval("tblid") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Table">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblname" runat="server" Text='<%#Eval("tblname") %>'></asp:Label>
                                                    <asp:HiddenField ID="hfremarks" runat="server" Visible="false" Value='<%#Eval("remarks") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Details">
                                                <ItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td>Alias Name</td>
                                                            <td>:</td>
                                                            <td>
                                                                <asp:Label ID="lblalias" runat="server" Text='<%#Eval("tblalias") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Views</td>
                                                            <td>:</td>
                                                            <td>
                                                                <asp:Label ID="lblviews" runat="server" Text='<%#Eval("vws") %>'></asp:Label><asp:HiddenField ID="hfviews" runat="server" Visible="false" Value='<%#Eval("viewid") %>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Seats</td>
                                                            <td>:</td>
                                                            <td>
                                                                <asp:Label ID="lblseats" runat="server" Text='<%#Eval("seats") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Capping</td>
                                                            <td>:</td>
                                                            <td>
                                                                <asp:Label ID="lblcapping" runat="server" Text='<%#Eval("capping") %>'></asp:Label></td>
                                                        </tr>
                                                    </table>
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
                                            <asp:TemplateField HeaderText="Actions">
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


                    <asp:Button ID="btneviewspopup" runat="server" Style="display: none" CausesValidation="false" />
                    <cc1:ModalPopupExtender ID="mpeviewspopup" runat="server" TargetControlID="btneviewspopup" PopupControlID="pnlvwpopup"
                        CancelControlID="btnvwclose" BackgroundCssClass="modalBackground">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="pnlvwpopup" runat="server" Style="display: none; width: auto;">
                        <div class="col-md-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title">Add Views</h4>
                                    <div class="forms-sample">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">View Name*</label>
                                                    <div class="col-sm-9">
                                                        <asp:TextBox ID="txtvwname" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="View Name"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtvwname" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="vwuser" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Actions*</label>
                                                    <div class="col-sm-9">
                                                        <asp:Label ID="lblvwmsg" runat="server" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                                        <asp:Button ID="btnaddviews" runat="server" ValidationGroup="vwuser" CausesValidation="true" TabIndex="8" UseSubmitBehavior="false" Text="Update" OnClick="btnaddviews_Click" OnClientClick="if(!Page_ClientValidate('vwuser')){return false;}this.disabled=true;this.value='Updating..';" class="btn btn-primary me-2" />
                                                        <asp:Button ID="btnvwclose" runat="server" class="btn btn-light" Text="Close" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Button ID="btnShowPopup" runat="server" Style="display: none" CausesValidation="false" />
                    <cc1:ModalPopupExtender ID="mpeuser" runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlpopup"
                        CancelControlID="btnclose" BackgroundCssClass="modalBackground">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="pnlpopup" runat="server" Style="display: none; width: auto;">
                        <div class="col-md-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title">Edit Table</h4>
                                    <div class="forms-sample">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Alias Table Name*</label>
                                                    <div class="col-sm-9">
                                                        <asp:HiddenField ID="hfetblid" Visible="false" runat="server" />
                                                        <asp:TextBox ID="txttblealias" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Alias Table Name"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqeuname" runat="server" ControlToValidate="txttblealias" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="euser" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Views Near Table</label>
                                                    <div class="col-sm-9">
                                                        <asp:DropDownList ID="drpeviews" runat="server" CssClass="form-control" TabIndex="2"></asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Seats Available*</label>
                                                    <div class="col-sm-9">
                                                        <asp:TextBox ID="txteseats" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="10" TabIndex="3" placeholder="Seats Available"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfevmno" runat="server" ControlToValidate="txteseats" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="euser" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="regemno" SetFocusOnError="true" ValidationExpression="^(0|[1-9]\d*)$" runat="server" Display="Dynamic" ControlToValidate="txteseats" Text="* Numbers Only" ValidationGroup="euser" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Seats Capping (if Any)*</label>
                                                    <div class="col-sm-9">
                                                        <asp:TextBox ID="txteseatscapping" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="10" TabIndex="3" placeholder="Seats Capping (if Any)"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="regecapping" SetFocusOnError="true" ValidationExpression="^(0|[1-9]\d*)$" runat="server" Display="Dynamic" ControlToValidate="txteseatscapping" Text="* Numbers Only" ValidationGroup="euser" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
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
                                                        <asp:Button ID="btnupdate" runat="server" ValidationGroup="euser" CausesValidation="true" TabIndex="8" UseSubmitBehavior="false" Text="Update" OnClick="btnupdate_Click" OnClientClick="if(!Page_ClientValidate('euser')){return false;}this.disabled=true;this.value='Updating..';" class="btn btn-primary me-2" />
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
            <asp:AsyncPostBackTrigger ControlID="btnviews" EventName="Click" />
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
