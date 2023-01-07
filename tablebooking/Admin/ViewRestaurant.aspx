<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NXDAdminMaster.Master" AutoEventWireup="true" CodeBehind="ViewRestaurant.aspx.cs" Inherits="tablebooking.Admin.ViewRestaurant" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="assets/css/loader.css" />
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
                    <div class="col-md-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Search</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <table>
                                            <tr>
                                                <td style="width: 100%">
                                                    <asp:TextBox ID="txtsearchrestraurant" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Search by Restaurant Name"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvsrch" runat="server" ControlToValidate="txtsearchrestraurant" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="srch2" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator></td>
                                                <td style="width: 20%">
                                                    <asp:Button ID="btnsearch" runat="server" ValidationGroup="srch2" CausesValidation="true" UseSubmitBehavior="false" Text="Search" OnClientClick="if(!Page_ClientValidate('srch')){return false;}this.disabled=true;this.value='Searching..';" OnClick="btnsearch_Click" class="btn btn-primary me-2" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <h4 class="card-title">Restaurant List</h4>
                                <div class="table-responsive">
                                    <asp:GridView ID="grddata" CssClass="table table-striped" EmptyDataText="No Data Found.." AlternatingRowStyle-CssClass="py-1" runat="server" OnRowCommand="grddata_RowCommand" OnRowDeleting="grddata_RowDeleting" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sno.">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                    <asp:HiddenField ID="hfrestid" Visible="false" runat="server" Value='<%#Eval("restid") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Restaurant">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblname" runat="server" Text='<%#Eval("restname") %>'></asp:Label>
                                                    <asp:HiddenField ID="hfmail" runat="server" Visible="false" Value='<%#Eval("rmail") %>' />
                                                    <asp:HiddenField ID="hfmno" runat="server" Visible="false" Value='<%#Eval("cpno") %>' />
                                                    <asp:HiddenField ID="hfcpname" runat="server" Visible="false" Value='<%#Eval("cpname") %>' />
                                                    <asp:HiddenField ID="hfexpdate" runat="server" Visible="false" Value='<%#Eval("expdate") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Details">
                                                <ItemTemplate>
                                                    <table border="1">
                                                        <tr>
                                                            <td>Contact Person</td>
                                                            <td>:</td>
                                                            <td><%#Eval("cpname") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Email-ID</td>
                                                            <td>:</td>
                                                            <td><%#Eval("rmail") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Contact No.</td>
                                                            <td>:</td>
                                                            <td><%#Eval("cpno") %></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Expiry</td>
                                                            <td>:</td>
                                                            <td><%#Eval("expdate") %></td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Added By" Visible="false">
                                                <ItemTemplate>
                                                    <%#Eval("aname") %>
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
                                                    <asp:LinkButton ID="lbnedit" CausesValidation="false" CssClass="badge badge-success" runat="server" Text="Edit" CommandName="delete" CommandArgument="edititem"></asp:LinkButton><br />
                                                    <br />
                                                    <asp:LinkButton ID="lnkbooking" CausesValidation="false" CssClass="badge badge-dark" runat="server" Text="Bookings" CommandName="delete" CommandArgument="viewbookings"></asp:LinkButton>
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
                                    <h4 class="card-title">Edit Restaurant</h4>
                                    <div class="forms-sample">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Restaurant Name*</label>
                                                    <div class="col-sm-9">
                                                        <asp:HiddenField ID="hferestid" runat="server" Visible="false" />
                                                        <asp:TextBox ID="txtrname" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Name"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="requname" runat="server" ControlToValidate="txtrname" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="euser" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="reguname" SetFocusOnError="true" ValidationExpression="^([a-zA-Z]+\s)*[a-zA-Z]+$" runat="server" Display="Dynamic" ControlToValidate="txtrname" Text="* Character Only" ValidationGroup="euser" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Contact Person*</label>
                                                    <div class="col-sm-9">
                                                        <asp:TextBox ID="txtcpname" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Contact Person"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtcpname" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="euser" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" SetFocusOnError="true" ValidationExpression="^([a-zA-Z]+\s)*[a-zA-Z]+$" runat="server" Display="Dynamic" ControlToValidate="txtcpname" Text="* Character Only" ValidationGroup="euser" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
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
                                                    <label class="col-sm-3 col-form-label">Expiry Days*</label>
                                                    <div class="col-sm-9">
                                                        <asp:TextBox ID="txtexpdays" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Expiry Days"></asp:TextBox>
                                                        <asp:Label ID="lblexpdate" runat="server"></asp:Label>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" SetFocusOnError="true" ValidationExpression="^-?[1-9]+([0-9]+)*$" runat="server" Display="Dynamic" ControlToValidate="txtexpdays" Text="* Integers Only" ValidationGroup="euser" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
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

                    <asp:Button ID="btnshowpop2" runat="server" Style="display: none" CausesValidation="false" />
                    <cc1:ModalPopupExtender ID="mpesrch" runat="server" TargetControlID="btnshowpop2" PopupControlID="pnlsrch"
                        CancelControlID="btnpopclose" BackgroundCssClass="modalBackground">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="pnlsrch" runat="server" Style="display: none; width: auto;">
                        <div class="col-md-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title">Bookings</h4>
                                    <div class="forms-sample">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group row">
                                                    <div class="col-sm-12">
                                                        <asp:HiddenField ID="hfpoprestid" runat="server" />
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="txtfdate" runat="server" CssClass="form-control" placeholder="From Date: dd/mm/yyyy"></asp:TextBox></td>
                                                                <cc1:CalendarExtender ID="clndrfrom" Format="dd/MM/yyyy" TargetControlID="txtfdate" runat="server" />
                                                                <asp:RequiredFieldValidator ID="rfvfdate" runat="server" ControlToValidate="txtfdate"
                                                                    SetFocusOnError="true" Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="srch"></asp:RequiredFieldValidator>
                                                                <td>
                                                                    <asp:TextBox ID="txttodate" runat="server" CssClass="form-control" placeholder="To Date: dd/mm/yyyy"></asp:TextBox></td>
                                                                <cc1:CalendarExtender ID="clndrto" Format="dd/MM/yyyy" TargetControlID="txttodate" runat="server" />
                                                                <asp:RequiredFieldValidator ID="rfvtodate" runat="server" ControlToValidate="txttodate"
                                                                    SetFocusOnError="true" Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="srch"></asp:RequiredFieldValidator>
                                                                <td>
                                                                    <asp:Button ID="btnsrchdate" runat="server" CssClass="btn-dark" Text="Search" ValidationGroup="srch" OnClick="btnsrchdate_Click1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <asp:GridView ID="grdsrchbookings" CssClass="table table-striped" EmptyDataText="No Data Found.." AlternatingRowStyle-CssClass="py-1" runat="server" AutoGenerateColumns="false">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Sno.">
                                                                    <ItemTemplate>
                                                                        <%#Container.DataItemIndex+1 %>
                                                                        <asp:HiddenField ID="tblid" Visible="false" runat="server" Value='<%#Eval("ubookid") %>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Table">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblname" runat="server" Text='<%#Eval("tblname") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Details">
                                                                    <ItemTemplate>
                                                                        <table>
                                                                            <tr>
                                                                                <td>Persons</td>
                                                                                <td>:</td>
                                                                                <td>
                                                                                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("npersons") %>'></asp:Label></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>Booking</td>
                                                                                <td>:</td>
                                                                                <td>
                                                                                    <asp:Label ID="Label2" runat="server" Text='<%#Eval("bookdt") %>'></asp:Label></td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Customer">
                                                                    <ItemTemplate>
                                                                        <table>
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
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Booked On">
                                                                    <ItemTemplate>
                                                                        <%#Eval("addedon") %>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group row">
                                                    <label class="col-sm-3 col-form-label">Actions*</label>
                                                    <div class="col-sm-9">
                                                        <asp:Button ID="btnpopclose" runat="server" class="btn btn-light" Text="Close" />
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
            <asp:AsyncPostBackTrigger ControlID="btnupdate" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnsearch" EventName="Click" />
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
</asp:Content>
