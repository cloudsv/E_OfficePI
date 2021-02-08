<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintformCaller.aspx.cs" Inherits="E_OfficePI.Printforms.PrintformCaller" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--<link href="../Css/SiamCar.css" rel="stylesheet" />--%>
    <title></title>
</head>
<body style="background-color:#373535">
    <form id="form1" runat="server">
        <center>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server"  ToolPanelView="None" />
        </center>
    </form>
    </body>
</html>