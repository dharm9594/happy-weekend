<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" CodeBehind=" StratigicSites_Master.aspx.cs" Inherits="adminTemp.StratigicSites_Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <%--  <link href="../css/btnStyles.css" rel="stylesheet" />
    <link href="../css/tbl.css" rel="stylesheet" />--%>
    <script>
        function validate() {
            debugger;
            var ddlRegion = $("#ContentPlaceHolder1_ddlRegion").val();
            var ddlCountry = $("#ContentPlaceHolder1_ddlCountry").val();
            var txtSite = $("#ContentPlaceHolder1_txtSite").val();

            if (ddlRegion == '0' || ddlRegion == '' || ddlRegion == null) {
                alert('Please Select Region !!!');
                document.getElementById("<%=ddlRegion.ClientID%>").focus();
                return false;
            }
            if (ddlCountry == '0' || ddlCountry == '' || ddlCountry == null) {
                alert('Please Select Country !!!');
                document.getElementById("<%=ddlCountry.ClientID%>").focus();
                return false;
            }
            if (txtSite == '0' || txtSite == '' || txtSite == null) {
                alert('Please Enter Site Name !!!');
                document.getElementById("<%=txtSite.ClientID%>").focus();
                return false;
            }

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div id="breadcrumb" class="col-md-12">
            <ol class="breadcrumb">
                <li><a href="#" style="text-decoration: none; cursor: none;">Master</a></li>
                <li><a href="#" style="text-decoration: none; cursor: none;">Stratigic Site Master</a></li>
            </ol>
        </div>
    </div>
    <div class="container" style="text-align:center">
          <div id="Workspace1_MainContent_pnlRequest" style="text-align: -webkit-center;">
					
              <div class="row">
            <div class="col-sm-6" style="width:50%" >
               <%-- <fieldset style="/*text-align: -webkit-left; padding:5px; background-color: #d6ebf5;*/    margin-top: 10px;">
                    <legend style="border-radius:5px; padding: 2px 16px;  color:white; background-color: #E31837;">Stratigic Site Master</legend>--%>
                      <div class="box-header">
                     <div class="box-name">
                           <div class="row">
                                <div class="col-lg-6" style="text-align: left;">
                                       <i class="fa fa-book" aria-hidden="true"></i>
                                        <span style="font-size: 15px !important;">Stratigic Site Master</span>
                                    </div>
                               </div>
                         </div>
                    </div>
                  <div class="box-content ReqDivBcg">
                    <div style=" width:100%">
                    <table style="width:100%" class=" dGrid">
                        <colgroup>
                            <col width="150px">
                        </colgroup>
                        <tbody><tr>
                            <th>Region:</th>
                            <td>
                              <asp:DropDownList ID="ddlRegion" runat="server" Width="60%" CssClass="" Style=" margin-top: 2%">
                                <asp:ListItem Value="0" Text="--Select--"> </asp:ListItem>
                                <asp:ListItem Value="0022" Text="Region1"></asp:ListItem>
                                <asp:ListItem Value="0033" Text="Region2"></asp:ListItem>
                                <asp:ListItem Value="0044" Text="Region3"></asp:ListItem>
                                    </asp:DropDownList>
                            </td>
                        </tr>
                              <tr>
                            <th>Country:</th>
                            <td>
                               <asp:DropDownList ID="ddlCountry" runat="server" Width="60%" CssClass="" Style=" margin-top: 2%">
                                <asp:ListItem Value="0" Text="--Select--"> </asp:ListItem>
                                <asp:ListItem Value="02" Text="Country1"></asp:ListItem>
                                <asp:ListItem Value="03" Text="Country2"></asp:ListItem>
                                <asp:ListItem Value="04" Text="Country3"></asp:ListItem>
                                    </asp:DropDownList>
                            </td>
                        </tr>
                            <tr>
                            <th>Site:</th>
                            <td>
                                <asp:TextBox ID="txtSite" placeholder="Enter Stratigic Site Name" Width="60%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>    
                            </td>
                        </tr>
                      <%--  <tr>
                            <td colspan="2">
                                <hr>
                            </td>
                        </tr>--%>
                            <hr>
                        <tr style="text-align:center">
                            <td colspan="2">
                            <asp:Button ID="btnADD" CssClass="btn btn-blue" OnClientClick="return validate();"  Width="30%" OnClick="btnAdd_Click" runat="server" Text="Add" />
                                </td>
                        </tr>
                 <%--       <tr>
                            <td colspan="2">
                                <hr>
                            </td>
                        </tr>
                        <tr>
                           
                        </tr>
                        <tr>
                            <td colspan="2">
                              
</td>
                        </tr>--%>

                    </tbody></table>
                        </div>
                      </div>
               <%-- </fieldset>--%>

            </div>
              <div class="col-sm-6" style="width:90%; margin-top:10px">
                    <%--<fieldset style="/*text-align: -webkit-left; padding:5px; background-color: #d6ebf5;*/    margin-top: 10px;">
                    <legend style="border-radius:5px; padding: 2px 16px;   color:white; background-color: #E31837;">Stratigic Site Details</legend>--%>
                       <div class="box-header">
                     <div class="box-name">
                           <div class="row">
                                <div class="col-lg-6" style="text-align: left;">
                                        <i class="fa fa-home"></i>
                                        <span style="font-size: 15px !important;">Stratigic Site Details</span>
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
                    <asp:CommandField ShowDeleteButton="True" ItemStyle-Width="70px"  DeleteImageUrl="~/images/delete.png" HeaderText="Delete" DeleteText="delete<i class='fa fa-trash-o'></i>" />
                  <%--   <asp:TemplateField HeaderText="Edit" ItemStyle-Width="40px">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkRegion" Text='<i class="fa fa-edit"></i>' ItemStyle-Width="70px" CommandArgument='<%# Eval("Site_ID") %>' runat="server" OnClick="lnkEdit_Click"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                     <asp:BoundField DataField="Site_ID" ItemStyle-Width="70px" HeaderText="Site ID" ReadOnly="True" SortExpression="Site_ID" />
                    <asp:BoundField DataField="Site" ItemStyle-Width="150px" HeaderText="Site" SortExpression="Site" />
                    <asp:BoundField DataField="Region" ItemStyle-Width="150px" HeaderText="Region" SortExpression="Region" />
                    <asp:BoundField DataField="Country" ItemStyle-Width="150px" HeaderText="Country" SortExpression="Country" />
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
<%--            <input type="submit" name="ctl00$Workspace1$MainContent$btnSave" value="Create Service Request" id="Workspace1_MainContent_btnSave" class="btn btn-blue"/>--%>


        
				</div>
          </div>
</asp:Content>
