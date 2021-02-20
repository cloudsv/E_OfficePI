<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="E_OfficePI.Page.Dashboard" %>

<!DOCTYPE html>

<html >
<head >

   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="../images/favicon.ico" type="image/ico" />

    <title>PBRI System 1.0 สถาบันพระบรมราชชนก</title>

    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/blue.css" rel="stylesheet">

    <!-- bootstrap-progressbar -->
    <link href="../vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- JQVMap -->
    <link href="../vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet" />
    <!-- bootstrap-daterangepicker -->
    <link href="../vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <!-- TODO put back the minified version after completion and minification -->
    <link href="../build/css/custom.css" rel="stylesheet">
    <link href="../build/css/style-extra-bs4.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script src="../js/engine.js"></script>

    <script src="../js/Grid/Grid.js"></script>
    <link href="../Css/Signin.css" rel="stylesheet" />
    <script src="../vendors/popper/popper.min.js"></script>
    <script src="http://uiwebsoft.com/justlog/assets/js/jquery-2.2.0.min.js"></script>
    <script src="http://uiwebsoft.com/justlog/assets/js/popper.min.js"></script>
    <script src="http://uiwebsoft.com/justlog/assets/js/bootstrap.min.js"></script>

    <script src="http://jojosati.github.io/bootstrap-datepicker-thai/js/bootstrap-datepicker.js"></script>
    <script src="http://jojosati.github.io/bootstrap-datepicker-thai/js/bootstrap-datepicker-thai.js"></script>
    <script src="http://jojosati.github.io/bootstrap-datepicker-thai/js/locales/bootstrap-datepicker.th.js"></script>
    <script>
        $(function () {
            Getheader();
        });
        function Getheader() {
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/Getheader",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                },
                success: function (response) {
                    $('#Divheader').val(response.d);
                },
                async: true,
                error: function (er) {

                }
            });
        }
    </script>
</head>
<body>

  <div class="container">
      <div class="row">
          <div class="col-12">
              <div id="Divheader"></div>
          </div>
      </div>
  </div>
</body>
</html>
