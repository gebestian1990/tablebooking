<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="tablebooking.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="apple-mobile-web-app-title" content="TableBooking" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>Restaurant Table Booking</title>
    <link rel="stylesheet" href="css/normalize.min.css" />
    <link rel='stylesheet' href='css/bootstrap.css' />
    <link rel='stylesheet' href='css/intlTelInput.css' />
    <link rel='stylesheet' href='css/ionicons.min.css' />
    <link rel='stylesheet' href='css/nice-select.min.css' />
    <link rel="stylesheet" href="css/formstyle.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" />
    <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css' />

    <script>
        if (document.location.search.match(/type=embed/gi)) {
            window.parent.postMessage("resize", "*");
        }
    </script>
</head>
<body translate="no">
    <!-- Multi step form -->
    <section class="multi_step_form">
        <form id="msform" runat="server">
            <asp:ScriptManager ID="script" runat="server"></asp:ScriptManager>
            <!-- Title -->
            <div class="tittle">
                <asp:Image ID="imglogo" runat="server" Style="float: left; margin-left: 20px;" Width="80" />
                <h2>Booking at
                    <asp:Label ID="lblrestname" runat="server"></asp:Label></h2>
                <p>
                    on
                    <asp:Label ID="lblbookingdetails" runat="server"></asp:Label>
                </p>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <style>
                            .space label {
                                margin-left: 5px;
                                margin-right: 5px;
                            }
                        </style>
                        <center>
                        <span style="color:red;font-weight:bold">Delivery Option:</span> <asp:RadioButtonList ID="rdbdeltypes" runat="server" RepeatDirection="Horizontal"
                            CssClass="space">
                        </asp:RadioButtonList>
                            </center>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="rdbdeltypes" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <br />
                <button type="button" id="btncart" onclick="togglePopup()" class="action-button">View Cart(<span id="ttlitems">0</span>)</button>
                <button type="button" id="btncartcontinue" class="action-button previous_button" onclick="chkcartdetails()">Continue</button>
                <div class="content">
                    <div style="height: 200px; overflow: scroll;">
                        <div onclick="togglePopup()" class="close-btn">
                            ×
                        </div>
                        <span id="cartdata">No Data Found..</span>
                    </div>
                </div>
            </div>
            <!-- progressbar -->
            <div id="bookingCart">
                <asp:HiddenField ID="hflatitude" runat="server" />
                <asp:HiddenField ID="hflongitude" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div style="width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px;">
                            <div style="float: left; width: 15%; margin-left: 5px;">
                                <asp:DropDownList ID="drpfoodcategory" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                            <div style="float: left; width: 15%; margin-left: 5px;">
                                <asp:DropDownList ID="drpfoodtype" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                            <div style="float: left; width: 50%; margin-left: 5px;">
                                <asp:TextBox ID="txtsearch" placeholder="Search by name keyword.." CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div style="float: left; width: 10%; margin-left: 5px;">
                                <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click" CssClass="form-control" BackColor="LightGray" />
                            </div>
                        </div>
                        <div style="clear: both"></div>
                        <div style="width: 100%; text-align: center; margin-top: 10px; margin-bottom: 20px;">
                            <asp:Label ID="lblproducts" runat="server"></asp:Label>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnsearch" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div id="bookingDetails" style="display: none">
                <ul id="progressbar">
                    <li class="active">Booking</li>
                    <li>Your Details</li>
                    <li>Summary</li>
                </ul>
                <!-- fieldsets -->
                <fieldset>
                    <div class="form-row">
                        <div style="width: 100%">
                            <div style="float: left; width: 50%;">
                                <asp:HiddenField ID="hfdate" runat="server" />
                                <asp:HiddenField ID="hfcdate" runat="server" />
                                <asp:HiddenField ID="hftime" runat="server" />
                                <asp:HiddenField ID="hfbtime" runat="server" />
                                <asp:HiddenField ID="hfslots" runat="server" />
                                <asp:HiddenField ID="hfbookings" runat="server" />
                                <asp:HiddenField ID="hfsparrange" runat="server" />
                                <asp:HiddenField ID="hfrdbval" runat="server" />
                                <div class='datepicker' style="float: left">
                                </div>
                            </div>
                            <div style="float: left; width: 50%; display: none" id="tblpersons">
                                How many people are coming?<br />
                                <br />
                                <p>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:HiddenField ID="hfqty" runat="server" Value="0" />
                                            <asp:TextBox ID="qty1" runat="server" Text="0" CssClass="qty"
                                                Width="40px" onBlur="fnslots()"
                                                Style="text-align: center" ReadOnly="true" BorderColor="LightGreen" Font-Bold="true"></asp:TextBox>
                                            <asp:ImageButton ID="imgminus" runat="server" ImageUrl="img/yOadS1c.png" OnClick="imgminus_Click"
                                                Style="width: 20px; height: 20px;" CssClass="minus" />
                                            <asp:ImageButton ID="imgplus" runat="server" ImageUrl="img/98cvZnj.png" OnClick="imgplus_Click"
                                                Style="width: 20px; height: 20px;" CssClass="add" />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="imgminus" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="imgplus" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="qty1" EventName="TextChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    <br />
                                    <br />
                                    <span id="lblslots"></span>
                                    <span id="lbltimings"></span>
                                    <br />
                                    <asp:Label ID="lblmsg" runat="server"></asp:Label>
                                    <br />
                                    <span id="lblbookings"></span>
                                    <br />
                                </p>
                            </div>
                            <div style="float: left; width: 50%; display: none;" id="tbldtake">
                                <span id="dtakeslots"></span>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="action-button previous_button" onclick="gotoprevious()">Back</button>
                    <button type="button" id="btncontinueone" style="display: none" class="next action-button">Continue</button>
                </fieldset>
                <fieldset style="overflow: scroll;">
                    <h3>Personal Details</h3>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <asp:TextBox ID="txtfname" runat="server" class="form-control" Style="border: 1px solid red" placeholder="First Name*"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:TextBox ID="txtlname" runat="server" class="form-control" Style="border: 1px solid red" placeholder="Last Name*"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <input type="tel" id="phone" class="form-control" placeholder="+61" />
                        </div>
                        <div class="form-group col-md-6">
                            <asp:TextBox ID="txtcpno" runat="server" Style="border: 1px solid red" class="form-control" placeholder="Contact No*"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:TextBox ID="txtmailid" runat="server" Style="border: 1px solid red" class="form-control" placeholder="Email-ID*"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <asp:TextBox ID="txtcompany" runat="server" class="form-control" placeholder="Company"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-12">
                            <asp:TextBox ID="txtremarks" TextMode="MultiLine" Height="40" class="form-control" runat="server" placeholder="Notes"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-12">
                            Special Arrangements:
                        <input type="checkbox" name="laptop"
                            value="Birthday" />Birthday

                        <input type="checkbox" style="margin-left: 3px" name="laptop"
                            value="Wheelchair Accessibility" />Wheelchair Accessibility

                        <input type="checkbox" name="laptop" style="margin-left: 3px"
                            value="Allergy (Please specify in notes)" />Allergy (Please specify in notes)

                        <input type="checkbox" name="laptop" style="margin-left: 3px"
                            value="Highchair" />
                        </div>
                        <div class="form-group col-md-12" style="border: 1px solid red">
                            <asp:CheckBox ID="chkterms" runat="server" class="form-control" Text="I agree to terms and conditions*"></asp:CheckBox>
                        </div>
                    </div>
                    <button type="button" class="action-button previous previous_button">Back</button>
                    <button type="button" id="btncontinuetwo" onclick="fnbooksummary()" class="next action-button" style="display: none">Continue</button>
                </fieldset>
                <fieldset>
                    <h3>Booking Summary</h3>
                    <div class="form-group">
                        <span id="lblsummary">
                            <table border="1" class="table-bordered">
                                <tr>
                                    <td>Customer</td>
                                    <td>:</td>
                                    <td><span id="customer"></span></td>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <td>:</td>
                                    <td><span id="mail"></span></td>
                                </tr>
                                <tr>
                                    <td>Contact No:</td>
                                    <td>:</td>
                                    <td><span id="contact"></span></td>
                                </tr>
                                <tr>
                                    <td>Company</td>
                                    <td>:</td>
                                    <td><span id="company"></span></td>
                                </tr>
                                <tr>
                                    <td>Special Arrangements</td>
                                    <td>:</td>
                                    <td><span id="specialarrange"></span></td>
                                </tr>
                                <tr>
                                    <td>Notes</td>
                                    <td>:</td>
                                    <td><span id="notes"></span></td>
                                </tr>
                                <tr>
                                    <td>Booking Date</td>
                                    <td>:</td>
                                    <td><span id="bdate"></span></td>
                                </tr>
                                <tr>
                                    <td>Time</td>
                                    <td>:</td>
                                    <td><span id="Time"></span></td>
                                </tr>
                                <tr id="devpersons">
                                    <td>No of Persons</td>
                                    <td>:</td>
                                    <td><span id="nps"></span></td>
                                </tr>
                            </table>
                        </span>
                    </div>
                    <button type="button" class="action-button previous previous_button">Back</button>
                    <asp:Button ID="btnsubmit" runat="server" class="action-button" Text="Book Now" OnClick="btnsubmit_Click" />
                </fieldset>
            </div>
        </form>
    </section>
    <!-- End Multi step form -->
    <script src='js/jquery.min.js'></script>
    <script src='js/bootstrap.min.js'></script>
    <script src='js/jquery.easing.min.js'></script>
    <script src='js/intlTelInput.js'></script>
    <script src='js/popper.min.js'></script>
    <script src='js/jquery.nice-select.min.js'></script>
    <script id="rendered-js" src="js/formjs.js"></script>
    <script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src='//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'></script>
    <script src="js/formcode.js"></script>
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
            $("#hflongitude").val(position.coords.longitude);
            $("#hflatitude").val(position.coords.latitude);
        }
    </script>
    <script type="text/javascript">

        // Function to show and hide the popup
        function togglePopup() {
            $(".content").toggle();
        }
    </script>
</body>
</html>
