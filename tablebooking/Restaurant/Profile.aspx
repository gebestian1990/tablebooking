<%@ Page Title="" Language="C#" MasterPageFile="~/Restaurant/RestaurantMaster.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="tablebooking.Restaurant.Profile" %>

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
                                <h4 class="card-title">Restaurant Profile</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Restaurant Name*</label>
                                        <asp:TextBox ID="txtrname" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="1" placeholder="Name"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="requname" runat="server" ControlToValidate="txtrname" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="reguname" SetFocusOnError="true" ValidationExpression="^([a-zA-Z]+\s)*[a-zA-Z]+$" runat="server" Display="Dynamic" ControlToValidate="txtrname" Text="* Character Only" ValidationGroup="user" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Tagline (If Any)</label>
                                        <asp:TextBox ID="txttagline" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="100" TabIndex="2" placeholder="Tagline (If Any)"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Contact Person*</label>
                                        <asp:TextBox ID="txtcpname" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="3" placeholder="Contact Person"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtcpname" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" SetFocusOnError="true" ValidationExpression="^([a-zA-Z]+\s)*[a-zA-Z]+$" runat="server" Display="Dynamic" ControlToValidate="txtcpname" Text="* Character Only" ValidationGroup="user" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Email-ID*</label>
                                        <asp:TextBox ID="txtmailid" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="30" TabIndex="4" placeholder="Email-ID"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvmailid" runat="server" ControlToValidate="txtmailid" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="regmailid" SetFocusOnError="true" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" runat="server" Display="Dynamic" ControlToValidate="txtmailid" Text="* Invalid Email-ID" ValidationGroup="user" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Mobile Number*</label>
                                        <asp:TextBox ID="txtmno" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="10" TabIndex="5" placeholder="Mobile Number"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvmno" runat="server" ControlToValidate="txtmno" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Password*</label>
                                        <asp:TextBox ID="txtpswd" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="15" TabIndex="6" placeholder="Password" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtpswd" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Logo</label>
                                        <asp:HiddenField ID="hflogo" runat="server" />
                                        <asp:FileUpload ID="fldlogo" runat="server" CssClass="form-control" TabIndex="7" onchange="return validateFileExtension(this);" />
                                        <asp:Image ID="imglogo" runat="server" Width="100" />
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Longitude* <a href="javascript:void(0)" style="text-decoration: underline;" onclick="getLocation()">Share Location</a></label>
                                        <asp:TextBox ID="txtlongitude" runat="server" CssClass="form-control" MaxLength="20" TabIndex="2"
                                            AutoCompleteType="Disabled" placeholder="Longitude"></asp:TextBox>
                                        <asp:HiddenField ID="hflongitude" runat="server" />
                                        <asp:RequiredFieldValidator ID="rfvlongitude" runat="server" ControlToValidate="txtlongitude"
                                            Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user"
                                            ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Latitude* <a href="javascript:void(0)" style="text-decoration: underline;" onclick="getLocation()">Share Location</a></label>
                                        <asp:TextBox ID="txtlatitude" runat="server" CssClass="form-control" MaxLength="20" TabIndex="2"
                                            AutoCompleteType="Disabled" placeholder="Latitude"></asp:TextBox>
                                        <asp:HiddenField ID="hflatitude" runat="server" />
                                        <asp:RequiredFieldValidator ID="rfvlatitude" runat="server" ControlToValidate="txtlatitude"
                                            Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user"
                                            ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Delivery Time Per Mile(Minutes)*</label>
                                        <asp:TextBox ID="txtdeltime" runat="server" TabIndex="6"
                                            CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvdeltime" runat="server" ControlToValidate="txtdeltime"
                                            Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user"
                                            ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Delivery Within Radius*</label>
                                        <asp:TextBox ID="txtdelradius" runat="server" TabIndex="6"
                                            CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvdelradius" runat="server" ControlToValidate="txtdelradius"
                                            Display="Dynamic" ErrorMessage="* Required" ValidationGroup="user"
                                            ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <asp:Label ID="lblmsg" runat="server" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btnsubmit" runat="server" ValidationGroup="user" TabIndex="8" CausesValidation="true" UseSubmitBehavior="false" Text="Submit" OnClientClick="if(!Page_ClientValidate('user')){return false;}this.disabled=true;this.value='Submitting..';" OnClick="btnsubmit_Click" class="btn btn-primary me-2" />
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
    <script>
        getLocation();
        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition);
            } else {
                x.innerHTML = "Geolocation is not supported by this browser.";
            }
        }

        function showPosition(position) {
            $("#body_txtlongitude").val(position.coords.longitude);
            $("#body_hflongitude").val(position.coords.longitude);
            $("#body_txtlatitude").val(position.coords.latitude);
            $("#body_hflatitude").val(position.coords.latitude);
        }
    </script>
</asp:Content>
