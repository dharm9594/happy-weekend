<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/view/Main.Master" CodeBehind="ConvertJsonToCsv.aspx.cs" Inherits="ServiceDesk.view.API.ConvertJsonToCsv" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="aspAjax" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/btnStyles.css" rel="stylesheet" />
    <link href="../css/tbl.css" rel="stylesheet" />
   <style type="text/css">
    .modal
    {
        position: fixed;
        top: 0;
        left: 0;
        background-color: black;
        z-index: 99;
        opacity: 0.8;
        filter: alpha(opacity=80);
        -moz-opacity: 0.8;
        min-height: 100%;
        width: 100%;
    }
    .loading
    {
        font-family: Arial;
        font-size: 10pt;
        border: 5px solid #67CFF5;
        width: 200px;
        height: 100px;
        display: none;
        position: fixed;
        background-color: White;
        z-index: 999;
    }
</style>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
  <script type="text/javascript">
      function ShowProgress() {
          setTimeout(function () {
              var modal = $('<div />');
              modal.addClass("modal");
              $('body').append(modal);
              var loading = $(".loading");
              loading.show();
              var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
              var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
              loading.css({ top: top, left: left });
          }, 200);
      }
      $('form').live("submit", function () {
          ShowProgress();
      });
</script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <aspAjax:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></aspAjax:ToolkitScriptManager>
     <div class="row">
        <div id="breadcrumb" class="col-md-12">
            <ol class="breadcrumb">
                <li><a href="#" style="text-decoration: none;cursor: none;">Master</a></li>
                <li><a href="#" style="text-decoration: none;cursor: none;">Json Convertor</a></li>
            </ol>
        </div>
    </div>
      <div class="container" style="text-align: center">
          <div id="Workspace1_MainContent_pnlRequest" style="text-align: -webkit-center;">
                  <div class="col-xs-11">
                    <div class="box ">

                        <div class="box-header">
                            <div class="box-name">
                                <div class="row">
                                    <div class="col-lg-7" style="text-align: left;">
                                        <i class="fa fa-home"></i>
                                        <span style="font-size: 15px !important;">Json Convertor</span>
                                    </div>
                                   <%-- <div class="col-lg-4" style="text-align: right;">
                                        <asp:Label ID="lblWFMDate" runat="server" CssClass="form-control HighlightDate"></asp:Label>
                                    </div>--%>
                                    <div class="box-icons col-lg-1">
                                        <a class="expand-link">
                                            <i class="fa fa-expand"></i>
                                        </a>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="box-content GMDivBcg">
                            <div class="row">&nbsp;</div>
                            
                            <div id="divWFMRejected" runat="server">
                                <div class="row">&nbsp;</div>
                                <div class="row">
                                 <%--   <div class="col-lg-3 LblControl">JSON DATA:</div>--%>
                                    <div class="col-lg-12">
                                        <asp:TextBox ID="txtJson" runat="server" CssClass="form-control" TextMode="MultiLine" Height="300" Width="100%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="Save" runat="server" ID="RFTxtWFMRejectedComment" Display="None" ControlToValidate="txtJson"
                                            ErrorMessage="Json data required" InitialValue="" Enabled="true"></asp:RequiredFieldValidator>
                                        <aspAjax:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="Server" TargetControlID="RFTxtWFMRejectedComment" />
                                    </div>
                                </div>
                            </div>
                        <div class="row">&nbsp;</div>
                        <div class="row">
                            <div class="col-lg-offset-1">
                                <div style="padding-top: 10px;">
                                    <asp:Button ID="JsonToCSV" OnClientClick="return FnValidateUploadFile();" OnClick="JsonToCSV_Click" runat="server" Text="Convert" ValidationGroup="Save" CssClass="btn btn-primary" />
                                     <asp:Button ID="btnclear" OnClick="Clear_Click" runat="server" Text="Clear" ValidationGroup="" CssClass="btn btn-danger" />
                                </div>
                            </div>
                        </div>
                         </div>
                    </div>
                </div>
              </div>
          </div>
    <div class="loading" align="center">
    Loading. Please wait.<br />
    <br />
   <img src="../images/loading1.gif" />
</div>
    </asp:Content>