<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="tablebooking.Restaurant.index" %>

<!DOCTYPE html>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Restaurant Table Booking</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta http-equiv="Cache-Control" content="no-cache" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <!-- plugins:css -->
    <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css" />
    <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css" />
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="assets/css/style.css" />
    <!-- End layout styles -->
    <link rel="shortcut icon" href="assets/images/favicon.png" />
    <link rel="stylesheet" href="assets/css/loader.css" />
     <script type="text/javascript">
         function preventBack() { window.history.forward(); }
         setTimeout("preventBack()", 0);
         window.onunload = function () { null };
    </script>
</head>
<body>
    <form id="form1" runat="server" autocomplete="off">
        <asp:ScriptManager ID="script" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="uplogin" runat="server">
            <ContentTemplate>
                <div class="container-scroller">
                    <div class="container-fluid page-body-wrapper full-page-wrapper">
                        <div class="content-wrapper d-flex align-items-center auth">
                            <div class="row flex-grow">
                                <div class="col-lg-4 mx-auto">
                                    <div class="auth-form-light text-left p-5">
                                        <div class="brand-logo text-center">
                                            <img src="assets/images/logo.png" />
                                        </div>
                                        <h4 class="font-weight-light text-center">Table Booking</h4>
                                        <h6 class="font-weight-light text-center">Restaurant Panel</h6>
                                        <div id="login" runat="server" class="pt-3">
                                            <div class="form-group">
                                                <asp:TextBox ID="txtemail" runat="server"
                                                    class="form-control form-control-lg" placeholder="your@email.com" TabIndex="1" MaxLength="30"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqemail" runat="server" Text="* Required Email"
                                                    Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtemail"
                                                    ValidationGroup="login" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="regemail" SetFocusOnError="true"
                                                    ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtemail" Text="* Invalid Email"
                                                    ValidationGroup="login" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                            </div>
                                            <div class="form-group">
                                                <asp:TextBox ID="txtpswd" runat="server" TabIndex="2"
                                                    class="form-control form-control-lg" placeholder="Password"
                                                    TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqpswd" runat="server" SetFocusOnError="true"
                                                    Text="* Required Password" Display="Dynamic" ControlToValidate="txtpswd"
                                                    ValidationGroup="login" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="mt-3">
                                                <asp:Label ID="lblmsg" runat="server" CssClass="auth-link" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label>
                                                <asp:Button ID="btnlogin" runat="server" TabIndex="3" OnClick="btnlogin_Click"
                                                    class="btn btn-block btn-gradient-dark btn-lg font-weight-medium auth-form-btn"
                                                    UseSubmitBehavior="false"
                                                    OnClientClick="if(!Page_ClientValidate('login')){return false;} this.disabled=true;this.value='SIGNING IN..';"
                                                    ValidationGroup="login"
                                                    Text="Sign In" />
                                            </div>
                                            <div class="my-2 d-flex justify-content-between align-items-center">
                                                <asp:LinkButton ID="lnkforgotpswd" runat="server" TabIndex="4"
                                                    Text="Forgot password?" OnClick="lnkforgotpswd_Click"
                                                    CssClass="auth-link text-black"></asp:LinkButton>
                                            </div>
                                        </div>
                                        <div class="pt-3" id="forgot" runat="server">
                                            <div class="form-group">
                                                <asp:TextBox ID="txtfemail" TabIndex="1" MaxLength="30" AutoCompleteType="Disabled"
                                                    CssClass="form-control form-control-lg" runat="server" placeholder="your@email.com"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqfemail" runat="server" Text="* Required Email"
                                                    Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtfemail"
                                                    ValidationGroup="flogin" CssClass="auth-link" ForeColor="Red"
                                                    Style="font-weight: bold"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="regfemail" SetFocusOnError="true"
                                                    ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                                                    runat="server" Display="Dynamic" ControlToValidate="txtemail" Text="* Invalid Email"
                                                    ValidationGroup="flogin" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold"></asp:RegularExpressionValidator>
                                            </div>
                                            <div class="mt-3">
                                                <asp:Label ID="lblfmsg" runat="server" CssClass="auth-link"
                                                    Style="font-weight: bold; margin-bottom: 10px;"></asp:Label>
                                                <asp:Button ID="btnforgot" runat="server" TabIndex="2"
                                                    Text="Forgot Password" OnClick="btnforgot_Click" UseSubmitBehavior="false"
                                                    OnClientClick="if(!Page_ClientValidate('flogin')){return false;} this.disabled=true;this.value='Sending Mail';"
                                                    ValidationGroup="flogin" CssClass="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" />
                                            </div>
                                            <div class="my-2 d-flex justify-content-between align-items-center">
                                                <asp:LinkButton ID="lnklogin" runat="server" Text="Back To Login"
                                                    OnClick="lnklogin_Click" TabIndex="3" CssClass="auth-link text-black"></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- content-wrapper ends -->
                    </div>
                    <!-- page-body-wrapper ends -->
                </div>
                <!-- container-scroller -->
                <!-- plugins:js -->
                <script src="assets/vendors/js/vendor.bundle.base.js"></script>
                <!-- endinject -->
                <!-- Plugin js for this page -->
                <!-- End plugin js for this page -->
                <!-- inject:js -->
                <script src="assets/js/off-canvas.js"></script>
                <script src="assets/js/hoverable-collapse.js"></script>
                <script src="assets/js/misc.js"></script>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="upprogindex" runat="server" AssociatedUpdatePanelID="uplogin">
            <ProgressTemplate>
                <div id="loadmodal">
                    <span id="loadercenter">
                        <img src="assets/images/loading.gif" alt="loading" /></span>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <!-- endinject -->
    </form>
</body>
</html>

