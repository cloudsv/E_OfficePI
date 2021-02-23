<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MasterPreInstructor.aspx.cs" Inherits="E_OfficePI.Page.TQF.MasterPreInstructor" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
<%--    <script src="../../js/datepicker/bootstrap-datepicker.js"></script>--%>
    <link href="../../js/datepicker/datepicker.css" rel="stylesheet" />
    <script>
        function Savetitle(Attachmentid,x) {
            var json = '';
            json = 'val:' + $('#' + x).val() + '|';
            json += 'Attachmentid:' + Attachmentid + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/MasterPreInstructor.aspx/Savetitle",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    if (response.d == '') {
                        Msgboxsuccess('ปรับปรุงข้อมูลเรียบร้อยแล้ว');
                        return;
                    }

                },
                async: false,
                error: function (er) {

                }
            });
        }
        //function Closetitle() {
        //    $('#Divtitle').modal('hide');
        //}
        //function Settitle(attachmentid) {
            
        //    $('#Txttitle').attr('data-value', attachmentid);
        //    $.ajax({
        //        type: "POST",
        //        url: "\../Page/TQF/MasterPreInstructor.aspx/Gettitle",
        //        data: "{'json' :'" + attachmentid + "'}",
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        beforeSend: function () {
        //            $(".loader").fadeOut("slow");
        //        },
        //        success: function (response) {
        //            $('#Txttitle').val(response.d);
        //        },
        //        async: false,
        //        error: function (er) {

        //        }
        //    });
        //    $('#Divtitle').modal('show');
        //}
        function Upload(x) {
            
            if (x == '') {
                Msgbox('โปรดบันทึกข้อมูลให้เรียบร้อยก่อน');
                return;
            }
            var key = 'attachment';
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
        
        function Viewattachment(x) {
            window.open('http://203.154.74.202/E-officepi/Attachment/file/' + x, '_blank');
        }
        function Delattachment(x) {
            var json = x;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/MasterPreInstructor.aspx/Delattachment",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getattachment($('#Hduserid').val());
                },
                async: false,
                error: function (er) {

                }
            });
        }
        function Getattachment(x) {
            var json = x;
            var j = 0;
            var _html = '';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/MasterPreInstructor.aspx/Getattachment",
                data: "{'json' : '" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {

                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    _html += "<table style='width:100%;border-spacing: 10px!important;border-collapse: separate!important;'>";
                    _html += "<tr>";
                    _html += "<td colspan='2' style='text-algin:right;'>";
                    _html += "<a style='color:blue;cursor:pointer;text-decoration:underline;margin-bottom:10px;'  onclick='Upload(\"" + $('#Hduserid').val() + "\");'>กดเพื่อ Upload เอกสาร</a>";
                    _html += "</td>";
                    _html += "</tr>";
                    _html += "<tr>";
                    _html += "<td colspan='2' style='text-algin:right;'>";
                    _html += "<hr>";
                    _html += "</td>";
                    _html += "</tr>";

                    if (response.d.length == 0) {
                        _html += "<tr>";
                        _html += '<td colspan="2"><div style="color:red;text-align:center;height:50px;">ไม่พบข้อมูล</div></td>';
                        _html += "</tr>";
                    }
                    else {
                       
                        for (j = 0; j < response.d.length; j++) {
                            _html += "<tr>";
                            _html += "<td>";
                            _html += "<input style='text-align:left;' class='form-control' type='text' id='Txttitle_" + response.d[j]['Attachmentid'] + "' onblur=\"Savetitle('" + response.d[j]['Attachmentid'] + "','Txttitle_" + response.d[j]['Attachmentid'] + "');\"  value='" + response.d[j]['Title'] + "' />";
                            _html += "</td>";
                            _html += "<td>";
                            _html += "<div  style='cursor:pointer; border: 1px solid lightgray;background-color:white;margin:10px;padding:10px;'><a onclick='Viewattachment(\"" + response.d[j]['Url'] + "\");'>" + response.d[j]['Filename'] + "</a></div>";
                            _html += "</td>";
                            _html += "<td>";
                            _html += "<button style='font-size:9px !important;' class='btn btn-danger' onclick='Delattachment(" + response.d[j]['Attachmentid'] + ");'><i class='fa fa-trash' style='font-size:9px !important;' aria-hidden='true'></i></button>";

                            _html += "</td>";
                            _html += "</tr>";
                           
                        }
                    }
                   
                    _html += "</table>";
                    
                    $('#Divattachment').html(_html);
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
        function CallBackUpload(Ctrl, RunningNo) {

            $.ajax({
                type: "POST",
                url: "\../Page/TQF/MasterPreInstructor.aspx/CallBackUpload",
                data: "{'Ctrl' : '" + Ctrl + "','RunningNo' :'" + RunningNo + "','Userid' :'" + $('#Hduserid').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                   
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    Getattachment($('#Hduserid').val());
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
            if (ctrl == 'GvPreInstuctor') {
                BindPreInstuctor();
            }
        }
        function CustomEdit(ctrl, dat, div, WPanel, HPanel) {
            var json = dat;
            if (ctrl == 'GvPreInstuctor') {
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/Masterpreinstructor.aspx/Getpreinstuctorinfo",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                   
                    success: function (response) {
                        res = response.d;
                        if (res["Error"] != '') {
                            Msgbox(res["Error"]);
                            return;
                        }
                        $('#Hduserid').val(res['Userid']);
                        $('#Txtfirstname').val(res['Firstname']);
                        $('#Txtlastname').val(res['Lastname']);
                        $('#Txtbirthdate').val(res['Birthdate']);
                        $('#Txtcardid').val(res['Cardid']);
                        $('#Txtposition').val(res['Position']);
                        $('#Txtyearno').val(res['Yearno']);
                        $('#Txtacademy').val(res['Academy']);
                        $('#Txtaddress').val(res['Address']);
                        $('#Txteducationbackground').val(res['Educationbackground']);
                        $('#Txtexperience').val(res['Experience']);

                        Getattachment($('#Hduserid').val());

                        $('#Divpreinstuctor').modal('show');
                    },
                    async: false,
                    error: function (er) {
                    }
                });
            }
        }
        function Savepreinstuctor() {
            var json = '';
            json += 'Userid:' + $('#Hduserid').val() + '|';
            json += 'Firstname:' + $('#Txtfirstname').val() + '|';
            json += 'Lastname:' + $('#Txtlastname').val() + '|';
            json += 'Birthdate:' + $('#Txtbirthdate').val() + '|';
            json += 'Cardid:' + $('#Txtcardid').val() + '|';
            json += 'Position:' + $('#Txtposition').val() + '|';
            json += 'Yearno:' + $('#Txtyearno').val() + '|';
            json += 'Academy:' + $('#Txtacademy').val() + '|';
            json += 'Address:' + $('#Txtaddress').val() + '|';
            json += 'Educationbackground:' + $('#Txteducationbackground').val() + '|';
            json += 'Experience:' + $('#Txtexperience').val() + '|';
   

            $.ajax({
                type: "POST",
                url: "\../Page/TQF/Masterpreinstructor.aspx/Savepreinstuctor",
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
                    $('#Divpreinstuctor').modal('hide');
                    Msgboxsuccess('บันทึกข้อมูลเรียบร้อยแล้ว');
                    BindPreInstuctor();

                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Newpreinstuctor() {
            $('#Hduserid').val('');
            $('#Txtfirstname').val('');
            $('#Txtlastname').val('');
            $('#Txtbirthdate').val('');
            $('#Txtcardid').val('');
            $('#Txtposition').val('');
            $('#Txtyearno').val('');
            $('#Txtacademy').val('');
            $('#Txtaddress').val('');
            $('#Txteducationbackground').val('');
            $('#Txtexperience').val('');
            Getattachment('');
            $('#Divpreinstuctor').modal('show');
        }

        function BindPreInstuctor() {
            ClearResource('TQF/MasterPreInstructor.aspx', 'GvPreInstuctor');
            var json = '';
            var Cri = json;
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!L"];
            var Data = ["Firstname", "Lastname", "EducationBackground"];
            var Searchcolumns = ["ชื่อ", "นามสกุล","วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "EducationBackground"];
            var Width = ["30%", "30%", "30%"];
            var Gv = new Grid("TQF/MasterPreInstructor.aspx", Columns, SearchesDat, Searchcolumns, 'GvPreInstuctor', 30, Width, Data, "", '', '2', '<button class="btn btn-secondary" style="border-radius:1px;font-size:14px;" onclick="Newpreinstuctor();">เพิ่มอาจารย์พิเศษ</button>', '1', '1', '', '', '', 'Userid', '', '', 'Userid', Cri, '');
            $('#DivPreInstuctor').html(Gv._Tables());
            Gv._Bind();
        }

        $(function () {
            //$("#Txtbirthdate").datepicker({
            //    format: "dd/mm/yyyy",
            //    todayBtn: "linked",
            //    language: "th",
            //    forceParse: false,
            //    autoclose: true,
            //    todayHighlight: true
            //});
            BindPreInstuctor();
        });
    </script>
</head>
<body>

    <div id="DivPreInstuctor" style="margin-top: 10px;">
    </div>
  
    <div class="modal" id="Divpreinstuctor" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 14px; font-family: TH SarabunPSK;">
            <div class="modal-content">
                <div class="modal-header">
                    <span>ข้อมูลอาจารย์พิเศษ</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <input type="hidden" id="Hduserid" value="" />
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ชื่อ</span>
                            </div>
                            <div class="col-3">
                                <input type="text" id="Txtfirstname" class="form-control" />
                            </div>
                            <div class="col-3">
                                <span>นามสกุล</span>
                            </div>
                            <div class="col-3">
                               <input type="text" id="Txtlastname" class="form-control" />
                            </div>
                        </div>

                         <div class="row mt-3">
                            <div class="col-3">
                                <span>วันเกิด</span>
                            </div>
                            <div class="col-3">
                                  <input id="Txtbirthdate" class="form-control" type="text" data-provide="datepicker" data-date-language="th-th" />
                                
                              <%-- <div id="Dtpbirthdate" class="input-group date" data-date-format="mm-dd-yyyy">
                                    <input id="Txtbirthdate" class="form-control" type="text" />
                                    <button>
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    </button>
                                </div>--%>
                            </div>
                            <div class="col-3">
                                <span>บัตรประชาชน</span>
                            </div>
                            <div class="col-3">
                               <input type="text" id="Txtcardid" class="form-control" maxlength="13" />
                            </div>
                        </div>
                         <div class="row mt-3">
                            <div class="col-3">
                                <span>ตำแหน่ง</span>
                            </div>
                            <div class="col-3">
                               <input type="text" id="Txtposition" class="form-control" />
                            </div>
                            <div class="col-3">
                                <span>ปีที่จบ</span>
                            </div>
                            <div class="col-3">
                               <input type="text" id="Txtyearno" class="form-control" />
                            </div>
                        </div>

                          <div class="row mt-3">
                            <div class="col-3">
                                <span>สถาบันที่จบ</span>
                            </div>
                            <div class="col-3">
                               <input type="text" id="Txtacademy" class="form-control" />
                            </div>
                            <div class="col-3">
                               
                            </div>
                            <div class="col-3">
                              
                            </div>
                        </div>
                           <div class="row mt-3">
                            <div class="col-3">
                               <span>วุฒิการศึกษา</span>
                            </div>
                            <div class="col-9">
                                <input type="text" id="Txteducationbackground" class="form-control" />
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>ที่อยู่</span>
                            </div>
                            <div class="col-9">
                                 <textarea id="Txtaddress" class="form-control" style="height:50px;" ></textarea>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">
                                <span>หลักสูตรที่ผ่านการอบรม</span>
                            </div>
                            <div class="col-9">
                                 <textarea id="Txtexperience" class="form-control" style="height:50px;" ></textarea>
                            </div>
                        </div>
                         <div class="row mt-3">
                            <div class="col-3">
                                <span>ไฟล์แนบ</span>
                            </div>
                            <div class="col-9">
                                 <div id="Divattachment" style="border:solid 1px lightgray;">

                                 </div>
                            </div>
                        </div>


                       
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="Savepreinstuctor();" class="btn btn-secondary" style="border-radius: 2px; font-size: 13px;">Save</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
  <%--    <div class="modal" id="Divtitle" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <span>ชื่อ</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container" style="margin-right: 10px; min-height: 320px; padding: 8px;">
                        <div class="row">
                            <div class="col-12">
                                <span>ชื่อ</span>&nbsp;<span style="color: red;">*</span>
                            </div>
                            <div class="col-12">
                                <input type="text" class="form-control" id="Txttitle" value="" />
                            </div>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-standard" style="background-color: #313131; color: white; font-size: 14px; border-radius: 0;" onclick="Savetitle();">บันทึก</button>
                        <button type="button" class="btn btn-danger" style="font-size: 14px; border-radius: 0;" data-dismiss="modal" onclick="Closetitle();">ปิดหน้าต่างนี้</button>
                    </div>

                </div>
            </div>
        </div>
    </div>--%>
</body>
</html>
