<%@ Page Title="" Language="C#" MasterPageFile="~/view/Main.Master" AutoEventWireup="true" CodeBehind="Self_PassReport.aspx.cs" Inherits="ServiceDesk.view.Self_PassReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="false" />
    <div class="row">
        <div id="breadcrumb" class="col-md-12">
            <ol class="breadcrumb">
                <li><a href="#" style="text-decoration: none; cursor: none;">Report</a></li>
                <li><a href="#" style="text-decoration: none; cursor: none;">Self Password Report</a></li>
            </ol>
        </div>
    </div>
    <div class="container" style="text-align: center">
        <div id="Workspace1_MainContent_pnlRequest" style="text-align: -webkit-center;">
            <div class="row">
                <div class="col-sm-8" style="width: 60%">
                    <%-- <fieldset style="/*text-align: -webkit-left; padding: 5px; background-color: #d6ebf5; */    margin-top: 10px;">
                        <legend style="border-radius: 5px; padding: 2px 16px; color: white; background-color: #E31837;"></legend>--%>
                    <div class="box-header">
                        <div class="box-name">
                            <div class="row">
                                <div class="col-lg-8" style="text-align: left;">
                                    <i class="fa fa-home"></i>
                                    <span style="font-size: 15px !important;">Search</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-content ReqDivBcg">
                        <div id="Div1" runat="server">
                            <table style="color: #333333; border-collapse: collapse; width: 100%;" class="dGrid">
                                <colgroup>
                                    <col width="150px">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th>From Date:</th>
                                        <td>
                                            <telerik:RadDatePicker MinDate="1-1-1950" CssClass="form-control" Width="90%" DateInput-DisplayText="From Date"
                                                ID="txtFromDate" DateInput-DateFormat="yyyy-MM-dd" autocomplete="off" runat="server">
                                            </telerik:RadDatePicker>
                                               <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFromDate"
                                                ValidationGroup="m2" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>                          
                                         
                                        </td>
                                        <th>To Date:</th>
                                        <td>
                                               <telerik:RadDatePicker MinDate="1-1-1950" CssClass="form-control" Width="90%" DateInput-DisplayText="To Date"
                                                ID="txtToDate" DateInput-DateFormat="yyyy-MM-dd" autocomplete="off" runat="server">
                                            </telerik:RadDatePicker>
                                               <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtToDate"
                                                ValidationGroup="m2" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>                          
                                        </td>
                                    </tr>
                                    <tr>
                                         <th>Request Type:</th>
                                        <td>
                                            <asp:DropDownList ID="ddlRequestType" runat="server" Width="90%" CssClass="">
                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Self Password Reset" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Unlock Account" Value="21"></asp:ListItem>
                                            </asp:DropDownList>
                                           <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlRequestType"
                                                ValidationGroup="m2" ErrorMessage="*" InitialValue="0" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                        </td>
                                       
                                         <th>Request Status:</th>
                                        <td>
                                            <asp:DropDownList ID="ddlRequestStatus" runat="server" Width="90%" CssClass="">
                                                <asp:ListItem Text="--Select--" Value="00"></asp:ListItem>
                                                <asp:ListItem Text="Success" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Failure" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                          <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlRequestStatus"
                                                ValidationGroup="m2" ErrorMessage="*" InitialValue="00" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                        </td>
                                    </tr>
                                    <tr style="text-align: center">
                                        <td colspan="4">
                                            <asp:Button ID="btnSearch" Width="20%" Style="margin-bottom: auto" CssClass="btn btn-blue" OnClick="btnSearch_Click" ValidationGroup="m2" runat="server" Text="Search" />
                                            
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <%--  </fieldset>--%>
                </div>
                <div class="col-sm-6" style="width: 90%; margin-top: 10px">
                    <%--  <fieldset style="/*text-align: -webkit-left; padding: 5px; background-color: #d6ebf5; */    margin-top: 10px;">
                        <legend style="border-radius: 5px; padding: 2px 16px; color: white; background-color: #E31837;">Issue Master Details</legend>
                    --%>
                    <div class="box-header">
                        <div class="box-name">
                            <div class="row">
                                <div class="col-lg-8" style="text-align: left;">
                                    <i class="fa fa-home"></i>
                                    <span style="font-size: 15px !important;">Report</span>
                                    
                                </div>
                                  <div class="box-icons col-lg-1" style="text-align: right;">
                                           <asp:Button ID="btnexport"  Visible="false" Style="margin-bottom: auto" CssClass="btn btn-orange" OnClick="btn_Export" runat="server" Text="Export" />
                                    </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-content ReqDivBcg">
                        <div class="" style="width: 100%">
                            <asp:GridView ID="Grddata" runat="server" align="center" CellPadding="4" ForeColor="#333333" GridLines="None"
                                Style="width: 100%; table-layout: unset;" CssClass="dGrid" EmptyDataText=" " AutoGenerateColumns="False" AllowPaging="True" PageSize="8" OnPageIndexChanging="Grddata_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField HeaderText="Ticket ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblid" runat="server" Text='<%#Bind("TicketID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                      <asp:TemplateField HeaderText="Ticket ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="LBLtTicket" runat="server" Text='<%#Bind("TicketID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Issue Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lvlIssue" runat="server" Text='<%#Bind("Issue") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                       <asp:TemplateField HeaderText="Employee ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblReqID" runat="server" Text='<%#Bind("CreatedByEmployeeID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Employee Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblReqName" runat="server" Text='<%#Bind("RequestorName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="CallMiner UserId">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCallminerUserID" runat="server" Text='<%#Bind("CallMiner_UserId") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" runat="server" Text='<%#Bind("Status") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                      <asp:TemplateField HeaderText="is Force Change Pass" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblForcePass" runat="server" Text='<%#Bind("isForceChangePass") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tenant" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTenant" runat="server" Text='<%#Bind("Tenant") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Created Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lbldate" runat="server" Text='<%#Eval("CreatedDate","{0:dd-MM-yyyy}")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                   
                                </Columns>
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                            </asp:GridView>
                        </div>
                    </div>
                    <%--  </fieldset>--%>
                </div>
            </div>
            <br style="float: none; clear: both" />
        </div>
    </div>
</asp:Content>
