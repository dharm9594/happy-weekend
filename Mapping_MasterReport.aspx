﻿<%@ Page Title="" Language="C#" MasterPageFile="~/view/Main.Master" AutoEventWireup="true" CodeBehind="Mapping_MasterReport.aspx.cs" Inherits="ServiceDesk.view.Mapping_MasterReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/btnStyles.css" rel="stylesheet" />
    <link href="../css/tbl.css" rel="stylesheet" />
   <%--   <link href="../plugins/bootstrap.min.css" rel="stylesheet" />--%>
    <script src="../plugins/jquery.min.js"></script>
    <script src="../plugins/bootstrap.min.js"></script>
  
    <script type="text/javascript">
        function LoadWaiverModalPopup() {
            debugger;
            $('#deleteFileModal').modal('show');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div id="breadcrumb" class="col-md-12">
            <ol class="breadcrumb">
                <li><a href="#" style="text-decoration: none; cursor: none;">Report</a></li>
                <li><a href="#" style="text-decoration: none; cursor: none;">Agents Report</a></li>
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
                                        <th>Search Type:</th>
                                        <td>
                                            <asp:DropDownList ID="ddlSearchType" runat="server" Width="30%" CssClass="">
                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="EmployeeID" Value="EmployeeID"></asp:ListItem>
                                                <asp:ListItem Text="EmployeeName" Value="EmployeeName"></asp:ListItem>
                                                <asp:ListItem Text="NTID" Value="NTID"></asp:ListItem>
                                                <asp:ListItem Text="CallMiner_UserID" Value="CallMiner_UserID"></asp:ListItem>
                                                <asp:ListItem Text="Tenant" Value="Tenant"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlSearchType"
                                                ValidationGroup="m2" ErrorMessage="*" InitialValue="0" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>                          
                                            <asp:TextBox ID="txtSearch" placeholder="Search here" Width="40%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtSearch"
                                                ValidationGroup="m2" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:Button ID="btnSearch" Width="20%" Style=" margin-bottom:auto" CssClass="btn btn-blue" OnClick="btnSearch_Click" ValidationGroup="m2" runat="server" Text="Search" />
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
                                    <span style="font-size: 15px !important;">Agents Report</span>
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
                                    <asp:TemplateField HeaderText="Delete">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkdelete" runat="server" OnClick="lnkdelete_Click" OnClientClick="javascript:if(!confirm('Are you sure want to delete this record?'))return false;"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkEdit" runat="server" OnClick="lnkEdit_Click"><i class="fa fa-pencil"></i></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblid" runat="server" Text='<%#Bind("Id") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Employee ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblIssuelevel" runat="server" Text='<%#Bind("EmployeeID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Employee Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblissuetype" runat="server" Text='<%#Bind("EmployeeName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Domain" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblissueSubtype" runat="server" Text='<%#Bind("Domain") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="NTID" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPriority" runat="server" Text='<%#Bind("NTID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="CallMiner ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSLA" runat="server" Text='<%#Bind("CallMiner_UserID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Default Password" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDefPass" runat="server" Text='<%#Bind("DefaultPassword") %>'></asp:Label>
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
                                    <asp:TemplateField HeaderText="Created By" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCreatedBy" runat="server" Text='<%#Bind("CreatedBy") %>'></asp:Label>
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
    <div class="modal fade" id="deleteFileModal" role="dialog">

        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><i class="fa fa-files">&nbsp;</i>Update Details</h4>
                </div>
                <div class="modal-body">
                    <div id="SingleInsert" runat="server" style="width: 100%">
                        <table style="color: #333333; border-collapse: collapse; width: 100%;" class="dGrid">
                            <colgroup>
                                <col width="150px">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>Employee ID:</th>
                                    <td>
                                        <asp:TextBox ID="txtEmployeeID" placeholder="Enter Employee ID" Width="80%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqddlIssuelevel" runat="server" ControlToValidate="txtEmployeeID"
                                            ValidationGroup="m1" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <th>LOB:</th>
                                    <td>
                                        <asp:TextBox ID="txtLOB" placeholder="Enter LOB" Width="80%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLOB"
                                            ValidationGroup="m1" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Employee Name:</th>
                                    <td>
                                        <asp:TextBox ID="txtEmpName" placeholder="Enter Employee Name" Width="80%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqddlIssuetype" runat="server" ControlToValidate="txtEmpName"
                                            ValidationGroup="m1" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <th>Location:</th>
                                    <td>
                                        <asp:TextBox ID="txtLocation" placeholder="Enter Location" Width="80%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtLocation"
                                            ValidationGroup="m1" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Enter Domain:</th>
                                    <td>
                                        <asp:TextBox ID="txtDomain" placeholder="Enter Domain" Width="80%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqtxtIssuesubtype" runat="server" ControlToValidate="txtDomain"
                                            ValidationGroup="m1" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <th>Position:</th>
                                    <td>
                                        <asp:TextBox ID="txtPostion" placeholder="Enter Position" Width="80%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPostion"
                                            ValidationGroup="m1" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <th>NTID:</th>
                                    <td>
                                        <asp:TextBox ID="txtNTID" placeholder="Enter NTID" Width="80%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqtxtPriority" runat="server" ControlToValidate="txtNTID"
                                            ValidationGroup="m1" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <th>Company:</th>
                                    <td>
                                        <asp:TextBox ID="txtCompany" placeholder="Enter Company" Width="80%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtCompany"
                                            ValidationGroup="m1" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <th>CallMiner ID:</th>
                                    <td>
                                        <asp:TextBox ID="txtCallminerID" placeholder="Enter CallMiner ID" Width="80%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqtxtSLA" runat="server" ControlToValidate="txtCallminerID"
                                            ValidationGroup="m1" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <th>Tenant:</th>
                                    <td>
                                        <asp:TextBox ID="txtTenant" placeholder="Enter Tenant" Width="80%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtTenant"
                                            ValidationGroup="m1" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Default Password:</th>
                                    <td>
                                        <asp:TextBox ID="txtDefaultPass" placeholder="Enter Default Password" Width="80%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDefaultPass"
                                            ValidationGroup="m1" ErrorMessage="*" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <th>Type:</th>
                                    <td>
                                        <asp:DropDownList ID="ddlType" runat="server" Width="80%" CssClass="">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Agents" Value="Agents"></asp:ListItem>
                                            <asp:ListItem Text="Support" Value="Support"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlType"
                                            ValidationGroup="m1" ErrorMessage="*" InitialValue="0" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <hr>
                                <tr style="text-align: center;">
                                    <td colspan="4">
                                        <asp:Button ID="btnADD" Width="10%" CssClass="btn btn-blue" Style="margin-top: 10px" OnClick="btnADD_Click" ValidationGroup="m1" runat="server" Text="Update" />
                                        <asp:HiddenField ID="Hdeditval" runat="server" />
                                    </td>

                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
