
<%@ Page Title="Ticket details" Language="C#" MasterPageFile="~/view/Main.Master" AutoEventWireup="true" CodeBehind="TicketDetails.aspx.cs" Inherits="ServiceDesk.view.TicketDetails" %>

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


        //$(document).ready(function () {
        //    $('.DDLWFMAction').change(function () {                
        //        //alert('shree');
        //        var option = $("[id*='DDLWFMAction'] :selected").text();
        //        if (option == "Reject")
        //        {
        //            $("[id*='divWFMRejected']").show();                    
        //        }
        //        else {
        //            $("[id*='divWFMRejected']").hide();
        //        }
        //    });

        //});

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
                <li><a href="ViewTicketRequestorData.aspx">Request Status</a></li>
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
                        <div class="box-content GMDivBcg" style=" background-color:gray">
                            <div class="row">
                                <div class="col-lg-3 LblControl">Strategic Partner :</div>
                                <div class="col-lg-4">
                                    <asp:DropDownList ID="ddlStratigic_Partner" runat="server" CssClass="form-control" OnSelectedIndexChanged="DDLIssueType_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                    <%--  <asp:RequiredFieldValidator ValidationGroup="Save" runat="server" ID="RFRequestor" Display="None" ControlToValidate="ddlStratigic_Partner"
                                        ErrorMessage="Requestor is required." InitialValue="" Enabled="true"></asp:RequiredFieldValidator>
                                    <aspAjax:ValidatorCalloutExtender ID="VCERequestor" runat="Server" TargetControlID="ddlStratigic_Partner" />--%>
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
                                    <asp:DropDownList runat="server" ID="ddlIssue_Level" AutoPostBack="true" OnSelectedIndexChanged="DDLRequestType_SelectedIndexChanged" CssClass="form-control">
                                        <asp:ListItem Value="0" Text="--Select Issue Level--"> </asp:ListItem>
                                        <asp:ListItem Value="Tier 1" Text="Tier 1"></asp:ListItem>
                                        <asp:ListItem Value="Tier 2" Text="Tier 2"></asp:ListItem>
                                        <asp:ListItem Value="Tier 3" Text="Tier 3"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ValidationGroup="Save" runat="server" ID="RFDrpDwnRegion1" Display="None" ControlToValidate="ddlIssue_Level"
                                        ErrorMessage="Issue level is required." InitialValue="0" Enabled="true"></asp:RequiredFieldValidator>
                                    <aspAjax:ValidatorCalloutExtender ID="VDrpDwnRegion1" runat="Server" TargetControlID="RFDrpDwnRegion1" />
                                </div>
                                <div class="col-lg-3">
                                    <asp:DropDownList runat="server" ID="ddlIssue_Type" AutoPostBack="true" OnSelectedIndexChanged="DDLIssueType_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ValidationGroup="Save" runat="server" ID="RFDrpDwnSubRegion1" Display="None" ControlToValidate="ddlIssue_Type"
                                        ErrorMessage="Issue Type is required." InitialValue="0" Enabled="true"></asp:RequiredFieldValidator>
                                    <aspAjax:ValidatorCalloutExtender ID="VDrpDwnSubRegion1" runat="Server" TargetControlID="RFDrpDwnSubRegion1" />
                                </div>
                                <div class="col-lg-3">
                                    <asp:DropDownList runat="server" ID="ddlIssue_SubType" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DDLIssue_SubType_SelectedIndexChanged"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ValidationGroup="Save" runat="server" ID="RFDrpDwnLocation1" Display="None" ControlToValidate="ddlIssue_SubType"
                                        ErrorMessage="Issue Sub Type is required." InitialValue="0" Enabled="true"></asp:RequiredFieldValidator>
                                    <aspAjax:ValidatorCalloutExtender ID="VDrpDwnLocation1" runat="Server" TargetControlID="RFDrpDwnLocation1" />
                                </div>
                                <div class="col-lg-3">
                                    <asp:TextBox ID="txtPriority" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="Save" runat="server" ID="RequiredFieldValidator1" Display="None" ControlToValidate="txtPriority"
                                        ErrorMessage="Priority is required." InitialValue="" Enabled="true"></asp:RequiredFieldValidator>
                                    <aspAjax:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="Server" TargetControlID="RequiredFieldValidator1" />
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
                                                        <iframe id="ifarme11" style="height: 300px; width: 100%; overflow-y: auto" runat="server"></iframe>
                                                    </div>
                                            </asp:Panel>

                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-3 LblControl" >Action(Pending/Resolve):</div>
                                <div class="col-lg-3">
                                    <asp:DropDownList ID="DDLWFMAction" runat="server"  CssClass="form-control DDLWFMAction" OnSelectedIndexChanged="DDLWFMAction_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Reply"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Resolved"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ValidationGroup="Save" runat="server" ID="RFDDLWFMAction" Display="None" ControlToValidate="DDLWFMAction"
                                        ErrorMessage="Please Select Action." InitialValue="0" Enabled="true"></asp:RequiredFieldValidator>
                                    <aspAjax:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="Server" TargetControlID="RFDDLWFMAction" />
                                </div>
                            </div>
                            <div id="divWFMRejected" runat="server">
                                <div class="row">&nbsp;</div>
                                <div class="row">
                                    <div class="col-lg-3 LblControl">Reply Comment:</div>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="TxtWFMRejectedComment" runat="server" CssClass="form-control" TextMode="MultiLine" Height="70" Width="240px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="Save" runat="server" ID="RFTxtWFMRejectedComment" Display="None" ControlToValidate="TxtWFMRejectedComment"
                                            ErrorMessage=" Comments is required." InitialValue="" Enabled="true"></asp:RequiredFieldValidator>
                                        <aspAjax:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="Server" TargetControlID="RFTxtWFMRejectedComment" />
                                    </div>
                                </div>
                            </div>
                            <div id="divResolved" runat="server">
                                <div class="row">&nbsp;</div>
                                <div class="row">
                                    <div class="col-lg-3 LblControl">Resolved Agents:</div>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="txtResolved_Id" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="Save" runat="server" ID="RequiredFieldValidator2" Display="None" ControlToValidate="txtResolved_Id"
                                            ErrorMessage=" Comments is required." InitialValue="" Enabled="true"></asp:RequiredFieldValidator>
                                        <aspAjax:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" runat="Server" TargetControlID="RequiredFieldValidator2" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">&nbsp;</div>

                            <div class="row">
                                <div class="col-lg-3 LblControl">Notes: </div>
                                <div class="col-lg-9">
                                    <asp:TextBox ID="txtMailContent" runat="server" CssClass="form-control" TextMode="MultiLine" Height="70" Width="290px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ValidationGroup="Save" runat="server" ID="RFtxtComments" Display="None" ControlToValidate="txtMailContent"
                                        ErrorMessage="Comments is required." InitialValue="" Enabled="true"></asp:RequiredFieldValidator>
                                    <aspAjax:ValidatorCalloutExtender ID="VtxtComments" runat="Server" TargetControlID="RFtxtComments" />
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
                                    <asp:Button ID="btnSaveWFMRequestorData" OnClientClick="return FnValidateUploadFile();" OnClick="btnSaveWFMRequestorData_Click" runat="server" Text="Save" ValidationGroup="Save" CssClass="btn btn-primary" />
                                </div>
                            </div>
                        </div>
                         </div>
                    </div>
                </div>
            </div>
            </div>
            <div style="visibility: hidden">
                <input type="hidden" id="HdnIsGMApproved" runat="server" />
            </div>

        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSaveWFMRequestorData" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

