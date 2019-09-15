<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testing.aspx.cs" Inherits="ServiceDesk.view.testing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
       <script src="../plugins/jquery.min.js"></script>
 

    <script>
        function myFunction() {
            debugger;
            var copyText = document.getElementById("txtJson");
            copyText.select();
            document.execCommand("copy");
        }
        </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>

        <input type="text" value="Hello World" id="myInput">
<button onclick="myFunction()">Copy text</button>
      <asp:TextBox ID="txtJson" runat="server" CssClass="form-control" TextMode="MultiLine" Height="200" Width="100%"></asp:TextBox>
                                            <asp:Button ID="JsonToCSV" OnClientClick="if(confirm('Are you sure?')) myFunction(event);" OnClick="test" runat="server" Text="Json to CSV" ValidationGroup="Save" CssClass="btn btn-primary" />

    </div>
    </form>
</body>
</html>
