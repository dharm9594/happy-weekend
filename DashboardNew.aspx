<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/view/Main.Master" AutoEventWireup="true" CodeBehind="DashboardNew.aspx.cs" Inherits="ServiceDesk.view.DashboardNew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/theme.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" ScriptMode="Release"></telerik:RadScriptManager>
    <div class="row">
        <div id="breadcrumb" class="col-md-12">
            <ol class="breadcrumb">
                <li style="color: white;">Dashboard</li>
            </ol>
        </div>
    </div>
    <div class="row">
          <div>
                           <div  class="col-sm-6 col-lg-3">
                                <div class="overview-item overview-item--c1">
                                    <div class="overview__inner">
                                         <a href="ViewTicketRequestorData.aspx">
                                        <div class="overview-box clearfix inner">
                                            <div class="icon">
                                                <i class="fa fa-home"></i>
                                            </div>
                                            <div class="text">
                                                <h2 id="lblPendingTicket" runat="server"></h2>
                                                <span>Pending Tickets</span>
                                            </div>
                                        </div>
                                             </a>
                                      <%--  <div class="overview-chart">
                                            <canvas id="widgetChart1"></canvas>
                                        </div>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-3">
                                <div class="overview-item overview-item--c2">
                                    <div class="overview__inner">
                                         <a href="ViewTicketResolveData.aspx">
                                        <div class="overview-box clearfix">
                                            <div class="icon">
                                                <i class="fa fa-book"></i>
                                            </div>
                                            <div class="text">
                                                <h2 id="lblResolveTicket" runat="server"></h2>
                                                <span>Resolved Tickets</span>
                                            </div>
                                        </div>
                                         </a>
                                      <%--  <div class="overview-chart">
                                            <canvas id="widgetChart2"></canvas>
                                        </div>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-3">
                                <div class="overview-item overview-item--c3">
                                    <div class="overview__inner">
                                         <a href="ViewTicketRequestorData.aspx">
                                        <div class="overview-box clearfix">
                                            <div class="icon">
                                                <i class="fa fa-book"></i>
                                            </div>
                                            <div class="text">
                                                <h2 id="lblRepliedTicket" runat="server"></h2>
                                                <span>Replied Tickets</span>
                                            </div>
                                        </div>
                                             </a>
                                      <%--  <div class="overview-chart">
                                            <canvas id="widgetChart3"></canvas>
                                        </div>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-3">
                                <div class="overview-item overview-item--c4">
                                    <div class="overview__inner">
                                        <div class="overview-box clearfix">
                                            <div class="icon">
                                                <i class="fa fa-book"></i>
                                            </div>
                                            <div class="text">
                                                <h2 id="lblTotalTicket" runat="server"></h2>
                                                <span>Total Tickets</span>
                                            </div>
                                        </div>
                                       
                                     <%--   <div class="overview-chart">
                                            <canvas id="widgetChart4"></canvas>
                                        </div>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
    </div>

   <%-- <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header">
                    <div class="box-name">
                        <i class="fa fa-home"></i>
                        <span style="font-size: 15px !important;">Chart for Stratigic Partner Wise</span>
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

                <div class="box-content" style="min-height: 300px;">
                    <div class="row">
                        <div class="col-lg-6">
                            <div id="DivColumn">
                                <telerik:RadHtmlChart runat="server" ID="ColumnChart" Width="500" Height="300" Transitions="true">
                                    <Appearance>
                                        <FillStyle BackgroundColor="White"></FillStyle>
                                    </Appearance>

                                    <ChartTitle Text="Stratigic Partner Wise">
                                        <Appearance Align="Center" BackgroundColor="White" Position="Top"></Appearance>
                                    </ChartTitle>

                                    <Legend>
                                        <Appearance BackgroundColor="White" Position="Bottom"></Appearance>
                                    </Legend>

                                    <PlotArea>
                                        <Appearance>
                                            <FillStyle BackgroundColor="White"></FillStyle>
                                        </Appearance>

                                        <XAxis AxisCrossingValue="0" Color="#b3b3b3" MajorTickType="Outside" DataLabelsField="stratigic_Partner_Name" MinorTickType="Outside" Reversed="false">
                                            <LabelsAppearance DataFormatString="{0}"  RotationAngle="0"></LabelsAppearance>
                                            <MajorGridLines Color="#EFEFEF" Width="1"></MajorGridLines>
                                            <MinorGridLines Color="#F7F7F7" Width="1"></MinorGridLines>
                                        </XAxis>

                                        <YAxis AxisCrossingValue="0" Color="#b3b3b3" MajorTickSize="1" MajorTickType="Outside"  MinorTickSize="1" 
                                            MinorTickType="Outside" MinValue="0" Reversed="false" Step="10">

                                            <LabelsAppearance DataFormatString="{0}" RotationAngle="0"></LabelsAppearance>
                                            <MajorGridLines Color="#EFEFEF" Width="1"></MajorGridLines>
                                            <MinorGridLines Color="#F7F7F7" Width="1"></MinorGridLines>
                                            <TitleAppearance Position="Center" RotationAngle="0" Text=""></TitleAppearance>
                                        </YAxis>

                                        <Series>
                                            <telerik:ColumnSeries Name="Pending" DataFieldY="Pending">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#D43D1A"></FillStyle>
                                                </Appearance>

                                                <LabelsAppearance DataFormatString="{0}" Position="OutsideEnd"></LabelsAppearance>
                                                <TooltipsAppearance DataFormatString=" Pending {0}" Color="White"></TooltipsAppearance>
                                            </telerik:ColumnSeries>

                                            <telerik:ColumnSeries Name="Replied" Stacked="false" DataFieldY="Replied">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#FFA812"></FillStyle>
                                                </Appearance>

                                                <LabelsAppearance DataFormatString="{0}" Position="OutsideEnd"></LabelsAppearance>
                                                <TooltipsAppearance DataFormatString=" Replied {0}" Color="White"></TooltipsAppearance>
                                            </telerik:ColumnSeries>
                                            <telerik:ColumnSeries Name="Resolved" DataFieldY="Resolved">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#66CD00"></FillStyle>
                                                </Appearance>

                                                <LabelsAppearance DataFormatString="{0}" Position="OutsideEnd"></LabelsAppearance>
                                                <TooltipsAppearance DataFormatString=" Resolved {0}" Color="White"></TooltipsAppearance>
                                            </telerik:ColumnSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="datagrid" style=" overflow:auto; padding: 15px; height:300px">
                                <asp:GridView ID="GrdStatusPass" runat="server" AutoGenerateColumns="false" EmptyDataText="!!! No Password reset for this ticket !!!" EmptyDataRowStyle-CssClass="LblFont"
                                    GridLines="Both" BorderColor="Black" >
                                    <Columns>
                                        <asp:BoundField HeaderText="Sr No" DataField="RowID" />
                                        <asp:TemplateField HeaderText="Stratigic Partner">
                                            <ItemTemplate>
                                                <asp:Label ID="LblID" runat="server" Text='<%#Bind("stratigic_Partner_Name")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Resolved" DataField="Resolved" />
                                        <asp:BoundField HeaderText="Replied" DataField="Replied" />
                                        <asp:BoundField HeaderText="Pending" DataField="Pending" />

                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>--%>

     <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header">
                    <div class="box-name">
                        <i class="fa fa-home"></i>
                        <span style="font-size: 15px !important;">Tenant Wise Self Password reset</span>
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

                <div class="box-content" style="min-height: 300px;">
                    <div class="row">
                        <div class="col-lg-6">
                           <div id="Div1">
                                  <telerik:RadHtmlChart runat="server" ID="Pie_Chart_Tenant" Width="500"  Height="300" Transitions="true">
                                    <Appearance>
                                        <FillStyle BackgroundColor="White"></FillStyle>
                                    </Appearance>
                                    <ChartTitle Text="Tenant Wise">
                                        <Appearance Align="Center" BackgroundColor="White" Position="Top"></Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance BackgroundColor="White" Position="Right" Visible="true"></Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Appearance>
                                            <FillStyle BackgroundColor="White"></FillStyle>
                                        </Appearance>
                                        <Series>
                                            <telerik:PieSeries DataFieldY="Total_Percentage"   NameField="FieldName" StartAngle="90">
                                                 <Appearance>
                                                     <FillStyle BackgroundColor="#66CD00"></FillStyle>
                                                </Appearance>
                                                <LabelsAppearance   DataFormatString="{0}%"></LabelsAppearance>
                                                <TooltipsAppearance Color="White" DataFormatString="{0}%"></TooltipsAppearance>
                                            </telerik:PieSeries>
                                  
                                          
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
                            </div>
                        </div>

                        <div class="col-lg-6">
                             <div class="datagrid" style=" overflow:auto; padding: 15px; height:300px">
                                <asp:GridView ID="grdTenantSelf" runat="server" AutoGenerateColumns="false" EmptyDataText="!!! No Password reset for this ticket !!!" EmptyDataRowStyle-CssClass="LblFont"
                                    GridLines="Both" BorderColor="Black" >
                                    <Columns>
                                          <asp:BoundField HeaderText="Filed Name" DataField="FieldName" />
                                        <asp:BoundField HeaderText="Values" DataField="Value" />
                                         <asp:BoundField HeaderText="%" DataField="Total_Percentage" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header">
                    <div class="box-name">
                        <i class="fa fa-home"></i>
                        <span style="font-size: 15px !important;">Chart for Issue Sub Type Wise</span>
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

                <div class="box-content" style="min-height: 300px;">
                     <div class="row">
                        <div class="col-lg-6">
                            <div id="DivIssueWise">
                                <telerik:RadHtmlChart runat="server" ID="ColumnForIssueWise" Width="500" Height="300" Transitions="true">
                                    <Appearance>
                                        <FillStyle BackgroundColor="White"></FillStyle>
                                    </Appearance>

                                    <ChartTitle Text="Issue sub Type Wise">
                                        <Appearance Align="Center" BackgroundColor="White" Position="Top"></Appearance>
                                    </ChartTitle>

                                    <Legend>
                                        <Appearance BackgroundColor="White" Position="Bottom"></Appearance>
                                    </Legend>

                                    <PlotArea>
                                        <Appearance>
                                            <FillStyle BackgroundColor="White"></FillStyle>
                                        </Appearance>

                                        <XAxis AxisCrossingValue="0" Color="#b3b3b3" MajorTickType="Outside" DataLabelsField="Issue_SubType" MinorTickType="Outside" Reversed="false">
                                            <LabelsAppearance DataFormatString="{0}"  RotationAngle="0"></LabelsAppearance>
                                            <MajorGridLines Color="#EFEFEF" Width="1"></MajorGridLines>
                                            <MinorGridLines Color="#F7F7F7" Width="1"></MinorGridLines>
                                        </XAxis>

                                        <YAxis AxisCrossingValue="0" Color="#b3b3b3" MajorTickSize="1" MajorTickType="Outside"  MinorTickSize="1" 
                                            MinorTickType="Outside" MinValue="0" Reversed="false" Step="10">

                                            <LabelsAppearance DataFormatString="{0}" RotationAngle="0"></LabelsAppearance>
                                            <MajorGridLines Color="#EFEFEF" Width="1"></MajorGridLines>
                                            <MinorGridLines Color="#F7F7F7" Width="1"></MinorGridLines>
                                            <TitleAppearance Position="Center" RotationAngle="0" Text=""></TitleAppearance>
                                        </YAxis>

                                        <Series>
                                            <telerik:ColumnSeries Name="Pending" DataFieldY="Pending">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#D43D1A"></FillStyle>
                                                </Appearance>

                                                <LabelsAppearance DataFormatString="{0}" Position="OutsideEnd"></LabelsAppearance>
                                                <TooltipsAppearance DataFormatString=" Pending {0}" Color="White"></TooltipsAppearance>
                                            </telerik:ColumnSeries>

                                            <telerik:ColumnSeries Name="Replied" Stacked="false" DataFieldY="Replied">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#FFA812"></FillStyle>
                                                </Appearance>

                                                <LabelsAppearance DataFormatString="{0}" Position="OutsideEnd"></LabelsAppearance>
                                                <TooltipsAppearance DataFormatString=" Replied {0}" Color="White"></TooltipsAppearance>
                                            </telerik:ColumnSeries>
                                            <telerik:ColumnSeries Name="Resolved" DataFieldY="Resolved">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#66CD00"></FillStyle>
                                                </Appearance>

                                                <LabelsAppearance DataFormatString="{0}" Position="OutsideEnd"></LabelsAppearance>
                                                <TooltipsAppearance DataFormatString=" Resolved {0}" Color="White"></TooltipsAppearance>
                                            </telerik:ColumnSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="datagrid" style=" overflow:auto; padding: 15px; height:300px">
                                <asp:GridView ID="grdIssueLevelWise" runat="server" AutoGenerateColumns="false" EmptyDataText="!!! No Password reset for this ticket !!!" EmptyDataRowStyle-CssClass="LblFont"
                                    GridLines="Both" BorderColor="Black" >
                                    <Columns>
                                        <asp:BoundField HeaderText="Sr No" DataField="RowID" />
                                        <asp:TemplateField HeaderText="Issue SubType">
                                            <ItemTemplate>
                                                <asp:Label ID="LblID" runat="server" Text='<%#Bind("Issue_SubType")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Resolved" DataField="Resolved" />
                                        <asp:BoundField HeaderText="Replied" DataField="Replied" />
                                        <asp:BoundField HeaderText="Pending" DataField="Pending" />

                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header">
                    <div class="box-name">
                        <i class="fa fa-home"></i>
                        <span style="font-size: 15px !important;">SLA</span>
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

                <div class="box-content" style="min-height: 300px;">
                    <div class="row">
                        <div class="col-lg-6">
                           <div id="DivPie_SLA_Meet">
                                  <telerik:RadHtmlChart runat="server" ID="Pie_ChartSLA_Meet" Width="500"  Height="300" Transitions="true">
                                    <Appearance>
                                        <FillStyle BackgroundColor="White"></FillStyle>
                                    </Appearance>
                                    <ChartTitle Text="SLA Meet">
                                        <Appearance Align="Center" BackgroundColor="White" Position="Top"></Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance BackgroundColor="White" Position="Right" Visible="true"></Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Appearance>
                                            <FillStyle BackgroundColor="White"></FillStyle>
                                        </Appearance>
                                        <Series>
                                            <telerik:PieSeries DataFieldY="Total_Percentage"   NameField="FieldName" StartAngle="90">
                                                 <Appearance>
                                                     <FillStyle BackgroundColor="#66CD00"></FillStyle>
                                                </Appearance>
                                                <LabelsAppearance   DataFormatString="{0}%"></LabelsAppearance>
                                                <TooltipsAppearance Color="White" DataFormatString="{0}%"></TooltipsAppearance>
                                            </telerik:PieSeries>
                                  
                                          
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
                            </div>
                        </div>

                        <div class="col-lg-6">
                             <div class="datagrid" style=" overflow:auto; padding: 15px; height:300px">
                                <asp:GridView ID="grdPie_ChartSLA_Meet" runat="server" AutoGenerateColumns="false" EmptyDataText="!!! No Password reset for this ticket !!!" EmptyDataRowStyle-CssClass="LblFont"
                                    GridLines="Both" BorderColor="Black" >
                                    <Columns>
                                          <asp:BoundField HeaderText="Filed Name" DataField="FieldName" />
                                        <asp:BoundField HeaderText="Values" DataField="Value" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
