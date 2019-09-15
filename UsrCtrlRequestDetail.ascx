<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UsrCtrlRequestDetail.ascx.cs" Inherits="ServiceDesk.view.UsrCtrlRequestDetail" %>
<div class="box-header">
                            <div class="box-name">
                                <div class="row">
                                    <div class="col-lg-7" style="text-align: left;">
                                        <i class="fa fa-home"></i>
                                        <span style="font-size: 15px !important;">Requestor Screen</span>
                                    </div>
                                    <div class="col-lg-4" style="text-align: right;">
                                        <asp:Label ID="lblDate" runat="server" CssClass="form-control HighlightDate"></asp:Label>
                                    </div>
                                      <div class="box-icons col-lg-1">
                     <%--   <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>--%>
                        <a class="expand-link">
                            <i class="fa fa-expand"></i>
                        </a>
                    <%--    <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>--%>
                    </div>
                                </div>
                            </div>
       
                        </div>
                        <div class="box-content ReqDivBcg">
                            <div class="row">
                                <div class="col-lg-2 LblControl">Requestor :</div>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="txtRequestor" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                                </div>
                                 <div class="col-lg-1 LblControl">EmailID: </div>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtRequestorEmail" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">&nbsp;</div>
                            <div class="row">
                                <div class="col-lg-2 LblControl">Subject : </div>
                                <div class="col-lg-10">
                                    <asp:Label ID="LblCountryCode" style=" font-weight:400; font-size:medium " runat="server" Enabled="false"></asp:Label>
                                </div>
                            </div>

                            <div class="row">&nbsp;</div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="panel panel-primary">
                                        <div class="panel-heading" style="height: 30px !important;  background-color: #33a1c9;">
                                            <h5 class="panel-title" style="font-size: 12px !important;">Email Body</h5>
                                        </div>
                                        <asp:Panel ID="Pnl" runat="server" Enabled="false">
                                            <div class="panel-body">
                                                <div class="row" style="overflow:scroll; height:300px">
                                                  <div id="EmailBody" runat="server"></div>
                                                    </div>
                                            </div>
                                        </asp:Panel>

                                    </div>
                                </div>
                            </div>
                        </div>