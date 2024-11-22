<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="GGlimpse.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="FormGrid">
                <label>Username: </label>
                <asp:TextBox runat="server" TextMode="SingleLine" ID="UserName" placeholder="Username" />
                <label>Email-ID: </label>
                <asp:TextBox runat="server" TextMode="Email" ID="UserMailID" placeholder="example@gmail.com" />
                <label>Password: </label>
                <asp:TextBox runat="server" TextMode="Password" ID="UserPwd" placeholder="Password" />
                <div class="ControlsBox">
                    <asp:Button Text="Register" runat="server" ID="UserRegister" OnClick="UserRegister_Click" />
                </div>
            </div>
            <div class="CenterText">
                Already have an account?
        <asp:LinkButton Text="Login instead" runat="server" PostBackUrl="~/Login.aspx" />
            </div>
        </div>
    </form>
</body>
</html>
