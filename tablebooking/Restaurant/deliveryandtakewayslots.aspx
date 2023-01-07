<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="deliveryandtakewayslots.aspx.cs" MasterPageFile="~/Restaurant/RestaurantMaster.Master" Inherits="tablebooking.Restaurant.deliveryandtakewayslots" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:UpdatePanel ID="update" runat="server">
        <ContentTemplate>
            <div class="content-wrapper">
                <h1>Timings</h1>
                <div class="row">
                    <div class="col-md-6 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Delivery Timings</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Opening</label>
                                        <asp:DropDownList ID="drpdelopen" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvdelopen" runat="server" InitialValue="0" ControlToValidate="drpdelopen" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="break" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Closing</label>
                                        <asp:DropDownList ID="drpdelclose" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvdelclose" runat="server" InitialValue="0" ControlToValidate="drpdelclose" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="break" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Delivery Difference</label>
                                        <asp:DropDownList ID="drpdeldiff" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvdeldff" runat="server" InitialValue="0" ControlToValidate="drpdeldiff" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="break" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Status</label>
                                        <asp:DropDownList ID="drpdelstatus" runat="server" TabIndex="7" CssClass="form-control form-control-lg">
                                            <asp:ListItem Value="0" Text="-Select Status-"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="InActive"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvdelstatus" runat="server" InitialValue="0" ControlToValidate="drpdelstatus" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="break" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <asp:Label ID="lbldelmsg" runat="server" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btndelsubmit" runat="server" ValidationGroup="break" TabIndex="7" CausesValidation="true" UseSubmitBehavior="false" Text="Submit" OnClientClick="if(!Page_ClientValidate('break')){return false;}this.disabled=true;this.value='Submitting..';" OnClick="btndelsubmit_Click" class="btn btn-primary me-2" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Takeway Timings</h4>
                                <div class="forms-sample">
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Opening</label>
                                        <asp:DropDownList ID="drptwayopen" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvtwayopen" runat="server" InitialValue="0" ControlToValidate="drptwayopen" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="lunch" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Closing</label>
                                        <asp:DropDownList ID="drptwayclose" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvtwayclose" runat="server" InitialValue="0" ControlToValidate="drptwayclose" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="lunch" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Booking Difference</label>
                                        <asp:DropDownList ID="drptwaydiff" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvtwaybookdff" runat="server" InitialValue="0" ControlToValidate="drptwaydiff" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="lunch" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Status</label>
                                        <asp:DropDownList ID="drptwaystatus" runat="server" TabIndex="7" CssClass="form-control form-control-lg">
                                            <asp:ListItem Value="0" Text="-Select Status-"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="InActive"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvstatus" runat="server" InitialValue="0" ControlToValidate="drptwaystatus" Display="Dynamic" ErrorMessage="* Required" ValidationGroup="lunch" ForeColor="Red" Font-Bold="true" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                    <asp:Label ID="lblmsgtway" runat="server" CssClass="auth-link" ForeColor="Red" Style="font-weight: bold; margin-bottom: 10px;"></asp:Label><br />
                                    <asp:Button ID="btnywaysubmit" runat="server" ValidationGroup="user" TabIndex="7" CausesValidation="true" UseSubmitBehavior="false" Text="Submit" OnClientClick="if(!Page_ClientValidate('lunch')){return false;}this.disabled=true;this.value='Submitting..';" OnClick="btnywaysubmit_Click" class="btn btn-primary me-2" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btndelsubmit" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnywaysubmit" EventName="Click" />
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
