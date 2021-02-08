<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Master.aspx.cs" Inherits="E_OfficePI.Page.Master.Master" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script src="../../js/datepicker/bootstrap-datepicker.js"></script>
    <link href="../../js/datepicker/datepicker.css" rel="stylesheet" />

     <style>
        button {
            font-family: 'TH SarabunPSK';
            font-size: 18px;
        }

        .form-control {
            font-family: 'TH SarabunPSK';
            font-size: 18px;
        }

        a {
            cursor: pointer;
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

        @media (min-width: 768px) {
            .modal-xl {
                width: 90%;
                max-width: 1200px;
            }
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
            json += 'TxtMasteristerdatefrom:' + $('#TxtMasteristerdatefrom').val() + '|';
            json += 'TxtMasteristerdateto:' + $('#TxtMasteristerdateto').val() + '|';
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
                url: "\../Page/Master/Master.aspx/Savecalendar",
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
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SaveCourse() {
            var json = '';

            json += 'CbCourseyearno:' + $('#CbAddYearNo').val() + '|';
            json += 'CbCoursecourse:' + $('#CbAddcourse').val() + '|';
            json += 'CbCourseclass:' + $('#CbAddclass').val() + '|';
            json += 'CbCourseterm:' + $('#CbAddTerm').val() + '|';
            json += 'SubjectId:' + ChkSubjectId + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SaveCourse",
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
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
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
                url: "\../Page/Master/Master.aspx/Searchcalendar",
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
                        $('#TxtMasteristerdatefrom').val(res['Masteristerdatefrom']);
                        $('#TxtMasteristerdateto').val(res['Masteristerdateto']);
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
                url: "\../Page/Master/Master.aspx/Getcourse",
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
                url: "\../Page/Master/Master.aspx/Getterm",
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
                url: "\../Page/Master/Master.aspx/Getclass",
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
                url: "\../Page/Master/Master.aspx/Getyear",
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
        function GetCollege() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/GetCollege",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#CbCollege').find('option').remove().end();
                    if (res.length == 0) {
                        $('#CbCollege').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbCollege').append($('<option/>', {
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
        function GetOwnerOrg() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/GetOwnerOrg",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#CbOwnerOrg').find('option').remove().end();
                    if (res.length == 0) {
                        $('#CbOwnerOrg').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbOwnerOrg').append($('<option/>', {
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
        function GetCourseGroup() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/GetCourseGroup",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#CbCourseGroup').find('option').remove().end();
                    if (res.length == 0) {
                        $('#CbCourseGroup').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbCourseGroup').append($('<option/>', {
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
                $('#Divmodalterm').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/Getterminfo",
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
            if (ctrl == 'GvPosition') {
                //$('#DivmodalPosition').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetPositionInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdPositionId').val(res['Id']);
                        $('#TxtPositionName').val(res['PositionName']);
                        $('#DivmodalPosition').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            if (ctrl == 'GvAcademy') {
                $('#DivmodalAcademy').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetAcademyInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdAcademyId').val(res['Id']);
                        $('#TxtAcademyName').val(res['AcademyName']);

                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            if (ctrl == 'GvLeaveType') {
                $('#DivmodalLeaveType').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetLeaveTypeInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdLeaveTypeId').val(res['Id']);
                        $('#TxtLeaveTypeName').val(res['LeaveTypeName']);

                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            if (ctrl == 'GvPositionJob') {
                //$('#DivmodalPosition').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetPositionJobInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdPositionJobId').val(res['Id']);
                        $('#TxtPositionJobName').val(res['PositionName']);
                        $('#DivmodalPositionJob').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            if (ctrl == 'GvPositionMange') {
                //$('#DivmodalPosition').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetPositionMangeInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdPositionMangeId').val(res['Id']);
                        $('#TxtPositionMangeName').val(res['PositionName']);
                        $('#DivmodalPositionMange').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            if (ctrl == 'GvMajor') {
                //$('#DivmodalPosition').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetMajorInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdMajorId').val(res['Id']);
                        $('#TxtMajorName').val(res['MajorName']);
                        $('#DivmodalMajor').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            if (ctrl == 'GvBlood') {
                //$('#DivmodalPosition').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetBloodInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdBloodId').val(res['Id']);
                        $('#TxtBloodName').val(res['BloodName']);
                        $('#DivmodalBlood').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            if (ctrl == 'GvClass') {
                //$('#DivmodalPosition').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetClassInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdClassId').val(res['Id']);
                        $('#TxtClassName').val(res['ClassName']);
                        $('#DivmodalClass').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            if (ctrl == 'GvCollege') {
                //$('#DivmodalPosition').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetCollegeInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdCollegeId').val(res['Id']);
                        $('#TxtCollegeName').val(res['CollegeName']);
                        $('#DivmodalCollege').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            if (ctrl == 'GvCountry') {
                //$('#DivmodalPosition').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetCountryInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdCountryId').val(res['Id']);
                        $('#TxtCountryName').val(res['CountryName']);
                        $('#DivmodalCountry').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            if (ctrl == 'GvCourseGroup') {
                //$('#DivmodalPosition').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetCourseGroupInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdCourseGroupId').val(res['Id']);
                        $('#TxtCourseGroupName').val(res['CourseGroupName']);
                        $('#DivmodalCourseGroup').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            if (ctrl == 'GvCourseMain') {
                //$('#DivmodalPosition').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetCourseMainInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdCourseMainId').val(res['Id']);
                        $('#TxtCourseMainName').val(res['CourseName']);
                        $('#CbCourseGroup').val(res['CourseGroupId']);
                        $('#CbCollege').val(res['CollegeId']);
                        $('#CbOwnerOrg').val(res['OwnerOrgId']);
                        $('#DivmodalCourseMain').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            if (ctrl == 'GvCurrentStatus') {
                //$('#DivmodalPosition').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/Master/Master.aspx/GetCurrentStatusInfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: function () {
                    //    Getcourse();
                    //    $(".loader").fadeOut("slow");
                    //},
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#HdCurrentStatusId').val(res['Id']);
                        $('#TxtCurrentStatusName').val(res['CurrentStatusName']);
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
                url: "\../Page/Master/Master.aspx/Saveterm",
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
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Bindterm();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SavePosition() {
            var json = '';
            json += 'HdPosition:' + $('#HdPositionId').val() + '|';
            json += 'TxtPositionName:' + $('#TxtPositionName').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SavePosition",
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
                    $('#DivmodalPosition').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindPosition();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SaveAcademy() {
            var json = '';
            json += 'HdAcademy:' + $('#HdAcademyId').val() + '|';
            json += 'TxtAcademyName:' + $('#TxtAcademyName').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SaveAcademy",
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
                    $('#DivmodalAcademy').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindAcademy();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SaveLeaveType() {
            var json = '';
            json += 'HdLeaveType:' + $('#HdLeaveTypeId').val() + '|';
            json += 'TxtLeaveTypeName:' + $('#TxtLeaveTypeName').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SaveLeaveType",
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
                    $('#DivmodalLeaveType').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindLeaveType();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SavePositionJob() {
            var json = '';
            json += 'HdPositionJob:' + $('#HdPositionJobId').val() + '|';
            json += 'TxtPositionJobName:' + $('#TxtPositionJobName').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SavePositionJob",
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
                    $('#DivmodalPositionJob').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindPositionJob();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SavePositionMange() {
            var json = '';
            json += 'HdPositionMange:' + $('#HdPositionMangeId').val() + '|';
            json += 'TxtPositionMangeName:' + $('#TxtPositionMangeName').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SavePositionMange",
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
                    $('#DivmodalPositionMange').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindPositionMange();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SaveMajor() {
            var json = '';
            json += 'HdMajor:' + $('#HdMajorId').val() + '|';
            json += 'TxtMajorName:' + $('#TxtMajorName').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SaveMajor",
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
                    $('#DivmodalMajor').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindMajor();

                },
                async: true,
                error: function (er) {

                }
            });
        }

        function SaveBlood() {
            var json = '';
            json += 'HdBlood:' + $('#HdBloodId').val() + '|';
            json += 'TxtBloodName:' + $('#TxtBloodName').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SaveBlood",
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
                    $('#DivmodalBlood').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindBlood();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SaveClass() {
            var json = '';
            json += 'HdClass:' + $('#HdClassId').val() + '|';
            json += 'TxtClassName:' + $('#TxtClassName').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SaveClass",
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
                    $('#DivmodalClass').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindClass();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SaveCollege() {
            var json = '';
            json += 'HdCollege:' + $('#HdCollegeId').val() + '|';
            json += 'TxtCollegeName:' + $('#TxtCollegeName').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SaveCollege",
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
                    $('#DivmodalCollege').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindCollege();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SaveCountry() {
            var json = '';
            json += 'HdCountry:' + $('#HdCountryId').val() + '|';
            json += 'TxtCountryName:' + $('#TxtCountryName').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SaveCountry",
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
                    $('#DivmodalCountry').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindCountry();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SaveCourseGroup() {
            var json = '';
            json += 'HdCourseGroup:' + $('#HdCourseGroupId').val() + '|';
            json += 'TxtCourseGroupName:' + $('#TxtCourseGroupName').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SaveCourseGroup",
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
                    $('#DivmodalCourseGroup').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindCourseGroup();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SaveCourseMain() {
            var json = '';
            json += 'HdCourseMain:' + $('#HdCourseMainId').val() + '|';
            json += 'TxtCourseMainName:' + $('#TxtCourseMainName').val() + '|';
            json += 'CbCourseGroup:' + $('#CbCourseGroup').val() + '|';
            json += 'CbCollege:' + $('#CbCollege').val() + '|';
            json += 'CbOwnerOrg:' + $('#CbOwnerOrg').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SaveCourseMain",
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
                    $('#DivmodalCourseMain').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindCourseMain();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function SaveCurrentStatus() {
            var json = '';
            json += 'HdCurrentStatus:' + $('#HdCurrentStatusId').val() + '|';
            json += 'TxtCurrentStatusName:' + $('#TxtCurrentStatusName').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Master/Master.aspx/SaveCurrentStatus",
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
                    $('#DivmodalCurrentStatus').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindCurrentStatus();
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

        function NewPosition() {
            $('#HdPositionId').val('');
            $('#TxtPositionName').val('');
            $('#DivmodalPosition').modal('show');
        }
        function NewAcademy() {
            $('#HdAcademyd').val('');
            $('#TxtAcademyName').val('');
            $('#DivmodalAcademy').modal('show');
        }
        function NewLeaveType() {
            $('#HdLeaveTypeId').val('');
            $('#TxtLeaveTypeName').val('');
            $('#DivmodalLeaveType').modal('show');
        }
        function NewPositionJob() {
            $('#HdPositionJobId').val('');
            $('#TxtPositionJobName').val('');
            $('#DivmodalPositionJob').modal('show');
        }
        function NewPositionMange() {
            $('#HdPositionMangeId').val('');
            $('#TxtPositionMangeName').val('');
            $('#DivmodalPositionMange').modal('show');
        }
        function NewMajor() {
            $('#HdMajorId').val('');
            $('#TxtMajorName').val('');
            $('#DivmodalMajor').modal('show');
        }
        function NewBlood() {
            $('#HdBloodId').val('');
            $('#TxtBloodName').val('');
            $('#DivmodalBlood').modal('show');
        }
        function NewClass() {
            $('#HdClassId').val('');
            $('#TxtClassName').val('');
            $('#DivmodalClass').modal('show');
        }
        function NewCollege() {
            $('#HdCollegeId').val('');
            $('#TxtCollegeName').val('');
            $('#DivmodalCollege').modal('show');
        }
        function NewCountry() {
            $('#HdCountryId').val('');
            $('#TxtCountryeName').val('');
            $('#DivmodalCountry').modal('show');
        }
        function NewCourseGroup() {
            $('#HdCourseGroupId').val('');
            $('#TxtCourseGroupName').val('');
            $('#DivmodalCourseGroup').modal('show');
        }
        function NewCourseMain() {
            $('#HdCourseMainId').val('');
            $('#TxtCourseMainName').val('');
            $('#CbCourseGroup').val('');
            $('#CbCollege').val('');
            $('#CbOwnerOrg').val('');
            $('#DivmodalCourseMain').modal('show');
        }
        function NewCurrentStatus() {
            $('#HdCurrentStatusId').val('');
            $('#TxtCurrentStatusName').val('');
            $('#DivmodalCurrentStatus').modal('show');
        }
        function BindSubject() {
            ClearResource('Master/Master.aspx', 'GvSubject');
            var json = '';
            json += 'CbAddYearNo:' + $('#CbAddYearNo').val() + '|';
            json += 'CbAddclass:' + $('#CbAddclass').val() + '|';
            json += 'CbAddcourse:' + $('#CbAddcourse').val() + '|';
            json += 'CbAddTerm:' + $('#CbAddTerm').val() + '|';

            var Cri = json;
            var Columns = ["รหัสวิชา!C", "รายวิชา!C", "หน่วยกิต!C", "ทฤษฎี!C", "ทดลอง/ปฏิบัติ!C", "ศึกษาด้วยตัวเอง!C"];
            var Data = ["Subjectcode", "Subjectname", "Credit", "Theory", "Practice", "SelfStudy"];
            var Searchcolumns = ["รหัสวิชา", "ชื่อวิชา"];
            var SearchesDat = ["Subjectcode", "Subjectname"];
            var Width = ["10%", "40%", "10%", "10%", "10%", "10%"];
            //var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvSubject', 30, Width, Data, "", '', '2', '', '1', '1', '1', '', '1', 'id', '', '', 'id', Cri, '');
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvSubject', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', '1', '1', 'id', Cri, 'id');
            //var Gv = new Grid(Columns, SearchesDat, Searchcolumns, 'GvPaymentvoucherforExport', 50, Width, Data, "ใบสำคัญจ่าย", 'S', '1', '', '', '', '', '', '', 'ASC#N!PaymentvoucherId', '1', '1', 'PaymentvoucherId', '', 'PaymentvoucherId');
            $('#DivGvSubject').html(Gv._Tables());
            $('#ChkGvSubject_SelectAll').hide();
            $('#lnkselect_GvSubject').hide();
            $('#lnkUnselect_GvSubject').hide();
            Gv._Bind();
        }
        function Bindterm() {
            ClearResource('Master/Master.aspx', 'Gvterm');
            var Cri = $('#HdMasterid').val();
            var Columns = ["ปีการศึกษา!L", "ชั้นปี!L", "หลักสูตร!L", "เปิดภาคที่ 1!L", "เปิดภาคที่ 2!L", "เปิดภาคที่ 3!L", "วันปิดภาค!L"];
            var Data = ["Yearno", "Class", "Coursename", "Openterm1", "Openterm2", "Openterm3", "Closeterm"];
            var Searchcolumns = ["ปี", "ชั้นปี", "หลักสูตร"];
            var SearchesDat = ["Yearno", "Class", "Coursename"];
            var Width = ["8%", "5%", "40%", "8%", "8%", "8%", "8%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'Gvterm', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="Newterm();">เพิ่มข้อมูลปี/ภาคการศึกษา</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divterm').html(Gv._Tables());
            Gv._Bind();
        }
        function BindCourse() {
            ClearResource('Master/Master.aspx', 'GvCourse');
            var json = '';
            json += 'CbCourseyearno:' + $('#CbCourseyearno').val() + '|';
            json += 'CbCoursecourse:' + $('#CbCoursecourse').val() + '|';
            json += 'CbCourseclass:' + $('#CbCourseclass').val() + '|';
            json += 'CbCourseterm:' + $('#CbCourseterm').val() + '|';

            var Cri = json;
            var Columns = ["รหัสวิชา!C", "รายวิชา!C", "หน่วยกิต!C", "ทฤษฎี!C", "ทดลอง/ปฏิบัติ!C", "ศึกษาด้วยตัวเอง!C"];
            var Data = ["Subjectcode", "Subjectname", "Credit", "Theory", "Practice", "SelfStudy"];
            var Searchcolumns = ["รหัสวิชา", "ชื่อวิชา"];
            var SearchesDat = ["Subjectcode", "Subjectname"];
            var Width = ["10%", "40%", "10%", "10%", "10%", "10%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvCourse', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewCourse();">เพิ่มรายวิชา</button>', '1', '1', '', '', '', 'mc.id', '', '', 'mc.id', Cri, '');
            $('#DivGvCourse').html(Gv._Tables());
            Gv._Bind();
        }

        function BindPosition() {
            ClearResource('Master/Master.aspx', 'GvPosition');
            var Cri = "";
            var Columns = ["ชื่อตำเเหน่ง!L"];
            var Data = ["AcademicPosition"];
            var Searchcolumns = ["ชื่อตำเเหน่ง"];
            var SearchesDat = ["AcademicPosition"];
            var Width = ["80%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvPosition', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewPosition();">เพิ่มตำเเหน่ง</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivPosition').html(Gv._Tables());
            Gv._Bind();
        }
        function BindAcademy() {
            ClearResource('Master/Master.aspx', 'GvAcademy');
            var Cri = "";
            var Columns = ["ชื่อมหาวิทยาลัย!L"];
            var Data = ["AcademyName"];
            var Searchcolumns = ["ชื่อมหาวิทยาลัย"];
            var SearchesDat = ["AcademyName"];
            var Width = ["80%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvAcademy', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewAcademy();">เพิ่มมหาวิทยาลัย</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivAcademy').html(Gv._Tables());
            Gv._Bind();
        }
        function BindLeaveType() {
            ClearResource('Master/Master.aspx', 'GvLeaveType');
            var Cri = "";
            var Columns = ["ประเภทการลา!L"];
            var Data = ["LeaveTypeName"];
            var Searchcolumns = ["ประเภทการลา"];
            var SearchesDat = ["LeaveTypeName"];
            var Width = ["80%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvLeaveType', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewLeaveType();">เพิ่มประเภทการลา</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivLeaveType').html(Gv._Tables());
            Gv._Bind();
        }
        function BindPositionJob() {
            ClearResource('Master/Master.aspx', 'GvPositionJob');
            var Cri = "";
            var Columns = ["ชื่อตำเเหน่ง!L"];
            var Data = ["Lineofjobpositionname"];
            var Searchcolumns = ["ชื่อตำเเหน่ง"];
            var SearchesDat = ["Lineofjobpositionname"];
            var Width = ["80%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvPositionJob', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewPositionJob();">เพิ่มตำเเหน่งในสายงาน</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivPositionJob').html(Gv._Tables());
            Gv._Bind();
        }
        function BindPositionMange() {
            ClearResource('Master/Master.aspx', 'GvPositionMange');
            var Cri = "";
            var Columns = ["ชื่อตำเเหน่ง!L"];
            var Data = ["ManagementPositionname"];
            var Searchcolumns = ["ชื่อตำเเหน่ง"];
            var SearchesDat = ["ManagementPositionname"];
            var Width = ["80%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvPositionMange', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewPositionMange();">เพิ่มตำเเหน่งผู้บริหาร</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivPositionMange').html(Gv._Tables());
            Gv._Bind();
        }
        function BindMajor() {
            ClearResource('Master/Master.aspx', 'GvMajor');
            var Cri = "";
            var Columns = ["ชื่อสาขาวิชา!L"];
            var Data = ["MajorName"];
            var Searchcolumns = ["ชื่อสาขาวิชา"];
            var SearchesDat = ["MajorName"];
            var Width = ["80%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvMajor', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewMajor();">เพิ่มสาขาวิชา</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivMajor').html(Gv._Tables());
            Gv._Bind();
        }
        function BindBlood() {
            ClearResource('Master/Master.aspx', 'GvBlood');
            var Cri = "";
            var Columns = ["ชื่อกรุ๊ปเลือด!L"];
            var Data = ["BloodName"];
            var Searchcolumns = ["ชื่อกรุ๊ปเลือด"];
            var SearchesDat = ["BloodName"];
            var Width = ["80%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvBlood', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewBlood();">เพิ่มกรุ๊ปเลือด</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivBlood').html(Gv._Tables());
            Gv._Bind();
        }
        function BindClass() {
            ClearResource('Master/Master.aspx', 'GvClass');
            var Cri = "";
            var Columns = ["ชื่อ Class!L"];
            var Data = ["Class"];
            var Searchcolumns = ["ชื่อ Class"];
            var SearchesDat = ["Class"];
            var Width = ["80%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvClass', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewClass();">เพิ่ม Class</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivClass').html(Gv._Tables());
            Gv._Bind();
        }
        function BindCollege() {
            ClearResource('Master/Master.aspx', 'GvCollege');
            var Cri = "";
            var Columns = ["ชื่อวิทยาลัย!L"];
            var Data = ["CollegeName"];
            var Searchcolumns = ["ชื่อวิทยาลัย"];
            var SearchesDat = ["CollegeName"];
            var Width = ["80%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvCollege', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewCollege();">เพิ่มวิทยาลัย</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivCollege').html(Gv._Tables());
            Gv._Bind();
        }
        function BindCountry() {
            ClearResource('Master/Master.aspx', 'GvCountry');
            var Cri = "";
            var Columns = ["ชื่อประเทศ!L"];
            var Data = ["CountryName"];
            var Searchcolumns = ["ชื่อประเทศ"];
            var SearchesDat = ["CountryName"];
            var Width = ["80%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvCountry', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewCountry();">เพิ่มประเทศ</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivCountry').html(Gv._Tables());
            Gv._Bind();
        }
        function BindCourseGroup() {
            ClearResource('Master/Master.aspx', 'GvCourseGroup');
            var Cri = "";
            var Columns = ["ชื่อหมวดหลักสูตร!L"];
            var Data = ["CourseGroup"];
            var Searchcolumns = ["ชื่อหมวดหลักสูตร"];
            var SearchesDat = ["CourseGroup"];
            var Width = ["80%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvCourseGroup', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewCourseGroup();">เพิ่มหมวดหลักสูตร</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivCourseGroup').html(Gv._Tables());
            Gv._Bind();
        }
        function BindCourseMain() {
            ClearResource('Master/Master.aspx', 'GvCourseMain');
            var Cri = "";
            var Columns = ["ชื่อวิทยาลัย!C", "หมวดหลักสูตร!C", "หน่วยงานที่รับผิดชอบ!C", "ชื่อหลักสูตร!C"];
            var Data = ["CollegeName", "CourseGroupName", "OwnerOrgName", "CourseName"];
            var Searchcolumns = ["ชื่อหลักสูตร"];
            var SearchesDat = ["CourseName"];
            var Width = ["20%", "20%", "20%", "20%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvCourseMain', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewCourseMain();">เพิ่มหลักสูตร</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivCourseMain').html(Gv._Tables());
            Gv._Bind();
        }
        function BindCurrentStatus() {
            ClearResource('Master/Master.aspx', 'GvCurrentStatus');
            var Cri = "";
            var Columns = ["ชื่อสถานะ!L"];
            var Data = ["CurrentstatusName"];
            var Searchcolumns = ["ชื่อสถานะ"];
            var SearchesDat = ["CurrentstatusName"];
            var Width = ["80%"];
            var Gv = new Grid("Master/Master.aspx", Columns, SearchesDat, Searchcolumns, 'GvCurrentStatus', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="NewCurrentstatus();">เพิ่มสถานะปัจจุบัน</button>', '1', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#DivCurrentStatus').html(Gv._Tables());
            Gv._Bind();
        }
        function Term() {

            $('#Divterm').show();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
            Bindterm();
        }
        function Position() {
            $('#DivPosition').show();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
            BindPosition();
        }
        function PositionJob() {
            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').show();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();

            BindPositionJob();
        }
        function PositionMange() {
            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').show();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
            BindPositionMange();
        }
        function Major() {
            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').show();
            $('#DivBlood').hide();
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
            BindMajor();
        }
        function Blood() {
            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').show();
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
            BindBlood();
        }
        function Academy() {
            $('#DivAcademy').show();
            $('#DivLeaveType').hide();
            $('#DivPosition').hide();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
            BindAcademy();
        }
        function LeaveType() {
            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').show();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
            BindLeaveType();
        }
        function Course() {

            $('#DivCourse').show();
            $('#DivGvCourse').show();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
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
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
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
            $('#DivCourseMain').hide();
        }
        function Class() {
            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            $('#DivClass').show();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
            BindClass();
        }
        function College() {
            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            $('#DivClass').hide();
            $('#DivCollege').show();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
            BindCollege();
        }
        function Country() {
            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').show();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
            BindCountry();
        }
        function CourseGroup() {
            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').show();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').hide();
            BindCourseGroup();
        }
        function CourseMain() {
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').show();
            $('#DivCurrentStatus').hide();

            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            BindCourseMain();
            GetCourseGroup();
            GetCollege();
            GetOwnerOrg();
        }
        function CurrentStatus() {
            $('#DivClass').hide();
            $('#DivCollege').hide();
            $('#DivCountry').hide();
            $('#DivCourseGroup').hide();
            $('#DivCourseMain').hide();
            $('#DivCurrentStatus').show();

            $('#DivPosition').hide();
            $('#DivAcademy').hide();
            $('#DivLeaveType').hide();
            $('#Divterm').hide();
            $('#Divinitial').hide();
            $('#Divcalendar').hide();
            $('#DivCourse').hide();
            $('#DivPositionJob').hide();
            $('#DivPositionMange').hide();
            $('#DivMajor').hide();
            $('#DivBlood').hide();
            BindCurrentStatus();
        }
        $(document).ready(function () {
            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });

        });
        $(function () {
            //$("#navbarDropdownMenuLink").click(function () { 
            //    $(this).dropdown("toggle");
            //    return false;
            //});  

            //$('#navbarDropdownMenuLink').click(function () {

            //    if ($('#navbarDropdownMenuLink').data('open')) {
            //        $('#navbarDropdownMenuLink').data('open', false);
            //    } else {
            //        $('#navbarDropdownMenuLink').data('open', true);
            //    }

            //});

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

            $("#TxtMasteristerdatefrom").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });
            $("#TxtMasteristerdateto").datepicker({
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
  <%--  <div class="top_nav col-md-12">
        <div class="nav_menu">
            <nav>

                <ul class="nav navbar-nav navbar-left">
                    <li role="presentation" class="dropdown">
                        <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                            <span class="">ข้อมูลตั้งต้น</span> <span class="badge bg-blue" id="Spmessagequann"></span>
                        </a>
                        <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                            <li class="nav-item">
                                <a class="nav-link grid-item" href="#" onclick="Term();" id="Divterm();">ข้อมูลภาค/ปีการศึกษา</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link grid-item" href="#" onclick="Calendar();" id="Divcalendar();">ปฏิทินการศึกษา</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="Course();" id="DivCours">ข้อมูลหลักสูตร</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="">ข้อมูลตารางสอน</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="Position()">ข้อมูลตำเเหน่งในมหาลัย</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="PositionJob()">ข้อมูลตำเเหน่งในสายงาน</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="PositionMange()">ข้อมูลตำเเหน่งผู้บริหาร</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="Academy()">ข้อมูลมหาวิทยาลัย</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="LeaveType()">ข้อมูลประเภทการลา</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="Major()">ข้อมูลสาขาวิชา</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="Blood()">ข้อมูลกรุ๊ปเลือด</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="Class()">ข้อมูลชั้นเรียน</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="College()">ข้อมูลวิทยาลัย</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="Country()">ข้อมูลประเทศ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="CourseGroup()">ข้อมูลกลุ่มหมวด</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="CourseMain()">ข้อมูลหลักสูตร</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="CurrentStatus()">ข้อมูลสถานะปัจจุบัน</a>
                            </li>
                        </ul>
                    </li>
                </ul>

            </nav>
        </div>
    </div>--%>
    <%--<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">ข้อมูลตั้งต้นระบบ</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNavDropdown">
    <ul class="navbar-nav"> 
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
           ข้อมูลพื้นฐาน
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
            <a class="nav-link" href="#" style="color:lightgray;"onclick="Term();" id="Divterm();">ข้อมูลภาค/ปีการศึกษา</a> 
            <a class="nav-link" href="#" style="color:lightgray;"onclick="Calendar();" id="Divcalendar();">ปฏิทินการศึกษา</a> 
            <a class="nav-link" href="#" style="color:lightgray;"onclick="Course();" id="DivCours" style="color:lightgray;" >ข้อมูลหลักสูตร</a> 
            <a class="nav-link" href="#" style="color:lightgray;" onclick="" >ข้อมูลตารางสอน</a> 
            <a class="nav-link" href="#" style="color:lightgray;"onclick="Position()" >ข้อมูลตำเเหน่งในมหาลัย</a> 
            <a class="nav-link" href="#" style="color:lightgray;"onclick="PositionJob()" >ข้อมูลตำเเหน่งในสายงาน</a> 
            <a class="nav-link" href="#" style="color:lightgray;"onclick="PositionMange()" >ข้อมูลตำเเหน่งผู้บริหาร</a> 
            <a class="nav-link" href="#" style="color:lightgray;" onclick="Academy()" >ข้อมูลมหาวิทยาลัย</a> 
            <a class="nav-link" href="#" style="color:lightgray;" onclick="LeaveType()" >ข้อมูลประเภทการลา</a> 
            <a class="nav-link" href="#" style="color:lightgray;"onclick="Major()" >ข้อมูลสาขาวิชา</a> 
            <a class="nav-link" href="#" style="color:lightgray;"onclick="Blood()" >ข้อมูลกรุ๊ปเลือด</a>
            <a class="nav-link" href="#" style="color:lightgray;"onclick="Class()" >ข้อมูลชั้นเรียน</a> 
            <a class="nav-link" href="#" style="color:lightgray;"onclick="College()" >ข้อมูลวิทยาลัย</a> 
            <a class="nav-link" href="#" style="color:lightgray;"onclick="Country()" >ข้อมูลประเทศ</a> 
            <a class="nav-link" href="#" style="color:lightgray;"onclick="CourseGroup()" >ข้อมูลกลุ่มหมวด</a> 
            <a class="nav-link" href="#" style="color:lightgray;"onclick="CourseMain()" >ข้อมูลหลักสูตร</a> 
            <a class="nav-link" href="#" style="color:lightgray;"onclick="CurrentStatus()" >ข้อมูลสถานะปัจจุบัน</a>
        </div>
      </li>   
    </ul> 
  </div> 
</nav>--%>
    <%--  <div class="container-fluid" style="font-family: TH SarabunPSK; background-color: white; padding: 10px; width: 100%; margin-top: 20px;">
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
                        <a class="nav-link" href="#" style="color:lightgray;" onclick="" >ข้อมูลตารางสอน</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;"onclick="Position()" >ข้อมูลตำเเหน่งในมหาลัย</a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;"onclick="PositionJob()" >ข้อมูลตำเเหน่งในสายงาน</a>
                    </li>
                      <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;"onclick="PositionMange()" >ข้อมูลตำเเหน่งผู้บริหาร</a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;" onclick="Academy()" >ข้อมูลมหาวิทยาลัย</a>
                    </li>
                      <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;" onclick="LeaveType()" >ข้อมูลประเภทการลา</a>
                    </li>
                      <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;"onclick="Major()" >ข้อมูลสาขาวิชา</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;"onclick="Blood()" >ข้อมูลกรุ๊ปเลือด</a>
                    </li>
                    
                </ul> 
              
            </div>
        </nav>--%>
    <%--    <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id=""> 
                <ul  class="navbar-nav" style="color: black !important; font-family: TH SarabunPSK;">
                     <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;"onclick="Class()" >ข้อมูลชั้นเรียน</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;"onclick="College()" >ข้อมูลวิทยาลัย</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;"onclick="Country()" >ข้อมูลประเทศ</a>
                    </li>
                   <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;"onclick="CourseGroup()" >ข้อมูลกลุ่มหมวด</a>
                    </li>
                   <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;"onclick="CourseMain()" >ข้อมูลหลักสูตร</a>
                    </li>
                   <li class="nav-item">
                        <a class="nav-link" href="#" style="color:lightgray;"onclick="CurrentStatus()" >ข้อมูลสถานะปัจจุบัน</a>
                    </li>
                </ul>
            </div>
        </nav>--%>
    <div id="Divterm" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivPosition" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivPositionJob" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivPositionMange" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivMajor" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivBlood" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivAcademy" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivLeaveType" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivClass" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivCollege" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivCountry" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivCourseGroup" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivCourseMain" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivCurrentStatus" style="display: none; margin-top: 10px;">
    </div>
    <div id="DivCourse" style="display: none; margin-top: 10px;">
        <div class="container">
            <div class="row">
                <div class="form-group">
                    <div class="input-group mb-2">
                        <span style="margin: 10px;">ปีการศึกษา</span><select style="margin: 10px; width: 100px;" class="form-control" id="CbCourseyearno"></select>
                        <span style="margin: 10px;">ภาค</span><select style="margin: 10px; width: 100px;" class="form-control" id="CbCourseterm"></select>
                        <span style="margin: 10px;">ชั้นปี</span><select style="margin: 10px; width: 100px;" class="form-control" id="CbCourseclass"></select>
                        <span style="margin: 10px;">หลักสูตร</span><select style="margin: 10px; width: 400px;" class="form-control" id="CbCoursecourse"></select>
                        <button style="margin: 10px; font-size: 14px; border-radius: 1px;" class="btn btn-info" onclick="BindCourse();"><span>ค้นหา</span></button>
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
                        <button style="margin: 10px; font-size: 14px; border-radius: 1px;" class="btn btn-info" onclick="Searchcalendar();"><span>ค้นหา</span></button>
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
                    <input type="button" style="font-size: 14px; border-radius: 1px;" class="btn btn-secondary" value="บันทึกข้อมูลปฏิทิน" onclick="Savecalendar()" />
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
                                <div id="DtpMasteristerdatefrom" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="TxtMasteristerdatefrom" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-2">
                                <span>ถึง</span>
                            </div>
                            <div class="col-3">
                                <div id="DtpMasteristerdateto" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="TxtMasteristerdateto" class="form-control" type="text" />
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
    <div class="modal" id="DivmodalPosition" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <input type="hidden" id="HdPositionId" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลตำเเหน่ง</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อตำเเหน่ง</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="TxtPositionName" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SavePosition();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="DivmodalAcademy" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <input type="hidden" id="HdAcademyId" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลชื่อมหาวิทยาลัย</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อมหาวิทยาลัย</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="TxtAcademyName" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SaveAcademy();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="DivmodalLeaveType" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <input type="hidden" id="HdLeaveTypeId" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลประเภทการลา</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อประเภทการลา</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="TxtLeaveTypeName" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SaveLeaveType();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
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
    <div class="modal" id="DivmodalPositionJob" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <input type="hidden" id="HdPositionJobId" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลตำเเหน่งในสายงาน
                    </span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อตำเเหน่งในสายงาน</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="TxtPositionJobName" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SavePositionJob();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="DivmodalPositionMange" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <input type="hidden" id="HdJobPositionMangeId" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลตำเเหน่งผู้บริหาร
                    </span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อตำเเหน่งผู้บริหาร</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="TxtPositionMangeName" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SavePositionMange();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="DivmodalMajor" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <input type="hidden" id="HdMajorId" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลสาขาวิชา
                    </span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อสาขาวิชา</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="TxtMajorName" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SaveMajor();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="DivmodalBlood" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <input type="hidden" id="HdBloodId" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลกรุ๊ปเลือด
                    </span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อกรุ๊ปเลือด</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="TxtBloodName" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SaveBlood();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="DivmodalClass" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <input type="hidden" id="HdClassId" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูล Class
                    </span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อ Class</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="TxtClassName" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SaveClass();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="DivmodalCollege" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <input type="hidden" id="HdCollegeId" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลวิทยาลัย
                    </span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อวิทยาลัย</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="TxtCollegeName" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SaveCollege();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="DivmodalCountry" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <input type="hidden" id="HdCountryId" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลประเทศ
                    </span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อประเทศ</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="TxtCountryName" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SaveCountry();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="DivmodalCourseGroup" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <input type="hidden" id="HdCourseGroupId" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลหมวดหลักสูตร
                    </span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อหมวดหลักสูตร</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="TxtCourseGroupName" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SaveCourseGroup();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="DivmodalCourseMain" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <input type="hidden" id="HdCourseMainId" value="" />
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลหลักสูตร
                    </span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>หมวดหลักสูตร</span>
                            </div>
                            <div class="col-3">
                                <select class="form-control" id="CbCourseGroup"></select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อหลักสูตร</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="TxtCourseMainName" class="form-control" />
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-3">
                                <span>วิทยาลัย</span>
                            </div>
                            <div class="col-3">
                                <select class="form-control" id="CbCollege"></select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>หน่วยงานที่รับผิดชอบ</span>
                            </div>
                            <div class="col-3">
                                <select class="form-control" id="CbOwnerOrg"></select>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="SaveCourseMain();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
</body>
</html>
