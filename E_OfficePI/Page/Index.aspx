<%@ Page Title="" Language="C#" MasterPageFile="~/Page/EOffice.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="E_OfficePI.Page.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
    body{
            font-family:'TH SarabunPSK';
            font-size:18px !important;
            
        }
</style>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
          <%--       <button type="button" class="btn btn-success" onclick="waitingDialog.show('Custom message');setTimeout(function () {waitingDialog.hide();}, 2000);">Show dialog</button>--%>
                <div id="Divmain">

                </div>
            </div>
        </div>
    </div>
</asp:Content>
