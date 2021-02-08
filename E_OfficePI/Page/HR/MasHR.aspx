<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MasHR.aspx.cs" Inherits="E_OfficePI.Page.HR.MasHR" %>

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
       function Consolidateleave(x) {
           var json = '';
           json = 'userid :' + x + '|';
           json += 'settingleave :' + $('#Txtsettingleave_' + x).val() + '|';
           json += 'Hdleavetype :' + $('#Hdleavetype').val() + '|';
           json += 'Hdyear :' + $('#Hdyear').val() + '|';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/MasHR.aspx/Consolidateleave",
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
                   Searchsettingleave();
               },
               async: false,
               error: function (er) {
               }
           });
       }
       function Saveleave(x) {

           if ($('#Txtsettingleave_' + x).val() == '') {
               Msgbox('วันลาที่กำหนดห้ามเป็นค่าว่าง');
               return;
           }
           if ($('#Txtsettingleave_' + x).val() <= 0) {
               Msgbox('วันลาที่กำหนดห้ามน้อยกว่าหรือเท่ากับ 0');
               return;
           }
           var json = '';
           json = 'userid :' + x + '|';
           json += 'settingleave :' + $('#Txtsettingleave_' + x).val() + '|';
           json += 'Hdleavetype :' + $('#Hdleavetype').val() + '|';
           json += 'Hdyear :' + $('#Hdyear').val() + '|';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/MasHR.aspx/Saveleave",
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
                   Searchsettingleave();
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
           var settingleave = 0;
           var totalleave = 0;
           var currentleave = 0;  
           var remainleave = 0;
           prevtotalleave = $('#Txtprevtotalleave_' + x).val();
           settingleave = $('#Txtsettingleave_' + x).val();
           totalleave = $('#Txttotalleave_' + x).val();
           currentleave = $('#Txtcurrentleave_' + x).val();
           remainleave = $('#Txtremainleave_' + x).val();


           if (prevtotalleave == '') {
               prevtotalleave = '0';
           }

           if (settingleave == '') {
               settingleave = '0';
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

           if (settingleave == '') {
               settingleave = '0';
           }
           else if (Number(settingleave) < 0) {
               settingleave = '0';
           }

           totalleave = Number(prevtotalleave) + Number(settingleave)
           remainleave = Number(totalleave) - Number(currentleave);
         

           $('#Txtprevtotalleave_' + x).val(prevtotalleave);
           $('#Txtsettingleave_' + x).val(settingleave);
           $('#Txtcurrentleave_' + x).val(currentleave);
           $('#Txttotalleave_' + x).val(totalleave);
           $('#Txtremainleave_' + x).val(remainleave);
       }
       $(function () {
           Settingleave();
           Getsettingleavetype();
           Getsettingleavetypeyear();
           setTimeout(() => {
               Unloading();
           }, 100);
          
           Searchsettingleave();
       });
       function Settingleave() {
           $('#Divsettingleave').show();
       }
       function Getsettingleavetypeyear() {
           var json = '';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/MasHR.aspx/Getyear",
               data: "{'json' :'" + json + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               beforeSend: function () {
                   $(".loader").fadeOut("slow");
               },
               success: function (response) {
                   res = response.d;
                   $('#Cbsettingleaveyear').find('option').remove().end();

                   if (res.length == 0) {
                       $('#Cbsettingleaveyear').append($('<option/>', {
                           value: '',
                           text: 'ไม่พบหลักสูตร'
                       }));
                   }
                   else {
                       for (i = 0; i < res.length; i++) {
                           $('#Cbsettingleaveyear').append($('<option/>', {
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
       function Searchsettingleave() {
           var html = '';
           var json = '';
           var Ctrl = '';
           var Ctrlconsolidate = '';
           var json = '';
           json += 'Cbsettingleaveyear:' + $('#Cbsettingleaveyear').val() + '|';
           json += 'Cbsettingleavetype:' + $('#Cbsettingleavetype').val() + '|';
           $('#Hdleavetype').val($('#Cbsettingleavetype').val());
           $('#Hdyear').val($('#Cbsettingleaveyear').val());
           $.ajax({
               type: "POST",
               url: "\../Page/HR/MasHR.aspx/Getsettingleave",
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
                       Msgbox('ไม่สามารถแสดงข้อมูลการกำหนดวันลาได้ โปรดติดต่อผู้ดูแลระบบ');
                       return;
                   }
                   html += '<table class="table table-bordered">';
                   html += '<tr>';
                   html += '<td  style="width:10%;text-align:center;">รหัสพนักงาน</td>';
                   html += '<td  style="text-align:center;">ชื่อ-นามสกุล</td>';
                   html += '<td  style="width:10%;text-align:center;">วันลายกมา</td>';
                   html += '<td  style="width:10%;text-align:center;">วันลาที่กำหนด</td>';
                   html += '<td  style="width:10%;text-align:center;">วันลาทั้งหมด</td>';
                   html += '<td  style="width:10%;text-align:center;">ลาไปแล้ว</td>';
                   html += '<td  style="width:10%;text-align:center;">คงเหลือ</td>';
                   html += '<td  style="width:10%;text-align:center;">&nbsp;</td>';
                   html += '<td  style="width:10%;text-align:center;">&nbsp;</td>';
                   html += '</tr>';
                   if (res.length > 0) {
                       for (i = 0; i < res.length; i++) {
                           html += '<tr>';
                           html += '<td>' + res[i]['Empno'] + '</td>';
                           html += '<td>' + res[i]['Firstname'] + ' ' + res[i]['Lastname'] + '</td>';
                           html += '<td><input type="text" style="text-align:right;" readonly="readonly" Class="form-control" id="Txtprevtotalleave_' + res[i]['Userid'] + '" value="' + res[i]['Prevtotalleave'] + '" /></td>';
                           if (res[i]['Isdone'] != "True") {
                               html += '<td><input type="text" style="text-align:right;" onkeypress="OnlyNumeric(event,this)"  class="form-control" onkeyup="Calc(' + res[i]['Userid'] + ');" id="Txtsettingleave_' + res[i]['Userid'] + '" value="' + res[i]['Settingleave'] + '" /></td>';
                           }
                           else {
                               html += '<td><input type="text" style="text-align:right;" readonly="readonly" Class="form-control" id="Txtsettingleave_' + res[i]['Userid'] + '" value="' + res[i]['Settingleave'] + '" /></td>';
                           }
                           html += '<td><input type="text" style="text-align:right;" readonly="readonly" Class="form-control" id="Txttotalleave_' + res[i]['Userid'] + '" value="' + res[i]['Totalleave'] + '" /></td>';
                           html += '<td><input type="text" style="text-align:right;" readonly="readonly" Class="form-control" id="Txtcurrentleave_' + res[i]['Userid'] + '" value="' + res[i]['Currentleave'] + '" /></td>';
                           html += '<td><input type="text" style="text-align:right;" readonly="readonly" Class="form-control" id="Txtremainleave_' + res[i]['Userid'] + '" value="' + res[i]['Remainleave'] + '" /></td>';
                           if (res[i]['Isdone'] != "True") {
                               Ctrl = '<button style="border-radius:1px;font-size:13px;" Class="btn btn-Secondary" onclick="Saveleave(' + res[i]['Userid'] + ')" >บันทึกวันลา</button>';
                           }
                           else {
                               Ctrl = '<span style="color:green;font-size:14px;">บันทึกวันลาแล้ว</span>';
                           }
                           if (res[i]['Isconsolidate'] != "True") {
                               if (res[i]['Isdone'] != "True") {
                                   Ctrlconsolidate = '<button style="border-radius:1px;font-size:13px;" disabled="disabled" Class="btn btn-danger" onclick="Consolidateleave(' + res[i]['Userid'] + ')" >ยกยอดวันลา</button>';
                               }
                               else {
                                   Ctrlconsolidate = '<button style="border-radius:1px;font-size:13px;" Class="btn btn-danger" onclick="Consolidateleave(' + res[i]['Userid'] + ')" >ยกยอดวันลา</button>';
                               }
                           }
                           else {
                               Ctrlconsolidate = '<span style="color:green;font-size:14px;">ยกยอดวันลาแล้ว</span>';
                           }
                           html += '</td>';
                           html += '<td style="text-align:center;">' + Ctrl + '</td>';
                           html += '<td  style="text-align:center;">' + Ctrlconsolidate + '</td>';
                           html += '</tr>';
                       }
                   }
                   else {
                       html += '<tr>';
                       html += '<td colspan="6"><div style="color:red;height:100px;text-align:center;">ไม่พบนักศึกษาที่ลงทะเบียน</div></td>';
                       html += '</tr>';
                   }
                   html += '</table>';
                   $('#Divsettingleavecont').html(html);
               },
               async: false,
               error: function (er) {
               }
           });
           
       }
       function Getsettingleavetype() {
           var json = '';
           $.ajax({
               type: "POST",
               url: "\../Page/HR/MasHR.aspx/Getleavetype",
               data: "{'json' :'" + json + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               beforeSend: function () {
                   $(".loader").fadeOut("slow");
               },
               success: function (response) {
                   res = response.d;
                   $('#Cbsettingleavetype').find('option').remove().end();

                   if (res.length == 0) {
                       $('#Cbsettingleavetype').append($('<option/>', {
                           value: '',
                           text: 'ไม่พบหลักสูตร'
                       }));
                   }
                   else {
                       for (i = 0; i < res.length; i++) {
                           $('#Cbsettingleavetype').append($('<option/>', {
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
                        <a class="nav-link" href="#" onclick="Settingleave();" id="aSettingLeave();">ข้อมูลกำหนดวันลา</a>
                    </li>
                   <%-- <li class="nav-item">
                        <a class="nav-link" href="#" onclick="Term();" id="Divsettingentrance();">ข้อมูลเวลาเข้างาน</a>
                    </li>--%>
                </ul>
            </div>
        </nav>
   
    <div id="Divsettingleave" style="display: none;margin-top:30px;">
        <div class="container">
            <div class="row mt-3">
                <div class="col-2" style="text-align:right;">
                    <span>ประเภทการลา</span>
                </div>
                <div class="col-4">
                    <select class="form-control" id="Cbsettingleavetype">

                    </select>
                </div>
                 <div class="col-2"  style="text-align:right;">
                    <span>ปี</span>
                </div>
                <div class="col-2">
                    <select class="form-control" id="Cbsettingleaveyear">

                    </select>
                </div>
                 <div class="col-2">
                  <button class="btn btn-info" style="font-family:TH SarabunPSK;font-size:13px;border-radius:1px;" onclick="Searchsettingleave();">ค้นหา</button>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-12">
                    <hr />
                </div>
                
            </div>
            <div class="row mt-1">
                  <div class="col-3">
                        <%--<button class="btn btn-secondary" style="font-family:TH SarabunPSK;font-size:13px;border-radius:1px;" onclick="doSettingleave();">บันทึกวันลาทั้งหมด</button>--%>
                  </div>
            </div>
            <div class="row mt-1">
                  <div id="Divsettingleavecont" class="col-12">
                       
                  </div>
            </div>
        </div>
    </div>
   </div>
</body>
</html>

