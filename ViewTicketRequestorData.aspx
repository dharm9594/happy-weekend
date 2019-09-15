<%@ Page Title="Ticket Raised Details" Language="C#" MasterPageFile="~/view/Main.Master" AutoEventWireup="true" CodeBehind="ViewTicketRequestorData.aspx.cs" Inherits="ServiceDesk.view.ViewTicketRequestorData" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function FnSearch() {
            FnGridSearch($('[id$="LblNoRecords"]'), $('[id$="GrdWFMRequest"]'), $('[id$="TxtSearch"]'));
        }

        function FnValidateNbr() {
            var vTxtPgNbr = $('#<%=TxtPageNbr.ClientID%>');
            var vTxtPgCount = $('#<%=LblTotalPage.ClientID%>');
            FnValidateGridPaging(vTxtPgNbr, vTxtPgCount);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div id="breadcrumb" class="col-md-12">
            <ol class="breadcrumb">
                <li><a href="#">Reports</a></li>
                <li><a href="#">View Ticket Request</a></li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header">
                    <div class="box-name">
                        <i class="fa fa-home"></i>
                        <span style="font-size:15px !important;">Ticket Raised Details</span>
                    </div>
                    <div class="box-icons">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a class="expand-link">
                            <i class="fa fa-expand"></i>
                        </a>
                        <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                    <div class="no-move"></div>
                </div>
                <div class="box-content">
                    <%if(iTotalPage > 0){ %>
                    <div class="row">
                        <div class="col-lg-12">
                            Search :
                            <asp:TextBox ID="TxtSearch" runat="server" onkeypress="FnSearch();" onkeyup="FnSearch();"></asp:TextBox><br />
                            <asp:Label ID="LblNoRecords" runat="server" ForeColor="Red"></asp:Label><br />
                            <div class="datagrid">
                                <asp:GridView ID="GrdWFMRequest" runat="server" AutoGenerateColumns="false" EmptyDataText="!!! No Record(s) Found. !!!" EmptyDataRowStyle-CssClass="LblFont"
                                    GridLines="Both" BorderColor="Black"   OnDataBound="GrdWFMRequest_DataBound" OnRowDataBound="GrdWFMRequest_RowDataBound">
                                    <Columns>
                                        <asp:BoundField HeaderText="Sr No" DataField="RowID" />
                                        <asp:TemplateField HeaderText="Request ID">
                                            <ItemTemplate>
                                                <asp:Label ID="LblID" runat="server" Text='<%#Bind("TicketID")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Requestor Name" DataField="RequestorName" />
                                         <asp:BoundField HeaderText="Ticket Source" DataField="Source" />
                                        <asp:BoundField HeaderText="Email Address" DataField="RequestorEmailAddress" />
                                        <asp:BoundField HeaderText="Subject" DataField="EmailSubject" />
                                           <asp:BoundField HeaderText="Stratigic Partner" DataField="Stratigic_Partner_Name" />
                                          <asp:BoundField HeaderText="Status" HtmlEncode="false" DataField="Action" />
                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <%--<asp:ImageButton ID="ImgEditRequest" runat="server" ImageAlign="AbsMiddle"/>--%>
                                                <asp:LinkButton ID="LnkEditRequest" runat="server" Text="Action"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-5">&nbsp;</div>
                        <div class="col-lg-2">
                            <div style="padding-top: 10px;">
                                <table>
                                    <tr>
                                        <td>Page &nbsp;</td>
                                        <td>
                                            <asp:Panel ID="Pnl" runat="server" DefaultButton="BtnLoadData">
                                                <asp:TextBox ID="TxtPageNbr" runat="server" Text="1" Width="50" onkeyup="OnlyNumbers(this)"></asp:TextBox>
                                            </asp:Panel>
                                        </td>
                                        <td>&nbsp; of &nbsp;<asp:Label ID="LblTotalPage" runat="server"></asp:Label></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="col-lg-5">&nbsp;</div>
                    </div>
                    <%} else
                      { %>
                    <div class="row">
                        <div class="col-lg-12" style="text-align:center;">
                            <h3>!!! No Record(s) Found.</h3>
                        </div>
                    </div>
                    <%} %>
                    <div style="visibility: hidden">
                        <asp:Button ID="BtnLoadData" runat="server" OnClick="BtnLoadData_Click" OnClientClick="FnValidateNbr();" Text="Load Data" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

