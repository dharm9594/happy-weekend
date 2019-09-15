<%@ Page Title="" Language="C#" MasterPageFile="~/view/Main.Master" AutoEventWireup="true" CodeBehind="EmailIDStrategicPartnerMaster.aspx.cs" Inherits="ServiceDesk.view.EmailIDStrategicPartnerMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/btnStyles.css" rel="stylesheet" />
    <link href="../css/tbl.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="row">
        <div id="breadcrumb" class="col-md-12">
            <ol class="breadcrumb">
                <li><a href="#" style="text-decoration: none; cursor: none;">Master</a></li>
                <li><a href="#" style="text-decoration: none; cursor: none;">EmailIDStratigic Partner Master</a></li>
            </ol>
        </div>
    </div>
    <div class="container" style="text-align: center">
        <div id="Workspace1_MainContent_pnlRequest" style="text-align: -webkit-center;">
            <div class="row">
                <div class="col-sm-6" style="width: 50%">
                    <div class="box-header">
                     <div class="box-name">
                           <div class="row">
                                <div class="col-lg-6" style="text-align: left;">
                                       <i class="fa fa-book" aria-hidden="true"></i>
                                        <span style="font-size: 15px !important;">EmailIDStratigic Partner Master</span>
                                    </div>
                               </div>
                         </div>
                    </div>
                     <div class="box-content ReqDivBcg">
                        <div style="width: 100%">
                            <table style="width: 100%" class="dGrid">
                                <colgroup>
                                    <col width="150px">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th>Strategic Partner:</th>
                                        <td>
                                            <asp:DropDownList ID="ddlStrategicPatner" runat="server" Width="60%" CssClass="" Style="margin-top: 2%">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="Reqddlstrategicpatner" runat="server" ControlToValidate="ddlStrategicPatner"
                                                ValidationGroup="m1" ErrorMessage="required field" InitialValue="0" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Domain Name:</th>
                                        <td>
                                            <asp:TextBox ID="txtStrategicPatner_Emailadd" placeholder="Enter Domain Name" Width="60%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="ReqtxtStrategicPatner_Emailadd" runat="server" ControlToValidate="txtStrategicPatner_Emailadd"
                                                ValidationGroup="m1" ErrorMessage="required field" InitialValue="" CssClass="validator" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <hr>
                                    <tr style="text-align: center">
                                        <td colspan="2">
                                            <asp:Button ID="btnADD" Width="30%" CssClass="btn btn-blue" OnClick="btnADD_Click" ValidationGroup="m1" runat="server" Text="Add" />
                                            <asp:HiddenField ID="Hdeditval" runat="server" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>                   
                    </div>
                </div>
                <div class="col-sm-6" style="width: 90%">
                     <div class="box-header">
                     <div class="box-name">
                           <div class="row">
                                <div class="col-lg-6" style="text-align: left;">
                                       <i class="fa fa-book" aria-hidden="true"></i>
                                        <span style="font-size: 15px !important;">EmailIDStratigic Partner Details</span>
                                    </div>
                               </div>
                         </div>
                    </div>
                      <div class="box-content ReqDivBcg">
                        <div class="" style="width: 100%">
                            <asp:GridView ID="Grddata" runat="server" align="center" CellPadding="4" ForeColor="#333333" GridLines="None"
                                Style="width: 100%" CssClass="dGrid" EmptyDataText=" " AutoGenerateColumns="False" AllowPaging="True" PageSize="8" OnPageIndexChanging="Grddata_PageIndexChanging">
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
                                            <asp:Label ID="lblid" runat="server" Text='<%#Bind("id") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="StrategicPID" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblstrategicPid" runat="server" Text='<%#Bind("StrategicPartnerID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Domain Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDomainName" runat="server" Text='<%#Bind("EmailAddressExtention") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Strategic Partner Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStrategicPName" runat="server" Text='<%#Bind("StrategicPartner") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Created Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lbldate" runat="server" Text='<%#Eval("Created_date","{0:dd-MM-yyyy}")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Created By" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCreatedBy" runat="server" Text='<%#Bind("Created_By") %>'></asp:Label>
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
                </div>
            </div>
            <br style="float: none; clear: both" />

        </div>
    </div>

</asp:Content>
