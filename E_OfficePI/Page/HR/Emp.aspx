<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Emp.aspx.cs" Inherits="E_OfficePI.Page.HR.Emp" %>

<!DOCTYPE html>
<html>
<head>
    <style>
        .a
        {
            background-color:#808080;
        }
               @media (min-width: 768px) {
  .modal-xl {
    width: 90%;
   max-width:1200px;
  }
}
    </style>
    <%--    <!-- Bootstrap -->
    <link href="/../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="/../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="/../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="/../vendors/iCheck/skins/flat/blue.css" rel="stylesheet">

    <!-- bootstrap-progressbar -->
    <link href="/../vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- JQVMap -->
    <link href="/../vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet" />
    <!-- bootstrap-daterangepicker -->
    <link href="../vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <!-- TODO put back the minified version after completion and minification -->
    <link href="/../build/css/custom.css" rel="stylesheet">
    <link href="/../build/css/style-extra-bs4.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>--%>
    <script src="../../js/engine.js"></script>
    <script src="../../js/datepicker/bootstrap-datepicker.js"></script>
    <link href="../../js/datepicker/datepicker.css" rel="stylesheet" />
    <title></title>
    <style>
        body
        {
            font-family: 'TH SarabunPSK';
            font-size: 18px; 
        }
        button {
            font-family: 'TH SarabunPSK';
            font-size: 18px;
        }
         .form-control{
            font-family: 'TH SarabunPSK';
            font-size: 18px;
        }
        .modal-dialog {
            position: absolute;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
            margin: auto;
            width: 1200px;
            height: 300px;
            color:black;
        }

        .modal-ku {
            width: 800px;
            margin: auto;
        }
    </style>
    <script>
        function ChangeIns(ctrl, type) {

          

            var json = 'type:' + type + '|';
            json += 'value:' + $('#' + ctrl).prop("checked") + '|';
            json += 'Hdempid:' + $('#Hdempid').val() + '|';
            json += 'firstnameTH :' + $('#TxtfirstnameTH').val() + '|';
            json += 'lastnameTH :' + $('#TxtlastnameTH').val() + '|';
    
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/ChangeIns",
                data: "{'json' : '" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d != '') {
                        Msgbox(response.d);
                        return;
                    }
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');

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
        function PostDelete(ctrl, dat) {

            if (ctrl == "Gvleavedetail") {
                Leavedetail($('#Hdleavetype').val());
            }
            else if (ctrl == "Gveducation") {
                Bindeducation();
            }
            else if (ctrl == "Gvprofession") {
                Bindprofession();
            }
            else if (ctrl == "Gvprofessioncouncil") {
                Bindprofessioncouncil();
            }
            else if (ctrl == "Gvexpertise") {
                Bindexpertise();
            }
            else if (ctrl == "Gvpromote") {
                Bindpromote();
            }
            else if (ctrl == "Gvinsignia") {
                Bindinsignia();
            }
            

        }
        function CallUpload(Ctrl, Type) {
            var key = '';
            w = 600;
            h = 400;
            var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
            var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
            var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
            var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;
            var left = ((width / 2) - (w / 2)) + dualScreenLeft;
            var top = ((height / 2) - (h / 2)) + dualScreenTop;
            window.open('../Attachment/Upload.aspx?key=' + key, '_blank', 'directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
        }
        function CallBackUpload(Ctrl, RunningNo) {

           
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/CallBackUpload",
                data: "{'Ctrl' : '" + Ctrl + "','RunningNo' :'" + RunningNo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                   
                    $('#Imgempprofile').attr('src', '../Attachment/File/' +  response.d["src"]);
                    $('#Imgempprofile').attr('data-value', response.d["AttachmentId"]);
                   
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
        function Leavedetail(Leavetype)
        {
            $('#Hdleavetype').val(Leavetype);
            $('#Divleavedetail').modal('show');
            ClearResource('HR/emp.aspx', 'Gvleavedetail');
            var Cri = $('#Hdempid').val() + '|' + Leavetype;
            var Columns = ["เรื่องที่ขอลา!L","รายละเอียดการลา", "ช่วงเวลาที่ลา", "ผู้ทำการแทน!L","สถานะ!C"];
            var Data = ["Leavesubject", "Leavedesc", "Fulldate","fullname","Status"];
            var Searchcolumns = [];
            var SearchesDat = [];
            var Width = ["25%", "25%", "15%", "25%","10%"];
           
            var Gv = new Grid("HR/emp.aspx", Columns, SearchesDat, Searchcolumns, 'Gvleavedetail', 30, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divleavedetailcont').html(Gv._Tables());
            Gv._Bind();
        }
        function Saveleave() {
            var json = '';
            json =  'Hdempid:' + $('#Hdempid').val() + '|';
            json += 'Hdleavetypeid:' + $('#Hdleavetypeid').val() + '|';
            json += 'Txtleavesubject:' + $('#Txtleavesubject').val() + '|';
            json += 'Cbleavecat:' + $('#Cbleavecat').val() + '|';
            json += 'Txtstartleave:' + $('#Txtstartleave').val() + '|';
            json += 'Txtstopleave:' + $('#Txtstopleave').val() + '|';
            json += 'Txtpartleave:' + $('#Txtpartleave').val() + '|';
            json += 'Cbleavepartstarttime:' + $('#Cbleavepartstarttime').val() + '|';
            json += 'Cbleavepartstoptime:' + $('#Cbleavepartstoptime').val() + '|';
            json += 'Txtleavedesc:' + $('#Txtleavedesc').val() + '|';
            json += 'Cbdelegate:' + $('#Cbdelegate').val() + '|';

            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Saveleave",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != '') {
                        Msgboxsuccess(res);
                        return;
                    }
                    $('#Divmodalleave').modal('hide');
                    Getleaves();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Getparttime() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getparttime",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbleavepartstarttime').find('option').remove().end();
                    for (i = 0; i < res.length; i++) {
                        $('#Cbleavepartstarttime').append($('<option/>', {
                            value: res[i]["Val"],
                            text: res[i]["Name"]
                        }));
                    }

                    $('#Cbleavepartstoptime').find('option').remove().end();
                    for (i = 0; i < res.length; i++) {
                        $('#Cbleavepartstoptime').append($('<option/>', {
                            value: res[i]["Val"],
                            text: res[i]["Name"]
                        }));
                    }

                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Getdelegate() {
            var json = '';
            json += 'Hdempid:' + $('#Hdempid').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getdelegate",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbdelegate').find('option').remove().end();
                    for (i = 0; i < res.length; i++) {
                        $('#Cbdelegate').append($('<option/>', {
                            value: res[i]["Val"],
                            text: res[i]["Name"]
                        }));
                    }
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Reqleave(x, leavetypename) {

            //validate ก่อน
            var json = 'userid:' + $('#Hdempid').val() + '|';
            json += 'type:' + x + '|'; 
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Validateleave",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != '') {
                        Msgbox(res);
                        return;
                    }
                    $('#Spleavetypetitle').html(leavetypename);
                    $('#Hdleavetypeid').val(x);
                    $('#Divmodalleave').modal('show');
                    $('#Txtleavesubject').val('');
                    Getdelegate();
                    Getparttime();
                    $('#Txtstartleave').val('');
                    $('#Txtstopleave').val('');
                    $('#Txtpartleave').val('');
                    $('#Txtleavedesc').val('');
                    $('#Cbdelegate').val('');
                },
                async: true,
                error: function (er) {

                }
            });

            
        }
        $(document).ready(function () {
            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });
          
        });
        //$(document).ajaxStart(function () {
        //    $('#pleaseWaitDialog').show();
        //}).ajaxStop(function () {
        //    $('#pleaseWaitDialog').hide();
        //});
        function Getleaves() {
            var json = '';
            var html = '';
            var i = 0;
            json += 'Hdempid:' + $('#Hdempid').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getleaves",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    html += '<div class="container" style="margin-top:20px;margin-bottom:20px;">';
                    html += '<div class="row mt-3">';
                    for (i = 0; i < res.length; i++) {
                        html += '<div class="col-3">';
                        html += '<div class="card">';
                        html += '<div class="card-header" style="text-align:center;">';
                        html += res[i]['Leavetypename'];
                        html += '</div>';
                        html += '<div class="card-body">';
                        html += '<h6 class="card-title">วันลาคงเหลือ / วันลาทั้งหมด</h5>';
                        html += '<div style="min-height:100px;text-align:center;verticle-align:middle;"><h2 style="color:orange;margin-top:30px;font-weight:bold;">' + res[i]['Remainleave'] + ' / ' + res[i]['Totalleave'] + '</p></div>';
                        html += '<div  class="input-group"><button  class="btn btn-primary"  onclick="Reqleave(' + res[i]['Leavetype'] + ',\'' + res[i]['Leavetypename'] + '\');">ทำเรื่องลา</button><button  class="btn btn-primary" style="width:100px;margin-left:5px;" onclick="Leavedetail(\'' + res[i]['Leavetype'] + '\');">รายละเอียด</button></div>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                    }
                    html += '</div>';
                    html += '</div>';
                    $('#Divleaves').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Savepromote() {
            var json = '';
            json += 'Hdempid:' + $('#Hdempid').val() + '|';
            json += 'Hdpromote:' + $('#Hdpromoteid').val() + '|';
            json += 'Effectdate:' + $('#Txteffectdate').val() + '|';
            json += 'Positionremark:' + $('#Txtpositionremark').val() + '|';
            json += 'Positionno:' + $('#Txtpositionno').val() + '|';
            json += 'Lvremark:' + $('#Txtlvremark').val() + '|';
            json += 'Salary:' + $('#Txtpromotesalary').val() + '|';
            json += 'Referdocument:' + $('#Txtreferdocument').val() + '|';
            json += 'Promotetypeid:' + $('#Cbpromotetype').val() + '|';
            json += 'Managementpositionid:' + $('#Cbpromotemanagementposition').val() + '|';
            json += 'Lineofjobpositionid:' + $('#Cblineofjobposition').val() + '|';
            json += 'Workplace:' + $('#Txtpromoteworkplace').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Savepromote",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != "") {
                        Msgbox(res);
                        return;
                    }
                    $('#Divmodalpromote').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Bindpromote();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Getpromotetype() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getpromotetype",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbpromotetype').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbpromotetype').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbpromotetype').append($('<option/>', {
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

        function Getpromotemanagementposition() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getmanagementposition",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbpromotemanagementposition').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbpromotemanagementposition').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbpromotemanagementposition').append($('<option/>', {
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

        function Getlineofjobposition() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getlineofjobposition",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cblineofjobposition').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cblineofjobposition').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cblineofjobposition').append($('<option/>', {
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


        function Getpromotetype() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getpromotetype",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbpromotetype').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbpromotetype').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbpromotetype').append($('<option/>', {
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

        function Newpromote() {
            Getpromotetype();
            Getlineofjobposition();
            Getpromotemanagementposition();
            $('#Txtpromoteworkplace').val('');
            $('#Txtreferdocument').val('');
            $('#Txtpromotesalary').val('');
            $('#Txtlvremark').val('');
            $('#Txtpositionremark').val('');
            $('#Txteffectdate').val('');
            $('#Hdpromoteid').val('');
            $('#Divmodalpromote').modal('show');
        }


        function Bindpromote() {
            ClearResource('HR/emp.aspx', 'Gvpromote');
            var Cri = $('#Hdempid').val();
            var Columns = ["วัน เดือน ปี!L", "ตำแหน่ง!L", "เลขที่ตำแหน่ง!L", "ระดับ!L", "อัตราเงินเดือน!L", "เอกสารอ้างอิง!L"];
            var Data = ["Effectdate", "Positionremark", "Positionno", "LvRemark", "Salary", "ReferDocument"];
            var Searchcolumns = ["ตำแหน่ง", "เลขที่ตำแหน่ง", "ระดับ", "อัตราเงินเดือน", "เอกสารอ้างอิง"];
            var SearchesDat = ["Positionremark", "Positionno", "LvRemark", "Salary", "ReferDocument"];
            var Width = ["15%", "15%", "15%", "15%", "15%", "10%", "10%"];
            var Gv = new Grid("HR/emp.aspx", Columns, SearchesDat, Searchcolumns, 'Gvpromote', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;" onclick="Newpromote();">เพิ่มตำแหน่ง</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divpromote').html(Gv._Tables());
            Gv._Bind();
        }
        function Saveinsignia() {
            var json = '';
            json += 'Hdempid:' + $('#Hdempid').val() + '|';
            json += 'Hdinsignia:' + $('#Hdinsigniaid').val() + '|';


            json += 'Cbinsignia:' + $('#Cbinsignia').val() + '|';
            json += 'Txtinsigniabookno:' + $('#Txtinsigniabookno').val() + '|';
            json += 'Txtinsigniaorderno:' + $('#Txtinsigniaorderno').val() + '|';
            json += 'Txtinsigniapageno:' + $('#Txtinsigniapageno').val() + '|';
            json += 'Txtinsigniaanouncedate:' + $('#Txtinsigniaanouncedate').val() + '|';
            json += 'Txtinsigniaparagraphno:' + $('#Txtinsigniaparagraphno').val() + '|';
            json += 'Txtinsigniayearno:' + $('#Txtinsigniayearno').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Saveinsignia",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != "") {
                        Msgboxsuccess(res);
                        return;
                    }
                    $('#Divmodalinsignia').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Bindinsignia();

                },
                async: true,
                error: function (er) {

                }
            });
        }



        function Getinsignia() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getinsignia",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbinsignia').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbinsignia').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbinsignia').append($('<option/>', {
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
        function Newinsignia() {
            Getinsignia();
            $('#Txtinsigniabookno').val('');
            $('#Txtinsigniayearno').val('');
            $('#Txtinsigniaparagraphno').val('');
            $('#Txtinsigniaanouncedate').val('');
            $('#Txtinsigniapageno').val('');
            $('#Txtinsigniaorderno').val('');
            $('#Hdinsigniaid').val('');
            $('#Divmodalinsignia').modal('show');
        }
        function Bindinsignia() {
            ClearResource('HR/emp.aspx', 'Gvinsignia');
            var Cri = $('#Hdempid').val();
            var Columns = ["ปี!L", "ชั้นตราเครื่องราชอิสริยาภรณ์!L", "เล่มที่!L", "ตอนที่!L", "วันที่ประกาศ!L", "หน้าที่!L", "ลำดับ!L"];
            var Data = ["Yearno", "Insignianame", "Bookno", "Paragraphno", "AnounceDate", "Pageno", "Orderno"];
            var Searchcolumns = ["ปี", "ชั้นตราเครื่องราชอิสริยาภรณ์", "เล่มที่", "ตอนที่", "วันที่ประกาศ", "หน้าที่", "ลำดับ"];
            var SearchesDat = ["Yearno", "Insignianame", "Bookno", "Paragraphno", "AnounceDate", "Pageno", "Orderno"];
            var Width = ["10%", "35%", "5%", "8%", "15%", "5%", "5%"];
            var Gv = new Grid("HR/emp.aspx", Columns, SearchesDat, Searchcolumns, 'Gvinsignia', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;" onclick="Newinsignia();">เพิ่มเครื่องราชอิสริยาภรณ์</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divinsignia').html(Gv._Tables());
            Gv._Bind();
        }

        function Saveexpertise() {
            var json = '';
            json += 'Hdempid:' + $('#Hdempid').val() + '|';
            json += 'Hdexpertise:' + $('#Hdexpertiseid').val() + '|';
            json += 'Txtexpertisetopic:' + $('#Txtexpertisetopic').val() + '|';
            json += 'Txtexpertiseremark:' + $('#Txtexpertiseremark').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Saveexpertise",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != "") {
                        Msgboxsuccess(res);
                        return;
                    }
                    $('#Divmodalexpertise').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Bindexpertise();

                },
                async: true,
                error: function (er) {
                }
            });
        }

        function Newexpertise() {
            $('#Txtexpertisetopic').val('');
            $('#Txtexpertiseremark').val('');
            $('#Hdexpertiseid').val('');
            $('#Divmodalexpertise').modal('show');
        }
        function Bindexpertise() {
            ClearResource('HR/emp.aspx', 'Gvexpertise');
            var Cri = $('#Hdempid').val();
            var Columns = ["เรื่อง!L", "ประเด็นสำคัญ!L"];
            var Data = ["topic", "remark"];
            var Searchcolumns = ["เรื่อง", "ประเด็นสำคัญ"];
            var SearchesDat = ["topic", "remark"];
            var Width = ["40%", "40%"];
            var Gv = new Grid("HR/emp.aspx", Columns, SearchesDat, Searchcolumns, 'Gvexpertise', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;" onclick="Newexpertise();">เพิ่มความชำนาญ</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divexpertise').html(Gv._Tables());
            Gv._Bind();
        }
        function Saveprofessioncouncil() {
            var json = '';
            json += 'Hdempid:' + $('#Hdempid').val() + '|';
            json += 'Hdprofessioncouncil:' + $('#Hdprofessioncouncilid').val() + '|';
            json += 'Cbprofessioncouncil:' + $('#Cbprofessioncouncil').val() + '|';
            json += 'Txtprofessioncouncilno:' + $('#Txtprofessioncouncilno').val() + '|';
            json += 'Txtprofessioncouncilstart:' + $('#Txtprofessioncouncilstart').val() + '|';
            json += 'Txtprofessioncouncilstop:' + $('#Txtprofessioncouncilstop').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Saveprofessioncouncil",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != "") {
                        Msgboxsuccess(res);
                        return;
                    }
                    $('#Divmodalprofessioncouncil').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Bindprofessioncouncil();

                },
                async: true,
                error: function (er) {

                }
            });
        }



        function Getprofessioncouncil() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getprofessioncouncil",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofessioncouncil').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofessioncouncil').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofessioncouncil').append($('<option/>', {
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



        function Newprofessioncouncil() {
            Getprofessioncouncil();
            $('#Txtprofessioncouncilstart').val('');
            $('#Txtprofessioncouncilstop').val('');
            $('#Txtprofessioncouncilno').val('');
            $('#Hdprofessioncouncilid').val('');
            $('#Divmodalprofessioncouncil').modal('show');
        }


        function Bindprofessioncouncil() {
            ClearResource('HR/emp.aspx', 'Gvprofessioncouncil');
            var Cri = $('#Hdempid').val();
            var Columns = ["ชื่อวิชาชีพ!L", "เลขที่ใบประกอบวิชาชีพ!L", "วันที่ออกบัตร!L", "วันที่บัตรหมดอายุ!L"];
            var Data = ["professioncouncilname", "professioncouncilNo", "professioncouncilstart", "professioncouncilend"];
            var Searchcolumns = ["ชื่อวิชาชีพ", "เลขที่ใบประกอบวิชาชีพ"];
            var SearchesDat = ["professionname", "professioncouncilno"];
            var Width = ["20%", "20%", "20%", "20%"];
            var Gv = new Grid("HR/emp.aspx", Columns, SearchesDat, Searchcolumns, 'Gvprofessioncouncil', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;" onclick="Newprofessioncouncil();">เพิ่มวิชาชีพ</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divprofessioncouncil').html(Gv._Tables());
            Gv._Bind();
        }



        function Saveprofession() {
            var json = '';
            json += 'Hdempid:' + $('#Hdempid').val() + '|';
            json += 'Hdprofession:' + $('#Hdprofessionid').val() + '|';
            json += 'Cbprofession:' + $('#Cbprofession').val() + '|';
            json += 'Txtprofessionno:' + $('#Txtprofessionno').val() + '|';
            json += 'Txtprofessionstart:' + $('#Txtprofessionstart').val() + '|';
            json += 'Txtprofessionstop:' + $('#Txtprofessionstop').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Saveprofession",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != "") {
                        Msgboxsuccess(res);
                        return;
                    }
                    $('#Divmodalprofession').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Bindprofession();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Saveeducation() {
            var json = '';
            json += 'Hdempid:' + $('#Hdempid').val() + '|';
            json += 'Hdeducation:' + $('#Hdeducationid').val() + '|';
            json += 'Cbdegree:' + $('#Cbdegree').val() + '|';
            json += 'Cbeducation:' + $('#Cbeducation').val() + '|';
            json += 'Cbmajor:' + $('#Cbmajor').val() + '|';
            json += 'Cbacademy:' + $('#Cbacademy').val() + '|';
            json += 'Cbcountry:' + $('#Cbcountry').val() + '|';
            json += 'Txteducationstart:' + $('#Txteducationstart').val() + '|';
            json += 'Txteducationstop:' + $('#Txteducationstop').val() + '|';
            json += 'Txtstartemployprofessionname:' + $('#Txtstartemployprofessionname').val() + '|';
            json += 'Cbismaxeducation:' + $('#Cbismaxeducation').val() + '|';
            json += 'Cbisuseforstartaffair:' + $('#Cbisuseforstartaffair').val() + '|';
            json += 'Chkisnurse:' + $('#Chkisnurse').prop('checked') + '|';
            

            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Saveeducation",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != "") {
                        Msgboxsuccess(res);
                        return;
                    }
                    $('#Divmodaleducation').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Bindeducation();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Getacademy() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getacademy",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbacademy').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbacademy').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbacademy').append($('<option/>', {
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
        function Getmajor() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getmajor",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbmajor').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbmajor').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbmajor').append($('<option/>', {
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
        function Getcountry() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getcountry",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbcountry').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbcountry').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbcountry').append($('<option/>', {
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
        function Geteducation() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Geteducation",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbeducation').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbeducation').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbeducation').append($('<option/>', {
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
        function Getprofession() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getprofession",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofession').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofession').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofession').append($('<option/>', {
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
        function Getdegree() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getdegree",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbdegree').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbdegree').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbdegree').append($('<option/>', {
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
        function Neweducation() {
            Getdegree();
            Geteducation();
            Getmajor();
            Getacademy();
            Getcountry();
            $('#Txteducationstart').val('');
            $('#Txteducationstop').val('');
            $('#Txtstartemployprofessionname').val('');
            $('#Cbismaxeducation').val('True');
            $('#Cbisuseforstartaffair').val('True');
            $('#Chkisnurse').prop('checked', '');
            

            $('#Hdeducationid').val('');
            $('#Divmodaleducation').modal('show');
        }
        function Newprofession() {
            Getprofession();
            $('#Txtprofessionstart').val('');
            $('#Txtprofessionstop').val('');
            $('#Txtprofessionno').val('');
            $('#Hdprofessionid').val('');
            $('#Divmodalprofession').modal('show');
        }
        function CustomEdit(ctrl, dat, div, WPanel, HPanel) {
            var json = dat;
            if (ctrl == 'Gvinsignia') {
                
                $.ajax({
                    type: "POST",
                    url: "\../Page/HR/Emp.aspx/Getinsigniainfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        Getinsignia();
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgboxsuccess(res["Error"]);
                            return;
                        }
                        $('#Hdinsigniaid').val(res['id']);
                        $('#Cbinsignia').val(res['Insigniaid']);
                        $('#Txtinsigniaorderno').val(res['Orderno']);
                        $('#Txtinsigniapageno').val(res['Pageno']);
                        $('#Txtinsigniaanouncedate').val(res['Anouncedate']);
                        $('#Txtinsigniabookno').val(res['Bookno']);
                        $('#Txtinsigniayearno').val(res['Yearno']);
                        $('#Txtinsigniaparagraphno').val(res['Paragraphno']);
                        $('#Divmodalinsignia').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            else if (ctrl == "Gvpromote")
            {
                $.ajax({
                    type: "POST",
                    url: "\../Page/HR/Emp.aspx/Getpromoteinfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        Getpromotetype();
                        Getpromotemanagementposition();
                        Getlineofjobposition();
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgboxsuccess(res["Error"]);
                            return;
                        }
                        $('#Hdpromoteid').val(res['id']);
                        $('#Txteffectdate').val(res['Effectdate']);
                        $('#Txtpositionremark').val(res['Positionremark']);
                        $('#Txtlvremark').val(res['Lvremark']);
                        
                        $('#Txtpositionno').val(res['Positionno']);
                        $('#Txtreferdocument').val(res['Referdocument']);
                        $('#Txtpromotesalary').val(res['Salary']);
                        $('#Txtreferdocument').val(res['Referdocument']);
                        $('#Cbpromotetype').val(res['Promotetypeid']);
                        $('#Cbpromotemanagementposition').val(res['Managementpositionid']);
                        $('#Cblineofjobposition').val(res['Lineofjobpositionid']);
                        $('#Txtpromoteworkplace').val(res['Workplace']);
                        $('#Divmodalpromote').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            else if (ctrl == 'Gvexpertise') {
                $.ajax({
                    type: "POST",
                    url: "\../Page/HR/Emp.aspx/Getexpertiseinfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        Getprofession();
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgboxsuccess(res["Error"]);
                            return;
                        }
                        $('#Hdexpertiseid').val(res['id']);
                        $('#Txtexpertisetopic').val(res['Topic']);
                        $('#Txtexpertiseremark').val(res['Remark']);
                        $('#Divmodalexpertise').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            else if (ctrl == 'Gvprofessioncouncil') {
                $.ajax({
                    type: "POST",
                    url: "\../Page/HR/Emp.aspx/Getprofessioncouncilinfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        Getprofessioncouncil();
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgboxsuccess(res["Error"]);
                            return;
                        }

                        $('#Hdprofessioncouncilid').val(res['id']);
                        $('#Cbprofessioncouncil').val(res['Professioncouncilid']);
                        $('#Txtprofessioncouncilstart').val(res['Professioncouncilstart']);
                        $('#Txtprofessioncouncilstop').val(res['Professioncouncilend']);
                        $('#Txtprofessioncouncilno').val(res['Professioncouncilno']);
                        $('#Divmodalprofessioncouncil').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            else if (ctrl == 'Gvprofession') {
                $.ajax({
                    type: "POST",
                    url: "\../Page/HR/Emp.aspx/Getprofessioninfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        Getprofession();
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgboxsuccess(res["Error"]);
                            return;
                        }

                        $('#Hdprofessionid').val(res['id']);
                        $('#Cbprofession').val(res['Professionid']);
                        $('#Txtprofessionstart').val(res['Professionstart']);
                        $('#Txtprofessionstop').val(res['Professionend']);
                        $('#Txtprofessionno').val(res['Professionno']);
                        $('#Divmodalprofession').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            else if (ctrl == 'Gveducation') {
                $.ajax({
                    type: "POST",
                    url: "\../Page/HR/Emp.aspx/Geteducationinfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        Getdegree();
                        Geteducation();
                        Getmajor();
                        Getacademy();
                        Getcountry();
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgboxsuccess(res["Error"]);
                            return;
                        }
                        $('#Hdeducationid').val(res['id']);
                        $('#Cbdegree').val(res['Degreeid']);

                        $('#Cbeducation').val(res['Educationid']);
                        $('#Cbmajor').val(res['Majorid']);
                        $('#Cbacademy').val(res['Academyid']);
                        $('#Cbcountry').val(res['Countryid']);
                        $('#Txteducationstart').val(res['Educationstart']);
                        $('#Txteducationstop').val(res['Educationend']);
                        $('#Txtstartemployprofessionname').val(res['Startemployprofession']);
                        $('#Cbismaxeducation').val(res['IsmaxEducation']);
                        $('#Cbisuseforstartaffair').val(res['IsuseforStartAffair']);
                   
                        $('#Chkisnurse').prop('checked', res['Isnurse']);
                        $('#Divmodaleducation').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
        }
        function Bindprofession() {
            ClearResource('HR/emp.aspx', 'Gvprofession');
            var Cri = $('#Hdempid').val();
            var Columns = ["ชื่อวิชาชีพ!L", "เลขที่ใบประกอบวิชาชีพ!L", "วันที่ออกบัตร!L", "วันที่บัตรหมดอายุ!L"];
            var Data = ["professionname", "professionNo", "professionstart", "professionend"];
            var Searchcolumns = ["ชื่อวิชาชีพ", "เลขที่ใบประกอบวิชาชีพ"];
            var SearchesDat = ["professionname", "professionno"];
            var Width = ["20%", "20%", "20%", "20%"];
            var Gv = new Grid("HR/emp.aspx", Columns, SearchesDat, Searchcolumns, 'Gvprofession', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;" onclick="Newprofession();">เพิ่มวิชาชีพ</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divprofession').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindeducation() {
            ClearResource('HR/emp.aspx', 'Gveducation');
            var Cri = $('#Hdempid').val();
            var Columns = ["ระดับการศึกษา!L", "วุฒิการศึกษา!L", "สาขา!L", "วันที่เริ่มศึกษา - วันที่จบการศึกษา!L", "สถานศึกษา!L"];
            var Data = ["Degreename", "Educationname", "Majorname", "Educationperiod", "Academyname"];
            var Searchcolumns = ["ระดับการศึกษา", "วุฒิการศึกษา", "สาขา", "สถานศึกษา"];
            var SearchesDat = ["Degreename", "Educationname", "Majorname", "Academyname"];
            var Width = ["10%", "15%", "20%", "20%", "20%"];
            var Gv = new Grid("HR/emp.aspx", Columns, SearchesDat, Searchcolumns, 'Gveducation', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;" onclick="Neweducation();">เพิ่มประวัติการศึกษา</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Diveducation').html(Gv._Tables());
            Gv._Bind();
        }
        function District(x) {
            Getdistrictbyctrl($('#Cbaddressprovince_' + x).val(), 'Cbaddressdistrict_' + x);
            Getsubdistrictbyctrl(0, 'Cbaddresssubdistrict_' + x);
            Getpostcodebyctrl(0, 'Cbaddresspostcode_' + x);
        }
        function Subdistrict(x) {
            Getsubdistrictbyctrl($('#Cbaddressdistrict_' + x).val(), 'Cbaddresssubdistrict_' + x);
            Getpostcodebyctrl(0, 'Cbaddresspostcode_' + x);
        }
        function Postcode(x) {
            Getpostcodebyctrl($('#Cbaddresssubdistrict_' + x).val(), 'Cbaddresspostcode_' + x);
        }

        function Getaddress() {
            var i = 0;
            var html = '';
            var res;
            var json = $('#Hdempid').val();
            var ctrlprovince = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getaddress",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    for (i = 0; i < res.length; i++) {
                        html += '<div class="card" style="margin-top:20px;">';
                        html += '<div class="card-header">';
                        html += res[i]['Addresstype']
                        html += '</div>';
                        html += '<div class="card-body">';
                        html += '<div class="container">';
                        html += '<div class="row mt-3">';
                        html += '<div class="col-12">';
                        html += '<span>ที่อยู่</span>';
                        html += '</div>';
                        html += '<div class="col-12">';
                        html += '<textarea id="Txtaddress_' + res[i]['id'] + '" class="form-control" style="height:100px">' + res[i]['Address'] + '</textarea>';
                        html += '</div>';
                        html += '</div>';

                        html += '<div class="row mt-3">';
                        html += '<div class="col-6">';
                        html += '<span>จังหวัด</span>';
                        html += '</div>';
                        html += '<div class="col-6">';
                        html += '<span>อำเภอ</span>';
                        html += '</div>';
                        html += '</div>';

                        html += '<div class="row mt-3">';
                        html += '<div class="col-6">';
                        html += '<select onchange="District(' + res[i]['id'] + ');" id="Cbaddressprovince_' + res[i]['id'] + '" class="form-control"></select>';
                        html += '</div>';
                        html += '<div class="col-6">';
                        html += '<select onclick="Subdistrict(' + res[i]['id'] + ');" id="Cbaddressdistrict_' + res[i]['id'] + '" class="form-control"></select>';
                        html += '</div>';
                        html += '</div>';

                        html += '<div class="row mt-3">';
                        html += '<div class="col-6">';
                        html += '<span>ตำบล</span>';
                        html += '</div>';
                        html += '<div class="col-6">';
                        html += '<span>รหัสไปรษณีย์</span>';
                        html += '</div>';
                        html += '</div>';


                        html += '<div class="row mt-3">';
                        html += '<div class="col-6">';
                        html += '<select onclick="Postcode(' + res[i]['id'] + ');" id="Cbaddresssubdistrict_' + res[i]['id'] + '" class="form-control"></select>';
                        html += '</div>';
                        html += '<div class="col-6">';
                        html += '<select  id="Cbaddresspostcode_' + res[i]['id'] + '" class="form-control"></select>';
                        html += '</div>';
                        html += '</div>';

                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                    }
                    $('#Divaddress').html(html);

                    for (i = 0; i < res.length; i++) {
                        ctrlprovince += 'Cbaddressprovince_' + res[i]['id'] + '|';
                    }

                    Getprovincebyctrl(ctrlprovince);

                    for (i = 0; i < res.length; i++) {

                        $('#Cbaddressprovince_' + res[i]['id']).val(res[i]['Provinceid']);
                        Getdistrictbyctrl(res[i]['Provinceid'], 'Cbaddressdistrict_' + res[i]['id']);
                        $('#Cbaddressdistrict_' + res[i]['id']).val(res[i]['Districtid']);
                        Getsubdistrictbyctrl(res[i]['Districtid'], 'Cbaddresssubdistrict_' + res[i]['id']);
                        $('#Cbaddresssubdistrict_' + res[i]['id']).val(res[i]['Subdistrictid']);
                        Getpostcodebyctrl(res[i]['Subdistrictid'], 'Cbaddresspostcode_' + res[i]['id']);
                        $('#Cbaddresspostcode_' + res[i]['id']).val(res[i]['Postcode']);
                    }

                },
                async: false,
                error: function (er) {
                }
            });

        }
        function Save(x) {
            var json = '';
            if (x == '2') {
                json += 'x :' + x + '|';
                json += 'Hdempid :' + $('#Hdempid').val() + '|';
                $('#Divaddress').find('textarea').each(function () {
                    json += $(this).attr('id') + ':' + $(this).val() + '|';
                });
                $('#Divaddress').find('select').each(function () {
                    json += $(this).attr('id') + ':' + $(this).val() + '|';
                });
            }
            else if (x == '7')
            {
                //profile
                json += 'x :' + x + '|';
                json += 'Hdempid :' + $('#Hdempid').val() + '|';
                json += 'Txtaffairstart :' + $('#Txtaffairstart').val() + '|';
                json += 'Txtstartemploy :' + $('#Txtstartemploy').val() + '|';
                json += 'Cbisinstructor :' + $('#Cbisinstructor').val() + '|';
                json += 'Txtworkplace :' + $('#Txtworkplace').val() + '|';
                json += 'Txtsalary :' + $('#Txtsalary').val() + '|';
                json += 'Cbfield :' + $('#Cbfield').val() + '|';
                json += 'Cbisreponsiblelab :' + $('#Cbisreponsiblelab').val() + '|';
                json += 'Cbmanagementposition :' + $('#Cbmanagementposition').val() + '|';
                json += 'Cbemploytype :' + $('#Cbemploytype').val() + '|';
                json += 'Cbcurrentstatus :' + $('#Cbcurrentstatus').val() + '|';
                json += 'Cbisoperate :' + $('#Cbisoperate').val() + '|';
            }
            else if (x == '1') {
                //profile
                json += 'x :' + x + '|';
                json += 'Hdempid :' + $('#Hdempid').val() + '|';
                json += 'Txtempno :' + $('#Txtempno').val() + '|';
                json += 'Txtmymobile :' + $('#Txtmymobile').val() + '|';
                json += 'Txtstartemploydate :' + $('#Txtstartemploydate').val() + '|';
                json += 'Cbacademicposition :' + $('#Cbacademicposition').val() + '|';
                json += 'Imgempprofilesrc :' + $('#Imgempprofile').attr('src') + '|';
                json += 'Imgempprofiledat :' + $('#Imgempprofile').attr('data-value') + '|';
                json += 'firstnameTH :' + $('#TxtfirstnameTH').val() + '|';
                json += 'lastnameTH :' + $('#TxtlastnameTH').val() + '|';
                json += 'firstnameEN :' + $('#TxtfirstnameEN').val() + '|';
                json += 'lastnameEN :' + $('#TxtlastnameEN').val() + '|';
                json += 'Cbtitle :' + $('#Cbtitle').val() + '|';
                json += 'Cbgender :' + $('#Cbgender').val() + '|';
                json += 'Txtbirthdate :' + $('#Txtbirthdate').val() + '|';
                json += 'Txtheight :' + $('#Txtheight').val() + '|';
                json += 'Txtweight :' + $('#Txtweight').val() + '|';
                json += 'Cbprovince :' + $('#Cbprovince').val() + '|';
                json += 'Cbblood :' + $('#Cbblood').val() + '|';
                json += 'Cbreligion :' + $('#Cbreligion').val() + '|';
                json += 'Cbrace :' + $('#Cbrace').val() + '|';
                json += 'Cbnation :' + $('#Cbnation').val() + '|';
                json += 'Cbmarystatus :' + $('#Cbmarystatus').val() + '|';
                json += 'Cbnation :' + $('#Cbnation').val() + '|';
                json += 'Txtcardid :' + $('#Txtcardid').val() + '|';
                json += 'Txttaxno :' + $('#Txttaxno').val() + '|';

                json += 'Txtaccountno :' + $('#Txtaccountno').val() + '|';
                json += 'email :' + $('#Txtemail').val() + '|';
                json += 'Txtwebsite :' + $('#Txtwebsite').val() + '|';
                json += 'Txtinterest :' + $('#Txtinterest').val() + '|';
                json += 'Txtmotto :' + $('#Txtmotto').val() + '|';
                json += 'Txtfacebook :' + $('#Txtfacebook').val() + '|';
                json += 'Txtpensiondate :' + $('#Txtpensiondate').val() + '|';
                json += 'Txtcooperative :' + $('#Txtcooperative').val() + '|';

                json += 'TxtaccountnoGHB :' + $('#TxtaccountnoGHB').val() + '|';
                json += 'TxtaccountnoGH :' + $('#TxtaccountnoGH').val() + '|';
                json += 'Txtwelfareshop :' + $('#Txtwelfareshop').val() + '|';
                json += 'Txtcremation :' + $('#Txtcremation').val() + '|';
                json += 'Txtprovidentfund :' + $('#Txtprovidentfund').val() + '|';
                json += 'Txtsocialsecurity :' + $('#Txtsocialsecurity').val() + '|';
                json += 'Txthomephone :' + $('#Txthomephone').val() + '|';
                json += 'Txtworkphone :' + $('#Txtworkphone').val() + '|';
                json += 'Txtmobile :' + $('#Txtmobile').val() + '|';
                json += 'Txtinternalphone :' + $('#Txtinternalphone').val() + '|';
            }
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Save",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != '') {
                        Msgboxsuccess(res);
                        return;
                    }
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Bindeducation();
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Savenewuser() {
            var json = '';
            $('#Sperror').html('');
            if ($('#Txtnewempno').val() == '') {
                $('#Sperror').html('โปรดระบุรหัสบุุคคลากร');
                return;
            }
            if ($('#Txtusername').val() == '') {
                $('#Sperror').html('โปรดระบุ Username');
                return;
            }
            if ($('#Txtfirstnameth').val() == '') {
                $('#Sperror').html('โปรดระบุชื่อ');
                return;
            }
            if ($('#Txtfirstnameth').val() == '') {
                $('#Sperror').html('โปรดระบุนามสกุล');
                return;
            }
            json += 'Txtusername :' + $('#Txtusername').val() + '|';
            json += 'firstnameth :' + $('#Txtfirstnameth').val() + '|';
            json += 'lastnameth :' + $('#Txtlastnameth').val() + '|';
            json += 'newempno :' + $('#Txtnewempno').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Savenewuser",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    setTimeout(() => {
                        Loading();
                    }, 100); 
                    $(".loader").fadeOut("slow");
                    $('#Divnewuser').modal('hide');
                },
                success: function (response) {
                    res = response.d;
                    if (res['Error'] != "") {
                        Msgboxsuccess(res['Error']);
                        Unloading();
                        return;
                    }
                  
                    Edituser(res["Userid"]);
                },
                async: false,
                error: function (er) {
                }
            });
        }

        function Generateempno() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Generateempno",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Txtnewempno').val(res);
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Validateusername() {
            var json = $('#Txtusername').val();
            if ($('#Txtusername').val() == '') {
                Msgboxsuccess('โปรดระบุ Username ก่อน');
                return;
            }
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Validateusername",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != '') {
                        Msgboxsuccess(res);
                        return;
                    }
                    Msgboxsuccess('Username นี้ว่าง สามารถใช้งานได้');
                },
                async: false,
                error: function (er) {
                }
            });
        }

        function Getfield() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getfield",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbfield').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbfield').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbfield').append($('<option/>', {
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
        function Getmanagementposition() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getmanagementposition",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbmanagementposition').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbmanagementposition').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbmanagementposition').append($('<option/>', {
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
        function Getemploytype() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getemploytype",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbemploytype').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbemploytype').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbemploytype').append($('<option/>', {
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
        function Getcurrentstatus() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getcurrentstatus",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbcurrentstatus').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbcurrentstatus').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbcurrentstatus').append($('<option/>', {
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
        function Gettitle() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Gettitle",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbtitle').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbtitle').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbtitle').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                        $('#Cbtitle').on('change', function () {
                            json = $('#Cbtitle').val();
                            $.ajax({
                                type: "POST",
                                url: "\../Page/HR/Emp.aspx/GettitleEN",
                                data: "{'json' :'" + json + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                beforeSend: function () {
                                    $(".loader").fadeOut("slow");
                                },
                                success: function (response) {
                                    res = response.d;
                                    $('#TxttitleEN').val(res);
                                },
                                async: false,
                                error: function (er) {
                                }
                            });
                        });
                    }
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Getmarystatus() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getmarystatus",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbmarystatus').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbmarystatus').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbmarystatus').append($('<option/>', {
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
        function Getnation() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getnation",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbnation').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbnation').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbnation').append($('<option/>', {
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
        function Getrace() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getrace",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbrace').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbrace').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbrace').append($('<option/>', {
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
        function Getreligion() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getreligion",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbreligion').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbreligion').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbreligion').append($('<option/>', {
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
        function Getblood() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getblood",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbblood').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbblood').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbblood').append($('<option/>', {
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
        function Getacademicposition() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getacademicposition",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbacademicposition').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbacademicposition').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbacademicposition').append($('<option/>', {
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
        function Getgender() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getgender",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbgender').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbgender').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbgender').append($('<option/>', {
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
        function Getprovincebyctrl(x) {

            var json = '';
            var ctrls = x.split("|");
            var i = 0;
            var j = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getprovince",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;

                    for (j = 0; j < ctrls.length; j++) {
                        ctrl = ctrls[j];
                        if (ctrl != "") {
                            $('#' + ctrl).find('option').remove().end();

                            if (res.length == 0) {
                                $('#' + ctrl).append($('<option/>', {
                                    value: '',
                                    text: 'ไม่พบหลักสูตร'
                                }));
                            }
                            else {
                                for (i = 0; i < res.length; i++) {
                                    $('#' + ctrl).append($('<option/>', {
                                        value: res[i]["Val"],
                                        text: res[i]["Name"]
                                    }));
                                }
                            }


                        }
                    }
                    for (j = 0; j < ctrls.length; j++) {
                        Getdistrictbyctrl(0, 'Cbaddressdistrict_' + (j + 1));
                        Getsubdistrictbyctrl(0, 'Cbaddresssubdistrict_' + (j + 1));
                        Getpostcodebyctrl(0, 'Cbaddresspostcode_' + (j + 1));
                    }
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Getpostcodebyctrl(subdistrictid, ctrl) {
            var json = subdistrictid;
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getpostcode",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#' + ctrl).find('option').remove().end();

                    if (res.length == 0) {
                        $('#' + ctrl).append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#' + ctrl).append($('<option/>', {
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
        function Getsubdistrictbyctrl(districtid, ctrl) {
            var json = districtid;
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getsubdistrict",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#' + ctrl).find('option').remove().end();

                    if (res.length == 0) {
                        $('#' + ctrl).append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#' + ctrl).append($('<option/>', {
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
        function Getdistrictbyctrl(provinceid, ctrl) {
            var json = provinceid;
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getdistrict",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;

                    $('#' + ctrl).find('option').remove().end();

                    if (res.length == 0) {
                        $('#' + ctrl).append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#' + ctrl).append($('<option/>', {
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

        function Getprovince() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getprovince",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprovince').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprovince').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprovince').append($('<option/>', {
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
        function Newtextbook() {
            ClearResource('TQF/TQF3.aspx', 'Gvsearchtextbook');
            var Cri = $('#HdTQFId').val();
            var Columns = ["Textbook!L"];
            var Data = ["Textbook"];
            var Searchcolumns = ["Textbook!L"];
            var SearchesDat = ["Textbook"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchtextbook', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divtextbookcont').html(Gv._Tables());
            Gv._Bind();
            $('#Divmodaltextbook').modal('show');
        }
        function Back2selectemps() {
            Getuser();
            $('#Divemp').show();
            $('#Divempprofile').hide();
            $('#Hdempid').val('');
        }
        function GetHROPS7(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/GetHROPS7",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d['Error'] != '') {
                        Msgboxsuccess(response.d['Error']);
                        return;
                    }
                    $('#Txtaffairstart').val(response.d["Affairstart"]);
                    $('#Txtstartemploy').val(response.d["Startemploy"]);
                    $('#Cbisinstructor').val(response.d["Isinstructor"]);
                    $('#Txtworkplace').val(response.d["Workplace"]);
                    $('#Txtsalary').val(response.d["Salary"]);
                    $('#Cbfield').val(response.d["Fieldid"]);
                    $('#Cbisreponsiblelab').val(response.d["Isreponsiblelab"]);
                    $('#Cbmanagementposition').val(response.d["Managementpositionid"]);
                    $('#Cbemploytype').val(response.d["Employtypeid"]);
                    $('#Cbcurrentstatus').val(response.d["Currentstatusid"]);
                    $('#Cbisoperate').val(response.d["Isoperate"]);
                    
                },
                async: false,
                error: function (er) {
                    Msgboxsuccess(er.Marystatus);
                }
            });
        }


        function Getempinfo(x) {
            var json = x;
            $('#Loader').fadeIn("slow");
            
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getempinfo",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    
                  
                    Gettitle();
                    Getmarystatus();
                    Getreligion();
                    Getblood();
                    Getprovince();
                    Getacademicposition();
                    Getgender();
                    Getnation();
                    Getrace();
                    Getfield();
                    Getmanagementposition();
                    Getemploytype();
                    Getcurrentstatus();
                    //GetHROPS7(x);
                },
               
                success: function (response) {
                    if (response.d['Error'] != '') {
                        Msgboxsuccess(response.d['Error']);
                        return;
                    }
                    if (response.d['InsExtra'] == "1") {
                        $('#ChkInsE').prop("checked", true)
                    }
                    else {
                        $('#ChkInsE').prop("checked", false)
                    }
                    if (response.d['InsRegular'] == "1") {
                        $('#ChkInsR').prop("checked", true)
                    }
                    else {
                        $('#ChkInsR').prop("checked", false)
                    }
                    if (response.d['InsTheory'] == "1") {
                        $('#ChkInsT').prop("checked", true)
                    }
                    else {
                        $('#ChkInsT').prop("checked", false)
                    }
                    $('#Txtprofileusername').val(response.d['Username']);
                    $('#Txtmymobile').val(response.d['Mymobile']);
                    $('#Txtempno').val(response.d["Empno"]);
                    $('#Txtstartemploydate').val(response.d["Startemploydate"]);
                    $('#Cbacademicposition').val(response.d["Academicpositionid"]);
                    if (response.d['Imgempprofile'] == null || response.d['Imgempprofile'] == '') {
                        $('#Imgempprofile').attr('data-value', '0');
                        $('#Imgempprofile').attr('src', "../../E-OFFICEPI/Image/DefaultUser.png");
                    }
                    else {
                        $('#Imgempprofile').attr('data-value', response.d["Attachmentid"]);
                        $('#Imgempprofile').attr('src', response.d["Imgempprofile"]);
                    }
                    $('#Cbtitle').val(response.d["Titleid"]);
                    $.ajax({
                        type: "POST",
                        url: "\../Page/HR/Emp.aspx/GettitleEN",
                        data: "{'json' :'" + response.d["Titleid"] + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        beforeSend: function () {
                            $(".loader").fadeOut("slow");
                        },
                        success: function (response) {
                            res = response.d;
                            $('#TxttitleEN').val(res);
                        },
                        async: false,
                        error: function (er) {
                        }
                    });
                    $('#TxtfirstnameTH').val(response.d["FirstnameTH"]);
                    $('#TxtlastnameTH').val(response.d["LastnameTH"]);
                    $('#TxtfirstnameEN').val(response.d["FirstnameEN"]);
                    $('#TxtlastnameEN').val(response.d["LastnameEN"]);
                    $('#Cbgender').val(response.d["Genderid"]);
                    $('#Txtbirthdate').val(response.d["Birthdate"]);
                    $('#Txtheight').val(response.d["Height"]);
                    $('#Txtweight').val(response.d["Weight"]);
                    $('#Cbprovince').val(response.d["Provinceid"]);
                    $('#Cbblood').val(response.d["Bloodid"]);
                    $('#Cbreligion').val(response.d["Religionid"]);
                    $('#Cbrace').val(response.d["Raceid"]);
                    $('#Cbnation').val(response.d["Nationid"]);
                    $('#Cbmarystatus').val(response.d["Marystatusid"]);
                    $('#Txtcardid').val(response.d["Cardid"]);
                    $('#Txttaxno').val(response.d["Taxno"]);
                    $('#Txtaccountno').val(response.d["Accountno"]);
                    $('#Txtemail').val(response.d["Email"]);
                    $('#Txtwebsite').val(response.d["Website"]);
                    $('#Txtinterest').val(response.d["Interest"]);
                    $('#Txtmotto').val(response.d["Motto"]);
                    $('#Txtfacebook').val(response.d["Facebook"]);
                    $('#Txtpensiondate').val(response.d["PensionDate"]);
                    $('#Txtcooperative').val(response.d["Cooperative"]);
                    $('#TxtaccountnoGHB').val(response.d["AccountnoGHB"]);
                    $('#TxtaccountnoGH').val(response.d["AccountnoGH"]);
                    $('#Txtwelfareshop').val(response.d["Welfareshop"]);
                    $('#Txtcremation').val(response.d["Cremation"]);
                    $('#Txtprovidentfund').val(response.d["Providentfund"]);
                    $('#Txtsocialsecurity').val(response.d["Socialsecurity"]);
                    //$('#Txthomephone').val(response.d["Homephone"]);
                    //$('#Txtworkphone').val(response.d["Workphone"]);
                    //$('#Txtmobile').val(response.d["Mobile"]);
                    //$('#Txtinternalphone').val(response.d["Internalphone"]);
                    Getaddress();
                    Bindeducation();
                    Bindprofession();
                    Bindprofessioncouncil();
                    Bindexpertise();
                    Bindinsignia();
                    Bindpromote();
                    Getleaves();
                },
                async: false,
                complete: function () {
                    $('#Loader').fadeOut("slow");


                },

                error: function (er) {
                    Msgbox(er);
                }
            });
        }
        function Edituser(x) {
            $('#Divemp').hide();
            $('#Divempprofile').show();
            $('#Hdempid').val(x);
     
            Getempinfo(x);
           
            
            
        }
        function Adduser() {
            $('#Sperror').html('');
            $('#Divnewuser').modal('show');
        }
        function Resetpass(x) {
            var html = '';
            var json = '';
            var userid = '';

            $("#DivConfirm").modal('show');
            $('#DivConfirmMsg').html('คุณต้องการตั้งรหัสผ่านท่านนี้เป็นรหัสกลาง (p@ssw0rd)');
            $('#CmdConfirm').on('click', function () {
                json = 'x :' + x + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/HR/Emp.aspx/Resetpass",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        Msgboxsuccess('Password is reset to p@ssw0rd ');
                        $("#DivConfirm").modal('hide');
                        Getuser();
                    },
                    async: false,
                    error: function (er) {
                        Msgboxsuccess(er.Marystatus);
                    }
                });
            });
        }
        function Deleteuser(x) {



            $("#DivConfirm").modal('show');
            $('#DivConfirmMsg').html('คุณต้องการลบบุคลากรท่านนี้ ?');

            $('#CmdConfirm').on('click', function () {
                var html = '';
                var json = '';
                var userid = '';
                json = 'x :' + x + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/HR/Emp.aspx/Deleteuser",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#DivConfirm").modal('hide');
                        Msgboxsuccess('ลบบุคลากรท่านนี้เรียบร้อยแล้ว');
                        Getuser();

                    },
                    async: false,
                    error: function (er) {
                        Msgboxsuccess(er.Marystatus);
                    }
                });
            });



        }
        function Getuser() {
            var html = '';
            var json = '';
            var userid = '';
          
            json = 'Txtusersearch :' + $('#Txtusersearch').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/Emp.aspx/Getuser",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $('#Loader').fadeIn('slow');
                },
                success: function (response) {
                  
                    if (response.d.length > 0) {
                        for (i = 0; i < response.d.length; i++) {
                            userid = response.d[i]['userid'];
                            html += ' <div class="col-lg-6 col-md-12 col-xs-12 col-sm-12" >';
                            html += ' <div class="container" style="border:dashed 1px gray;padding:10px;margin:10px;min-height:100px;font-size:1em;">';
                            html += ' <div class="row">';
                            html += ' <div class="col-4" style="text-align:center;">';

                            if (response.d[i]['avartarurl'] == null || response.d[i]['avartarurl'] == '') {
                                html += ' <img src="../../E-OFFICEPI/Image/DefaultUser.png"  style="width:150px;margin-top:20px;" />';
                            }
                            else {
                                html += ' <img src="' + response.d[i]['avartarurl'] + '"  style="width:150px;margin-top:20px;" />';
                            }
                            html += ' </div>';
                            html += ' <div class="col-8" style="font-size:18px;">';
                            html += ' <div class="row">';
                            html += ' <div class="col-12" style="text-align:right;">';
                            html += ' <span style="border-raduis:2px;border:1px solid lightgray;padding-top:2px;padding-bottom:2px;padding-left:5px;padding-right:5px;font-size:20px;cursor:pointer;color:orange;background-color:lightgray;" onclick="Resetpass(' + userid + ');"><i class="fa fa-key"></i></span>&nbsp;';
                            html += ' <span style="border-raduis:2px;border:1px solid lightgray;padding-top:2px;padding-bottom:2px;padding-left:5px;padding-right:5px;font-size:20px;cursor:pointer;color:green;background-color:lightgray;" onclick="Edituser(' + userid + ');"><i class="fa fa-pencil-square-o"></i></span>&nbsp;';
                            html += ' <span style="border-raduis:2px;border:1px solid lightgray;padding-top:2px;padding-bottom:2px;padding-left:5px;padding-right:5px;font-size:20px;cursor:pointer;color:red;background-color:lightgray;"  onclick="Deleteuser(' + userid + ');"><i class="fa fa-trash-o"></i></span>';
                            html += ' </div>';
                            html += ' </div>';
                            html += ' <div class="row">';
                            html += ' &nbsp;';
                            html += ' </div>';
                            html += ' <div class="row">';
                            html += ' &nbsp;';
                            html += ' </div>';
                            html += ' <div class="row mt-1">';
                            html += ' <div class="col-5">';
                            html += ' <div style="margin-top:5px;font-size:18px;color:blue;">Username</div>';
                            html += ' </div>';
                            html += ' <div class="col-7">';
                            html += ' <span id="Spname" style="margin-top:5px;font-size:18px;color:blue;">' + response.d[i]['username'] +  '</span>';
                            html += ' </div>';
                            html += ' </div>';

                            html += ' <div class="row mt-1">';
                            html += ' <div class="col-12">';
                            html += ' <hr>';
                            html += ' </div>';
                            html += ' </div>';

                            html += ' <div class="row mt-1">';
                            html += ' <div class="col-5">';
                            html += ' <div style="margin-top:5px;">รหัสบุุคคลากร</div>';
                            html += ' </div>';
                            html += ' <div class="col-7">';
                            html += ' <span id="Spname">' + response.d[i]['Empno'] + '</span>';
                            html += ' </div>';
                            html += ' </div>';
                            html += ' <div class="row mt-1">';
                            html += ' <div class="col-5">';
                            html += ' <div style="margin-top:5px;">ชื่อ - นามสกุล</div>';
                            html += ' </div>';
                            html += ' <div class="col-7">';
                            html += ' <span id="Spname">' + response.d[i]['titlenameth'] + ' ' + response.d[i]['firstnameth'] + ' ' + response.d[i]['lastnameth'] + '</span>';
                            html += ' </div>';
                            html += ' </div>';
                            html += ' <div class="row mt-1">';
                            html += ' <div class="col-5">';
                            html += ' <div style="margin-top:5px;">อีเมล</div>';
                            html += ' </div>';
                            html += ' <div class="col-7">';
                            html += ' <span id="Spemail">' + response.d[i]['email'] + '</span>';
                            html += ' </div>';
                            html += ' </div>';
                            html += ' <div class="row mt-1">';
                            html += ' <div class="col-5">';
                            html += ' <div style="margin-top:5px;">เบอร์โทร</div>';
                            html += ' </div>';
                            html += ' <div class="col-7">';
                            html += ' <span id="Sptel">' + response.d[i]['Mymobile'] + '</span>';
                            html += ' </div>';
                            html += ' <div class="col-12">';
                            html += ' <hr>';
                            html += ' </div>';
                            html += ' <div class="col-12" style=""text-align:center;>';
                            html += ' <div style="min-height:50px;" >';
                            html += ' </div>';
                            //html += ' <button class="btn btn-primary" style="width:80%;font-size:1em;margin:5px;" onclick="Resetpass(' + userid + ');">Reset Password</button>';
                            html += ' </div>';
                            html += ' </div>';
                            html += ' </div>';
                            html += ' </div>';
                            html += ' </div>';
                            html += ' </div>';
                        }
                    }
                    else {
                        html += ' <div class="col-12"><div style="text-align:center;color:red;min-height:200px;margin-top:50px;font-size:16px;">ไม่พบข้อมูล</div>';
                        html += ' </div>';
                    }

                    $('#Divusers').html(html);
                   
                   
                },
                async: true,
                complete: function () {
                    $('#Loader').fadeOut("slow");
                   
                  
                },
                error: function (er) {
                    waitingDialog.hide();
                    Msgbox(er);
                }
            });

        }

        $(function () {
            Getuser();
            $('#Cbleavecat').on('change', function () {
                if ($('#Cbleavecat').val() == 'F') {
                    $('#Divfulltime').show();
                    $('#Divparttime').hide();
                }
                else {
                    $('#Divfulltime').hide();
                    $('#Divparttime').show();
                }
            })
            $('#Cmdsearch').on('click', function () {
                Getuser();
            });
            $("#Txtaffairstart").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtstartemploy").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
          
            $("#Txtprofessioncouncilstart").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtprofessioncouncilstop").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtprofessionstart").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtprofessionstop").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txteducationstart").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txteducationstop").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            
            $("#Txteffectdate").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            $("#Txtinsigniaanouncedate").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtbirthdate").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtstartemploydate").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            }); 
            $("#Txtpensiondate").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            $("#Txtstartleave").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            $("#Txtstopleave").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtpartleave").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

        });
    </script>
</head>
<body>
    <div id="Divemp" style="display: block; margin-top: 50px; color: black;">
        <div class="container-fluid" style="font-family: TH SarabunPSK; background-color: white; padding: 10px; width: 95%; min-height: 800px;">
            <div class="row">
                <div class="col-9">
                    <button class="btn btn-secondary" onclick="Adduser();" style="margin: 10px; border-radius: 2px;"><span style="font-size: 18px; color: white;">เพิ่มบุคลากรใหม่</span></button>
                </div>
                <div class="col-3">
                    <div class="input-group mb-3">
                        <input id="Txtusersearch" type="text" class="form-control" placeholder="รหัสบุุคคลากร,ชื่อบุุคคลากร" style="width: 100px; border-radius: 1px; font-size: 18px;">
                        <div class="input-group-append">
                            <button id="Cmdsearch" class="btn btn-info" type="button" onclick="Getuser();">
                                <i class="fa fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="container-fluid">
                    <div class="col-12">
                        <hr />
                    </div>
                </div>
            </div>
            <div class="row" id="Divusers" style="padding: 30px;">
            </div>
        </div>


    </div>

    <div id="Divempprofile" class="container-fluid" style="font-size: 18px; display: none; font-family: TH SarabunPSK; background-color: white; padding: 10px; width: 95%; min-height: 300px; margin-top: 50px; margin-bottom: 50px;">
        <input type="hidden" id="Hdempid" value="" />
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav" style="color: black !important; font-family: TH SarabunPSK;">

                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="Back2selectemps();">กลับสู่หน้าจอบุคลากรงาน</a>
                    </li>
                </ul>
            </div>
        </nav>
        <ul class="nav nav-tabs" style="margin: 20px;">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#menu1">ข้อมูลส่วนตัว</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#menu2">ที่อยู่</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#menu3">การศึกษา</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#menu4">วิชาชีพ</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#menu5">สมาชิกสภาวิชาชีพ</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#menu6">ความชำนาญ</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#menu7">กพ.7</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#menu8">ตำแหน่ง & เงินเดือน</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#menu9">เครื่องราชอิสริยาภรณ์</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#menu10">การลา</a>
            </li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">

            <div id="menu1" class="container tab-pane active">
                <div class="container-fluid" style="font-size: 18px; color: black;">
                    <div class="row mt-1">
                        <div class="col-12">
                            <button class="btn btn-info" style="border-radius: 1px;" onclick="Save('1');">บันทึก</button>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <hr />
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-9">
                            <div class="container">
                                 <div class="row mt-3">
                                    <div class="col-3">
                                        รหัสผู้ใช้งาน
                                    </div>
                                    <div class="col-9">
                                        <div class="input-group mb-3">
                                            <input id="Txtprofileusername" type="text" class="form-control" readonly="readonly" />
                                        </div>

                                    </div>

                                </div>
                                <div class="row mt-3">
                                    <div class="col-3">
                                        รหัสบุุคคลากร
                                    </div>
                                    <div class="col-9">
                                        <div class="input-group mb-3">
                                            <input id="Txtempno" type="text" class="form-control" readonly="readonly" />
                                        </div>

                                    </div>

                                </div>
                                <div class="row mt-3">
                                    <div class="col-3">
                                        วันที่บรรจุเข้าทำงาน
                                    </div>
                                    <div class="col-9">

                                        <div id="Dtpstartemploydate" class="input-group date" data-date-format="mm-dd-yyyy">
                                            <input id="Txtstartemploydate" class="form-control" type="text" />
                                            <button>
                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-3">
                                        ตำแหน่งทางวิชาการ
                                    </div>
                                    <div class="col-9">
                                        <select id="Cbacademicposition" class="form-control"></select>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-3">
                                        เบอร์โทรศัพท์ที่ติดต่อได้
                                    </div>
                                    <div class="col-9">
                                        <input type="text" class="form-control" id="Txtmymobile" />
                                    </div>
                                </div>
                                  <div class="row mt-3">
                                    <div class="col-3">
                                        สถานะการเป็นอาจารย์
                                    </div>
                                    <div class="col-9">
                                        <div class="input-group mb-3">
                                            <input type="checkbox" id="ChkInsR" onclick="ChangeIns('ChkInsR','R')" />&nbsp;<span>อาจารย์ผู้รับผิดชอบรายวิชา</span>&nbsp;&nbsp;
                                            <input type="checkbox" id="ChkInsT" onclick="ChangeIns('ChkInsT', 'T')" />&nbsp;<span>อาจารย์ภาคทฤษฎี</span>&nbsp;&nbsp;
                                            <input type="checkbox" id="ChkInsE" onclick="ChangeIns('ChkInsE', 'E')" />&nbsp;<span>อาจารย์สอนภาคปฏิบัติ</span>&nbsp;&nbsp;
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-3" style="text-align: center;">
                            <img id="Imgempprofile" onclick="CallUpload('Imgempprofile','img');" style="width: 120px;cursor:pointer; border: solid 1px gray;" src="../../E-OFFICEPI/Image/DefaultUser.png" />
                            <div style="margin-top: 10px;">กดที่รูปภาพเพื่อ Upload</div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-12">
                            <hr />
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="container">
                            <div class="row mt-3">
                                <div class="col-2">
                                    ชื่อ-สกุล (ไทย)
                                </div>
                                <div class="col-10">
                                    <div class="input-group mb-3">
                                        <select id="Cbtitle" class="form-control">
                                        </select>
                                        &nbsp;<input id="TxtfirstnameTH" type="text" class="form-control" />
                                        &nbsp;<input id="TxtlastnameTH" type="text" class="form-control" />
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    ชื่อ-สกุล (ภาษาอังกฤษ)
                                </div>
                                <div class="col-10">
                                    <div class="input-group mb-3">
                                        <input id="TxttitleEN" type="text" class="form-control" readonly="readonly" />
                                        &nbsp;<input id="TxtfirstnameEN" type="text" class="form-control" />
                                        &nbsp;<input id="TxtlastnameEN" type="text" class="form-control" />
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    เพศ
                                </div>
                                <div class="col-2">
                                    <select class="form-control" id="Cbgender">
                                    </select>
                                </div>
                                <div class="col-1" style="text-align: right;">
                                    วันเกิด
                                </div>
                                <div class="col-3">

                                    <div id="Dtpbirthdate" class="input-group date" data-date-format="mm-dd-yyyy">
                                        <input id="Txtbirthdate" class="form-control" type="text" />
                                        <button>
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-1" style="text-align: right;">
                                    ส่วนสูง
                                </div>
                                <div class="col-1">
                                    <input id="Txtheight" type="text" class="form-control" />
                                </div>
                                <div class="col-1" style="text-align: right;">
                                    น้ำหนัก
                                </div>
                                <div class="col-1">
                                    <input id="Txtweight" type="text" class="form-control" />
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-12">
                                    <hr />
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    จังหวัดที่เกิด
                                </div>
                                <div class="col-4">
                                    <select id="Cbprovince" class="form-control">
                                    </select>
                                </div>
                                <div class="col-2" style="text-align: right;">
                                    หมู่เลือด
                                </div>
                                <div class="col-4">
                                    <select id="Cbblood" class="form-control">
                                    </select>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    ศาสนา
                                </div>
                                <div class="col-4">
                                    <select id="Cbreligion" class="form-control">
                                    </select>
                                </div>
                                <div class="col-2" style="text-align: right;">
                                    เชื้อชาติ
                                </div>
                                <div class="col-4">
                                    <select id="Cbrace" class="form-control">
                                    </select>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    สัญชาติ
                                </div>
                                <div class="col-4">
                                    <select id="Cbnation" class="form-control">
                                    </select>
                                </div>
                                <div class="col-2" style="text-align: right;">
                                    สถานภาพ
                                </div>
                                <div class="col-4">
                                    <select id="Cbmarystatus" class="form-control">
                                    </select>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-12">
                                    <hr />
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    เลขที่บัตรประชาชน
                                </div>
                                <div class="col-4">
                                    <input id="Txtcardid" type="text" maxlength="13" class="form-control" />
                                </div>
                                <div class="col-2" style="text-align: right;">
                                    เลขที่ผู้เสียภาษี
                                </div>
                                <div class="col-4">
                                    <input id="Txttaxno" type="text" class="form-control" />
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    บัญชีเลขที่
                                </div>
                                <div class="col-4">
                                    <input id="Txtaccountno" type="text" maxlength="13" class="form-control" />
                                </div>
                                <div class="col-2" style="text-align: right;">
                                    คติประจำใจ
                                </div>
                                <div class="col-4">
                                    <input id="Txtmotto" type="text" class="form-control" />
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    ความสนใจ
                                </div>
                                <div class="col-4">
                                    <input id="Txtinterest" type="text" maxlength="13" class="form-control" />
                                </div>
                                <div class="col-2" style="text-align: right;">
                                    E-mail
                                </div>
                                <div class="col-4">
                                    <input id="Txtemail" type="text" class="form-control" />
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    Website
                                </div>
                                <div class="col-4">
                                    <input id="Txtwebsite" type="text" maxlength="13" class="form-control" />
                                </div>
                                <div class="col-2" style="text-align: right;">
                                    Facebook
                                </div>
                                <div class="col-4">
                                    <input id="Txtfacebook" type="text" class="form-control" />
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-12">
                                    <hr />
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    ก.บ.ข. วันที่สมัคร
                                </div>
                                <div class="col-4">
                                    <input id="Txtpensiondate" type="text" class="form-control" />
                                </div>
                                <div class="col-2" style="text-align: right;">
                                    เลขที่สหกรณ์
                                </div>
                                <div class="col-4">
                                    <input id="Txtcooperative" type="text" class="form-control" />
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    เลขที่บัญชี (ธอส)
                                </div>
                                <div class="col-4">
                                    <input id="TxtaccountnoGHB" type="text" class="form-control" />
                                </div>
                                <div class="col-2" style="text-align: right;">
                                    เลขที่บัญชี (ออมสิน)
                                </div>
                                <div class="col-4">
                                    <input id="TxtaccountnoGH" type="text" class="form-control" />
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    เลขที่ร้านค้าสวัสดิการ
                                </div>
                                <div class="col-4">
                                    <input id="Txtwelfareshop" type="text" class="form-control" />
                                </div>
                                <div class="col-2" style="text-align: right;">
                                    เลขที่ ฌกส.
                                </div>
                                <div class="col-4">
                                    <input id="Txtcremation" type="text" class="form-control" />
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-2">
                                    เลขที่ กสจ.
                                </div>
                                <div class="col-4">
                                    <input id="Txtprovidentfund" type="text" class="form-control" />
                                </div>
                                <div class="col-2" style="text-align: right;">
                                    เลขที่ประกันสังคม
                                </div>
                                <div class="col-4">
                                    <input id="Txtsocialsecurity" type="text" class="form-control" />
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-12">
                                    &nbsp;
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="menu2" class="container tab-pane fade">
                <div class="row mt-1">
                        <div class="col-12">
                            <button class="btn btn-info" style="border-radius: 1px;" onclick="Save('2');">บันทึก</button>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <hr />
                        </div>
                    </div>
                <div id="Divaddress">
                </div>
            </div>
            <div id="menu3" class="container tab-pane fade">
                <div id="Diveducation">
                </div>
            </div>
            <div id="menu4" class="container tab-pane fade">
                <div id="Divprofession">
                </div>
            </div>
            <div id="menu5" class="container tab-pane fade">
                <div id="Divprofessioncouncil">
                </div>
            </div>
            <div id="menu6" class="container tab-pane fade">
                <div id="Divexpertise">
                </div>
            </div>
            <div id="menu7" class="container tab-pane fade">
                 <div class="container-fluid" style="font-size: 18px; color: black;padding-bottom:50px;">
                    <div class="row mt-1">
                        <div class="col-12">
                            <button class="btn btn-info" style="border-radius: 1px;" onclick="Save('7');">บันทึก</button>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <hr />
                        </div>
                    </div>
                   
                   
                    <div class="row mt-3">
                        <div class="container">
                            <div class="row mt-3">
                                    <div class="col-3">
                                        วันที่บรรจุเข้ารับราชการครั้งแรก
                                    </div>
                                    <div class="col-9">
                                       <div id="Dtpaffairstart" class="input-group date" data-date-format="mm-dd-yyyy">
                                            <input id="Txtaffairstart" class="form-control" type="text" />
                                            <button>
                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                            </button>
                                        </div>

                                    </div>

                                </div>
                                <div class="row mt-3">
                                    <div class="col-3">
                                        วันที่เริ่มปฏิบัติงานที่ สบช./วิทยาลัย
                                    </div>
                                    <div class="col-9">

                                          <div id="Dtpstartemploy" class="input-group date" data-date-format="mm-dd-yyyy">
                                            <input id="Txtstartemploy" class="form-control" type="text" />
                                            <button>
                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                            </button>
                                        </div>



                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-3">
                                       เป็นอาจารย์พยาบาลประจำ
                                    </div>
                                    <div class="col-9">
                                        <select id="Cbisinstructor" class="form-control">
                                            <option value="True">ใช่</option>
                                            <option value="False">ไม่ใช่</option>
                                        </select>
                                    </div>
                                </div>
                           
                            <div class="row mt-3">
                                <div class="col-3">
                                    สถานที่ปฏิบัติงานจริง
                                </div>
                                <div class="col-9">
                                   <input type="text" class="form-control" id="Txtworkplace" />
                                </div>
                                 </div>
                            <div class="row mt-3">
                                <div class="col-3" >
                                    เงินเดือน
                                </div>
                                <div class="col-3">
                                   <input type="text" class="form-control" id="Txtsalary" />
                                </div>
                                  <div class="col-3" style="text-align: right;">
                                    ประเภทสายงาน
                                </div>
                                <div class="col-3">
                                  <select id="Cbfield" class="form-control"></select>
                                </div>
                             </div>
                            <div class="row mt-3">
                                <div class="col-3" >
                                    รับผิดชอบห้องปฎิบัติการ
                                </div>
                                <div class="col-3">
                                      <select id="Cbisreponsiblelab" class="form-control">
                                            <option value="True">ใช่</option>
                                            <option value="False">ไม่ใช่</option>
                                        </select>
                                </div>
                                  <div class="col-3" style="text-align: right;">
                                    ตำแหน่งบริหาร
                                </div>
                                <div class="col-3">
                                  <select id="Cbmanagementposition" class="form-control"></select>
                                </div>
                             </div>
                            <div class="row mt-3">
                                <div class="col-3">
                                   ประเภทบุคลากร
                                </div>
                                <div class="col-3">
                                    <select id="Cbemploytype" class="form-control">
                                    </select>
                                </div>
                                <div class="col-3" style="text-align: right;">
                                   สถานะปัจจุบัน
                                </div>
                                <div class="col-3">
                                    <select id="Cbcurrentstatus" class="form-control">
                                    </select>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-3">
                                   สถานะการปฏิบัติงาน
                                </div>
                                <div class="col-9">
                                    <select id="Cbisoperate" class="form-control">
                                        <option value="True">ปฏิบัติงานอยู่</option>
                                        <option value="False">ออกไปแล้ว</option>
                                    </select>
                                </div>
                            </div>
                          
                        </div>
                    </div>
                </div>
            </div>
            <div id="menu8" class="container tab-pane fade">
                <div id="Divpromote">
                </div>
            </div>
            <div id="menu9" class="container tab-pane fade">
                <div id="Divinsignia">
                </div>
            </div>
            <div id="menu10" class="container tab-pane fade">
                <div id="Divleaves">

                </div>
            </div>
        </div>


    </div>


    <div class="modal" id="Divmodalprofessioncouncil" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 18px; font-family: TH SarabunPSK;">
            <div class="modal-content">
                <div class="modal-header">
                    <span>ใบวิชาชีพ</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <input type="hidden" id="Hdprofessioncouncilid" value="" />
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วิชาชีพ</span>
                            </div>
                            <div class="col-9">
                                <select class="form-control" id="Cbprofessioncouncil"></select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>เลขที่ใบประกอบวิชาชีพ</span>
                            </div>
                            <div class="col-9">
                                <input type="text" id="Txtprofessioncouncilno" class="form-control" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วันที่ออกบัตร</span>

                            </div>
                            <div class="col-3">
                                <div id="Dtpprofessioncouncilstart" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtprofessioncouncilstart" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-2">
                                <span>วันที่บัตรหมดอายุ</span>
                            </div>
                            <div class="col-3">
                                <div id="Dtpprofessioncouncilstop" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtprofessioncouncilstop" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="Saveprofessioncouncil();" class="btn btn-primary" style="border-radius: 2px; font-size: 18px;">บันทึก</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="Divmodaleducation" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 18px; font-family: TH SarabunPSK;">
            <div class="modal-content">
                <div class="modal-header">
                    <span></span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <input type="hidden" id="Hdeducationid" value="" />
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ระดับการศึกษา</span>
                            </div>
                            <div class="col-9">
                                <select class="form-control" id="Cbdegree"></select>
                            </div>
                        </div>



                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วุฒิการศึกษา</span>
                            </div>
                            <div class="col-9">
                                <select class="form-control" id="Cbeducation"></select>
                            </div>
                        </div>



                        <div class="row mt-3">
                            <div class="col-3">
                                <span>สาขาวิชา</span>

                            </div>
                            <div class="col-9">
                                <select class="form-control" id="Cbmajor"></select>
                            </div>
                        </div>


                        <div class="row mt-3">
                            <div class="col-3">
                                <span>สถานศึกษา</span>

                            </div>
                            <div class="col-9">
                                <select class="form-control" id="Cbacademy"></select>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ประเทศ</span>

                            </div>
                            <div class="col-9">
                                <select class="form-control" id="Cbcountry"></select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วันที่เริ่มศึกษา</span>

                            </div>
                            <div class="col-3">
                                <div id="Dtpeducationstart" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txteducationstart" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-2">
                                <span>วันที่จบศึกษา</span>
                            </div>
                            <div class="col-3">
                                <div id="Dtpeducationstop" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txteducationstop" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>

                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วุฒิสูงสุดด้านวิชาชีพ</span>

                            </div>
                            <div class="col-9">
                                <input type="text" class="form-control" id="Txtstartemployprofessionname" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>เป็นวุฒิสูงสุด</span>
                            </div>
                            <div class="col-9">
                                <select class="form-control" id="Cbismaxeducation">
                                    <option value="True">ใช่</option>
                                    <option value="False">ไม่ใช่</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ใช้เข้ารับราชการครั้งแรก</span>
                            </div>
                            <div class="col-9">
                                <select class="form-control" id="Cbisuseforstartaffair">
                                    <option value="True">ใช่</option>
                                    <option value="False">ไม่ใช่</option>
                                </select>
                            </div>
                        </div>

                          <div class="row mt-3">
                            <div class="col-3">
                                
                            </div>
                            <div class="col-9">
                               <div class="input-group">
                                   <span>เป็นวุฒิพยาบาล</span>
                                   &nbsp;
                                   <input type="checkbox" id="Chkisnurse" />
                               </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="Saveeducation();" class="btn btn-primary" style="border-radius: 2px; font-size: 18px;">บันทึก</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="Divmodalexpertise" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 18px; font-family: TH SarabunPSK;">
            <div class="modal-content">
                <div class="modal-header">
                    <span>ใบวิชาชีพ</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <input type="hidden" id="Hdexpertiseid" value="" />
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>เรื่อง</span>
                            </div>
                            <div class="col-9">
                                <input type="text" id="Txtexpertisetopic" class="form-control" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ประเด็นสำคัญ	</span>
                            </div>
                            <div class="col-9">
                                <textarea id="Txtexpertiseremark" class="form-control" style="height: 100px;"></textarea>
                            </div>
                        </div>

                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="Saveexpertise();" class="btn btn-primary" style="border-radius: 2px; font-size: 18px;">บันทึก</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="Divmodalprofession" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 18px; font-family: TH SarabunPSK;">
            <div class="modal-content">
                <div class="modal-header">
                    <span>ใบวิชาชีพ</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <input type="hidden" id="Hdprofessionid" value="" />
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วิชาชีพ</span>
                            </div>
                            <div class="col-9">
                                <select class="form-control" id="Cbprofession"></select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>เลขที่ใบประกอบวิชาชีพ</span>
                            </div>
                            <div class="col-9">
                                <input type="text" id="Txtprofessionno" class="form-control" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วันที่ออกบัตร</span>

                            </div>
                            <div class="col-3">
                                <div id="Dtpprofessionstart" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtprofessionstart" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-2">
                                <span>วันที่บัตรหมดอายุ</span>
                            </div>
                            <div class="col-3">
                                <div id="Dtpprofessionstop" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtprofessionstop" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="Saveprofession();" class="btn btn-primary" style="border-radius: 2px; font-size: 18px;">บันทึก</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal fade bd-example-modal-lg" id="Divnewuser" tabindex="-1" role="dialog" style="z-index: 99999;" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-ku" role="document">

            <div class="modal-content" style="width: 500px;">
                <div class="modal-header" style="background-color: #82c2f3;">
                    <span style="font-size: 18px;">E-OFFICE สถาบันพระบรมราชชนก </span>
                </div>
                <div class="modal-body">
                    <div class="container" style="font-size: 18px; margin-top: 20px;">

                        <div class="row">
                            <div class="col-3" style="text-align: right;">
                                รหัสบุุคคลากร<span style="color: red;">*</span>
                            </div>
                              <div class="col-9">
                             <div class="input-group mb-3">
                                <input id="Txtnewempno" type="text" class="form-control" placeholder="รหัสบุุคคลากร" />
                                <div class="input-group-append">
                                    <button type="button" onclick="Generateempno();" class="btn btn-info" style="border-radius: 2px; font-size: 18px; width: 100%;">สร้างรหัส</button>
                                </div>

                            </div>
                                  </div>
                        </div>

                        <div class="row">
                            <div class="col-3" style="text-align: right;">
                                Username&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-9">


                                <div class="input-group mb-3">
                                    <input style="font-size: 18px;" type="email" id="Txtusername" autocomplete="off" class="form-control" placeholder="Username">

                                    <div class="input-group-append">
                                        <button type="button" onclick="Validateusername();" class="btn btn-danger" style="border-radius: 2px; font-size: 18px; width: 100%;">ตรวจสอบ</button>
                                    </div>
                                </div>
                                <div class="invalid-feedback">
                                    โปรดระบุ Username
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-3" style="text-align: right;">
                                ชื่อ &nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-9">
                                <div class="form-group" style="text-align: left;">
                                    <input type="text" id="Txtfirstnameth" autocomplete="off" class="form-control" placeholder="ชื่อ">
                                    <div class="invalid-feedback">
                                        โปรดระบุ ชื่อ
                                    </div>
                                </div>
                            </div>
                            <div class="col-3" style="text-align: right;">
                                นามสกุล &nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-9">
                                <div class="form-group" style="text-align: left;">
                                    <input type="text" id="Txtlastnameth" autocomplete="off" class="form-control" placeholder="นามสกุล">
                                    <div class="invalid-feedback">
                                        โปรดระบุ นามสกุล
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-3">
                              
                            </div>
                            <div class="col-9">
                                <span id="Sperror"  style="color:red;font-size:18px;font-family:TH SarabunPSK;"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="min-height: 50px; margin-top: 10%; font-size: 18px;"></div>
                <div class="modal-footer">
                    <button type="button" onclick="Savenewuser();" class="btn btn-secondary" style="border-radius: 2px; font-size: 18px;">บันทึกบุคลากรใหม่</button>
                    <button type="button" class="btn btn-danger" style="border-radius: 2px; font-size: 18px;" data-dismiss="modal">ปิดหน้าต่างนี้</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="Divmodalinsignia" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 18px; font-family: TH SarabunPSK;">
            <div class="modal-content">
                <div class="modal-header">
                    <span>เครื่องราชอิสริยาภรณ์</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <input type="hidden" id="Hdinsigniaid" value="" />
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชั้นเครื่องราชอิสริยาภรณ์</span>
                            </div>
                            <div class="col-9">
                                <select class="form-control" id="Cbinsignia"></select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ปี</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="Txtinsigniayearno" class="form-control" />
                            </div>
                            <div class="col-3">
                                <span>เล่มที่</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="Txtinsigniabookno" class="form-control" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ตอนที่</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="Txtinsigniaparagraphno" class="form-control" />
                            </div>
                            <div class="col-3">
                                <span>หน้าที่</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="Txtinsigniapageno" class="form-control" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ลำดับ</span>
                            </div>
                            <div class="col-9">
                                <input type="text" class="form-control" id="Txtinsigniaorderno" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วันที่ประกาศ</span>

                            </div>
                            <div class="col-3">
                                <div id="Dtpinsigniaanouncedate" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtinsigniaanouncedate" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="Saveinsignia();" class="btn btn-primary" style="border-radius: 2px; font-size: 18px;">บันทึก</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                </div>

            </div>
        </div>
    </div>



     <div class="modal" id="Divmodalpromote" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 18px; font-family: TH SarabunPSK;">
            <div class="modal-content">
                <div class="modal-header">
                    <span>ตำแหน่ง</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <input type="hidden" id="Hdpromoteid" value="" />
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ประเภทการเลื่อนตำแหน่ง</span>
                            </div>
                            <div class="col-9">
                                <select class="form-control" id="Cbpromotetype"></select>
                            </div>
                        </div>
                         <div class="row mt-3">
                            <div class="col-3">
                                <span>ตำแหน่ง</span>
                            </div>
                            <div class="col-9">
                                <textarea id="Txtpositionremark"  class="form-control" ></textarea>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วัน เดือน ปี</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="Txteffectdate" class="form-control" />
                            </div>
                            <div class="col-3">
                                <span>เลขที่ตำแหน่ง</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="Txtpositionno" class="form-control" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ระดับ</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="Txtlvremark" class="form-control" />
                            </div>
                            <div class="col-3">
                                <span>อัตราเงินเดือน</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="Txtpromotesalary" class="form-control" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ตำแหน่งในการบริหารงาน</span>
                            </div>
                            <div class="col-3">
                                 <select class="form-control" id="Cbpromotemanagementposition"></select>
                            </div>
                            <div class="col-3">
                                <span>ตำแหน่งในสายงาน</span>
                            </div>
                            <div class="col-3">
                                <select class="form-control" id="Cblineofjobposition"></select>
                            </div>
                        </div>
                     <div class="row mt-3">
                        <div class="col-3">
                                <span>เอกสารอ้างอิง</span>
                            </div>
                            <div class="col-9">
                                 <input type="text" id="Txtreferdocument" class="form-control" />
                            </div>
                        </div>
                      <div class="row mt-3">
                        <div class="col-3">
                                <span>สถานที่ปฏิบัติงานจริง</span>
                            </div>
                            <div class="col-9">
                                <textarea id="Txtpromoteworkplace" style="height:100px;" class="form-control" ></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="Savepromote();" class="btn btn-primary" style="border-radius: 2px; font-size: 18px;">บันทึก</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                </div>

            </div>
        </div>
    </div>





     <div class="modal" id="Divmodalleave" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 18px; font-family: TH SarabunPSK;">
            <div class="modal-content">
                <div class="modal-header">
                    <span id="Spleavetypetitle">การลา</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <input type="hidden" id="Hdleavetypeid" value="" />
                        <div class="container">
                           <div class="row mt-3">
                                <div class="col-12">
                                    <span>เรื่องที่ขอลา</span>
                                </div>
                                <div class="col-12">
                                    <input type="text" id="Txtleavesubject" class="form-control" />
                                </div>
                            </div>
                             <div class="row mt-3">
                                <div class="col-12">
                                    <span>ประเภทการขอลา</span>
                                </div>
                                <div class="col-12">
                                      <div class="input-group mb-3">
                                        <select id="Cbleavecat" class="form-control">
                                            <option selected="selected" value="F">เต็มวัน</option>
                                            <option value="P">ครึ่งวัน</option>
                                        </select>
                                    </div>
                                    
                                </div>
                            </div>
                            <div id="Divfulltime">
                                <div class="row mt-3">
                                    <div class="col-6">
                                        <span>วันที่เริ่มลาจาก</span>
                                    </div>
                                    <div class="col-6">
                                        <span>วันที่เริ่มลาถึง</span>
                                    </div>
                                </div>
                          
                          
                            <div class="row mt-1">
                                <div class="col-6">
                                     <div id="Dtpstartleave" class="input-group date" data-date-format="mm-dd-yyyy">
                                        <input id="Txtstartleave" class="form-control" type="text" />
                                        <button>
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div id="Dtpstopleave" class="input-group date" data-date-format="mm-dd-yyyy">
                                        <input id="Txtstopleave" class="form-control" type="text" />
                                        <button>
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            </div>
                             <div id="Divparttime" style="display:none;">
                                <div class="row mt-3">
                                    <div class="col-6">
                                        <span>วันที่ลา</span>
                                    </div>
                                    <div class="col-6">
                                        <span>จากเวลา/ถึงเวลา</span>
                                    </div>
                                </div>
                          
                          
                            <div class="row mt-1">
                                <div class="col-6">
                                     <div id="Dtpstartpartleave" class="input-group date" data-date-format="mm-dd-yyyy">
                                        <input id="Txtpartleave" class="form-control" type="text" />
                                        <button>
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-6">
                                     <div class="input-group mb-3">
                                        <select id="Cbleavepartstarttime" class="form-control">
                                           
                                        </select>
                                         &nbsp;
                                          <select id="Cbleavepartstoptime" class="form-control">
                                            
                                        </select>
                                    </div>
                                </div>
                            </div>
                            </div>
                             <div class="row mt-3">
                                <div class="col-12">
                                    <span>รายละเอียดการลา</span>
                                </div>
                                <div class="col-12">
                                    <textarea id="Txtleavedesc" style="height:100px;" class="form-control" ></textarea>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-12">
                                    <span>ผู้ทำการแทน</span>
                                </div>
                                <div class="col-12">
                                    <select id="Cbdelegate" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="Saveleave();" class="btn btn-secondary" style="border-radius: 2px; font-size: 18px;">ทำเรื่องลา</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                </div>

            </div>

          
        </div>
    </div>

       <div class="modal fade bd-example-modal-xl" id="Divleavedetail"  data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-xl"  style="color: black; font-size: 18px; font-family: TH SarabunPSK;">
            <div class="modal-content">
                <div class="modal-header">
                    <span>รายละเอียดการลา</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                     <div class="container">
                         <div class="col-12">
                             <div id="Divleavedetailcont">

                             </div>
                         </div>
                     </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    
                    <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                </div>

            </div>

            
        </div>
    </div>

    <input type="hidden" id="Hdleavetype" value="" />
</body>
</html>
