<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" CodeBehind="_Links.aspx.cs" Inherits="adminTemp._Links" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <%--  <link href="../css/btnStyles.css" rel="stylesheet" />
    <link href="../css/tbl.css" rel="stylesheet" />--%>
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div id="breadcrumb" class="col-md-12">
            <ol class="breadcrumb">
                <li><a href="#" style="text-decoration: none; cursor: none;">Useful Links</a></li>
                <li><a href="#" style="text-decoration: none; cursor: none;">Useful Links</a></li>
            </ol>
        </div>
    </div>
    <div class="container" style="text-align:center">
          <div id="Workspace1_MainContent_pnlRequest" style="text-align: -webkit-center;">
					
              <div class="row">
              <div class="col-sm-6" style="width:90%; margin-top:10px">
                    <%--<fieldset style="/*text-align: -webkit-left; padding:5px; background-color: #d6ebf5;*/    margin-top: 10px;">
                    <legend style="border-radius:5px; padding: 2px 16px;   color:white; background-color: #E31837;">Stratigic Site Details</legend>--%>
                       <div class="box-header">
                     <div class="box-name">
                           <div class="row">
                                <div class="col-lg-6" style="text-align: left;">
                                        <i class="fa fa-link"></i>
                                        <span style="font-size: 15px !important;">Useful Links</span>
                                    </div>
                                 
                               </div>
                          
                         </div>
                    </div>
                    <div class="box-content ReqDivBcg" >
                          <div class="" style=" width:100%">
            <asp:GridView ID="GridView1" runat="server" align="center" CellPadding="4" ForeColor="#333333" GridLines="None"
                Style="width:100%" CssClass="dGrid" OnRowDeleting="GridView1_RowDeleting" AllowPaging="True" PageSize="8"
                OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound" EmptyDataText=" " AutoGenerateColumns="False">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ItemStyle-Width="30%"  DeleteImageUrl="~/images/delete.png" HeaderText="Delete" DeleteText="<i class='fa fa-trash-o'></i>" />
                  <%--   <asp:TemplateField HeaderText="Edit" ItemStyle-Width="40px">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkRegion" Text='<i class="fa fa-edit"></i>' ItemStyle-Width="70px" CommandArgument='<%# Eval("Site_ID") %>' runat="server" OnClick="lnkEdit_Click"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                     <asp:BoundField DataField="id" ItemStyle-Width="20%" HeaderText="ID" ReadOnly="True" SortExpression="id" />
                    <asp:BoundField DataField="Name" ItemStyle-Width="150px" HeaderText="Name" SortExpression="Name" />
                    <asp:HyperLinkField DataNavigateUrlFields="Links" Target="_blank" Text="Click here" ItemStyle-Width="150" HeaderText="Links" SortExpression="Links" />
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
                        <%-- </fieldset>--%>
              </div>
        </div>
            <br style="float: none; clear: both"/>
				</div>
          </div>
</asp:Content>
