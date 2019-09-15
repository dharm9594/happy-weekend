<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" CodeBehind="StratigicPartner_Master.aspx.cs" Inherits="adminTemp.StratigicPartner_Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <script>
       function validate() {
           debugger;
           var ddlSite = $("#ContentPlaceHolder1_ddlSite").val();
           var txtPartner_id = $("#ContentPlaceHolder1_txtPartner_id").val();
           var txtPartner_Name = $("#ContentPlaceHolder1_txtPartner_Name").val();

           if (ddlSite == '0' || ddlSite == '' || ddlSite == null) {
               alert('Please Select Site !!!');
               document.getElementById("<%=ddlSite.ClientID%>").focus();
                return false;
            }
           if (txtPartner_id == '0' || txtPartner_id == '' || txtPartner_id == null) {
                alert('Please Enter Partner Id !!!');
                document.getElementById("<%=txtPartner_id.ClientID%>").focus();
                return false;
            }
           if (txtPartner_Name == '0' || txtPartner_Name == '' || txtPartner_Name == null) {
                alert('Please Enter Partner Name !!!');
                document.getElementById("<%=txtPartner_Name.ClientID%>").focus();
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
                <li><a href="#" style="text-decoration: none; cursor: none;">Stratigic Partner Master</a></li>
            </ol>
        </div>
    </div>
    <div class="container" style="text-align:center">
          <div id="Workspace1_MainContent_pnlRequest" style="text-align: -webkit-center;">
					
              <div class="row">
            <div class="col-sm-6" style="width:50%;" >
               <%-- <fieldset style="/*text-align: -webkit-left; padding:5px; background-color: #d6ebf5;*/    margin-top: 10px;">
                    <legend style="border-radius:5px; padding: 2px 16px;  color:white; background-color: #E31837;">Stratigic Partner Master</legend>--%>
                <div class="box-header">
                     <div class="box-name">
                           <div class="row">
                                <div class="col-lg-6" style="text-align: left;">
                                       <i class="fa fa-book" aria-hidden="true"></i>
                                        <span style="font-size: 15px !important;">Stratigic Partner Master</span>
                                    </div>
                               </div>
                         </div>
                    </div>
                 <div class="box-content ReqDivBcg">
                    <div style=" width:100%">
                    <table style="width:100%" class="dGrid">
                        <colgroup>
                            <col width="150px">
                        </colgroup>
                        <tbody><tr>
                            <th>Site:</th>
                            <td>
                              <asp:DropDownList ID="ddlSite" runat="server" Width="60%" CssClass="" Style=" margin-top: 2%">
                                <asp:ListItem Value="0" Text="--Select--"> </asp:ListItem>
                                <asp:ListItem Value="002" Text="Site1"></asp:ListItem>
                                <asp:ListItem Value="003" Text="Site2"></asp:ListItem>
                                <asp:ListItem Value="004" Text="Site3"></asp:ListItem>
                                    </asp:DropDownList>
                            </td>
                        </tr>
                              <tr>
                            <th>Stratigic Partner ID:</th>
                            <td>
                                <asp:TextBox ID="txtPartner_id" placeholder="Enter Stratigic Partner ID" Width="60%" CssClass="" autocomplete="off" runat="server"></asp:TextBox>    
                            </td>
                        </tr>
                            <tr>
                            <th>Stratigic Partner Name:</th>
                            <td>
                                <asp:TextBox ID="txtPartner_Name" Width="60%" placeholder="Enter Stratigic Partner Name" CssClass="" autocomplete="off" runat="server"></asp:TextBox>    
                            </td>
                        </tr>
                        <%--<tr>
                            <td colspan="2">
                                <hr>
                            </td>
                        </tr>--%>
                          <%--  <hr>--%>
                        <tr style="text-align:center">
                            <td colspan="2">
                            <asp:Button ID="btnADD" Width="30%" CssClass="btn btn-blue" OnClientClick="return validate();"  OnClick="btnAdd_Click" runat="server" Text="Add" />
                                </td>
                        </tr>
                     <%--   <tr>
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
             <%--   </fieldset>--%>

            </div>
                   
              <div class="col-sm-6" style="width:90% ;margin-top:10px">
                   <%-- <fieldset style="/*text-align: -webkit-left; padding:5px; background-color: #d6ebf5;*/    margin-top: 10px;">
                    <legend style="border-radius:5px; padding: 2px 16px;   color:white; background-color: #E31837;">Stratigic Partner Details</legend>--%>
                   <div class="box-header">
                     <div class="box-name">
                           <div class="row">
                                <div class="col-lg-6" style="text-align: left;">
                                        <i class="fa fa-home"></i>
                                        <span style="font-size: 15px !important;">Stratigic Partner Details</span>
                                    </div>
                                 
                               </div>
                          
                         </div>
                    </div>
                  
                    <div class="box-content ReqDivBcg" >
                          <div class="" style=" width:100%">
                           <%--   <hr>--%>
            <asp:GridView ID="GridView1" runat="server" align="center" CellPadding="4" ForeColor="#333333" GridLines="None"
                Style="width:100%" CssClass="dGrid" OnRowDeleting="GridView1_RowDeleting" AllowPaging="True" PageSize="8"
                OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound" EmptyDataText=" " AutoGenerateColumns="False">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ItemStyle-Width="70px" HeaderText="Delete" DeleteText="<i class='fa fa-trash-o'></i>" />
                    <asp:BoundField DataField="ID" ItemStyle-Width="70px" HeaderText="ID" ReadOnly="True" SortExpression="ID" />
                    <asp:BoundField DataField="Stratigic_Partner_Name" ItemStyle-Width="150px" HeaderText="Stratigic Partner Name" SortExpression="Stratigic_Partner_Name" />
                    <asp:BoundField DataField="Site" ItemStyle-Width="150px" HeaderText="Site  " SortExpression="Site" />
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
                         <%--</fieldset>--%>
              </div>
        </div>
            <br style="float: none; clear: both"/>
<%--            <input type="submit" name="ctl00$Workspace1$MainContent$btnSave" value="Create Service Request" id="Workspace1_MainContent_btnSave" class="btn btn-blue"/>--%>


        
				</div>
          </div>
</asp:Content>
