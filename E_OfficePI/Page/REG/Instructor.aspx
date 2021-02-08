<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Instructor.aspx.cs" Inherits="E_OfficePI.Page.REG.Instructor" %>

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
        function Savegrade(id) {
            var json = '';
            json += 'Txtsendgradepoint_: ' + $('#Txtsendgradepoint_' + id).val() + '|';
            json += 'Cbsendgradegrade_: ' + $('#Cbsendgradegrade_' + id).val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/instructor.aspx/Savegrade",
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
                    Msgbox('บันทึกเกรดนักศึกษาคนนี้เรียบร้อยแล้ว');
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function CalGPAX(id) {
            var json = '';
            json += 'Txtsendgradepoint_: ' + $('#Txtsendgradepoint_' + id).val() + '|';
            json += 'Cbsendgradegrade_: ' + $('#Cbsendgradegrade_' + id).val() + '|';
            json += 'id: ' + id + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/instructor.aspx/Savegrade",
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
                    json = id;
                    $.ajax({
                        type: "POST",
                        url: "\../Page/REG/instructor.aspx/CalGPAX",
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
                            Msgbox('คำนวณ GPAX ให้นักศึกษาคนนี้เรียบร้อยแล้ว');
                            Searchsendgrade();
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
        function Sendgrade() {
            $('#Divsendgrade').show();
        }
        function Getsendgradecourse() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/instructor.aspx/Getcourse",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbsendgradecourse').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbsendgradecourse').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบรายวิชา'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbsendgradecourse').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                    }
                   
                    $('#Cbsendgradecourse').on('change', function () {
                        Getsubject($('#Cbsendgradecourse').val());
                    });
                    Getsubject($('#Cbsendgradecourse').val());
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Getsubject(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/REG/instructor.aspx/Getsubject",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbsendgradesubject').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbsendgradesubject').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbsendgradesubject').append($('<option/>', {
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
                url: "\../Page/REG/instructor.aspx/Getterm",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbsendgradeterm').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbsendgradeterm').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบภาคการศึกษา'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbsendgradeterm').append($('<option/>', {
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
                url: "\../Page/REG/instructor.aspx/Getclass",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbsendgradeclass').find('option').remove().end();
                    if (res.length == 0) {

                        $('#Cbsendgradeclass').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบชั้นปี'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofileclass').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                        for (i = 0; i < res.length; i++) {
                            $('#Cbsendgradeclass').append($('<option/>', {
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
                url: "\../Page/REG/instructor.aspx/Getyear",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbsendgradeyear').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbsendgradeyear').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbsendgradeyear').append($('<option/>', {
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
        function Searchsendgrade() {
            var html = '';
            var json = '';
            var i = 0;
            var Ctrl = '';
            var CtrlCalsGPAX = '';
            json += 'Cbsendgradeyear:' + $('#Cbsendgradeyear').val() + '|';
            json += 'Cbsendgradesubject:' + $('#Cbsendgradesubject').val() + '|';
            json += 'Cbsendgradeclass:' + $('#Cbsendgradeclass').val() + '|';
            json += 'Cbsendgradeterm:' + $('#Cbsendgradeterm').val() + '|';
            json += 'Cbsendgradecourse:' + $('#Cbsendgradecourse').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Instructor.aspx/Searchsendgrade",
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
                    //public string id { get; set; }
                    //public string Studentid { get; set; }
                    //public string Studentno { get; set; }
                    //public string Firstname { get; set; }
                    //public string Lastname { get; set; }
                    //public string Point { get; set; }
                    //public string Grade { get; set; }
                    //public string IscalGPAX { get; set; }
                    html += '<table class="table table-bordered">';
                    html += '<tr>';
                    html += '<td style="width:10%">รหัสนักศึกษา</td>';
                    html += '<td>ชื่อ-นามสกุล</td>';
                    html += '<td  style="width:10%">คะแนน</td>';
                    html += '<td  style="width:10%">เกรด</td>';
                    html += '<td  style="width:10%">&nbsp;</td>';
                    html += '<td  style="width:10%">&nbsp;</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>' + res[i]['Studentno'] + '</td>';
                            html += '<td>' + res[i]['Firstname'] + ' ' + res[i]['Lastname'] + '</td>';
                          
                            if (res[i]['IscalGPAX'] != "True") {

                                html += '<td><input type="text" Class="form-control" id="Txtsendgradepoint_' + res[i]['id'] + '" value="' + res[i]['Point'] + '" /></td>';
                                html += '<td>';
                                html += '<Select style="border-radius:1px;" Class="form-control" id="Cbsendgradegrade_' + res[i]['id'] + '" >';
                                if (res[i]['Grade'] == "A") {
                                    html += '<option value="A" selected>A</option>';
                                }
                                else {
                                    html += '<option value="A">A</option>';
                                }
                                if (res[i]['Grade'] == "B+") {
                                    html += '<option value="B+" selected>B+</option>';
                                }
                                else {
                                    html += '<option value="B+">B+</option>';
                                }
                                if (res[i]['Grade'] == "B") {
                                    html += '<option value="B" selected>B</option>';
                                }
                                else {
                                    html += '<option value="B">B</option>';
                                }
                                if (res[i]['Grade'] == "C+") {
                                    html += '<option value="C+" selected>C+</option>';
                                }
                                else {
                                    html += '<option value="C+">C+</option>';
                                }
                                if (res[i]['Grade'] == "C") {
                                    html += '<option value="C" selected>C</option>';
                                }
                                else {
                                    html += '<option value="C">C</option>';
                                }
                                if (res[i]['Grade'] == "D+") {
                                    html += '<option value="D+" selected>D+</option>';
                                }
                                else {
                                    html += '<option value="D+">D+</option>';
                                }
                                if (res[i]['Grade'] == "D") {
                                    html += '<option value="D" selected>D</option>';
                                }
                                else {
                                    html += '<option value="D">D</option>';
                                }
                                if (res[i]['Grade'] == "F") {
                                    html += '<option value="F" selected>F</option>';
                                }
                                else {
                                    html += '<option value="F">F</option>';
                                }
                                html += '</Select>';
                                html += '</td>';
                            }
                            else {
                                html += '<td><input type="text" readonly="readonly" Class="form-control" id="Txtsendgradepoint_' + res[i]['id'] + '" value="' + res[i]['Point'] + '" /></td>';
                                html += '<td>';
                                html += '<Select  readonly="readonly" style="border-radius:1px;" Class="form-control" id="Cbsendgradegrade_' + res[i]['id'] + '" >';
                                if (res[i]['Grade'] == "A") {
                                    html += '<option value="A" selected>A</option>';
                                }
                                else {
                                    html += '<option value="A">A</option>';
                                }
                                if (res[i]['Grade'] == "B+") {
                                    html += '<option value="B+" selected>B+</option>';
                                }
                                else {
                                    html += '<option value="B+">B+</option>';
                                }
                                if (res[i]['Grade'] == "B") {
                                    html += '<option value="B" selected>B</option>';
                                }
                                else {
                                    html += '<option value="B">B</option>';
                                }
                                if (res[i]['Grade'] == "C+") {
                                    html += '<option value="C+" selected>C+</option>';
                                }
                                else {
                                    html += '<option value="C+">C+</option>';
                                }
                                if (res[i]['Grade'] == "C") {
                                    html += '<option value="C" selected>C</option>';
                                }
                                else {
                                    html += '<option value="C">C</option>';
                                }
                                if (res[i]['Grade'] == "D+") {
                                    html += '<option value="D+" selected>D+</option>';
                                }
                                else {
                                    html += '<option value="D+">D+</option>';
                                }
                                if (res[i]['Grade'] == "D") {
                                    html += '<option value="D" selected>D</option>';
                                }
                                else {
                                    html += '<option value="D">D</option>';
                                }
                                if (res[i]['Grade'] == "F") {
                                    html += '<option value="F" selected>F</option>';
                                }
                                else {
                                    html += '<option value="F">F</option>';
                                }
                                html += '</Select>';
                                html += '</td>';
                            }
                            if (res[i]['IscalGPAX'] != "True") {
                                Ctrl = '<button style="border-radius:1px;font-size:13px;" Class="btn btn-Secondary" onclick="Savegrade(' + res[i]['id'] + ')" >บันทึกเกรด</button>';
                                CtrlCalsGPAX = '<button style="border-radius:1px;font-size:13px;" Class="btn btn-danger" onclick="CalGPAX(' + res[i]['id'] + ')" >ประมวลผลเกรดรวม</button>';
                            }
                            else {
                                Ctrl = '<span style="color:green;font-size:14px;">บันทึกเกรดแล้ว</span>';
                                CtrlCalsGPAX = '<span style="color:green;font-size:14px;">ประมวลผล GPAX แล้ว</span>';
                            }
                            html += '</td>';
                            html += '<td style="text-align:center;">' + Ctrl + '</td>';
                            html += '<td  style="text-align:center;">' + CtrlCalsGPAX + '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr>';
                        html += '<td colspan="6"><div style="color:red;height:100px;text-align:center;">ไม่พบนักศึกษาที่ลงทะเบียน</div></td>';
                        html += '</tr>';
                    }
                    html += '</table>';
                    $('#Divsendgradecont').html(html);
                },
                async: false,
                error: function (er) {
                }
            });

        }
        function Save(x) {
            var json = '';

            if (x == '1') {
                json += 'x :' + x + '|';
                json += 'Hdstudentid :' + $('#Hdstudentid').val() + '|';
                json += 'Txtprofilestudentno :' + $('#Txtprofilestudentno').val() + '|';
                json += 'Cbprofileclass :' + $('#Cbprofileclass').val() + '|';
                json += 'Cbprofiletitle :' + $('#Cbprofiletitle').val() + '|';
                json += 'Txtprofilefirstname :' + $('#Txtprofilefirstname').val() + '|';
                json += 'Txtprofilelastname :' + $('#Txtprofilelastname').val() + '|';
                json += 'Cbprofilestudentstatus :' + $('#Cbprofilestudentstatus').val() + '|';
                json += 'Cbprofiledegree :' + $('#Cbprofiledegree').val() + '|';
                json += 'Cbprofileeducation :' + $('#Cbprofileeducation').val() + '|';
                json += 'Cbprofilecourse :' + $('#Cbprofilecourse').val() + '|';
                json += 'Txtprofileyear :' + $('#Txtprofileyear').val() + '|';
                json += 'Cbprofilefundprovince :' + $('#Cbprofilefundprovince').val() + '|';
                json += 'Cbprofilefunding :' + $('#Cbprofilefunding').val() + '|';
                json += 'Cbprofilefundprovince :' + $('#Cbprofilefundprovince').val() + '|';
                json += 'Cbprofilefundtype :' + $('#Cbprofilefundtype').val() + '|';



                $.ajax({
                    type: "POST",
                    url: "\../Page/REG/instructor.aspx/Save",
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
                        Msgbox('บันทึกข้อมูลเรียบร้อยแล้ว');

                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            else if (x == '2') {

                json += 'x :' + x + '|';
                json += 'Hdstudentid :' + $('#Hdstudentid').val() + '|';
                json += 'Txtprofilecardid :' + $('#Txtprofilecardid').val() + '|';
                json += 'TxtprofiletitleEN :' + $('#TxtprofiletitleEN').val() + '|';
                json += 'TxtprofilefirstnameEN :' + $('#TxtprofilefirstnameEN').val() + '|';
                json += 'TxtprofilelastnameEN :' + $('#TxtprofilelastnameEN').val() + '|';
                json += 'Txtprofilebirthdate :' + $('#Txtprofilebirthdate').val() + '|';
                json += 'Cbprofileblood :' + $('#Cbprofileblood').val() + '|';
                json += 'Cbprofilegender :' + $('#Cbprofilegender').val() + '|';
                json += 'Cbprofilemarystatus :' + $('#Cbprofilemarystatus').val() + '|';
                json += 'Cbprofilenation :' + $('#Cbprofilenation').val() + '|';
                json += 'Cbprofilereligion :' + $('#Cbprofilereligion').val() + '|';
                json += 'Cbprofilerace :' + $('#Cbprofilerace').val() + '|';
                json += 'Txtprofileweight :' + $('#Txtprofileweight').val() + '|';
                json += 'Txtprofileheight :' + $('#Txtprofileheight').val() + '|';
                json += 'Cbprofilecountry :' + $('#Cbprofilecountry').val() + '|';
                json += 'Cbprofileprovince :' + $('#Cbprofileprovince').val() + '|';
                json += 'Txtpreveducation :' + $('#Txtpreveducation').val() + '|';
                json += 'Cbprofileismilitarystate :' + $('#Cbprofileismilitarystate').val() + '|';


                $.ajax({
                    type: "POST",
                    url: "\../Page/REG/instructor.aspx/Save",
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
                        Msgbox('บันทึกข้อมูลเรียบร้อยแล้ว');
                        Bindeducation();
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
            else if (x == '3') {
                json += 'x :' + x + '|';
                json += 'Hdstudentid :' + $('#Hdstudentid').val() + '|';
                $('#Divaddress').find('textarea').each(function () {
                    json += $(this).attr('id') + ':' + $(this).val() + '|';
                });
                $('#Divaddress').find('select').each(function () {
                    json += $(this).attr('id') + ':' + $(this).val() + '|';
                });
                $.ajax({
                    type: "POST",
                    url: "\../Page/REG/instructor.aspx/Save",
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
                        Msgbox('บันทึกข้อมูลเรียบร้อยแล้ว');
                        Bindeducation();
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
        }
        $(document).ready(function () {
            Sendgrade();
        });

        $(function () {
            Getterm();
            Getyear();
            Getclass();
            Getsendgradecourse();
            
            Searchsendgrade();
           
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
                        <a class="nav-link" href="#" onclick="Sendgrade();">ประมวลผลเกรด</a>
                    </li>
                </ul>
            </div>
        </nav>

        <div id="Divsendgrade" style="display: none; margin-top: 30px;">
            <div class="container">
                <div class="row">
                    <div class="form-group">
                        <div class="input-group mb-2">
                            <span style="margin: 10px;">ปีการศึกษา</span><select style="margin: 10px; width: 80px;" class="form-control" id="Cbsendgradeyear"></select>
                            <span style="margin: 10px;">ภาค</span><select style="margin: 10px; width: 80px;" class="form-control" id="Cbsendgradeterm"></select>
                            <span style="margin: 10px;">ชั้นปี</span><select style="margin: 10px; width: 80px;" class="form-control" id="Cbsendgradeclass"></select>
                            <span style="margin: 10px;">หลักสูตร</span><select style="margin: 10px; width: 200px;" class="form-control" id="Cbsendgradecourse"></select>
                            <span style="margin: 10px;">วิชา</span><select style="margin: 10px; width: 200px;" class="form-control" id="Cbsendgradesubject"></select>
                            <button style="margin: 10px;font-family:TH SarabunPSK;font-size:13px;border-radius:1px;" class="btn btn-info" onclick="Searchsendgrade();"><span>ค้นหา</span></button>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <hr />
                    </div>
                </div>
                <div class="row">
                    <div id="Divsendgradecont" class="col-12" style="color:black;">
                    </div>
                </div>
            </div>
        </div>


    </div>
</body>
</html>
