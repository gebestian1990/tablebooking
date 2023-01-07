<%@ Page Title="" Language="C#" MasterPageFile="~/Restaurant/RestaurantMaster.Master" AutoEventWireup="true" CodeBehind="AddProducts.aspx.cs" Inherits="tablebooking.Restaurant.AddProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel ID="update" runat="server">
        <ContentTemplate>
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-md-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Restaurant Profile</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Item Name*</label>
                                        <asp:TextBox ID="txtitem" runat="server" CssClass="form-control" MaxLength="50" TabIndex="1"
                                            AutoCompleteType="Disabled" placeholder="Name max 50 words"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqtile" runat="server" ControlToValidate="txtitem"
                                            Display="Dynamic" ErrorMessage="* Required" ValidationGroup="item" ForeColor="Red"
                                            Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Category*</label>
                                        <asp:DropDownList ID="drpcategory" runat="server" CssClass="form-control" TabIndex="2"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvcategory" runat="server" ControlToValidate="drpcategory" InitialValue="0"
                                            Display="Dynamic" ErrorMessage="* Required" ValidationGroup="item" ForeColor="Red"
                                            Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Type*</label>
                                        <asp:DropDownList ID="drpfoodtype" runat="server" CssClass="form-control" TabIndex="3"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvfoodtype" runat="server" ControlToValidate="drpfoodtype" InitialValue="0"
                                            Display="Dynamic" ErrorMessage="* Required" ValidationGroup="item" ForeColor="Red"
                                            Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Item Image* (Dimension: 255px X 150px)</label>
                                        <asp:FileUpload ID="fldimage" runat="server" CssClass="form-control" TabIndex="4" onchange="return validateFileExtension(this);"></asp:FileUpload>
                                        <asp:RequiredFieldValidator ID="reqimage" runat="server" ControlToValidate="fldimage"
                                            Display="Dynamic" ErrorMessage="* Required" ValidationGroup="item" ForeColor="Red"
                                            Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Item Details*</label>
                                        <asp:TextBox ID="txtdetails" runat="server" TextMode="MultiLine" TabIndex="5" Height="300px" MaxLength="200"
                                            CssClass="form-control" AutoCompleteType="Disabled" placeholder="Details in 200 words"></asp:TextBox>
                                        <ajaxToolkit:HtmlEditorExtender ID="hextdetails" runat="server" TargetControlID="txtdetails" EnableSanitization="false"></ajaxToolkit:HtmlEditorExtender>
                                        <asp:RequiredFieldValidator ID="reqmail" runat="server" ControlToValidate="txtdetails"
                                            Display="Dynamic" ErrorMessage="* Required" ForeColor="Red" Font-Bold="true"
                                            SetFocusOnError="true" ValidationGroup="item"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Item Price*</label>
                                        <asp:TextBox ID="txtprice" runat="server" TabIndex="6"
                                            CssClass="form-control" AutoCompleteType="Disabled" placeholder="Price"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvprice" runat="server" ControlToValidate="txtprice"
                                            Display="Dynamic" ErrorMessage="* Required" ForeColor="Red" Font-Bold="true"
                                            SetFocusOnError="true" ValidationGroup="item"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="regprice" runat="server" ControlToValidate="txtprice" ValidationExpression="^\d+$"
                                            Display="Dynamic" ErrorMessage="* Invalid Price" ForeColor="Red" Font-Bold="true"
                                            SetFocusOnError="true" ValidationGroup="item"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Discounted Item Price*</label>
                                        <asp:TextBox ID="txtdisprice" runat="server" TabIndex="7"
                                            CssClass="form-control" AutoCompleteType="Disabled" placeholder="Discounted Price"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvdisprice" runat="server" ControlToValidate="txtdisprice"
                                            Display="Dynamic" ErrorMessage="* Required" ForeColor="Red" Font-Bold="true"
                                            SetFocusOnError="true" ValidationGroup="item"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="regdisprice" runat="server" ControlToValidate="txtdisprice" ValidationExpression="^\d+$"
                                            Display="Dynamic" ErrorMessage="* Invalid Price" ForeColor="Red" Font-Bold="true"
                                            SetFocusOnError="true" ValidationGroup="item"></asp:RegularExpressionValidator>
                                    </div>
                                    <asp:Label ID="lblmsg" runat="server" CssClass="auth-link" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" TabIndex="8" ValidationGroup="recipe"
                                        Style="margin-top: 10px;" OnClick="btnsubmit_Click" CssClass="btn btn-primary"
                                        UseSubmitBehavior="false"
                                        OnClientClick="if (!Page_ClientValidate()){ return false; } this.disabled = true; this.value = 'Submitting...';" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnsubmit" />
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
