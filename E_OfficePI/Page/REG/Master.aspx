<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Master.aspx.cs" Inherits="E_OfficePI.Page.REG.Master" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script src="../../js/datepicker/bootstrap-datepicker.js"></script>
    <link href="../../js/datepicker/datepicker.css" rel="stylesheet" />
    <title></title>
    <style>
        .button {
            font-size: 14px;
        }

        .form-control {
            font-family: TH SarabunPSK !important;
            font-size: 14px !important;
        }
    </style>
    <script>
        var ChkSubjectId = '';
        function Savecalendar() {
            var json = '';

            json += 'Cbcalendaryearno:' + $('#Cbcalendaryearno').val() + '|';
            json += 'Cbcalendarcourse:' + $('#Cbcalendarcourse').val() + '|';
            json += 'Cbcalendarclass:' + $('#Cbcalendarclass').val() + '|';
            json += 'Cbcalendarterm:' + $('#Cbcalendarterm').val() + '|';
            json += 'Txtopendatefrom:' + $('#Txtopendatefrom').val() + '|';
            json += 'Txtopendateto:' + $('#Txtopendateto').val() + '|';
            json += 'Txtregisterdatefrom:' + $('#Txtregisterdatefrom').val() + '|';
            json += 'Txtregisterdateto:' + $('#Txtregisterdateto').val() + '|';
            json += 'Txtaddwithdrawdatefrom:' + $('#Txtaddwithdrawdatefrom').val() + '|';
            json += 'Txtaddwithdrawdateto:' + $('#Txtaddwithdrawdateto').val() + '|';
            json += 'Txtpaymentdatefrom:' + $('#Txtpaymentdatefrom').val() + '|';
            json += 'Txtpaymentdateto:' + $('#Txtpaymentdateto').val() + '|';
            json += 'Txtmidexamdatefrom:' + $('#Txtmidexamdatefrom').val() + '|';
            json += 'Txtmidexamdateto:' + $('#Txtmidexamdateto').val() + '|';
            json += 'Txtfinalexamdatefrom:' + $('#Txtfinalexamdatefrom').val() + '|';
            json += 'Txtfinalexamdateto:' + $('#Txtfinalexamdateto').val() + '|';
            json += 'Txtsendgradedatefrom:' + $('#Txtsendgradedatefrom').val() + '|';
            json += 'Txtsendgradedateto:' + $('#Txtsendgradedateto').val() + '|';
      
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Master.aspx/Savecalendar",
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
                    Msgbox('บันทึกข้อมูลเรียบร้อยแล้ว');
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SaveCourse(){
            var json = '';

            json += 'CbCourseyearno:' + $('#CbCourseyearno').val() + '|';
            json += 'CbCoursecourse:' + $('#CbCoursecourse').val() + '|';
            json += 'CbCourseclass:' + $('#CbCourseclass').val() + '|';
            json += 'CbCourseterm:' + $('#CbCourseterm').val() + '|'; 
            json += 'SubjectId:' + ChkSubjectId + '|'; 
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Master.aspx/SaveCourse",
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
                    BindCourse(); 
                    $('#DivmodalCourse').modal('hide');
                    Msgbox('บันทึกข้อมูลเรียบร้อยแล้ว');
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Searchcalendar() {
            var json = '';
            json += 'Cbcalendaryearno:' + $('#Cbcalendaryearno').val() + '|';
            json += 'Cbcalendarcourse:' + $('#Cbcalendarcourse').val() + '|';
            json += 'Cbcalendarclass:' + $('#Cbcalendarclass').val() + '|';
            json += 'Cbcalendarterm:' + $('#Cbcalendarterm').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Master.aspx/Searchcalendar",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res["Error"] != "") {
                        Msgbox(res["Error"]);
                        return;
                    }
                    else {
                        $('#Txtopendatefrom').val(res['Opendatefrom']);
                        $('#Txtopendateto').val(res['Opendateto']);
                        $('#Txtregisterdatefrom').val(res['Registerdatefrom']);
                        $('#Txtregisterdateto').val(res['Registerdateto']);
                        $('#Txtaddwithdrawdatefrom').val(res['Addwithdrawdatefrom']);
                        $('#Txtaddwithdrawdateto').val(res['Addwithdrawdateto']);
                        $('#Txtpaymentdatefrom').val(res['Paymentdatefrom']);
                        $('#Txtpaymentdateto').val(res['Paymentdateto']);
                        $('#Txtmidexamdatefrom').val(res['Midexamdatefrom']);
                        $('#Txtmidexamdateto').val(res['Midexamdateto']);
                        $('#Txtfinalexamdatefrom').val(res['Finalexamdatefrom']);
                        $('#Txtfinalexamdateto').val(res['Finalexamdateto']);
                        $('#Txtsendgradedatefrom').val(res['Sendgradedatefrom']);
                        $('#Txtsendgradedateto').val(res['Sendgradedateto']);
                    }
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Getcalendarcourse() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Master.aspx/Getcourse",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbcalendarcourse').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbcalendarcourse').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbcalendarcourse').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                    }
                    $('#CbCoursecourse').find('option').remove().end();
                    if (res.length == 0) {
                        $('#CbCoursecourse').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbCoursecourse').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                    }
                    $('#CbAddcourse').find('option').remove().end();
                    if (res.length == 0) {
                        $('#CbAddcourse').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbAddcourse').append($('<option/>', {
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
        function Getterm() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Master.aspx/Getterm",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbcalendarterm').find('option').remove().end(); 
                    if (res.length == 0) {
                        $('#Cbcalendarterm').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbcalendarterm').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                    }
                    $('#CbCourseterm').find('option').remove().end(); 
                    if (res.length == 0) {
                        $('#CbCourseterm').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbCourseterm').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                    }
                    $('#CbAddTerm').find('option').remove().end();
                    if (res.length == 0) {
                        $('#CbAddTerm').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbAddTerm').append($('<option/>', {
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
        function Getclass() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Master.aspx/Getclass",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbcalendarclass').find('option').remove().end(); 
                    if (res.length == 0) {
                        $('#Cbcalendarclass').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbcalendarclass').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                    }
                    $('#CbCourseclass').find('option').remove().end(); 
                    if (res.length == 0) {
                        $('#CbCourseclass').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbCourseclass').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                    }
                    $('#CbAddclass').find('option').remove().end();
                    if (res.length == 0) {
                        $('#CbAddclass').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbAddclass').append($('<option/>', {
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
        function Getyear() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Master.aspx/Getyear",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbcalendaryearno').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbcalendaryearno').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbcalendaryearno').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                    }
                    $('#CbCourseyearno').find('option').remove().end();
                    if (res.length == 0) {
                        $('#CbCourseyearno').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbCourseyearno').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                    }
                    $('#CbAddYearNo').find('option').remove().end();
                    if (res.length == 0) {
                        $('#CbAddYearNo').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbAddYearNo').append($('<option/>', {
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
        function CustomEdit(ctrl, dat, div, WPanel, HPanel) {
            var json = dat;
            if (ctrl == 'Gvterm') {

                $.ajax({
                    type: "POST",
                    url: "\../Page/REG/Master.aspx/Getterminfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        Getcourse();
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#Hdtermid').val(res['id']);
                        $('#Txtyearno').val(res['Yearno']);
                        $('#Cbclass').val(res['Class']);
                        $('#Cbcourse').val(res['Courseid']);
                        $('#Txtopenterm1').val(res['Openterm1']);
                        $('#Txtopenterm2').val(res['Openterm2']);
                        $('#Txtopenterm3').val(res['Openterm3']);
                        $('#Txtcloseterm').val(res['Closeterm']);
                        $('#Divmodalterm').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
        }
        function Saveterm() {
            var json = '';
            json += 'Hdterm:' + $('#Hdtermid').val() + '|';
            json += 'Cbcourse:' + $('#Cbcourse').val() + '|';
            json += 'Txtyearno:' + $('#Txtyearno').val() + '|';
            json += 'Cbclass:' + $('#Cbclass').val() + '|';
            json += 'Txtopenterm1:' + $('#Txtopenterm1').val() + '|';
            json += 'Txtopenterm2:' + $('#Txtopenterm2').val() + '|';
            json += 'Txtopenterm3:' + $('#Txtopenterm3').val() + '|';
            json += 'Txtcloseterm:' + $('#Txtcloseterm').val() + '|';
            $('#Divmodalterm').modal('show');
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Master.aspx/Saveterm",
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
                    $('#Divmodalterm').modal('hide');
                    Msgbox('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Bindterm();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function RowSelect(Ctrl, x) { 
            if (Ctrl == "GvSubject") { 
                if ($('#ChkGvSubject_' + x).prop('checked')) {
                    ChkSubjectId.replace(x + ',', "");
                    ChkSubjectId += x + ',';
                }
                else {
                    ChkSubjectId = ChkSubjectId.replace(x + ',', "");
                }
            }
        }
        function Getcourse() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Master.aspx/Getcourse",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbcourse').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbcourse').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbcourse').append($('<option/>', {
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


        function Getcourse() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/Getcourse",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbcourse').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbcourse').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbcourse').append($('<option/>', {
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
        function Newterm() {
            Getcourse();
            $('#Txtyearno').val('');
            $('#Cbclass').val('1');
            $('#Txtopenterm1').val('');
            $('#Txtopenterm2').val('');
            $('#Txtopenterm3').val('');
            $('#Txtcloseterm').val('');
            $('#Divmodalterm').modal('show');
        }
        function NewCourse() { 
            $('#DivmodalCourse').modal('show');
            ChkSubjectId = ''; 
            BindSubject();
            $('#CbAddYearNo').on('change', function () {
                BindSubject();
            });
            $('#CbAddclass').on('change', function () {
                BindSubject();
            });
            $('#CbAddcourse').on('change', function () {
                BindSubject();
            });
            $('#CbAddTerm').on('change', function () {
                BindSubject();
            });
        
        }
        function BindSubject() {
            ClearResource('REG/Master.aspx', 'GvSubject'); 
            var json = '';
            json += 'CbAddYearNo:' + $('#CbAddYearNo').val() + '|';
            json += 'CbAddclass:' + $('#CbAddclass').val() + '|';
            json += 'CbAddcourse:' + $('#CbAddcourse').val() + '|';
            json += 'CbAddTerm:' + $('#CbAddTerm').val() + '|';

            var Cri = json;
            var Columns = ["รหัสวิชา!C", "รายวิชา!C", "หน่วยกิจ!C", "ทฤษฎี!C", "ทดลอง/ปฏิบัติ!C", "ศึกษาด้วยตัวเอง!C"];
            var Data = ["Subjectcode", "Subjectname", "Credit", "Theory", "Practice", "SelfStudy"];
            var Searchcolumns = ["รหัสวิชา", "ชื่อวิชา"];
            var SearchesDat = ["Subjectcode", "Subjectname"];
            var Width = ["10%", "40%", "10%", "10%", "10%", "10%"];
            //var Gv = new Grid("REG/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvSubject', 30, Width, Data, "", '', '2', '', '1', '1', '1', '', '1', 'id', '', '', 'id', Cri, '');
            var Gv = new Grid("REG/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvSubject', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', '1', '1', 'id', Cri, 'id');
            //var Gv = new Grid(Columns, SearchesDat, Searchcolumns, 'GvPaymentvoucherforExport', 50, Width, Data, "ใบสำคัญจ่าย", 'S', '1', '', '', '', '', '', '', 'ASC#N!PaymentvoucherId', '1', '1', 'PaymentvoucherId', '', 'PaymentvoucherId');
            $('#DivGvSubject').html(Gv._Tables());
            $('#ChkGvSubject_SelectAll').hide();
            $('#lnkselect_GvSubject').hide();
            $('#lnkUnselect_GvSubject').hide();
            Gv._Bind();
        } 
        function Bindterm() {
            ClearResource('REG/Master.aspx', 'Gvterm');
            var Cri = $('#HdMasterid').val();
            var Columns = ["ปีการศึกษา!L", "ชั้นปี!L", "หลักสูตร!L", "เปิดภาคที่ 1!L", "เปิดภาคที่ 2!L", "เปิดภาคที่ 3!L", "วันปิดภาค!L"];
            var Data = ["Yearno", "Class", "Coursename", "Openterm1", "Openterm2", "Openterm3", "Closeterm"];
            var Searchcolumns = ["ปี", "ชั้นปี", "หลักสูตร"];
            var SearchesDat = ["Yearno", "Class", "Coursename"];
            var Width = ["8%", "5%", "40%", "8%", "8%", "8%", "8%"];
            var Gv = new Grid("REG/Master.aspx", Columns, SearchesDat, Searchcolumns, 'Gvterm', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="Newterm();">เพื่มข้อมูลปี/ภาคการศึกษา</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divterm').html(Gv._Tables());
            Gv._Bind();
        }
        function BindCourse() {
            ClearResource('REG/Master.aspx', 'GvCourse');
            var json = '';
            json += 'CbCourseyearno:' + $('#CbCourseyearno').val() + '|';
            json += 'CbCoursecourse:' + $('#CbCoursecourse').val() + '|';
            json += 'CbCourseclass:' + $('#CbCourseclass').val() + '|';
            json += 'CbCourseterm:' + $('#CbCourseterm').val() + '|';

            var Cri = json;
            var Columns = ["รหัสวิชา!C","รายวิชา!C", "หน่วยกิจ!C", "ทฤษฎี!C", "ทดลอง/ปฏิบัติ!C", "ศึกษาด้วยตัวเอง!C"];
            var Data = ["Subjectcode", "Subjectname", "Credit", "Theory", "Practice", "SelfStudy"];
            var Searchcolumns = ["รหัสวิชา", "ชื่อวิชา"];
            var SearchesDat = ["Subjectcode", "Subjectname"];
            var Width = ["10%", "40%", "10%", "10%", "10%", "10%"];
            var Gv = new Grid("REG/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvCourse', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewCourse();">เพื่มรายวิชา</button>', '1', '1', '', '', '', 'mc.id', '', '', 'mc.id', Cri, '');
            $('#DivGvCourse').html(Gv._Tables());
            Gv._Bind();
        } 
        function Term() {
            $('#Divterm').show();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            Bindterm();
        }
        function Course() {
            $('#DivCourse').show();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#Divcalendar').hide();
            Getyear();
            Getcalendarcourse();
            Getclass();
            Getterm();
            BindCourse();
        }
        function Calendar() {
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#DivCourse').hide();
            $('#Divcalendar').show(); 
            Getyear();
            Getcalendarcourse();
            Getclass();
            Getterm();
            Searchcalendar();
        }
        function Initial() {
            $('#Divterm').hide();
            $('#Divinitial').show();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
        }
        $(document).ready(function () {
            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });
            Term();
        });
        $(function () {
            $("#Txtopendatefrom").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtopendateto").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            $("#Txtregisterdatefrom").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtregisterdateto").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            $("#Txtaddwithdrawdatefrom").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtaddwithdrawdateto").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            $("#Txtpaymentdatefrom").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtpaymentdateto").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            $("#Txtmidexamdatefrom").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtmidexamdateto").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtfinalexamdatefrom").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtfinalexamdateto").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            $("#Txtsendgradedatefrom").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtsendgradedateto").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtopenterm1").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtopenterm2").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtopenterm3").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#Txtcloseterm").datepicker({
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
    <div class="container-fluid" style="font-family: TH SarabunPSK; background-color: white; padding: 10px; width: 100%; margin-top: 20px;">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav" style="color: black !important; font-family: TH SarabunPSK;">
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="Term();" id="Divterm();">ข้อมูลภาค/ปีการศึกษา</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="Calendar();" id="Divcalendar();">ปฏิทินการศึกษา</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="Course();" id="DivCours" style="color:lightgray;" >ข้อมูลหลักสูตร</a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;" >ข้อมูลตารางสอน</a>
                    </li>
                    
                </ul>
            </div>
        </nav>
   
    <div id="Divterm" style="display: none;margin-top:10px;">
    </div>
    <div id="DivCourse" style="display: none;margin-top:10px;">
          <div class="container">
                <div class="row">
                    <div class="form-group">
                        <div class="input-group mb-2">
                            <span style="margin: 10px;">ปีการศึกษา</span><select style="margin: 10px; width: 100px;" class="form-control" id="CbCourseyearno"></select>
                            <span style="margin: 10px;">ภาค</span><select style="margin: 10px; width: 100px;" class="form-control" id="CbCourseterm"></select>
                            <span style="margin: 10px;">ชั้นปี</span><select style="margin: 10px; width: 100px;" class="form-control" id="CbCourseclass"></select>
                            <span style="margin: 10px;">หลักสูตร</span><select style="margin: 10px; width: 400px;" class="form-control" id="CbCoursecourse"></select>
                            <button style="margin: 10px;font-size:14px;border-radius:1px;" class="btn btn-info" onclick="BindCourse();"><span>ค้นหา</span></button>
                        </div>
                    </div> 
                </div>
           </div>
            <div class="container" id="DivGvCourse"> 
            </div>
    </div>
    <div id="Divcalendar" style="display: none; background-color: white; margin-top: 50px; color: black;">
        <div class="container">
            <div class="row">
                <div class="form-group">
                    <div class="input-group mb-2">
                        <span style="margin: 10px;">ปีการศึกษา</span><select style="margin: 10px; width: 100px;" class="form-control" id="Cbcalendaryearno"></select>
                        <span style="margin: 10px;">ภาค</span><select style="margin: 10px; width: 100px;" class="form-control" id="Cbcalendarterm"></select>
                        <span style="margin: 10px;">ชั้นปี</span><select style="margin: 10px; width: 100px;" class="form-control" id="Cbcalendarclass"></select>
                        <span style="margin: 10px;">หลักสูตร</span><select style="margin: 10px; width: 400px;" class="form-control" id="Cbcalendarcourse"></select>
                        <button style="margin: 10px;font-size:14px;border-radius:1px;" class="btn btn-info" onclick="Searchcalendar();"><span>ค้นหา</span></button>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <hr />
                </div>
            </div>
             <div class="row">
                <div class="col-12">
                    <input type="button" style="font-size:14px;border-radius:1px;" class="btn btn-secondary" value="บันทึกข้อมูลปฏิทิน" onclick="Savecalendar()" />
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <hr />
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="container">



                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วันเปิดภาคการศึกษา</span>

                            </div>
                            <div class="col-3">
                                <div id="Dtpopendatefrom" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtopendatefrom" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-2">
                                <span>ถึง</span>
                            </div>
                            <div class="col-3">
                                <div id="Dtpopendateto" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtopendateto" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วันลงทะเบียนเรียน</span>

                            </div>
                            <div class="col-3">
                                <div id="Dtpregisterdatefrom" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtregisterdatefrom" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-2">
                                <span>ถึง</span>
                            </div>
                            <div class="col-3">
                                <div id="Dtpregisterdateto" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtregisterdateto" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>

                        </div>


                        <div class="row mt-3">
                            <div class="col-3">
                                <span>เพิ่ม-ถอนรายวิชา</span>

                            </div>
                            <div class="col-3">
                                <div id="Dtpaddwithdrawdatefrom" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtaddwithdrawdatefrom" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-2">
                                <span>ถึง</span>
                            </div>
                            <div class="col-3">
                                <div id="Dtpaddwithdrawdateto" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtaddwithdrawdateto" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>

                        </div>



                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชำระค่าลงทะเบียนเรียน</span>

                            </div>
                            <div class="col-3">
                                <div id="Dtppaymentdatefrom" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtpaymentdatefrom" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-2">
                                <span>ถึง</span>
                            </div>
                            <div class="col-3">
                                <div id="Dtppaymentdateto" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtpaymentdateto" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>

                        </div>



                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ช่วงสอบกลางภาค</span>

                            </div>
                            <div class="col-3">
                                <div id="Dtpmidexamdatefrom" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtmidexamdatefrom" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-2">
                                <span>ถึง</span>
                            </div>
                            <div class="col-3">
                                <div id="Dtpmidexamdateto" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtmidexamdateto" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>

                        </div>



                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ช่วงสอบปลายภาค</span>

                            </div>
                            <div class="col-3">
                                <div id="Dtpfinalexamdatefrom" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtfinalexamdatefrom" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-2">
                                <span>ถึง</span>
                            </div>
                            <div class="col-3">
                                <div id="Dtpfinalexamdateto" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtfinalexamdateto" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>

                        </div>



                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ช่วงสอบปลายภาค</span>

                            </div>
                            <div class="col-3">
                                <div id="Dtpsendgradedatefrom" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtsendgradedatefrom" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-2">
                                <span>ถึง</span>
                            </div>
                            <div class="col-3">
                                <div id="Dtpsendgradedateto" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtsendgradedateto" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="col-12">
                    &nbsp;
                </div>
            </div>
        </div>
    </div>
    </div>
    <div class="modal" id="Divmodalterm" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลปี/ภาคการศึกษา</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <input type="hidden" id="Hdtermid" value="" />
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ปีการศึกษา</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="Txtyearno" class="form-control" />
                            </div>
                            <div class="col-3">
                                <span>ชั้นปี</span>
                            </div>
                            <div class="col-3">
                                <select class="form-control" id="Cbclass">
                                    <option value="1" selected="selected">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>หลักสูตร</span>
                            </div>
                            <div class="col-9">
                                <select class="form-control" id="Cbcourse"></select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วันที่เปิดการศึกษา ภาคที่ 1</span>
                            </div>
                            <div class="col-9">
                                <input type="text" class="form-control" id="Txtopenterm1" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วันที่เปิดการศึกษา ภาคที่ 2</span>
                            </div>
                            <div class="col-9">
                                <input type="text" class="form-control" id="Txtopenterm2" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วันที่เปิดการศึกษา ภาคที่ 3</span>
                            </div>
                            <div class="col-9">
                                <input type="text" class="form-control" id="Txtopenterm3" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วันที่ปิดการศึกษา</span>
                            </div>
                            <div class="col-9">
                                <input type="text" class="form-control" id="Txtcloseterm" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="Saveterm();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
        <div class="modal" id="DivmodalCourse" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <div class="modal-content">
                <div class="modal-header">
                    <span>เพิ่มวิชา</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container"> 
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ปีการศึกษา</span>
                            </div>
                            <div class="col-3"> 
                                 <select class="form-control" id="CbAddYearNo"></select>
                            </div>
                            <div class="col-3">
                                <span>ชั้นปี</span>
                            </div>
                            <div class="col-3">
                                <select class="form-control" id="CbAddclass">
                                    <option value="1" selected="selected">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>หลักสูตร</span>
                            </div>
                            <div class="col-9">
                                <select class="form-control" id="CbAddcourse"></select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ภาคเรียนที่ </span>
                            </div>
                            <div class="col-9">
                                  <select class="form-control" id="CbAddTerm"></select>
                            </div>
                        </div>
                       
                        <div id="DivGvSubject"> 
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SaveCourse();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>

</body>
</html>
