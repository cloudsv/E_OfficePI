<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TQF3.aspx.cs" Inherits="E_OfficePI.Page.TQF.TQF3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <link href="../../js/datepicker/datepicker.css" rel="stylesheet" />
    <link href="../../Select2/css/bootstrap-select.css" rel="stylesheet" />
    <script src="../../js/Numeric.js"></script>
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
            color: white;
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
        .bootstrap-select .dropdown-menu {
	width: 100%;
  
}

.bootstrap-select .dropdown-menu li small {
	white-space: normal;
}
    </style>
    <script>

        function Calc() {
            var value = 0;
            var res = 0;
            $('*[id*=Txtestimatepercent_]').each(function () {
                try {
                    if ($(this).val() == '') {
                        $(this).val(0);
                    }
                    res += parseFloat($(this).val().replace(/,/g, ''));
                }
                catch (ex) {
                    res = 0;
                }
            });
            $('#Txttotalpercent').val(FormatWithRound2Digit(res));
        }
       
        function Deleterecommenddocument(x) {
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Deleterecommenddocument",
                data: "{'json' :'" + x + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    Updaterecommenddocument();
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != "") {
                        Msgbox(res);
                        return;
                    }
                    Getrecommenddocument();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Newrecommenddocument() {
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Newrecommenddocument",
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
                    Getrecommenddocument();
                },
                async: true,
                error: function (er) {

                }
            });


        }
        function Updaterecommenddocument() {

            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divrecommenddocument').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updaterecommenddocument",
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
                    Getrecommenddocument();
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Getrecommenddocument() {

            var html = '';
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Getrecommenddocument",
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
                            html += '<textarea class="form-control" onblur="Updaterecommenddocument();" id="Txtrecommenddocument_' + res[i]['TQFrecommenddocumentId'] + '" >' + res[i]['Value'] + '</textarea>';
                            html += '</td>';


                            html += '<td>';
                            html += '<button onclick="Deleterecommenddocument(' + res[i]['TQFrecommenddocumentId'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';

                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    html += '</table>';
                    $('#Divrecommenddocument').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }



        function Deleteebook(x) {
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Deleteebook",
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
                url: "\../Page/TQF/TQF3.aspx/Newebook",
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
                url: "\../Page/TQF/TQF3.aspx/Updateebook",
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
                url: "\../Page/TQF/TQF3.aspx/Getebook",
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
                url: "\../Page/TQF/TQF3.aspx/Deletejournal",
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
                url: "\../Page/TQF/TQF3.aspx/Newjournal",
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
                url: "\../Page/TQF/TQF3.aspx/Updatejournal",
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
                url: "\../Page/TQF/TQF3.aspx/Getjournal",
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






        function Deleteother(x) {
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Deleteother",
                data: "{'json' :'" + x + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    Updateother();
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != "") {
                        Msgbox(res);
                        return;
                    }
                    Getother();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Newother() {
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Newother",
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
                    Getother();
                },
                async: true,
                error: function (er) {

                }
            });


        }
        function Updateother() {

            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divother').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updateother",
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
                    Getother();
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Getother() {

            var html = '';
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Getother",
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
                            html += '<textarea class="form-control" onblur="Updateother();" id="Txtother_' + res[i]['TQFotherId'] + '" >' + res[i]['Value'] + '</textarea>';
                            html += '</td>';


                            html += '<td>';
                            html += '<button onclick="Deleteother(' + res[i]['TQFotherId'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';

                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    html += '</table>';
                    $('#Divother').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }





        function Deleteinquiry(x) {
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Deleteinquiry",
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
                url: "\../Page/TQF/TQF3.aspx/Newinquiry",
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
                url: "\../Page/TQF/TQF3.aspx/Updateinquiry",
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
                url: "\../Page/TQF/TQF3.aspx/Getinquiry",
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






        

        function Closeshowcomment() {
            $('#Divshowcomment').modal('hide');
        }
        function Showcomment(x) {
            var json = x;

            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Showcomment",
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
                        url: "\../Page/TQF/TQF3.aspx/Send2validate",
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
                    url: "\../Page/TQF/TQF3.aspx/Doreject",
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
                    url: "\../Page/TQF/TQF3.aspx/Doedit",
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
                    url: "\../Page/TQF/TQF3.aspx/Doapprove",
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


        function SelectTQF(id) {
            var json = '';
            json += id;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/SelectTQF",
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
        function DelTQF(id) {
            var json = '';
            var html = '';
            $("#DivConfirm").modal('show');
            $('#DivConfirmMsg').html('ยืนยันการลบรายการ ?');
            $('#CmdConfirm').on('click', function () {
                json = id;
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF3.aspx/DelTQF",
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
        function Closenewest() {
            $('#Divnewest').modal('hide');
        }
        function Saveest() {
            var json = '';
            var html = '';
            json += $('#Txtnewest').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Saveest",
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
                    $('#Divnewest').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Getlearningoutput();
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function AddEst() {
            $('#Txtnewest').val('');
            $('#Divnewest').modal('show');
        }




        function Closenewpar() {
            $('#Divnewpar').modal('hide');
        }
        function Savepar() {
            var json = '';
            var html = '';
            json += $('#Txtnewpar').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Savepar",
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
                    $('#Divnewpar').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Getlearningoutput();
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function AddPar() {
            $('#Txtnewpar').val('');
            $('#Divnewpar').modal('show');
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
        function Getsubjectgroup() {

            var json;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Getsubjectgroup",
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
        function Costdetail() {
            var json = '';
            var html = '';
            json += $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Costdetail",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {

                    html += '<table class="table table-bordered">';
                    html += '<tr>';
                    html += '<td  style="width:60%;text-align:left;">ค่าใช้จ่าย</td>';
                    html += '<td  style="text-align:right;">จำนวนเงิน</td>';
                    html += '</tr>';
                    for (i = 0; i < response.d.length; i++) {
                        html += '<tr>';
                        html += '<td style="width:60%;text-align:left;">' + response.d[i]['Costname'] + '</td>';
                        html += '<td style="text-align:right;"><input type="number"  style="text-align:right;" Class="form-control" id="Txtcostvalue_' + response.d[i]['Costid'] + '" value="' + response.d[i]['Costvalue'] + '" /></td>';
                        html += '</tr>';
                    }
                    html += '</table>';
                    $('#Divcostcont').html(html);
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Savecost() {
            var json = '';
            $("#Divcostcont").find('textarea').each(function () {
                json += $(this).attr('id') + ':' + $(this).val() + "|";

            });
            $("#Divcostcont").find('select').each(function () {

                json += $(this).attr('id') + ':' + $(this).val() + "|";

            });
            $("#Divcostcont").find('input[type = number]').each(function () {

                json += $(this).attr('id') + ':' + $(this).val() + "|";

            });
            $("#Divcostcont").find('input[type = checkbox]').each(function () {

                json += $(this).attr('id') + ':' + $(this).prop('checked') + "|";

            });
            json += 'HdTQFId :' + $('#HdTQFId').val() + "|";
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Savecost",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function (xhr) {

                },
                success: function (response) {
                    if (response.d != '') {
                        Msgbox(response.d);
                        return;
                    }
                    Msgboxsuccess('บันทึกค่าใช้จ่ายเรียบร้อยแล้ว');

                },
                async: false,
                error: function (er) {
                    Msgbox(er.status);
                }
            });
        }
        function Saveteachingplandetail() {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divteachingplandetail').find('input').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Saveteachingplandetail",
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
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');

                },
                async: false,
                error: function (er) {

                }
            });

        }
        function Delteachingplandetail(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Delteachingplandetail",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    Saveteachingplandetail();
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getteachingplandetail();
                },
                async: false,
                error: function (er) {

                }
            });
        }
        function Viewteachingplandetailattachmentconclusion(x) {
            window.open('http://203.154.74.202/E-officepi/Attachment/file/' + x, '_blank');
        }
        function Viewteachingplandetailattachmentplan(x) {
            window.open('http://203.154.74.202/E-officepi/Attachment/file/' + x, '_blank');
        }
        function Delteachingplandetailattachmentconclusion(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Delteachingplandetailattachmentconclusion",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    Saveteachingplandetail();
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getteachingplandetail();
                },
                async: false,
                error: function (er) {

                }
            });
        }
        function Delteachingplandetailattachmentplan(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Delteachingplandetailattachmentplan",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    Saveteachingplandetail();
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getteachingplandetail();
                },
                async: false,
                error: function (er) {

                }
            });
        }
        function CallBackUpload(Ctrl, RunningNo) {

            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/CallBackUpload",
                data: "{'Ctrl' : '" + Ctrl + "','RunningNo' :'" + RunningNo + "','Teachingplandetailid' :'" + $('#Hdteachingplandetailid').val() + "','TQFId' :'" + $('#HdTQFId').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    Saveteachingplandetail();
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getteachingplandetail();
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

        function Uploadteachingplanconclusion(x) {
            $('#Hdteachingplandetailid').val(x);

            var key = 'teachingplandetailconclusion';
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
        function Uploadteachingplan(x) {
            $('#Hdteachingplandetailid').val(x);

            var key = 'teachingplandetail';
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
        function DelEst(Learningoutputid, x) {
            var json = '';
            json = '';
            json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
            json += 'Learningoutputid :' + Learningoutputid + '|';
            json += 'val :' + x + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/DelEst",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {

                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getlearningoutput();
                },
                async: false,
                error: function (er) {

                }
            });
        }
        function SelEst(x) {
            $('#Hdlearningsetid').val(x);
            $('#Divlearningoutput').modal('show');
            ClearResource('TQF/TQF3.aspx', 'Gvestimate');
            var Cri = x;
            var Columns = ["ผลการเรียนรู้!L"];
            var Data = ["Estimate"];
            var Searchcolumns = ["ผลการเรียนรู้"];
            var SearchesDat = ["Estimate"];
            var Width = ["100%"];
            var Gvsearchinstuctor = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvestimate', 1000, Width, Data, "", '', '2', '', '', '', '', '', '', 'ASC#N!id', 'id', '', 'id', Cri, '');
            $('#Divlearningoutputcont').html(Gvsearchinstuctor._Tables());
            Gvsearchinstuctor._Bind();
        }
        function DelInstructor(Userid, Theoryplan) {
            var json = '';
            json = '';
            json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
            json += 'Theoryplan :' + Theoryplan + '|';
            json += 'val :' + Userid + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/DelInstructor",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {

                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getheoryplan();
                },
                async: false,
                error: function (er) {

                }
            });
        }
        function DelPar(Learningoutputid, x) {
            var json = '';
            json = '';
            json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
            json += 'Learningoutputid :' + Learningoutputid + '|';
            json += 'val :' + x + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/DelPar",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {

                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getlearningoutput();
                },
                async: false,
                error: function (er) {

                }
            });
        }
        function SelPar(x) {
            $('#Hdlearningsetid').val(x);
            $('#Divlearningoutput').modal('show');
            ClearResource('TQF/TQF3.aspx', 'Gvparticular');
            var Cri = x;
            var Columns = ["ผลการเรียนรู้!L"];
            var Data = ["Particular"];
            var Searchcolumns = ["ผลการเรียนรู้"];
            var SearchesDat = ["Particular"];
            var Width = ["100%"];
            var Gvsearchinstuctor = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvparticular', 1000, Width, Data, "", '', '2', '', '', '', '', '', '', 'ASC#N!id', 'id', '', 'id', Cri, '');
            $('#Divlearningoutputcont').html(Gvsearchinstuctor._Tables());
            Gvsearchinstuctor._Bind();
        }

        function DelLen(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/DelLen",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {

                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getlearningoutput();
                },
                async: false,
                error: function (er) {

                }
            });
        }
        function SelLen(x) {
            $('#Hdlearningsetid').val(x);
            $('#Divlearningoutput').modal('show');
            ClearResource('TQF/TQF3.aspx', 'Gvlearningoutput');
            var Cri = x;
            var Columns = ["ผลการเรียนรู้!L"];
            var Data = ["Output"];
            var Searchcolumns = ["ผลการเรียนรู้"];
            var SearchesDat = ["Output"];
            var Width = ["100%"];
            var Gvsearchinstuctor = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvlearningoutput', 1000, Width, Data, "", '', '2', '', '', '', '', '', '', 'ASC#N!id', 'id', '', 'id', Cri, '');
            $('#Divlearningoutputcont').html(Gvsearchinstuctor._Tables());
            Gvsearchinstuctor._Bind();
        }
        function DelLearningset(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/DelLearningset",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {

                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getlearningoutput();
                },
                async: false,
                error: function (er) {

                }
            });
        }
        function Newlearningset() {
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Newlearningset",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");

                },
                success: function (response) {

                    Getlearningoutput();
                },
                async: false,
                error: function (er) {

                }
            });
        }

        function Newteachingplandetail() {
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Newteachingplandetail",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                    Saveteachingplandetail();
                },
                success: function (response) {

                    Getteachingplandetail();
                },
                async: false,
                error: function (er) {

                }
            });
        }
        function Getteachingplandetail() {
            var _html = '';
            var i, j = 0;
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Getteachingplandetail",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    if (response.d.length == 0) {
                        _html += "<div style='text-align:center; height: 50px; margin - top: 25px; color: red; font - size: 15px; vertical - align: bottom; text - align : center;'>ไม่พบข้อมูล</div>";
                        $('#Divteachingplandetail').html(_html);
                    }
                    else {
                        _html = '<div>';
                        for (i = 0; i < response.d.length; i++) {

                            _html += "<div class='row mt-3' >";
                            _html += '<div class="card card-body bg-light" style="margin-top:10px;" >';




                            _html += "<div class='col-12'>";
                            _html += "<table style='width:100%;' >";
                            _html += "<tr>";
                            _html += "<td><span>แผนการสอนเรื่อง</span>&nbsp;</td>";
                            _html += "<td><input type='text' style='width:220px;'  class='form-control' id='Txtteachingplandetailsubject_" + response.d[i]['id'] + "' value='" + response.d[i]['Teachingplandetailsubject'] + "' /></td>";
                            _html += "<td><span>รายละเอียด</span>&nbsp;</td>";
                            _html += "<td><input type='text' class='form-control' id='Txtteachingplandetaildesc_" + response.d[i]['id'] + "' value='" + response.d[i]['Teachingplandetaildesc'] + "' /></td>";
                            _html += "<td><span>ผู้เรียน</span>&nbsp;</td>";
                            _html += "<td><input type='text' class='form-control' id='Txtteachingplandetailstudent_" + response.d[i]['id'] + "' value='" + response.d[i]['Teachingplandetailstudent'] + "' /></td>";
                            _html += "<td><span>สถานที่</span>&nbsp;</td>";
                            _html += "<td><input type='text' class='form-control' id='Txtteachingplandetailplace_" + response.d[i]['id'] + "' value='" + response.d[i]['Teachingplandetailplace'] + "' /></td>";


                            _html += "<td>&nbsp;<button class='btn btn-danger' onclick='Delteachingplandetail(" + response.d[i]['id'] + ");'><i class='fa fa-trash' aria-hidden='true'></i></button></td>";
                            _html += "</tr>";
                            _html += "</table>";
                            _html += "</div>";



                            _html += "<div class='col-12'>";
                            _html += "<hr/>";
                            _html += "</div>";


                            _html += "<div class='col-12'>";

                            _html += "<table style='width:100%;text-align:center;border-color:gray;padding:5px;' border='1' >";

                            _html += "<tr>";
                            _html += "<td>เอกสารแผนการสอน";
                            _html += "</td>";
                            _html += "<td>บันทึกสรุปหลังการสอน";
                            _html += "</td>";
                            _html += "</tr>";
                            _html += "<tr>";
                            _html += "<td>";
                            _html += "<table style='width:100%;border-spacing: 10px!important;border-collapse: separate!important;'>";
                            _html += "<tr>";
                            _html += "<td colspan='2' style='text-algin:right;'>";
                            _html += "<a style='color:blue;text-decoration:underline;margin-bottom:10px;'  onclick='Uploadteachingplan(" + response.d[i]['id'] + ");'>กดเพื่อ Upload เอกสาร</a>";
                            _html += "</td>";
                            _html += "</tr>";
                            for (j = 0; j < response.d[i]['Teachingplandetailattchmentplan'].length; j++) {
                                _html += "<tr>";
                                _html += "<td>";
                                _html += "<div  style='border: 1px solid lightgray;background-color:white;margin:10px;padding:10px;'><a onclick='Viewteachingplandetailattachmentplan(\"" + response.d[i]['Teachingplandetailattchmentplan'][j]['Url'] + "\");'>" + response.d[i]['Teachingplandetailattchmentplan'][j]['Filename'] + "</a></div>";
                                _html += "</td>";
                                _html += "<td>";
                                _html += "<button style='font-size:9px !important;'  class='btn btn-danger' onclick='Delteachingplandetailattachmentplan(" + response.d[i]['Teachingplandetailattchmentplan'][j]['Attachmentid'] + ");'><i class='fa fa-trash' style='font-size:9px !important;' aria-hidden='true'></i></button>";

                                _html += "</td>";
                                _html += "</tr>";
                            }
                            _html += "</table>";
                            _html += "</td>";





                            _html += "<td>";
                            _html += "<table style='width:100%;border-spacing: 10px!important;border-collapse: separate!important;'>";
                            _html += "<tr>";
                            _html += "<td colspan='2' style='text-algin:right;'>";
                            _html += "<a style='color:blue;text-decoration:underline;margin-bottom:10px;'  onclick='Uploadteachingplanconclusion(" + response.d[i]['id'] + ");'>กดเพื่อ Upload เอกสาร</a>";
                            _html += "</td>";
                            _html += "</tr>";

                            for (j = 0; j < response.d[i]['Teachingplandetailattchmentconclusion'].length; j++) {
                                _html += "<tr>";
                                _html += "<td>";
                                _html += "<div  style='border: 1px solid lightgray;background-color:white;margin:10px;padding:10px;'><a onclick='Viewteachingplandetailattachmentconclusion(\"" + response.d[i]['Teachingplandetailattchmentconclusion'][j]['Url'] + "\");'>" + response.d[i]['Teachingplandetailattchmentconclusion'][j]['Filename'] + "</a></div>";
                                _html += "</td>";
                                _html += "<td>";
                                _html += "<button style='font-size:9px !important;'  class='btn btn-danger' onclick='Delteachingplandetailattachmentconclusion(" + response.d[i]['Teachingplandetailattchmentconclusion'][j]['Attachmentid'] + ");'><i class='fa fa-trash' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                                //_html += "<a onclick='Delteachingplandetailattachmentconclusion(" + response.d[i]['Teachingplandetailattchmentconclusion'][j]['Attachmentid'] + ");'>ลบ</a>";
                                _html += "</td>";
                                _html += "</tr>";
                            }

                            _html += "</table>";
                            _html += "</td>";

                            _html += "</tr>";
                            _html += "</table>";

                            _html += "</div>";

                            _html += "</div>";
                            _html += "</div>";
                        }
                        _html += "</div>";
                    }

                    $('#Divteachingplandetail').html(_html);




                    //_html = '<div class="card card-body bg-light">';
                    //_html += "<div class='row' >";
                    //_html += "<div class='col-3' >";
                    //_html += "แบบฟอร์มแผนการสอนภาคทฤษฏี";
                    //_html += "</div>";
                    //_html += "<div class='col-3'>";
                    //_html += "เอกสารแผนการสอน";
                    //_html += "</div>";
                    //_html += "<div class='col-3'>";
                    //_html += "บันทึกสรุปหลังการสอน";
                    //_html += "</div>";
                    //_html += "</div>";
                    //_html += "</div>";
                    //for (i = 0; i < response.d.length; i++) {
                    //    _html += '<div class="card card-body bg-light" style="margin-top:10px;" >';
                    //    _html += "<div class='row'>";
                    //    _html += "<div class='col-3' style='border: 1px solid lightgray;padding:10px;background-color:white;margin:10px;' >";
                    //    _html += "<table >";
                    //    _html += "<tr>";
                    //    _html += "<td style='text-align:left'>";
                    //    _html += "<span>แผนการสอนเรื่อง</span>";
                    //    _html += "</td>";
                    //    _html += "</tr>";
                    //    _html += "<tr>";
                    //    _html += "<td>";
                    //    _html += "<input type='text' style='width:220px;'  class='form-control' id='Txtteachingplandetailsubject_" + response.d[i]['id'] + "' value='" + response.d[i]['Teachingplandetailsubject'] + "' />";
                    //    _html += "</td>";
                    //    _html += "</tr>";
                    //    _html += "<tr>";
                    //    _html += "<td style='text-align:left !important;'>";
                    //    _html += "<span>รายละเอียด</span>";
                    //    _html += "</td>";
                    //    _html += "</tr>";
                    //    _html += "<tr>";
                    //    _html += "<td>";
                    //    _html += "<input type='text' class='form-control' id='Txtteachingplandetaildesc_" + response.d[i]['id'] + "' value='" + response.d[i]['Teachingplandetaildesc'] + "' />";
                    //    _html += "</td>";
                    //    _html += "</tr>";
                    //    _html += "<tr>";
                    //    _html += "<td style='text-align:left'>";
                    //    _html += "<span>ผู้เรียน</span>";
                    //    _html += "</td>";
                    //    _html += "</tr>";
                    //    _html += "<tr>";
                    //    _html += "<td>";
                    //    _html += "<input type='text' class='form-control' id='Txtteachingplandetailstudent_" + response.d[i]['id'] + "' value='" + response.d[i]['Teachingplandetailstudent'] + "' />";
                    //    _html += "</td>";
                    //    _html += "</tr>";
                    //    _html += "<tr>";
                    //    _html += "<td style='text-align:left'>";
                    //    _html += "<span>สถานที่</span>";
                    //    _html += "</td>";
                    //    _html += "</tr>";
                    //    _html += "<tr>";
                    //    _html += "<td>";
                    //    _html += "<input type='text' class='form-control' id='Txtteachingplandetailplace_" + response.d[i]['id'] + "' value='" + response.d[i]['Teachingplandetailplace'] + "' />";
                    //    _html += "</td>";
                    //    _html += "</tr>";
                    //    _html += "</table>";
                    //    _html += "</div>";


                    //    _html += "<div class='col-3' style='border: 1px solid lightgray;padding:10px;background-color:white;margin:10px;'>";
                    //    _html += "<table>";
                    //    _html += "<tr>";
                    //    _html += "<td colspan='2' style='text-algin:center;'>";
                    //    _html += "<a style='color:blue;text-decoration:underline;margin-bottom:10px;'  onclick='Uploadteachingplan(" + response.d[i]['id'] + ");'>กดเพื่อ Upload เอกสาร</a>";
                    //    _html += "</td>";
                    //    _html += "</tr>";
                    //    for (j = 0; j < response.d[i]['Teachingplandetailattchmentplan'].length; j++) {
                    //        _html += "<tr>";
                    //        _html += "<td>";
                    //        _html += "<div  style='border: 1px solid lightgray;background-color:white;'><a onclick='Viewteachingplandetailattachmentplan(\"" + response.d[i]['Teachingplandetailattchmentplan'][j]['Url'] + "\");'>" + response.d[i]['Teachingplandetailattchmentplan'][j]['Filename'] + "</a></div>";
                    //        _html += "</td>";
                    //        _html += "<td>";
                    //        _html += "<button style='font-size:9px !important;'  class='btn btn-danger' onclick='Delteachingplandetailattachmentplan(" + response.d[i]['Teachingplandetailattchmentplan'][j]['Attachmentid'] + ");'><i class='fa fa-trash' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                    //        //_html += "<a onclick='Delteachingplandetailattachmentplan(" + response.d[i]['Teachingplandetailattchmentplan'][j]['Attachmentid'] + ");'>ลบ</a>";
                    //        _html += "</td>";
                    //        _html += "</tr>";
                    //    }

                    //    _html += "</table>";
                    //    _html += "</div>";



                    //    _html += "<div class='col-3' style='border: 1px solid lightgray;padding:10px;background-color:white;margin:10px;'>";
                    //    _html += "<table>";
                    //    _html += "<tr>";
                    //    _html += "<td colspan='2'>";
                    //    _html += "<a style='color:blue;text-decoration:underline;margin-bottom:10px;'  onclick='Uploadteachingplanconclusion(" + response.d[i]['id'] + ");'>กดเพื่อ Upload เอกสาร</a>";
                    //    _html += "</td>";
                    //    _html += "</tr>";

                    //    for (j = 0; j < response.d[i]['Teachingplandetailattchmentconclusion'].length; j++) {
                    //        _html += "<tr>";
                    //        _html += "<td>";
                    //        _html += "<div  style='border: 1px solid lightgray;background-color:white;'><a onclick='Viewteachingplandetailattachmentconclusion(\"" + response.d[i]['Teachingplandetailattchmentconclusion'][j]['Url'] + "\");'>" + response.d[i]['Teachingplandetailattchmentconclusion'][j]['Filename'] + "</a></div>";
                    //        _html += "</td>";
                    //        _html += "<td>";
                    //        _html += "<button style='font-size:9px !important;'  class='btn btn-danger' onclick='Delteachingplandetailattachmentconclusion(" + response.d[i]['Teachingplandetailattchmentconclusion'][j]['Attachmentid'] + ");'><i class='fa fa-trash' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                    //        //_html += "<a onclick='Delteachingplandetailattachmentconclusion(" + response.d[i]['Teachingplandetailattchmentconclusion'][j]['Attachmentid'] + ");'>ลบ</a>";
                    //        _html += "</td>";
                    //        _html += "</tr>";
                    //    }

                    //    _html += "</table>";
                    //    _html += "</div>";



                    //    _html += "<div class='col-2'>";

                    //    _html += "<button class='btn btn-danger' onclick='Delteachingplandetail(" + response.d[i]['id'] + ");'><i class='fa fa-trash' aria-hidden='true'></i></button>";
                    //    _html += "</div>";

                    //    _html += "</div>";
                    //    _html += "</div>";
                    //}

                    //$('#Divteachingplandetail').html(_html);
                    //}




                },
                async: false,
                error: function (er) {

                }
            });
        }

        function Getestimateplan() {
            var _html = '';
            var i, j = 0;
            var totalpercent = '';
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Getestimateplan",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    if (response.d.length == 0) {
                        _html += "<tr>";
                        _html += "<td colspan='4'>";
                        _html += "<div style='text-align:center; height: 50px; margin - top: 25px; color: red; font - size: 15px; vertical - align: bottom; text - align : center;'>ไม่พบข้อมูล</div>";
                        _html += "</td>";
                        _html += "</tr>";
                        $('#Divestimateplan').html(_html);
                    }
                    else {
                        for (i = 0; i < response.d.length; i++) {
                            _html += "<tr>";


                            _html += "<td>";
                            for (j = 0; j < response.d[i]['Estimateplanobjective'].length; j++) {
                                _html += '<div>';
                                if (response.d[i]['Estimateplanobjective'][j]['Selected'] != '') {
                                    _html += '<input type="checkbox" id="Chkepobjecttive_' + response.d[i]['id'] + '_' + response.d[i]['Estimateplanobjective'][j]['Objectiveid'] + '" onclick="Updateestimateobjective(\'Chkepobjecttive_' + response.d[i]['id'] + '_' + response.d[i]['Estimateplanobjective'][j]['Objectiveid'] + '\');" checked />&nbsp;<span>' + response.d[i]['Estimateplanobjective'][j]['Objective'] + '</span>';
                                }
                                else {
                                    _html += '<input type="checkbox" id="Chkepobjecttive_' + response.d[i]['id'] + '_' + response.d[i]['Estimateplanobjective'][j]['Objectiveid'] + '" onclick="Updateestimateobjective(\'Chkepobjecttive_' + response.d[i]['id'] + '_' + response.d[i]['Estimateplanobjective'][j]['Objectiveid'] + '\');"  />&nbsp;<span>' + response.d[i]['Estimateplanobjective'][j]['Objective'] + '</span>';
                                }
                                _html += '<div>';
                            }
                            _html += "</td>";

                            _html += "<td>";

                            for (j = 0; j < response.d[i]['Estimateplannestimate'].length; j++) {
                                _html += '<div>';
                                if (response.d[i]['Estimateplannestimate'][j]['Selected'] != '') {
                                    _html += '<input type="checkbox" id="Chkepestimate_' + response.d[i]['id'] + '_' + response.d[i]['Estimateplannestimate'][j]['Estimateid'] + '" onclick="Updateestimateestimate(\'Chkepestimate_' + response.d[i]['id'] + '_' + response.d[i]['Estimateplannestimate'][j]['Estimateid'] + '\');" checked />&nbsp;<span>' + response.d[i]['Estimateplannestimate'][j]['Estimatename'] + '</span>';
                                }
                                else {
                                    _html += '<input type="checkbox" id="Chkepestimate_' + response.d[i]['id'] + '_' + response.d[i]['Estimateplannestimate'][j]['Estimateid'] + '" onclick="Updateestimateestimate(\'Chkepestimate_' + response.d[i]['id'] + '_' + response.d[i]['Estimateplannestimate'][j]['Estimateid'] + '\');"  />&nbsp;<span>' + response.d[i]['Estimateplannestimate'][j]['Estimatename'] + '</span>';
                                }
                                _html += '<div>';
                            }
                            _html += "</td>";
                            _html += "<td>";
                            _html += "<input type='text' class='form-control' style='text-align:right;'   id='Txtestimateweek_" + response.d[i]['id'] + "' value= '" + response.d[i]['Week'] + "' />"
                            _html += "</td>";
                            _html += "<td>";
                            _html += "<input  class='form-control' style='text-align:right;' maxlength='3' style='text-align:right;' onkeyup='Calc();' onblur='FormatWithRound(this, 2)' onfocus='UnFormat(this)' onkeypress='OnlyNumeric(event, this)' id='Txtestimatepercent_" + response.d[i]['id'] + "' value= '" + response.d[i]['Percent'] + "' />"
                            _html += "</td>";
                            _html += "<td>";
                            _html += "<button onclick='Delestimateplan(" + response.d[i]['id'] + ");' class='btn btn-danger' ><i class='fa fa-trash' aria-hidden='true'></i></button>";
                            _html += "</td>";


                            _html += "</tr>";
                            totalpercent = Number(totalpercent) + Number(response.d[i]['Percent']);
                        }
                        $('#Divestimateplan').html(_html);
                        $('#Txttotalpercent').val(FormatWithRound2Digit(totalpercent));
                 
                        for (i = 0; i < response.d.length; i++) {

                            //$("#Dtptptrdate_" + response.d[i]['id']).datepicker({
                            //    format: "dd/mm/yyyy",
                            //    todayBtn: "linked",
                            //    language: "th",
                            //    forceParse: false,
                            //    autoclose: true,
                            //    todayHighlight: true
                            //});

                            //Getteachingtopicplanctrl('Cbtpteachingplan_' + response.d[i]['id']);
                            //if (response.d[i]['estimateplanntopic'].length != 0) {
                            //    $('#Cbtpteachingplan_' + response.d[i]['id']).val(response.d[i]['estimateplanntopic'][0]['Teachingplanid']);
                            //    Getteachingtopicctrl(response.d[i]['estimateplanntopic'][0]['Teachingplanid'], 'Cbtpteachingtopic_' + response.d[i]['id'], response.d[i]['estimateplanntopic'][0]['Teachingtopicid']);
                            //    $('#Cbtpteachingtopic_' + response.d[i]['id']).val(response.d[i]['estimateplanntopic'][0]['Teachingtopicid']);

                            //}
                            //else {
                            //    Getteachingtopicctrl("", 'Cbtpteachingtopic_' + response.d[i]['id'], "");
                            //}


                        }
                    }




                },
                async: false,
                error: function (er) {

                }
            });


        }

        function Saveestimateplan() {
            var json = '';
            var Div = 'Divestimateplan'
            var num;
            
            $("#" + Div).find('input').each(function () {
                json += $(this).attr('id') + ':' + $(this).val() + "|";
            });
            $("#" + Div).find('select').each(function () {
                json += $(this).attr('id') + ':' + $(this).val() + "|";
            });
            json += 'TQFid:' + $('#HdTQFId').val() + '|';
            Calc();
            num = parseFloat($('#Txttotalpercent').val().replace(/,/g, ''));
            if (num > 100) {
                Msgbox('ร้อยละต้องไม่เกิน 100');
                return;
            }
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Saveestimateplan",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                    
                },
                success: function (response) {
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    Getestimateplan();
                },
                async: false,
                error: function (er) {
                }
            });

        }
        function Savetheoryplan() {
            var json = '';
            var Div = 'Divtheoryplan'
            $("#" + Div).find('input').each(function () {
                json += $(this).attr('id') + ':' + $(this).val() + "|";
            });
            $("#" + Div).find('select').each(function () {
                json += $(this).attr('id') + ':' + $(this).val() + "|";
            });
            json += 'TQFid:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Savetheoryplan",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');

                },
                async: false,
                error: function (er) {
                }
            });

        }


        function Delestimateplan(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Delestimateplan",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    Getestimateplan();
                },
                async: false,
                error: function (er) {
                }
            });
        }

        function Updateestimateobjective(ctrl) {
            var json = '';
            json += 'val:' + $('#' + ctrl).prop('checked') + '|';
            json += 'ctrl:' + ctrl + '|';
            json += 'TQFid:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updateestimateobjective",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    Getestimateplan();
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Updateestimateestimate(ctrl) {
            var json = '';
            json += 'val:' + $('#' + ctrl).prop('checked') + '|';
            json += 'ctrl:' + ctrl + '|';
            json += 'TQFid:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updateestimateestimate",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    Getestimateplan();
                },
                async: false,
                error: function (er) {
                }
            });
        }



        function Deltheoryplan(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Deltheoryplan",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    Savetheoryplan();
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    Getheoryplan();
                },
                async: true,
                error: function (er) {
                }
            });
        }
        function Updatetheoryobjective(ctrl) {
            var json = '';
            json += 'val:' + $('#' + ctrl).prop('checked') + '|';
            json += 'ctrl:' + ctrl + '|';
            json += 'TQFid:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updatetheoryobjective",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    Savetheoryplan();
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    Getheoryplan();
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Updatetheoryestimate(ctrl) {
            var json = '';
            json += 'val:' + $('#' + ctrl).prop('checked') + '|';
            json += 'ctrl:' + ctrl + '|';
            json += 'TQFid:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updatetheoryestimate",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                    Savetheoryplan();
                },
                success: function (response) {
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    Getheoryplan();
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Updatetheoryparticular(ctrl) {
            var json = '';
            json += 'val:' + $('#' + ctrl).prop('checked') + '|';
            json += 'ctrl:' + ctrl + '|';
            json += 'TQFid:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updatetheoryparticular",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    Savetheoryplan();
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    Getheoryplan();
                },
                async: false,
                error: function (er) {
                }
            });
        }

       

        function Getteachingtopicctrl(parentval, ctrl, val) {
            var json;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Getteachingtopic",
                data: "{'json' :'" + parentval + "'}",
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
                            text: ''
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
        function Getteachingtopicplanctrl(ctrl) {
            var json;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Getteachingtopicplan",
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
                            text: ''
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#' + ctrl).append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }


                        for (i = 0; i < res.length; i++) {
                            $('#' + ctrl).on('change', function () {
                                Getteachingtopicctrl($(this).val(), ctrl.replace("plan", "topic"));
                            })
                        }
                    }
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Getteachingtopicplan() {
            var json;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Getteachingtopicplan",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbteachingtopicplan').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbteachingtopicplan').append($('<option/>', {
                            value: '',
                            text: ''
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbteachingtopicplan').append($('<option/>', {
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
            if (ctrl == 'Gvteachingtopic') {
                $('#Divteachingtopics').modal('hide');
                $('#Divnewteachingtopic').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF3.aspx/Getteachingtopicinfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        Getteachingtopicplan();
                    },
                    success: function (response) {
                        res = response.d;
                        $('#Hdteachingtopicid').val(res['Val']);
                        $('#Cbteachingtopicplan').val(res['Extend1']);
                        $('#Txtteachingtopicdesc').val(res['Extend2']);
                        $('#Txtteachingtopicname').val(res['Name']);

                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            else if (ctrl == 'Gvteachingplan') {
                $('#Divteachingplans').modal('hide');
                $('#Divnewteachingplan').modal('show');
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF3.aspx/Getteachingplaninfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                    },
                    success: function (response) {
                        res = response.d;
                        $('#Hdteachingplanid').val(res['Val']);
                        $('#Txtteachingplanname').val(res['Name']);
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
        }
        function Closeteachingtopicmodal() {
            $('#Divteachingtopics').modal('show');
            Searchteachingtopic();
        }
        function Closeteachingplanmodal() {
            $('#Divteachingplans').modal('show');
            Searchteachingplan();
        }
        function Saveteachingtopic() {
            var html = '';
            var json = '';



            if ($('#Cbteachingtopicplan').val() == '') {
                Msgbox('โปรดระบุแผนการสอนก่อน');
                return;
            }
            if ($('#Txtteachingtopicname').val() == '') {
                Msgbox('โปรดระบุข้อมูลบทการสอนก่อน');
                return;
            }
            if ($('#Txtteachingtopicdesc').val() == '') {
                Msgbox('โปรดระบุรายละเอียดบทการสอนก่อน');
                return;
            }
            json = 'id :' + $('#Hdteachingtopicid').val() + '|';
            json += 'Txtteachingtopicname:' + $('#Txtteachingtopicname').val() + '|';
            json += 'Txtteachingtopicdesc:' + $('#Txtteachingtopicdesc').val() + '|';
            json += 'Cbteachingtopicplan:' + $('#Cbteachingtopicplan').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/doSaveteachingtopic",
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
                    $('#Divnewteachingtopic').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Closeteachingtopicmodal();
                },
                async: true,
                error: function (er) {

                }
            });
        }

        function Saveteachingplan() {
            var html = '';
            var json = '';

            if ($('#Txtteachingplanname').val() == '') {
                Msgbox('โปรดระบุข้อมูลแผนการสอนก่อน');
                return;
            }
            json = 'id :' + $('#Hdteachingplanid').val() + '|';
            json += 'Txtteachingplanname:' + $('#Txtteachingplanname').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/doSaveteachingplan",
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
                    $('#Divnewteachingplan').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    Closeteachingplanmodal();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Searchteachingplan() {

            ClearResource('TQF/TQF3.aspx', 'Gvteachingplan');
            var Columns = ["แผนการสอน!L"];
            var Data = ["Teachingplanname"];
            var Searchcolumns = ["แผนการสอน"];
            var SearchesDat = ["Teachingplanname"];
            var Width = ["80%"];
            var grdteachingplan = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvteachingplan', 1000, Width, Data, "", '', '1', 'สร้างแผนการสอนใหม่', '1', '1', '', '', '', 'id', '', '', 'id', '', '');

            $('#Divteachingplancont').html(grdteachingplan._Tables());
            grdteachingplan._Bind();

        }

        function Searchteachingtopic() {

            ClearResource('TQF/TQF3.aspx', 'Gvteachingtopic');
            var Columns = ["แผนการสอน!L", "บทการสอน!L"];
            var Data = ["Teachingplanname", "Teachingtopicname"];
            var Searchcolumns = ["แผนการสอน", "บทการสอน"];
            var SearchesDat = ["Teachingplanname", "Teachingtopicname"];
            var Width = ["40%", "40%"];
            var grdteachingtopic = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvteachingtopic', 1000, Width, Data, "", '', '1', 'สร้างบทการสอนใหม่', '1', '1', '', '', '', 'id', '', '', 'id', '', '');

            $('#Divteachingtopiccont').html(grdteachingtopic._Tables());
            grdteachingtopic._Bind();

        }
        function Newteachingtopic() {
            $('#Divteachingtopics').modal('show');
            Searchteachingtopic();
        }
        function Newteachingplan() {

            $('#Divteachingplans').modal('show');
            Searchteachingplan();
        }

        function Newestimateplan() {
            var html = '';
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Newestimateplan",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    Saveestimateplan();
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getestimateplan();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Newtheoryplan() {
            var html = '';
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Newtheoryplan",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    Savetheoryplan();
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getheoryplan();
                },
                async: true,
                error: function (er) {

                }
            });
        }

        function Getheoryplan() {
            var _html = '';
            var i, j = 0;
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Getheoryplan",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    if (response.d.length == 0) {
                        _html += "<tr>";
                        _html += "<td colspan='6'>";
                        _html += "<div style='text-align:center; height: 50px; margin - top: 25px; color: red; font - size: 15px; vertical - align: bottom; text - align : center;'>ไม่พบข้อมูล</div>";
                        _html += "</td>";
                        _html += "</tr>";
                        $('#Divtheoryplan').html(_html);
                    }
                    else {
                        for (i = 0; i < response.d.length; i++) {
                            _html += "<tr>";
                            _html += "<td >";
                            _html += "<table>";
                            _html += "<tr>";
                            _html += "<td>";
                            _html += "<span>สัปดาห์ที่</span>";
                            _html += "</td>";
                            _html += "</tr>";

                            _html += "<tr>";
                            _html += "<td>";
                            _html += "<input type='text' class='form-control' style='width:height:40px;text-align:right;' maxlength='2' id='Txttpweekno_" + response.d[i]['id'] + "' Value='" + response.d[i]['Weekno'] + "' />";
                            _html += "</td>";
                            _html += "</tr>";

                            _html += "<tr>";
                            _html += "<td>";
                            _html += "<span>วัน</span>";
                            _html += "</td>";
                            _html += "</tr>";

                            _html += "<tr>";
                            _html += "<td>";
                            //_html += "<div id='Dtptptrdate_" + response.d[i]['id'] + "' class='input-group date'  data-date-format='mm-dd-yyyy'>";
                            _html += "<input id='Txttptrdate_" + response.d[i]['id'] + "' class='form-control'  data-provide='datepicker' data-date-language='th-th' value=" + response.d[i]['Trdate'] + " />";
                            //_html += "<button>";
                            //_html += "<span class='input-group-addon'><i class='fa fa-calendar'></i></span>";
                            //_html += "</button>";
                            //_html += "</div>";
                            _html += "</td>";
                            _html += "</tr>";

                            _html += "<tr>";
                            _html += "<td >";
                            _html += "<span>ชั่วโมงทฤษฏีกับปฏิบัติ</span>";
                            _html += "</td>";
                            _html += "</tr>";

                            _html += "<tr>";
                            _html += "<td>";
                            _html += "<input type='text' class='form-control'  id='Txttptrtime_" + response.d[i]['id'] + "' Value = '" + response.d[i]['Trtime'] + "' /> ";
                            _html += "</td>";
                            _html += "</tr>";





                            _html += "</table>";




                            _html += "</td>";

                            _html += "<td style='width:20%;'>";
                            for (j = 0; j < response.d[i]['Theoryplanobjective'].length; j++) {
                                _html += '<div>';
                                if (response.d[i]['Theoryplanobjective'][j]['Selected'] != '') {
                                    _html += '<input type="checkbox" id="Chktpobjecttive_' + response.d[i]['id'] + '_' + response.d[i]['Theoryplanobjective'][j]['Objectiveid'] + '" onclick="Updatetheoryobjective(\'Chktpobjecttive_' + response.d[i]['id'] + '_' + response.d[i]['Theoryplanobjective'][j]['Objectiveid'] + '\');" checked />&nbsp;<span>' + response.d[i]['Theoryplanobjective'][j]['Objective'] + '</span>';
                                }
                                else {
                                    _html += '<input type="checkbox" id="Chktpobjecttive_' + response.d[i]['id'] + '_' + response.d[i]['Theoryplanobjective'][j]['Objectiveid'] + '" onclick="Updatetheoryobjective(\'Chktpobjecttive_' + response.d[i]['id'] + '_' + response.d[i]['Theoryplanobjective'][j]['Objectiveid'] + '\');"  />&nbsp;<span>' + response.d[i]['Theoryplanobjective'][j]['Objective'] + '</span>';
                                }
                                _html += '<div>';
                            }
                            _html += "</td>";
                            _html += "<td>";

                            _html += "<table style='width:100%;'>";
                            _html += "<tr>";
                            _html += "<td>";
                            _html += "<span>แผนการสอน</span>";
                            _html += "</td>";
                            _html += "</tr>";
                            _html += "<tr>";
                            _html += "<td>";
                            _html += "<input type='text' class='form-control' id='Txttpteachingplan_" + response.d[i]['id'] + "' value='" + response.d[i]['Teachingplanname'] + "'/>";
                            _html += "</td>";
                            _html += "</tr>";

                            _html += "<tr>";
                            _html += "<td>";
                            _html += "<span>บทที่</span>";
                            _html += "</td>";
                            _html += "</tr>";
                            _html += "<tr>";
                            _html += "<td>";
                            _html += "<input type='text'  class='form-control' id='Txttpteachingtopic_" + response.d[i]['id'] + "' value='" + response.d[i]['Teachingplantopicname'] + "'/>";
                            _html += "</td>";
                            _html += "</tr>";
                            _html += "</table>";

                            _html += "</td>";

                            _html += "<td>";
                            for (j = 0; j < response.d[i]['Theoryplannparticular'].length; j++) {
                                _html += '<div>';
                                if (response.d[i]['Theoryplannparticular'][j]['Selected'] != '') {
                                    _html += '<input type="checkbox" id="Chktpparticular_' + response.d[i]['id'] + '_' + response.d[i]['Theoryplannparticular'][j]['Particularid'] + '" onclick="Updatetheoryparticular(\'Chktpparticular_' + response.d[i]['id'] + '_' + response.d[i]['Theoryplannparticular'][j]['Particularid'] + '\');" checked />&nbsp;<span>' + response.d[i]['Theoryplannparticular'][j]['Particularname'] + '</span>';
                                }
                                else {
                                    _html += '<input type="checkbox" id="Chktpparticular_' + response.d[i]['id'] + '_' + response.d[i]['Theoryplannparticular'][j]['Particularid'] + '" onclick="Updatetheoryparticular(\'Chktpparticular_' + response.d[i]['id'] + '_' + response.d[i]['Theoryplannparticular'][j]['Particularid'] + '\');"  />&nbsp;<span>' + response.d[i]['Theoryplannparticular'][j]['Particularname'] + '</span>';
                                }
                                _html += '<div>';
                            }
                            _html += "</td>";

                            _html += "<td>";

                            for (j = 0; j < response.d[i]['Theoryplannestimate'].length; j++) {
                                _html += '<div>';
                                if (response.d[i]['Theoryplannestimate'][j]['Selected'] != '') {
                                    _html += '<input type="checkbox" id="Chktpestimate_' + response.d[i]['id'] + '_' + response.d[i]['Theoryplannestimate'][j]['Estimateid'] + '" onclick="Updatetheoryestimate(\'Chktpestimate_' + response.d[i]['id'] + '_' + response.d[i]['Theoryplannestimate'][j]['Estimateid'] + '\');" checked />&nbsp;<span>' + response.d[i]['Theoryplannestimate'][j]['Estimatename'] + '</span>';
                                }
                                else {
                                    _html += '<input type="checkbox" id="Chktpestimate_' + response.d[i]['id'] + '_' + response.d[i]['Theoryplannestimate'][j]['Estimateid'] + '" onclick="Updatetheoryestimate(\'Chktpestimate_' + response.d[i]['id'] + '_' + response.d[i]['Theoryplannestimate'][j]['Estimateid'] + '\');"  />&nbsp;<span>' + response.d[i]['Theoryplannestimate'][j]['Estimatename'] + '</span>';
                                }
                                _html += '<div>';
                            }
                            _html += "</td>";
                            _html += "<td>";

                            //_html += '<select class="form-control" id="Cbtpins_' + response.d[i]['id'] + '">';
                            //if (response.d[i]['Instructorid'] == '') {
                            //    _html += '<option value="" selected="selected">--ไม่ระบุ--</option>';
                            //}
                            //else {
                            //    _html += '<option value="">--ไม่ระบุ--</option>';
                            //}
                            //for (j = 0; j < response.d[i]['Instructors'].length; j++) {
                            //    if (response.d[i]['Instructors'][j]['Userid'] == response.d[i]['Instructorid']) {
                            //        _html += '<option value="' + response.d[i]['Instructors'][j]["Userid"] + '" selected="selected">' + response.d[i]['Instructors'][j]["Firstname"] + " " + response.d[i]['Instructors'][j]["Lastname"] + '</option>';
                            //    }
                            //    else {
                            //        _html += '<option value="' + + response.d[i]['Instructors'][j]["Userid"] + '">' + response.d[i]['Instructors'][j]["Firstname"] + " " + response.d[i]['Instructors'][j]["Lastname"] + '</option>';
                            //    }
                            //}
                            //_html += '</select>';

                            _html += "<table  class='table table-bordered' style='table-layout: fixed;width:100%;'>";


                            for (j = 0; j < response.d[i]['Instructors'].length; j++) {
                                _html += "<tr>";
                                _html += "<td style='width: 80%;'>";
                                _html += '<select class="form-control" id="Cbtpins_' + response.d[i]['id'] + '_' + response.d[i]['Instructors'][j]['Userid'] + '">';
                                for (k = 0; k < response.d[i]['TemplateInstructors'].length; k++) {
                                    _html += '<option value="' + response.d[i]['TemplateInstructors'][k]['Userid'] + '">' + response.d[i]['TemplateInstructors'][k]['Firstname'] + " " + response.d[i]['TemplateInstructors'][k]['Lastname'] + '</option>';
                                }
                                _html += '</select>';
                                _html += "</td>";
                                _html += "<td style='width: 20%;'>";
                                _html += '<button style=\'font-size:8px !important;margin:2px;\'  class=\'btn btn-danger\' onclick="DelInstructor(\'' + response.d[i]['Instructors'][j]['Userid'] + '\',' + response.d[i]['id'] + ');"><i class=\'fa fa-trash\' style=\'font-size:9px !important;\' aria-hidden=\'true\'></i></button>';
                                _html += "</td>";
                                _html += "</tr>";
                            }
                          
                            _html += "<tr>";

                            _html += "<td  style='width: 80%;'>";

                            _html += '<select id="Cbtpins_' + response.d[i]['id'] + '_0' + '" class="form-control">';
                            for (k = 0; k < response.d[i]['TemplateInstructors'].length; k++) {
                                _html += '<option value="' + response.d[i]['TemplateInstructors'][k]['Userid'] + '">' + response.d[i]['TemplateInstructors'][k]['Firstname'] + " " + response.d[i]['TemplateInstructors'][k]['Lastname'] + '</option>';
                            }
                            _html += '</select>';

                            _html += "</td>";
                            _html += "<td>";
                            _html += "</td>";
                            _html += "</tr>";
                           
                            _html += "</table>";

                        
                            _html += "</td>";
                            _html += "<td>";
                            _html += "<button onclick='Deltheoryplan(" + response.d[i]['id'] + ");' class='btn btn-danger' ><i class='fa fa-trash' aria-hidden='true'></i></button>";
                            _html += "</td>";


                            _html += "</tr>";
                        }
                        $('#Divtheoryplan').html(_html);

                        for (i = 0; i < response.d.length; i++) {
                            for (j = 0; j < response.d[i]['Instructors'].length; j++) {
                                $('#Cbtpins_' + response.d[i]['id'] + '_' + response.d[i]['Instructors'][j]['Userid']).selectpicker({
                                    liveSearch: true,
                                    maxOptions: 1
                                });


                                $('#Cbtpins_' + response.d[i]['id'] + '_' + response.d[i]['Instructors'][j]['Userid']).on('change', function () {
                                    json = '';
                                    json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                                    json += 'Theoryplan :' + $(this).attr('id') + '|';
                                    json += 'val :' + $(this).val() + '|';


                                    $.ajax({
                                        type: "POST",
                                        url: "\../Page/TQF/TQF3.aspx/Updatetheoryplaninstructor",
                                        data: "{'json'  : '" + json + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (response) {
                                            if (response.d != '') {
                                                Msgbox(response.d);
                                                Getheoryplan();
                                                return;
                                            }
                                            Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                                            Getheoryplan();
                                        },
                                        async: false,
                                        error: function (er) {

                                        }
                                    });



                                });

                                $('#Cbtpins_' + response.d[i]['id'] + '_' + response.d[i]['Instructors'][j]['Userid']).val(response.d[i]['Instructors'][j]['Userid']).selectpicker('refresh');

                            }
                            $('#Cbtpins_' + response.d[i]['id'] + '_0').selectpicker({
                                liveSearch: true,
                                maxOptions: 1
                            });
                            $('#Cbtpins_' + response.d[i]['id'] + '_0').val('').selectpicker('refresh');
                            $('#Cbtpins_' + response.d[i]['id'] + '_0').on('change', function () {
                                json = '';
                                json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                                json += 'Theoryplan :' + $(this).attr('id') + '|';
                                json += 'val :' + $(this).val() + '|';
                                

                                $.ajax({
                                        type: "POST",
                                        url: "\../Page/TQF/TQF3.aspx/Updatetheoryplaninstructor",
                                        data: "{'json'  : '" + json + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (response) {
                                            if (response.d != '') {
                                                Msgbox(response.d);
                                                Getheoryplan();
                                                return;
                                            }
                                            Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                                            Getheoryplan();
                                        },
                                        async: false,
                                        error: function (er) {

                                        }
                                    });
                            });


                        }



                        //for (i = 0; i < response.d.length; i++) {

                        //    $("#Dtptptrdate_" + response.d[i]['id']).datepicker({
                        //        format: "dd/mm/yyyy",
                        //        todayBtn: "linked",
                        //        language: "th",
                        //        forceParse: false,
                        //        autoclose: true,
                        //        todayHighlight: true
                        //    });

                        //    //Getteachingtopicplanctrl('Cbtpteachingplan_' + response.d[i]['id']);
                        //    //if (response.d[i]['Theoryplanntopic'].length != 0) {
                        //    //    $('#Cbtpteachingplan_' + response.d[i]['id']).val(response.d[i]['Theoryplanntopic'][0]['Teachingplanid']);
                        //    //    Getteachingtopicctrl(response.d[i]['Theoryplanntopic'][0]['Teachingplanid'], 'Cbtpteachingtopic_' + response.d[i]['id'], response.d[i]['Theoryplanntopic'][0]['Teachingtopicid']);
                        //    //    $('#Cbtpteachingtopic_' + response.d[i]['id']).val(response.d[i]['Theoryplanntopic'][0]['Teachingtopicid']);

                        //    //}
                        //    //else {
                        //    //    Getteachingtopicctrl("", 'Cbtpteachingtopic_' + response.d[i]['id'], "");
                        //    //}


                        //}
                    }




                },
                async: false,
                error: function (er) {

                }
            });


        }
        function Deleteconfidentdocument(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divconfidentdocument').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updateconfidentdocument",
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
                        url: "\../Page/TQF/TQF3.aspx/Deleteconfidentdocument",
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
                            Getconfidentdocument();
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
        function Newconfidentdocument() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divconfidentdocument').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });


            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updateconfidentdocument",
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
                        url: "\../Page/TQF/TQF3.aspx/Newconfidentdocument",
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
                            Getconfidentdocument();
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
        function Getconfidentdocument() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Getconfidentdocument",
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
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            //html += '<td>';
                            //html += 'เอกสารและข้อมูลสำคัญ';
                            //html += '</td>';
                            html += '<td style="width:90%;">';
                            html += '<textarea id="Txtconf_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Confidentdocument'] + '</textarea>';
                            html += '</td>';
                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deleteconfidentdocument(' + res[i]['id'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="3" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divconfidentdocument').html(html);
                },
                async: true,
                error: function (er) {

                }
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
            else if (ctrl == 'Gvother') {
                Bindother();
            }
            else if (ctrl == 'Gvebook') {

                Bindebook();
            }
            else if (ctrl == 'Gvtextbook') {

                Bindtextbook();
            }
            else if (ctrl == 'Gvrecommenddocument') {
                Bindrecommenddocument();
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
                url: "TQF/TQF3.aspx/Selectedtextbook",
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
                url: "TQF/TQF3.aspx/Selectedebook",
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
                url: "TQF/TQF3.aspx/Selectedinquiry",
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
                url: "TQF/TQF3.aspx/Selectedjournal",
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
        function Selectedrecommenddocument(x) {
            var json = '';
            json += 'x :' + x + '|';
            json += 'TQFId :' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "TQF/TQF3.aspx/Selectedrecommenddocument",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    res = response.d;
                    if (res != '') {
                        Msgbox(res);
                        return;
                    }
                    Bindrecommenddocument();
                    $('#Divmodalrecommenddocument').modal('hide');
                },
                async: true,
                error: function (er) {

                }
            });
        }

        function Selectedother(x) {
            var json = '';
            json += 'x :' + x + '|';
            json += 'TQFId :' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "TQF/TQF3.aspx/Selectedother",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    res = response.d;
                    if (res != '') {
                        Msgbox(res);
                        return;
                    }
                    Bindother();
                    $('#Divmodalother').modal('hide');
                },
                async: true,
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
            var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchtextbook', 1000, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divtextbookcont').html(Gv._Tables());
            Gv._Bind();
            $('#Divmodaltextbook').modal('show');
        }
        //function Newebook() {
        //    ClearResource('TQF/TQF3.aspx', 'Gvsearchebook');
        //    var Cri = $('#HdTQFId').val();
        //    var Columns = ["E-Book!L"];
        //    var Data = ["Ebook"];
        //    var Searchcolumns = ["E-Book"];
        //    var SearchesDat = ["Ebook"];
        //    var Width = ["100%"];
        //    var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchebook', 1000, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
        //    $('#Divebookcont').html(Gv._Tables());
        //    Gv._Bind();
        //    $('#Divmodalebook').modal('show');
        //}
        //function Newinquiry() {
        //    ClearResource('TQF/TQF3.aspx', 'Gvsearchinquiry');
        //    var Cri = $('#HdTQFId').val();
        //    var Columns = ["ระบบสืบค้น!L"];
        //    var Data = ["Inquiry"];
        //    var Searchcolumns = ["ระบบสืบค้น"];
        //    var SearchesDat = ["Inquiry"];
        //    var Width = ["100%"];
        //    var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchinquiry', 1000, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
        //    $('#Divinquirycont').html(Gv._Tables());
        //    Gv._Bind();
        //    $('#Divmodalinquiry').modal('show');
        //}
        //function Newjournal() {
        //    ClearResource('TQF/TQF3.aspx', 'Gvsearchjournal');
        //    var Cri = $('#HdTQFId').val();
        //    var Columns = ["วารสารวิชาการ!L"];
        //    var Data = ["Journal"];
        //    var Searchcolumns = ["วารสารวิชาการ"];
        //    var SearchesDat = ["Journal"];
        //    var Width = ["100%"];
        //    var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchjournal', 1000, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
        //    $('#Divjournalcont').html(Gv._Tables());
        //    Gv._Bind();
        //    $('#Divmodaljournal').modal('show');
        //}
        //function Newother() {
        //    ClearResource('TQF/TQF3.aspx', 'Gvsearchother');
        //    var Cri = $('#HdTQFId').val();
        //    var Columns = ["สื่อการสอนอื่นๆ!L"];
        //    var Data = ["Otherdocument"];
        //    var Searchcolumns = ["สื่อการสอนอื่นๆ"];
        //    var SearchesDat = ["Otherdocument"];
        //    var Width = ["100%"];
        //    var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchother', 1000, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
        //    $('#Divothercont').html(Gv._Tables());
        //    Gv._Bind();
        //    $('#Divmodalother').modal('show');
        //}
        //function Newrecommenddocument() {
        //    ClearResource('TQF/TQF3.aspx', 'Gvsearchrecommenddocument');
        //    var Cri = $('#HdTQFId').val();
        //    var Columns = ["ตำรารอง / เอกสารเพิ่มเติม!L"];
        //    var Data = ["Recommenddocument"];
        //    var Searchcolumns = ["ตำรารอง / เอกสารเพิ่มเติม"];
        //    var SearchesDat = ["Recommenddocument"];
        //    var Width = ["100%"];
        //    var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchrecommenddocument', 1000, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
        //    $('#Divrecommenddocumentcont').html(Gv._Tables());
        //    Gv._Bind();
        //    $('#Divmodalrecommenddocument').modal('show');
        //}
        function Bindnewobjective() {

            ClearResource('TQF/TQF3.aspx', 'Gvnewobjective');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วัตถุประสงค์!L"];
            var Data = ["Objective"];
            var Searchcolumns = ["วัตถุประสงค์!L"];
            var SearchesDat = ["Objective"];
            var Width = ["100%"];
            var Gvnewobjective = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvnewobjective', 1000, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', 'id', 'id', Cri, '');
            $('#Divmodalobjectivecont').html(Gvnewobjective._Tables());
            Gvnewobjective._Bind();
        }
        function Bindother() {
            ClearResource('TQF/TQF3.aspx', 'Gvother');
            var Cri = $('#HdTQFId').val();
            var Columns = ["สื่อการสอนอื่นๆ!L"];
            var Data = ["Otherdocument"];
            var Searchcolumns = ["สื่อการสอนอื่นๆ"];
            var SearchesDat = ["Otherdocument"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvother', 1000, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divother').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindebook() {
            ClearResource('TQF/TQF3.aspx', 'Gvebook');
            var Cri = $('#HdTQFId').val();
            var Columns = ["E-Book!L"];
            var Data = ["Ebook"];
            var Searchcolumns = ["E-Book"];
            var SearchesDat = ["Ebook"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvebook', 1000, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divebook').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindinquiry() {

            ClearResource('TQF/TQF3.aspx', 'Gvinquiry');
            var Cri = $('#HdTQFId').val();
            var Columns = ["ระบบสืบค้น!L"];
            var Data = ["Inquiry"];
            var Searchcolumns = ["ระบบสืบค้น"];
            var SearchesDat = ["Inquiry"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvinquiry', 1000, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divinquiry').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindjournal() {

            ClearResource('TQF/TQF3.aspx', 'Gvjournal');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วารสารวิชาการ!L"];
            var Data = ["Journal"];
            var Searchcolumns = ["วารสารวิชาการ"];
            var SearchesDat = ["Journal"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvjournal', 1000, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divjournal').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindrecommenddocument() {

            ClearResource('TQF/TQF3.aspx', 'Gvrecommenddocument');
            var Cri = $('#HdTQFId').val();
            var Columns = ["ตำรารอง / เอกสารเพิ่มเติม!L"];
            var Data = ["Recommenddocument"];
            var Searchcolumns = ["ตำรารอง / เอกสารเพิ่มเติม"];
            var SearchesDat = ["Recommenddocument"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvrecommenddocument', 1000, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divrecommenddocument').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindtextbook() {

            ClearResource('TQF/TQF3.aspx', 'Gvtextbook');
            var Cri = $('#HdTQFId').val();
            var Columns = ["Textbook!L"];
            var Data = ["Textbook"];
            var Searchcolumns = ["Textbook!L"];
            var SearchesDat = ["Textbook"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvtextbook', 1000, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divtextbook').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindnewobjective() {

            ClearResource('TQF/TQF3.aspx', 'Gvnewobjective');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วัตถุประสงค์!L"];
            var Data = ["Objective"];
            var Searchcolumns = ["วัตถุประสงค์!L"];
            var SearchesDat = ["Objective"];
            var Width = ["100%"];
            var Gvnewobjective = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvnewobjective', 1000, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', 'id', 'id', Cri, '');
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
                url: "\../Page/TQF/TQF3.aspx/Updatetqfestimate",
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
        function Updatetqfparticular(ctrl) {
            var json = '';


            json += 'ctrl:' + ctrl + '|';

            json += 'val:' + $('#' + ctrl).prop("checked") + '|';
            json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updatetqfparticular",
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
        function Getlearningoutput() {
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
                url: "\../Page/TQF/TQF3.aspx/Getlearningoutput",
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
                    html += '<td style="width:40%;">ผลการเรียนรู้';
                    html += '</td>';
                    html += '<td style="width:30%;"><span>เทคนิค / วิธีการสอน</span>&nbsp;&nbsp;&nbsp;&nbsp;<button style="font-size:9px !important;" class="btn btn-success" onclick="AddPar();"><i class="fa fa-plus" style="font-size:9px !important;" aria-hidden="true"></i></button>' ;
                    html += '</td>';
                    html += '<td style="width:30%;"><span>วิธีการประเมินผล</span>&nbsp;&nbsp;&nbsp;&nbsp;<button style="font-size:9px !important;" class="btn btn-success" onclick="AddEst();"><i class="fa fa-plus" style="font-size:9px !important;" aria-hidden="true"></i></button>';
                    //html += '</td>';
                    //html += '<td>&nbsp;';
                    //html += '</td>';
                    html += '</tr>';




                   html += '<tr>';


                    html += '<td style="width:30%;">';
                    html += "<table  class='table table-bordered' style='table-layout: fixed;width:100%;'>";


                    for (j = 0; j < response.d['Lens'].length; j++) {
                        html += "<tr>";
                        html += "<td style='width: 100%;'>";
                        html += "<span>" + response.d['Lens'][j]["Learningoutputname"] + "</span>";
                        
                        html += "</td>";
                        html += "</tr>";
                    }
                    html += "<tr>";
                 
                   
                    html += "</tr>";
                    html += "</table>";
                    html += '</td>';                   


                    html += '<td style="width:30%;">';
                    html += "<table  class='table table-bordered' style='table-layout: fixed;width:100%;'>";


                        for (j = 0; j < response.d['Particulars'].length; j++) {
                            html += "<tr>";
                            html += "<td style='width: 80%;'>";

                            html += '<select id="Cbparticulars_' + response.d['Particulars'][j]['Particularid'] + '" class="form-control">';

                            for (k = 0; k < response.d['MasterParticulars'].length; k++) {
                                html += '<option value="' + response.d['MasterParticulars'][k]['Particularid'] + '">' + response.d['MasterParticulars'][k]['Particularname'] + '</option>';
                            }
                            html += '</select>';
                            html += "</td>";
                            html += "<td style='width: 20%;'>";
                            //html += "<button style='font-size:9px !important;'  class='btn btn-success' onclick='AddPar();'><i class='fa fa-plus' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                            html += "<button style='font-size:9px !important;'  class='btn btn-danger' onclick='DelPar(" + response.d['Particulars'][j]['Learningparticularid'] + ',' + response.d['Particulars'][j]['Particularid'] + ");'><i class='fa fa-trash' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                            html += "</td>";
                            html += "</tr>";
                        }
                        html += "<tr>";
                        html += "<td >";

                        html += '<select id="Cbparticulars_0' + '" class="form-control">';
                        for (k = 0; k < response.d['MasterParticulars'].length; k++) {
                            html += '<option value="' + response.d['MasterParticulars'][k]['Particularid'] + '">' + response.d['MasterParticulars'][k]['Particularname'] + '</option>';
                        }
                        html += '</select>';

                        html += "</td>";
                        html += "<td>";
                        //html += "<button style='font-size:9px !important;'  class='btn btn-success' onclick='AddPar();'><i class='fa fa-plus' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                        html += "</td>";
                        html += "</tr>";
                        html += "</table>";
                        html += '</td>';





                        html += '<td style="width:30%;">';
                        html += "<table  class='table table-bordered' style='table-layout: fixed;width:100%;'>";

                        for (j = 0; j < response.d['Estimates'].length; j++) {
                            html += "<tr>";
                            html += "<td style='width:80%;'>";

                            html += '<select id="Cbestimates_' + response.d['Estimates'][j]['Estimateid'] + '" class="form-control" >';

                            for (k = 0; k < response.d['MasterEstimates'].length; k++) {
                                html += '<option value="' + response.d['MasterEstimates'][k]['Estimateid'] + '">' + response.d['MasterEstimates'][k]['Estimatename'] + '</option>';
                            }
                            html += '</select>';
                            html += "</td>";
                            html += "<td>";
                            //html += "<button style='font-size:9px !important;'  class='btn btn-success' onclick='AddEst();'><i class='fa fa-plus' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                            html += "<button style='font-size:9px !important;'  class='btn btn-danger' onclick='DelEst(" + response.d['Estimates'][j]['Learningestimateid']  + ',' + response.d['Estimates'][j]['Estimateid'] + ");'><i class='fa fa-trash' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                            html += "</td>";
                            html += "</tr>";
                        }
                        html += "<tr>";
                        html += "<td>";

                        html += '<select id="Cbestimates_0' + '" class="form-control">';
                        for (k = 0; k < response.d['MasterEstimates'].length; k++) {
                            html += '<option value="' + response.d['MasterEstimates'][k]['Estimateid'] + '">' + response.d['MasterEstimates'][k]['Estimatename'] + '</option>';
                        }
                        html += '</select>';

                        html += "</td>";
                        html += "<td>";
                        //html += "<button style='font-size:9px !important;'  class='btn btn-success' onclick='AddEst();'><i class='fa fa-plus' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                        html += "</td>";
                        html += "</tr>";
                        html += "</table>";
                        html += '</td>';








                    




                    html += '</table>';
                    html += '</div>';
                    html += '</div>';

                    $('#Divestimateoutput').html(html);

                  
                        for (j = 0; j < response.d['Particulars'].length; j++) {
                            $('#Cbparticulars_' + response.d['Particulars'][j]['Particularid']).selectpicker({
                                liveSearch: true,
                                maxOptions: 1
                            });


                            $('#Cbparticulars_' + response.d['Particulars'][j]['Particularid']).on('change', function () {
                                json = '';
                                json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                                json += 'Learningparticularid :' + $(this).attr('id') + '|';
                                json += 'val :' + $(this).val() + '|';
                                $.ajax({
                                    type: "POST",
                                    url: "\../Page/TQF/TQF3.aspx/Updateparticular",
                                    data: "{'json'  : '" + json + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        if (response.d != '') {
                                            Msgbox(response.d);
                                            
                                        }
                                        Getlearningoutput();
                                    },
                                    async: false,
                                    error: function (er) {

                                    }
                                });



                            });

                            $('#Cbparticulars_' + response.d['Particulars'][j]['Particularid']).val(response.d['Particulars'][j]['Particularid']).selectpicker('refresh');

                        }
                        $('#Cbparticulars_0').selectpicker({
                            liveSearch: true,
                            maxOptions: 1
                        });
                        $('#Cbparticulars_0').val('').selectpicker('refresh');
                        $('#Cbparticulars_0').on('change', function () {
                            json = '';
                            json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                            json += 'Learningparticularid :' + $(this).attr('id') + '|';
                            json += 'val :' + $(this).val() + '|';
                            $.ajax({
                                type: "POST",
                                url: "\../Page/TQF/TQF3.aspx/Updateparticular",
                                data: "{'json'  : '" + json + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (response) {
                                    if (response.d != '') {
                                        Msgbox(response.d);
                                        
                                    }
                                    Getlearningoutput();
                                },
                                async: false,
                                error: function (er) {

                                }
                            });



                        });


                    




                 
                        for (j = 0; j < response.d['Estimates'].length; j++) {
                            $('#Cbestimates_' + response.d['Estimates'][j]['Estimateid']).selectpicker({
                                liveSearch: true,
                                maxOptions: 1
                            });


                            $('#Cbestimates_' + response.d['Estimates'][j]['Estimateid']).on('change', function () {
                                json = '';
                                json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                                json += 'Learningestimateid :' + $(this).attr('id') + '|';
                                json += 'val :' + $(this).val() + '|';
                                $.ajax({
                                    type: "POST",
                                    url: "\../Page/TQF/TQF3.aspx/Updateestimate",
                                    data: "{'json'  : '" + json + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        if (response.d != '') {
                                            Msgbox(response.d);
                                            
                                        }
                                        Getlearningoutput();
                                    },
                                    async: false,
                                    error: function (er) {

                                    }
                                });



                            });

                            $('#Cbestimates_' + response.d['Estimates'][j]['Estimateid']).val(response.d['Estimates'][j]['Estimateid']).selectpicker('refresh');

                        }
                        $('#Cbestimates_0').selectpicker({
                            liveSearch: true,
                            maxOptions: 1
                        });
                        $('#Cbestimate_0').val('').selectpicker('refresh');
                        $('#Cbestimates_0').on('change', function () {
                            json = '';
                            json += 'HdTQFId :' + $('#HdTQFId').val() + '|';
                            json += 'Learningestimateid :' + $(this).attr('id') + '|';
                            json += 'val :' + $(this).val() + '|';
                            $.ajax({
                                type: "POST",
                                url: "\../Page/TQF/TQF3.aspx/Updateestimate",
                                data: "{'json'  : '" + json + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (response) {
                                    if (response.d != '') {
                                        Msgbox(response.d);
                                       
                                    }
                                    Getlearningoutput();
                                },
                                async: false,
                                error: function (er) {

                                }
                            });



                        });


                   

                },
                async: false,
                error: function (er) {

                }
            });

        }
        function Changetotalhour() {
            $('#Txttheoryhour').val(Number($('#Cbtotalhour').val()) * 2);
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
                    url: "\../Page/TQF/TQF3.aspx/Addnewobjective",
                    data: "{'json'  : '" + json + "'}",
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

            ClearResource('TQF/TQF3.aspx', 'Gvnewobjective');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วัตถุประสงค์!L"];
            var Data = ["Objective"];
            var Searchcolumns = ["วัตถุประสงค์!L"];
            var SearchesDat = ["Objective"];
            var Width = ["100%"];
            var Gvnewobjective = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvnewobjective', 1000, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', 'id', 'id', Cri, '');
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
                url: "\../Page/TQF/TQF3.aspx/Getoutcome",
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
                            html += '<textarea class="form-control" onblur="Updateoutcome();" id="Txtoutcome_' + res[i]['TQFoutcomeId'] + '" >' + res[i]['Value'] + '</textarea>';
                            html += '</td>';


                            html += '<td>';
                            html += '<button onclick="Deleteoutcome(' + res[i]['TQFoutcomeId'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';

                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    html += '</table>';
                    $('#Divoutcome').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }


        function Updateadvice() {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divadvice').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updateadvice",
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
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                },
                async: true,
                error: function (er) {

                }
            });
        }

        function Deleteadvice(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divadvice').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updateadvice",
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
                        url: "\../Page/TQF/TQF3.aspx/Deleteadvice",
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
                            Getadvice();
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
        function Deleteoutcome(x) {
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Deleteoutcome",
                data: "{'json' :'" + x + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    Updateoutcome();
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res != "") {
                        Msgbox(res);
                        return;
                    }
                    Getoutcome();
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
                url: "\../Page/TQF/TQF3.aspx/Updatedevelopobjective",
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
                        url: "\../Page/TQF/TQF3.aspx/Deletedevelopobjective",
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

        function Newadvice() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divadvice').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });


            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updateadvice",
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
                        url: "\../Page/TQF/TQF3.aspx/Newadvice",
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
                            Getadvice();
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
        function Newoutcome() {
            var json = $('#HdTQFId').val();
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Newoutcome",
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
                    Getoutcome();
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
                url: "\../Page/TQF/TQF3.aspx/Updatedevelopobjective",
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
                        url: "\../Page/TQF/TQF3.aspx/Newdevelopobjective",
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
        function Getadvice() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Getadvice",
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
                    html += '<td>ชื่อ – สกุล อาจารย์';
                    html += '</td>';
                    html += '<td>สถานที่';
                    html += '</td>';
                    html += '<td>E-mail address/โทรศัพท์';
                    html += '</td>';
                    html += '<td>วัน และ เวลาในการให้คำปรึกษา';
                    html += '</td>';
                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<textarea id="TxtadviceF_' + res[i]['Id'] + '"  class="form-control" style="height: 80px;">' + res[i]['Fullname'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtadviceP_' + res[i]['Id'] + '" class="form-control" style="height: 80px;">' + res[i]['Adviceplace'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtadviceE_' + res[i]['Id'] + '" class="form-control" style="height: 80px;">' + res[i]['AdviceEmail'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtadviceD_' + res[i]['Id'] + '" class="form-control" style="height: 80px;">' + res[i]['Advicedateandtime'] + '</textarea>';
                            html += '</td>';
                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deleteadvice(' + res[i]['Id'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>'
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="4" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'

                    $('#Divadvice').html(html);
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
                url: "\../Page/TQF/TQF3.aspx/Getdevelopobjective",
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
                        html += '<tr><td colspan="5" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
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
                url: "\../Page/TQF/TQF3.aspx/Getobjective",
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
                var json = $('#HdTQFId').val();
                var dat = '';
                $('#Divconfidentdocument').find('textarea').each(function () {
                    dat += $(this).attr('id') + ':' + $(this).val() + '|';
                });
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF3.aspx/Updateconfidentdocument",
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
                        Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');

                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            else {
                if (menu == "7") {
                    json += 'menu:' + menu + '|';
                    json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                    json += 'Txtstategybystudent:' + $('#Txtstategybystudent').val() + '|';
                    json += 'Txtstategybyteaching:' + $('#Txtstategybyteaching').val() + '|';
                    json += 'Txtimproveteaching:' + $('#Txtimproveteaching').val() + '|';
                    json += 'Txtreestimate:' + $('#Txtreestimate').val() + '|';
                    json += 'Txtplanningimprove:' + $('#Txtplanningimprove').val() + '|';
                    json += 'Txtstategyother:' + $('#Txtstategyother').val() + '|';

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
                }
                else if (menu == "2") {
                    var dat = '';
                    $('#Divdevelopobjective').find('textarea').each(function () {
                        dat += $(this).attr('id') + ':' + $(this).val() + '|';
                    });
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF3.aspx/Updatedevelopobjective",
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
                        },
                        async: false,
                        error: function (er) {

                        }
                    });

                }
                else if (menu == "3") {

                    var dat = '';
                    $('#Divadvice').find('textarea').each(function () {
                        dat += $(this).attr('id') + ':' + $(this).val() + '|';
                    });
                    $.ajax({
                        type: "POST",
                        url: "\../Page/TQF/TQF3.aspx/Updateadvice",
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
                            json += 'Txttotalhour:' + $('#Cbtotalhour').val() + '|';
                            json += 'Txttheoryhour:' + $('#Txttheoryhour').val() + '|';
                            json += 'Txtaddtionaltech:' + $('#Txtaddtionaltech').val() + '|';
                            json += 'Txtpracticalhour:' + $('#Txtpracticalhour').val() + '|';
                            json += 'Txtresearchhour:' + $('#Txtresearchhour').val() + '|';
                        },
                        async: false,
                        error: function (er) {

                        }
                    });


                }
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF3.aspx/Save",
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

        }
        function Deleteobjective(TQFObjectiveid) {
            var json = '';
            json += TQFObjectiveid;

            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Deleteobjective",
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
        function Updateoutcome() {

            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divoutcome').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Updateoutcome",
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
                    Getoutcome();
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
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
                url: "\../Page/TQF/TQF3.aspx/Updateobjectiveremark",
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
                url: "\../Page/TQF/TQF3.aspx/Updatetext",
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
            ClearResource('TQF/TQF3.aspx', 'Gvsearchinstuctor');
            var Cri = x + '|' + $('#HdTQFId').val();
            var Columns = ["ชื่อ!L", "นามสกุล!L", "คุณวุฒิ!L"];
            var Data = ["firstname", "lastname", "Educationbackground"];
            var Searchcolumns = ["ชื่อ", "นามสกุล", "คุณวุฒิ"];
            var SearchesDat = ["firstname", "lastname", "Educationbackground"];
            var Width = ["20%", "20%", "60%"];
            var Gvsearchinstuctor = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchinstuctor', 1000, Width, Data, "", '', '2', '', '', '', '', '', '', 'm.Userid', 'm.Userid', '', 'm.Userid', Cri, '');
            $('#Divinstuctorcont').html(Gvsearchinstuctor._Tables());
            Gvsearchinstuctor._Bind();
        }

        function Custom(Ctrl, Panel) {

            if (Ctrl == 'Gvteachingtopic') {

                Getteachingtopicplan();
                $('#Txtteachingtopicdesc').val('');
                $('#Txtteachingtopicname').val('');
                $('#Hdteachingtopicid').val('');
                $('#Divteachingtopics').modal('hide');
                $('#Divnewteachingtopic').modal('show');
            }
            else if (Ctrl == 'Gvteachingplan') {

                $('#Txtteachingplanname').val('');
                $('#Hdteachingplanid').val('');
                $('#Divteachingplans').modal('hide');
                $('#Divnewteachingplan').modal('show');
            }
            else if (Ctrl == 'GvresponsibleInstructor') {
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
                url: "\../Page/TQF/TQF3.aspx/Getnewsubject",
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
                url: "\../Page/TQF/TQF3.aspx/Getnewyear",
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
                url: "\../Page/TQF/TQF3.aspx/Getnewclass",
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
                url: "\../Page/TQF/TQF3.aspx/Getnewterm",
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
                url: "\../Page/TQF/TQF3.aspx/Getcourse",
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
                url: "\../Page/TQF/TQF3.aspx/Getnewcollege",
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

            ClearResource('TQF/TQF3.aspx', 'GvregisterStudent');
            var Columns = ["รหัสนักศึกษา!L", "ชื่อ!L", "นามสกุล!L", "วันที่ลงทะเบียน!C"];
            var Data = ["Studentno", "Firstname", "Lastname", "Registerdate"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วิชา"];
            var SearchesDat = ["Studentno", "Firstname", "Lastname"];
            var Width = ["20%", "30%", "30%", "20%"];
            var GvregisterStudent = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'GvregisterStudent', 1000, Width, Data, "", '', '', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divregistationsubject').html(GvregisterStudent._Tables());
            GvregisterStudent._Bind();
        }
        function BindresponsibleInstructor() {
            var Cri = $('#HdTQFId').val();
            ClearResource('TQF/TQF3.aspx', 'GvresponsibleInstructor');
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!C", "ประสบการณ์การสอนในสาขาที่เกี่ยวข้อง (จำนวนปี)!C"];
            var Data = ["Firstname", "Lastname", "Educationalbackground", "Exp"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "Educationalbackground"];
            var Width = ["20%", "20%", "20%", "40%"];
            var GvresponsibleInstructor = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'GvresponsibleInstructor', 1000, Width, Data, "", '', '', 'เพิ่มอาจารย์ผู้รับผิดชอบรายวิชา', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#DivresponsibleInstructor').html(GvresponsibleInstructor._Tables());
            GvresponsibleInstructor._Bind();
        }
        function BindtheoryInstructor() {
            var Cri = $('#HdTQFId').val();
            ClearResource('TQF/TQF3.aspx', 'GvtheoryInstructor');
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!C", "ประสบการณ์การสอนในสาขาที่เกี่ยวข้อง (จำนวนปี)!C"];
            var Data = ["Firstname", "Lastname", "Educationalbackground", "Exp"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "Educationalbackground"];
            var Width = ["20%", "20%", "20%", "40%"];
            var GvtheoryInstructor = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'GvtheoryInstructor', 1000, Width, Data, "", '', '', 'เพิ่มอาจารย์ภาคทฤษฎี', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#DivtheoryInstructor').html(GvtheoryInstructor._Tables());
            GvtheoryInstructor._Bind();
        }
        function BindextraInstructor() {

            var Cri = $('#HdTQFId').val();
            ClearResource('TQF/TQF3.aspx', 'GvextraInstructor');
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!C", "ประสบการณ์การสอนในสาขาที่เกี่ยวข้อง (จำนวนปี)!C"];
            var Data = ["Firstname", "Lastname", "Educationalbackground", "Exp"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "Educationalbackground"];
            var Width = ["20%", "20%", "20%", "40%"];
            var GvextraInstructor = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'GvextraInstructor', 1000, Width, Data, "", '', '', 'เพิ่มอาจารย์สอนภาคปฏิบัติ', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#DivextraInstructor').html(GvextraInstructor._Tables());
            GvextraInstructor._Bind();
        }
        function BindpreInstructor() {

            var Cri = $('#HdTQFId').val();
            ClearResource('TQF/TQF3.aspx', 'GvpreInstructor');
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!C", "ประสบการณ์การสอนในสาขาที่เกี่ยวข้อง (จำนวนปี)!C"];
            var Data = ["Firstname", "Lastname", "Educationalbackground", "Exp"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "Educationalbackground"];
            var Width = ["20%", "20%", "20%", "40%"];
            var GvpreInstructor = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'GvpreInstructor', 1000, Width, Data, "", '', '', 'เพิ่มอาจารย์พิเศษ', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#DivpreInstructor').html(GvpreInstructor._Tables());
            GvpreInstructor._Bind();
        }
        function LoadTQFInfo(id) {
            var json = id;
            $.ajax({
                type: "POST",
                url: "TQF/TQF3.aspx/LoadTQFInfo",
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
                    $('#TxtsubjectnameEN').val(res['SubjectnameEN']);
                    $('#Txtcredits').val(res['Credits']);
                    $('#Txtsubjectdesc').val(res['SubjectDesc']);
                    $('#Cbsubjectgroup').val(res['Subjectgroup']);
                    $('#TxtsubjectdescEN').val(res['SubjectDescEN']);

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

                    if (res['Totalhour'] != '') {
                        $('#Cbtotalhour').val(res['Totalhour']);
                        $('#Txttheoryhour').val(res['Theoryhour']);
                    }
                    else {
                        $('#Txttheoryhour').val('');

                    }
                    $('#Txtaddtionaltech').val(res['Addtionaltech']);
                    $('#Txtpracticalhour').val(res['Practicalhour']);
                    $('#Txtresearchhour').val(res['Researchhour']);

                    $('#Txtstategybystudent').val(res['Stategybystudent']);
                    $('#Txtstategybyteaching').val(res['Stategybyteaching']);
                    $('#Txtimproveteaching').val(res['Improveteaching']);
                    $('#Txtreestimate').val(res['Reestimate']);
                    $('#Txtplanningimprove').val(res['Planningimprove']);
                    $('#Txtstategyother').val(res['Stategyother']);



                    BindresponsibleInstructor();
                    BindtheoryInstructor();
                    BindextraInstructor();
                    BindpreInstructor();
                    BindregisterStudent();
                    Getobjective();
                    Getoutcome();
                    Getdevelopobjective();
                    Getadvice();
                    //tab3
                    Getlearningoutput();

                    //Tab4
                    Bindtextbook();
                    //Bindrecommenddocument();
                    //Bindjournal();
                    //Bindinquiry();
                    //Bindebook();
                    //Bindother();


                    Getrecommenddocument();
                    Getjournal();
                    Getinquiry();
                    Getebook();
                    Getother();


                    Getconfidentdocument();


                    //Tab5
                    Getheoryplan();
                    Getestimateplan();

                    Getteachingplandetail();
                    Costdetail();
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
                url: "TQF/TQF3.aspx/DonewTQF",
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
                url: "TQF/TQF3.aspx/Selectedinstuctor",
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
            var json = '';

            if (ctrl == 'Gvlearningoutput') {
                $('#Divlearningoutput').modal('hide');
                json = 'TQFId :' + $('#HdTQFId').val() + '|';
                json += 'LearningSetId :' + $('#Hdlearningsetid').val() + '|';
                json += 'Learningoutputid :' + x + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF3.aspx/SelLen",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        Getlearningoutput();
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            else if (ctrl == 'Gvparticular') {
                $('#Divlearningoutput').modal('hide');
                json = 'TQFId :' + $('#HdTQFId').val() + '|';
                json += 'LearningSetId :' + $('#Hdlearningsetid').val() + '|';
                json += 'Particularid :' + x + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF3.aspx/SelPar",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        Getlearningoutput();
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            else if (ctrl == 'Gvestimate') {
                $('#Divlearningoutput').modal('hide');
                json = 'TQFId :' + $('#HdTQFId').val() + '|';
                json += 'LearningSetId :' + $('#Hdlearningsetid').val() + '|';
                json += 'Estimateid :' + x + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF3.aspx/SelEst",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $(".loader").fadeOut("slow");
                    },
                    success: function (response) {
                        Getlearningoutput();
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
            else if (ctrl == 'Gvsearchcourse') {
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
            else if (ctrl == "Gvsearchrecommenddocument") {
                Selectedrecommenddocument(x);
            }
            else if (ctrl == "Gvsearchother") {
                Selectedother(x);
            }
        }
        function Getcourse() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Getcourse",
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



        function SearchapproveTQF() {
            var Cri = '';
            ClearResource('TQF/TQF3.aspx', 'Gvsearchcourseapprove');
            var Columns = ["วิชา!L", "รุ่น!C", "ปี!C", "สถานะ!C"];
            var Data = ["subjectname", "Generation", "Year", "Statusname"];
            var Searchcolumns = ["วิชา"];
            var SearchesDat = ["subjectname"];
            var Width = ["50%", "10%", "10%", "10%"];

            var Gvsearchcourse = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchcourseapprove', 1000, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divsearchcourseapprove').html(Gvsearchcourse._Tables());
            Gvsearchcourse._Bind();
        }
        function SearchTQF() {
            var Cri = $('#Cbsearchcourse').val();
            ClearResource('TQF/TQF3.aspx', 'Gvsearchcourse');
            var Columns = ["วิชา!L", "รุ่น!C", "ปี!C", "!C", "สถานะ!C"];
            var Data = ["subjectname", "Generation", "Year", "Del", "Statusname"];
            var Searchcolumns = ["วิชา"];
            var SearchesDat = ["subjectname"];
            var Width = ["50%", "10%", "10%", "10%"];

            var Gvsearchcourse = new Grid("TQF/TQF3.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchcourse', 1000, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divsearchcourse').html(Gvsearchcourse._Tables());
            Gvsearchcourse._Bind();
        }
        function CreateTQF() {
            $('#DivcreateTQF').modal('show');
            Getnewcollege();
            Getnewcourse($('#Cbnewcollege').val());
            Getnewsubject($('#Cbnewcourse').val());
            Getnewclass();
            Getnewterm();
            Getnewyear();
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
        $(function () {
            Getsubjectgroup();

            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF3.aspx/Iseducate",
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
                        //    isBuddhist: true,
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


        <div id="Divapprove" style="display: none;">
            <div class="card" style="margin-top: 20px; color: black;">
                <div class="card-header">
                    ข้อมูลการอนุมัติ มคอ.3 
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

        <div id="Divmaster" style="display: none;">
            <div class="card" style="margin-top: 20px; color: black;">
                <div class="card-header">
                    ข้อมูล มคอ.3 รายละเอียดของรายวิชา
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
        <div id="Divdetail" style="display: none;">
            <input type="hidden" id="HdTQFId" value="" />
            <div class="container">
                <div class="row">
                    <div class="col-12" style="text-align: right;">
                        <button class="btn btn-danger" style="border-radius: 1px; margin-top: 10px;" onclick="Send2validate();">ส่งให้ตรวจสอบ / อนุมัติ</button>
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
                    <a class="nav-link" data-toggle="tab" href="#menudetail">จัดการแผนการสอนละเอียด</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menucost">ค่าใช้จ่ายในรายวิชา</a>
                </li>
            </ul>
            <!-- Tab panes -->
            <div id="divtab" class="tab-content">

                <div id="menu1" class="container tab-pane active">
                    <div class="container-fluid" style="font-size: 16px; color: black;">
                        <div class="row mt-1">
                            <div class="col-12">
                                <button class="btn btn-info" style="border-radius: 1px;" onclick="Save('1');">บันทึกหมวด</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <div id="example_html">
            
                          
          </div>
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

                                        <div class="container" style="font-size: 16px !important;">
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

                                        <div class="container" style="font-size: 16px !important;">
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

                                        <div class="container" style="font-size: 16px !important;">
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
                                                    <input id="Txtsubjectdesc" type="text" class="form-control" style="display:none;"/>
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

                                        <div class="container" style="font-size: 16px !important;">
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
                                                    <span>อาจารย์ภาคทฤษฎี</span>
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
                                                    <span>อาจารย์พิเศษ</span>
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

                                        <div class="container" style="font-size: 16px !important;">
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

                                        <div class="container" style="font-size: 16px !important;">
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
                                        <h6>8. สถานที่เรียน</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 16px !important;">
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

                                        <div class="container" style="font-size: 16px !important;">
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
                    <div class="container-fluid" style="font-size: 16px; color: black;">
                        <div class="row mt-1">
                            <div class="col-12">
                                <button class="btn btn-info" style="border-radius: 1px;" onclick="Save('2');">บันทึกหมวด</button>
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

                                        <div class="container" style="font-size: 16px !important;">
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
                                            <%--<div class="row mt-1">
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
                                            </div>--%>
                                            <div class="row mt-1">
                                                <button onclick="Newoutcome();" class="btn btn-info" style="border-radius: 1px; margin: 5px; font-size: 14px;">เพิ่มวัตถุประสงค์รายวิชา</button>
                                            </div>
                                            <div class="row mt-3" id="Divoutcome">
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

                                        <div class="container" style="font-size: 16px !important;">
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
                <div id="menu3" class="container tab-pane fade">
                    <div class="container-fluid" style="font-size: 16px; color: black;">
                        <div class="row mt-1">
                            <div class="col-12">
                                <button onclick="Save('3');" class="btn btn-info" style="border-radius: 1px;">บันทึกหมวด</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12" style="text-align: center;">
                                <h6>หมวดที่ 3 ลักษณะและวิธีดำเนินการ</h6>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. คำอธิบายรายวิชา</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">คำอธิบายรายวิชา (ไทย)</div>
                                                <div class="col-12">
                                                    <textarea id="TxtsubjectremarkTH" class="form-control" style="height: 100px;"></textarea>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">คำอธิบายรายวิชา (อังกฤษ)</div>
                                                <div class="col-12">
                                                    <textarea id="TxtsubjectremarkEN" class="form-control" style="height: 100px;"></textarea>
                                                </div>
                                            </div>
                                            <%-- <div class="row mt-1">
                                                <div class="col-12" style="color: red;">*** นำข้อมูลคำอธิบายรายวิชาทั้งภาษาไทยและภาษาอังกฤษมาจาก มคอ.2</div>

                                            </div>--%>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>2. จำนวนชั่วโมงที่ใช้ต่อภาคการศึกษา</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1" style="display: none;">
                                                <div class="col-4">
                                                    <span>จำนวนชั่วโมงต่อ หนึ่งหน่วยกิต</span>
                                                </div>
                                                <div class="col-8">
                                                    <select class="form-control" id="Cbtotalhour" onchange="Changetotalhour();" style="font-size: 16px!important;">
                                                        <option selected="selected" value="15">15 ชั่วโมง</option>
                                                        <option value="30">30 ชั่วโมง</option>

                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <table class="table table-bordered" style="margin-top: 10px;">
                                                        <tr>
                                                            <td>ทฤษฎี
                                                            </td>
                                                            <td>ปฏิบัติ/ทดลอง
                                                            </td>
                                                            <td>การศึกษาค้นคว้าด้วยตนเอง
                                                            </td>
                                                            <td>สอนเสริม
                                                            </td>


                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <textarea id="Txttheoryhour" class="form-control" style="height: 80px;"></textarea>
                                                            </td>
                                                            <td>
                                                                <textarea id="Txtpracticalhour" class="form-control" style="height: 80px;"></textarea>

                                                            </td>
                                                            <td>
                                                                <textarea id="Txtresearchhour" class="form-control" style="height: 80px;"></textarea>
                                                            </td>
                                                            <td>
                                                                <textarea id="Txtaddtionaltech" class="form-control" style="height: 80px;"></textarea>

                                                            </td>

                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12" style="color: red;">*** การแสดงผลในตารางจำนวนชั่วโมงที่ใช้ต่อภาคการศึกษา เป็นการคำนวณจาก หน่วยกิตคูณด้วยจำนวนอาทิตย์ ยกตัวอย่าง (3-0-6)*10 = (30-0-60)</div>
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
                                        <h6>3. จำนวนชั่วโมง/สัปดาห์ที่อาจารย์ให้คำปรึกษาและแนะนำทางวิชาการแก่นิสิต/นักศึกษาเป็นรายบุคคล</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">

                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <button onclick="Newadvice();" class="btn btn-info" style="border-radius: 1px; margin: 5px; font-size: 14px;" autocomplete="off">เพิ่มอาจารย์ที่ปรึกษา</button>
                                                    <button onclick="Updateadvice();" class="btn btn-secondary" style="border-radius: 1px; margin: 5px; font-size: 14px;" autocomplete="off">บันทึกอาจารย์ที่ปรึกษา</button>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <div id="Divadvice">
                                                        <%-- <table class="table table-bordered" style="margin-top: 10px;">
                                                        <tr>
                                                            <td>ชื่อ – สกุล อาจารย์
                                                            </td>
                                                            <td>สถานที่
                                                            </td>
                                                            <td>E-mail address/โทรศัพท์
                                                            </td>
                                                            <td>วัน และ เวลาในการให้คำปรึกษา
                                                            </td>

                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <textarea class="form-control" style="height: 80px;"></textarea>
                                                            </td>
                                                            <td>
                                                                <textarea class="form-control" style="height: 80px;"></textarea>
                                                            </td>
                                                            <td>
                                                                <textarea class="form-control" style="height: 80px;"></textarea>
                                                            </td>
                                                            <td>
                                                                <textarea class="form-control" style="height: 80px;"></textarea>
                                                            </td>

                                                        </tr>
                                                    </table>--%>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                <div class="col-12" style="color: red;">*** นำข้อมูลมาจาก มคอ.3 หมวดที่ 1 ข้อที่ 4.อาจารย์ผู้รับผิดชอบรายวิชาและอาจารย์ผู้สอน</div>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu4" class="container tab-pane fade">
                    <div class="container-fluid" style="font-size: 16px; color: black;">
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
                                <h6>หมวดที่ 4 การพัฒนาผลการเรียนรู้ของนักศึกษา</h6>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. การพัฒนาผลการเรียนรู้ของนิสิต/นักศึกษา</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">

                                            <%--  <div class="row mt-1">
                                                <div class="col-12">
                                                    <button class="btn btn-info" onclick="Newlearningset();" style="border-radius: 1px;">เพิ่มผลการเรียนรู้ใหม่</button>
                                                </div>
                                                    </div>--%>

                                            <div id="Divestimateoutput" class="col-12">




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
                                                                    <div class="card" style="font-size: 14px!important">
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
                                                                    <div class="card" style="font-size: 14px!important">
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
                    <div class="container-fluid" style="font-size: 16px; color: black;">
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
                                <h6>หมวดที่ 5 แผนการสอนและการประเมินผล</h6>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. แผนการสอน ( ภาคทฤษฎี )</h6>

                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">

                                            <div class="row mt-1">
                                                <div class="col-6" style="text-align: left;">

                                                    <button class="btn btn-secondary" style="border-radius: 1px;" onclick="Newtheoryplan();">เพิ่มแผนการสอนทฤษฎี</button>
                                                    <button class="btn btn-danger" style="border-radius: 1px;" onclick="Savetheoryplan();">บันทึกแผนการสอนทฤษฎี</button>
                                                </div>
                                                <div class="col-6" style="text-align: right;">
                                                    <%-- <select id="basic2" class="form-control"  >
                                                  <option value="C">cow</option>
                                                  <option value="B">bull</option>
                                                  <option value="E">EGG</option>
                                                 <option value="S">Source</option>
                                                </select>--%>


                                                    <%-- <button class="btn btn-info" style="border-radius:1px;" onclick="Newteachingplan();">เพิ่มข้อมูลแผนการสอน</button>
                                                &nbsp;
                                                <button class="btn btn-info" style="border-radius:1px;" onclick="Newteachingtopic();">เพิ่มข้อมูลบทการสอน</button>--%>
                                                </div>
                                            </div>

                                            <div class="row mt-3">
                                                <table class="table table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td style='width: 15%;'>วัน เดือน ปี</td>
                                                            <td style="width: 15%;">ผลการเรียนรู้</td>
                                                            <td style="width: 13%;">บทที่/หัวข้อ</td>
                                                            <td style='width: 12%;'>วิธีการสอน</td>
                                                            <td style='width: 12%;'>การประเมินผล</td>
                                                            <td style='width: 30%;'>ผู้สอน</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="Divtheoryplan">
                                                    </tbody>
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
                                        <h6>2.แผนการประเมินผลการเรียนรู้</h6>

                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">

                                            <div class="row mt-1">
                                                <div class="col-6" style="text-align: left;">
                                                    <button class="btn btn-secondary" style="border-radius: 1px;" onclick="Newestimateplan();">เพิ่มแผนการประเมินผลการเรียนรู้</button>
                                                    <button class="btn btn-danger" style="border-radius: 1px;" onclick="Saveestimateplan();">บันทึกแผนการประเมินผลการเรียนรู้</button>
                                                </div>
                                                <div class="col-4" style="text-align: right;">
                                                    <span>จำนวนร้อยละรวมทั้งหมด</span>
                                                </div>
                                                <div class="col-2" style="text-align: right;">
                                                    <input type="text" class="form-control" style="color: red; text-align: right;" id="Txttotalpercent" readonly="readonly" />
                                                </div>
                                            </div>

                                            <div class="row mt-3">
                                                <table class="table table-bordered">
                                                    <thead>
                                                        <tr>
                                                            <td>ผลการเรียนรู้</td>
                                                            <td style="width: 20%;">งานที่ใช้ประเมินผลการเรียนรู้</td>
                                                            <td>สัปดาห์ที่กำหนด</td>
                                                            <td>สัดส่วนของการประเมินผล (ร้อยละ)</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="Divestimateplan">
                                                    </tbody>
                                                </table>

                                            </div>



                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <%--        <div class="card">
                                    <div class="card-header">
                                        <h6>3. เอกสารข้อมูลแนะนำ</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1">
                                                <div class="col-12" style="margin-bottom:20px;">
                                                    3.1 หนังสือ / ตำรารอง / เอกสารเพิ่มเติม
                                                </div>
                                                <div class="col-12"><button class="btn btn-primary" onclick="Newrecommenddocument();">เพิ่มเอกสารเพิ่มเติม</button></div>
                                   
                                                <div class="col-12" id="Divrecommenddocument" style="margin-top:20px;">
                                                </div>
                                                <div class="col-12">
                                                    <div class="col-12" style="color: red;">*** นำข้อมูลตำรารอง / เอกสารเพิ่มเติมจากข้อมูลพื้นฐานของระบบ</div>
                                                </div>
                                            </div>
                                            <div class="row mt-1">
                                                

                                                <div class="col-12" style="margin-bottom:20px;">
                                                    3.2 วารสาร
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
                                                    3.3 ระบบสืบค้น
                                                </div>
                                                <div class="col-12"><button class="btn btn-primary" onclick="Newinquiry();">เพิ่มระบบสืบค้น</button></div>
                                   
                                                <div class="col-12" id="Divinquiry" style="margin-top:20px;">
                                                </div>

                                               <div class="col-12"><button class="btn btn-primary" onclick="Newebook();">เพิ่ม E-Book</button></div>
                                   
                                                <div class="col-12" id="Divebook" style="margin-top:20px;">
                                                </div>
                                                <div class="col-12">
                                                    <div class="col-12" style="color: red;">*** นำข้อมูลระบบสืบค้นมาจากข้อมูลพื้นฐานของระบบ</div>
                                                </div>
                                            </div>

                                            <div class="row mt-1">
                                              

                                                 <div class="col-12" style="margin-bottom:20px;">
                                                   3.4 สื่อการสอนอื่นๆ
                                                </div>
                                                <div class="col-12"><button class="btn btn-primary" onclick="Newother();">เพิ่มสื่อการสอนอื่นๆ</button></div>
                                   
                                                <div class="col-12" id="Divother" style="margin-top:20px;">
                                                </div>


                                                <div class="col-12">
                                                    <div class="col-12" style="color: red;">*** นำข้อมูลสื่อการสอนอื่นๆมาจากระบบครุภัณฑ์ หมวดของครุภัณฑ์การศึกษา</div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>--%>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu6" class="container tab-pane fade">
                    <div class="container-fluid" style="font-size: 16px; color: black;">
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
                                <h6>หมวดที่ 6 ทรัพยากรประกอบการเรียนการสอน</h6>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. ตำราและเอกสารหลัก</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                   <%-- <button class="btn btn-primary" onclick="Newtextbook();">เพิ่มตำราและเอกสารหลัก</button></div>
                                                    <div class="col-12" id="Divtextbook" style="margin-top: 20px;">--%>
                                                </div>
                                                <div class="col-8">
                                                    &nbsp;
                                                </div>
                                                 <div class="col-4">
                                                     <div class="input-group mb-3"><input type="text" class="form-control" style="font-size:1em;"  placeholder="รหัสหนังสือ,ชื่อหนังสือ" /><div class="input-group-append"><button class="btn btn-outline-info"   style="font-size: 1.0em; border-radius: 1px;" type="button"><i class="fa fa-search" aria-hidden="true"></i></button></div></div>
                                                 </div>
                                                <div class="col-12">
                                                    <div style="height:200px;border:1px solid lightgray;vertical-align:middle;">
                                                        <div style="font-size:14px;font-family:Kanit; color:red;text-align:center;margin-top:60px;">ไม่พบข้อมูล</div>
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
                                        <h6>2. เอกสารและข้อมูลสำคัญ</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newconfidentdocument();">เพิ่มเอกสารและข้อมูลสำคัญ</button></div>

                                                <div class="col-12" id="Divconfidentdocument" style="margin-top: 20px;">
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
                                        <h6>3. เอกสารข้อมูลแนะนำ</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1">
                                                <div class="col-12" style="margin-bottom: 20px;">
                                                    3.1 หนังสือ / ตำรารอง / เอกสารเพิ่มเติม
                                                </div>


                                                <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newrecommenddocument();">เพิ่มเอกสารเพิ่มเติม</button></div>

                                                <div class="col-12" id="Divrecommenddocument" style="margin-top: 20px;">
                                                </div>
                                                <div class="col-12">
                                                    <div class="col-12" style="color: red;">*** นำข้อมูลตำรารอง / เอกสารเพิ่มเติมจากข้อมูลพื้นฐานของระบบ</div>
                                                </div>
                                            </div>
                                            <div class="row mt-1">


                                                <div class="col-12" style="margin-bottom: 20px;">
                                                    3.2 วารสาร
                                                </div>
                                                <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newjournal();">เพิ่มวารสารวิชาการ</button></div>

                                                <div class="col-12" id="Divjournal" style="margin-top: 20px;">
                                                </div>


                                                <div class="col-12">
                                                    <div class="col-12" style="color: red;">*** นำข้อมูลวารสารวิชาการจากข้อมูลพื้นฐานของระบบ</div>
                                                </div>
                                            </div>

                                            <div class="row mt-1">

                                                <div class="col-12"></div>
                                                <div class="col-12">
                                                </div>
                                                <div class="col-12" style="margin-bottom: 20px;">
                                                    3.3 ระบบสืบค้น
                                                </div>
                                                <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newinquiry();">เพิ่มระบบสืบค้น</button></div>

                                                <div class="col-12" id="Divinquiry" style="margin-top: 20px;">
                                                </div>

                                                <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newebook();">เพิ่ม E-Book</button></div>

                                                <div class="col-12" id="Divebook" style="margin-top: 20px;">
                                                </div>
                                                <div class="col-12">
                                                    <div class="col-12" style="color: red;">*** นำข้อมูลระบบสืบค้นมาจากข้อมูลพื้นฐานของระบบ</div>
                                                </div>
                                            </div>

                                            <div class="row mt-1">


                                                <div class="col-12" style="margin-bottom: 20px;">
                                                    3.4 สื่อการสอนอื่นๆ
                                                </div>
                                                <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newother();">เพิ่มสื่อการสอนอื่นๆ</button></div>

                                                <div class="col-12" id="Divother" style="margin-top: 20px;">
                                                </div>


                                                <div class="col-12">
                                                    <div class="col-12" style="color: red;">*** นำข้อมูลสื่อการสอนอื่นๆมาจากระบบครุภัณฑ์ หมวดของครุภัณฑ์การศึกษา</div>
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
                    <div class="container-fluid" style="font-size: 16px; color: black;">
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
                                <h6>หมวดที่ 7 การประเมินและการปรับปรุงการดำเนินการของรายวิชา</h6>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. กลยุทธ์การประเมินประสิทธิผลของรายวิชาโดยนิสิต/นักศึกษา</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <textarea id="Txtstategybystudent" style="height: 100px; width: 100%;"></textarea>
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
                                        <h6>2. กลยุทธ์การประเมินการสอน</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <textarea id="Txtstategybyteaching" style="height: 100px; width: 100%;"></textarea>
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
                                        <h6>3. การปรับปรุงการสอน</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <textarea id="Txtimproveteaching" style="height: 100px; width: 100%;"></textarea>
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
                                        <h6>4. การทวนสอบมาตรฐานผลสัมฤทธิ์ของนิสิต/นักศึกษาในรายวิชา</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <textarea id="Txtreestimate" style="height: 100px; width: 100%;"></textarea>
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
                                        <h6>5. การดำเนินการทบทวนและการวางแผนการปรับปรุงประสิทธิผลของรายวิชา</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <textarea id="Txtplanningimprove" style="height: 100px; width: 100%;"></textarea>
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
                                        <h6>6. อื่นๆ</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 16px !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <textarea id="Txtstategyother" style="height: 100px; width: 100%;"></textarea>
                                                </div>
                                            </div>



                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="menudetail" class="container tab-pane fade">
                    <div class="container">
                        <div class="row mt-1">
                            <div class="col-12">
                                <button class="btn btn-info" onclick="Newteachingplandetail();" style="border-radius: 1px;">เพิ่มแผนการสอน</button>
                                &nbsp;
                                 <button class="btn btn-secondary" onclick="Saveteachingplandetail();" style="border-radius: 1px;">บันทึกแผนการสอน</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12" style="text-align: center;">
                                <div id="Divteachingplandetail"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="menucost" class="container tab-pane fade">
                    <div class="container">
                        <div class="row mt-1">
                            <div class="col-12">
                                <button class="btn btn-info" onclick="Savecost();" style="border-radius: 1px;">บันทึกรายการค่าใช้จ่าย</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12" style="text-align: center;">
                                <div id="Divcostcont">
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
                        <div class="container" style="font-size: 16px; margin-top: 20px;">
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
                                        <input type="number" style="text-align: right;" id="Txtnewgeneration" class="form-control" />
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
                        <button type="button" onclick="DonewTQF();" class="btn btn-primary" style="border-radius: 2px; font-size: 0.8em;" id="Cmdforgotpasswordsendlink">บันทึก</button>
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
                        <button type="button" class="btn btn-danger" style="font-size: 16px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
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
                        <button type="button" class="btn btn-danger" style="font-size: 16px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>
        <div class="modal" id="Divlearningoutput" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span></span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">

                        <div class="container" id="Divlearningoutputcont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 16px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>


        <div class="modal" id="Divparticular" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span></span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">

                        <div class="container" id="Divparticularcont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 16px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal" id="Divestimate" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span></span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">

                        <div class="container" id="Divestimatecont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 16px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
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
                        <button type="button" class="btn btn-danger" style="font-size: 16px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
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
                        <button type="button" class="btn btn-danger" style="font-size: 16px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
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
                        <button type="button" class="btn btn-danger" style="font-size: 16px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
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
                        <button type="button" class="btn btn-danger" style="font-size: 16px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal" id="Divmodalrecommenddocument" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span>เอกสารข้อมูลแนะนำ</span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">

                        <div class="container" id="Divrecommenddocumentcont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 16px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal" id="Divmodalother" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span>สื่อการสอนอื่นๆ</span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">

                        <div class="container" id="Divothercont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 16px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>


        <div class="modal" id="Divteachingplans" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <span>แผนการสอน</span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="container" id="Divteachingplancont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal" id="Divnewteachingplan" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <span>แผนการสอน</span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="container" style="margin-right: 10px; min-height: 320px; padding: 8px;">
                            <div class="row">
                                <div class="col-12">
                                    <span>ชื่อแผนการสอน</span>&nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-12">
                                    <input type="hidden" id="Hdteachingplanid" value="" />
                                    <input type="text" class="form-control" id="Txtteachingplanname" value="" />
                                </div>
                            </div>
                        </div>
                        <!-- Modal footer -->
                        <div class="modal-footer">
                            <button type="button" class="btn btn-standard" style="background-color: #313131; color: white; font-size: 14px; border-radius: 0;" onclick="Saveteachingplan();">บันทึก</button>
                            <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal" onclick="Closeteachingplanmodal();">ปิดหน้าต่างนี้</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>





    </div>
    <div class="modal" id="Divteachingtopics" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <span>บทการสอน</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container" id="Divteachingtopiccont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; padding: 8px;">
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                </div>

            </div>
        </div>
    </div>


    <div class="modal" id="Divnewest" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <span>เพิ่มวิธีประเมิน</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container" style="margin-right: 10px; min-height: 320px; padding: 8px;">
                        <div class="row">
                            <div class="col-12">
                                <span>วิธีประเมิน</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                                <input type="text" class="form-control" id="Txtnewest" value="" />
                            </div>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-standard" style="background-color: #313131; color: white; font-size: 14px; border-radius: 0;" onclick="Saveest();">บันทึก</button>
                        <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal" onclick="Closenewest();">ปิดหน้าต่างนี้</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="modal" id="Divnewpar" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <span>เพิ่มวิธีปฏิบัติ</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container" style="margin-right: 10px; min-height: 320px; padding: 8px;">
                        <div class="row">
                            <div class="col-12">
                                <span>วิธีปฏิบัติ</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                                <input type="text" class="form-control" id="Txtnewpar" value="" />
                            </div>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-standard" style="background-color: #313131; color: white; font-size: 14px; border-radius: 0;" onclick="Savepar();">บันทึก</button>
                        <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal" onclick="Closenewpar();">ปิดหน้าต่างนี้</button>
                    </div>

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
                    <div class="container" style="margin-right: 10px; min-height: 320px; padding: 8px;">
                        <div class="row">
                            <div class="col-12">
                                <span>ความเห็นเพิ่มเติม</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                                <textarea class="form-control" readonly="readonly" id="Txtshowcomment" style="height: 200px;"></textarea>
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
                    <div class="container" style="margin-right: 10px; min-height: 320px; padding: 8px;">
                        <div class="row">
                            <div class="col-12">
                                <span>ความเห็นเพิ่มเติม</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                                <textarea class="form-control" id="Txtcomment" style="height: 200px;"></textarea>
                            </div>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" style="background-color: #313131; color: white; font-size: 14px; border-radius: 0;" onclick="Doedit();">ส่งกลับแก้ไข</button>
                        <button type="button" class="btn btn-success" style="background-color: #313131; color: white; font-size: 14px; border-radius: 0;" onclick="Doapprove();">ตรวจสอบ / อนุมัติ</button>
                        <button type="button" class="btn btn-warning" style="background-color: #313131; color: white; font-size: 14px; border-radius: 0;" onclick="Doreject();">ปฏิเสธ</button>
                        <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal" onclick="Closecomment();">ปิดหน้าต่างนี้</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="modal" id="Divnewteachingtopic" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <span>บทการสอน</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container" style="margin-right: 10px; min-height: 320px; padding: 8px;">
                        <div class="row">
                            <div class="col-12">
                                <span>ภายใต้การสอน</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                                <select class="form-control" id="Cbteachingtopicplan"></select>
                            </div>
                            <div class="col-12">
                                <span>บทการสอน</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                                <input type="hidden" id="Hdteachingtopicid" value="" />
                                <input type="text" class="form-control" id="Txtteachingtopicname" value="" />
                            </div>
                            <div class="col-12">
                                <span>รายละเอียด</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                                <textarea class="form-control" id="Txtteachingtopicdesc"></textarea>
                            </div>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-standard" style="background-color: #313131; color: white; font-size: 14px; border-radius: 0;" onclick="Saveteachingtopic();">บันทึก</button>
                        <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal" onclick="Closeteachingtopicmodal();">ปิดหน้าต่างนี้</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="Hdteachingplandetailid" value="" />
    <input type="hidden" id="Hdlearningsetid" value="" />
    <input type="hidden" id="Hdapprove" value="" />


    <a id="back2Top" title="Back to top" href="#">&#10148;</a>

    <script src="../../Select2/js/bootstrap-select.js"></script>
    <script>
        function createOptions(number) {
            var options = [], _options;

            for (var i = 0; i < number; i++) {
                var option = '<option value="' + i + '">Option ' + i + '</option>';
                options.push(option);
            }

            _options = options.join('');

            //$('#number')[0].innerHTML = _options;
            //$('#number-multiple')[0].innerHTML = _options;

            //$('#number2')[0].innerHTML = _options;
            //$('#number2-multiple')[0].innerHTML = _options;
        }

     //var mySelect = $('#first-disabled2');

     //createOptions(4000);

     //$('#special').on('click', function () {
     //    mySelect.find('option:selected').prop('disabled', true);
     //    mySelect.selectpicker('refresh');
     //});

     //$('#special2').on('click', function () {
     //    mySelect.find('option:disabled').prop('disabled', false);
     //    mySelect.selectpicker('refresh');
     //});

     //$('#basic2').selectpicker({
     //    liveSearch: true,
     //    maxOptions: 1
     //});
     //$('#basic2').val('E').selectpicker('refresh');
    </script>
</body>
</html>
