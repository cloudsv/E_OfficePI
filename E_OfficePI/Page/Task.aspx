<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Task.aspx.cs" Inherits="E_OfficePI.Page.Task" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script src="../../js/datepicker/bootstrap-datepicker.js"></script>
    <link href="../../js/datepicker/datepicker.css" rel="stylesheet" />
    <script src="../js/engine.js"></script>
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
        function doApprove() {
            var x = $('#Hdapproveid').val();
            $.ajax({
                type: "POST",
                url: "Task.aspx/doApprove",
                data: "{'json' :'" + x + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                   
                    
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    $('#Divmodalleave').modal('hide');
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    Task();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function doReject() {
            var x = $('#Hdapproveid').val();
            $.ajax({
                type: "POST",
                url: "Task.aspx/doReject",
                data: "{'json' :'" + x + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $(".loader").fadeOut("slow");
                },
                success: function (response) {
                    $('#Divmodalleave').modal('hide');
                    Msgboxsuccess('ดำเนินการเรียบร้อยแล้ว');
                    Task();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Approve(m, x) {
            
            if (m == 'LEAVE') {
                $('#Hdapproveid').val(x);
                $('#Divmodalleave').modal('show');
                $.ajax({
                    type: "POST",
                    url: "Task.aspx/Leaveinfo",
                    data: "{'json' :'" + x + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        
                    },
                    success: function (response) {
                        if (response.d['Leavecat'] == "F") {
                            $('#Divfulltime').show();
                            $('#Divparttime').hide();
                        }
                        else {
                            $('#Divfulltime').hide();
                            $('#Divparttime').show();
                        }
                        
                        $('#Txtleavesubject').val(response.d['Leavesubject']);
                        $('#Txtleavetype').val(response.d['Leavetype']);
                        $('#Txtstartleave').val(response.d['Startleave']);
                        $('#Txtstopleave').val(response.d['Stopleave']);
                        $('#Txtpartleave').val(response.d['Partleave']);
                        $('#Txtparttime').val(response.d['Parttime']);
                        $('#Txtleavedesc').val(response.d['Leavedesc']);
                        $('#Txtdelegate').val(response.d['Delegate']);
                        $(".loader").fadeOut("slow");
                    },
                    async: true,
                    error: function (er) {

                    }
                });
            }
        }
        function Task() {
            $('#Divtask').show();
            Bindtask();
        }
        function Bindtask() {
            ClearResource('Task.aspx', 'Gvtask');
            var Cri = $('#HdRoleid').val();
            var Columns = ["งานอนุมัติ!L" ,"เรื่อง","รายละเอียด"];
            var Data = ["Module","Subject", "Detail"];
            var Searchcolumns =[];
            var SearchesDat = [];
            var Width = ["10%","80%", "10%"];
            var Gv = new Grid("Task.aspx", Columns, SearchesDat, Searchcolumns, 'Gvtask', 30, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divtaskcont').html(Gv._Tables());
            Gv._Bind();
        }
        $(function () {
            Task();

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
                        <a class="nav-link" href="#" onclick="Task();">งานรออนุมัติ</a>
                    </li>
                </ul>
            </div>
        </nav>
        <div id="Divtask" style="display: none;">
            <div id="Divtaskcont">
            </div>
        </div>
    </div>
    <div class="modal" id="Divmodalleave" data-backdrop="static" style="z-index: 99999;" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document" style="color: black; font-size: 18px; font-family: TH SarabunPSK;">
            <div class="modal-content">
                <div class="modal-header">
                    <span id="Spleavetypetitle">การลา</span>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container">
                       
                        <div class="container">
                           <div class="row mt-3">
                                <div class="col-12">
                                    <span>เรื่องที่ขอลา</span>
                                </div>
                                <div class="col-12">
                                    <input type="text" id="Txtleavesubject" readonly="readonly" class="form-control" />
                                </div>
                            </div>
                             <div class="row mt-3">
                                <div class="col-12">
                                    <span>ประเภทการขอลา</span>
                                </div>
                                <div class="col-12">
                                    <input type="text" id="Txtleavetype" readonly="readonly" class="form-control" />
                                    
                                </div>
                            </div>
                             <div id="Divfulltime">
                                <div class="row mt-3">
                                    <div class="col-6">
                                        <span>วันที่เริ่มลาจาก</span>
                                    </div>
                                    <div class="col-6">
                                        <span>วันที่เริ่มลาถึง</span>
                                    </div>
                             </div>
                          
                          
                            <div class="row mt-1">
                                <div class="col-6">

                                    <input type="text" id="Txtstartleave" readonly="readonly" class="form-control" />

                                     
                                </div>
                                <div class="col-6">

                                    <input type="text" id="Txtstopleave" readonly="readonly" class="form-control" />
                                   
                                </div>
                            </div>
                            </div>
                             <div id="Divparttime" style="display:none;">
                                <div class="row mt-3">
                                    <div class="col-6">
                                        <span>วันที่ลา</span>
                                    </div>
                                    <div class="col-6">
                                        <span>จากเวลา/ถึงเวลา</span>
                                    </div>
                                </div>
                          
                          
                                <div class="row mt-1">
                                <div class="col-6">
                                        <input type="text" id="Txtpartleave" readonly="readonly" class="form-control" />
                                    
                                </div>
                                <div class="col-6">
                                     <div class="input-group mb-3">
                                        <input type="text" id="Txtparttime" readonly="readonly" class="form-control" />
                                    </div>
                                </div>
                            </div>
                            </div>
                             <div class="row mt-3">
                                <div class="col-12">
                                    <span>รายละเอียดการลา</span>
                                </div>
                                <div class="col-12">
                                    <textarea id="Txtleavedesc" readonly="readonly" style="height:100px;" class="form-control" ></textarea>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-12">
                                    <span>ผู้ทำการแทน</span>
                                </div>
                                <div class="col-12">
                                       <input type="text" id="Txtdelegate" readonly="readonly" class="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" onclick="doApprove();" class="btn btn-success" style="border-radius: 2px; font-size: 18px;">อนุมัติ</button>
                    &nbsp;
                    <button type="button" onclick="doReject();" class="btn btn-danger" style="border-radius: 2px; font-size: 18px;">ไม่อนุมัติ</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" style="font-size: 18px; border-radius: 0;" data-dismiss="modal">ปิดหน้าต่าง</button>
                </div>

            </div>

          
        </div>
    </div>
    <input type="hidden" id="Hdapproveid" value="" /> 
</body>
</html>
