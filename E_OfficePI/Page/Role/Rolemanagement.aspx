<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Rolemanagement.aspx.cs" Inherits="E_OfficePI.Page.Role.Rolemanagement" %>


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
            cursor:pointer;
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
   max-width:1200px;
  }
}
    </style>
    <script>
        function doAdduser2Org(x) {
            var userid = x;
            var roleid = $('#HdRoleid').val();
            var json = 'userid :' + userid + '|';
            json += 'roleid :' + roleid + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Role/Rolemanagement.aspx/doAdduser2Org",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('#Divusers').modal('hide');
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                  
                    $('#Divroleuser').modal('show');
                    RoleUserInfo(roleid);
                },
                async: false,
                error: function (er) {
                    Msgbox(er.status);
                }
            });
        }
        function Getuser() {
            var html = '';
            var json = 'Txtusersearch :' + $('#Txtusersearch').val() + '|';
            json += 'Roleid :' + $('#HdRoleid').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/Role/Rolemanagement.aspx/Getuser",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.length > 0) {
                        html += '<table class="table table-bordered" style="font-size:18px;font-family:TH SarabunPSK;">';
                        html += '<tr class="table-info" style="color:black;" ><td style="width:20%;">&nbsp;</td><td style="width:30%;">ชื่อ นามสกุล</td></tr>';
                        for (i = 0; i < response.d.length; i++) {
                            html += '<tr style="color:black;"><td style="text-align:center;"><button onclick="doAdduser2Org(' + response.d[i]['userid'] + ');"  style="font-size:18px;" class="btn btn-danger"><i class="fa fa-check"></i></button></td><td style="width:80%;"><div style="margin-top:10px;">' + response.d[i]['firstnameth'] + ' ' + response.d[i]['lastnameth'] + '</div></td></tr>';
                        }
                        html += '</tr>';
                        html += '</table>';
                    }
                    else {
                        html += '<div style="padding:50px;text-align:center;">';
                        html += '<span style="color:red;">ไม่พบข้อมูล</span>'
                        html += '</div>';
                    }

                    $('#Divuserscont').html(html);

                },
                async: false,
                error: function (er) {
                    Msgbox(er.status);
                }
            });
        }
        function Adduser2Role() {
            var html = '';
            var json = '';//Search 
            if ($('#HdRoleid').val() == '') {
                Msgbox('โปรดเลือก Role ก่อน');
                return;
            }
            Getuser();
            $('#Divroleuser').modal('hide');
            $('#Divusers').modal('show');

        }


        function Deluserfromrole(x) {

            $("#DivConfirm").modal('show');
            $('#DivConfirmMsg').html('ต้องการลบผู้ใช้ท่านนี้ออกจาก Role ?');

            $('#CmdConfirm').on('click', function () {
                var html = '';
                var json = '';
                var userid = '';
                var userid = x;
                var roleid = $('#HdRoleid').val();
                var json = 'userid :' + userid + '|';
                json += 'roleid :' + roleid + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/Role/Rolemanagement.aspx/Deluserfromrole",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#DivConfirm").modal('hide');
                        RoleUserInfo(roleid);
                        Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    },
                    async: false,
                    error: function (er) {
                        Msgbox(er.status);
                    }
                });
            });



        }
        function RoleUserInfo(id) {
            var html = '';
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/Role/Rolemanagement.aspx/RoleUserInfo",
                data: "{'id' :'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function (xhr) {
                    $("html, body").animate({ scrollTop: 0 }, "slow");
                },
                success: function (response) {
                    if (response.d["Users"].length > 0) {
                       
                        html += '<div class="row mt-3">';
                     
                        for (i = 0; i < response.d["Users"].length; i++) {
                            html += '<div class="col-4">';
                            html += '<div class="card card-body bg-light" style="margin:5px;height:80px;">';
                            html += '<div class="container">';
                            html += '<div class="row">';
                            html += '<div class="col-3">';
                            if (response.d["Users"][i]['avartarurl'] == null || response.d["Users"][i]['avartarurl'] == '') {
                                html += ' <img style="width:60px;"  src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/220px-User_icon_2.svg.png"  style="width:120px;" />';
                            }
                            else {
                                html += ' <img src="' + response.d["Users"][i]['avartarurl'] + '"  style="width:60px;" />';
                            }
                            html += '</div >';
                            html += '<div class="col-7">' + response.d["Users"][i]['firstnameth'] + ' ' + response.d["Users"][i]['lastnameth'] + '</div><div class="col-2" style="text-align:center;"><button onclick="Deluserfromrole(' + response.d["Users"][i]['userid'] + ');"  style="font-size:18px;" class="btn btn-danger"><i class="fa fa-trash"></i></button></div>'
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
                        }
                       
                        html += '</div>';
                        
                    }
                    else {
                        html += '<div style="padding:50px;text-align:center;">';
                        html += '<span style="color:red;">ไม่พบข้อมูล</span>'
                        html += '</div>';
                    }
                    $('#Divuser').html(html);
                    $.ajax({
                        type: "POST",
                        url: "\../Page/Role/Rolemanagement.aspx/Getrolename",
                        data: "{'RoleId' :'" + id + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            $('#SpRolenameTH').html("ผู้ใช้ภายใน Role : <b>" + response.d + "</b>");
                        },
                        async: true,
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
                },
                async: false,
                error: function (er) {
                    Msgbox(er.status);
                }
            });
        }
        function View(ctrl) {
            $.ajax({
                type: "POST",
                url: "\../Page/Role/Rolemanagement.aspx/View",
                data: "{'Ctrl' :'" + $(ctrl).attr('id') + "','check' :'" + $(ctrl).prop('checked') + "','RoleId' :'" + $('#HdRoleid').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    return;
                },
                async: true,
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
        function Edit(ctrl) {
            $.ajax({
                type: "POST",
                url: "\../Page/Role/Rolemanagement.aspx/Edit",
                data: "{'Ctrl' :'" + $(ctrl).attr('id') + "','check' :'" + $(ctrl).prop('checked') + "','RoleId' :'" + $('#HdRoleid').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    return;
                },
                async: true,
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
        function ElementInfo(PageId, PageKey, FunctionId, FunctionName, RoleId) {
            //$('#HdRoleid').val(RoleId);
            //$('#HdPageId').val(PageId);
            $('#HdPageKey').val(PageKey);
            $('#HdFunctionId').val(FunctionId);
            $('#HdFunctionName').val(FunctionName);
            var html = '';
            var ChkView = '';
            var ChkEdit = '';
            var Mod = '';
            var i = 0;

            html = '<table style="width:100%">';
            if (FunctionId != '') {
                //html += '<tr><td><a onclick="CreateElement(' + "'" + PageId + "','" + PageKey + "','" + FunctionId + "','" + RoleId + "'" + ');"><span style="font-size:12px;font-weight:bold;"><u>เพิ่มคอนโทรล</u></span></A></td></tr>';
                //html += '<tr><td colspan="5"><span style="font-size:10px;color:red;">ในกรณีที่คอนโทรลเป็นไอเทมให้ใส่ * ตามหลัง</span></td></tr>';
                html += '<tr><td></td></tr>';
                html += '<tr><td colspan="5"></td></tr>';
            }
            //html = '<table style="width:100%">';
            //html += '<tr><td><a onclick="CreateElement(' + "'" + PageId + "','" + PageKey + "','" + FunctionId + "','" + RoleId + "'" + ');"><span style="font-size:12px;font-weight:bold;"><u>เพิ่มคอนโทรล </u></span></A></td></tr>';
            //html += '<tr><td colspan="5">&nbsp;</td></tr>';
            //html += '<tr><td><span style="color:black;font-weight:bold;font-size:12px;">' + FunctionName + '</span></td><td><input type="Checkbox" />&nbsp;<span style="color:blue;font-weight:normal;font-size:12px;">View</span></td><td><input type="Checkbox" />&nbsp;<span style="color:blue;font-weight:normal;font-size:12px;">Edit</span></td></tr>';
            //html += '<tr><td colspan="5"> <hr style="border: dashed 0.5px lightgrey; width: 98%; margin: 5px;" /></td></tr>';
            $.ajax({
                type: "POST",
                url: "\../Page/Role/Rolemanagement.aspx/LoadElementInfo",
                data: "{'PageKey' :'" + PageKey + "','FunctionId' :'" + FunctionId + "','RoleId' :'" + RoleId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.length > 0) {

                        html += '<tr><td style="width:65%;"><span style="color:black;font-weight:bold;font-size:12px;color:orange;">คอนโทรล</span></td><td>&nbsp;<span style="color:blue;font-weight:normal;font-size:12px;">View</span></td><td>&nbsp;<span style="color:blue;font-weight:normal;font-size:12px;">Edit</span></td><td>&nbsp;</td><td>&nbsp;</td></tr>';
                        html += '<tr><td colspan="5"> <hr style="border: dashed 0.5px lightgrey; width: 98%; margin: 5px;" /></td>  </tr>';
                        for (i = 0; i < response.d.length; i++) {
                            //Mod = '<a onclick="ElementInfo(' + "'" + PageKey + "'" + ',' + "'" + response.d[i]["FunctionId"] + "'" + ',' + "'" + RoleId + "'" + ');" style="font-size:12px;font-weight:bold;">' + response.d[i]["FunctionName"] + "</a>";
                            Mod = '<span style="font-size:12px;color:green;">' + response.d[i]["ElementName"] + '</span>';
                            if (response.d[i]["ElementName"] != "") {

                                if (response.d[i]["View"] == "True") {
                                    ChkView = '<input type="Checkbox" checked  id=\'ChkCtrlView_' + response.d[i]["ElementId"] + '\'/>';
                                }
                                else {
                                    ChkView = '<input type="Checkbox"  id=\'ChkCtrlView_' + response.d[i]["ElementId"] + '\'/>';
                                }
                                if (response.d[i]["Edit"] == "True") {
                                    ChkEdit = '<input type="Checkbox" checked  id=\'ChkCtrlEdit_' + response.d[i]["ElementId"] + '\'/>';
                                }
                                else {
                                    ChkEdit = '<input type="Checkbox"  id=\'ChkCtrlEdit_' + response.d[i]["ElementId"] + '\'/>';;
                                }

                                //CmdDel = "<img id=\'CmdCtrlDel_" + response.d[i]["ElementId"] + "' style='Cursor:pointer' src='../..//Pictures/Grid/Del.png' class='grid-info' onclick=\"ElementDel('" + PageId + "','" + PageKey + "','" + response.d[i]["ElementName"] + "','" + RoleId + "','" + response.d[i]["ElementId"] + "','" + response.d[i]["FunctionName"] + "');\" />";
                                //CmdEdit = "<img id=\'CmdCtrlEdit_" + response.d[i]["ElementId"] + "' style='Cursor:pointer' src='../..//Pictures/Grid/Edit.png' class='grid-info' onclick=\"ElementEdit('" + PageId + "','" + PageKey + "','" + response.d[i]["ElementName"] + "','" + RoleId + "','" + response.d[i]["ElementId"] + "','" + response.d[i]["FunctionName"] + "','" + response.d[i]["ElementType"] + "','" + response.d[i]["ElementRemark"] + "');\" />";
                                CmdDel = '';
                                CmdEdit = '';
                            }
                            html += '<tr id="element"><td>' + Mod + '</td><td>' + ChkView + '</td><td>' + ChkEdit + '</td><td>' + CmdEdit + '</td><td>' + CmdDel + '</td></tr>';
                        }

                    }
                    else {

                        html += "<tr><td colspan='5'><div style='height: 50px;margin-top: 25px;color: red; font-size:15px;vertical-align:bottom;text-align : center;'>ไม่พบข้อมูล</div></td></tr>";
                    }
                    html += '</table>';

                    $("input[type='checkbox'][id^='ChkCtrlView_']").prop('checked', false);
                    $("input[type='checkbox'][id^='ChkCtrlEdit_']").prop('checked', false);
                    if ($("input[type='checkbox'][id^='ChkFuncView_" + FunctionId + "']").prop('checked') == true) {
                        $("input[type='checkbox'][id^='ChkCtrlView_']").prop('checked', true);
                    }
                    if ($("input[type='checkbox'][id^='ChkFuncEdit_" + FunctionId + "']").prop('checked') == true) {
                        $("input[type='checkbox'][id^='ChkCtrlEdit_']").prop('checked', true);
                    }
                    $('#ChkCtrlViewAll').on('click', function () {
                        ViewAll(this);
                        $("input[type='checkbox'][id^='ChkCtrlView_']").prop('checked', $('#ChkCtrlViewAll').prop('checked'));
                        $("input[type='checkbox'][id^='ChkFuncView_" + FunctionId + "']").prop('checked', $('#ChkCtrlViewAll').prop('checked'));
                    });
                    $('#ChkCtrlEditAll').on('click', function () {
                        EditAll(this);
                        $("input[type='checkbox'][id^='ChkCtrlEdit_']").prop('checked', $('#ChkCtrlEditAll').prop('checked'));
                        $("input[type='checkbox'][id^='ChkFuncEdit_" + FunctionId + "']").prop('checked', $('#ChkCtrlEditAll').prop('checked'));
                    });

                    $('#DivElement').html(html);

                    $("input[type='checkbox'][id^='ChkCtrlView_']").on('change', function () {
                        //Add By JOKE 
                        $('#ChkFuncView_' + FunctionId).prop('checked', false);
                        $('#ChkCtrlViewAll').prop('checked', true);
                        $("input[type='checkbox'][id^='ChkCtrlView_']").each(function (i, row) {
                            if ($('#' + $(this).attr('Id')).prop('checked') == false) {
                                $('#ChkCtrlViewAll').prop('checked', false);
                            }
                            if ($('#' + $(this).attr('Id')).prop('checked') == true) {
                                $('#ChkFuncView_' + FunctionId).prop('checked', true);
                            }
                        });
                        //End
                        View(this);

                    });

                    $("input[type='checkbox'][id^='ChkCtrlEdit_']").on('change', function () {

                        //Add By JOKE 
                        $('#ChkFuncEdit_' + FunctionId).prop('checked', false);
                        $('#ChkCtrlEditAll').prop('checked', true);
                        $("input[type='checkbox'][id^='ChkCtrlEdit_']").each(function (i, row) {
                            if ($('#' + $(this).attr('Id')).prop('checked') == false) {
                                $('#ChkCtrlEditAll').prop('checked', false);
                            }
                            if ($('#' + $(this).attr('Id')).prop('checked') == true) {
                                $('#ChkFuncEdit_' + FunctionId).prop('checked', true);
                            }
                        });
                        //End
                        Edit(this);
                    });
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
        function FuncInfo(PageId, PageKey, PageNameTH, RoleId) {

            //$('#HdRoleid').val(RoleId);
            $('#HdPageId').val(PageId);
            $('#HdPageKey').val(PageKey);
            $('#HdFunctionId').val('');
            $('#HdFunctionName').val('');
            var html = '';
            var ChkView = '';
            var ChkEdit = '';
            var CmdDel = '';
            var Mod = '';
            var i = 0;
            html = '<table id="TableFunction" style="width:100%">';
            //html += '<tr><td><a onclick="CreateFunction(' + "'" + PageId + "','" + PageKey + "','" + PageNameTH + "','" + RoleId + "'" + ');"><span style="font-size:12px;font-weight:bold;"><u>เพิ่มฟังก์ชันภายในโมดูล ' + PageNameTH + '</u></span></A></td></tr>';
            //html += '<tr><td colspan="5"> &nbsp;</td>  </tr>';
            html += '<tr><td><span style="font-size:12px;font-weight:bold;"><u>ฟังก์ชันภายในโมดูล ' + PageNameTH + '</u></span></td></tr>';
            html += '<tr><td colspan="5"></td></tr>';
            $.ajax({
                type: "POST",
                url: "\../Page/Role/Rolemanagement.aspx/LoadFunction",
                data: "{'PageId' :'" + PageId + "','PageKey' :'" + PageKey + "','RoleId' :'" + RoleId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.length > 0) {
                        html += '<tr><td><span style="color:black;font-weight:bold;font-size:12px;color:orange;">ฟังก์ชัน</span></td><td>&nbsp;<span style="color:blue;font-weight:normal;font-size:12px;">View</span></td><td>&nbsp;<span style="color:blue;font-weight:normal;font-size:12px;">Edit</span></td><td>&nbsp;</td><td>&nbsp;</td></tr>';
                        html += '<tr><td colspan="5"> <hr style="border: dashed 0.5px lightgrey; width: 98%; margin: 5px;" /></td>  </tr>';
                        for (i = 0; i < response.d.length; i++) {
                            if (response.d[i]["Edit"] == "0") {
                                ChkEdit = '<input type="Checkbox"  id=\'ChkFuncEdit_' + response.d[i]["FunctionId"] + '\' onclick="ElementInfo(' + "'" + PageId + "','" + PageKey + "'" + ',' + "'" + response.d[i]["FunctionId"] + "'" + ',' + "'" + response.d[i]["FunctionName"] + "'" + ',' + "'" + RoleId + "'" + ');"/>';
                            }
                            else {
                                ChkEdit = '<input type="Checkbox" checked id=\'ChkFuncEdit_' + response.d[i]["FunctionId"] + '\' onclick="ElementInfo(' + "'" + PageId + "','" + PageKey + "'" + ',' + "'" + response.d[i]["FunctionId"] + "'" + ',' + "'" + response.d[i]["FunctionName"] + "'" + ',' + "'" + RoleId + "'" + ');"/>';
                            }
                            if (response.d[i]["View"] == "0") {
                                ChkView = '<input type="Checkbox"  id=\'ChkFuncView_' + response.d[i]["FunctionId"] + '\' onclick="ElementInfo(' + "'" + PageId + "','" + PageKey + "'" + ',' + "'" + response.d[i]["FunctionId"] + "'" + ',' + "'" + response.d[i]["FunctionName"] + "'" + ',' + "'" + RoleId + "'" + ');"/>';
                            }
                            else {
                                ChkView = '<input type="Checkbox" checked id=\'ChkFuncView_' + response.d[i]["FunctionId"] + '\' onclick="ElementInfo(' + "'" + PageId + "','" + PageKey + "'" + ',' + "'" + response.d[i]["FunctionId"] + "'" + ',' + "'" + response.d[i]["FunctionName"] + "'" + ',' + "'" + RoleId + "'" + ');"/>';
                            }

                            //CmdDel = "<img id=\'CmdFuncDel_" + response.d[i]["FunctionId"] + "' style='Cursor:pointer' src='../..//Pictures/Grid/Del.png' class='grid-info' onclick=\"FuncDel('" + PageId + "','" + PageKey + "','" + PageNameTH + "','" + RoleId + "','" + response.d[i]["FunctionId"] + "','" + response.d[i]["FunctionName"] + "');\" />";
                            //CmdEdit = "<img id=\'CmdFuncEdit_" + response.d[i]["FunctionId"] + "' style='Cursor:pointer' src='../..//Pictures/Grid/Edit.png' class='grid-info' onclick=\"FuncEdit('" + PageId + "','" + PageKey + "','" + PageNameTH + "','" + RoleId + "','" + response.d[i]["FunctionId"] + "','" + response.d[i]["FunctionName"] + "');\" />";
                            CmdDel = '';
                            CmdEdit = '';
                            Mod = '<a onclick="ElementInfo(' + "'" + PageId + "','" + PageKey + "'" + ',' + "'" + response.d[i]["FunctionId"] + "'" + ',' + "'" + response.d[i]["FunctionName"] + "'" + ',' + "'" + RoleId + "'" + ');" style="font-size:12px;font-weight:nolmal;color:blue;">' + response.d[i]["FunctionName"] + "</a>";
                            html += '<tr id="element"><td>' + Mod + '</td><td>' + ChkView + '</td><td>' + ChkEdit + '</td><td>' + CmdEdit + '</td><td>' + CmdDel + '</td></tr>';
                        }

                    }
                    else {
                        html += "<tr><td colspan='5'><div style='height: 50px;margin-top: 25px;color: red; font-size:15px;vertical-align:bottom;text-align : center;'>ไม่พบข้อมูล</div></td></tr>";
                    }
                    html += '</table>';
                    $('#DivFunction').html(html);
                    $("#TableFunction tr").click(function () {
                        var selected = $(this).hasClass("highlight");
                        $("#TableFunction tr").removeClass("highlight");
                        if (!selected)
                            $(this).addClass("highlight");
                    });


                    $('#ChkFuncViewAll').on('click', function () {
                        ViewAll(this);
                        $("input[type='checkbox'][id^='ChkFuncView_']").prop('checked', $('#ChkFuncViewAll').prop('checked'));
                        $("input[type='checkbox'][id^='" + "ChkView_" + PageId + "']").prop('checked', $('#ChkFuncViewAll').prop('checked')); //Add By JOKE
                    });
                    $('#ChkFuncEditAll').on('click', function () {
                        EditAll(this);
                        $("input[type='checkbox'][id^='ChkFuncEdit_']").prop('checked', $('#ChkFuncEditAll').prop('checked'));
                        $("input[type='checkbox'][id^='" + "ChkEdit_" + PageId + "']").prop('checked', $('#ChkFuncEditAll').prop('checked')); //Add By JOKE
                    });
                    $("input[type='checkbox'][id^='ChkFuncView_']").on('change', function () {
                        View(this);
                        //Add By JOKE 
                        $('#ChkFuncViewAll').prop('checked', true);
                        $('#ChkView_' + PageId).prop('checked', false);
                        $('#ChkCtrlViewAll').prop('checked', true);
                        $("input[type='checkbox'][id^='ChkFuncView_']").each(function (i, row) {
                            if ($('#' + $(this).attr('Id')).prop('checked') == false) {
                                $('#ChkFuncViewAll').prop('checked', false);
                                $('#ChkCtrlViewAll').prop('checked', false);
                            }
                            else {
                                $('#ChkView_' + PageId).prop('checked', true);
                            }
                        });
                        //End
                    });
                    $("input[type='checkbox'][id^='ChkFuncEdit_']").on('change', function () {
                        Edit(this);
                        //Add By JOKE 
                        $('#ChkFuncEditAll').prop('checked', true);
                        $('#ChkEdit_' + PageId).prop('checked', false);
                        $('#ChkCtrlEditAll').prop('checked', true);
                        $('#ChkCtrlEdit_').prop('checked', true);
                        $("input[type='checkbox'][id^='ChkFuncEdit_']").each(function (i, row) {
                            if ($('#' + $(this).attr('Id')).prop('checked') == false) {
                                $('#ChkFuncEditAll').prop('checked', false);
                                $('#ChkEdit_' + PageId).prop('checked', false);
                                $('#ChkCtrlEditAll').prop('checked', false);
                            }
                            else {
                                $('#ChkEdit_' + PageId).prop('checked', true);
                            }
                        });
                        //End
                    });
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
            //ElementInfo('', '', '', '', '');
        }
        function LoadEntity(RoleId) {


            var html = '';
            var ChkView = '';
            var ChkEdit = '';
            var Mod = '';
            var i = 0;
            html = '<table id="TableEntity" style="width:100%;">';
            html += '<tr><td><span style="color:black;font-weight:bold;font-size:12px;color:orange;">โมดูล</span></td><td><span style="color:blue;font-weight:normal;font-size:12px;">View</span></td><td>&nbsp;<span style="color:blue;font-weight:normal;font-size:12px;">Edit</span></td></tr>';
            html += '<tr><td colspan="3"> <hr style="border: dashed 0.5px lightgrey; width: 98%; margin: 5px;" /></td></tr>';
            $.ajax({
                type: "POST",
                url: "\../Page/Role/Rolemanagement.aspx/LoadEntity",
                data: "{'RoleId' :'" + RoleId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    for (i = 0; i < response.d.length; i++) {
                        Mod = '<a  onclick="FuncInfo(' + "'" + response.d[i]["PageId"] + "'" + ',' + "'" + response.d[i]["PageKey"] + "'" + ',' + "'" + response.d[i]["PageNameTH"] + "'" + ',' + "'" + RoleId + "'" + ');" style="font-size:12px;font-weight:bold;">' + response.d[i]["PageNameTH"] + "</a> &nbsp;&nbsp;<span style='font-size:10px;color:green;'>(" + response.d[i]["PageDescTH"] + ")</span>";

                        if (response.d[i]["Edit"] == "0") {
                            ChkEdit = '<input type="Checkbox"  id=\'ChkEdit_' + response.d[i]["PageId"] + '\' onclick="FuncInfo(' + "'" + response.d[i]["PageId"] + "'" + ',' + "'" + response.d[i]["PageKey"] + "'" + ',' + "'" + response.d[i]["PageNameTH"] + "'" + ',' + "'" + RoleId + "'" + ');"/>';
                        }
                        else {
                            ChkEdit = '<input type="Checkbox" checked id=\'ChkEdit_' + response.d[i]["PageId"] + '\' onclick="FuncInfo(' + "'" + response.d[i]["PageId"] + "'" + ',' + "'" + response.d[i]["PageKey"] + "'" + ',' + "'" + response.d[i]["PageNameTH"] + "'" + ',' + "'" + RoleId + "'" + ');"/>';
                        }
                        if (response.d[i]["View"] == "0") {
                            ChkView = '<input type="Checkbox"  id=\'ChkView_' + response.d[i]["PageId"] + '\' onclick="FuncInfo(' + "'" + response.d[i]["PageId"] + "'" + ',' + "'" + response.d[i]["PageKey"] + "'" + ',' + "'" + response.d[i]["PageNameTH"] + "'" + ',' + "'" + RoleId + "'" + ');"/>';
                        }
                        else {
                            ChkView = '<input type="Checkbox" checked id=\'ChkView_' + response.d[i]["PageId"] + '\' onclick="FuncInfo(' + "'" + response.d[i]["PageId"] + "'" + ',' + "'" + response.d[i]["PageKey"] + "'" + ',' + "'" + response.d[i]["PageNameTH"] + "'" + ',' + "'" + RoleId + "'" + ');"/>';
                        }
                        html += '<tr onclick="FuncInfo(' + "'" + response.d[i]["PageId"] + "'" + ',' + "'" + response.d[i]["PageKey"] + "'" + ',' + "'" + response.d[i]["PageNameTH"] + "'" + ',' + "'" + RoleId + "'" + '); id="element"><td>' + Mod + '</td><td>' + ChkView + '</td><td>' + ChkEdit + '</td></tr>';
                    }
                    html += '</table>';
                    $('#DivEntity').html(html);


                    $.ajax({
                        type: "POST",
                        url: "\../Page/Role/Rolemanagement.aspx/Getrolename",
                        data: "{'RoleId' :'" + RoleId + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            $('#TxtPermissionInRoleNameTH').val(response.d);
                            
                        },
                        async: true,
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

                    //$("#TableEntity tr").click(function () {
                    //    var selected = $(this).hasClass("highlight");
                    //    $("#TableEntity tr").removeClass("highlight");
                    //    if (!selected)
                    //        $(this).addClass("highlight");
                    //});
                    //$('#ChkViewAll').on('click', function () {
                    //    ViewAll(this);
                    //    $("input[type='checkbox'][id^='ChkView_']").prop('checked', $('#ChkViewAll').prop('checked'));
                    //    $("#ChkFuncViewAll").prop('checked', $(this).prop('checked'));
                    //    $("input[type='checkbox'][id^='ChkFuncView_']").prop('checked', $(this).prop('checked'));
                    //    $("#ChkCtrlViewAll").prop('checked', $(this).prop('checked'));
                    //    $("input[type='checkbox'][id^='ChkCtrlView_']").prop('checked', $(this).prop('checked'));


                    //});
                    //$('#ChkEditAll').on('click', function () {
                    //    EditAll(this);
                    //    $("input[type='checkbox'][id^='ChkEdit_']").prop('checked', $('#ChkEditAll').prop('checked'));
                    //    $("#ChkFuncEditAll").prop('checked', $(this).prop('checked'));
                    //    $("input[type='checkbox'][id^='ChkFuncEdit_']").prop('checked', $(this).prop('checked'));
                    //    $("#ChkCtrlEditAll").prop('checked', $(this).prop('checked'));
                    //    $("input[type='checkbox'][id^='ChkCtrlEdit_']").prop('checked', $(this).prop('checked'));

                    //});
                    //$("input[type='checkbox'][id^='ChkView_']").on('change', function () {
                    //    View(this);
                    //    $("#ChkFuncViewAll").prop('checked', $(this).prop('checked'));
                    //    $("input[type='checkbox'][id^='ChkFuncView_']").prop('checked', $(this).prop('checked'));

                    //    $("#ChkCtrlViewAll").prop('checked', $(this).prop('checked'));
                    //    $("input[type='checkbox'][id^='ChkCtrlView_']").prop('checked', $(this).prop('checked'));


                    //});
                    //$("input[type='checkbox'][id^='ChkEdit_']").on('change', function () {
                    //    Edit(this);
                    //    $("#ChkFuncEditAll").prop('checked', $(this).prop('checked'));
                    //    $("input[type='checkbox'][id^='ChkFuncEdit_']").prop('checked', $(this).prop('checked'));
                    //    $("#ChkCtrlEditAll").prop('checked', $(this).prop('checked'));
                    //    $("input[type='checkbox'][id^='ChkCtrlEdit_']").prop('checked', $(this).prop('checked'));

                    //});
                },
                async: true,
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
        function doManagerole() {
            var x = $('#Cbmanagerole').val();

            if (x == "U") {
                $('#Divmanagerole').modal('hide');
                $('#Divroleuser').modal('show');
                RoleUserInfo($('#HdRoleid').val());
            }
            else if (x == "F") {
               
                $('#Divmanagerole').modal('hide');
                $('#Divrolefunction').modal('show');
                LoadEntity($('#HdRoleid').val());
            }
        }
        function Managerole(x) {
            $('#HdRoleid').val(x);
            $('#Divmanagerole').modal('show');
        }
        function Role() {
            $('#Divrole').show();
            Bindrole();
        }
        function Getuserinrole() {

            var html = '';
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/Role/Rolemanagement.aspx/Getuserinrole",
                data: "{'id' :'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d["Users"].length > 0) {
                        for (i = 0; i < response.d["Users"].length; i++) {
                            html += '<div class="card card-body bg-light" style="margin:15px;height:100px;">';
                            html += '<div class="container">';
                            html += '<div class="row">';
                            html += '<div class="col-3">';
                            if (response.d["Users"][i]['avartarurl'] == null || response.d["Users"][i]['avartarurl'] == '') {
                                html += ' <img style="width:60px;"  src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/220px-User_icon_2.svg.png"  style="width:120px;" />';
                            }
                            else {
                                html += ' <img src="' + response.d["Users"][i]['avartarurl'] + '"  style="width:60px;" />';
                            }
                            html += '</div >';
                            html += '<div class="col-7">' + response.d["Users"][i]['firstnameth'] + ' ' + response.d["Users"][i]['lastnameth'] + '</div><div class="col-2" style="text-align:center;"><button onclick="Deluserfromrole(' + response.d["Users"][i]['userid'] + ');"  style="font-size:14px;" class="btn btn-danger"><i class="fa fa-trash"></i></button></div>'
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
                        }
                    }
                    else {
                        html += '<div style="padding:50px;text-align:center;">';
                        html += '<span style="color:red;">ไม่พบข้อมูล</span>'
                        html += '</div>';
                    }
                    $('#Divuserinrole').html(html);
                },
                async: false,
                error: function (er) {
                    Msgbox(er.status);
                }
            });
        }
        function Getavailableuser() {
            var html = '';
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/Role/Rolemanagement.aspx/Getavailableuser",
                data: "{'id' :'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d["Users"].length > 0) {
                        for (i = 0; i < response.d["Users"].length; i++) {
                            html += '<div class="card card-body bg-light" style="margin:15px;height:100px;">';
                            html += '<div class="container">';
                            html += '<div class="row">';
                            html += '<div class="col-3">';
                            if (response.d["Users"][i]['avartarurl'] == null || response.d["Users"][i]['avartarurl'] == '') {
                                html += ' <img style="width:60px;"  src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/220px-User_icon_2.svg.png"  style="width:120px;" />';
                            }
                            else {
                                html += ' <img src="' + response.d["Users"][i]['avartarurl'] + '"  style="width:60px;" />';
                            }
                            html += '</div >';
                            html += '<div class="col-7">' + response.d["Users"][i]['firstnameth'] + ' ' + response.d["Users"][i]['lastnameth'] + '</div><div class="col-2" style="text-align:center;"><button onclick="Deluserfromrole(' + response.d["Users"][i]['userid'] + ');"  style="font-size:14px;" class="btn btn-danger"><i class="fa fa-trash"></i></button></div>'
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
                        }
                    }
                    else {
                        html += '<div style="padding:50px;text-align:center;">';
                        html += '<span style="color:red;">ไม่พบข้อมูล</span>'
                        html += '</div>';
                    }
                    $('#Divuserinrole').html(html);
                },
                async: false,
                error: function (er) {
                    Msgbox(er.status);
                }
            });
        }
        function Bindrole() {
            ClearResource('Role/Rolemanagement.aspx', 'Gvrole');
            var Cri = $('#HdRoleid').val();
            var Columns = ["ชื่อ Role!L", "ตั้งค่า Role!C"];
            var Data = ["Rolename", "Control"];
            var Searchcolumns = ["ชื่อ Role"];
            var SearchesDat = ["Rolename"];
            var Width = ["90%", "10%"];
            var Gv = new Grid("Role/Rolemanagement.aspx", Columns, SearchesDat, Searchcolumns, 'Gvrole', 30, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divrolecont').html(Gv._Tables());
            Gv._Bind();
        }
        $(function () {
            Role();

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
                        <a class="nav-link" href="#" onclick="Role();">บทบาทหน้าที่</a>
                    </li>
                </ul>
            </div>
        </nav>
        <div id="Divrole" style="display: none;">
            <div id="Divrolecont">
            </div>
        </div>
    </div>
    <div class="modal" id="Divmanagerole" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <span>จัดการ Role</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-3">
                                <span>จัดการ</span>
                            </div>
                            <div class="col-6">
                                <select class="form-control" id="Cbmanagerole">
                                    <option selected="selected" value="U">ผู้ใช้งานภายใน Role</option>
                                    <option value="F">ฟังก์ชันภายใน Role</option>
                                </select>
                            </div>
                            <div class="col-2">
                                <button type="button" onclick="doManagerole();" class="btn btn-info" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ตกลง</button>
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
    <input type="hidden" id="HdRoleid" value="" />
   


        <div class="modal fade bd-example-modal-xl" id="Divroleuser" data-backdrop="static" data-keyboard="false">
               <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header"  style="margin-left:100px;">
                    <span>จัดการผู้ใช้เข้ากับ Role</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body" style="margin-left:100px;">
                    <div class="container" >
                     <div class="row mt-1" style="margin-top: 20px;">
                        <div class="col-12">
                            <div class="card card-body bg-light">
                                <div class="row">
                                    <div class="col-6">
                                       <span id="SpRolenameTH"></span>
                                    </div>
                                    <div class="col-6" style="text-align: right;">
                                        <button class="btn btn-secondary" onclick="Adduser2Role();"><span style="font-size: 18px; border-radius: 0px;">เพิ่มผู้ใช้งานเข้า Role</span></button>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="row mt-1">
                        <div class="col-12">
                            <div id="Divuser" style="min-height: 400px; border: solid 1px lightgray;">
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

         </div>


    <div class="modal fade bd-example-modal-xl" id="Divrolefunction" data-backdrop="static" data-keyboard="false">
               <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header"  style="margin-left:100px;">
                    <span>จัดการฟังก์ชันเข้ากับ Role</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body" style="margin-left:100px;">
                    <div class="container" >
              <table style="width: 100%;">
            <tr>
                <td style="width: 20%;">Role Name</td>
                <td style="text-align: left;">
                    <input type="text" id="TxtPermissionInRoleNameTH" style="font-size:16px !important;" class="form-control"  readonly="readonly"  /></td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr style="border: dashed 0.5px lightgrey; width: 98%; margin: 5px;" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table style="width: 100%;" border="0">
                        <tr>
                            <td rowspan="2" style="width: 50%;vertical-align:top;">
                                <div class="div-permission" style="min-height: 300px;">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="text-align: center;">
                                                <div class="card card-body bg-light">
                                                    <span class="sp-standard" style="font-weight: bold;">โมดูลภายในระบบ</span>
                                                </div>
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div id="DivEntity" style="border:solid 1px gray;border-radius:2px;margin:4px;padding:12px;font-size:14px !important">
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                            <td style="vertical-align: top;">
                                <div class="div-permission" style="min-height: 300px;">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="text-align: center;">
                                                <div class="card card-body bg-light">
                                                    <span class="sp-standard" style="font-weight: bold;">ฟังก์ชันภายในโมดูล</span>
                                                </div>
                                               
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div id="DivFunction"  style="min-height:400px; border:solid 1px gray;border-radius:2px;margin:4px;padding:12px;font-size:14px !important">
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top;">
                                <div class="div-permission" style="min-height: 300px;">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="text-align: center;">
                                             

                                                 <div class="card card-body bg-light">
                                                    <span class="sp-standard" style="font-weight: bold;">คอนโทรลในฟังก์ชัน</span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div id="DivElement" style="min-height:200px; border:solid 1px gray;border-radius:2px;margin:4px;padding:12px;font-size:14px !important">
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
                          </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                </div>
                </div>
                   </div>
    </div>
    <div id="DivCreateElement" class="sp-standard" title="เพิ่มคอนโทรล" style="display: none;">
        <table style="width: 100%">
            <tr>
                <td style="text-align: left;"><span>ชื่อคอนโทรล</span>
                <td>
                <td style="text-align: left; width: 250px;">
                    <table style="width:100%">
                         <tr>
                             <td><input id="TxtElementName" data-column="ElementName" data-validation="ElementName" style="width: 93%;" type="text"></td>
                             <td>&nbsp;<span style="color: red;">* </span></td>
                         </tr>  
                    </table> 
            </tr>
           <tr>
                <td style="text-align: left;"><span>ประเภทวัตถุ</span>
                <td>
                <td style="text-align: left; width:250px" >
                    <table style="width:100%">
                         <tr>
                             <td>
                                  <select id="CbElementType" data-column="ElementType" style="width:100%" >
                                     <option  selected>ระบุ</option>
                                     <option value="DropDown">DropDown</option>
                                     <option value="Buttom">Buttom</option>
                                     <option value="Grid">Grid</option>
                                     <option value="Div">Div</option> 
                                 </select>
                             </td>
                             <td>&nbsp;<span style="color: red;">* </span></td>
                         </tr>  
                    </table>  
                </td>
            </tr>
            <tr style="vertical-align: top;">
                <td style="text-align: left;"><span>หมายเหตุ</span> <td>
                <td style="text-align: left; width: 250px;">
                <textarea rows="4" id="TxtElementRemark" data-column="ElementRemark"  style="text-align: left; width:84%;"></textarea></td>
            </tr>
        </table>
    </div>
    <div id="DivCreateFunction" class="sp-standard" title="ฟังก์ชั่น" style="display: none;">
        <table style="width: 100%">
            <tr>
                <td style="text-align: left;"><span>ชื่อฟังก์ชั่น</span></td>
                <td style="text-align: left;">
                    <input id="TxtFunctionName" data-column="FunctionName" data-validation="FunctionName" style="width: 250px;" type="text">&nbsp;<span style="color: red;">* </span></td>
            </tr>
        </table>
    </div>

     <div class="modal" tabindex="-1" role="dialog" id="Divusers" style="color: black;">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="text-align: left!important;">
                <div class="modal-header">
                    <h4 class="modal-title" style="font-family: TH SarabunPSK; font-size: 18px;">ผู้ใช้ภายในระบบ</h4>

                </div>
                <div class="modal-body" style="text-align: left; min-height: 60px; margin-top: 20px; font-family: TH SarabunPSK; font-size: 18px;">
                    <div class="container">
                        <div class="row">
                            <div class="col-6" style="text-align: right;"></div>
                            <div class="col-6" style="text-align: left;">
                                <div class="input-group mb-3">
                                    <input id="Txtusersearch" type="text" class="form-control" placeholder="Search..." style="width: 100px; border-radius: 1px; font-size: 18px;">
                                    <div class="input-group-append">
                                        <button id="Cmdsearch" onclick="Getuser();" style="font-size: 18px;" class="btn btn-info" type="button">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12" style="text-align: left;">
                                <div id="Divuserscont" style="min-height: 150px; font-size: 18px; font-family: TH SarabunPSK; border: solid 1px lightgray;"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-secondary" style="font-size: 18px; border-radius: 1px;" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
