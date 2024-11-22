<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GGlimpse.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <div>
    <div class="FormGrid">
        <label>Email-ID: </label>
        <asp:TextBox runat="server" TextMode="Email" ID="UserMailID" placeholder="example@gmail.com" />
        <label>Password: </label>
        <asp:TextBox runat="server" TextMode="Password" ID="UserPwd" placeholder="Password" />
        <div class="ControlsBox">
            <asp:Button Text="Login" runat="server" ID="UserLogin" OnClick="UserLogin_Click" />
        </div>
    </div>
    <div class="CenterText">
        Don't have an account?
        <asp:LinkButton Text="Sign Up instead" runat="server" PostBackUrl="~/SignUp.aspx" />
    </div>
</div>
    </form>
</body>
</html>
