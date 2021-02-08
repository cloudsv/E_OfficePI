<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OfficialVisit.aspx.cs" Inherits="E_OfficePI.Page.HR.OfficialVisit" %>

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
        function Print(id) {

            var json = id;
            $.ajax({
                type: "POST",
                url: "\../Page/HR/OfficialVisit.aspx/Print",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d != '') {
                        w = 600;
                        h = 400;
                        var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
                        var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
                        var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
                        var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;
                        var left = ((width / 2) - (w / 2)) + dualScreenLeft;
                        var top = ((height / 2) - (h / 2)) + dualScreenTop;
                        window.open("/../../Printforms/PrintformCaller.aspx?Val=" + response.d, '');
                    }
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
        function CallBackUpload(Label, Running) {
            $.ajax({
                type: "POST",
                url: "\../Page/HR/OfficialVisit.aspx/CallBackUpload",
                data: "{'Label' : '" + Label + "','Running' :'" + Running + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('#Txtattachment').val(response.d);
                    $('#Txtattachment').attr('data-value', Running);
                    
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
            json += 'Hdofficialvisitid :' + $('#Hdofficialvisitid').val() + "|";
            $.ajax({
                type: "POST",
                url: This + "/Savecost",
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
        function Del(id) {
            $("#DivConfirm").modal('show');
            $('#DivConfirmMsg').html('ต้องการที่จะลบการตั้งเรื่องไปช่วยราชการ ?');
            $('#CmdConfirm').on('click', function () {
                json = id;
                $.ajax({
                    type: "POST",
                    url: "\../Page/HR/officialvisit.aspx/Del",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                        $("#DivConfirm").modal('hide');
                        Bindofficialvisit();
                    },
                    async: false,
                    error: function (er) {
                        Msgboxsuccess(er.Marystatus);
                    }
                });
            });
        }
        function Detail(id) {
            var json = '';
            var html = '';
            var i = 0;
            $('#Hdofficialvisitid').val(id);
            $.ajax({
                type: "POST",
                url: "\../Page/HR/officialvisit.aspx/Detail",
                data: "{'json' :'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    $('#Divcost').modal('show');
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
        function Getrequest() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/officialvisit.aspx/Getrequest",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    $('#TxtRequestfullname').val(response.d);
                    
                },
                async: false,
                error: function (er) {
                }
            });
        }
        function Save() {
            var json = '';
            $("#Divnewofficialvisit").find('textarea').each(function () {
                    json += $(this).attr('id') + ':' + $(this).val() + "|";
                
            });
            $("#Divnewofficialvisit").find('select').each(function () {

                json += $(this).attr('id') + ':' + $(this).val() + "|";

            });
            $("#Divnewofficialvisit").find('input[type = text]').each(function () {

                json += $(this).attr('id') + ':' + $(this).val() + "|";

            });
            $("#Divnewofficialvisit").find('input[type = checkbox]').each(function () {

                json += $(this).attr('id') + ':' + $(this).prop('checked') + "|";

            });
            json += 'Txtattachmentcont:' + $('#Txtattachment').attr('data-value') + "|";
            $.ajax({
                type: "POST",
                url: This + "/Save",
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
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    $('#Divnewofficialvisit').modal('hide');
                    Bindofficialvisit();
                },
                async: false,
                error: function (er) {
                    Msgbox(er.status);
                }
            });
        }
        function Getofficialvisittype() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/officialvisit.aspx/Getofficialvisittype",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#CbOfficialvisittypeid').find('option').remove().end();

                    if (res.length == 0) {
                        $('#CbOfficialvisittypeid').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบข้อมูล'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbOfficialvisittypeid').append($('<option/>', {
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
        function Getorg() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/officialvisit.aspx/Getorg",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#CbProjectownerorgid').find('option').remove().end();

                    if (res.length == 0) {
                        $('#CbProjectownerorgid').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบข้อมูล'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbProjectownerorgid').append($('<option/>', {
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
        function Getvehicletype() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/officialvisit.aspx/Getvehicletype",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#CbVehicletypeid').find('option').remove().end();

                    if (res.length == 0) {
                        $('#CbVehicletypeid').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบข้อมูล'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbVehicletypeid').append($('<option/>', {
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
        function Getdeveloptype() {
            var json = '';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/officialvisit.aspx/Getdeveloptype",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#CbDeveloptypeid').find('option').remove().end();

                    if (res.length == 0) {
                        $('#CbDeveloptypeid').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบข้อมูล'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbDeveloptypeid').append($('<option/>', {
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
                url: "\../Page/HR/officialvisit.aspx/Getcountry",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#CbCountryid').find('option').remove().end();

                    if (res.length == 0) {
                        $('#CbCountryid').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbCountryid').append($('<option/>', {
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
                url: "\../Page/HR/officialvisit.aspx/Getprovince",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    res = response.d;
                    $('#CbProvinceid').find('option').remove().end();

                    if (res.length == 0) {
                        $('#CbProvinceid').append($('<option/>', {
                            value: '',
                            text: 'ไม่พบหลักสูตร'
                        }));
                    }
                    else {
                        for (i = 0; i < res.length; i++) {
                            $('#CbProvinceid').append($('<option/>', {
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
        function Newofficialvisit() {
            Getrequest();
            Getorg();
            Getprovince();
            Getcountry();
            Getvehicletype();
            Getofficialvisittype();
            Getdeveloptype();
            Getofficialvisittype();
            $('#Divnewofficialvisit').modal('show');
        }
        function officialvisit() {

            $('#Divofficialvisit').show();
            Bindofficialvisit();
        }
        function Bindofficialvisit() {

            ClearResource('HR/officialvisit.aspx', 'Gvofficialvisit');
            var Cri = $('#Hdofficialvisitid').val();
            var Columns = ["เลขที่เอกสาร!L", "วันที่ออกเอกสาร!L", "เรื่อง!L", "ไปราชการ!L", "สถานที่!L", "ค่าใช้จ่าย!C", "!C", "!C"];
            var Data = ["Docno", "Documentdate", "offcialvisitname", "duration", "Place", "Detail", "Del", "Print"];
            var Searchcolumns = ["offcialvisitname"];
            var SearchesDat = ["offcialvisitname"];
            var Width = ["10%", "10%", "20%", "20%", "15%", "10%", "5%", "5%"];
            var Gv = new Grid("HR/officialvisit.aspx", Columns, SearchesDat, Searchcolumns, 'Gvofficialvisit', 30, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divofficialvisitcont').html(Gv._Tables());
            Gv._Bind();
        }
        $(function () {
            $("#TxtDocumentdate").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            $("#TxtWorkstart").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            $("#TxtWorkend").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });


            $("#TxtTravelstart").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            $("#TxtTravelend").datepicker({
                format: "dd/mm/yyyy",
                todayBtn: "linked",
                language: "th",
                forceParse: false,
                autoclose: true,
                todayHighlight: true
            });

            officialvisit();
        })

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
                        <a class="nav-link" href="#" onclick="officialvisit();">การไปราชการ</a>
                    </li>
                </ul>
            </div>
        </nav>
        <div id="Divofficialvisit" style="display: none;">

            <div class="container">
                <div class="row mt-3">
                    <div class="col-12">
                        <button class="btn btn-secondary" onclick="Newofficialvisit();">เพิ่มการไปราชการ</button>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <div id="Divofficialvisitcont">
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>
    <div class="modal fade" id="Divcost" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header" >
                    <span>รายละเอียดค่าใช้จ่าย</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container-fluid">
                       
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                       </div>
                          <div class="row mt-1">
                            <div class="col-12">
                               <div id="Divcostcont">

                               </div>
                            </div>
                        </div>
                        <!-- Modal footer -->
                        <div class="modal-footer">
                           <button type="button" class="btn btn-info" style="font-size: 18px; border-radius: 0;" onclick="Savecost();" >บันทึก</button>
                            &nbsp;
                            <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>




      <div class="modal fade bd-example-modal-xl"  id="Divnewofficialvisit" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header"  style="margin-left:100px;">
                    <span>ไปราชการ</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body"  style="margin-left:100px;">
                    <div class="container-fluid">
                       
                     
                        <div class="row mt-1">
                            <div class="col-9"  style="text-align:right;">
                               <span>ไฟล์ต้นเรื่อง</span>
                            </div>
                            <div class="col-3">
                                <input type="text" class="form-control" id="Txtattachment" data-value="" value="" readonly="readonly" />
                                <button type="button" class="btn btn-warning" style="font-size: 18px;width:100%;margin-top:5px; border-radius: 0;" onclick="Doupload();" >นำเข้าเอกสาร</button>
                            </div>
                        </div>
                         <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                                </div>
                             </div>

                        <div class="row mt-1">
                            <div class="col-9"  style="text-align:right;">
                               <span>เลขที่หนังสือ</span>
                            </div>
                            <div class="col-3">
                                <input type="text" class="form-control" id="TxtDocno" data-value="" value=""  />
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-9" style="text-align:right;">
                               <span>วันที่</span>
                            </div>
                            <div class="col-3">
                                 <div id="DtpDocumentdate" class="input-group date" data-date-format="mm-dd-yyyy">
                                        <input id="TxtDocumentdate" class="form-control" type="text" />
                                        <button>
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </button>
                                </div>
                            </div>
                        </div>

                         <div class="row mt-1">
                            <div class="col-2"  style="text-align:right;">
                               <span>ผู้ขออนุมัติ</span>
                            </div>
                            <div class="col-10">
                                <input type="text" class="form-control" id="TxtRequestfullname" data-value="" value=""  readonly="readonly" />
                            </div>
                        </div>
                         <div class="row mt-1">
                            <div class="col-2"  style="text-align:right;">
                               <span>เรื่องไปราชการ</span>
                            </div>
                            <div class="col-10">
                                <input type="text" class="form-control" id="TxtOffcialvisitname" data-value="" value=""   />
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-2"  style="text-align:right;">
                               <span>วันที่ไปราชการ</span>
                            </div>
                            <div class="col-5">
                               <div id="DtpWorkstart" class="input-group date" data-date-format="mm-dd-yyyy">
                                        <input id="TxtWorkstart" class="form-control" type="text" />
                                        <button>
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </button>
                                </div>
                            </div>
                                 <div class="col-2"  style="text-align:right;">
                               <span>ถึง</span>
                            </div>
                            <div class="col-3">
                               <div id="DtpWorkend" class="input-group date" data-date-format="mm-dd-yyyy">
                                        <input id="TxtWorkend" class="form-control" type="text" />
                                        <button>
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </button>
                                </div>
                            </div>
                        </div>

                         <div class="row mt-1">
                            <div class="col-2"  style="text-align:right;">
                               <span>วันที่เดินทาง</span>
                            </div>
                            <div class="col-5">
                               <div id="DtpTravelstart" class="input-group date" data-date-format="mm-dd-yyyy">
                                        <input id="TxtTravelstart" class="form-control" type="text" />
                                        <button>
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </button>
                                </div>
                            </div>
                                 <div class="col-2"  style="text-align:right;">
                               <span>ถึง</span>
                            </div>
                            <div class="col-3">
                               <div id="DtpTravelend" class="input-group date" data-date-format="mm-dd-yyyy">
                                        <input id="TxtTravelend" class="form-control" type="text" />
                                        <button>
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </button>
                                </div>
                            </div>
                        </div>

                         <div class="row mt-1">
                            <div class="col-2"  style="text-align:right;">
                               <span>สถานที่</span>
                            </div>
                            <div class="col-10">
                                <input type="text" class="form-control" id="TxtPlace"  value=""  />
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-2"  style="text-align:right;">
                               <span>จังหวัด</span>
                            </div>
                            <div class="col-10">
                                <select class="form-control" id="CbProvinceid"></select>
                            </div>
                        </div>
                         <div class="row mt-1">
                            <div class="col-2"  style="text-align:right;">
                               <span>ประเทศ</span>
                            </div>
                            <div class="col-10">
                                <select class="form-control" id="CbCountryid"></select>
                            </div>
                        </div>
                         <div class="row mt-1">
                         <div class="col-2"  style="text-align:right;">
                               <span>หน่วยงานที่จัด</span>
                            </div>
                            <div class="col-10">
                                <select class="form-control" id="CbProjectownerorgid"></select>
                            </div>
 </div>
                        <div class="row mt-1">
                            <div class="col-2"  style="text-align:right;">
                               <span>ผู้จัด/โครงการ</span>
                            </div>
                            <div class="col-5">
                                <input type="text" class="form-control" id="TxtProjectowner"  value=""  />
                            </div>
                             <div class="col-2"  style="text-align:right;">
                               <span>ประเภทการไปราชการ</span>
                            </div>
                            <div class="col-3">
                                <select class="form-control" id="CbOfficialvisittypeid"></select>
                            </div>
                            
                        </div>
                         <div class="row mt-1">
                            <div class="col-2"  style="text-align:right;">
                               <span>ประเภทการพัฒนา</span>
                            </div>
                            <div class="col-5">
                                  <select class="form-control" id="CbDeveloptypeid"></select>
                            </div>
                             <div class="col-2"  style="text-align:right;">
                               <span>พาหนะ</span>
                            </div>
                            <div class="col-3">
                                <select class="form-control" id="CbVehicletypeid"></select>
                            </div>
                        </div>
                        <!-- Modal footer -->
                        <div class="modal-footer">
                           <button type="button" class="btn btn-info" style="font-size: 18px; border-radius: 0;" onclick="Save();" >บันทึก</button>
                            &nbsp;
                            <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <input type="hidden" id="Hdofficialvisitid" value="" />
</body>
</html>

