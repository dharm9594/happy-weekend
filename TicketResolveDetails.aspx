<%@ Page Title="Ticket details" Language="C#" MasterPageFile="~/view/Main.Master" AutoEventWireup="true" CodeBehind="TicketResolveDetails.aspx.cs" Inherits="ServiceDesk.view.TicketResolveDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="aspAjax" %>
<%@ Register Src="~/view/UsrCtrlRequestDetail.ascx" TagPrefix="uc1" TagName="UsrCtrlRequestDetail" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- <script src="../plugins/jquery/jquery-2.1.0.min.js"></script>--%><script src="../js/jquery-1.9.1.js"></script>
    <script type="text/javascript">
        function FnSlideUp() {
            $('.ClsHideSite').slideUp();
        }

        function FnSlideDown() {
            $('.ClsHideSite').slideDown();
        }
    </script>

    <style>
        .ajax__validatorcallout {
            z-index: 10;
        }

        .ClsHideSite {
            display: block;
        }

        .panel-primary > .panel-heading {
            background-color: #33a1c9;
        }


        .clsValidation {
            left: 100px!important;
            top: 0px!important;
            visibility: visible!important;
            position: relative!important;
        }

        .ProgressOverlay {
            position: absolute;
            background-color: black;
            top: 0px;
            left: 0px;
            width: 100%;
            height: 100%;
            opacity: 0.8;
            -moz-opacity: 0.8;
            filter: alpha(opacity=80);
            -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=80)";
            z-index: 10000;
        }

        .centered {
            position: fixed;
            top: 50%;
            left: 50%;
            margin-top: -50px;
            margin-left: -100px;
            text-align: center;
            z-index: 10000;
        }
    </style>
    <script type="text/javascript">

        function FnValidateUploadFile() {
            if ($('[id$="txtWFMReviewer"]').val().trim() == "") {
                alert('WFM Co-ordinate cannot be left blank');
                return false;
            }
            if ($('[id$="txtWFMDesigination"]').val().trim() == "") {
                alert('Desigination cannot be left blank');
                return false;
            }
            if ($('[id$="txtWFMRequestorTelNo"]').val().trim() == "") {
                alert('WFM Contact No cannot be left blank');
                return false;
            }
            var option = $("[id*='DDLWFMAction'] :selected").text();
            if (option == "Reject") {
                if ($('[id$="TxtWFMRejectedComment"]').val().trim() == "") {
                    alert('WFM Rejected Comment cannot be left blank');
                    return false;
                }
            }
            ShowProgress();
            return true;
        }

        function ShowProgress() {
            //document.getElementById('<%=UpdateProgress1.ClientID%>').style.display = "inline";             
            $('[id$="UpdateProgress1"]').css('display', 'inline');

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <aspAjax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></aspAjax:ToolkitScriptManager>
    <div class="row">
        <div id="breadcrumb" class="col-md-12">
            <ol class="breadcrumb">
                <li><a href="#" style="text-decoration: none; cursor: none;">Tracking Request</a></li>
                <li><a href="ViewTicketResolveData.aspx">Resolve Ticket</a></li>
                <li><a href="#" style="text-decoration: none; cursor: none;">Ticket # <%=Convert.ToString(Session["RequestID"])%></a></li>
            </ol>
        </div>
    </div>
    <asp:UpdatePanel ID="UpPnl" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpPnl" runat="server">
                <ProgressTemplate>
                    <div class="ProgressOverlay">
                        <div class="centered">
                            <img alt="progress" src="../images/loading1.gif" width="60" height="60" />
                            <br />
                            <span style="font-family: Baskerville; font-size: medium; font-weight: bolder; color: white;">Processing Please Wait...</span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="row">
                <div class="col-xs-6">
                    <div class="box">
                        <uc1:UsrCtrlRequestDetail runat="server" ID="UsrCtrlRequestDetail" />
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="box ">

                        <div class="box-header">
                            <div class="box-name">
                                <div class="row">
                                    <div class="col-lg-7" style="text-align: left;">
                                        <i class="fa fa-home"></i>
                                        <span style="font-size: 15px !important;">Update Ticket</span>
                                    </div>
                                    <div class="col-lg-4" style="text-align: right;">
                                        <asp:Label ID="lblWFMDate" runat="server" CssClass="form-control HighlightDate"></asp:Label>
                                    </div>
                                    <div class="box-icons col-lg-1">
                                        <a class="expand-link">
                                            <i class="fa fa-expand"></i>
                                        </a>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="box-content GMDivBcg">
                            <div class="row">
                                <div class="col-lg-3 LblControl">Strategic Partner :</div>
                                <div class="col-lg-4">
                                    <asp:TextBox ID="ddlStratigic_Partner" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>

                            <%--  <div class="row">&nbsp;</div>--%>
                            <div class="row">
                                <div class="col-lg-3 LblControl">Issue Level : </div>
                                <div class="col-lg-3 LblControl">Issue Type: </div>
                                <div class="col-lg-3 LblControl">Issue Sub Type: </div>
                                <div class="col-lg-3 LblControl">Priority: </div>
                            </div>



                            <div class="row">
                                <div class="col-lg-3">
                                       <asp:TextBox ID="ddlIssue_Level" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-lg-3">
                                     <asp:TextBox ID="ddlIssue_Type" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-lg-3">
                                     <asp:TextBox ID="ddlIssue_SubType" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-lg-3">
                                    <asp:TextBox ID="txtPriority" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">&nbsp;</div>
                            <div id="ShowIframe" runat="server">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="panel panel-primary">
                                            <div class="panel-heading" style="height: 30px !important; background-color: #33a1c9;">
                                                <h5 class="panel-title" id="iFrameHeader" runat="server" style="font-size: 12px !important;">Email Body</h5>
                                            </div>
                                            <asp:Panel ID="Pnl" runat="server" Enabled="false">
                                                <div class="panel-body" style="padding-top: 0; padding-bottom: 0">
                                                    <div class="row">
                                                     <%--   <iframe id="ifarme11" tabindex="-1" style="height: auto; width: 100%; overflow-y: auto" runat="server"></iframe>--%>

                                                         <div class="datagrid" style=" overflow:auto; padding: 15px; height:300px">
                                <asp:GridView ID="GrdStatusPass" runat="server" AutoGenerateColumns="false" EmptyDataText="!!! No Password reset for this ticket !!!" EmptyDataRowStyle-CssClass="LblFont"
                                    GridLines="Both" BorderColor="Black" >
                                    <Columns>
                                        <asp:BoundField HeaderText="Sr No" DataField="RowID" />
                                        <asp:TemplateField HeaderText="User Name">
                                            <ItemTemplate>
                                                <asp:Label ID="LblID" runat="server" Text='<%#Bind("UserName")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Password" DataField="newPassword" />
                                        <asp:BoundField HeaderText="Status" DataField="Status" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                                                    </div>
                                            </asp:Panel>

                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-3 LblControl" >Action(Pending/Resolve):</div>
                                <div class="col-lg-3">
                                    <asp:DropDownList ID="DDLWFMAction" runat="server" Enabled="false"  CssClass="form-control DDLWFMAction"  AutoPostBack="true">
                                        <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Reply"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Resolved"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div id="divResolved" runat="server">
                                <div class="row">&nbsp;</div>
                                <div class="row">
                                    <div class="col-lg-3 LblControl">Resolved Agents:</div>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="txtResolved_Id" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="row">&nbsp;</div>

                            <div class="row">
                                <div class="col-lg-3 LblControl">Notes: </div>
                                <div class="col-lg-9">
                                    <asp:TextBox ID="txtMailContent" runat="server" Enabled="false" CssClass="form-control" TextMode="MultiLine" Height="70" Width="290px"></asp:TextBox>
                                </div>
                            </div>
                             <div class="row">&nbsp;</div>
                            <div class="row">
                                <div class="col-lg-3 LblControl">Upload File: </div>
                                <div class="col-lg-9">
                                    <asp:FileUpload ID="FileUpload_Attachment" runat="server" />
                                    <%--    <asp:RequiredFieldValidator ValidationGroup="Save" runat="server" ID="RequiredFieldValidator3" Display="None" ControlToValidate="FileUpload_Attachment"
                                        ErrorMessage="File Attachment is required." InitialValue="" Enabled="true"></asp:RequiredFieldValidator>
                                    <aspAjax:ValidatorCalloutExtender ID="ValidatorCalloutExtender5" runat="Server" TargetControlID="RequiredFieldValidator3" />--%>
                                </div>
                            </div>
                       
                        <div class="row">&nbsp;</div>
                        <div class="row">
                            <div class="col-lg-offset-5">
                                <div style="padding-top: 10px;">
                                    <asp:Button ID="btnSaveWFMRequestorData"  OnClientClick="return FnValidateUploadFile();" OnClick="btnSaveWFMRequestorData_Click" runat="server" Text="Go Back"  CssClass="btn btn-danger" />
                                </div>
                            </div>
                        </div>
                         </div>
                    </div>
                </div>
            </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSaveWFMRequestorData" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

