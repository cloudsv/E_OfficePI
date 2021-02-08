<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Orgchart.aspx.cs" Inherits="E_OfficePI.Page.HR.Orgchart" %>

<!DOCTYPE html>

<html>
<head>
    <script src="../../js/engine.js"></script>
    <style>
        .modal-lg {
            max-width: 80%;
        }

        button {
            font-size: 18px;
        }

        .modal-header {
            justify-content: unset;
        }
    </style>
    <script>
        $(document).ready(function () {
            setTimeout(() => {
                Unloading();
            }, 1000);
        });
        function Updateeducate() {
            var json = '';
            if ($('#Hdorgid').val() == '') {
                Msgbox('โปรดระบุองค์กรก่อน');
                return;
            }
            json =  'id:' + $('#Hdorgid').val() + '|';
            json += 'val:' + $('#Chkiseducate').prop('checked') + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/OrgChart.aspx/Updateeducate",
                data: "{'json' :'" + json + "'}",
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
                    Msgbox(er.status);
                }
            });
        }
        function Manpowerinfo() {
            $('#Divmanpowerinfo').modal('show');
        }
        function Addorg(x) {

            $('#Txtparentorgname').val('');
            $('#Divorgname').modal('show');
            $('#CmdSaveparentorg').on('click', function () {
                var json = '';
                var json = 'orgid :' + x + '|';
                json += 'Txtparentorgname :' + $('#Txtparentorgname').val() + '|';

                $.ajax({
                    type: "POST",
                    url: "\../Page/HR/OrgChart.aspx/Addparentorg",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d != '') {
                            Msgbox(response.d);
                            return;
                        }
                        //Msgbox('Add sub organize is successfully');
                        document.getElementById("myframe").contentWindow.Rendertree();
                    },
                    async: false,
                    error: function (er) {
                        Msgbox(er.status);
                    }
                });
                $("#CmdSaveparentorg").unbind("click");
            });
        }
        function Editorg(x) {
            var json = '';
            var json = 'orgid :' + x + '|';
            $('#Divorgname').modal('show');
            $.ajax({
                type: "POST",
                url: "\../Page/HR/OrgChart.aspx/Getorgname",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('#Txtparentorgname').val(response.d);
                    $('#CmdSaveparentorg').on('click', function () {
                        json = 'orgid :' + x + '|';
                        json += 'Txtparentorgname :' + $('#Txtparentorgname').val() + '|';
                        $.ajax({
                            type: "POST",
                            url: "\../Page/HR/OrgChart.aspx/Editparentorg",
                            data: "{'json' :'" + json + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                if (response.d != '') {
                                    Msgbox(response.d);
                                    return;
                                }
                                //Msgbox('Add sub organize is successfully');
                                document.getElementById("myframe").contentWindow.Rendertree();
                            },
                            async: false,
                            error: function (er) {
                                Msgbox(er.status);
                            }
                        });
                        $("#CmdSaveparentorg").unbind("click");
                    });
                },
                async: false,
                error: function (er) {
                    Msgbox(er.status);
                }
            });
        }
        function Deleteorg(x) {
            var json = '';
            $("#DivConfirm").modal('show');
            $('#DivConfirmMsg').html('คุณต้องการจะลบผังองค์กรนี้หรือไม่ (ข้อมูลภายใต้ผังองค์กรนี้จะถูกลบด้วย) ?');
            $('#CmdConfirm').on('click', function () {
                json += 'orgid :' + x + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/HR/OrgChart.aspx/Deleteorg",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#DivConfirm").modal('hide');
                        $('#Txtorgname').val('');
                        $('#Hdorgid').val('');
                        Orginfo(x);
                        //Msgbox('Delete organize is completed');
                        document.getElementById("myframe").contentWindow.Rendertree();
                    },
                    async: false,
                    error: function (er) {
                        Msgbox(er.status);
                    }
                });
            });
        }
        function doAdduser2Org(x) {
            var userid = x;
            var orgid = $('#Hdorgid').val();
            var json = 'userid :' + userid + '|';
            json += 'orgid :' + orgid + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/HR/OrgChart.aspx/doAdduser2Org",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //Msgbox('Add user to Organize is completed');
                    $('#Divusers').modal('hide');
                    Orginfo(orgid);
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
            $.ajax({
                type: "POST",
                url: "\../Page/HR/OrgChart.aspx/Getuser",
                data: "{'json' :'" + json + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.length > 0) {
                        html += '<table class="table table-bordered" style="font-size:18px;font-family:TH SarabunPSK;">';
                        html += '<tr class="table-info" style="color:black;" ><td style="width:20%;">&nbsp;</td><td style="width:30%;">ชื่อ นามสกุล</td></tr>';
                        for (i = 0; i < response.d.length; i++) {
                            html += '<tr style="color:black;"><td style="text-align:center;"><button onclick="doAdduser2Org(' + response.d[i]['userid'] + ');"  style="font-size:18px;" class="btn btn-info"><i class="fa fa-check"></i></button></td><td style="width:80%;"><div style="margin-top:10px;">' + response.d[i]['firstnameth'] + ' ' + response.d[i]['lastnameth'] + '</div></td></tr>';
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
        function Adduser2Org() {
            var html = '';
            var json = '';//Search 
            if ($('#Hdorgid').val() == '') {
                Msgbox('โปรดเลือกองค์กรก่อน');
                return;
            }
            Getuser();
            $('#Divusers').modal('show');

        }
        function DeluserfromOrg(x) {

            $("#DivConfirm").modal('show');
            $('#DivConfirmMsg').html('ต้องการลบผู้ใช้ท่านนี้ออกจากผัง ?');

            $('#CmdConfirm').on('click', function () {
                var html = '';
                var json = '';
                var userid = '';
                var userid = x;
                var orgid = $('#Hdorgid').val();
                var json = 'userid :' + userid + '|';
                json += 'orgid :' + orgid + '|';
                $.ajax({
                    type: "POST",
                    url: "\../Page/HR/OrgChart.aspx/DeluserfromOrg",
                    data: "{'json' :'" + json + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $("#DivConfirm").modal('hide');
                        //Msgbox('Delete user from organize is completed');
                        Orginfo(orgid);
                    },
                    async: false,
                    error: function (er) {
                        Msgbox(er.status);
                    }
                });
            });



        }
        function Orginfo(id) {
            var html = '';
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/HR/OrgChart.aspx/Orginfo",
                data: "{'id' :'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function (xhr) {
                    $("html, body").animate({ scrollTop: 0 }, "slow");
                },

                success: function (response) {
                    $('#Txtorgname').val(response.d['Orgname']);
                    $('#Hdorgid').val(response.d['Orgid']);
                    
                    if (response.d['Iseducate'] == 'True') {
                        $('#Chkiseducate').prop('checked', true);
                    }
                    else {
                        $('#Chkiseducate').prop('checked', false);
                    }

                    if (response.d["Users"].length > 0) {
                        for (i = 0; i < response.d["Users"].length; i++) {
                            html += '<div class="card card-body bg-light" style="margin:15px;height:80px;">';
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
                            html += '<div class="col-7">' + response.d["Users"][i]['firstnameth'] + ' ' + response.d["Users"][i]['lastnameth'] + '</div><div class="col-2" style="text-align:center;"><button onclick="DeluserfromOrg(' + response.d["Users"][i]['userid'] + ');"  style="font-size:18px;" class="btn btn-danger"><i class="fa fa-trash"></i></button></div>'
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
                    $('#Divuser').html(html);
                },
                async: false,
                error: function (er) {
                    Msgbox(er.status);
                }
            });
        }
    </script>
    <title></title>
</head>
<body>

    <div class="container-fluid" style="font-family: TH SarabunPSK; background-color: white; color: black; padding: 10px; width: 100%; margin-top: 20px;">
        <div class="row mt-3">
            <div class="col-8">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="card card-body bg-light">
                                ผังองค์กร
                            </div>
                        </div>

                    </div>
                    <div class="row mt-3">
                        <div class="col-12">
                            <iframe id="myframe" src="../Page/HR/Org.aspx" style="padding-left: 32px; min-height: 1000px; width: 100%; border: 1px solid lightgray;" frameborder="0"></iframe>
                        </div>

                    </div>
                </div>
            </div>

            <div class="col-4">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="card card-body bg-light">
                                <div class="row">
                                    <div class="col-3">
                                        องค์กร
                                    </div>
                                    <div class="col-9" style="text-align: right;">
                                        <input type="hidden" id="Hdorgid" value="" />
                                        <input class="form-control" id="Txtorgname" style="font-size: 18px;" readonly="readonly" />
                                        <div class="input-group" style="margin-top:5px;" >
                                            <input type="checkbox" onclick="Updateeducate();" id="Chkiseducate" />&nbsp;<span>เป็นวิทยาลัย</span>
                                        </div>
                                <%--        <button class="btn btn-warning" style="width: 100%; margin-top: 10px; font-size: 18px; border-radius: 1px;" onclick="Manpowerinfo();"><span>ข้อมูลอัตรากำลัง</span></button>--%>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-12">
                            <div class="card card-body bg-light">
                                <div class="row">
                                    <div class="col-6">
                                        ผู้ใช้งานภายใต้องค์กร
                                    </div>
                                    <div class="col-6" style="text-align: right;">
                                        <button class="btn btn-secondary" onclick="Adduser2Org();"><span style="font-size: 18px; border-radius: 0px;">เพิ่มผู้ใช้งานเข้าผัง</span></button>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div id="Divuser" style="min-height: 400px; border: solid 1px lightgray;">
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" tabindex="-1" role="dialog" id="Divusers" style="color: black;">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="text-align: left!important;">
                <div class="modal-header">
                    <h4 class="modal-title" style="font-family: TH SarabunPSK; font-size: 18px;">ผู้ใช้ที่ยังไม่มีองค์กรสังกัด</h4>

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

    <div class="modal" tabindex="-1" role="dialog" id="Divorgname">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="text-align: left!important;">
                <div class="modal-header">
                    <h6 class="modal-title" style="font-family: TH SarabunPSK; color: black;">องค์กร</h6>

                </div>
                <div class="modal-body" style="text-align: left; min-height: 60px; margin-top: 20px; font-family: TH SarabunPSK; font-size: 18px; color: black;">
                    <div class="container">

                        <div class="row">
                            <div class="col-2" style="text-align: right;">
                                <span>องค์กร</span>
                            </div>
                            <div class="col-10" style="text-align: left;">
                                <input type="text" id="Txtparentorgname" class="form-control" style="font-family: TH SarabunPSK; font-size: 18px;" value="" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="CmdSaveparentorg" class="btn btn-secondary" style="font-size: 18px; border-radius: 1px;" data-dismiss="modal">Save</button>&nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 1px;" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" id="Divmanpowerinfo" style="z-index: 99999;">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" style="text-align: left!important;font-size:18px;">
                <div class="modal-header">
                    <h4 class="modal-title" style="font-family: TH SarabunPSK; font-size: 18px;">ข้อมูลกรอบอัตรากำลัง</h4>

                </div>
                <div class="modal-body" style="text-align: left; min-height: 60px; margin-top: 20px; font-family: TH SarabunPSK; font-size: 18px; color: black;">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-3">หน่วยงานที่รับผิดชอบข้อมูล</div>
                            <div class="col-9">
                                <input type="text" class="form-control" readonly="readonly" /></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">ตำแหน่งเลขที่</div>
                            <div class="col-9">
                                <input type="text" id="Txtpositionno" class="form-control" /></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">ชื่อตำแหน่งในการบริหารงาน</div>
                            <div class="col-9">
                                <input type="text" id="Txtpositionname" class="form-control" /></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">ชื่อตำแหน่งในสายงาน</div>
                            <div class="col-9">
                                <input type="text" id="Txtpositionnamebyorgchart" class="form-control" /></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">ชนิดตำแหน่ง</div>
                            <div class="col-3">
                                <select id="Cbpositontype" class="form-control"></select></div>
                            <div class="col-3" style="text-align: right;">ประเภทตำแหน่ง</div>
                            <div class="col-3">
                                <select id="Cbpositoncat" class="form-control"></select></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">ประเภทแหล่งเงินจ้าง</div>
                            <div class="col-9">
                                <select id="Cbfundingsource" class="form-control"></select></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">หน่วยงานย่อยตาม ก.พ. ชั้นที่ 1	</div>
                            <div class="col-9">
                                <select id="Cbsuborglv1" class="form-control"></select></div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-3">หน่วยงานย่อยตาม ก.พ. ชั้นที่ 2	</div>
                            <div class="col-9">
                                <select id="Cbsuborglv2" class="form-control"></select></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">กำหนดระดับสูงสุด</div>
                            <div class="col-3">
                                <select id="Cbmaxlv" class="form-control"></select></div>
                            <div class="col-3" style="text-align: right;">กำหนดระดับต่ำสุด</div>
                            <div class="col-3">
                                <select id="Cbminlv" class="form-control"></select></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">หน่วยงานที่สังกัด(จ.18)</div>
                            <div class="col-9">
                                <select id="Cbsourceorgcode18" class="form-control"></select></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">หน่วยงานต้นสังกัด</div>
                            <div class="col-9">
                                <select id="Cbsourceorg" class="form-control"></select></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">กรม</div>
                            <div class="col-9">
                                <select id="Cbdepartment" class="form-control"></select></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">กำหนดระดับการศึกษา</div>
                            <div class="col-3">
                                <select id="Cbeducationlv" class="form-control"></select></div>
                            <div class="col-3" style="text-align: right;">วุฒิประจำตำแหน่ง</div>
                            <div class="col-3">
                                <select id="Cbdegree" class="form-control"></select></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-3">เงินตำแหน่ง</div>
                            <div class="col-3">
                                <select id="Cballowancestatus" class="form-control"></select></div>
                            <div class="col-1" style="text-align: right;">สถานะ</div>
                            <div class="col-2">
                                <select id="Cbpositonstatus" class="form-control"></select></div>
                            <div class="col-1" style="text-align: right;">การใช้งาน</div>
                            <div class="col-2">
                                <select id="Cbstatus" class="form-control"></select></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">เอกสารอ้างอิง</div>
                            <div class="col-12" id="Divattachment">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">หมายเหตุ</div>
                            <div class="col-12">
                                <textarea class="form-control" id="Txtpowerremark" style="height: 100px;">

                                 </textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="Cmdsavemanpower" class="btn btn-primary" style="font-size: 18px; border-radius: 1px;" data-dismiss="modal">Save</button>&nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 1px;" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
