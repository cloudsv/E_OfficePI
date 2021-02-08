<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Timesheet.aspx.cs" Inherits="E_OfficePI.Page.HR.Timesheet" %>


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
       function CallBackUpload(Label, Running) {
           $.ajax({
               type: "POST",
               url: "\../Page/HR/Timesheet.aspx/CallBackUpload",
               data: "{'Label' : '" + Label + "','Running' :'" + Running + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (response) {
                   SearchTS();
               },
               async: false,
               error: function (er) {
                   try {
                       var x = $.parseJSON(er.responseText);
                       show_msg(x.Message);
                   }
                   catch (ex) {
                       console.log(ex.responseText);
                   }
               }
           });
       }
       function Doupload() {
           var key = '';
           w = 600;
           h = 400;
           var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
           var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
           var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
           var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;
           var left = ((width / 2) - (w / 2)) + dualScreenLeft;
           var top = ((height / 2) - (h / 2)) + dualScreenTop;
           window.open('/../Attachment/Upload.aspx?key=' + key, '_blank', 'directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
       }
       function Export() {
           var json = '';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/Timesheet.aspx/Export",
               data: "{'json':'" + json + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (response) {
                   var url;
                   url = response.d;
                   $(location).attr("href", url);
               },
               async: false,
               error: function (er) {
                   try {
                       var x = $.parseJSON(er.responseText);
                       show_msg(x.Message);
                   }
                   catch (ex) {
                       alert(ex.responseText);
                   }
               }
           });
       }
       function Consolidateleave(x) {
           var json = '';
           json = 'userid :' + x + '|';
           json += 'Timesheet :' + $('#TxtTimesheet_' + x).val() + '|';
           json += 'Hdleavetype :' + $('#Hdleavetype').val() + '|';
           json += 'Hdyear :' + $('#Hdyear').val() + '|';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/Timesheet.aspx/Consolidateleave",
               data: "{'json' :'" + json + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               beforeSend: function () {
                   $(".loader").fadeOut("slow");
               },
               success: function (response) {
                   if (response.d != '') {
                       Msgbox(response.d);
                       return;
                   }
                   Msgboxsuccess('ยกยอดวันลาเรียบร้อยแล้ว');
                   SearchTS();
               },
               async: false,
               error: function (er) {
               }
           });
       }
       function Saveleave(x) {

           if ($('#TxtTimesheet_' + x).val() == '') {
               Msgbox('วันลาที่กำหนดห้ามเป็นค่าว่าง');
               return;
           }
           if ($('#TxtTimesheet_' + x).val() <= 0) {
               Msgbox('วันลาที่กำหนดห้ามน้อยกว่าหรือเท่ากับ 0');
               return;
           }
           var json = '';
           json = 'userid :' + x + '|';
           json += 'Timesheet :' + $('#TxtTimesheet_' + x).val() + '|';
           json += 'Hdleavetype :' + $('#Hdleavetype').val() + '|';
           json += 'Hdyear :' + $('#Hdyear').val() + '|';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/Timesheet.aspx/Saveleave",
               data: "{'json' :'" + json + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               beforeSend: function () {
                   $(".loader").fadeOut("slow");
               },
               success: function (response) {
                   if (response.d != '') {
                       Msgbox(response.d);
                       return;
                   }
                   Msgboxsuccess('บันทึกวันลาเรียบร้อยแล้ว');
                   SearchTS();
               },
               async: false,
               error: function (er) {
               }
           });
       }
       $(document).ajaxStart(function () {
           $('#pleaseWaitDialog').show();
       }).ajaxStop(function () {
           $('#pleaseWaitDialog').hide();
       });
       function Calc(x) {

           var prevtotalleave = 0;
           var Timesheet = 0;
           var totalleave = 0;
           var currentleave = 0;  
           var remainleave = 0;
           prevtotalleave = $('#Txtprevtotalleave_' + x).val();
           Timesheet = $('#TxtTimesheet_' + x).val();
           totalleave = $('#Txttotalleave_' + x).val();
           currentleave = $('#Txtcurrentleave_' + x).val();
           remainleave = $('#Txtremainleave_' + x).val();


           if (prevtotalleave == '') {
               prevtotalleave = '0';
           }

           if (Timesheet == '') {
               Timesheet = '0';
           }

           if (totalleave == '') {
               totalleave = '0';
           }

           if (currentleave == '') {
               currentleave = '0';
           }
           if (remainleave == '') {
               remainleave = '0';
           }

           if (Timesheet == '') {
               Timesheet = '0';
           }
           else if (Number(Timesheet) < 0) {
               Timesheet = '0';
           }

           totalleave = Number(prevtotalleave) + Number(Timesheet)
           remainleave = Number(totalleave) - Number(currentleave);
         

           $('#Txtprevtotalleave_' + x).val(prevtotalleave);
           $('#TxtTimesheet_' + x).val(Timesheet);
           $('#Txtcurrentleave_' + x).val(currentleave);
           $('#Txttotalleave_' + x).val(totalleave);
           $('#Txtremainleave_' + x).val(remainleave);
       }
       $(function () {
           Timesheet();
           GetToday();
           setTimeout(() => {
               Unloading();
           }, 100);
          
           SearchTS();
       });
       function Timesheet() {
           $("#TxtTSdate").datepicker({
               format: "dd/mm/yyyy",
               todayBtn: "linked",
               language: "th",
               forceParse: false,
               autoclose: true,
               todayHighlight: true
           });
           GetTSOrg();
           $('#DivTimesheet').show();
       }
   
       function SearchTS() {
           var html = '';
           var json = '';
           var Ctrl = '';
           var Ctrlconsolidate = '';
           var json = '';
           json += 'CbTSOrg:' + $('#CbTSOrg').val() + '|';
           json += 'TxtTSdate:' + $('#TxtTSdate').val() + '|';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/Timesheet.aspx/GetTimesheet",
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
                       Msgbox('ไม่สามารถแสดงข้อมูลการเข้า-ออกที่ทำงานได้ โปรดติดต่อผู้ดูแลระบบ');
                       return;
                   }
                   html += '<table class="table table-bordered">';
                   html += '<tr>';
                   html += '<td  style="width:10%;text-align:center;">รหัสพนักงาน</td>';
                   html += '<td  style="text-align:center;">ชื่อ-นามสกุล</td>';
                   html += '<td  style="width:10%;text-align:center;">เวลาเข้า</td>';
                   html += '<td  style="width:10%;text-align:center;">เวลาออก</td>';
                   html += '</tr>';
                   if (res.length > 0) {
                       for (i = 0; i < res.length; i++) {
                           html += '<tr>';
                           html += '<td>' + res[i]['Empno'] + '</td>';
                           html += '<td>' + res[i]['Firstname'] + ' ' + res[i]['Lastname'] + '</td>';
                           html += '<td><input type="text" style="text-align:right;" readonly="readonly" Class="form-control" id="TxtTSin_' + res[i]['Userid'] + '" value="' + res[i]['Intime'] + '" /></td>';
                           html += '<td><input type="text" style="text-align:right;" readonly="readonly" Class="form-control" id="TxtTSout_' + res[i]['Userid'] + '" value="' + res[i]['Outtime'] + '" /></td>';
                           html += '</tr>';
                       }
                   }
                   else {
                       html += '<tr>';
                       html += '<td colspan="4"><div style="color:red;height:100px;text-align:center;">ไม่พบข้อมูล</div></td>';
                       html += '</tr>';
                   }
                   html += '</table>';
                   $('#DivTimesheetcont').html(html);
               },
               async: false,
               error: function (er) {
               }
           });
           
       }

       
       function GetToday() {
           var json = '';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/Timesheet.aspx/GetToday",
               data: "{'json' :'" + json + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               beforeSend: function () {
                   $(".loader").fadeOut("slow");
               },
               success: function (response) {
                   res = response.d;
                   $('#TxtTSdate').val(res);
               },
               async: false,
               error: function (er) {
               }
           });
       }
       function GetTSOrg() {
           var json = '';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/Timesheet.aspx/GetTSOrg",
               data: "{'json' :'" + json + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               beforeSend: function () {
                   $(".loader").fadeOut("slow");
               },
               success: function (response) {
                   res = response.d;
                   $('#CbTSOrg').find('option').remove().end();

                   if (res.length == 0) {
                       $('#CbTSOrg').append($('<option/>', {
                           value: '',
                           text: 'ไม่พบข้อมูล'
                       }));
                   }
                   else {
                       for (i = 0; i < res.length; i++) {
                           $('#CbTSOrg').append($('<option/>', {
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
    <input type="hidden" id="Hdleavetype" value="" />
    <input type="hidden" id="Hdyear" value="" />
    <div class="container-fluid" style="font-family: TH SarabunPSK;color:black; background-color: white; padding: 10px; width: 100%; margin-top: 20px;">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav" style="color: black !important; font-family: TH SarabunPSK;">
                    <li class="nav-item">
                        <a class="nav-link" href="#" >การเข้า-ออกที่ทำงาน</a>
                    </li>
                </ul>
            </div>
        </nav>
   
    <div id="DivTimesheet" style="display: none;margin-top:30px;">
        <div class="container">
            <div class="row mt-3">
                <div class="col-2" style="text-align:right;">
                    <span>องค์กร / วิทยาลัย</span>
                </div>
                <div class="col-4">
                    <select class="form-control" id="CbTSOrg">

                    </select>
                </div>
                 <div class="col-2"  style="text-align:right;">
                    <span>วันที่บันทึก</span>
                </div>
                <div class="col-2">
                     <div id="DtpTSdate" class="input-group date" data-date-format="mm-dd-yyyy">
                        <input id="TxtTSdate" class="form-control" type="text" />
                        <button>
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </button>
                    </div>
                </div>
                 <div class="col-2">
                  <button class="btn btn-info" style="font-family:TH SarabunPSK;font-size:13px;border-radius:1px;" onclick="SearchTS();">ค้นหา</button>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-12">
                    <hr />
                </div>
                
            </div>
            <div class="row mt-1">
                  <div class="col-12">
                     <div class="input-group mb-3">
                        <button class="btn btn-secondary" style="font-family:TH SarabunPSK;font-size:13px;border-radius:1px;" onclick="Export();">Download Templated</button>
                         &nbsp;
                        <button class="btn btn-secondary" style="font-family:TH SarabunPSK;font-size:13px;border-radius:1px;" onclick="Doupload();">นำเข้ารายการ</button>
                      </div>
                  </div>
            </div>
            <div class="row mt-1">
                  <div id="DivTimesheetcont" class="col-12">
                       
                  </div>
            </div>
        </div>
    </div>
   </div>
</body>
</html>
