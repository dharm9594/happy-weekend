<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ServiceTracker.view.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Login</title>
    <link href="../plugins/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Righteous' rel='stylesheet' type='text/css' />
    <link href="../css/style.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
				<script src="http://getbootstrap.com/docs-assets/js/html5shiv.js"></script>
				<script src="http://getbootstrap.com/docs-assets/js/respond.min.js"></script>
		<![endif]-->

    <link rel="stylesheet" href="../lib/validationEngine/css/validationEngine.jquery.css" />
    <link rel="stylesheet" href="../ProgressBar/jquery-ui.css" />
    <!--Progress Bar-->

    <%--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>--%>
    <script src="../ProgressBar/jquery.min.js"></script>
    <script src="../ProgressBar/nprogress.js"></script>
    <link href="../ProgressBar/nprogress.css" rel='stylesheet' />

    <!--FancyBox Video-->
    <!-- Add jQuery library -->
    <script type="text/javascript" src="../video/lib/jquery-1.10.1.min.js"></script>

    <!-- Add fancyBox main JS and CSS files -->
    <script type="text/javascript" src="../video/source/jquery.fancybox.js?v=2.1.5"></script>
    <link rel="stylesheet" type="text/css" href="../video/source/jquery.fancybox.css?v=2.1.5" media="screen" />
    <!--FancyBox Video-->

    <script type="text/javascript">
        $(document).ready(function () {
            $('body').show();
            NProgress.start();
            setTimeout(function () { NProgress.done(); $('.fade').removeClass('out'); }, 1000);

            //Open Iframe Video
            //$(".fancybox").fancybox();
            // openEffect/closeEffect : elastic,fade,none
            //URL: http://fancyapps.com/fancybox/#docs

            $(".fancybox").fancybox({
                maxWidth: 810,
                maxHeight: 520,
                fitToView: false,
                width: '100%',
                height: '100%',
                autoSize: false,
                closeClick: false,
                openEffect: 'elastic',
                closeEffect: 'elastic'
            });
            //Open Iframe Video
        });
    </script>
    <!--Progress Bar-->
</head>
<body class="login" style="overflow-x: hidden;">
    <div class="container-fluid">
        <div id="page-login" class="row" style=" background: linear-gradient(315deg, #00188f, #13b5ea, #00b294);">
            <form id="form1" runat="server">
                <div class="col-xs-12 col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">
                    <div class="text-center" style="padding-top: 10px;">
                        <img src="../images/SitelLogo.png" height="100px" alt="SiTel Logo" />
                    </div>
                    <br />
                    <div style="text-align: center;">
                        <h3 style="color: white; font-family: Arial; text-align: center">Speech Analytics</h3>
                    </div>
                    <div class="box" style ="margin-top:5%;">
                        <div class="text-center">
                            <asp:Label ID="LblVersionMsg" ForeColor="Red" Text="" runat="server" />
                        </div>
                        <div class="box-content">
                            <div class="text-center">
                                <h3 class="page-header">Login</h3>
                            </div>
                            <div class="text-center">
                                <div id="DivAlert" runat="server" class="alert alert-danger" style="font-weight: bold; display: none;"></div>
                            </div>
                            <div class="form-group">
                                <label class="control-label">Domain</label>
                                <asp:DropDownList ID="DDL_Domain" runat="server" CssClass="validate[required] form-control">
                                    <asp:ListItem Text="--Select Domain--" Value=""></asp:ListItem>
                                    <asp:ListItem Text="APAC" Value="APAC"></asp:ListItem>
                                    <asp:ListItem Text="APC" Value="APC"></asp:ListItem>
                                    <asp:ListItem Text="EMEA" Value="EMEA"></asp:ListItem>
                                    <asp:ListItem Text="LA" Value="LA"></asp:ListItem>
                                    <asp:ListItem Text="LAT" Value="LAT"></asp:ListItem>
                                    <asp:ListItem Text="NA" Value="NA"></asp:ListItem>
                                    <asp:ListItem Text="NAC" Value="NAC"></asp:ListItem>
                                    <asp:ListItem Text="UAC" Value="UAC"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label class="control-label">Username</label>
                                <input id="TxtUserName" runat="server"  type="text" placeholder="Username" class="validate[required] form-control" value="" />
                            </div>
                            <div class="form-group">
                                <label class="control-label">Password</label>
                                <input id="TxtPassword" runat="server" value="" type="password" placeholder="Password" class="validate[required] form-control" />
                                <%--<input id="TxtPassword" runat="server" value="" type="password" placeholder="Password" />--%>
                            </div>
                            <div class="text-center">
                                <asp:Button ID="BtnLogin" runat="server" Text="Login" OnClick="BtnLogin_Click" CssClass="btn btn-primary" />
                            </div>
                        </div>
                    </div>
                </div>

             <%--   <div class="row">
                    <div class="col-lg-12" style="text-align: center;">
                        <a class="fancybox fancybox.iframe" href="Video.html">
                            <img src="../video/VideoIcon.png" alt="" /></a>&nbsp;
                        <a class="fancybox fancybox.iframe" href="Video.html" style="color: white;">View Login Demo</a>
                    </div>
                </div>--%>
            </form>
        </div>
    </div>

    <script src="../lib/validationEngine/js/jquery.validationEngine.js"></script>
    <script src="../lib/validationEngine/js/languages/jquery.validationEngine-en.js"></script>
    <script src="../lib/jquery-validation/dist/jquery.validate.min.js"></script>
    <script src="../js/respond.min.js"></script>
    <script>
        $("#BtnLogin").click(function () {
            if ($("#form1").validationEngine('validate') == false)
                return false;
        });
    </script>
    <script>
        try {

            if ($.trim(navigator.appVersion.split(";")[1]) == "MSIE 8.0" || $.trim(navigator.appVersion.split(";")[1]) == "MSIE 7.0" || $.trim(navigator.appVersion.split(";")[1]) == "MSIE 6.0" || $.trim(navigator.appVersion.split(";")[1]) == "MSIE 5.0") {
                $('[id$="LblVersionMsg"]').text('You do not have the updated version of Internet Explorer. Please upgrade your browser to 9.0 and above  for best view.');
            }
        } catch (e) {

        }
    </script>
</body>
</html>
