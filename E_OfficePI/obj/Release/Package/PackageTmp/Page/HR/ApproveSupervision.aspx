<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApproveSupervision.aspx.cs" Inherits="E_OfficePI.Page.HR.ApproveSupervision" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script src="../../js/datepicker/bootstrap-datepicker.js"></script>
    <link href="../../js/datepicker/datepicker.css" rel="stylesheet" />
    <title></title>
    <style>
        button {
            font-family: 'TH SarabunPSK';
            font-size: 18px;
        }
        .form-control{
            font-family: 'TH SarabunPSK';
            font-size: 18px;
        }
        a {
            font-family: 'TH SarabunPSK';
            font-size: 20px !important;
        }

        span {
            font-family: 'TH SarabunPSK';
            font-size: 20px !important;
        }

        select {
            font-family: 'TH SarabunPSK';
            font-size: 20px !important;
        }

        body {
            font-family: 'TH SarabunPSK';
            font-size: 20px !important;
            font-weight: bold;
        }

        button {
            font-family: 'TH SarabunPSK';
            font-size: 18px !important;
            cursor: pointer;
        }
    </style>
   <script>

  
       $(document).ajaxStart(function () {
           $('#pleaseWaitDialog').show();
       }).ajaxStop(function () {
           $('#pleaseWaitDialog').hide();
       });
     
       $(function () {
           ApproveSupervision();
           setTimeout(() => {
               Unloading();
           }, 100);
           Search();
       });
       function ApproveSupervision() {
           GetAPOrg();
           $('#DivApproveSupervision').show();
       }
       function ChangeApprove(userid, Approveruserid) {

           var json = '';
           json = 'userid :' + userid + '|';
           json += 'Approveruserid :' + $('#' + Approveruserid).val() + '|';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/ApproveSupervision.aspx/ChangeApprove",
               data: "{'json' :'" + json + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               beforeSend: function () {
                   $(".loader").fadeOut("slow");
               },
               success: function (response) {
                   res = response.d;
                   Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว')
               },
               async: false,
               error: function (er) {
               }
           });
       }


       function ChangeValidate(userid, validatoruserid) {

           var json = '';
           json = 'userid :' + userid + '|';
           json += 'validatoruserid :' + $('#' + validatoruserid).val() + '|';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/ApproveSupervision.aspx/ChangeValidate",
               data: "{'json' :'" + json + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               beforeSend: function () {
                   $(".loader").fadeOut("slow");
               },
               success: function (response) {
                   res = response.d;
                   Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว')
               },
               async: false,
               error: function (er) {
               }
           });
       }
       function Search() {
           var html = '';
           var json = '';
           var Ctrl = '';
           var Ctrlconsolidate = '';
           var json = '';
           var j = 0;
           json += 'CbAPOrg:' + $('#CbAPOrg').val() + '|';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/ApproveSupervision.aspx/GetApproverSupervision",
               data: "{'json' :'" + json + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               beforeSend: function () {
                   $(".loader").fadeOut("slow");
               },
               success: function (response) {
                   res = response.d;
                   res = response.d;
                   if (res == null) {
                       Msgbox('ไม่สามารถแสดงข้อมูลสายงานอนุมัติได้ โปรดติดต่อผู้ดูแลระบบ');
                       return;
                   }
                   html += '<table class="table table-bordered">';
                   html += '<tr>';
                   html += '<td  style="width:10%;text-align:center;">รหัสพนักงาน</td>';
                   html += '<td  style="width:30%;text-align:center;">ชื่อ-นามสกุล</td>';
                   html += '<td  style="width:30%;text-align:center;">ผู้ตรวจสอบ</td>';
                   html += '<td  style="width:30%;text-align:center;">ผู้อนุมัติ</td>';
                   html += '</tr>';
                   if (res.length > 0) {
                       for (i = 0; i < res.length; i++) {
                           html += '<tr>';
                           html += '<td>' + res[i]['Empno'] + '</td>';
                           html += '<td>' + res[i]['Firstname'] + ' ' + res[i]['Lastname'] + '</td>';
                           html += '<td>';

                           html += '<select onchange="ChangeValidate(\'' + res[i]['Userid'] + '\',\'' + 'Cbv_' + res[i]['Userid'] + '\');" class="form-control" id="Cbv_' + res[i]['Userid'] + '">';
                           if (res[i]['Validatoruserid'] == null) {
                               html += '<option value="" selected="selected">--ไม่ระบุ--</option>';
                           }
                           else {
                               html += '<option value="">--ไม่ระบุ--</option>';
                           }
                           for (j = 0; j < res[i]['Validatorusers'].length; j++) {
                               if (res[i]['Validatorusers'][j]['Selected'] != null) {
                                   html += '<option value="' + res[i]['Validatorusers'][j]["Userid"] + '" selected="selected">' + res[i]['Validatorusers'][j]["Firstname"] + " " + res[i]['Validatorusers'][j]["Lastname"]  + '</option>';
                               }
                               else {
                                   html += '<option value="' + + res[i]['Validatorusers'][j]["Userid"] + '">' + res[i]['Validatorusers'][j]["Firstname"] + " " + res[i]['Validatorusers'][j]["Lastname"] +  '</option>';
                               }
                           }
                           html += '</select>';



                           html += '</td >';


                           html += '<td>';

                           html += '<select onchange="ChangeApprove(\'' + res[i]['Userid'] + '\',\'' + 'Cba_' + res[i]['Userid'] + '\');" class="form-control" id="Cba_' + res[i]['Userid'] + '">';
                           if (res[i]['Approveruserid'] == null) {
                               html += '<option value="" selected="selected">--ไม่ระบุ--</option>';
                           }
                           else {
                               html += '<option value="">--ไม่ระบุ--</option>';
                           }
                           for (j = 0; j < res[i]['Approverusers'].length; j++) {
                               if (res[i]['Approverusers'][j]['Selected'] != null) {
                                   html += '<option value="' + res[i]['Approverusers'][j]["Userid"] + '" selected="selected">' + res[i]['Approverusers'][j]["Firstname"] + " " + res[i]['Approverusers'][j]["Lastname"] + '</option>';
                               }
                               else {
                                   html += '<option value="' + + res[i]['Approverusers'][j]["Userid"] + '">' + res[i]['Approverusers'][j]["Firstname"] + " " + res[i]['Approverusers'][j]["Lastname"] + '</option>';
                               }
                           }
                           html += '</select>';



                           html += '</td >';

                           html += '</tr>';
                       }
                   }
                   else {
                       html += '<tr>';
                       html += '<td colspan="4"><div style="color:red;height:100px;text-align:center;">ไม่พบข้อมูล</div></td>';
                       html += '</tr>';
                   }
                   html += '</table>';
                   $('#DivApproveSupervisioncont').html(html);
               },
               async: false,
               error: function (er) {
               }
           });
           
       }

       
       
       function GetAPOrg() {
           var json = '';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/ApproveSupervision.aspx/GetAPOrg",
               data: "{'json' :'" + json + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               beforeSend: function () {
                   $(".loader").fadeOut("slow");
               },
               success: function (response) {
                   res = response.d;
                   $('#CbAPOrg').find('option').remove().end();

                   if (res.length == 0) {
                       $('#CbAPOrg').append($('<option/>', {
                           value: '',
                           text: 'ไม่พบข้อมูล'
                       }));
                   }
                   else {
                       for (i = 0; i < res.length; i++) {
                           $('#CbAPOrg').append($('<option/>', {
                               value: res[i]["Val"],
                               text: res[i]["Name"]
                           }));
                       }
                   }
               },
               async: false,
               error: function (er) {
               }
           });
       }
   </script>
</head>
<body>
    <input type="hidden" id="HdSupervisiontype" value="" />
    <input type="hidden" id="Hdyear" value="" />
    <div class="container-fluid" style="font-family: TH SarabunPSK;color:black; background-color: white; padding: 10px; width: 100%; margin-top: 20px;">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav" style="color: black !important; font-family: TH SarabunPSK;">
                    <li class="nav-item">
                        <a class="nav-link" href="#" >สายงานอนุมัติการไปสอนภาคปฏิบัติ</a>
                    </li>
                </ul>
            </div>
        </nav>
   
    <div id="DivApproveSupervision" style="display: none;margin-top:30px;">
        <div class="container">
            <div class="row mt-3">
                <div class="col-2" style="text-align:right;">
                    <span>องค์กร / วิทยาลัย</span>
                </div>
                <div class="col-6">
                    <select class="form-control" id="CbAPOrg">

                    </select>
                </div>

                 <div class="col-4">
                  <button class="btn btn-info" style="font-family:TH SarabunPSK;font-size:13px;border-radius:1px;" onclick="Search();">ค้นหา</button>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-12">
                    <hr />
                </div>
                
            </div>
           
            <div class="row mt-1">
                  <div id="DivApproveSupervisioncont" class="col-12">
                       
                  </div>
            </div>
        </div>
    </div>
   </div>
</body>
</html>