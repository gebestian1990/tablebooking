<%@ Page Title="" Language="C#" MasterPageFile="~/Restaurant/RestaurantMaster.Master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="ProductList.aspx.cs" Inherits="tablebooking.Restaurant.ProductList" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
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
                                <h4 class="card-title">Search Product</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <table>
                                            <tr>
                                                <td>
                                                    <label for="validationCustom01">Product Name</label>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtproduct" runat="server" CssClass="form-control" TabIndex="1"></asp:TextBox>
                                                    </div>
                                                </td>
                                                <td></td>
                                                <td>
                                                    <div class="input-group">
                                                        <asp:Button ID="btnsearch" runat="server" Text="Search" TabIndex="2"
                                                            Style="margin-top: 25px;" OnClick="btnsearch_Click" CssClass="btn btn-primary" /><br />
                                                        <asp:Label ID="lblmsg" runat="server" CssClass="auth-link" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <h4 class="card-title">Search Product</h4>
                                    <div class="forms-sample">
                                        <asp:GridView ID="grddata" runat="server" AutoGenerateColumns="false"
                                            CssClass="table table-hover" EmptyDataText="No Data Found..."
                                            OnRowCommand="grddata_RowCommand" OnRowDeleting="grddata_RowDeleting">
                                            <RowStyle CssClass="ms-table-f-w" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sno.">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Title">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hfkitmid" runat="server" Value='<%#Eval("kitmid") %>' />
                                                        <asp:Label ID="lbltitle" runat="server" Text='<%#Eval("itemname") %>'></asp:Label>
                                                        <asp:HiddenField ID="hftitle" runat="server" Value='<%#Eval("itemname") %>' />
                                                        <asp:HiddenField ID="hfdetails" runat="server" Value='<%#Eval("descp") %>' />
                                                        <asp:HiddenField ID="hfstatus" runat="server" Value='<%#Eval("isactive") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Category">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblcategory" runat="server" Text='<%#Eval("foodcategory") %>'></asp:Label>
                                                        <asp:HiddenField ID="hfcat" runat="server" Value='<%#Eval("catid") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Type">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbltype" runat="server" Text='<%#Eval("foodtype") %>'></asp:Label>
                                                        <asp:HiddenField ID="hftype" runat="server" Value='<%#Eval("ftype") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Image">
                                                    <ItemTemplate>
                                                        <asp:Image ID="imgrecipe" runat="server" Width="100px" ImageUrl='<%#Eval("img") %>' />
                                                        <asp:HiddenField ID="hfimg" runat="server" Value='<%#Eval("fimg") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Price">
                                                    <ItemTemplate>
                                                        <%#Eval("price") %>
                                                        <asp:HiddenField ID="hfprice" runat="server" Value='<%#Eval("price") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Discounted Price">
                                                    <ItemTemplate>
                                                        <%#Eval("disprice") %>
                                                        <asp:HiddenField ID="hfdisprice" runat="server" Value='<%#Eval("disprice") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <%#Eval("stat") %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Actions">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkedit" CausesValidation="false" runat="server" Text="Edit"
                                                            CommandArgument="edititem" CommandName="delete" CssClass="auth-link"></asp:LinkButton>
                                                        <asp:LinkButton ID="lnkdelete" CausesValidation="false" CssClass="badge badge-danger"
                                                            runat="server" Text="Delete" CommandName="delete" CommandArgument="deleteitem"
                                                            OnClientClick="if (!confirm('Are you sure you want delete?')) return false;"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                    <div class="form-group">
                                        <asp:Button ID="btnShowPopup" runat="server" Style="display: none" CausesValidation="false" />
                                        <cc1:ModalPopupExtender ID="mperoll" runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlpopup"
                                            CancelControlID="btnclose" BackgroundCssClass="modalBackground">
                                        </cc1:ModalPopupExtender>
                                        <asp:Panel ID="pnlpopup" runat="server" Style="display: none; width: auto;background-color:white">
                                            <div class="ms-panel">
                                                <div class="ms-panel-header">
                                                    <h6>Update Product</h6>
                                                </div>
                                                <div class="ms-panel-body">
                                                    <div class="needs-validation">
                                                        <div class="form-row">
                                                            <div class="col-md-4 mb-3">
                                                                <label for="validationCustom01">Item Name*</label>
                                                                <div class="input-group">
                                                                    <asp:HiddenField ID="hfekitmid" runat="server" />
                                                                    <asp:TextBox ID="txtitem" runat="server" CssClass="form-control" MaxLength="50" TabIndex="1"
                                                                        AutoCompleteType="Disabled" placeholder="Name max 50 words"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="reqtile" runat="server" ControlToValidate="txtitem"
                                                                        Display="Dynamic" ErrorMessage="* Required" ValidationGroup="item" ForeColor="Red"
                                                                        Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4 mb-3">
                                                                <label for="validationCustom01">Category*</label>
                                                                <div class="input-group">
                                                                    <asp:DropDownList ID="drpcategory" runat="server" CssClass="form-control" TabIndex="2"></asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvcategory" runat="server" ControlToValidate="drpcategory" InitialValue="0"
                                                                        Display="Dynamic" ErrorMessage="* Required" ValidationGroup="item" ForeColor="Red"
                                                                        Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4 mb-3">
                                                                <label for="validationCustom01">Type*</label>
                                                                <div class="input-group">
                                                                    <asp:DropDownList ID="drpfoodtype" runat="server" CssClass="form-control" TabIndex="3"></asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvfoodtype" runat="server" ControlToValidate="drpfoodtype" InitialValue="0"
                                                                        Display="Dynamic" ErrorMessage="* Required" ValidationGroup="item" ForeColor="Red"
                                                                        Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4 mb-3">
                                                                <label for="validationCustom02">Item Image* (Dimension: 255px X 150px)</label>
                                                                <div class="input-group">
                                                                    <asp:FileUpload ID="fldimage" runat="server" CssClass="form-control" TabIndex="4"
                                                                        onchange="return validateFileExtension(this);"></asp:FileUpload>
                                                                    <asp:HiddenField ID="hfeimg" runat="server" />
                                                                </div>
                                                            </div>
                                                            <div class="col-md-8 mb-3">
                                                                <label for="validationCustomUsername">Item Details*</label>
                                                                <div class="input-group">
                                                                    <asp:TextBox ID="txtdetails" runat="server" TextMode="MultiLine" TabIndex="5" Height="150px" MaxLength="200"
                                                                        CssClass="form-control" AutoCompleteType="Disabled" placeholder="Details in 200 words"></asp:TextBox>
                                                                    <cc1:HtmlEditorExtender ID="hextdetails" runat="server" TargetControlID="txtdetails" EnableSanitization="false"></cc1:HtmlEditorExtender>
                                                                    <asp:RequiredFieldValidator ID="reqmail" runat="server" ControlToValidate="txtdetails"
                                                                        Display="Dynamic" ErrorMessage="* Required" ForeColor="Red" Font-Bold="true"
                                                                        SetFocusOnError="true" ValidationGroup="item"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-8 mb-3">
                                                                <label for="validationCustomUsername">Item Price*</label>
                                                                <div class="input-group">
                                                                    <asp:TextBox ID="txtprice" runat="server" TabIndex="6"
                                                                        CssClass="form-control" AutoCompleteType="Disabled" placeholder="Price"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvprice" runat="server" ControlToValidate="txtprice"
                                                                        Display="Dynamic" ErrorMessage="* Required" ForeColor="Red" Font-Bold="true"
                                                                        SetFocusOnError="true" ValidationGroup="item"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="regprice" runat="server" ControlToValidate="txtprice" ValidationExpression="^\d+$"
                                                                        Display="Dynamic" ErrorMessage="* Invalid Price" ForeColor="Red" Font-Bold="true"
                                                                        SetFocusOnError="true" ValidationGroup="item"></asp:RegularExpressionValidator>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-8 mb-3">
                                                                <label for="validationCustomUsername">Discounted Item Price*</label>
                                                                <div class="input-group">
                                                                    <asp:TextBox ID="txtdisprice" runat="server" TabIndex="7"
                                                                        CssClass="form-control" AutoCompleteType="Disabled" placeholder="Discounted Price"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvdisprice" runat="server" ControlToValidate="txtdisprice"
                                                                        Display="Dynamic" ErrorMessage="* Required" ForeColor="Red" Font-Bold="true"
                                                                        SetFocusOnError="true" ValidationGroup="item"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="regdisprice" runat="server" ControlToValidate="txtdisprice" ValidationExpression="^\d+$"
                                                                        Display="Dynamic" ErrorMessage="* Invalid Price" ForeColor="Red" Font-Bold="true"
                                                                        SetFocusOnError="true" ValidationGroup="item"></asp:RegularExpressionValidator>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4 mb-3">
                                                                <label for="validationCustom02">Status</label>
                                                                <div class="input-group">
                                                                    <asp:DropDownList ID="drpstatus" runat="server">
                                                                        <asp:ListItem Value="0">InActive</asp:ListItem>
                                                                        <asp:ListItem Value="1">Active</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <asp:Label ID="lblmsg2" runat="server" CssClass="auth-link" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                                            <asp:Button ID="btnupdate" runat="server" Text="Update" TabIndex="4" ValidationGroup="item"
                                                                Style="margin-top: 10px;" OnClick="btnupdate_Click" CssClass="btn btn-primary"
                                                                UseSubmitBehavior="false"
                                                                OnClientClick="if (!Page_ClientValidate('recipe')){ return false; } this.disabled = true; this.value = 'Updating...';" />
                                                            <asp:Button ID="btnclose" runat="server" TabIndex="10" class="btn btn-light" Text="Close" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnsearch" />
            <asp:PostBackTrigger ControlID="btnupdate" />
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
    <script type="text/javascript">
        function validateFileExtension(fld) {
            if (!/(\.png|\.jpg|\.jpeg)$/i.test(fld.value)) {
                alert("Invalid image file type.");
                fld.form.reset();
                fld.focus();
                return false;
            }
            return true;
        } </script>
</asp:Content>

