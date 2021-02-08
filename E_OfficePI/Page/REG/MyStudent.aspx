<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyStudent.aspx.cs" Inherits="E_OfficePI.Page.REG.MyStudent" %>

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
        function Deletestudent(x) {
            $("#DivConfirm").modal('show');
            $('#DivConfirmMsg').html('คุณต้องการลบนักศึกษาคนนี้ ?');

            $('#CmdConfirm').on('click', function () {
                var html = '';
                var json = '';
                var userid = '';
                json = 'x :' + x + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/REG/Mystudent.aspx/Deletestudent",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#DivConfirm").modal('hide');
                        Msgbox('ลบข้อมูลนักศึกษาเรียบร้อยแล้ว');
                        students();
                    },
                    async: false,
                    error: function (er) {
                        Msgbox(er.Marystatus);
                    }
                });
            });
        }
        function Payment() {
            $('#Divpayment').show();
            $('#Divstudent').hide();
            $('#Divstudentprofile').hide();
            $('#Divaddwithdraw').hide();
            Searchpayment();
        }
        function Gettitle() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Mystudent.aspx/Gettitle",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofiletitle').find('option').remove().end();
                    if (res.length == 0) {
                        $('#Cbprofiletitle').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                       
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofiletitle').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                        $('#Cbprofiletitle').on('change', function () {
                            json = $('#Cbprofiletitle').val();
                            $.ajax({
                                type: "POST",
                                url: "\../Page/REG/Mystudent.aspx/GettitleEN",
                                data: "{'json' :'" + json + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                beforeSend: function () {
                                    $(".loader").fadeOut("slow");
                                },
                                success: function (response) {
                                    res = response.d;
                                    $('#TxtprofiletitleEN').val(res);
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
        function Getfundtype() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Mystudent.aspx/Getfundtype",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                }, 
                success: function (response) {
                    res = response.d;
                    $('#Cbprofilefundtype').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofilefundtype').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofilefundtype').append($('<option/>', {
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
        function Getfunding() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Mystudent.aspx/Getfunding",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofilefunding').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofilefunding').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofilefunding').append($('<option/>', {
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
        function Getmarystatus() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Mystudent.aspx/Getmarystatus",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofilemarystatus').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofilemarystatus').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofilemarystatus').append($('<option/>', {
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
                url: "\../Page/REG/Mystudent.aspx/Getnation",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofilenation').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofilenation').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofilenation').append($('<option/>', {
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
                url: "\../Page/REG/Mystudent.aspx/Getrace",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofilerace').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofilerace').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofilerace').append($('<option/>', {
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
                url: "\../Page/REG/Mystudent.aspx/Getreligion",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofilereligion').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofilereligion').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofilereligion').append($('<option/>', {
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
                url: "\../Page/REG/Mystudent.aspx/Getblood",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofileblood').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofileblood').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofileblood').append($('<option/>', {
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
        function Getstudentstatus() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Mystudent.aspx/Getstudentstatus",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofilestudentstatus').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofilestudentstatus').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofilestudentstatus').append($('<option/>', {
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
                url: "\../Page/REG/Mystudent.aspx/Getgender",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofilegender').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofilegender').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofilegender').append($('<option/>', {
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
        function Save(x) {
            var json = '';

            if (x == '1')
            {
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
                    url: "\../Page/REG/Mystudent.aspx/Save",
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
            else if (x == '2')
            {

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
                    url: "\../Page/REG/Mystudent.aspx/Save",
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
                    url: "\../Page/REG/Mystudent.aspx/Save",
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
        function Getstudentinfo() {
            var json = $('#Hdstudentid').val();
            $.ajax({
                type: "POST",
                url: "\../Page/REG/mystudent.aspx/Getstudentinfo",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res['GPAX'] != "") {
                        $('#TxtprofileGPAX').val(res['GPAX']);
                    }
                    else {
                        $('#TxtprofileGPAX').val('ยังไม่มีการประมวลผลเกรด');
                    }
                    $('#Txtprofilestudentno').val(res['Studentno']);
                    $('#Cbprofileclass').val(res['Class']);
                    $('#Cbprofiletitle').val(res['Titleid']);
                    $('#Txtprofilefirstname').val(res['Firstname']);
                    $('#Txtprofilelastname').val(res['Lastname']);
                    $('#Cbprofilestudentstatus').val(res['Studentstatusid']);
                    $('#Cbprofiledegree').val(res['Degreeid']);
                    $('#Cbprofileeducation').val(res['Educationid']);
                    $('#Cbprofilecourse').val(res['Courseid']);
                    $('#Txtprofileyear').val(res['Year']);
                    $('#Cbprofilefundprovince').val(res['Fundprovinceid']);
                    $('#Cbprofilefunding').val(res['Fundingid']);
                    $('#Cbprofilefundtype').val(res['Fundtypeid']);
                    $('#Txtprofilecardid').val(res['Cardid']);
                    $('#TxtprofiletitleEN').val(res['TitleEN']);
                    $('#TxtprofilefirstnameEN').val(res['FirstnameEN']);
                    $('#TxtprofilelastnameEN').val(res['LastnameEN']);
                    $('#Txtprofilebirthdate').val(res['Birthdate']);
                    $('#Cbprofileblood').val(res['Bloodid']);
                    $('#Cbprofilegender').val(res['Genderid']);
                    $('#Cbprofilemarystatus').val(res['Marystatusid']);
                    $('#Cbprofilenation').val(res['Nationid']);
                    $('#Cbprofilereligion').val(res['Religionid']);
                    $('#Cbprofilerace').val(res['Raceid']);
                    $('#Txtprofileweight').val(res['Weight']);
                    $('#Txtprofileheight').val(res['Height']);
                    $('#Cbprofilecountry').val(res['Countryid']);
                    $('#Cbprofileprovince').val(res['Provinceid']);
                    $('#Txtpreveducation').val(res['Preveducation']);
                    $('#Cbprofilemilitarystate').val(res['Ismilitarystate']);       
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
                url: "\../Page/REG/Mystudent.aspx/Getcountry",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofilecountry').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofilecountry').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofilecountry').append($('<option/>', {
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
                url: "\../Page/REG/Mystudent.aspx/Geteducation",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofileeducation').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofileeducation').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofileeducation').append($('<option/>', {
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
                url: "\../Page/REG/Mystudent.aspx/Getdegree",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbprofiledegree').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbprofiledegree').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofiledegree').append($('<option/>', {
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
        function Editstudent(x) {
            $('#Divstudent').hide();
            $('#Divstudentprofile').show();

            $('#Hdstudentid').val(x);
            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });
           
            Getaddress();
            Gettitle();
            Getmarystatus();
            Getreligion();
            Getblood();
            Getprovince();
            Getcountry();
            Getdegree();
            Geteducation();
            Getgender();
            Getnation();
            Getrace();
            Getstudentcourse();
            Getfunding();
            Getfundtype();
            Getstudentstatus();
            Getclass();
            Getstudentinfo();
            Binddebt();
        }
        function Savenewstudent() {
            var json = '';
            json += 'Txtstudentno :' + $('#Txtstudentno').val() + '|';
            json += 'Txtfirstname :' + $('#Txtfirstname').val() + '|';
            json += 'Txtlastname :' + $('#Txtlastname').val() + '|';
            json += 'Cbstudentcourse :' + $('#Cbstudentcourse').val() + '|';
            json += 'Cbstudentregistertype :' + $('#Cbstudentregistertype').val() + '|';
            json += 'Cbstudentregisterquota :' + $('#Cbstudentregisterquota').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Mystudent.aspx/Savenewstudent",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res['Error'] != "") {
                        Msgbox(res['Error']);
                        return;
                    }
                    $('#Divnewstudent').modal('hide');
                    Editstudent(res["id"]);
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function students() {
            var html = '';
            var json = '';
            var studentid = '';
            json = 'Txtstudentsearch :' + $('#Txtstudentsearch').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Mystudent.aspx/Students",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.length > 0) {
                        for (i = 0; i < response.d.length; i++) {
                            studentid = response.d[i]['id'];
                            html += ' <div class="col-6" >';
                            html += ' <div class="container" style="border:dashed 1px gray;padding:10px;margin:10px;min-height:100px;font-size:14px;">';
                            html += ' <div class="row">';
                            html += ' <div class="col-4" style="text-align:center;">';

                            if (response.d[i]['avartarurl'] == null || response.d[i]['avartarurl'] == '') {
                                html += ' <img src="https://iconorbit.com/icons/256-watermark/1611201511254916681-Boy%20Student.jpg"  style="width:120px;margin-top:20px;" />';
                            }
                            else {
                                html += ' <img src="' + response.d[i]['Avartarurl'] + '"  style="width:150px;margin-top:20px;" />';
                            }
                            html += ' </div>';
                            html += ' <div class="col-8" style="font-size:13px;">';
                            html += ' <div class="row">';
                            html += ' <div class="col-12" style="text-align:right;">';
                            html += ' <span style="font-size:20px;cursor:pointer;color:green;" onclick="Editstudent(' + studentid + ');"><i class="fa fa-pencil-square-o"></i></span>&nbsp;';
                            html += ' <span style="font-size:20px;cursor:pointer;color:red;"  onclick="Deletestudent(' + studentid + ');"><i class="fa fa-trash-o"></i></span>';
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
                            html += ' <div style="margin-top:5px;">ชื่อ - นามสกุล</div>';
                            html += ' </div>';
                            html += ' <div class="col-7">';
                            html += ' <span id="Spname">' + response.d[i]['Titlenameth'] + ' ' + response.d[i]['Firstname'] + ' ' + response.d[i]['Lastname'] + '</span>';
                            html += ' </div>';
                            html += ' </div>';
                            html += ' <div class="row mt-1">';
                            html += ' <div class="col-5">';
                            html += ' <div style="margin-top:5px;">ชั้นปี</div>';
                            html += ' </div>';
                            html += ' <div class="col-7">';
                            html += ' <span id="Spemail">' + response.d[i]['Class'] + '</span>';
                            html += ' </div>';
                            html += ' </div>';
                            html += ' <div class="row mt-1">';
                            html += ' <div class="col-5">';
                            html += ' <div style="margin-top:5px;">เกรดเฉลี่ยสะสม</div>';
                            html += ' </div>';
                            html += ' <div class="col-7">';

                            
                            if (response.d[i]['GPAX'] != '') {
                                html += ' <span id="Sptel">' + response.d[i]['GPAX'] + '</span>';
                            }
                            else {
                                html += ' <span id="Sptel">' + 'ยังไม่มีการประมวลผลเกรด' + '</span>';
                            }
                            html += ' </div>';
                            html += ' <div class="col-12">';
                            html += ' <hr>';
                            html += ' </div>';
                            html += ' <div class="col-12" style=""text-align:center;>';
                            html += ' <div style="min-height:50px;" >';
                            html += ' </div>';
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

                    $('#Divstudents').html(html);
                },
                async: false,
                error: function (er) {
                    Msgbox(er.Marystatus);
                }
            });

        }
        function PostDelete(ctrl, dat) {
            if (ctrl == 'Gvaddwithdraw') {
                Searchmystudent();
            }

        }
        function Searchsubject(x) {

            ClearResource('REG/Mystudent.aspx', 'Gvsearchsubject');
            var Cri = x;
            var Columns = ["รหัสวิชา!L", "ชื่อวิชา!L", "หน่วยกิต!L"];
            var Data = ["Subjectcode", "Subjectname", "Credit"];
            var Searchcolumns = ["รหัสวิชา", "ชื่อวิชา", "หน่วยกิต"];
            var SearchesDat = ["Subjectcode", "Subjectname", "Credit"];
            var Width = ["20%", "60%", "20%"];
            var Gvsearchsubject = new Grid("REG/Mystudent.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchsubject', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divsubjectcont').html(Gvsearchsubject._Tables());
            Gvsearchsubject._Bind();
        }
        function RowSelect(ctrl, x) {

            if (ctrl == "Gvsearchsubject") {
                Selectedsubject(x);
            }
        }
        function Selectedsubject(x) {
            var json = 'subjectid :' + x + '|';
            json += 'Hdregsubjectid:' + $('#Hdregsubjectid').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/mystudent.aspx/Selectedsubject",
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
                    $('#Divsubject').modal('hide');
                    Searchmystudent();
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Custom(Ctrl, Panel) {

            if (Ctrl == 'Gvaddwithdraw') {
                $('#Divsubject').modal('show');
                Searchsubject($('#Hdregsubjectid').val());
            }
        }
        function Getstudent(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/REG/mystudent.aspx/Getstudent",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbmystudent').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbmystudent').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบนักศึกษา'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbmystudent').append($('<option/>', {
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
        function Bindaddwithdraw(x) {
            var Cri = x;
            $('#Hdregsubjectid').val(x);

            ClearResource('REG/Mystudent.aspx', 'Gvaddwithdraw');
            var Columns = ["รหัสวิชา!L", "ชื่อวิชา!L", "หน่วยกิต!L"];
            var Data = ["Subjectcode", "Subjectname", "Credit"];
            var Searchcolumns = [];
            var SearchesDat = [];
            var Width = ["10%", "70%", "10%"];
            var Gvaddwithdraw = new Grid("REG/Mystudent.aspx", Columns, SearchesDat, Searchcolumns, 'Gvaddwithdraw', 30, Width, Data, "", '', '', 'ลงทะเบียนเพิ่ม', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divgvaddwithdraw').html(Gvaddwithdraw._Tables());
            Gvaddwithdraw._Bind();
        }
        function Searchmystudent() {
            var json = '';
            json += 'Cbmystudentyearno:' + $('#Cbmystudentyearno').val() + '|';
            json += 'Cbmystudent:' + $('#Cbmystudent').val() + '|';
            json += 'Cbmystudentclass:' + $('#Cbmystudentclass').val() + '|';
            json += 'Cbmystudentterm:' + $('#Cbmystudentterm').val() + '|';
            json += 'Cbmystudentcourse:' + $('#Cbmystudentcourse').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Mystudent.aspx/Searchmystudent",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    if (res == '-1') {
                        
                        $('#Divgvaddwithdraw').html('<div style="margin-top:20px;padding-top:50px;color:red;text-align:center;height:200px;border:1px solid lightgray;">ได้มีการคำนวณเกรดเฉลี่ยสะสมไปแล้ว ไม่สามารถเพิ่ม/ลดรายวิชาได้</div>');
                    }
                    else {
                        Bindaddwithdraw(res);
                    }
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function doConfirmpayment() {
            var json = '';
         
            json += 'Txtreceiptno:' + $('#Txtreceiptno').val() + '|';
            json += 'Hdpayment:' + $('#Hdpayment').val() + '|';
            
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Mystudent.aspx/doConfirmpayment",
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
                    Searchpayment();
                    $('#Divconfirmpayment').modal('hide');
                    
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Confirmpayment(x) {
            $("#Hdpayment").val(x);
            $('#Divconfirmpayment').modal('show');
        }
        function Binddebt() {
            var json = '';
            var Cri = $('#Hdstudentid').val();

            ClearResource('REG/Mystudent.aspx', 'Gvdebt');
            var Columns = ["ปีการศึกษา!L", "หลักสูตร!L", "ชั้นปี!L", "ภาคที่!L", "รหัสนักศึกษา", "ชื่อ", "นามสกุล", "จำนวนเงิน!R"];
            var Data = ["Year", "Coursename", "Class", "Term", "Studentno", "Firstname", "Lastname", "Amount"];
            var Searchcolumns = [];
            var SearchesDat = [];
            var Width = ["10%", "30%", "5%", "5%", "10%", "10%", "10%", "10%"];
            var Gvdebt = new Grid("REG/Mystudent.aspx", Columns, SearchesDat, Searchcolumns, 'Gvdebt', 100, Width, Data, "", '', '', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divdebt').html(Gvdebt._Tables());
            Gvdebt._Bind();
        }
        function Searchpayment() {
            var json = '';
            var Cri = $('#Txtpaymentsearch').val();
 
            ClearResource('REG/Mystudent.aspx', 'Gvpayment');
            var Columns = ["ปีการศึกษา!L", "หลักสูตร!L", "ชั้นปี!L", "ภาคที่!L","รหัสนักศึกษา","ชื่อ","นามสกุล", "จำนวนเงิน!R",""];
            var Data = ["Year", "Coursename", "Class","Term","Studentno","Firstname","Lastname","Amount","Ctrl"];
            var Searchcolumns = [];
            var SearchesDat = [];
            var Width = ["10%", "20%", "5%", "5%", "10%", "10%", "10%", "10%", "10%"];
            var Gvpayment = new Grid("REG/Mystudent.aspx", Columns, SearchesDat, Searchcolumns, 'Gvpayment', 100, Width, Data, "", '', '', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divpaymentcont').html(Gvpayment._Tables());
            Gvpayment._Bind();
        }

        function Getstudentcourse() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/mystudent.aspx/Getcourse",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbstudentcourse').find('option').remove().end();
                    $('#Cbprofilecourse').find('option').remove().end();
                    
                    if (res.length == 0) {
                        $('#Cbstudentcourse').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                        $('#Cbprofilecourse').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbstudentcourse').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofilecourse').append($('<option/>', {
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
        function Getregisterquota() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/mystudent.aspx/Getregisterquota",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbstudentregisterquota').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbstudentregisterquota').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบข้อมูล'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbstudentregisterquota').append($('<option/>', {
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
        function Getregistertype() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/mystudent.aspx/Getregistertype",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbstudentregistertype').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbstudentregistertype').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบข้อมูล'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbstudentregistertype').append($('<option/>', {
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
        function Getmystudentcourse() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/mystudent.aspx/Getcourse",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbmystudentcourse').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbmystudentcourse').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbmystudentcourse').append($('<option/>', {
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
                url: "\../Page/REG/mystudent.aspx/Getterm",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbmystudentterm').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbmystudentterm').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbmystudentterm').append($('<option/>', {
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
                url: "\../Page/REG/mystudent.aspx/Getclass",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbmystudentclass').find('option').remove().end();
                    $('#Cbprofileclass').find('option').remove().end();
                    if (res.length == 0) {
                        $('#Cbprofileclass').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                        $('#Cbmystudentclass').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
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
                            $('#Cbmystudentclass').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                        }
                    }

                    $('#Cbmystudentclass').on('change', function () {
                        Getstudent($('#Cbmystudentclass').val());
                    });
                    Getstudent($('#Cbmystudentclass').val());
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
                url: "\../Page/REG/mystudent.aspx/Getyear",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#Cbmystudentyearno').find('option').remove().end();

                    if (res.length == 0) {
                        $('#Cbmystudentyearno').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbmystudentyearno').append($('<option/>', {
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
        $(document).ready(function () {

            My();
        });
        function My() {
            $('#Divpayment').hide();
            $('#Divaddwithdraw').hide();
            $('#Divstudentprofile').hide();
            $('#Divstudent').show();
            students();

        }
        function Addwithdraw() {

            $('#Divpayment').hide();
            $('#Divstudent').hide();
            $('#Divstudentprofile').hide();
            $('#Divaddwithdraw').show();
            Getclass();
            Getmystudentcourse();
            Getterm();
            Getyear();
            Searchmystudent();
        }
        function Addstudent() {
            Getregistertype();
            Getregisterquota();
            Getstudentcourse();
            $('#Divnewstudent').modal('show');
        }
        function Validatestudentno() {
            var json = $('#Txtstudentno').val();
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Mystudent.aspx/Validatestudentno",
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
                    Msgbox('รหัสนักศึกษา นี้ว่าง สามารถใช้งานได้');
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
                url: "\../Page/REG/Mystudent.aspx/Getprovince",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    
                    $('#Cbprofileprovince').find('option').remove().end();
                    $('#Cbprofilefundprovince').find('option').remove().end();
                    if (res.length == 0) {

                        $('#Cbprofileprovince').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                        $('#Cbprofilefundprovince').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#Cbprofileprovince').append($('<option/>', {
                                value: res[i]["Val"],
                                text: res[i]["Name"]
                            }));
                            $('#Cbprofilefundprovince').append($('<option/>', {
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
        function Getprovincebyctrl(x) {

            var json = '';
            var ctrls = x.split("|");
            var i = 0;
            var j = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Mystudent.aspx/Getprovince",
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
                url: "\../Page/REG/Mystudent.aspx/Getpostcode",
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
                url: "\../Page/REG/Mystudent.aspx/Getsubdistrict",
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
                url: "\../Page/REG/Mystudent.aspx/Getdistrict",
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
        function Getaddress() {
            var i = 0;
            var html = '';
            var res;
            var json = $('#Hdstudentid').val();
            var ctrlprovince = '';
            $.ajax({
                type: "POST",
                url: "\../Page/REG/Mystudent.aspx/Getaddress",
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
        $(function () {
            $("#Dtpprofilebirthdate").datepicker({
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
    <div class="container-fluid" style="font-family: TH SarabunPSK; background-color: white;color:black; padding: 10px; width: 100%; margin-top: 20px;min-height:800px;">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav" style="color: black !important; font-family: TH SarabunPSK;">
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="My();">ข้อมูลนักศึกษา</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="Payment();">ชำระค่าลงทะเบียนเรียน</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="Addwithdraw();">เพิ่ม/ถอน รายวิชาลงทะเบียน</a>
                    </li>


                </ul>
            </div>
        </nav>
        <div id="Divstudentprofile" style="display: none; color: black; margin-top: 50px;">
            <input type="hidden" id="Hdstudentid" value="" />
            <ul class="nav nav-tabs" style="margin: 20px;">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#menu1">ข้อมูลทั่วไป</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu2">ข้อมูลส่วนตัว</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu3">ข้อมูลที่ติดต่อ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu4">หนี้สิน</a>
                </li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">

                <div id="menu1" class="container tab-pane active">
                    <div class="container">
                         
                        <div class="row mt-3">
                            <div class="col-3">
                                <button class="btn btn-secondary" onclick="Save('1');" style="position:absolute;bottom:5px; font-family:TH SarabunPSK;font-size:13px;border-radius:1px;">บันทึก</button>
                            </div>
                            <div class="col-9" style="text-align:right;">
                                
                                <img src="https://iconorbit.com/icons/256-watermark/1611201511254916681-Boy%20Student.jpg"  style="cursor:pointer; width:100px;margin-top:10px;border:solid 1px lightgray;border-radius:4px;" />
                                <div style="font-size:12px;margin-top:5px;">กดที่รูปเพื่อ Upload</div>
                            </div>
                        </div>
                          <div class="row mt-3">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        
                       <div class="row mt-3">
                            <div class="col-2">
                                &nbsp;
                            </div>
                            <div class="col-4">
                               &nbsp;
                            </div>
                            <div class="col-2">
                                GPAX
                            </div>
                            <div class="col-4">
                                <input type="text" class="form-control" id="TxtprofileGPAX" readonly="readonly" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-2">
                                รหัสนักศึกษา
                            </div>
                            <div class="col-4">
                                <input type="text" class="form-control" id="Txtprofilestudentno" readonly="readonly" />
                            </div>
                            <div class="col-2">
                                ชั้นปีที่
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofileclass">
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-2">
                                ชื่อ-นามสกุล
                            </div>
                            <div class="col-4">
                                <div class="input-group mb-2">
                                    <select class="form-control" id="Cbprofiletitle">
                                    </select>
                                    <input type="text" class="form-control" id="Txtprofilefirstname" />
                                    <input type="text" class="form-control" id="Txtprofilelastname" />
                                </div>
                            </div>
                            <div class="col-2">
                                สถานะนักศึกษา
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofilestudentstatus">
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-2">
                                ระดับการศึกษา
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofiledegree">
                                </select>
                            </div>
                            <div class="col-2">
                                วุฒิการศึกษา
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofileeducation">
                                </select>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-2">
                                หลักสูตร
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofilecourse">
                                </select>
                            </div>
                            <div class="col-2">
                                ภาค/ปีการศึกษาที่เข้า
                            </div>
                            <div class="col-4">
                                <input type="text" id="Txtprofileyear" class="form-control" />
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-2">
                                ทุนจังหวัด
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofilefundprovince">
                                </select>
                            </div>
                            <div class="col-2">
                                เจ้าของทุน
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofilefunding">
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-2">
                                ประเภทุน
                            </div>
                            <div class="col-10">
                                <select class="form-control" id="Cbprofilefundtype">
                                </select>
                            </div>

                        </div>
                    </div>
                </div>

                <div id="menu2" class="container tab-pane">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-12">
                               
                                <button class="btn btn-secondary" onclick="Save('2');" style="font-family:TH SarabunPSK;font-size:13px;border-radius:1px;">บันทึก</button>
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
                            <div class="col-10">
                                <input type="text" class="form-control" id="Txtprofilecardid" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-2">
                                ชื่อ-นามสกุล (อังกฤษ)
                            </div>
                            <div class="col-4">
                                <div class="input-group mb-2">
                                   <input type="text" class="form-control" id="TxtprofiletitleEN" readonly="readonly" />
                                    <input type="text" class="form-control" id="TxtprofilefirstnameEN" />
                                    <input type="text" class="form-control" id="TxtprofilelastnameEN" />
                                </div>
                            </div>
                            <div class="col-2">
                                วันเกิด
                            </div>
                            <div class="col-4">
                                <div id="Dtpprofilebirthdate" class="input-group date" style="width: 200px;" data-date-format="mm-dd-yyyy">
                                    <input id="Txtprofilebirthdate" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-2">
                                หมู่เลือด
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofileblood">
                                </select>
                            </div>
                            <div class="col-2">
                                เพศ
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofilegender">
                                </select>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-2">
                                สถานะสมรส
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofilemarystatus">
                                </select>
                            </div>
                            <div class="col-2">
                                สัญชาติ
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofilenation">
                                </select>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-2">
                                ศาสนา
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofilereligion">
                                </select>
                            </div>
                            <div class="col-2">
                                เชื้อชาติ
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofilerace">
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-2">
                                น้ำหนัก
                            </div>
                            <div class="col-4">
                                <input type="text" class="form-control" id="Txtprofileweight" />
                            </div>
                            <div class="col-2">
                                ส่วนสูง
                            </div>
                            <div class="col-4">
                                <input type="text" class="form-control" id="Txtprofileheight" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-2">
                                ประเทศที่เกิด
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofilecountry">
                                </select>
                            </div>
                            <div class="col-2">
                                จังหวัดที่เกิด
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofileprovince">
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-2">
                                สถานะทหาร
                            </div>
                            <div class="col-4">
                                <select class="form-control" id="Cbprofileismilitarystate">
                                    <option value="True">ผ่านการเกณฑ์ทหาร</option>
                                     <option value="False">ไม่ผ่านการเกณฑ์ทหาร</option>
                                </select>
                            </div>
                            <div class="col-2">
                                วุฒิการศึกษาก่อนรับเข้า
                            </div>
                            <div class="col-4">
                                <input type="text" class="form-control" id="Txtpreveducation" />
                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu3" class="container tab-pane">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-12">
                               
                                <button class="btn btn-secondary" onclick="Save('3');" style="font-family:TH SarabunPSK;font-size:13px;border-radius:1px;">บันทึก</button>
                            </div>
                        </div>
                         <div class="row mt-3">
                            <div class="col-12">
                               
                                <hr />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div id="Divaddress"></div>
                            </div>
                        </div>
                    </div>

                </div>

                 <div id="menu4" class="container tab-pane">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-12">
                                <div id="Divdebt"></div>
                            </div>
                        </div>
                    </div>

                </div>
                
            </div>

        </div>
        <div id="Divaddwithdraw" style="display: none; margin-top: 30px;">
            <div class="container">
                <input type="hidden" id="Hdregsubjectid" value="" />
                <div class="row">
                    <div class="form-group">
                        <div class="input-group mb-2">
                            <span style="margin: 10px;">ปีการศึกษา</span><select style="margin: 10px; width: 80px;" class="form-control" id="Cbmystudentyearno"></select>
                            <span style="margin: 10px;">ภาค</span><select style="margin: 10px; width: 80px;" class="form-control" id="Cbmystudentterm"></select>
                            <span style="margin: 10px;">ชั้นปี</span><select style="margin: 10px; width: 80px;" class="form-control" id="Cbmystudentclass"></select>
                            <span style="margin: 10px;">หลักสูตร</span><select style="margin: 10px; width: 200px;" class="form-control" id="Cbmystudentcourse"></select>
                            <span style="margin: 10px;">นักศึกษา </span>
                            <select style="margin: 10px; width: 200px;" class="form-control" id="Cbmystudent"></select>
                            <button style="margin: 10px;font-size:13px;font-family:TH SarabunPSK;border-radius:1px;" class="btn btn-info" onclick="Searchmystudent();"><span>ค้นหา</span></button>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <hr />
                    </div>
                </div>
                <div class="row">
                    <div id="Divgvaddwithdraw" class="col-12">
                    </div>
                </div>
            </div>
        </div>
              <div id="Divpayment" style="display: none; margin-top: 30px;">
            <div class="container">
                <div class="row">
                    <div class="col-6">
                        &nbsp;
                    </div>
                     <div class="col-6" style="text-align:right;">
                    <div class="form-group">
                        <div class="input-group mb-3">
                            <span style="margin-top:5px;">นักศึกษาที่ต้องการชำระเงิน</span>&nbsp;
                            <input id="Txtpaymentsearch" type="text" class="form-control" placeholder="รหัสนักศึกษา,ชื่อ-นามสกุล" style="width: 100px; border-radius: 1px; font-size: 14px;"/>
                            <div class="input-group-append">
                                <button onclick="Searchpayment();" class="btn btn-info" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                         </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <hr />
                    </div>
                </div>
                <div class="row">
                    <div id="Divpaymentcont" class="col-12">
                    </div>
                </div>
            </div>
        </div>
        <div id="Divstudent" style="display: block; margin-top: 50px; color: black;">
            <div class="container-fluid" style="font-family: TH SarabunPSK; background-color: white; padding: 10px; width: 95%; min-height: 800px;">
                <div class="row">
                    <div class="col-9">
                        <button class="btn btn-secondary" onclick="Addstudent();" style="margin: 10px; border-radius: 2px;"><span style="font-size: 13px; color: white;">เพิ่มนักศึกษาใหม่</span></button>
                    </div>
                    <div class="col-3">
                        <div class="input-group mb-3">
                            <input id="Txtstudentsearch" type="text" class="form-control" placeholder="รหัสนักศึกษา,ชื่อ-นามสกุล" style="width: 100px; border-radius: 1px; font-size: 14px;" />
                            <div class="input-group-append">
                                <button id="Cmdsearch" class="btn btn-info" type="button">
                                    <i class="fa fa-search" style="font-size:12px;"></i>
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
                <div class="row" id="Divstudents" style="padding: 30px;">
                </div>
            </div>


        </div>
        <div class="modal" id="Divsubject" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span>รายวิชา</span>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="container" id="Divsubjectcont" style="border: solid 1px lightgray; margin-right: 10px; min-height: 320px; width: 100%; padding: 8px;">
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                    </div>

                </div>
            </div>
        </div>
         <div class="modal fade bd-example-modal-lg" id="Divconfirmpayment" tabindex="-1" role="dialog" style="z-index: 99999;" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-ku" role="document">

                <div class="modal-content" style="width: 500px;">
                    <div class="modal-header" style="background-color: #82c2f3;">
                        <span style="color: white; font-size: 13px;">E-OFFICE สถาบันพระบรมราชชนก </span>
                    </div>
                    <div class="modal-body">
                        <div class="container" style="font-size: 14px; margin-top: 20px;">
                            <div class="row mt-3">
                                <div class="col-3" style="text-align: right;">
                                    เลขที่ใบเสร็จ&nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <div class="input-group mb-3">
                                        <input style="font-size: 14px;" type="email" id="Txtreceiptno" autocomplete="off" class="form-control" placeholder="เลขที่ใบเสร็จ" />
                                       
                                    </div>
                                    <div class="invalid-feedback">
                                        โปรดระบุ เลขที่ใบเสร็จ
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="min-height: 50px; margin-top: 10%; font-size: 13px;"></div>
                    <div class="modal-footer">
                        <button type="button" onclick="doConfirmpayment();" class="btn btn-primary" style="border-radius: 2px; font-size: 13px;">ยืนยันการชำระเงิน</button>
                        <button type="button" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;" data-dismiss="modal">ปิดหน้าต่างนี้</button>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" id="Hdpayment" value="" />
        <div class="modal fade bd-example-modal-lg" id="Divnewstudent" tabindex="-1" role="dialog" style="z-index: 99999;" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-ku" role="document">

                <div class="modal-content" style="width: 500px;">
                    <div class="modal-header" style="background-color: #82c2f3;">
                        <span style="color: white; font-size: 13px;">E-OFFICE สถาบันพระบรมราชชนก </span>
                    </div>
                    <div class="modal-body">
                        <div class="container" style="font-size: 14px; margin-top: 20px;">
                            <div class="row mt-3">
                                <div class="col-3" style="text-align: right;">
                                    รหัสนักศึกษา&nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <div class="input-group mb-3">
                                        <input style="font-size: 14px;" type="email" id="Txtstudentno" autocomplete="off" class="form-control" placeholder="รหัสนักศึกษา" />
                                        <div class="input-group-append">
                                            <button type="button" onclick="Validatestudentno();" class="btn btn-info" style="border-radius: 2px; font-size: 14px; width: 100%;"><i class="fa fa-key" aria-hidden="true"></i></button>
                                        </div>
                                    </div>
                                    <div class="invalid-feedback">
                                        โปรดระบุ รหัสนักศึกษา
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-3" style="text-align: right;">
                                    ชื่อ &nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <div class="form-group" style="text-align: left;">
                                        <input type="text" id="Txtfirstname" autocomplete="off" class="form-control" placeholder="ชื่อ" />
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
                                        <input type="text" id="Txtlastname" autocomplete="off" class="form-control" placeholder="นามสกุล" />
                                        <div class="invalid-feedback">
                                            โปรดระบุ นามสกุล
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="row mt-3">
                                <div class="col-3" style="text-align: right;">
                                    หลักสูตรที่สมัครเรียน &nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <select class="form-control" id="Cbstudentcourse">
                                    </select>
                                </div>

                            </div>
                            <div class="row mt-3">
                                <div class="col-3" style="text-align: right;">
                                    ประเภทการรับ &nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <select class="form-control" id="Cbstudentregistertype">
                                    </select>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-3" style="text-align: right;">
                                    โควตา &nbsp;<span style="color: red;">*</span>
                                </div>
                                <div class="col-9">
                                    <select class="form-control" id="Cbstudentregisterquota">
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="min-height: 50px; margin-top: 10%; font-size: 13px;"></div>
                    <div class="modal-footer">
                        <button type="button" onclick="Savenewstudent();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">บันทึกนักศึกษาใหม่</button>
                        <button type="button" class="btn btn-danger" style="border-radius: 2px; font-size: 13px;" data-dismiss="modal">ปิดหน้าต่างนี้</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
