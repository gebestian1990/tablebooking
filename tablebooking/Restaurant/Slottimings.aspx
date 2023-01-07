<%@ Page Title="" Language="C#" MasterPageFile="~/Restaurant/RestaurantMaster.Master" AutoEventWireup="true" CodeBehind="Slottimings.aspx.cs" Inherits="tablebooking.Restaurant.Slottimings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel ID="update" runat="server">
        <ContentTemplate>
            <div class="content-wrapper">
                <h1>Timings</h1>
                <div class="row">
                    <div class="col-md-4 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Breakfast</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Opening</label>
                                        <asp:DropDownList ID="drpbreakopen" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvbreakopen" runat="server" InitialValue="0" ControlToValidate="drpbreakopen" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="break" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Closing</label>
                                        <asp:DropDownList ID="drpbreakclose" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvbreakclose" runat="server" InitialValue="0" ControlToValidate="drpbreakclose" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="break" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Booking Difference</label>
                                        <asp:DropDownList ID="drpbookdiff" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvbookdff" runat="server" InitialValue="0" ControlToValidate="drpbookdiff" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="break" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Status</label>
                                        <asp:DropDownList ID="drpbreakstatus" runat="server" TabIndex="7" CssClass="form-control form-control-lg">
                                            <asp:ListItem Value="0" Text="-Select Status-"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="InActive"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvbreakstatus" runat="server" InitialValue="0" ControlToValidate="drpbreakstatus" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="break" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <asp:Label ID="lblbreakmsg" runat="server" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btnbreaksubmit" runat="server" ValidationGroup="break" TabIndex="7" CausesValidation="true" UseSubmitBehavior="false" Text="Submit" OnClientClick="if(!Page_ClientValidate('break')){return false;}this.disabled=true;this.value='Submitting..';" OnClick="btnbreaksubmit_Click" class="btn btn-primary me-2" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Lunch</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Opening</label>
                                        <asp:DropDownList ID="drplunchopen" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvlunchopen" runat="server" InitialValue="0" ControlToValidate="drplunchopen" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="lunch" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Closing</label>
                                        <asp:DropDownList ID="drplunchclose" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvlunchclose" runat="server" InitialValue="0" ControlToValidate="drplunchclose" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="lunch" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Booking Difference</label>
                                        <asp:DropDownList ID="drplunchbookdiff" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvlunchbookdff" runat="server" InitialValue="0" ControlToValidate="drplunchbookdiff" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="lunch" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Status</label>
                                        <asp:DropDownList ID="drplunchstatus" runat="server" TabIndex="7" CssClass="form-control form-control-lg">
                                            <asp:ListItem Value="0" Text="-Select Status-"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="InActive"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvstatus" runat="server" InitialValue="0" ControlToValidate="drplunchstatus" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="lunch" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <asp:Label ID="lblmsglunch" runat="server" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btnlunchsubmit" runat="server" ValidationGroup="user" TabIndex="7" CausesValidation="true" UseSubmitBehavior="false" Text="Submit" OnClientClick="if(!Page_ClientValidate('lunch')){return false;}this.disabled=true;this.value='Submitting..';" OnClick="btnlunchsubmit_Click" class="btn btn-primary me-2" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Dinner</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Opening</label>
                                        <asp:DropDownList ID="drpdinneropen" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvdinneropen" runat="server" InitialValue="0" ControlToValidate="drpdinneropen" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="dinner" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Closing</label>
                                        <asp:DropDownList ID="drpdinnerclose" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvdinnerclose" runat="server" InitialValue="0" ControlToValidate="drpdinnerclose" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="dinner" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Booking Difference</label>
                                        <asp:DropDownList ID="drpdinnerbookdiff" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvdinnerbookdiff" runat="server" InitialValue="0" ControlToValidate="drpdinnerbookdiff" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="dinner" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Status</label>
                                        <asp:DropDownList ID="drpdinnerstatus" runat="server" TabIndex="7" CssClass="form-control form-control-lg">
                                            <asp:ListItem Value="0" Text="-Select Status-"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="InActive"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvdinnerstatus" runat="server" InitialValue="0" ControlToValidate="drplunchstatus" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="dinner" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <asp:Label ID="lblmsgdinner" runat="server" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btndinnersubmit" runat="server" ValidationGroup="dinner" TabIndex="7" CausesValidation="true" UseSubmitBehavior="false" Text="Submit" OnClientClick="if(!Page_ClientValidate('dinner')){return false;}this.disabled=true;this.value='Submitting..';" OnClick="btndinnersubmit_Click" class="btn btn-primary me-2" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnbreaksubmit" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnlunchsubmit" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btndinnersubmit" EventName="Click" />
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
