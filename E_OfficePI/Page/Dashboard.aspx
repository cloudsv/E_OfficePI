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

   
    <link href="../Css/Signin.css" rel="stylesheet" />
    <script src="../vendors/popper/popper.min.js"></script>

    <script>
        function Closemodaldetail() {
            $('#Divmodaldetail').modal('hide');
        }
        function Openmodal(x) {
            var html = '';
            if (x == 'D') {
                $.ajax({
                    type: "POST",
                    url: "Dashboard.aspx/Getdetail",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                    },
                    success: function (response) {
                        
                        html = '';
                        html += '<table class="table-bordered" style="width:95%;">';
                        html += '<thead class="thead-light">';
                        html += '<tr>';
                        html += '<th scope="col">รายชื่อวิชา</th>';
                        html += '<th scope="col">สถานะ</th>';
                        html += '</tr>';
                        html += '</thead>';
                        html += '<tbody>';
                        if (response.d['DraftSubject']['Subjectstatus'].length > 0) {
                            for (i = 0; i < response.d['DraftSubject']['Subjectstatus'].length; i++) {
                                html += '<tr>';
                                html += '<td style="text-align:left;">' + response.d['DraftSubject']['Subjectstatus'][i]['Subjectcode'] + ' ' + response.d['DraftSubject']['Subjectstatus'][i]['Subjectname'] + '</td>';
                                html += '<td style="text-align:right;">' + response.d['DraftSubject']['Subjectstatus'][i]['Status'] + '</td>';
                                html += '</tr>';
                            }
                        }
                        else {
                            html += '<tr><td colspan="2"><div style="color:red;text-align:center;marging-top:50;height:100px;">ไม่พบรายวิชา<div></td></tr>';
                        }
                        html += '</tbody>';
                        html += '</table>';
                        $('#Divmodaldetailcont').html(html);
                        $('#Divmodaldetail').modal('show');
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            
            else if (x == 'P') {
                $.ajax({
                    type: "POST",
                    url: "Dashboard.aspx/Getdetail",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                    },
                    success: function (response) {

                        html = '';
                        html += '<table class="table-bordered" style="width:95%;">';
                        html += '<thead class="thead-light">';
                        html += '<tr>';
                        html += '<th scope="col">รายชื่อวิชา</th>';
                        html += '<th scope="col">สถานะ</th>';
                        html += '</tr>';
                        html += '</thead>';
                        html += '<tbody>';
                        if (response.d['PendingSubject']['Subjectstatus'].length > 0) {
                            for (i = 0; i < response.d['PendingSubject']['Subjectstatus'].length; i++) {
                                html += '<tr>';
                                html += '<td style="text-align:left;">' + response.d['PendingSubject']['Subjectstatus'][i]['Subjectcode'] + ' ' + response.d['PendingSubject']['Subjectstatus'][i]['Subjectname'] + '</td>';
                                html += '<td style="text-align:right;">' + response.d['PendingSubject']['Subjectstatus'][i]['Status'] + '</td>';
                                html += '</tr>';
                            }
                        }
                        else {
                            html += '<tr><td colspan="2"><div style="color:red;text-align:center;marging-top:50;height:100px;">ไม่พบรายวิชา<div></td></tr>';
                        }
                        html += '</tbody>';
                        html += '</table>';
                        $('#Divmodaldetailcont').html(html);
                        $('#Divmodaldetail').modal('show');
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }


            else if (x == 'C') {
                $.ajax({
                    type: "POST",
                    url: "Dashboard.aspx/Getdetail",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                    },
                    success: function (response) {

                        html = '';
                        html += '<table class="table-bordered" style="width:95%;">';
                        html += '<thead class="thead-light">';
                        html += '<tr>';
                        html += '<th scope="col">รายชื่อวิชา</th>';
                        html += '<th scope="col">สถานะ</th>';
                        html += '</tr>';
                        html += '</thead>';
                        html += '<tbody>';
                        if (response.d['CompletedSubject']['Subjectstatus'].length > 0) {
                            for (i = 0; i < response.d['CompletedSubject']['Subjectstatus'].length; i++) {
                                html += '<tr>';
                                html += '<td style="text-align:left;">' + response.d['CompletedSubject']['Subjectstatus'][i]['Subjectcode'] + ' ' + response.d['CompletedSubject']['Subjectstatus'][i]['Subjectname'] + '</td>';
                                html += '<td style="text-align:right;">' + response.d['CompletedSubject']['Subjectstatus'][i]['Status'] + '</td>';
                                html += '</tr>';
                            }
                        }
                        else {
                            html += '<tr><td colspan="2"><div style="color:red;text-align:center;marging-top:50;height:100px;">ไม่พบรายวิชา<div></td></tr>';
                        }
                        html += '</tbody>';
                        html += '</table>';
                        $('#Divmodaldetailcont').html(html);
                        $('#Divmodaldetail').modal('show');
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }


            else if (x == 'E') {
                $.ajax({
                    type: "POST",
                    url: "Dashboard.aspx/Getdetail",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                    },
                    success: function (response) {

                        html = '';
                        html += '<table class="table-bordered" style="width:95%;">';
                        html += '<thead class="thead-light">';
                        html += '<tr>';
                        html += '<th scope="col">รายชื่อวิชา</th>';
                        html += '<th scope="col">สถานะ</th>';
                        html += '</tr>';
                        html += '</thead>';
                        html += '<tbody>';
                        if (response.d['EditSubject']['Subjectstatus'].length > 0) {
                            for (i = 0; i < response.d['EditSubject']['Subjectstatus'].length; i++) {
                                html += '<tr>';
                                html += '<td style="text-align:left;">' + response.d['EditSubject']['Subjectstatus'][i]['Subjectcode'] + ' ' + response.d['EditSubject']['Subjectstatus'][i]['Subjectname'] + '</td>';
                                html += '<td style="text-align:right;">' + response.d['EditSubject']['Subjectstatus'][i]['Status'] + '</td>';
                                html += '</tr>';
                            }
                        }
                        else {
                            html += '<tr><td colspan="2"><div style="color:red;text-align:center;marging-top:50;height:100px;">ไม่พบรายวิชา<div></td></tr>';
                        }
                        html += '</tbody>';
                        html += '</table>';
                        $('#Divmodaldetailcont').html(html);
                        $('#Divmodaldetail').modal('show');
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
        }
        $(function () {
            Getdashboard();
        });
     
        function Getdashboard() {
            var html = '';
            var i = 0;
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/Getdashboard",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                },
                success: function (response) {
                    $('#Divheader').html('หลักสูตรที่อาจารย์ ' + response.d['Fullname'] + ' ประจำอยู่ จำนวน ' + response.d['Subjects'].length + ' วิชา ');
                    $('#Divheaderdetail').html('ภาระงานสอนของอาจารย์  ' + response.d['Fullname'] + ' ประจำปี 2564 ');
                    $('#Divdraft').html('จำนวนวิชาที่ดำเนินการ <br/> <h3>' + response.d['DraftSubject']['Total'] + '</h3>   วิชา ');
                    $('#Divpending').html('จำนวนวิชาที่รอตรวจ <br/> <h3>' + response.d['PendingSubject']['Total'] + '</h3>  วิชา ');
                    $('#Divcompleted').html('จำนวนวิชาที่ตรวจแล้ว <br/> <h3>' + response.d['CompletedSubject']['Total'] + '</h3>   วิชา ');
                    $('#Divedit').html('จำนวนวิชาที่แก้ไข <br/> <h3>' + response.d['EditSubject']['Total'] + '</h3>   วิชา ');

                    html = '';

                    html += '<table class="table-bordered" style="width:95%;">';
                    html += '<thead class="thead-light">';
                    html += '<tr>';
                    html += '<th scope="col">รายชื่อวิชา</th>';
                    html += '<th scope="col">ภาระงานสอน (ชั่วโมง)</th>';
                    html += '</tr>';
                    html += '</thead>';
                    html += '<tbody>';
                    if (response.d['Subjects'].length > 0) {
                        for (i = 0; i < response.d['Subjects'].length; i++) {
                            html += '<tr>';
                            html += '<td style="text-align:left;">' + response.d['Subjects'][i]['Subjectcode'] + ' ' + response.d['Subjects'][i]['Subjectname'] + '</td>';
                            html += '<td style="text-align:right;">' + response.d['Subjects'][i]['ResponsibilityHour'] + '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="2"><div style="color:red;text-align:center;marging-top:50;height:100px;">ไม่พบรายวิชา<div></td></tr>';
                    }
                    html += '<tr>';
                    html += '<td style="text-align:right;">รวมจำนวนรายชั่วโมง</td>';
                    html += '<td style="text-align:right;">' + response.d['Totalhours'] + '</td>';
                    html += '</tr>';
                    html += '</tbody>';
                    html += '</table>';
                    $('#Divdetail').html(html);
                
               
                },
                async: true,
                error: function (er) {

                }
            });
        }
    </script>
    <style>
        @media (min-width: 768px) {
            .modal-xl {
                width: 90%;
                max-width: 1200px;
            }
        }
        td,th
        {
            LINE-HEIGHT:50px;
            padding:10px;
        }
        body
        {
            font-family:'kanit light' !important;
        }
    </style>
</head>
<body>
  <div class="container">
      <div class="row">
          <div class="col-12">
              <div id="Divheader" class="card card-body bg-info" style="text-align:center;padding:20px;font-size:16px;height:80px;margin:20px;color:white;"></div>
          </div>
      </div>
        <div class="row">
            <div class="col-12">
                <hr style="width:90%" />
            </div>
            </div>
       <div class="row">
          <div class="col-lg-3 col-md-12 col-sm-12 col-xl-3 col-xs-12">
              <div id="Divdraft" onclick="Openmodal('D');" class="card card-body bg-primary" style="cursor:pointer; border-radius:4px; text-align:center;padding:10px;font-size:16px;height:140px;margin:10px;color:white;"></div>
          </div>
          <div class="col-lg-3 col-md-12 col-sm-12 col-xl-3 col-xs-12">
              <div id="Divpending"  onclick="Openmodal('P');" class="card card-body bg-danger" style="cursor:pointer;border-radius:4px;text-align:center;padding:10px;font-size:16px;height:140px;margin:10px;color:white;"></div>
          </div>
             <div class="col-lg-3 col-md-12 col-sm-12 col-xl-3 col-xs-12">
              <div id="Divcompleted"  onclick="Openmodal('C');" class="card card-body bg-success" style="cursor:pointer;border-radius:4px;text-align:center;padding:10px;font-size:16px;height:140px;margin:10px;color:white;"></div>
          </div>
             <div class="col-lg-3 col-md-12 col-sm-12 col-xl-3 col-xs-12">
              <div id="Divedit"  onclick="Openmodal('E');" class="card card-body " style="cursor:pointer;border-radius:4px;background-color:orangered; text-align:center;padding:18px;font-size:16px;height:140px;margin:10px;color:white;"></div>
          </div>
      </div>
      <div class="row">
        <div class="col-12">
              <div id="Divheaderdetail" style="text-align:center;font-size:14px;margin-top:100px;"></div>
          </div>
       </div>
      <div class="row">
          <div class="col-12" id="Divdetail" style="font-size:14px;margin-top:20px;text-align:center;">
        
          </div>
      </div>
     

  </div>
    <div class="modal" id="Divmodaldetail" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content" style="font-size:16px;">
                <div class="modal-header">
                    <span>รายละเอียดของสถานะรายวิชา</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container" style="margin-right: 10px; min-height: 220px; padding: 8px;">
                        <div class="row">
                            <div class="col-12" id="Divmodaldetailcont" style="font-size:14px !important;">
                            </div>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 14px !important; border-radius: 0;" data-dismiss="modal" onclick="Closemodaldetail();">ปิดหน้าต่างนี้</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</body>
</html>
