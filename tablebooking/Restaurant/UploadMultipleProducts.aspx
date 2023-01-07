<%@ Page Title="" Language="C#" MasterPageFile="~/Restaurant/RestaurantMaster.Master" AutoEventWireup="true" CodeBehind="UploadMultipleProducts.aspx.cs" Inherits="tablebooking.Restaurant.UploadMultipleProducts" %>

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
                                <h4 class="card-title">Upload Multiple Recipes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(<a href="images/DishDetails.xls" download>Download Sample Recipe Format</a>)</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Category*</label>
                                        <asp:DropDownList ID="drpcategory" runat="server" CssClass="form-control" TabIndex="2"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvcategory" runat="server" ControlToValidate="drpcategory" InitialValue="0"
                                            Display="Dynamic" ErrorMessage="* Required" ValidationGroup="recipe" ForeColor="Red"
                                            Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Type*</label>
                                        <asp:DropDownList ID="drpfoodtype" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvfoodtype" runat="server" ControlToValidate="drpfoodtype" InitialValue="0"
                                            Display="Dynamic" ErrorMessage="* Required" ValidationGroup="recipe" ForeColor="Red"
                                            Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Upload Excel File*</label>
                                        <asp:FileUpload ID="fldupload" runat="server" CssClass="form-control"></asp:FileUpload>
                                        <asp:RequiredFieldValidator ID="rfvupload" runat="server" ControlToValidate="fldupload"
                                            Display="Dynamic" ErrorMessage="* Required" ValidationGroup="recipe" ForeColor="Red"
                                            Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <asp:Label ID="lblmsg" runat="server" CssClass="auth-link" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" TabIndex="4" ValidationGroup="recipe"
                                        Style="margin-top: 10px;" OnClick="btnsubmit_Click" CssClass="btn btn-primary"
                                        UseSubmitBehavior="false"
                                        OnClientClick="if (!Page_ClientValidate('recipe')){ return false; } this.disabled = true; this.value = 'Submitting...';" />
                                </div>
                            </div>

                            <div class="card-body">
                                <asp:GridView ID="grddata" runat="server" AutoGenerateColumns="false" EmptyDataText="No Data Found...">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sno.">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Title">
                                            <ItemTemplate>
                                                <asp:Label ID="lbltitle" runat="server" Text='<%#Eval("title") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Category">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcategory" runat="server" Text='<%#Eval("category") %>'></asp:Label>
                                                <asp:HiddenField ID="hfcat" runat="server" Value='<%#Eval("catid") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lbltype" runat="server" Text='<%#Eval("type") %>'></asp:Label>
                                                <asp:HiddenField ID="hftype" runat="server" Value='<%#Eval("typeid") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Details">
                                            <ItemTemplate>
                                                <asp:Label ID="lbldetails" runat="server" Text='<%#Eval("Details") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Price">
                                            <ItemTemplate>
                                                <asp:Label ID="lblprice" runat="server" Text='<%#Eval("price") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Discounted Price">
                                            <ItemTemplate>
                                                <asp:Label ID="lbldiscountedprice" runat="server" Text='<%#Eval("disprice") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Image (Dimension: 255px X 150px)">
                                            <ItemTemplate>
                                                <asp:FileUpload ID="fldimage" runat="server" CssClass="form-control" onchange="return validateFileExtension(this);" />
                                                <asp:RequiredFieldValidator ID="rfvupload" runat="server" ControlToValidate="fldimage"
                                                    Display="Dynamic" ErrorMessage="*" ValidationGroup="image" ForeColor="Red"
                                                    Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:Button ID="btnuploadall" runat="server" Text="Upload Data" ValidationGroup="image" Visible="false"
                                    Style="margin-top: 10px;" OnClick="btnuploadall_Click" CssClass="btn btn-primary"
                                    UseSubmitBehavior="false"
                                    OnClientClick="if (!Page_ClientValidate('image')){ return false; } this.disabled = true; this.value = 'Uploading...';" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnsubmit" />
            <asp:PostBackTrigger ControlID="btnuploadall" />
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
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="server">
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
