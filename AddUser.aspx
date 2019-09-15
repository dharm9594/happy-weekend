<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="ServiceDesk.view.AddUser"   MasterPageFile="~/view/Main.Master"   %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="aspAjax" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
    <script type="text/javascript">
        function RedirectPage() {
            window.parent.location = 'InactiveUser.aspx';
        }
    </script>
    <link href="../css/style.css" rel="stylesheet" />
    <link href="../css/style.min.css" rel="stylesheet" />
    <script src="../js/select2.js"></script>
    <script src="../js/select2.min.js"></script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <telerik:radskinmanager ID="QsfSkinManager" runat="server" ShowChooser="false" Skin="Sitefinity" />
    <telerik:radscriptmanager ID="ScriptManager1" runat="server" ScriptMode="Release"></telerik:radscriptmanager>
    <style>
        .rgRow {
            background-color:white;
            color:black;
        }
            .rgRow a {
                color:black!important;
            }
        .RadComboBox .rcbActionButton {
        height:16px;
        }

        .rgAltRow {
            background-color:#33A1C9 !important;
            color:white;
        }
    </style>
    <div style ="text-align:center;" align="center">
        <br />
        <table style="width:100%;" align="center">
            <tr style="text-align:left;">
                <td colspan="3">
                    <table style="width: 300px;">
                        <tr>
                            <td style="width: 100px;">
                                <telerik:RadButton runat="server" ID="BtnAddRecord" AutoPostBack="false" Text="+ Add Record" OnClientClicking="ShowAddUserForm" class="button" />
                                <br />
                                <br />
                            </td>
                            <td style="width: 100px;">
                                <telerik:RadButton ID="BtnReset" runat="server" OnClick="BtnReset_Click" Text="Reset" class="button" />
                                <br />
                                <br />
                            </td>
                            <td style="width: 100px;">
                                <a href="#" class="LblControl" onclick="RedirectPage();">View Inactive User</a>
                                <%--<telerik:RadButton ID="BtnViewInactiveUser" runat="server" OnClientClick="RedirectPage();" Text="View Inactive User" class="button" />--%>
                                <br />
                                <br />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="3" align="center">
                    <!--DivInsert-->
                    <div id="DivInsert" style="display: none;   border:2px solid black;  background-color:#4f4f4f;color:white;" align="center">
                        <table border="0">
                            <tr>
                                <td colspan="11" style="font-size: small; vertical-align: middle; text-align: center;">
                                    
                                    <asp:Label Text="Add New User" runat="server" style="font-family: Baskerville;font-size:large; font-weight: bold; font-style: italic;"/>
                                </td>
                            </tr>
                            <tr><td style="height:3px;">&nbsp;</td></tr>
                            <tr>
                                <td style="vertical-align:top;">
                                    <asp:Label ID="Label1" runat="server" Text="Employee Id :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TxtLawsonID" runat="server" ForeColor ="Black"></asp:TextBox><br />
                                    
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtLawsonID" ErrorMessage="Lawson id cannot be left blank." ToolTip ="Lawson cannot be left blank." ValidationGroup="ValAdd" ForeColor="Red">*</asp:RequiredFieldValidator>
                                </td>
                                <td style="vertical-align:top;">
                                    <asp:Label ID="AddLblNTID" runat="server" Text="NT ID :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="AddTxtNTID" runat="server" ForeColor ="Black"></asp:TextBox><br />
                                   
                                </td>
                                <td>
                                     <asp:RequiredFieldValidator ID="ReqAddTxtNTID" runat="server" ControlToValidate="AddTxtNTID" ErrorMessage="NTID cannot be left blank." ToolTip ="NTID cannot be left blank." ValidationGroup="ValAdd" ForeColor="Red">*</asp:RequiredFieldValidator>
                                </td>
                                <td style="width: 3px;">&nbsp;</td>
                                <td style="vertical-align:top;">
                                    <asp:Label ID="AddLblFirstName" runat="server" Text="First Name :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="AddTxtFirstName" runat="server"  ForeColor ="Black"></asp:TextBox><br />
                                    
                                </td>
                                <td><asp:RequiredFieldValidator ID="ReqAddTxtFirstName" runat="server" ControlToValidate="AddTxtFirstName" ErrorMessage="FirstName cannot be left blank." ToolTip ="First Name cannot be left blank." ValidationGroup="ValAdd" ForeColor="Red">*</asp:RequiredFieldValidator></td>
                                <td style="width: 3px;">&nbsp;</td>
                                <td style="vertical-align:top;">
                                    <asp:Label ID="AddLblLastName" runat="server"   Text="Last Name :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="AddTxtLastName" runat="server" ForeColor ="Black"></asp:TextBox><br />
                                    <%--<asp:RequiredFieldValidator ID="ReqAddTxtLastName" runat="server" ControlToValidate="AddTxtLastName" ErrorMessage="LastName cannot be left blank." ToolTip ="Last Name cannot be left blank." ValidationGroup="ValAdd" ForeColor="Red">*</asp:RequiredFieldValidator>--%>
                                </td>
                                <td style="width: 3px;">&nbsp;</td>
                                <td style="vertical-align:top;">
                                    <asp:Label ID="AddLblStatus" runat="server" Text="Status :"></asp:Label>
                                </td>
                                <td style="vertical-align:top;">
                                    <asp:RadioButton ID="AddRdoStatusActive" runat="server" GroupName="UserStatus" Text="Active" Checked="true" />
                                    <asp:RadioButton ID="AddRdoStatusInActive" runat="server" GroupName="UserStatus" Text="Inactive" />
                                </td>
                            </tr>
                         <%--   <tr>
                                <td colspan="11" style="height: 3px;">&nbsp;</td>
                            </tr>--%>
                            <tr>
                                   
                                  <td style="vertical-align: top;">
                                    <asp:Label ID="Label2" runat="server" Text="Stretigic Partner:"></asp:Label>
                                </td>
                                <td style="vertical-align: top;">
                                    <telerik:RadComboBox RenderMode="Lightweight" ID="ddlCategory" Width="149px" ForeColor ="Black"  runat="server" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" >
                                                                        </telerik:RadComboBox>
                                </td>
                                <td></td>
                                <td style="vertical-align: top;">
                                    <asp:Label ID="AddLblRoles" runat="server" Text="User Roles :"></asp:Label>
                                </td>
                                <td colspan="8"    style="vertical-align: top;" class="LblControl">
                                    <asp:CheckBoxList ID="AddChkRolesList" runat="server" RepeatColumns="6" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" Width="220"></asp:CheckBoxList>
                                </td>
                              
                            </tr>
                            <tr>
                                <td colspan="11" style="height: 3px;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="11" style="text-align: center;">
                                    <telerik:RadButton ID="BtnAddUser" runat="server" Text="Add User" OnClick="BtnAddUser_Click" ValidationGroup="ValAdd" UseSubmitBehavior="true" CssClass="buttonUser" />&nbsp;
                                    <telerik:RadButton ID="BtnCancel" runat="server" Text="Cancel" OnClick="BtnCancel_Click" CausesValidation="false" CssClass="buttonUser" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <!--DivInsert-->
                    
                </td>
            </tr>
            <tr>
                <td colspan="3" align ="center" >
                    <!--DivGridview-->
                    <div >
                        <telerik:RadGrid ID="userGV" runat="server" AllowAutomaticDeletes="True"  skin ="Black"
                            AllowAutomaticInserts="false" AllowAutomaticUpdates="True"
                            AllowFilteringByColumn="true" AllowPaging="false" AllowSorting="True"
                            AutoGenerateDeleteColumn="True" AutoGenerateEditColumn="true"
                            EnableAriaSupport="True"
                            EnableHeaderContextMenu="True"
                            EnableHierarchyExpandAll="True" RetainExpandStateOnRebind="True" OnNeedDataSource="userGV_NeedDataSource"
                            ShowFooter="true" ShowGroupPanel="false" ShowStatusBar="false" OnDeleteCommand="userGV_DeleteCommand" OnItemCreated="userGV_ItemCreated"
                            OnItemDataBound="userGV_ItemDataBound" OnEditCommand="userGV_EditCommand" OnCancelCommand="userGV_CancelCommand"
                            OnUpdateCommand="userGV_UpdateCommand">
                            <PagerStyle Mode="NextPrevAndNumeric" />
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView EnableGroupsExpandAll="True" EnableHeaderContextAggregatesMenu="False" DataKeyNames="Login_ID"
                                AutoGenerateColumns="false">
                                <Columns>
                                    <telerik:GridBoundColumn UniqueName="Login_ID" HeaderText="Login ID" DataField="Login_ID" AllowFiltering="false" HeaderStyle-Width="100"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="NTID" HeaderText="NT ID" DataField="NT_ID" AllowFiltering="true"></telerik:GridBoundColumn>
                                    <%--<telerik:GridBoundColumn UniqueName="FirstName" HeaderText="First Name" DataField="First_Name" AllowFiltering="true"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="LastName" HeaderText="Last Name" DataField="Last_Name" AllowFiltering="true"></telerik:GridBoundColumn>--%>
                                    <telerik:GridTemplateColumn UniqueName="Name" HeaderText="Name" AllowFiltering="true">
                                        <ItemTemplate>
                                            <asp:Label ID="LblFirstName" runat="server" Text='<%#Bind("Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                   <%-- <telerik:GridTemplateColumn UniqueName="Last_Name" HeaderText="Last Name" AllowFiltering="true">
                                        <ItemTemplate>
                                            <asp:Label ID="LblLastName" runat="server" Text='<%#Bind("Last_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>--%>

                                    <telerik:GridBoundColumn UniqueName="RollID" HeaderText="Roll ID" DataField="Roll_ID" AllowFiltering="false"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="RollName" HeaderText="Roll Name" DataField="Roll_Name" Visible="false"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn UniqueName="UserStatus" HeaderText="User Status" DataField="user_status" AllowFiltering="true"></telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn UniqueName="ViewRoles" AllowFiltering="false" ItemStyle-Width="100">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LnkViewRoles" runat="server" OnClick="LnkViewRoles_Click" CommandArgument='<%#Bind("Login_ID") %>'>View Roles</asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <EditFormSettings EditFormType="Template">
                                    <EditColumn UniqueName="EditUserData" />
                                    <FormTemplate>
                                        <div style="text-align:center; padding-left:200px; padding-right:200px;">
                                        <table id="Table2" width="500" border="0" rules="none">
                                            <tr><td style="height:3px">&nbsp;</td></tr>
                                            <tr>
                                                <td colspan="4" style="font-size: small;">
                                                    <b>Edit User Details</b>
                                                </td>
                                            </tr>
                                            <tr><td style="height:3px">&nbsp;</td></tr>
                                            <tr>
                                                <td style="vertical-align:top;">
                                                    <b>
                                                        <asp:Label ID="LblNTID" runat="server" Text="NT ID :"></asp:Label></b>
                                                </td>
                                                <td style="vertical-align:top;">
                                                    <asp:TextBox ID="TxtNTID" runat="server" Text='<%#Bind("NT_ID") %>'></asp:TextBox><br />
                                                    <asp:RequiredFieldValidator ID="ReqTxtNTID" runat="server" ControlToValidate="TxtNTID" ErrorMessage="*" ValidationGroup="ValUpdate" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                </td>
                                                <td style="vertical-align:top;">
                                                    <b>
                                                        <asp:Label ID="LblFirstName" runat="server" Text="Name :"></asp:Label></b>
                                                </td>
                                                <td style="vertical-align:top;">
                                                    <asp:TextBox ID="TxtFirstName" runat="server" Text='<%#Bind("Name") %>'></asp:TextBox><br />
                                                    <asp:RequiredFieldValidator ID="ReqTxtFirstName" runat="server" ControlToValidate="TxtFirstName" ErrorMessage="*" ValidationGroup="ValUpdate" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                           <%--     <td style="vertical-align:top;">
                                                    <b>
                                                        <asp:Label ID="LblLastName" runat="server" Text="Last Name :"></asp:Label></b>
                                                </td>
                                                <td style="vertical-align:top;">
                                                    <asp:TextBox ID="TxtLastName" runat="server" Text='<%#Bind("Last_Name") %>'></asp:TextBox><br />
                                                    <asp:RequiredFieldValidator ID="ReqTxtLastName" runat="server" ControlToValidate="TxtLastName" ErrorMessage="*" ValidationGroup="ValUpdate" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                </td>--%>
                                                <td style="vertical-align:top;">
                                                    <b>
                                                        <asp:Label ID="LblStatus" runat="server" Text="Status :"></asp:Label></b>
                                                </td>
                                                <td style="vertical-align:top;">
                                                    <asp:RadioButton ID="RdoStatusActive" runat="server" GroupName="UserStatus" Text="Active" />
                                                    <asp:RadioButton ID="RdoStatusInActive" runat="server" GroupName="UserStatus" Text="Inactive" />
                                                    <div style="visibility: hidden;">
                                                        <asp:Label ID="LblHdnStatus" runat="server" Text='<%#Bind("user_status")%>'></asp:Label>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                 <td colspan="4" style="height: 5px;">&nbsp;</td>
                                            </tr>
                                            <tr style="text-align:center;">
                                                <td colspan="4">
                                                    <telerik:RadButton ID="btnUpdate" Text="Update" runat="server" CommandName="Update" CssClass="buttonUser" UseSubmitBehavior="true" ValidationGroup="ValUpdate" ></telerik:RadButton>
                                                    &nbsp;<telerik:RadButton ID="btnCancel" Text="Cancel" runat="server" CausesValidation="false" CommandName="Cancel" CssClass="buttonUser"></telerik:RadButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" style="height: 5px;">&nbsp;</td>
                                            </tr>
                                        </table>
                                        </div>
                                    </FormTemplate>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                    <!--DivGridview-->
                </td>
            </tr>
        </table>

        <!--DivEditRolePopup-->
        <telerik:RadButton runat="server" ID="btnShowModalPopup" Style="display: none" />
        <aspAjax:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btnShowModalPopup"
            PopupControlID="divPopUp" BackgroundCssClass="modalBackground" PopupDragHandleControlID="panelDragHandle"
            DropShadow="false" CancelControlID="CancelButton" />

        <div class="modalPopup" id="divPopUp" style="display: none; border: solid">
            <div class="row">
                <div class="col-lg-12" style="padding-top:5px; text-align:center"><asp:Label ID="LblPopupUserName" runat="server"></asp:Label></div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <asp:CheckBoxList ID="ChkRolesList" runat="server" RepeatColumns="5" RepeatDirection="Horizontal" ForeColor ="White" CellPadding="5" CellSpacing="5" CssClass="CheckList" Width="400"></asp:CheckBoxList>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-6" style="text-align:right; padding-right:2px;">
                    <telerik:RadButton ID="BtnUpdateRole" runat="server" Text="Update" OnClick="BtnUpdateRole_Click" CssClass="buttonUser" />&nbsp;
                </div>

                <div class="col-lg-6" style="text-align:left; padding-left:2px;">
                    <telerik:RadButton ID="CancelButton" runat="server" Text="Cancel" CssClass="buttonUser" />
                </div>
            </div>
        </div>

        <div style="visibility: hidden;">
            <asp:TextBox ID="TxtHdnLoginID" runat="server"></asp:TextBox>
        </div>
        <!--DivEditRolePopup-->

        <script type="text/javascript" language="javascript">
            function ShowAddUserForm() {
                $('#DivInsert').slideDown();
                //document.getElementById("DivInsert").style.display = "block";
                return false;
            }

            function HideAddUserForm() {
                $('#DivInsert').slideUp();
                //document.getElementById("DivInsert").style.display = "none";
            }

            //function FnValidateAddUser() {
            //    var bFlag = true;
            //    var vAddTxtNTID = document.getElementById('AddTxtNTID.ClientID').value;
            //    var vAddTxtFirstName = document.getElementById('AddTxtFirstName.ClientID').value;
            //    var vAddTxtLastName = document.getElementById('AddTxtLastName.ClientID').value;

            //    if (vAddTxtNTID == "" || vAddTxtNTID == null || vAddTxtNTID == "undefinied") {
            //        bFlag = false;
            //        alert("NT ID Required.");
            //        return bFlag;
            //    }

            //    if (vAddTxtFirstName == "" || vAddTxtFirstName == null || vAddTxtFirstName == "undefinied") {
            //        bFlag = false;
            //        alert("First Name Required.");
            //        return bFlag;
            //    }

            //    if (vAddTxtLastName == "" || vAddTxtLastName == null || vAddTxtLastName == "undefinied") {
            //        bFlag = false;
            //        alert("Last Name Required.");
            //        return bFlag;
            //    }

            //    if (!fnvalidateaddchkroleslist()) {
            //        bflag = false;
            //        alert("please select user role.");
            //        return bflag;
            //    }
            //}

            //function FnValidateAddChkRolesList() {
            //    var bFlag = false;
            //    var checkboxlist = document.getElementById('AddChkRolesList.ClientID');
            //    var inputlist = checkboxlist.getElementsByTagName('input');

            //    for (var i = 0; i < inputlist.length; i++) {
            //        if (inputlist[i].type == 'checkbox') {
            //            if (inputlist[i].checked) {
            //                bFlag = true;
            //                break;
            //            }
            //        }
            //    }
            //    return bFlag;
            //}

            function FnValidateEditUser() {
                var bFlag = true;
                var vTxtNTID = document.getElementById(window['TxtNTID_ID']).value;
                var vTxtFirstName = document.getElementById(window['TxtFirstName_ID']).value;
                var vTxtLastName = document.getElementById(window['TxtLastName_ID']).value;

                if (vTxtNTID == "" || vTxtNTID == null || vTxtNTID == "undefinied") {
                    bFlag = false;
                    alert("NT ID Required.");
                    return bFlag;
                }

                if (vTxtFirstName == "" || vTxtFirstName == null || vTxtFirstName == "undefinied") {
                    bFlag = false;
                    alert("First Name Required.");
                    return bFlag;
                }

                if (vTxtLastName == "" || vTxtLastName == null || vTxtLastName == "undefinied") {
                    bFlag = false;
                    alert("Last Name Required.");
                    return bFlag;
                }
            }
        </script>

        <style type="text/css">
            div.RadWindow {
                z-index: 9000 !important;
            }

            .modalBackground {
                background-color: Gray;
                filter: alpha(opacity=70);
                opacity: 0.7;
            }

            .modalPopup {
                background-color: #4f4f4f;
                border-width: 3px;
                border-style: solid;
                border-color: Gray;
                padding: 3px;
                width: 450px;
                color:white;
            }

            .rgEditForm {
                background-color: white;
                color: black;
            }
        </style>
    </div>
</asp:Content>
