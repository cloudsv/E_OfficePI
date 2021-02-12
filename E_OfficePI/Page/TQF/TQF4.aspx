<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TQF4.aspx.cs" Inherits="E_OfficePI.Page.TQF.TQF4" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

       <link href="../../js/datepicker/datepicker.css" rel="stylesheet" />
    <link href="../../Select2/css/bootstrap-select.css" rel="stylesheet" />
    <title></title>
   <style>
             #back2Top {
    width: 60px;
    line-height: 60px;
    overflow: hidden;
    z-index: 999;
    display: none;
    cursor: pointer;
    -moz-transform: rotate(270deg);
    -webkit-transform: rotate(270deg);
    -o-transform: rotate(270deg);
    -ms-transform: rotate(270deg);
    transform: rotate(270deg);
    position: fixed;
    bottom: 50px;
    right: 10px;
   
    background-color: red;
    color:white;
    text-align: center;
    font-size: 30px;
    text-decoration: none;
}
#back2Top:hover {
    background-color: #DDF;
    color: #000;
}
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

            function Closenewquality() {
                $('#Divnewquality').modal('hide');
            }
            function Savequality() {
                var json = '';
                var html = '';
                json += $('#Txtnewquality').val();
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Savequality",
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
                        $('#Divnewquality').modal('hide');
                        Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                        Gettraining();
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }


            function Closenewservicelv() {
                $('#Divnewservicelv').modal('hide');
            }
            function Saveservicelv() {
                var json = '';
                var html = '';
                json += $('#Txtnewservicelv').val();
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Saveservicelv",
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
                        $('#Divnewservicelv').modal('hide');
                        Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                        Gettraining();
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }

            function Closenewtrainingsource() {
                $('#Divnewtrainingsource').modal('hide');
            }
            function Savetrainingsource() {
                var json = '';
                var html = '';
                json += $('#Txtnewtrainingsource').val();
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Savetrainingsource",
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
                        $('#Divnewtrainingsource').modal('hide');
                        Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                        Gettraining();
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }


            function Addtrainingsource() {
                $('#Txtnewtrainingsource').val('');
                $('#Divnewtrainingsource').modal('show');
            }
            function Addservicelv() {
                $('#Txtnewservicelv').val('');
                $('#Divnewservicelv').modal('show');
            }
            function Addquality() {
                $('#Txtnewquality').val('');
                $('#Divnewquality').modal('show');
            }


            
            function Deltraining(Trainingid) {
                var json = '';
                json = '';
                json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                json += 'Trainingid :' + Trainingid + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Deltraining",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {

                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        Gettraining();
                    },
                    async: false,
                    error: function (er) {

                    }
                });
            }
            function Delquality(Trainingid, x) {
                var json = '';
                json = '';
                json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                json += 'Trainingid :' + Trainingid + '|';
                json += 'val :' + x + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Delquality",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {

                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        Gettraining();
                    },
                    async: false,
                    error: function (er) {

                    }
                });
            }
          
            function Deltrainingsource (Trainingid, x) {
                var json = '';
                json = '';
                json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                json += 'Trainingid :' + Trainingid + '|';
                json += 'val :' + x + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Deltrainingsource ",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {

                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        Gettraining();
                    },
                    async: false,
                    error: function (er) {

                    }
                });
            }
            function Delservicelv(Trainingid, x) {
                var json = '';
                json = '';
                json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                json += 'Trainingid :' + Trainingid + '|';
                json += 'val :' + x + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Delservicelv",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {

                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        Gettraining();
                    },
                    async: false,
                    error: function (er) {

                    }
                });
            }
            function Getsubjectgroup() {

                var json;
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Getsubjectgroup",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;

                        $('#Cbsubjectgroup').find('option').remove().end();

                        if (res.length == 0) {
                            $('#Cbsubjectgroup').append($('<option/>', {
                                value: '',
                                text: ''
                            }));
                        }
                        else {
                            for (i = 0; i < res.length; i++) {
                                $('#Cbsubjectgroup').append($('<option/>', {
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

            function Deleteebook(x) {
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Deleteebook",
                    data: "{'json' :'" + x + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        Updateebook();
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res != "") {
                            Msgbox(res);
                            return;
                        }
                        Getebook();
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            function Newebook() {
                var json = $('#HdTQFId').val();
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Newebook",
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
                        Getebook();
                    },
                    async: true,
                    error: function (er) {

                    }
                });


            }
            function Updateebook() {

                var json = $('#HdTQFId').val();
                var dat = '';
                $('#Divebook').find('textarea').each(function () {
                    dat += $(this).attr('id') + ':' + $(this).val() + '|';
                });
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Updateebook",
                    data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                        Getebook();
                        Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            function Getebook() {

                var html = '';
                var json = $('#HdTQFId').val();
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Getebook",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res == null) {
                            Msgbox('ไม่สามารถแสดงข้อมูลมคอ. ได้ โปรดติดต่อผู้ดูแลระบบ');
                            return;
                        }
                        html += '<table class="table table-bordered">';

                        if (res.length == 0) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<div style="color:red;text-align:center;height:50px;">ไม่พบข้อมูล</div>';
                            html += '</td>';
                            html += '</tr>';
                        }
                        else {
                            for (i = 0; i < res.length; i++) {
                                html += '<tr>';
                                html += '<td style="width:90%">';
                                html += '<textarea class="form-control" onblur="Updateebook();" id="Txtebook_' + res[i]['TQFebookId'] + '" >' + res[i]['Value'] + '</textarea>';
                                html += '</td>';


                                html += '<td>';
                                html += '<button onclick="Deleteebook(' + res[i]['TQFebookId'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';

                                html += '</td>';
                                html += '</tr>';
                            }
                        }
                        html += '</table>';
                        $('#Divebook').html(html);
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }

            function Deletejournal(x) {
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Deletejournal",
                    data: "{'json' :'" + x + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        Updatejournal();
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res != "") {
                            Msgbox(res);
                            return;
                        }
                        Getjournal();
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            function Newjournal() {
                var json = $('#HdTQFId').val();
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Newjournal",
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
                        Getjournal();
                    },
                    async: true,
                    error: function (er) {

                    }
                });


            }
            function Updatejournal() {

                var json = $('#HdTQFId').val();
                var dat = '';
                $('#Divjournal').find('textarea').each(function () {
                    dat += $(this).attr('id') + ':' + $(this).val() + '|';
                });
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Updatejournal",
                    data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                        Getjournal();
                        Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            function Getjournal() {

                var html = '';
                var json = $('#HdTQFId').val();
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Getjournal",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res == null) {
                            Msgbox('ไม่สามารถแสดงข้อมูลมคอ. ได้ โปรดติดต่อผู้ดูแลระบบ');
                            return;
                        }
                        html += '<table class="table table-bordered">';

                        if (res.length == 0) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<div style="color:red;text-align:center;height:50px;">ไม่พบข้อมูล</div>';
                            html += '</td>';
                            html += '</tr>';
                        }
                        else {
                            for (i = 0; i < res.length; i++) {
                                html += '<tr>';
                                html += '<td style="width:90%">';
                                html += '<textarea class="form-control" onblur="Updatejournal();" id="Txtjournal_' + res[i]['TQFjournalId'] + '" >' + res[i]['Value'] + '</textarea>';
                                html += '</td>';


                                html += '<td>';
                                html += '<button onclick="Deletejournal(' + res[i]['TQFjournalId'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';

                                html += '</td>';
                                html += '</tr>';
                            }
                        }
                        html += '</table>';
                        $('#Divjournal').html(html);
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }






            function DeleteTool(x) {
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/DeleteTool",
                    data: "{'json' :'" + x + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        UpdateTool();
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res != "") {
                            Msgbox(res);
                            return;
                        }
                        GetTool();
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            function NewTool() {
                var json = $('#HdTQFId').val();
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/NewTool",
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
                        GetTool();
                    },
                    async: true,
                    error: function (er) {

                    }
                });


            }
            function UpdateTool() {

                var json = $('#HdTQFId').val();
                var dat = '';
                $('#DivTool').find('textarea').each(function () {
                    dat += $(this).attr('id') + ':' + $(this).val() + '|';
                });
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/UpdateTool",
                    data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                        GetTool();
                        Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            function GetTool() {

                var html = '';
                var json = $('#HdTQFId').val();
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/GetTool",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res == null) {
                            Msgbox('ไม่สามารถแสดงข้อมูลมคอ. ได้ โปรดติดต่อผู้ดูแลระบบ');
                            return;
                        }
                        html += '<table class="table table-bordered">';

                        if (res.length == 0) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<div style="color:red;text-align:center;height:50px;">ไม่พบข้อมูล</div>';
                            html += '</td>';
                            html += '</tr>';
                        }
                        else {
                            for (i = 0; i < res.length; i++) {
                                html += '<tr>';
                                html += '<td style="width:90%">';
                                html += '<textarea class="form-control" onblur="UpdateTool();" id="TxtTool_' + res[i]['TQFToolId'] + '" >' + res[i]['Value'] + '</textarea>';
                                html += '</td>';


                                html += '<td>';
                                html += '<button onclick="DeleteTool(' + res[i]['TQFToolId'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';

                                html += '</td>';
                                html += '</tr>';
                            }
                        }
                        html += '</table>';
                        $('#DivTool').html(html);
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }





            function Deleteinquiry(x) {
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Deleteinquiry",
                    data: "{'json' :'" + x + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        Updateinquiry();
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res != "") {
                            Msgbox(res);
                            return;
                        }
                        Getinquiry();
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            function Newinquiry() {
                var json = $('#HdTQFId').val();
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Newinquiry",
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
                        Getinquiry();
                    },
                    async: true,
                    error: function (er) {

                    }
                });


            }
            function Updateinquiry() {

                var json = $('#HdTQFId').val();
                var dat = '';
                $('#Divinquiry').find('textarea').each(function () {
                    dat += $(this).attr('id') + ':' + $(this).val() + '|';
                });
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Updateinquiry",
                    data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                        Getinquiry();
                        Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            function Getinquiry() {

                var html = '';
                var json = $('#HdTQFId').val();
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Getinquiry",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        res = response.d;
                        if (res == null) {
                            Msgbox('ไม่สามารถแสดงข้อมูลมคอ. ได้ โปรดติดต่อผู้ดูแลระบบ');
                            return;
                        }
                        html += '<table class="table table-bordered">';

                        if (res.length == 0) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<div style="color:red;text-align:center;height:50px;">ไม่พบข้อมูล</div>';
                            html += '</td>';
                            html += '</tr>';
                        }
                        else {
                            for (i = 0; i < res.length; i++) {
                                html += '<tr>';
                                html += '<td style="width:90%">';
                                html += '<textarea class="form-control" onblur="Updateinquiry();" id="Txtinquiry_' + res[i]['TQFinquiryId'] + '" >' + res[i]['Value'] + '</textarea>';
                                html += '</td>';


                                html += '<td>';
                                html += '<button onclick="Deleteinquiry(' + res[i]['TQFinquiryId'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';

                                html += '</td>';
                                html += '</tr>';
                            }
                        }
                        html += '</table>';
                        $('#Divinquiry').html(html);
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }










            function SearchapproveTQF() {
                var Cri = '';
                ClearResource('TQF/TQF4.aspx', 'Gvsearchcourseapprove');
                var Columns = ["วิชา!L", "รุ่น!C", "ปี!C", "สถานะ!C"];
                var Data = ["subjectname", "Generation", "Year", "Statusname"];
                var Searchcolumns = ["วิชา"];
                var SearchesDat = ["subjectname"];
                var Width = ["50%", "10%", "10%", "10%"];

                var Gvsearchcourse = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchcourseapprove', 1000, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', '', 'id', Cri, '');
                $('#Divsearchcourseapprove').html(Gvsearchcourse._Tables());
                Gvsearchcourse._Bind();
            }
            function SearchTQF() {
                var Cri = $('#Cbsearchcourse').val();
                ClearResource('TQF/TQF4.aspx', 'Gvsearchcourse');
                var Columns = ["วิชา!L", "รุ่น!C", "ปี!C", "!C", "สถานะ!C"];
                var Data = ["subjectname", "Generation", "Year", "Del", "Statusname"];
                var Searchcolumns = ["วิชา"];
                var SearchesDat = ["subjectname"];
                var Width = ["50%", "10%", "10%", "10%"];

                var Gvsearchcourse = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchcourse', 1000, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', '', 'id', Cri, '');
                $('#Divsearchcourse').html(Gvsearchcourse._Tables());
                Gvsearchcourse._Bind();
            }
            function ApproveTQFS() {
                $('#Divdetail').hide();
                $('#Divmaster').hide();
                $('#Divapprove').hide();
                $('#Divapprove').show();
                SearchapproveTQF();
            }
            function TQFS() {
                $('#Divdetail').hide();
                $('#Divmaster').hide();
                $('#Divapprove').hide();
                $('#Divmaster').show();
                SearchTQF();
            }
            function Closeshowcomment() {
                $('#Divshowcomment').modal('hide');
            }
            function Showcomment(x) {
                var json = x;

                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Showcomment",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        $('#Divshowcomment').modal('show');
                        $('#Txtshowcomment').val(response.d);
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            function Closecomment() {
                $('#Divcomment').modal('hide');
            }



            function Doreject() {
                var json = '';
                json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                json += 'Hdapprove:' + $('#Hdapprove').val() + '|';
                json += 'Txtcomment:' + $('#Txtcomment').val() + '|';


                $("#DivConfirm").modal('show');
                $('#DivConfirmMsg').html('ยืนยันการปฏิเสธ ?');
                $('#CmdConfirm').on('click', function () {
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Doreject",
                        data: "{'json' :'" + json + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        beforeSend: function () {
                            $(".loader").fadeOut("slow");
                        },
                        success: function (response) {
                            $("#DivConfirm").modal('hide');
                            $('#Divcomment').modal('hide');
                            Msgboxsuccess('ปฏิเสธเรียบร้อยแล้ว')
                            ApproveTQFS();

                        },
                        async: false,
                        error: function (er) {
                        }
                    });
                });
            }
            function Doedit() {
                var json = '';
                json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                json += 'Hdapprove:' + $('#Hdapprove').val() + '|';
                json += 'Txtcomment:' + $('#Txtcomment').val() + '|';


                $("#DivConfirm").modal('show');
                $('#DivConfirmMsg').html('ยืนยันการส่งกลับแก้ไข ?');
                $('#CmdConfirm').on('click', function () {
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Doedit",
                        data: "{'json' :'" + json + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        beforeSend: function () {
                            $(".loader").fadeOut("slow");
                        },
                        success: function (response) {
                            $("#DivConfirm").modal('hide');
                            $('#Divcomment').modal('hide');
                            Msgboxsuccess('ส่งกลับแก้ไขเรียบร้อยแล้ว')
                            ApproveTQFS();

                        },
                        async: false,
                        error: function (er) {
                        }
                    });
                });


            }
            function Doapprove() {
                var json = '';
                json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                json += 'Hdapprove:' + $('#Hdapprove').val() + '|';
                json += 'Txtcomment:' + $('#Txtcomment').val() + '|';
                $("#DivConfirm").modal('show');
                $('#DivConfirmMsg').html('ยืนยันการอนุมัติ ?');
                $('#CmdConfirm').on('click', function () {
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Doapprove",
                        data: "{'json' :'" + json + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        beforeSend: function () {
                            $(".loader").fadeOut("slow");
                        },
                        success: function (response) {
                            $("#DivConfirm").modal('hide');
                            $('#Divcomment').modal('hide');
                            Msgboxsuccess('ตรวจสอบ/อนุมัติเรียบร้อยแล้ว')
                            ApproveTQFS();

                        },
                        async: false,
                        error: function (er) {
                        }
                    });
                });
            }

            function Approve(id) {
                $('#divtab').find('button').hide();
                $('#Txtcomment').val('');
                $('#Hdapprove').val('A');
                RowSelect('Gvsearchcourse', id);
            }

            function Validate(id) {
                $('#divtab').find('button').hide();
                $('#Txtcomment').val('');
                $('#Hdapprove').val('V');
                RowSelect('Gvsearchcourse', id);
            }
            function Send2validate() {
                var json = '';
                var html = '';
                json += $('#HdTQFId').val();
                if ($('#Hdapprove').val() == '') {
                    $("#DivConfirm").modal('show');
                    $('#DivConfirmMsg').html('ยืนยันการอนุมัติ ?');
                    $('#CmdConfirm').on('click', function () {


                        $.ajax({
                            type: "POST",
                            url: "\../Page/TQF/TQF4.aspx/Send2validate",
                            data: "{'json' :'" + json + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            beforeSend: function () {
                                $(".loader").fadeOut("slow");
                            },
                            success: function (response) {
                                $("#DivConfirm").modal('hide');
                                Msgboxsuccess('ส่งตรวจสอบเรียบร้อยแล้ว')
                                TQFS();
                            },
                            async: false,
                            error: function (er) {
                            }
                        });


                    });



                }
                else if ($('#Hdapprove').val() == 'V') {
                    $("#Divcomment").modal('show');
                }
                else if ($('#Hdapprove').val() == 'A') {
                    $("#Divcomment").modal('show');
                }
            }

            function SelectTQF(id) {
                var json = '';
                json += id;
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/SelectTQF",
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
                        $('#Hdapprove').val('');
                        RowSelect('Gvsearchcourse', id);
                    },
                    async: false,
                    error: function (er) {
                    }
                });

            }

            /*Scroll to top when arrow up clicked BEGIN*/
            $(window).scroll(function () {
                var height = $(window).scrollTop();
                if (height > 100) {
                    $('#back2Top').fadeIn();
                } else {
                    $('#back2Top').fadeOut();
                }
            });
            $(document).ready(function () {
                $("#back2Top").click(function (event) {
                    event.preventDefault();
                    $("html, body").animate({ scrollTop: 0 }, "slow");
                    return false;
                });

            });
 /*Scroll to top when arrow up clicked END*/
    </script>
    <script>
        
        function DelTQF(id) {
            var json = '';
            var html = '';
            $("#DivConfirm").modal('show');
            $('#DivConfirmMsg').html('ยืนยันการลบรายการ ?');
            $('#CmdConfirm').on('click', function () {
                json = id;
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/DelTQF",
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
                        SearchTQF();
                        $("#DivConfirm").modal('hide');
                        Msgboxsuccess('ลบข้อมูลเรียบร้อยแล้ว');

                    },
                    async: false,
                    error: function (er) {
                    }
                });
            });

        }
        function PostDelete(ctrl, dat) {
            if (ctrl == "GvresponsibleInstructor") {

                BindresponsibleInstructor();
            }
            else if (ctrl == "GvtheoryInstructor") {
                BindtheoryInstructor();
            }
            else if (ctrl == "GvextraInstructor") {
                BindextraInstructor();
            }
            else if (ctrl == "GvpreInstructor") {
                BindpreInstructor();
            }
            else if (ctrl == 'Gvebook') {
                Bindebook();
            }
            else if (ctrl == 'Gvtextbook') {
                Bindtextbook();
            }
            else if (ctrl == 'Gvtool') {
                Bindtool();
            }
            else if (ctrl == 'Gvjournal') {
                Bindjournal();
            }
            else if (ctrl == 'Gvinquiry') {
                Bindinquiry();
            }
        }
        function Selectedtextbook(x) {
            var json = '';
            json += 'x :' + x + '|';
            json += 'TQFId :' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "TQF/TQF4.aspx/Selectedtextbook",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    res = response.d;
                    if (res != '') {
                        Msgbox(res);
                        return;
                    }
                    Bindtextbook();
                    $('#Divmodaltextbook').modal('hide');
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Selectedebook(x) {
            var json = '';
            json += 'x :' + x + '|';
            json += 'TQFId :' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "TQF/TQF4.aspx/Selectedebook",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    res = response.d;
                    if (res != '') {
                        Msgbox(res);
                        return;
                    }
                    Bindebook();
                    $('#Divmodalebook').modal('hide');
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Selectedinquiry(x) {
            var json = '';
            json += 'x :' + x + '|';
            json += 'TQFId :' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "TQF/TQF4.aspx/Selectedinquiry",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    res = response.d;
                    if (res != '') {
                        Msgbox(res);
                        return;
                    }
                    Bindinquiry();
                    $('#Divmodalinquiry').modal('hide');
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Selectedjournal(x) {
            var json = '';
            json += 'x :' + x + '|';
            json += 'TQFId :' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "TQF/TQF4.aspx/Selectedjournal",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    res = response.d;
                    if (res != '') {
                        Msgbox(res);
                        return;
                    }
                    Bindjournal();
                    $('#Divmodaljournal').modal('hide');
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Selectedtool(x) {
            var json = '';
            json += 'x :' + x + '|';
            json += 'TQFId :' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "TQF/TQF4.aspx/Selectedtool",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    res = response.d;
                    if (res != '') {
                        Msgbox(res);
                        return;
                    }
                    Bindtool();
                    $('#Divmodaltool').modal('hide');
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Newtextbook() {
            ClearResource('TQF/TQF4.aspx', 'Gvsearchtextbook');
            var Cri = $('#HdTQFId').val();
            var Columns = ["Textbook!L"];
            var Data = ["Textbook"];
            var Searchcolumns = ["Textbook!L"];
            var SearchesDat = ["Textbook"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchtextbook', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divtextbookcont').html(Gv._Tables());
            Gv._Bind();
            $('#Divmodaltextbook').modal('show');
        }
        //function Newebook() {
        //    ClearResource('TQF/TQF4.aspx', 'Gvsearchebook');
        //    var Cri = $('#HdTQFId').val();
        //    var Columns = ["E-Book!L"];
        //    var Data = ["Ebook"];
        //    var Searchcolumns = ["E-Book"];
        //    var SearchesDat = ["Ebook"];
        //    var Width = ["100%"];
        //    var Gv = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchebook', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
        //    $('#Divebookcont').html(Gv._Tables());
        //    Gv._Bind();
        //    $('#Divmodalebook').modal('show');
        //}
        //function Newinquiry()
        //{
        //    ClearResource('TQF/TQF4.aspx', 'Gvsearchinquiry');
        //    var Cri = $('#HdTQFId').val();
        //    var Columns = ["ระบบสืบค้น!L"];
        //    var Data = ["Inquiry"];
        //    var Searchcolumns = ["ระบบสืบค้น"];
        //    var SearchesDat = ["Inquiry"];
        //    var Width = ["100%"];
        //    var Gv = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchinquiry', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
        //    $('#Divinquirycont').html(Gv._Tables());
        //    Gv._Bind();
        //    $('#Divmodalinquiry').modal('show');
        //}


        //function Newjournal() {
        //    ClearResource('TQF/TQF4.aspx', 'Gvsearchjournal');
        //    var Cri = $('#HdTQFId').val();
        //    var Columns = ["วารสารวิชาการ!L"];
        //    var Data = ["Journal"];
        //    var Searchcolumns = ["วารสารวิชาการ"];
        //    var SearchesDat = ["Journal"];
        //    var Width = ["100%"];
        //    var Gv = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchjournal', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
        //    $('#Divjournalcont').html(Gv._Tables());
        //    Gv._Bind();
        //    $('#Divmodaljournal').modal('show');
        //}
        //function Newtool() {
        //    ClearResource('TQF/TQF4.aspx', 'Gvsearchtool');
        //    var Cri = $('#HdTQFId').val();
        //    var Columns = ["เครื่องมือ!L"];
        //    var Data = ["tool"];
        //    var Searchcolumns = ["เครื่องมือ"];
        //    var SearchesDat = ["tool"];
        //    var Width = ["100%"];
        //    var Gv = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchtool', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
        //    $('#Divtoolcont').html(Gv._Tables());
        //    Gv._Bind();
        //    $('#Divmodaltool').modal('show');
        //}
        function Bindnewobjective() {

            ClearResource('TQF/TQF4.aspx', 'Gvnewobjective');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วัตถุประสงค์!L"];
            var Data = ["Objective"];
            var Searchcolumns = ["วัตถุประสงค์!L"];
            var SearchesDat = ["Objective"];
            var Width = ["100%"];
            var Gvnewobjective = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvnewobjective', 30, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', 'id', 'id', Cri, '');
            $('#Divmodalobjectivecont').html(Gvnewobjective._Tables());
            Gvnewobjective._Bind();
        } 
     
        function Bindebook() {
            ClearResource('TQF/TQF4.aspx', 'Gvebook');
            var Cri = $('#HdTQFId').val();
            var Columns = ["E-Book!L"];
            var Data = ["Ebook"];
            var Searchcolumns = ["E-Book"];
            var SearchesDat = ["Ebook"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvebook', 30, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divebook').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindinquiry() {

            ClearResource('TQF/TQF4.aspx', 'Gvinquiry');
            var Cri = $('#HdTQFId').val();
            var Columns = ["ระบบสืบค้น!L"];
            var Data = ["Inquiry"];
            var Searchcolumns = ["ระบบสืบค้น"];
            var SearchesDat = ["Inquiry"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvinquiry', 30, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divinquiry').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindjournal() {

            ClearResource('TQF/TQF4.aspx', 'Gvjournal');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วารสารวิชาการ!L"];
            var Data = ["Journal"];
            var Searchcolumns = ["วารสารวิชาการ"];
            var SearchesDat = ["Journal"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvjournal', 30, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divjournal').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindtool() {

            ClearResource('TQF/TQF4.aspx', 'Gvtool');
            var Cri = $('#HdTQFId').val();
            var Columns = ["ตำรารอง / เอกสารเพิ่มเติม!L"];
            var Data = ["tool"];
            var Searchcolumns = ["ตำรารอง / เอกสารเพิ่มเติม"];
            var SearchesDat = ["tool"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvtool', 30, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divtool').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindtextbook() {

            ClearResource('TQF/TQF4.aspx', 'Gvtextbook');
            var Cri = $('#HdTQFId').val();
            var Columns = ["Textbook!L"];
            var Data = ["Textbook"];
            var Searchcolumns = ["Textbook!L"];
            var SearchesDat = ["Textbook"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvtextbook', 30, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divtextbook').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindnewobjective() {

            ClearResource('TQF/TQF4.aspx', 'Gvnewobjective');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วัตถุประสงค์!L"];
            var Data = ["Objective"];
            var Searchcolumns = ["วัตถุประสงค์!L"];
            var SearchesDat = ["Objective"];
            var Width = ["100%"];
            var Gvnewobjective = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvnewobjective', 30, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', 'id', 'id', Cri, '');
            $('#Divmodalobjectivecont').html(Gvnewobjective._Tables());
            Gvnewobjective._Bind();
        }
        function Updatetqfestimate(ctrl) {
            var json = '';


            json += 'ctrl:' + ctrl + '|';

            json += 'val:' + $('#' + ctrl).prop("checked") + '|';
            json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updatetqfestimate",
                data: "{'json'  : '" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d != '') {
                        Msgbox(res);
                        return;
                    }
                    Getlearningoutput();
                },
                async: false,
                error: function (er) {

                }
            });

        }

        
        function Updatetqfestimateobj(ctrl) {
            var json = '';


            json += 'ctrl:' + ctrl + '|';

            json += 'val:' + $('#' + ctrl).prop("checked") + '|';
            json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updatetqfestimateobj",
                data: "{'json'  : '" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d != '') {
                        Msgbox(res);
                        return;
                    }
                    Getestimate();
                },
                async: false,
                error: function (er) {

                }
            });

        }
        function Updatetqftrainingsource(ctrl) {
            var json = '';


            json += 'ctrl:' + ctrl + '|';

            json += 'val:' + $('#' + ctrl).prop("checked") + '|';
            json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updatetqftrainingsource",
                data: "{'json'  : '" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d != '') {
                        Msgbox(res);
                        return;
                    }
                    Gettraining();
                },
                async: false,
                error: function (er) {

                }
            });

        }
        function UpdatetqfserviceLv(ctrl) {
            var json = '';


            json += 'ctrl:' + ctrl + '|';

            json += 'val:' + $('#' + ctrl).prop("checked") + '|';
            json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/UpdatetqfserviceLv",
                data: "{'json'  : '" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d != '') {
                        Msgbox(res);
                        return;
                    }
                    Gettraining();
                },
                async: false,
                error: function (er) {

                }
            });

        }
        function Updatetqfquality(ctrl) {
            var json = '';


            json += 'ctrl:' + ctrl + '|';

            json += 'val:' + $('#' + ctrl).prop("checked") + '|';
            json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updatetqfquality",
                data: "{'json'  : '" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d != '') {
                        Msgbox(res);
                        return;
                    }
                    Gettraining();
                },
                async: false,
                error: function (er) {

                }
            });

        }
        function Updatetqfparticular(ctrl)
        {
            var json = '';
            
          
            json += 'ctrl:' + ctrl + '|';
            
            json += 'val:' + $('#' + ctrl).prop("checked") + '|';
            json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updatetqfparticular",
                data: "{'json'  : '" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d != '') {
                        Msgbox(res);
                        return;
                    }
                    Getlearningoutput();
                },
                async: false,
                error: function (er) {

                }
            });

        }
        function Getestimate() {
            var json = $('#HdTQFId').val();
            var html = '';
            var i = 0;
            var j = 0;
            var x = 0;
            var isfound = false;
            var res;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getestimate",
                data: "{'json'  : '" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    res = response.d;
                    if (res == null) {
                        Msgbox('ไม่สามารถดึงข้อมูลหลักเกณฑ์การประเมินผล โปรดติดต่อผู้ดูแลระบบ');
                        return;

                    }
                    html += '<div class="row mt-1">';
                    html += '<div class="col-12">';
                    html += '<table class="table table-bordered" style="margin-top: 10px;">';
                    html += '<tr>';
                    html += '<td>ผลการเรียนรู้';
                    html += '</td>';
                    html += '<td>งานที่ใช้ในการประเมิน';
                    html += '</td>';
                    html += '<td>สัดส่วนการประเมิน';
                    html += '</td>';
                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {

                            html += '<tr>';
                            
                            html += '<td>';
                            for (j = 0; j < res[i]['Templateobjective'].length; j++) {
                                html += '<div>';
                                isfound = false;
                                for (x = 0; x < res[i]['Objective'].length; x++) {
                                    if (res[i]['Templateobjective'][j]['Objectiveid'] == res[i]['Objective'][x]['Objectiveid']) {
                                        isfound = true;
                                    }
                                }
                                if (isfound) {
                                    html += '<input type="checkbox" id="Chkestimateobjective_' + res[i]['Estimateid'] + '_' + res[i]['Templateobjective'][j]['Objectiveid'] + '" onclick="Updatetqfestimateobj(\'Chkestimateobjective_' + res[i]['Estimateid'] + '_' + res[i]['Templateobjective'][j]['Objectiveid'] + '\');" checked />&nbsp;<span>' + res[i]['Templateobjective'][j]['Objectivename'] + '</span>';
                                }
                                else {
                                    html += '<input type="checkbox" id="Chkestimateobjective_' + res[i]['Estimateid'] + '_' + res[i]['Templateobjective'][j]['Objectiveid'] + '" onclick="Updatetqfestimateobj(\'Chkestimateobjective_' + res[i]['Estimateid'] + '_' + res[i]['Templateobjective'][j]['Objectiveid'] + '\');" />&nbsp;<span>' + res[i]['Templateobjective'][j]['Objectivename'] + '</span>';
                                }
                                html += '<div>';
                            }
                            html += '</td>';
                            html += '<td>';
                            //html += '<textarea id="Txtestimatedesc_' + res[i]['Estimateid'] + '" readonly=readonly class="form-control"></textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<span>ร้อยละ</span>&nbsp;<input id="Txtratio_' + res[i]['Estimateid'] + '" onblur="Updateratio(\'' + res[i]['Estimateid'] + '\',\'Txtratio_' + res[i]['Estimateid'] + '\');" type="number" min="0" max="100" id="Txtestimateratio_' + res[i]['Estimateid'] + '" class="form-control" value=\'' + res[i]['Ratio'] + '\'/>';
                            html += '</td>';
                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deleteestimate(' + res[i]['Estimateid'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr > ';
                        }
                    }
                    else {
                        html += '<tr><td colspan="4" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>';
                    html += '</div>';
                    html += '</div>';

                    $('#Divestimate').html(html);
                },
                async: false,
                error: function (er) {

                }
            });

        }
        function Gettraining() {
            var json = $('#HdTQFId').val();
            var html = '';
            var i = 0;
            var j = 0;
            var k = 0;
            var x = 0;
            var isfound = false;
            var res;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Gettraining",
                data: "{'json'  : '" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    res = response.d;
                    if (res == null) {
                        Msgbox('ไม่สามารถดึงข้อมูลการกำหนดสถานที่ฝึก โปรดติดต่อผู้ดูแลระบบ');
                        return;

                    }
                    html += '<div class="row mt-1">';
                    html += '<div class="col-12">';
                    html += '<table class="table table-bordered" style="margin-top: 10px;">';
                    html += '<tr>';
                    html += '<td style="width:40%;">แหล่งฝึก';
                    html += '</td>';
                    html += '<td style="width:30%;">ระดับสถานะบริการ';
                    html += '</td>';
                    html += '<td style="width:30%;">ระบบคุณภาพ';
                    html += '</td>';
                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';



                    for (i = 0; i < response.d.length; i++) {

                        html += '<tr>';


                        html += '<td style="width:40%;">';


                        html += "<table  class='table table-bordered' style='table-layout: fixed;width:100%;'>";


                        for (j = 0; j < response.d[i]['Trainingsource'].length; j++) {
                            html += "<tr>";
                            html += "<td style='width: 80%;'>";

                            html += '<select id="Cbtrainingsources_' + response.d[i]['Trainingid'] + '_' + response.d[i]['Trainingsource'][j]['Trainingsourceid'] + '" class="form-control">';

                            for (k = 0; k < response.d[i]['Templatetrainingsource'].length; k++) {
                                html += '<option value="' + response.d[i]['Templatetrainingsource'][k]['Trainingsourceid'] + '">' + response.d[i]['Templatetrainingsource'][k]['Trainingsourcename'] + '</option>';
                            }
                            html += '</select>';
                            html += "</td>";
                            html += "<td style='width: 20%;'>";
                            html += "<button style='font-size:9px !important;'  class='btn btn-success' onclick='Addtrainingsource();'><i class='fa fa-plus' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                            //html += "&nbsp;<button style='font-size:9px !important;'  class='btn btn-danger' onclick='Deltrainingsource(" + response.d[i]['Trainingid'] + ',' + response.d[i]['Trainingsource'][j]['Trainingsourceid'] + ");'><i class='fa fa-trash' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                            html += "</td>";
                            html += "</tr>";
                        }
                        if (response.d[i]['Trainingsource'].length == 0) {
                            html += "<tr>";
                            html += "<td  style='width: 80%;'>";
                            html += '<select id="Cbtrainingsources_' + response.d[i]['Trainingid'] + '_0' + '" class="form-control">';
                            for (k = 0; k < response.d[i]['Templatetrainingsource'].length; k++) {
                                html += '<option value="' + response.d[i]['Templatetrainingsource'][k]['Trainingsourceid'] + '">' + response.d[i]['Templatetrainingsource'][k]['Trainingsourcename'] + '</option>';
                            }
                            html += '</select>';
                            html += "</td>";
                            html += "<td>";
                            html += "<button style='font-size:9px !important;'  class='btn btn-success' onclick='Addtrainingsource();'><i class='fa fa-plus' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                            html += "</td>";
                            html += "</tr>";
                        }
                        html += "</table>";
                        html += '</td>';


                        html += '<td style="width:30%;">';
                        html += "<table  class='table table-bordered' style='table-layout: fixed;width:100%;'>";


                        for (j = 0; j < response.d[i]['ServiceLv'].length; j++) {
                            html += "<tr>";
                            html += "<td style='width: 80%;'>";

                            html += '<select id="Cbservicelvs_' + response.d[i]['Trainingid'] + '_' + response.d[i]['ServiceLv'][j]['ServiceLvid'] + '" class="form-control">';

                            for (k = 0; k < response.d[i]['TemplateserviceLv'].length; k++) {
                                html += '<option value="' + response.d[i]['TemplateserviceLv'][k]['ServiceLvid'] + '">' + response.d[i]['TemplateserviceLv'][k]['ServiceLvname'] + '</option>';
                            }
                            html += '</select>';
                            html += "</td>";
                            html += "<td style='width: 20%;'>";
                            html += "<button style='font-size:9px !important;'  class='btn btn-success' onclick='Addservicelv();'><i class='fa fa-plus' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                            //html += "&nbsp;<button style='font-size:9px !important;'  class='btn btn-danger' onclick='Delservicelv(" + response.d[i]['Trainingid'] + ',' + response.d[i]['ServiceLv'][j]['ServiceLvid'] + ");'><i class='fa fa-trash' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                            html += "</td>";
                            html += "</tr>";
                        }



                        if (response.d[i]['ServiceLv'].length == 0) {
                            html += "<tr>";
                            html += "<td style='width: 80%;'>";

                            html += '<select id="Cbservicelvs_' + response.d[i]['Trainingid'] + '_0" class="form-control">';

                            for (k = 0; k < response.d[i]['TemplateserviceLv'].length; k++) {
                                html += '<option value="' + response.d[i]['TemplateserviceLv'][k]['ServiceLvid'] + '">' + response.d[i]['TemplateserviceLv'][k]['ServiceLvname'] + '</option>';
                            }
                            html += '</select>';
                            html += "</td>";
                            html += "<td style='width: 20%;'>";
                            html += "<button style='font-size:9px !important;'  class='btn btn-success' onclick='Addservicelv();'><i class='fa fa-plus' style='font-size:9px !important;' aria-hidden='true'></i></button>";

                            html += "</td>";
                            html += "</tr>";
                        }


                        html += "</table>";
                        html += '</td>';





                        html += '<td style="width:30%;">';
                        html += "<table  class='table table-bordered' style='table-layout: fixed;width:100%;'>";


                        for (j = 0; j < response.d[i]['Quality'].length; j++) {
                            html += "<tr>";
                            html += "<td style='width: 80%;'>";

                            html += '<select id="Cbqualitys_' + response.d[i]['Trainingid'] + '_' + response.d[i]['Quality'][j]['Qualityid'] + '" class="form-control">';

                            for (k = 0; k < response.d[i]['Templatequality'].length; k++) {
                                html += '<option value="' + response.d[i]['Templatequality'][k]['Qualityid'] + '">' + response.d[i]['Templatequality'][k]['Qualityname'] + '</option>';
                            }
                            html += '</select>';
                            html += "</td>";
                            html += "<td style='width: 20%;'>";
                            html += "<button style='font-size:9px !important;'  class='btn btn-success' onclick='Addquality();'><i class='fa fa-plus' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                            //html += "&nbsp;<button style='font-size:9px !important;'  class='btn btn-danger' onclick='Delquality(" + response.d[i]['Trainingid'] + ',' + response.d[i]['Quality'][j]['Qualityid'] + ");'><i class='fa fa-trash' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                            html += "</td>";
                            html += "</tr>";
                        }
                        if (response.d[i]['Quality'].length == 0) {
                            html += "<tr>";
                            html += "<td  style='width: 80%;'>";

                            html += '<select id="Cbqualitys_' + response.d[i]['Trainingid'] + '_0' + '" class="form-control">';
                            for (k = 0; k < response.d[i]['Templatequality'].length; k++) {
                                html += '<option value="' + response.d[i]['Templatequality'][k]['Qualityid'] + '">' + response.d[i]['Templatequality'][k]['Qualityname'] + '</option>';
                            }
                            html += '</select>';

                            html += "</td>";
                            html += "<td>";
                            html += "<button style='font-size:9px !important;'  class='btn btn-success' onclick='Addquality();'><i class='fa fa-plus' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                            html += "</td>";
                            html += "</tr>";
                        }
                        html += "</table>";
                        html += '</td>';



                        html += '<td>';
                        html += '<button onclick="Deltraining(' + response.d[i]['Trainingid'] + ');" class="btn btn-danger"><i class="fa fa-trash" aria-hidden="true"></i></button>';
                        html += '</td>';




                    }

                    html += '</table>';
                    html += '</div>';
                    html += '</div>';

                    $('#Divtraining').html(html);

                    for (i = 0; i < response.d.length; i++) {
                        for (j = 0; j < response.d[i]['Trainingsource'].length; j++) {
                            $('#Cbtrainingsources_' + response.d[i]['Trainingid'] + '_' + response.d[i]['Trainingsource'][j]['Trainingsourceid']).selectpicker({
                                liveSearch: true,
                                maxOptions: 1
                            });


                            $('#Cbtrainingsources_' + response.d[i]['Trainingid'] + '_' + response.d[i]['Trainingsource'][j]['Trainingsourceid']).on('change', function () {
                                json = '';
                                json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                                json += 'Trainingid :' + $(this).attr('id') + '|';
                                json += 'val :' + $(this).val() + '|';
                                $.ajax({
                                    type: "POST",
                                    url: "\../Page/TQF/TQF4.aspx/Updatetrainingsource",
                                    data: "{'json'  : '" + json + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        if (response.d != '') {
                                            Msgbox(res);
                                            return;
                                        }
                                        Gettraining();
                                    },
                                    async: false,
                                    error: function (er) {

                                    }
                                });



                            });

                            $('#Cbtrainingsources_' + response.d[i]['Trainingid'] + '_' + response.d[i]['Trainingsource'][j]['Trainingsourceid']).val(response.d[i]['Trainingsource'][j]['Trainingsourceid']).selectpicker('refresh');

                        }
                        $('#Cbtrainingsources_' + response.d[i]['Trainingid'] + '_0').selectpicker({
                            liveSearch: true,
                            maxOptions: 1
                        });
                        $('#Cbtrainingsources_' + response.d[i]['Trainingid'] + '_0').val('').selectpicker('refresh');
                        $('#Cbtrainingsources_' + response.d[i]['Trainingid'] + '_0').on('change', function () {
                            json = '';
                            json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                            json += 'Trainingid :' + $(this).attr('id') + '|';
                            json += 'val :' + $(this).val() + '|';
                            $.ajax({
                                type: "POST",
                                url: "\../Page/TQF/TQF4.aspx/Updatetrainingsource",
                                data: "{'json'  : '" + json + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (response) {
                                    if (response.d != '') {
                                        Msgbox(res);
                                        return;
                                    }
                                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                                    Gettraining();
                                },
                                async: false,
                                error: function (er) {

                                }
                            });



                        });


                    }




                    for (i = 0; i < response.d.length; i++) {
                        for (j = 0; j < response.d[i]['ServiceLv'].length; j++) {
                            $('#Cbservicelvs_' + response.d[i]['Trainingid'] + '_' + response.d[i]['ServiceLv'][j]['ServiceLvid']).selectpicker({
                                liveSearch: true,
                                maxOptions: 1
                            });


                            $('#Cbservicelvs_' + response.d[i]['Trainingid'] + '_' + response.d[i]['ServiceLv'][j]['ServiceLvid']).on('change', function () {
                                json = '';
                                json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                                json += 'Trainingid :' + $(this).attr('id') + '|';
                                json += 'val :' + $(this).val() + '|';
                                $.ajax({
                                    type: "POST",
                                    url: "\../Page/TQF/TQF4.aspx/Updateservicelv",
                                    data: "{'json'  : '" + json + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        if (response.d != '') {
                                            Msgbox(response.d);
                                            return;
                                        }
                                        Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                                        Gettraining();
                                    },
                                    async: false,
                                    error: function (er) {

                                    }
                                });



                            });

                            $('#Cbservicelvs_' + response.d[i]['Trainingid'] + '_' + response.d[i]['ServiceLv'][j]['ServiceLvid']).val(response.d[i]['ServiceLv'][j]['ServiceLvid']).selectpicker('refresh');

                        }
                        $('#Cbservicelvs_' + response.d[i]['Trainingid'] + '_0').selectpicker({
                            liveSearch: true,
                            maxOptions: 1
                        });
                        $('#Cbservicelvs_' + response.d[i]['Trainingid'] + '_0').val('').selectpicker('refresh');
                        $('#Cbservicelvs_' + response.d[i]['Trainingid'] + '_0').on('change', function () {
                            json = '';
                            json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                            json += 'Trainingid :' + $(this).attr('id') + '|';
                            json += 'val :' + $(this).val() + '|';
                            $.ajax({
                                type: "POST",
                                url: "\../Page/TQF/TQF4.aspx/Updateservicelv",
                                data: "{'json'  : '" + json + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (response) {
                                    if (response.d != '') {
                                        Msgbox(response.d);
                                        return;
                                    }
                                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                                    Gettraining();
                                },
                                async: false,
                                error: function (er) {

                                }
                            });



                        });


                    }




                    for (i = 0; i < response.d.length; i++) {
                        for (j = 0; j < response.d[i]['Quality'].length; j++) {
                            $('#Cbqualitys_' + response.d[i]['Trainingid'] + '_' + response.d[i]['Quality'][j]['Qualityid']).selectpicker({
                                liveSearch: true,
                                maxOptions: 1
                            });


                            $('#Cbqualitys_' + response.d[i]['Trainingid'] + '_' + response.d[i]['Quality'][j]['Qualityid']).on('change', function () {
                                json = '';
                                json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                                json += 'Trainingid :' + $(this).attr('id') + '|';
                                json += 'val :' + $(this).val() + '|';
                                $.ajax({
                                    type: "POST",
                                    url: "\../Page/TQF/TQF4.aspx/Updatequality",
                                    data: "{'json'  : '" + json + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        if (response.d != '') {
                                            Msgbox(response.d);
                                            return;
                                        }
                                        Gettraining();
                                    },
                                    async: false,
                                    error: function (er) {

                                    }
                                });



                            });

                            $('#Cbqualitys_' + response.d[i]['Trainingid'] + '_' + response.d[i]['Quality'][j]['Qualityid']).val(response.d[i]['Quality'][j]['Qualityid']).selectpicker('refresh');

                        }
                        $('#Cbqualitys_' + response.d[i]['Trainingid'] + '_0').selectpicker({
                            liveSearch: true,
                            maxOptions: 1
                        });
                        $('#Cbqualitys_' + response.d[i]['Trainingid'] + '_0').val('').selectpicker('refresh');
                        $('#Cbqualitys_' + response.d[i]['Trainingid'] + '_0').on('change', function () {
                            json = '';
                            json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                            json += 'Trainingid :' + $(this).attr('id') + '|';
                            json += 'val :' + $(this).val() + '|';
                            $.ajax({
                                type: "POST",
                                url: "\../Page/TQF/TQF4.aspx/Updatequality",
                                data: "{'json'  : '" + json + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (response) {
                                    if (response.d != '') {
                                        Msgbox(response.d);
                                        return;
                                    }
                                    Gettraining();
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
        //function Gettraining() {
        //    var json = $('#HdTQFId').val();
        //    var html = '';
        //    var i = 0;
        //    var j = 0;
        //    var x = 0;
        //    var isfound = false;
        //    var res;
        //    $.ajax({
        //        type: "POST",
        //        url: "\../Page/TQF/TQF4.aspx/Gettraining",
        //        data: "{'json'  : '" + json + "'}",
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: function (response) {
        //            res = response.d;
        //            if (res == null) {
        //                Msgbox('ไม่สามารถดึงข้อมูลการพัฒนาผลการเรียนรู้ของนักศึกษา โปรดติดต่อผู้ดูแลระบบ');
        //                return;

        //            }
        //            html += '<div class="row mt-1">';
        //            html += '<div class="col-12">';
        //            html += '<table class="table table-bordered" style="margin-top: 10px;">';
        //            html += '<tr>';
        //            html += '<td>แหล่งฝึก';
        //            html += '</td>';
        //            html += '<td>ระดับสถานะบริการ';
        //            html += '</td>';
        //            html += '<td>ระบบคุณภาพ';
        //            html += '</td>';
        //            html += '<td>&nbsp;';
        //            html += '</td>';
        //            html += '</tr>';
        //            if (res.length > 0) {
        //                for (i = 0; i < res.length; i++) {

        //                    html += '<tr>';
        //                    html += '<td>';
        //                    for (j = 0; j < res[i]['Templatetrainingsource'].length; j++) {
        //                        html += '<div>';
        //                        isfound = false;
        //                        for (x = 0; x < res[i]['Trainingsource'].length; x++) {
        //                            if (res[i]['Templatetrainingsource'][j]['Trainingsourceid'] == res[i]['Trainingsource'][x]['Trainingsourceid']) {
        //                                isfound = true;
        //                            }
        //                        }
        //                        if (isfound) {
        //                            html += '<input type="checkbox" id="Chktrainingsource_' + res[i]['Trainingid'] + '_' + res[i]['Templatetrainingsource'][j]['Trainingsourceid'] + '" onclick="Updatetqftrainingsource(\'Chktrainingsource_' + res[i]['Trainingid'] + '_' + res[i]['Templatetrainingsource'][j]['Trainingsourceid'] + '\');" checked />&nbsp;<span>' + res[i]['Templatetrainingsource'][j]['Trainingsourcename'] + '</span>';
        //                        }
        //                        else {
        //                            html += '<input type="checkbox" id="Chktrainingsource_' + res[i]['Trainingid'] + '_' + res[i]['Templatetrainingsource'][j]['Trainingsourceid'] + '" onclick="Updatetqftrainingsource(\'Chktrainingsource_' + res[i]['Trainingid'] + '_' + res[i]['Templatetrainingsource'][j]['Trainingsourceid'] + '\');" />&nbsp;<span>' + res[i]['Templatetrainingsource'][j]['Trainingsourcename'] + '</span>';
        //                        }
        //                        html += '<div>';
        //                    }
        //                    html += '</td>';
        //                    html += '<td>';
        //                    for (j = 0; j < res[i]['TemplateserviceLv'].length; j++) {
        //                        html += '<div>';
        //                        isfound = false;
        //                        for (x = 0; x < res[i]['ServiceLv'].length; x++) {
        //                            if (res[i]['TemplateserviceLv'][j]['ServiceLvid'] == res[i]['ServiceLv'][x]['ServiceLvid']) {
        //                                isfound = true;
        //                            }
        //                        }
        //                        if (isfound) {
        //                            html += '<input type="checkbox" id="ChkserviceLv_' + res[i]['Trainingid'] + '_' + res[i]['TemplateserviceLv'][j]['ServiceLvid'] + '" onclick="UpdatetqfserviceLv(\'ChkserviceLv_' + res[i]['Trainingid'] + '_' + res[i]['TemplateserviceLv'][j]['ServiceLvid'] + '\');" checked />&nbsp;<span>' + res[i]['TemplateserviceLv'][j]['ServiceLvname'] + '</span>';
        //                        }
        //                        else {
        //                            html += '<input type="checkbox" id="ChkserviceLv_' + res[i]['Trainingid'] + '_' + res[i]['TemplateserviceLv'][j]['ServiceLvid'] + '" onclick="UpdatetqfserviceLv(\'ChkserviceLv_' + res[i]['Trainingid'] + '_' + res[i]['TemplateserviceLv'][j]['ServiceLvid'] + '\');" />&nbsp;<span>' + res[i]['TemplateserviceLv'][j]['ServiceLvname'] + '</span>';
        //                        }
        //                        html += '<div>';
        //                    }
        //                    html += '</td>';
        //                    html += '<td>';
        //                    for (j = 0; j < res[i]['Templatequality'].length; j++) {
        //                        html += '<div>';
        //                        isfound = false;
        //                        for (x = 0; x < res[i]['Quality'].length; x++) {
        //                            if (res[i]['Templatequality'][j]['Qualityid'] == res[i]['Quality'][x]['Qualityid']) {
        //                                isfound = true;
        //                            }
        //                        }
        //                        if (isfound) {
        //                            html += '<input type="checkbox" id="Chkquality_' + res[i]['Trainingid'] + '_' + res[i]['Templatequality'][j]['Qualityid'] + '" onclick="Updatetqfquality(\'Chkquality_' + res[i]['Trainingid'] + '_' + res[i]['Templatequality'][j]['Qualityid'] + '\');" checked />&nbsp;<span>' + res[i]['Templatequality'][j]['Qualityname'] + '</span>';
        //                        }
        //                        else {
        //                            html += '<input type="checkbox" id="Chkquality_' + res[i]['Trainingid'] + '_' + res[i]['Templatequality'][j]['Qualityid'] + '" onclick="Updatetqfquality(\'Chkquality_' + res[i]['Trainingid'] + '_' + res[i]['Templatequality'][j]['Qualityid'] + '\');" />&nbsp;<span>' + res[i]['Templatequality'][j]['Qualityname'] + '</span>';
        //                        }
        //                        html += '<div>';
        //                    }
        //                    html += '</td>';
        //                    html += '<td style="vertical-align: middle;">';
        //                    html += '<button onclick="Deletetraining(' + res[i]['Trainingid'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
        //                    html += '</td>';
        //                    html += '</tr > ';
        //                }
        //            }
        //            else {
        //                html += '<tr><td colspan="4" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
        //            }
        //            html += '</table>';
        //            html += '</div>';
        //            html += '</div>';

        //            $('#Divtraining').html(html);
        //        },
        //        async: false,
        //        error: function (er) {

        //        }
        //    });

        //}

        function Getlearningoutput() {
                var json = $('#HdTQFId').val();
                var html = '';
                var i = 0;
                var j = 0;
                var x = 0;
                var isfound = false;
                var res;
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Getlearningoutput",
                    data: "{'json'  : '" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        res = response.d;
                        if (res == null) {
                            Msgbox('ไม่สามารถดึงข้อมูลการพัฒนาผลการเรียนรู้ของนักศึกษา โปรดติดต่อผู้ดูแลระบบ');
                            return;

                        }
                        html += '<div class="row mt-1">';
                        html += '<div class="col-12">';
                        html += '<table class="table table-bordered" style="margin-top: 10px;">';
                        html += '<tr>';
                        html += '<td>ผลการเรียนรู้';
                        html += '</td>';
                        html += '<td>เทคนิค / วิธีการสอน';
                        html += '</td>';
                        html += '<td>วิธีการประเมินผล';
                        html += '</td>';
                        html += '</tr>';
                        for (i = 0; i < res.length; i++)
                        {
                         
                            html += '<tr>';
                            html += '<td>';
                            html += '<div class="card" style="font-size: 12px !important">';
                            html += '<div class="card-header">';
                            html += res[i]['Learningoutputname'];
                            html += '</div>';
                            html += '<div class="card-body" style="font-size: 14px !important">';
                            html += res[i]['Learningoutputdesc'];
                            html += '</div>';
                            html += '</div>';
                            html += '</td>';
                            html += '<td>';
                            for (j = 0; j < res[i]['Templateparticulars'].length; j++) {
                                html += '<div>';
                                isfound = false;
                                for (x = 0; x < res[i]['Particulars'].length; x++)
                                {
                                    if (res[i]['Templateparticulars'][j]['Particularid'] == res[i]['Particulars'][x]['Particularid']) {
                                        isfound = true;
                                    }    
                                }
                                if (isfound) {
                                    html += '<input type="checkbox" id="Chklearningoutputparticular_' + res[i]['Learningoutputid'] + '_' + res[i]['Templateparticulars'][j]['Particularid'] + '" onclick="Updatetqfparticular(\'Chklearningoutputparticular_' + res[i]['Learningoutputid'] + '_' + res[i]['Templateparticulars'][j]['Particularid'] + '\');" checked />&nbsp;<span>' + res[i]['Templateparticulars'][j]['Particularname'] + '</span>';
                                }
                                else
                                {
                                    html += '<input type="checkbox" id="Chklearningoutputparticular_' + res[i]['Learningoutputid'] + '_' + res[i]['Templateparticulars'][j]['Particularid'] + '" onclick="Updatetqfparticular(\'Chklearningoutputparticular_' + res[i]['Learningoutputid'] + '_' + res[i]['Templateparticulars'][j]['Particularid'] + '\');" />&nbsp;<span>' + res[i]['Templateparticulars'][j]['Particularname'] + '</span>';
                                }
                                html += '<div>';
                            }
                            html += '</td>';
                            html += '<td>';
                            for (j = 0; j < res[i]['TemplateEstimates'].length; j++) {
                                html += '<div>';
                                isfound = false;
                                for (x = 0; x < res[i]['Estimates'].length; x++) {
                                    if (res[i]['TemplateEstimates'][j]['Estimateid'] == res[i]['Estimates'][x]['Estimateid']) {
                                        isfound = true;
                                    }
                                    
                                    
                                }
                                if (isfound) {
                                    html += '<input type="checkbox" id="Chklearningoutputestimate_' + res[i]['Learningoutputid'] + '_' + res[i]['TemplateEstimates'][j]['Estimateid'] + '" onclick="Updatetqfestimate(\'Chklearningoutputestimate_' + res[i]['Learningoutputid'] + '_' + res[i]['TemplateEstimates'][j]['Estimateid'] + '\');" checked />&nbsp;<span>' + res[i]['TemplateEstimates'][j]['Estimatename'] + '</span>';
                                }
                                else {
                                    html += '<input type="checkbox" id="Chklearningoutputestimate_' + res[i]['Learningoutputid'] + '_' + res[i]['TemplateEstimates'][j]['Estimateid'] + '" onclick="Updatetqfestimate(\'Chklearningoutputestimate_' + res[i]['Learningoutputid'] + '_' + res[i]['TemplateEstimates'][j]['Estimateid'] + '\');"  />&nbsp;<span>' + res[i]['TemplateEstimates'][j]['Estimatename'] + '</span>';
                                }
                                html += '<div>';
                            }
                            html += '</td>';
                            html += '</tr > ';
                        }
                        html += '</table>';
                        html += '</div>';
                        html += '</div>';
                       
                        $('#Divestimateoutput').html(html);
                    },
                    async: false,
                    error: function (er) {

                    }
                });
            
        }
        
        function Callback(Ctrl, x, y, val) {
            var json = '';
            json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            json += 'Ctrl:' + Ctrl + '|';
            json += 'val:' + y + '|';
            if (Ctrl == 'Gvnewobjective') {
                var res;
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF4.aspx/Addnewobjective",
                    data: "{'json'  : '" + json  + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        res = response.d;
                        if (res != "") {
                            Msgbox(res);
                            return;
                        }
                        $('#Divmodalobjective').modal('hide');
                        Getobjective();
                    },
                    async: false,
                    error: function (er) {

                    }
                });
            }
        }
        function Bindnewobjective() {
           
            ClearResource('TQF/TQF4.aspx', 'Gvnewobjective');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วัตถุประสงค์!L"];
            var Data = ["Objective"];
            var Searchcolumns = ["วัตถุประสงค์!L"];
            var SearchesDat = ["Objective"];
            var Width = ["100%"];
            var Gvnewobjective = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvnewobjective', 30, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', 'id', 'id', Cri, '');
            $('#Divmodalobjectivecont').html(Gvnewobjective._Tables());
            Gvnewobjective._Bind();
        }
        function Newobjective() {
            $('#Divmodalobjective').modal('show');
            Bindnewobjective();
        }
        function Getoutcome() {
           
            var html = '';
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getoutcome",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res == null) {
                        Msgbox('ไม่สามารถแสดงข้อมูลแบบสอบถาม มคอ. ได้ โปรดติดต่อผู้ดูแลระบบ');
                        return;
                    }
                    html += '<table class="table table-bordered">';
                    for (i = 0; i < res.length; i++) {
                        html += '<tr>';
                        html += '<td>' + res[i]['Topic'];
                        html += '</td>';
                        html += '<td>';
                        html += '<div class="container">';
                        html += '<div class="col-12">';
                        html += '<input type="text" class="form-control" onblur="Updateoutcome(\'' + res[i]['TQFoutcomeId'] + '\',\'Txtoutcome_' + res[i]['TQFoutcomeId'] + '\');" id="Txtoutcome_' + res[i]['TQFoutcomeId'] + '" value="' + res[i]['Value'] + '" /">';
                        html += '</div>';
                        html += '<div class="col-12">';
                        html += '</div>';
                        html += '</div>';
                        html += '</td>';
                        html += '</tr>';
                    }
                    html += '</table>';
                    $('#Divoutcome').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Deleteestimate(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Deleteestimate",
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
                    Getestimate();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Deletetraining(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Deletetraining",
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
                    Gettraining();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Deletereport(x) {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divreport').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updatereport",
                data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Deletereport",
                        data: "{'json' :'" + x + "'}",
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
                            Getreport();
                        },
                        async: true,
                        error: function (er) {

                        }
                    });
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Deleteevent(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divevent').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $('#Divevent').find('select').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $('#Divevent').find('input').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updateevent",
                data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Deleteevent",
                        data: "{'json' :'" + x + "'}",
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
                            Getevent();
                        },
                        async: true,
                        error: function (er) {

                        }
                    });
                },
                async: true,
                error: function (er) {

                }
            });
        }
        
        function Newestimate() {
            var json = $('#HdTQFId').val();

            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Newestimate",
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
                    Getestimate();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Newtraining() {
            var json = $('#HdTQFId').val();
            
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Newtraining",
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
                    Gettraining();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Newreport() {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divreport').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updatereport",
                data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Newreport",
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
                            Getreport();
                        },
                        async: true,
                        error: function (er) {

                        }
                    });
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Newevent() {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divevent').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $('#Divevent').find('select').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $('#Divevent').find('input').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updateevent",
                data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Newevent",
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
                            Getevent();
                        },
                        async: true,
                        error: function (er) {

                        }
                    });
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Deletedevelopobjective(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divdevelopobjective').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updatedevelopobjective",
                data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Deletedevelopobjective",
                        data: "{'json' :'" + x + "'}",
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
                            Getdevelopobjective();
                        },
                        async: true,
                        error: function (er) {

                        }
                    });
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Newdevelopobjective() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divdevelopobjective').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
           
       
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updatedevelopobjective",
                data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Newdevelopobjective",
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
                            Getdevelopobjective();
                        },
                        async: true,
                        error: function (er) {

                        }
                    });
                },
                async: true,
                error: function (er) {

                }
            });
        }


        function Getreport() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getreport",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res == null) {
                        Msgbox('เกิดความผิดพลาด โปรดติดต่อผู้ดูแลระบบ');
                        return;
                    }
                    html += '<table class="table table-bordered">';
                    html += '<tr>';
                    html += '<td style="width:40%;">รายงานหรืองานที่มอบหมาย';
                    html += '</td>';
                    html += '<td style="width:40%;">กำหนดส่งงาน';
                    html += '</td>';
                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<textarea id="TxtreportN_' + res[i]['Reportid'] + '" class="form-control" style="height: 80px;">' + res[i]['Reportname'] + '</textarea>';
                            html += '</td>';
                        
                            html += '<td>';
                            html += '<textarea id="TxtreportD_' + res[i]['Reportid'] + '" class="form-control" style="height: 80px;">' + res[i]['Reportdue'] + '</textarea>';
                            html += '</td>';
                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deletereport(' + res[i]['Reportid'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="4" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divreport').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Getevent() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getevent",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res == null) {
                        Msgbox('เกิดความผิดพลาด โปรดติดต่อผู้ดูแลระบบ');
                        return;
                    }
                    html += '<table class="table table-bordered">';
                    html += '<tr>';
                    html += '<td style="width:60%;">กิจกรรม';
                    html += '</td>';
                    html += '<td>ประเภทกิจกรรม';
                    html += '</td>';
                   
                    html += '<td>จำนวนประสบการณ์';
                    html += '</td>';
                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<textarea id="TxteventN_' + res[i]['Eventid'] + '" class="form-control" style="height: 80px;">' + res[i]['Eventname'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<Select class="form-control" id="CbeventT_' + res[i]['Eventid'] + '">';
                            
                            if (res[i]['Eventtype'] == "G") {
                                html += '<option value="I" >เดี่ยว</option>';
                                html += '<option value="G" selected>กลุ่ม</option>';
                                html += '<option value="B" selected>เดี่ยว - กลุ่ม</option>';
                            }
                            else {
                                html += '<option value="I" selected>เดี่ยว</option>';
                                html += '<option value="G" >กลุ่ม</option>';
                                html += '<option value="B" selected>เดี่ยว - กลุ่ม</option>';
                            }
                            html += '</Select>';
                            html += '</td>';
                            html += '<td>';
                            html += '<input type="Text" id="TxteventE_' + res[i]['Eventid'] + '" class="form-control"  value="' + res[i]['Eventexp'] + '" />';
                            html += '</td>';
                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deleteevent(' + res[i]['Eventid'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="4" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divevent').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Getdevelopobjective() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getdevelopobjective",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res == null) {
                        Msgbox('เกิดความผิดพลาด โปรดติดต่อผู้ดูแลระบบ');
                        return;
                    }
                    html += '<table class="table table-bordered">';
                    html += '<tr>';
                    html += '<td>วัตถุประสงค์';
                    html += '</td>';
                    html += '<td>ข้อมูล / หลักฐาน';
                    html += '</td>';
                    html += '<td>วิธีการพัฒนา / ปรับปรุง';
                    html += '</td>';
                    html += '<td>ผู้รับผิดชอบ';
                    html += '</td>';
                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<textarea id="TxtdevoO_' + res[i]['Devlopobjectiveid'] + '" class="form-control" style="height: 80px;">' + res[i]['Objective'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtdevoD_' + res[i]['Devlopobjectiveid'] + '" class="form-control" style="height: 80px;">' + res[i]['Data'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtdevoS_' + res[i]['Devlopobjectiveid'] + '" class="form-control" style="height: 80px;">' + res[i]['Solution'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtdevoR_' + res[i]['Devlopobjectiveid'] + '" class="form-control" style="height: 80px;">' + res[i]['Response'] + '</textarea>';
                            html += '</td>';
                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deletedevelopobjective(' + res[i]['Devlopobjectiveid'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="4" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divdevelopobjective').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Getobjective() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getobjective",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res == null) {
                        Msgbox('เกิดความผิดพลาด โปรดติดต่อผู้ดูแลระบบ');
                        return;
                    }
                    for (i = 0; i < res.length; i++) {
                        html += '<div class="row mt-1">';
                        html += '<div class="col-8">';
                        html += (i + 1) + ' ' + res[i]['Objective'] + ' ( ' + + res[i]['Code'] + ' ) ';
                        html += '</div > ';
                        html += '<div class="col-4" style="text-align: left;"><div class="input-group mb-3">';
                        html += '<input type="text" onblur="Updateobjectiveremark(\'' + res[i]['TQFObjectivesId'] + '\',\'Txtobjectiveremark_' + res[i]['TQFObjectivesId'] + '\');" class="form-control" id="Txtobjectiveremark_' + res[i]['TQFObjectivesId'] + '" value="' + res[i]['Remark'] + '" />';
                        if (res[i]['iscustomize'] == 'True') {
                            html += '<button style="border-radius:1px;" onblur="Deleteobjective(\'' + res[i]['TQFObjectivesId'] + '\');" class="btn btn-danger"><i class=\"fa fa-trash\" aria-hidden=\"true\"></i></button></button>';
                        }
                        html += '</div></div>';
                        html += '</div>';
                    }
                   
                    $('#Divobjective').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Save(menu) {
            var json = '';
            
          
                if (menu == "6") {
                    json += 'menu:' + menu + '|';
                    json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                    json += 'Txtestimatestudent:' + $('#Txtestimatestudent').val() + '|';
                    json += 'Txtreponsibleteacher:' + $('#Txtreponsibleteacher').val() + '|';
                    json += 'Txtreponsiblecoteacher:' + $('#Txtreponsiblecoteacher').val() + '|';
                    json += 'Txtsummaryestimate:' + $('#Txtsummaryestimate').val() + '|';
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Save",
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
                            Msgboxsuccess('บันทึกเรียบร้อยแล้ว');
                        },
                        async: false,
                        error: function (er) {

                        }
                    });
                }
                else if (menu == "7") {
                    json += 'menu:' + menu + '|';
                    json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                    json += 'Txtreestimate:' + $('#Txtreestimate').val() + '|';
                    json += 'Txtreestimateperiod:' + $('#Txtreestimateperiod').val() + '|';
                    json += 'Txtreestimateperson:' + $('#Txtreestimateperson').val() + '|';

                    
                    json += 'Txtimprove:' + $('#Txtimprove').val() + '|';
                    json += 'Txtimproveobjective:' + $('#Txtimproveobjective').val() + '|';
                    json += 'Txtimprovedata:' + $('#Txtimprovedata').val() + '|';
                    json += 'Txtimproveperson:' + $('#Txtimproveperson').val() + '|';


                    json += 'Txtother:' + $('#Txtother').val() + '|';
                    json += 'Txtinstuctor:' + $('#Txtinstuctor').val() + '|';
                    json += 'Txtinstuctorpractical:' + $('#Txtinstuctorpractical').val() + '|';
                    json += 'Txtnurse:' + $('#Txtnurse').val() + '|';
                    json += 'Txtstudent:' + $('#Txtstudent').val() + '|';
                    json += 'Txtstudentperiod:' + $('#Txtstudentperiod').val() + '|';
                    json += 'Txtstudentperson:' + $('#Txtstudentperson').val() + '|';


                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Save",
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
                            Msgboxsuccess('บันทึกเรียบร้อยแล้ว');
                        },
                        async: false,
                        error: function (er) {

                        }
                    });
                }
                else if (menu == "8") {
                    Msgboxsuccess('บันทึกเรียบร้อยแล้ว');
                }
                else if (menu == "5") {
                    json += 'menu:' + menu + '|';
                    json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                    json += 'Txtpreparestudent:' + $('#Txtpreparestudent').val() + '|';
                    json += 'Txtpreparestudentmethod:' + $('#Txtpreparestudentmethod').val() + '|';
                    json += 'Txtpreparestudentoutput:' + $('#Txtpreparestudentoutput').val() + '|';
                    json += 'Txtprepareteacher:' + $('#Txtprepareteacher').val() + '|';
                    json += 'Txtprepareteacherpractical:' + $('#Txtprepareteacherpractical').val() + '|';
                    json += 'Txtmanagerisk:' + $('#Txtmanagerisk').val() + '|';
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Save",
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
                            Msgboxsuccess('บันทึกเรียบร้อยแล้ว');
                        },
                        async: false,
                        error: function (er) {

                        }
                    });
                }
                else if (menu == "1") {
                    json += 'menu:' + menu + '|';
                    json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                    json += 'Txtcredits:' + $('#Txtcredits').val() + '|';
                    json += 'Txtsubjectdesc:' + $('#Txtsubjectdesc').val() + '|';
                    json += 'Cbsubjectgroup:' + $('#Cbsubjectgroup').val() + '|';
                    json += 'Txtprerequisite:' + $('#Txtprerequisite').val() + '|';
                    json += 'Txtcorequisite:' + $('#Txtcorequisite').val() + '|';
                    json += 'TxtlearningPlace:' + $('#TxtlearningPlace').val() + '|';
                    json += 'Txtlastupdatesubject:' + $('#Txtlastupdatesubject').val() + '|';
                    json += 'Txtgeneration:' + $('#Txtgeneration').val() + '|';
                    json += 'Txtquann:' + $('#Txtquann').val() + '|';
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Save",
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
                            Msgboxsuccess('บันทึกเรียบร้อยแล้ว');
                        },
                        async: false,
                        error: function (er) {

                        }
                    });
                }
                else if (menu == "2") {
                    var dat = '';
                    $('#Divdevelopobjective').find('textarea').each(function () {
                        dat += $(this).attr('id') + ':' + $(this).val() + '|';
                    });
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Updatedevelopobjective",
                        data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                            json += 'menu:' + menu + '|';
                            json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                            json += 'Txtobjectivedesc:' + $('#Txtobjectivedesc').val() + '|';
                            $.ajax({
                                type: "POST",
                                url: "\../Page/TQF/TQF4.aspx/Save",
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
                                    Msgboxsuccess('บันทึกเรียบร้อยแล้ว');
                                },
                                async: false,
                                error: function (er) {

                                }
                            });
                        },
                        async: false,
                        error: function (er) {

                        }
                    });

                }
                else if (menu == "4") {
                    var dat = '';
                    var dat = '';
                    $('#Divevent').find('textarea').each(function () {
                        dat += $(this).attr('id') + ':' + $(this).val() + '|';
                    });
                    $('#Divevent').find('select').each(function () {
                        dat += $(this).attr('id') + ':' + $(this).val() + '|';
                    });
                    $('#Divevent').find('input').each(function () {
                        dat += $(this).attr('id') + ':' + $(this).val() + '|';
                    });
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF4.aspx/Updateevent",
                        data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                            dat = '';
                            $('#Divreport').find('textarea').each(function () {
                                dat += $(this).attr('id') + ':' + $(this).val() + '|';
                            });
                            $.ajax({
                                type: "POST",
                                url: "\../Page/TQF/TQF4.aspx/Updatereport",
                                data: "{'json' :'" + json + "','dat' :'" + dat + "'}",
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
                                    json += 'menu:' + menu + '|';
                                    json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                                    json += 'TxtsubjectremarkTH:' + $('#TxtsubjectremarkTH').val() + '|';
                                    json += 'TxtsubjectremarkEN:' + $('#TxtsubjectremarkEN').val() + '|';
                                    json += 'Txtfollowtrainingfield:' + $('#Txtfollowtrainingfield').val() + '|';
                                    json += 'Txtresponsibleinstuctor:' + $('#Txtresponsibleinstuctor').val() + '|';
                                    json += 'Txtresponsibleinstuctorpractical:' + $('#Txtresponsibleinstuctorpractical').val() + '|';
                                    json += 'Txtresibleteacherassist:' + $('#Txtresibleteacherassist').val() + '|';
                                    json += 'Txtguide:' + $('#Txtguide').val() + '|';
                                    json += 'Txtaccessary:' + $('#Txtaccessary').val() + '|';
                                    $.ajax({
                                        type: "POST",
                                        url: "\../Page/TQF/TQF4.aspx/Save",
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
                                            Msgboxsuccess('บันทึกเรียบร้อยแล้ว');
                                        },
                                        async: false,
                                        error: function (er) {

                                        }
                                    });
                                },
                                async: true,
                                error: function (er) {

                                }
                            });
                        },
                        async: true,
                        error: function (er) {

                        }
                    });
                    

                }
                
           

        }
        function Deleteobjective(TQFObjectiveid) {
            var json = '';
            json += TQFObjectiveid;
       
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Deleteobjective",
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
                    Getobjective();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Updateoutcome(TQFoutcomeid, ctrl) {

            var json = '';
            json += 'TQFoutcomeid:' + TQFoutcomeid + '|';
            json += 'val:' + $('#' + ctrl).val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updateoutcome",
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
                    Getoutcome();
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                },
                async: true,
                error: function (er) {

                }
            });
        }
        //function Updateoutcome(TQFoutcomeid, ctrl) {
        //    var json = '';
        //    json += 'TQFoutcomeid:' + TQFoutcomeid + '|';
        //    json += 'val:' + $('#' + ctrl).val() + '|';
        //    $.ajax({
        //        type: "POST",
        //        url: "\../Page/TQF/TQF4.aspx/Updateoutcome",
        //        data: "{'json' :'" + json + "'}",
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        beforeSend: function () {
        //            $(".loader").fadeOut("slow");
        //        },
        //        success: function (response) {
        //            if (response.d != '') {
        //                Msgbox(response.d);
        //                return;
        //            }
        //            Getoutcome();
        //        },
        //        async: true,
        //        error: function (er) {

        //        }
        //    });
        //}
        function Updateratio(Estimateid, ctrl) {
            var json = '';
            json += 'Estimateid:' + Estimateid + '|';
            json += 'val:' + $('#' + ctrl).val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updateratio",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Updateobjectiveremark(TQFObjectiveid, ctrl) {
            var json = '';
            json += 'TQFObjectiveid:' + TQFObjectiveid + '|';
            json += 'val:' + $('#' + ctrl).val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updateobjectiveremark",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Updatetext(TQFInstuctorid, ctrl) {
            var json = '';
            json += 'TQFInstuctorid:' + TQFInstuctorid + '|';
            json += 'val:' + $('#' + ctrl).val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Updatetext",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Searchinstuctor(x) {
            $('#HdInstuctortypeid').val(x);
            ClearResource('TQF/TQF4.aspx', 'Gvsearchinstuctor');
            var Cri = x + '|' + $('#HdTQFId').val();
            var Columns = ["ชื่อ!L", "นามสกุล!L", "คุณวุฒิ!L"];
            var Data = ["firstname", "lastname", "Educationbackground"];
            var Searchcolumns = ["ชื่อ", "นามสกุล", "คุณวุฒิ"];
            var SearchesDat = ["firstname", "lastname", "Educationbackground"];
            var Width = ["20%", "20%", "60%"];
            var Gvsearchinstuctor = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchinstuctor', 1000, Width, Data, "", '', '2', '', '', '', '', '', '', 'Userid', 'Userid', '', 'Userid', Cri, '');
            $('#Divinstuctorcont').html(Gvsearchinstuctor._Tables());
            Gvsearchinstuctor._Bind();
        }
        function Custom(Ctrl, Panel) {
            
            if (Ctrl == 'GvresponsibleInstructor') {
                $('#Divinstuctor').modal('show');
                Searchinstuctor('R');
            }
            else if (Ctrl == 'GvtheoryInstructor') {
                $('#Divinstuctor').modal('show');
                Searchinstuctor('T');
            }
            else if (Ctrl == 'GvextraInstructor') {
                $('#Divinstuctor').modal('show');
                Searchinstuctor('E');
            }
            else if (Ctrl == 'GvpreInstructor') {
                $('#Divinstuctor').modal('show');
                Searchinstuctor('P');
            }
        }
        function Getnewsubject(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getnewsubject",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbnewsubject').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbnewsubject').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbnewsubject').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                    }
                },
                async: true,
                error: function (er) {
                }
            });
        }
        function Getnewyear() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getnewyear",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbnewyear').find('option').remove().end();
                    for (i = 0; i < res.length; i++) {
                        $('#Cbnewyear').append($('<option/>', {
                            value: res[i]["Val"],
                            text: res[i]["Name"]
                        }));
                    }
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Getnewclass() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getnewclass",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbnewclass').find('option').remove().end();
                    for (i = 0; i < res.length; i++) {
                        $('#Cbnewclass').append($('<option/>', {
                            value: res[i]["Val"],
                            text: res[i]["Name"]
                        }));
                    }
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Getnewterm() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getnewterm",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbnewterm').find('option').remove().end();
                    for (i = 0; i < res.length; i++) {
                        $('#Cbnewterm').append($('<option/>', {
                            value: res[i]["Val"],
                            text: res[i]["Name"]
                        }));
                    }
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Getnewcourse(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getcourse",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbnewcourse').find('option').remove().end();
                    for (i = 0; i < res.length; i++) {
                        $('#Cbnewcourse').append($('<option/>', {
                            value: res[i]["Val"],
                            text: res[i]["Name"]
                        }));
                    }
                    $('#Cbnewcourse').on('change', function () {
                        Getnewsubject($('#Cbnewcourse').val());
                    });
                },
                async: false,
                error: function (er) {
                }
            });

        }
        function Getnewcollege() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getnewcollege",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;

                    $('#Cbnewcollege').find('option').remove().end();
                    for (i = 0; i < res.length; i++) {
                        $('#Cbnewcollege').append($('<option/>', {
                            value: res[i]["Val"],
                            text: res[i]["Name"]
                        }));
                    }
                    $('#Cbnewcollege').on('change', function () {
                        Getnewcourse($('#Cbnewcollege').val());
                    });
                },
                async: false,
                error: function (er) {

                }
            });
        }
        function BindregisterStudent() {
            var Cri = $('#HdTQFId').val();
          
            ClearResource('TQF/TQF4.aspx', 'GvregisterStudent');
            var Columns = ["รหัสนักศึกษา!L", "ชื่อ!L", "นามสกุล!L", "วันที่ลงทะเบียน!C"];
            var Data = ["Studentno", "Firstname", "Lastname", "Registerdate"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วิชา"];
            var SearchesDat = ["Studentno", "Firstname", "Lastname"];
            var Width = ["20%", "30%", "30%", "20%"];
            var GvregisterStudent = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'GvregisterStudent', 30, Width, Data, "", '', '', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divregistationsubject').html(GvregisterStudent._Tables());
            GvregisterStudent._Bind();
        }
        function BindresponsibleInstructor() {
            var Cri = $('#HdTQFId').val();
            ClearResource('TQF/TQF4.aspx', 'GvresponsibleInstructor');
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!C", "ประสบการณ์การสอนในสาขาที่เกี่ยวข้อง (จำนวนปี)!C"];
            var Data = ["Firstname", "Lastname", "Educationalbackground", "Exp"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "Educationalbackground"];
            var Width = ["20%", "20%", "20%", "40%"];
            var GvresponsibleInstructor = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'GvresponsibleInstructor', 1000, Width, Data, "", '', '', 'เพิ่มอาจารย์ผู้รับผิดชอบรายวิชา', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#DivresponsibleInstructor').html(GvresponsibleInstructor._Tables());
            GvresponsibleInstructor._Bind();
        }
        function BindtheoryInstructor() {
            var Cri = $('#HdTQFId').val();
            ClearResource('TQF/TQF4.aspx', 'GvtheoryInstructor');
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!C", "ประสบการณ์การสอนในสาขาที่เกี่ยวข้อง (จำนวนปี)!C"];
            var Data = ["Firstname", "Lastname", "Educationalbackground", "Exp"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "Educationalbackground"];
            var Width = ["20%", "20%", "20%", "40%"];
            var GvtheoryInstructor = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'GvtheoryInstructor', 1000, Width, Data, "", '', '', 'เพิ่มอาจารย์ภาคปฏิบัติ', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#DivtheoryInstructor').html(GvtheoryInstructor._Tables());
            GvtheoryInstructor._Bind();
        }
        function BindextraInstructor() {

            var Cri = $('#HdTQFId').val();
            ClearResource('TQF/TQF4.aspx', 'GvextraInstructor');
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!C", "ประสบการณ์การสอนในสาขาที่เกี่ยวข้อง (จำนวนปี)!C"];
            var Data = ["Firstname", "Lastname", "Educationalbackground", "Exp"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "Educationalbackground"];
            var Width = ["20%", "20%", "20%", "40%"];
            var GvextraInstructor = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'GvextraInstructor', 1000, Width, Data, "", '', '', 'เพิ่มอาจารย์สอนภาคปฏิบัติ', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#DivextraInstructor').html(GvextraInstructor._Tables());
            GvextraInstructor._Bind();
        }


        function BindpreInstructor() {

            var Cri = $('#HdTQFId').val();
            ClearResource('TQF/TQF4.aspx', 'GvpreInstructor');
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!C", "ประสบการณ์การสอนในสาขาที่เกี่ยวข้อง (จำนวนปี)!C"];
            var Data = ["Firstname", "Lastname", "Educationalbackground", "Exp"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "Educationalbackground"];
            var Width = ["20%", "20%", "20%", "40%"];
            var GvpreInstructor = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'GvpreInstructor', 1000, Width, Data, "", '', '', 'เพิ่มอาจารย์พยาบาลพี่เลี้ยง', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#DivpreInstructor').html(GvpreInstructor._Tables());
            GvpreInstructor._Bind();
        }
        function LoadTQFInfo(id) {
            var json = id;
            $.ajax({
                type: "POST",
                url: "TQF/TQF4.aspx/LoadTQFInfo",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    res = response.d;
                    if (res.error != "") {
                        Msgbox(res.error);
                    }
                    $('#HdTQFId').val(res['id']);
                    $('#Txtcoursegroupname').val(res['Coursename']);
                    $('#Txtownerorgname').val(res['Ownerorgname']);
                    $('#Txtcoursename').val(res['Coursename']);
                    $('#Txtsubjectname').val(res['Subjectname']);
                    $('#Txtcredits').val(res['Credits']);
                    $('#Txtsubjectdesc').val(res['SubjectDesc']);
                    $('#Cbsubjectgroup').val(res['Subjectgroup']);
                    $('#Txtprerequisite').val(res['Prerequisite']);
                    $('#Txtcorequisite').val(res['Corequisite']);
                    $('#TxtlearningPlace').val(res['LearningPlace']);
                    $('#Txtlastupdatesubject').val(res['Lastupdatesubject']);
                    $('#Txtterm').val(res['Term']);
                    $('#Txtclass').val(res['Class']);
                    $('#Txtyear').val(res['Year']);
                    $('#Txtgeneration').val(res['Generation']);
                    $('#Txtquann').val(res['Quann']);
                    $('#Txtobjectivedesc').val(res['Objectivedesc']);
                    $('#TxtsubjectremarkTH').val(res['SubjectremarkTH']);
                    $('#TxtsubjectremarkEN').val(res['SubjectremarkEN']);

                    
                   
                    
                    
                    
                    

                    $('#Txtfollowtrainingfield').val(res['Followtrainingfield']);
                    $('#Txtresponsibleinstuctor').val(res['Responsibleinstuctor']);
                    $('#Txtresponsibleinstuctorpractical').val(res['Responsibleinstuctorpractical']);
                    $('#Txtresibleteacherassist').val(res['Resibleteacherassist']);
                    $('#Txtguide').val(res['Guide']);
                    $('#Txtaccessary').val(res['Accessary']);

                    $('#Txtpreparestudent').val(res['Preparestudent']);
                    $('#Txtpreparestudentmethod').val(res['Preparestudentmethod']);
                    $('#Txtpreparestudentoutput').val(res['Preparestudentoutput']);

                    $('#Txtprepareteacher').val(res['Prepareteacher']);
                    $('#Txtprepareteacherpractical').val(res['Prepareteacherpractical']);
                    $('#Txtmanagerisk').val(res['Managerisk']);


                    $('#Txtreestimate').val(res['Reestimate']);
                    $('#Txtreestimateperiod').val(res['Reestimateperiod']);
                    $('#Txtreestimateperson').val(res['Reestimateperson']);
                    $('#Txtimprove').val(res['Improve']);
                    $('#Txtimproveobjective').val(res['Improveobjective']);
                    $('#Txtimprovedata').val(res['Improvedata']);
                    $('#Txtimproveperson').val(res['Improveperson']);
                    $('#Txtother').val(res['Other']);
                    $('#Txtinstuctor').val(res['Instuctor']);
                    $('#Txtinstuctorpractical').val(res['Instuctorpractical']);
                    $('#Txtnurse').val(res['Nurse']);
                    $('#Txtstudent').val(res['Student']);
                    $('#Txtstudentperiod').val(res['Studentperiod']);
                    $('#Txtstudentperson').val(res['Studentperson']);

                    $('#Txtestimatestudent').val(res['Estimatestudent']);
                    $('#Txtreponsibleteacher').val(res['Reponsibleteacher']);
                    $('#Txtreponsiblecoteacher').val(res['Reponsiblecoteacher']);
                    $('#Txtsummaryestimate').val(res['Summaryestimate']);
                  
                    BindresponsibleInstructor();
                    BindtheoryInstructor();
                    BindextraInstructor();
                    BindpreInstructor();
                    BindregisterStudent();
                    Getobjective();
                    Getoutcome();
                    Getdevelopobjective();
                    Getlearningoutput();
                    Getevent();
                    Getreport();
                    Gettraining();
                    Getestimate();
                    ////tab3
                   
                    Bindtextbook();
                    GetTool();
                    Getjournal();
                    Getinquiry();
                    Getebook();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function DonewTQF() {
            var json = '';
            $('#DiverrornewTQF').hide();
            $('#Txtnewgeneration').removeClass('form-control is-invalid');
            $('#Cbnewcollege').removeClass('form-control is-invalid');
            $('#Cbnewcourse').removeClass('form-control is-invalid');
            $('#Cbnewsubject').removeClass('form-control is-invalid');
            $('#Cbnewterm').removeClass('form-control is-invalid');
            $('#Cbnewclass').removeClass('form-control is-invalid');
            $('#Cbnewyear').removeClass('form-control is-invalid');
            $('#Cbnewcollege').addClass('form-control');
            $('#Cbnewcourse').addClass('form-control');
            $('#Cbnewsubject').addClass('form-control');
            $('#Cbnewterm').addClass('form-control');
            $('#Cbnewclass').addClass('form-control');
            $('#Cbnewyear').addClass('form-control');
            if ($('#Cbnewcollege').val() == '') {
                $('#Cbnewcollege').addClass('form-control is-invalid');
                return;
            }
            if ($('#Cbnewcourse').val() == '') {
                $('#Cbnewcourse').addClass('form-control is-invalid');
                return;
            }
            if ($('#Cbnewcollege').val() == '') {
                $('#Cbnewcollege').addClass('form-control is-invalid');
                return;
            }
            if ($('#Cbnewsubject').val() == '') {
                $('#Cbnewsubject').addClass('form-control is-invalid');
                return;
            }
            if ($('#Cbnewterm').val() == '') {
                $('#Cbnewterm').addClass('form-control is-invalid');
                return;
            }
            if ($('#Cbnewclass').val() == '') {
                $('#Cbnewclass').addClass('form-control is-invalid');
                return;
            }
            if ($('#Cbnewyear').val() == '') {
                $('#Cbnewyear').addClass('form-control is-invalid');
                return;
            }
            if ($('#Txtnewgeneration').val() == '') {
                $('#Txtnewgeneration').addClass('form-control is-invalid');
                return;
            }
            json += 'Cbnewcollege :' + $('#Cbnewcollege').val() + '|'
            json += 'Cbnewcourse :' + $('#Cbnewcourse').val() + '|'
            json += 'Cbnewsubject :' + $('#Cbnewsubject').val() + '|'
            json += 'Cbnewterm :' + $('#Cbnewterm').val() + '|'
            json += 'Cbnewclass :' + $('#Cbnewclass').val() + '|'
            json += 'Cbnewyear :' + $('#Cbnewyear').val() + '|'
            json += 'Txtnewgeneration :' + $('#Txtnewgeneration').val() + '|'
            $.ajax({
                type: "POST",
                url: "TQF/TQF4.aspx/DonewTQF",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    res = response.d;
                    if (res.error != "") {
                        $('#Diverror').show();
                        $("#Diverror").html(res);
                        return;
                    }
                    $('#HdTQFId').val(res.id);
                    $('#Divdetail').hide();
                    $('#Divmaster').hide();
                    $('#Divdetail').show();
                    LoadTQFInfo(res.id);
                    $('#DivcreateTQF').modal('hide');
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Selectedinstuctor(x) {
            var json = '';
            json += 'x :' + x + '|';
            json += 'TQFId :' + $('#HdTQFId').val() + '|'; 
            json += 'HdInstuctortypeid :' + $('#HdInstuctortypeid').val() + '|';
            $.ajax({
                type: "POST",
                url: "TQF/TQF4.aspx/Selectedinstuctor",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    res = response.d;
                    if (res != '') {
                        Msgbox(res);
                        return;
                    }
                    if ($('#HdInstuctortypeid').val() == 'R') {
                        BindresponsibleInstructor();
                    }
                    else if ($('#HdInstuctortypeid').val() == 'T') {
                        BindtheoryInstructor();
                    }
                    else if ($('#HdInstuctortypeid').val() == 'E') {
                        BindextraInstructor();
                    }
                    else if ($('#HdInstuctortypeid').val() == 'P') {
                        BindpreInstructor();
                    }
                    $('#Divinstuctor').modal('hide');
                },
                async: true,
                error: function (er) {

                }
            });

        }
        function RowSelect(ctrl, x) {
            
            if (ctrl == 'Gvsearchcourse') {
                $('#Divdetail').hide();
                $('#Divmaster').hide();
                $('#Divapprove').hide();
                $('#Divdetail').show();
                LoadTQFInfo(x);

            }
            else if (ctrl == "Gvsearchinstuctor") {
                Selectedinstuctor(x);
            }
            else if (ctrl == "Gvsearchtextbook") {
                Selectedtextbook(x);
            }
            else if (ctrl == "Gvsearchebook") {
                Selectedebook(x);
            }
            else if (ctrl == "Gvsearchinquiry") {
                Selectedinquiry(x);
            }
            else if (ctrl == "Gvsearchjournal") {
                Selectedjournal(x);
            }
            else if (ctrl == "Gvsearchtool") {
                Selectedtool(x);
            }
            else if (ctrl == "Gvsearchother") {
                Selectedother(x);
            }
        }
        function Getcourse() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Getcourse",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;

                    $('#Cbsearchcourse').find('option').remove().end();
                    $('#Cbsearchcourse').append($('<option/>', {
                        value: '',
                        text: 'ทั้งหมด'
                    }));
                    for (i = 0; i < res.length; i++) {
                        $('#Cbsearchcourse').append($('<option/>', {
                            value: res[i]["Val"],
                            text: res[i]["Name"]
                        }));
                    }




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
            TQFS();
            Getcourse();
            SearchTQF();
        });
        
        //function SearchTQF() {
        //    var Cri = $('#Cbsearchcourse').val();
        //    ClearResource('TQF/TQF4.aspx', 'Gvsearchcourse');
        //    var Columns = ["วิชา!L", "รุ่น!C", "ปี!C", "สถานะ!C"];
        //    var Data = ["subjectname", "Generation", "Year", "Statusname"];
        //    var Searchcolumns = ["วิชา"];
        //    var SearchesDat = ["subjectname"];
        //    var Width = ["50%", "10%", "10%", "10%"];

        //    var Gvsearchcourse = new Grid("TQF/TQF4.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchcourse', 30, Width, Data, "", '', '', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
        //    $('#Divsearchcourse').html(Gvsearchcourse._Tables());
        //    Gvsearchcourse._Bind();
        //}
        function CreateTQF() {
            $('#DivcreateTQF').modal('show');
            Getnewcollege();
            Getnewcourse($('#Cbnewcollege').val());
            Getnewsubject($('#Cbnewcourse').val());
            Getnewclass();
            Getnewterm();
            Getnewyear();
        }
        
        $(function () {
            Getsubjectgroup();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF4.aspx/Iseducate",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;

                    if (res == '') {
                        $('#Divmain').html('');
                        Msgbox('องค์กรที่คุณอยู่ไม่ใช่วิทยาลัยโปรดติดต่อผู้ดูแลระบบ');
                        return;
                    }
                    else {
                        //$("#Dtplastupdatesubject").datepicker({
                        //    format: "dd/mm/yyyy",
                        //    todayBtn: "linked",
                        //    language: "th",
                        //    forceParse: false,
                        //    autoclose: true,
                        //    todayHighlight: true
                        //});
                    }



                },
                async: false,
                error: function (er) {

                }
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
                        <a class="nav-link" href="#" onclick="CreateTQF();">สร้างรายการ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="TQFS();">รายการ มคอ.</a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link" href="#" onclick="ApproveTQFS();">รายการอนุมัติ</a>
                    </li>
                </ul>
            </div>
        </nav>
        <div id="Divmaster" style="display: none;">
            <div class="card" style="margin-top: 20px; color: black;">
                <div class="card-header">
                    ข้อมูล มคอ.4 รายวิชาประสบการณ์ภาคสนาม
                </div>
                <div class="card-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-4" style="text-align: right;">
                                <span>หลักสูตร :</span>
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbsearchcourse" style="width: 100%;">
                                    <option></option>
                                </select>
                            </div>
                            <div class="col-4" style="text-align: left;">
                                <button class="btn btn-info" onclick="SearchTQF();" style="border-radius: 1px;">ค้นหา</button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <hr />

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div id="Divsearchcourse">
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
        <div id="Divapprove" style="display: none;">
            <div class="card" style="margin-top: 20px; color: black;">
                <div class="card-header">
                    ข้อมูลการอนุมัติ มคอ.4 
                </div>
                <div class="card-body">
                    <div class="container">
                    
                        <div class="row">
                            <div class="col-12">
                                <hr />

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div id="Divsearchcourseapprove">
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
        <div id="Divdetail" style="display: none;">
            <input type="hidden" id="HdTQFId" value="" />
             <div class="container">
                <div class="row">
                    <div class="col-12" style="text-align:right;">
                        <button class="btn btn-danger" style="border-radius: 1px;margin-top:10px;" onclick="Send2validate();">ส่งให้ตรวจสอบ / อนุมัติ</button>
                    </div>
                </div>
            </div>
            <ul class="nav nav-tabs" style="margin: 20px;">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#menu1">หมวดที่ 1</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu2">หมวดที่ 2</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu3">หมวดที่ 3</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu4">หมวดที่ 4</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu5">หมวดที่ 5</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu6">หมวดที่ 6</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu7">หมวดที่ 7</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu8">หมวดที่ 8</a>
                </li>
            </ul>
            <!-- Tab panes -->
            <div id="divtab" class="tab-content">

                <div id="menu1" class="container tab-pane active">
                    <div class="container-fluid" style="font-size: 0.9em; color: black;">
                        <div class="row mt-1">
                            <div class="col-12">
                                <button class="btn btn-info" style="border-radius: 1px;" onclick="Save('1');">บันทึกหมวด</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12" style="text-align: center;">
                                <h6>หมวดที่ 1 ข้อมูลทั่วไป</h6>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1.รหัสและชื่อรายวิชา</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-4">รหัสและชื่อรายวิชา (ภาษาไทย) </div>
                                                <div class="col-8">
                                                    <input id="Txtsubjectname" type="text" class="form-control" readonly="true" />
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-4">รหัสและชื่อรายวิชา (ภาษาอังกฤษ) </div>
                                                <div class="col-8">
                                                    <input type="text" readonly="readonly" class="form-control" />
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <span style="color: red; font-size: 12px;">*** นำข้อมูลรหัสวิชาและชื่อวิชามาจากมคอ. 2 (โครงสร้างหลักสูตร)</span>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>2. จำนวนหน่วยกิต</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-4">จำนวนหน่วยกิต :</div>
                                                <div class="col-8">
                                                    <input id="Txtcredits" type="text" class="form-control" />
                                                </div>
                                            </div>

                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <span style="color: red; font-size: 12px;">*** นำข้อมูลรหัสวิชาและชื่อวิชามาจากมคอ. 2 (โครงสร้างหลักสูตร)</span>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>3. หลักสูตรและประเภทของรายวิชา</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-4">หลักสูตร :</div>
                                                <div class="col-8">
                                                    <input id="Txtcoursegroupname" type="text" class="form-control" readonly="true" />
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-4">หมวดวิชา :</div>
                                                <div class="col-8">
                                                     <select id="Cbsubjectgroup" class="form-control" ></select>
                                                    <input id="Txtsubjectdesc" style="display:none;" type="text" class="form-control" />
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <span style="color: red; font-size: 12px;">*** นำข้อมูลรหัสวิชาและชื่อวิชามาจากมคอ. 2 (โครงสร้างหลักสูตร)</span>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>4. ผู้รับผิดชอบรายวิชาและอาจารย์ผู้สอน</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <span>อาจารย์ผู้รับผิดชอบรายวิชา</span>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <div id="DivresponsibleInstructor"></div>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <span>อาจารย์ภาคปฏิบัติ</span>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <div id="DivtheoryInstructor"></div>
                                                </div>
                                            </div>
                                              <div class="row mt-1">
                                                <div class="col-12">
                                                    <span>อาจารย์สอนภาคปฏิบัติ</span>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <div id="DivextraInstructor"></div>
                                                </div>
                                            </div>
                                             <div class="row mt-1">
                                                <div class="col-12">
                                                    <span>อาจารย์พยาบาลพี่เลี้ยง</span>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <div id="DivpreInstructor"></div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>5. ภาคการศึกษา/ชั้นปีที่เรียนตามแผนการศึกษาในหลักสูตร</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1">
                                                <div class="col-2">
                                                    ภาคการศึกษาที่
                                                </div>
                                                <div class="col-1">
                                                    <input id="Txtterm" type="text" class="form-control" readonly="true" />
                                                </div>

                                                <div class="col-1">
                                                    ชั้นปีที่
                                                </div>
                                                <div class="col-1">
                                                    <input id="Txtclass" type="text" class="form-control" readonly="true" />
                                                </div>
                                                <div class="col-1">
                                                    ปีการศึกษา
                                                </div>
                                                <div class="col-1">
                                                    <input id="Txtyear" type="text" class="form-control" readonly="true" />
                                                </div>
                                                <div class="col-1">
                                                    รุ่นที่
                                                </div>
                                                <div class="col-1">
                                                    <input id="Txtgeneration" type="text" class="form-control" />
                                                </div>
                                                <div class="col-1">
                                                    จำนวน
                                                </div>
                                                <div class="col-2">
                                                    <input id="Txtquann" type="number" class="form-control" />
                                                </div>
                                                <div class="col-1">
                                                    &nbsp;
                                                </div>
                                            </div>

                                            <div class="row mt-1" style="display: none;">
                                                <div class="col-12">
                                                    <div style="margin-top: 20px; min-height: 200px; vertical-align: middle; border: solid 1px lightgray; text-align: center;">
                                                        <div id="Divregistationsubject" style="margin-top: 50px; text-align: center; color: red;">ไม่มีข้อมูลจำนวนนักเรียนที่ลงทะเบียนเรียนรายวิชานี้ในระบบทะเบียน</div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <span style="color: red; font-size: 12px;">*** นำข้อมูลรายชื่ออาจารย์ผู้รับผิดชอบรายวิชาและอาจารย์ผู้สอนมาจากระบบบุคลากร</span>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>6. รายวิชาที่ต้องเรียนมาก่อน (PRE-REQUISITES)</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-4">รายวิชาที่ต้องเรียนมาก่อน :</div>
                                                <div class="col-8">
                                                    <input id="Txtprerequisite" type="text" class="form-control" />
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <span style="color: red; font-size: 12px;">*** นำข้อมูลรายชื่อวิชาที่ต้องเรียนมาก่อนจาก มคอ.2 (โครงสร้างหลักสูตร)</span>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>7. รายวิชาที่ต้องเรียนพร้อมกัน (CO-REQUISITES)</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-4">รายวิชาที่ต้องเรียนพร้อมกัน :</div>
                                                <div class="col-8">
                                                    <input id="Txtcorequisite" type="text" class="form-control" />
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <span style="color: red; font-size: 12px;">*** นำข้อมูลรายชื่อวิชาที่ต้องเรียนมาก่อนจาก มคอ.2 (โครงสร้างหลักสูตร)</span>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>8. สถานฝึกปฏิบัติ</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-4">สถานที่เรียน :</div>
                                                <div class="col-8">
                                                    <textarea id="TxtlearningPlace" class="form-control" style="height: 100px;"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>9. วันที่จัดทำหรือปรับปรุงรายละเอียดของรายวิชาครั้งล่าสุด</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-4">วัน/เดือน/ปี :</div>
                                                <div class="col-8">
                                                   <input id="Txtlastupdatesubject" class="form-control" type="text" data-provide="datepicker" data-date-language="th-th" />
                                                    <%--<div id="Dtplastupdatesubject" class="input-group date" style="margin-left: -10px; width: 200px;" data-date-format="mm-dd-yyyy">
                                                        <input id="Txtlastupdatesubject" class="form-control" type="text" />
                                                        <button>
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </button>
                                                    </div>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu2" class="container tab-pane fade">
                    <div class="container-fluid" style="font-size: 0.9em; color: black;">
                        <div class="row mt-1">
                            <div class="col-12">
                                <button class="btn btn-info" style="border-radius: 1px;" onclick="Save('2');" >บันทึกหมวด</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12" style="text-align: center;">
                                <h6>หมวดที่ 2 จุดมุ่งหมายและวัตถุประสงค์</h6>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1.รหัสและชื่อรายวิชา</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-4">จุดมุ่งหมายรายวิชา</div>
                                                <div class="col-8">
                                                    <textarea id="Txtobjectivedesc" class="form-control" style="height: 100px;"></textarea>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12" style="color: red;">*** นำข้อมูลจุดมุ่งหมายรายวิชามาจากมคอ.2 (โครงสร้างหลักสูตร)</div>

                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-12">
                                                    <div style="margin-top: 20px; margin-bottom: 20px;">
                                                        <h6>วัตถุประสงค์รายวิชา</h6>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <div class="container" id="Divobjective">
                                                        <div class="row mt-1">
                                                            <div class="col-8">
                                                                1. มีความซื่อสัตย์ มีวินัย ตรงต่อเวลา (1.1)
                                                            </div>
                                                            <div class="col-4" style="text-align: left;">
                                                                <input type="text" class="form-control" />
                                                            </div>
                                                        </div>
                                                        <div class="row mt-1">
                                                            <div class="col-8">
                                                                2. มีความรอบรู้และความเข้าใจในสาระสำคัญของศาสตร์ที่เป็นพื้นฐานชีวิตทั้งด้านสังคมศาสตร์ มนุษยศาสตร์ วิทยาศาสตร์ คณิตศาสตร์ และวิทยาศาสตร์สุขภาพ รวมถึงศาสตร์อื่นที่ส่งเสริมทักษะศตวรรษ ๒๑ ตลอดถึงความเป็นมนุษย์ที่สมบูรณ์ (2.1)
                                                            </div>
                                                            <div class="col-4" style="text-align: left;">
                                                                <input type="text" class="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-12" style="text-align: center;">
                                                    <button class="btn btn-success" onclick="Newobjective();" style="width: 90%; border-radius: 1px;">เพิ่มผลลัพธ์การเรียนรู้ที่นอกเหนือจากในหลักสูตร</button>
                                                </div>
                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-12" style="color: red;">*** นำข้อมูลมาจาก Learning Outcomes จาก Curriculum Mapping ของมคอ.2</div>
                                            </div>
                                            <div class="row mt-3" id="Divoutcome">
                                                <table class="table table-bordered">
                                                    <tr>
                                                        <td>รายวิชานี้มีการบูรณาการการเรียนการสอนกับ
                                                        </td>
                                                        <td>
                                                            <div class="container">
                                                                <div class="col-12">
                                                                    <select class="form-control"></select>
                                                                </div>
                                                                <div class="col-12">
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>รายวิชาที่ชุมชนมีส่วนร่วมในการจัดการเรียนการสอน
                                                        </td>
                                                        <td>
                                                            <div class="container">
                                                                <div class="col-12">
                                                                    <select class="form-control"></select>
                                                                </div>
                                                                <div class="col-12">
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>2. วัตถุประสงค์ในการพัฒนา / ปรับปรุงในรายวิชา</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <button onclick="Newdevelopobjective();" class="btn btn-info" style="border-radius: 1px; margin: 5px; font-size: 14px;">เพิ่มวัตถุประสงค์ในการพัฒนา</button>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <div id="Divdevelopobjective">
                                                     </div>
                                           
                                                </div>
                                            </div>


                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div id="menu4" class="container tab-pane fade">
                    <div class="container-fluid" style="font-size: 0.9em; color: black;">
                        <div class="row mt-1">
                            <div class="col-12">
                                <button onclick="Save('4');" class="btn btn-info" style="border-radius: 1px;">บันทึกหมวด</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12" style="text-align: center;">
                                <h6>หมวดที่ 4 ลักษณะและวิธีดำเนินการ</h6>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. คำอธิบายรายวิชา</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">คำอธิบายรายวิชา (ไทย)</div>
                                                <div class="col-12">
                                                    <textarea id="TxtsubjectremarkTH" class="form-control" style="height: 100px;"></textarea>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">คำอธิบายรายวิชา (อังกฤษ)</div>
                                                <div class="col-12">
                                                    <textarea id="TxtsubjectremarkEN"  class="form-control" style="height: 100px;" ></textarea>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12" style="color: red;">*** นำข้อมูลคำอธิบายรายวิชาทั้งภาษาไทยและภาษาอังกฤษมาจาก มคอ.2</div>

                                            </div>


                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>2. กิจกรรมของนักศึกษา</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <button onclick="Newevent();" class="btn btn-info" style="border-radius: 1px; margin: 5px; font-size: 14px;">เพิ่มวัตถุประสงค์ในการพัฒนา</button>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <div id="Divevent">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>3. รายงานหรืองานที่นักศึกษาได้รับมอบหมาย</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <button onclick="Newreport();" class="btn btn-info" style="border-radius: 1px; margin: 5px; font-size: 14px;">เพิ่มวัตถุประสงค์ในการพัฒนา</button>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <div id="Divreport">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>4. การติดตามผลการเรียนรู้การฝึกประสบการณ์ภาคสนามของนักศึกษา</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtfollowtrainingfield" class="form-control" style="height: 100px;"></textarea>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                              <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>5. หน้าที่และความรับผิดชอบของอาจารย์ผู้รับผิดชอบรายวิชา</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtresponsibleinstuctor" class="form-control" style="height: 100px;"></textarea>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>6. หน้าที่และความรับผิดชอบของอาจารย์ผู้สอนภาคปฏิบัติ</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtresponsibleinstuctorpractical" class="form-control" style="height: 100px;"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                            <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>7. หน้าที่และความรับผิดชอบของพยาบาลพี่เลี้ยงในแหล่งฝึกภาคปฏิบัติ</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtresibleteacherassist" class="form-control" style="height: 100px;"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                            <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>8. การเตรียมการในการแนะแนวและช่วยเหลือนักศึกษา</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtguide" class="form-control" style="height: 100px;"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>9. สิ่งอำนวยความสะดวกและการสนับสนุนที่ต้องการจากสถานที่ที่จัดประสบการณ์ภาคสนาม</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtaccessary" class="form-control" style="height: 100px;"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu3" class="container tab-pane fade">
                    <div class="container-fluid" style="font-size: 0.9em; color: black;">
                       
                        <div class="row mt-1">
                            <div class="col-12">
                                <button class="btn btn-info" style="border-radius: 1px;">บันทึกหมวด</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12" style="text-align: center;">
                                <h6>หมวดที่ 3 การพัฒนาผลการเรียนรู้ของนักศึกษา</h6>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. การพัฒนาผลการเรียนรู้ของนิสิต/นักศึกษา</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <button class="btn btn-info" onclick="Newlearningset();" style="border-radius: 1px;">เพิ่มผลการเรียนรู้ใหม่</button>
                                                </div>
                                                    </div>

                                            <div id="Divestimateoutput"  class="col-12"> 
                                                <div class="row mt-1">
                                                <div class="col-12">
                                                    <table class="table table-bordered" style="margin-top: 10px;">
                                                        <tr>
                                                            <td>ผลการเรียนรู้
                                                            </td>
                                                            <td>เทคนิค / วิธีการสอน
                                                            </td>
                                                            <td>วิธีการประเมินผล
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <div class="card" style="font-size: 12px !important">
                                                                    <div class="card-header">
                                                                        1. ด้านคุณธรรม จริยธรรม
                                                                    </div>
                                                                    <div class="card-body" style="font-size: 14px !important">
                                                                        <pre>
        1.1 มีความซื่อสัตย์ มีวินัย ตรงต่อเวลา
        1.2 มีความรับผิดชอบต่อตนเองและสังคม
        1.3 สามารถใช้ดุลยพินิจในการจัดการประเด็นหรือปัญหาทางจริยธรรม
        1.4 แสดงออกถึงการเคารพสิทธิ คุณค่า ความแตกต่าง และศักดิ์ศรีของความเป็นมนุษย์ของผู้อื่นและตนเอง
    </pre>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <textarea class="form-control" style="height: 150px;"></textarea>
                                                            </td>
                                                            <td>
                                                                <textarea class="form-control" style="height: 150px;"></textarea>
                                                            </td>


                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <div class="card" style="font-size: 12px !important">
                                                                    <div class="card-header">
                                                                        1. ด้านคุณธรรม จริยธรรม
                                                                    </div>
                                                                    <div class="card-body" style="font-size: 14px !important">
                                                                        <pre>
        1.1 มีความซื่อสัตย์ มีวินัย ตรงต่อเวลา
        1.2 มีความรับผิดชอบต่อตนเองและสังคม
        1.3 สามารถใช้ดุลยพินิจในการจัดการประเด็นหรือปัญหาทางจริยธรรม
        1.4 แสดงออกถึงการเคารพสิทธิ คุณค่า ความแตกต่าง และศักดิ์ศรีของความเป็นมนุษย์ของผู้อื่นและตนเอง
    </pre>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <textarea class="form-control" style="height: 150px;"></textarea>
                                                            </td>
                                                            <td>
                                                                <textarea class="form-control" style="height: 150px;"></textarea>
                                                            </td>


                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12" style="color: red;">หมายเหตุ :</div>
                                                <div class="col-12" style="color: red; margin-left: 50px;">1. ข้อมูลของผลการเรียนรู้ถูกนำมาจาก ผลการเรียนรู้ในมคอ. 3 หมวดที่ 2</div>
                                                <div class="col-12" style="color: red; margin-left: 50px;">2. ข้อมูลของเทคนิค / วิธีการสอนและวิธีประเมินผลถูกนำมาจากข้อมูลพื้นฐาน ซึ่งผู้ที่สามารถเพิ่มให้ได้คือผู้ดูแลระบบประจำวิทยาลัย (รองวิชาการ)</div>
                                                <div class="col-12" style="color: red; margin-left: 50px;">3. ข้อมูลของเทคนิค / วิธีการสอนและวิธีประเมินผลจะถูกนำไปใช้ในหมวดที่ 5 ข้อที่ 1 แผนการสอน</div>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                   <div id="menu5" class="container tab-pane fade">
                    <div class="container-fluid" style="font-size: 0.9em; color: black;">
                        <div class="row mt-1">
                            <div class="col-12">
                                <button onclick="Save('5');" class="btn btn-info" style="border-radius: 1px;">บันทึกหมวด</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12" style="text-align: center;">
                                <h6>หมวดที่ 5 การวางแผนและการเตรียมการ</h6>
                            </div>
                        </div>
                    
                          <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. การกำหนดสถานที่ฝึก</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <button onclick="Newtraining();" class="btn btn-info" style="border-radius: 1px; margin: 5px; font-size: 14px;">เพิ่มสถานที่ฝึก</button>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <div id="Divtraining">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    
                          <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>2. การเตรียมนิสิต/นักศึกษา</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-3">
                                                <div class="col-4">
                                                    <span>วัตถุประสงค์ของการเตรียม</span>
                                                    </div>
                                                 <div class="col-4">
                                                      <span>วิธีการเตรียมนักศึกษา</span>
                                                    </div>
                                                 <div class="col-4">
                                                        <span>ผลที่คาดว่าจะได้รับ</span>
                                                    </div>
                                             </div>   
                                            <div class="row mt-3">
                                                <div class="col-4">
                                                    <textarea id="Txtpreparestudent" class="form-control" style="height: 100px;"></textarea>
                                                </div>
                                                 <div class="col-4">
                                                    <textarea id="Txtpreparestudentmethod" class="form-control" style="height: 100px;"></textarea>
                                                </div>
                                                 <div class="col-4">
                                                    <textarea id="Txtpreparestudentoutput" class="form-control" style="height: 100px;"></textarea>
                                                </div>
                                            </div>

                                            
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>3. การเตรียมอาจารย์ที่ปรึกษา/อาจารย์/อาจารย์ผู้สอนภาคปฎิบัติ</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtprepareteacher" class="form-control" style="height: 100px;"></textarea>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>4. การเตรียมอาจารย์/อาจารย์พยาบาลพี่เลี้ยงสอนภาคปฎิบัติ</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtprepareteacherpractical" class="form-control" style="height: 100px;"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                            <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>5. การจัดการความเสี่ยง</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtmanagerisk" class="form-control" style="height: 100px;"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                         
                    </div>
                </div>


                    <div id="menu6" class="container tab-pane fade">
                    <div class="container-fluid" style="font-size: 0.9em; color: black;">
                        <div class="row mt-1">
                            <div class="col-12">
                                <button onclick="Save('6');" class="btn btn-info" style="border-radius: 1px;">บันทึกหมวด</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12" style="text-align: center;">
                                <h6>หมวดที่ 6 การประเมินนักศึกษา</h6>
                            </div>
                        </div>
                    
                          <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. หลักเกณฑ์การประเมินผล</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <button onclick="Newestimate();" class="btn btn-info" style="border-radius: 1px; margin: 5px; font-size: 14px;">เพิ่มแผนการประเมินผลการเรียนรู้</button>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <div id="Divestimate">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    
                          <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>2. กระบวนการประเมินผลการปฏิบัติงานของนิสิต/นักศึกษา</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtestimatestudent" class="form-control" style="height: 100px;"></textarea>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>3. ความรับผิดชอบของอาจารย์พยาบาลพี่เลี้ยงสอนภาคปฎิบัติ/อาจารย์พี่เลี้ยงต่อการประเมินนิสิต/นักศึกษา</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtreponsibleteacher" class="form-control" style="height: 100px;"></textarea>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                          <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>4. ความรับผิดชอบของอาจารย์ผู้ประสานงานวิชาต่อการประเมินนิสิต/นักศึกษา</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtreponsiblecoteacher" class="form-control" style="height: 100px;"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                            <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>5. การสรุปผลการประเมินที่แตกต่าง</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtsummaryestimate" class="form-control" style="height: 100px;"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                         
                    </div>
                </div>
                <div id="menu8" class="container tab-pane fade">
                    <div class="container-fluid" style="font-size: 0.9em; color: black;">
                        <div class="row mt-1">
                            <div class="col-12">
                                <button onclick="Save('8');" class="btn btn-info" style="border-radius: 1px;">บันทึกหมวด</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12" style="text-align: center;">
                                  หมวดที่ 8 ทรัพยากรประกอบการเรียนการสอน
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. ตำราและเอกสารหลัก</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-12"><button class="btn btn-primary" onclick="Newtextbook();">เพิ่มตำราและเอกสารหลัก</button></div>
                                                <div class="col-12" id="Divtextbook" style="margin-top:20px;">
                                                </div>
                                            </div>



                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>2. อุปกรณ์และเครื่องมือ</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-12"><button class="btn btn-primary" onclick="NewTool();">เพิ่มอุปกรณ์และเครื่องมือ</button></div>
                                                
                                                <div class="col-12" id="DivTool" style="margin-top:20px;">
                                                </div>
                                            </div>



                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>3. วารสาร และข้อมูลอิเล็กทรอนิกส์</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            
                                            <div class="row mt-1">
                                                

                                                <div class="col-12" style="margin-bottom:20px;">
                                                    3.1 วารสาร
                                                </div>
                                                <div class="col-12"><button class="btn btn-primary" onclick="Newjournal();">เพิ่มวารสารวิชาการ</button></div>
                                   
                                                <div class="col-12" id="Divjournal" style="margin-top:20px;">
                                                </div>


                                                <div class="col-12">
                                                    <div class="col-12" style="color: red;">*** นำข้อมูลวารสารวิชาการจากข้อมูลพื้นฐานของระบบ</div>
                                                </div>
                                            </div>

                                            <div class="row mt-1">
                                                
                                                <div class="col-12"></div>
                                                <div class="col-12">
                                                </div>
                                                <div class="col-12" style="margin-bottom:20px;">
                                                    3.2 ระบบสืบค้น
                                                </div>
                                                <div class="col-12"><button class="btn btn-primary" onclick="Newinquiry();">เพิ่มระบบสืบค้น</button></div>
                                   
                                                <div class="col-12" id="Divinquiry" style="margin-top:20px;">
                                                </div>
                                                 <div class="col-12" style="margin-bottom:20px;">
                                                    3.3 E-Book
                                                </div>
                                               <div class="col-12"><button class="btn btn-primary" onclick="Newebook();">เพิ่ม E-Book</button></div>
                                   
                                                <div class="col-12" id="Divebook" style="margin-top:20px;">
                                                </div>
                                                <div class="col-12">
                                                    <div class="col-12" style="color: red;">*** นำข้อมูลระบบสืบค้นมาจากข้อมูลพื้นฐานของระบบ</div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu7" class="container tab-pane fade">
                    <div class="container-fluid" style="font-size: 0.9em; color: black;">
                        <div class="row mt-1">
                            <div class="col-12">
                                <button class="btn btn-info" onclick="Save('7');" style="border-radius: 1px;">บันทึกหมวด</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12" style="text-align: center;">
                                <h6>หมวดที่ 7 การประเมินและปรับปรุงการดำเนินการของการฝึกประสบการณ์ภาคสนาม</h6>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. กระบวนการประเมินการฝึกประสบการณ์ภาคสนามโดยผู้เกี่ยวข้องต่อไปนี้</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                               <div class="row mt-3">
                                                <div class="col-4">
                                                   <span>วิธีการ/เครื่องมือที่ใช้ </span>
                                                </div>
                                                <div class="col-4">
                                                     <span>ระยะเวลาดำเนินการ</span>
                                                </div>
                                                <div class="col-4">
                                                     <span>ผู้รับผิดชอบ </span>
                                                </div>
                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-4">
                                                    <textarea id="Txtstudent" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                                <div class="col-4">
                                                    <textarea id="Txtstudentperiod" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                                <div class="col-4">
                                                    <textarea id="Txtstudentperson" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                            </div>

                                          <%--  <div class="row mt-1">
                                                <div class="col-12">
                                                    <span>7.1.1 นักศึกษา</span>
                                                </div>
                                                <div class="col-12">
                                                    <textarea id="Txtstudent" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                            </div>--%>
                                             <div class="row mt-1" style="display:none;">
                                                <div class="col-12">
                                                    <span>7.1.2 พยาบาลพี่เลี้ยงในแหล่งฝึกภาคปฏิบัติ</span>
                                                </div>
                                                <div class="col-12">
                                                    <textarea id="Txtnurse" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                            </div>
                                            <div class="row mt-1" style="display:none;">
                                                <div class="col-12">
                                                    <span>7.1.3 อาจารย์ผู้สอนภาคปฎิบัติ</span>
                                                </div>
                                                <div class="col-12">
                                                    <textarea id="Txtinstuctorpractical" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                            </div>
                                          <div class="row mt-1" style="display:none;">
                                                <div class="col-12">
                                                    <span>7.1.4 อาจารย์ผู้รับผิดชอบรายวิชา</span>
                                                </div>
                                                <div class="col-12">
                                                    <textarea id="Txtinstuctor" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                            </div>
                                           <div class="row mt-1" style="display:none;">
                                                <div class="col-12">
                                                    <span>7.1.5 อื่นๆ</span>
                                                </div>
                                                <div class="col-12">
                                                    <textarea id="Txtother" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>2. กระบวนการทบทวนผลการประเมินและการวางแผนปรับปรุง</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                             <div class="row mt-1">
                                                <div class="col-3">
                                                   <span>วัตถุประสงค์</span>
                                                </div>
                                                 <div class="col-3">
                                                   <span>ข้อมูล/หลักฐาน</span>
                                                </div>
                                                   <div class="col-3">
                                                   <span>วิธีการพัฒนา/ปรับปรุง</span>
                                                </div>
                                                   <div class="col-3">
                                                   <span>ผู้รับผิดชอบ</span>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-3">
                                                    <textarea id="Txtimproveobjective" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                                    <div class="col-3">
                                                    <textarea id="Txtimprovedata" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                                <div class="col-3">
                                                    <textarea id="Txtimprove" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                                <div class="col-3">
                                                    <textarea id="Txtimproveperson" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                            </div>



                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>3. การทวนสอบผลสัมฤทธ์ของการฝึกปฏิบัติการพยาบาล/ภาคสนาม (หัวข้อเพิ่มเติม)</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">

                                            <div class="row mt-1">
                                                <div class="col-4">
                                                   <span>วิธีการ/เครื่องมือที่ใช้ </span>
                                                </div>
                                                  <div class="col-4">
                                                    <span>ผู้ดำเนินการ</span>
                                                </div>
                                                  <div class="col-4">
                                                   <span>เวลาดำเนินการ</span>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-4">
                                                    <textarea id="Txtreestimate" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                                
                                                  <div class="col-4">
                                                    <textarea id="Txtreestimateperson" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                                  <div class="col-4">
                                                    <textarea id="Txtreestimateperiod" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                            </div>



                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                      
                    </div>
                </div>
              
            </div>
        </div>
      
        <div class="modal fade bd-example-modal-lg" id="DivcreateTQF" tabindex="-1" role="dialog" style="z-index: 99999;" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-ku" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #82c2f3;">
                        <span style="color: white; font-size: 14px;">E-OFFICE สถาบันพระบรมราชชนก </span>
                    </div>
                    <div class="modal-body">
                        <div class="container" style="font-size: 0.9em; margin-top: 20px;">
                            <div class="row">
                                <div class="col-3" style="text-align: right;">
                                    วิทยาลัย &nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <div class="input-group mb-3">
                                        <select class="form-control" id="Cbnewcollege"></select>
                                    </div>
                                    <div class="invalid-feedback">
                                        โปรดระบุ วิทยาลัย
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-3" style="text-align: right;">
                                    หลักสูตร &nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <div class="input-group mb-3">
                                        <select class="form-control" id="Cbnewcourse"></select>
                                    </div>
                                    <div class="invalid-feedback">
                                        โปรดระบุ หลักสูตร
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-3" style="text-align: right;">
                                    ชื่อรายวิชา &nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <div class="input-group mb-3">
                                        <select class="form-control" id="Cbnewsubject"></select>
                                    </div>
                                    <div class="invalid-feedback">
                                        โปรดระบุ ชื่อรายวิชา
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-3" style="text-align: right;">
                                    ภาคการศึกษา &nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <div class="input-group mb-3">
                                        <select class="form-control" id="Cbnewterm"></select>
                                    </div>
                                    <div class="invalid-feedback">
                                        โปรดระบุ ภาคการศึกษา
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-3" style="text-align: right;">
                                    ชั้นปีที่ &nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <div class="input-group mb-3">
                                        <select class="form-control" id="Cbnewclass"></select>
                                    </div>
                                    <div class="invalid-feedback">
                                        โปรดระบุ ชั้นปีที่
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-3" style="text-align: right;">
                                    ปีการศึกษา &nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <div class="input-group mb-3">
                                        <select class="form-control" id="Cbnewyear"></select>
                                    </div>
                                    <div class="invalid-feedback">
                                        โปรดระบุ ปีการศึกษา
                                    </div>

                                </div>
                                <div class="col-12">
                                    <div style="text-align: left; color: red; display: none; margin-top: 5px; margin-bottom: 5px" id="Diverror">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-3" style="text-align: right;">
                                    รุ่น &nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <div class="input-group mb-3">
                                       <input type="number" style="text-align:right;" id="Txtnewgeneration" class="form-control" />
                                    </div>
                                    <div class="invalid-feedback">
                                        โปรดระบุ รุ่น
                                    </div>

                                </div>
                                <div class="col-12">
                                    <div style="text-align: left; color: red; display: none; margin-top: 5px; margin-bottom: 5px" id="Diverror">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="min-height: 50px; margin-top: 10%; font-size: 14px;"></div>
                    <div class="modal-footer">
                        <button type="button" onclick="DonewTQF();" class="btn btn-primary" style="border-radius: 2px; font-size: 0.8em;">บันทึก</button>
                        <button type="button" class="btn btn-secondary" style="border-radius: 2px; font-size: 0.8em;" data-dismiss="modal">ปิดหน้าต่างนี้</button>
                    </div>
                </div>
            </div>
        </div>

          <div class="modal" id="Divmodalobjective" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span>วัตถุประสงค์รายวิชา</span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="container" id="Divmodalobjectivecont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 0.9em; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>

         <div class="modal" id="Divinstuctor" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span>อาจารย์</span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                        <input type="hidden" id="HdInstuctortypeid" />
                        <div class="container" id="Divinstuctorcont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 0.9em; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>
        


           <div class="modal" id="Divmodaltextbook" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span>ตำราและเอกสารหลัก</span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                       
                        <div class="container" id="Divtextbookcont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 0.9em; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>

           <div class="modal" id="Divmodalebook" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span>E-Book</span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                       
                        <div class="container" id="Divebookcont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 0.9em; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>

          <div class="modal" id="Divmodalinquiry" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span>ระบบสืบค้น</span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                       
                        <div class="container" id="Divinquirycont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 0.9em; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>
           <div class="modal" id="Divmodaljournal" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span>วารสารวิชาการ</span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                       
                        <div class="container" id="Divjournalcont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 0.9em; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>

          <div class="modal" id="Divmodaltool" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span>เอกสารข้อมูลแนะนำ</span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                       
                        <div class="container" id="Divtoolcont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 0.9em; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>
            <div class="modal" id="Divshowcomment" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <span>ความเห็นเพิ่มเติม</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container"  style="margin-right: 10px; min-height: 320px; padding: 8px;">
                        <div class="row">
                            <div class="col-12">
                                <span>ความเห็นเพิ่มเติม</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                              <textarea class="form-control" readonly="readonly"  id="Txtshowcomment" style="height:200px;" ></textarea>
                            </div>
                         </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">

                        <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal" onclick="Closeshowcomment();">ปิดหน้าต่างนี้</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

      <div class="modal" id="Divcomment" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <span>ความเห็นเพิ่มเติม</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container"  style="margin-right: 10px; min-height: 320px; padding: 8px;">
                        <div class="row">
                            <div class="col-12">
                                <span>ความเห็นเพิ่มเติม</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                              <textarea class="form-control" id="Txtcomment" style="height:200px;" ></textarea>
                            </div>
                         </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" style="background-color:#313131;color:white; font-size: 14px; border-radius: 0;"  onclick="Doedit();">ส่งกลับแก้ไข</button>
                        <button type="button" class="btn btn-success" style="background-color:#313131;color:white; font-size: 14px; border-radius: 0;"  onclick="Doapprove();">ตรวจสอบ / อนุมัติ</button>
                        <button type="button" class="btn btn-warning" style="background-color:#313131;color:white; font-size: 14px; border-radius: 0;"  onclick="Doreject();">ปฏิเสธ</button>
                        <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal" onclick="Closecomment();">ปิดหน้าต่างนี้</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
          
    </div>
       <div class="modal" id="Divnewtrainingsource" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <span>เพิ่มแหล่งที่ฝึก</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container" style="margin-right: 10px; min-height: 320px; padding: 8px;">
                        <div class="row">
                            <div class="col-12">
                                <span>แหล่งที่ฝึก</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                                <input type="text" class="form-control" id="Txtnewtrainingsource" value="" />
                            </div>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-standard" style="background-color: #313131; color: white; font-size: 14px; border-radius: 0;" onclick="Savetrainingsource();">บันทึก</button>
                        <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal" onclick="Closenewtrainingsource();">ปิดหน้าต่างนี้</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
        <input type="hidden" id="Hdapprove" value="" />
        <input type="hidden" id="Hdlearningsetid" value="" />
        <a id="back2Top" title="Back to top" href="#">&#10148;</a>
        <script src="../../Select2/js/bootstrap-select.js"></script>



       <div class="modal" id="Divnewservicelv" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <span>เพิ่มสถานะบริการ</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container" style="margin-right: 10px; min-height: 320px; padding: 8px;">
                        <div class="row">
                            <div class="col-12">
                                <span>ระดับสถานะบริการ</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                                <input type="text" class="form-control" id="Txtnewservicelv" value="" />
                            </div>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-standard" style="background-color: #313131; color: white; font-size: 14px; border-radius: 0;" onclick="Saveservicelv();">บันทึก</button>
                        <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal" onclick="Closenewservicelv();">ปิดหน้าต่างนี้</button>
                    </div>

                </div>
            </div>
        </div>
    </div>


       <div class="modal" id="Divnewquality" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <span>เพิ่มระบบคุณภาพ</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container" style="margin-right: 10px; min-height: 320px; padding: 8px;">
                        <div class="row">
                            <div class="col-12">
                                <span>ระบบคุณภาพ</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                                <input type="text" class="form-control" id="Txtnewquality" value="" />
                            </div>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-standard" style="background-color: #313131; color: white; font-size: 14px; border-radius: 0;" onclick="Savequality();">บันทึก</button>
                        <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal" onclick="Closenewquality();">ปิดหน้าต่างนี้</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</body>
</html>

