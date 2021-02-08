<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TQF5.aspx.cs" Inherits="E_OfficePI.Page.TQF.TQF5" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link href="../../js/datepicker/datepicker.css" rel="stylesheet" />
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
          function SearchapproveTQF() {
              var Cri = '';
              ClearResource('TQF/TQF5.aspx', 'Gvsearchcourseapprove');
              var Columns = ["วิชา!L", "รุ่น!C", "ปี!C", "สถานะ!C"];
              var Data = ["subjectname", "Generation", "Year", "Statusname"];
              var Searchcolumns = ["วิชา"];
              var SearchesDat = ["subjectname"];
              var Width = ["50%", "10%", "10%", "10%"];

              var Gvsearchcourse = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchcourseapprove', 1000, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', '', 'id', Cri, '');
              $('#Divsearchcourseapprove').html(Gvsearchcourse._Tables());
              Gvsearchcourse._Bind();
          }
          function SearchTQF() {
              var Cri = $('#Cbsearchcourse').val();
              ClearResource('TQF/TQF5.aspx', 'Gvsearchcourse');
              var Columns = ["วิชา!L", "รุ่น!C", "ปี!C", "!C", "สถานะ!C"];
              var Data = ["subjectname", "Generation", "Year", "Del", "Statusname"];
              var Searchcolumns = ["วิชา"];
              var SearchesDat = ["subjectname"];
              var Width = ["50%", "10%", "10%", "10%"];

              var Gvsearchcourse = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchcourse', 1000, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', '', 'id', Cri, '');
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
                  url: "\../Page/TQF/TQF5.aspx/Showcomment",
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
                      url: "\../Page/TQF/TQF5.aspx/Doreject",
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
                      url: "\../Page/TQF/TQF5.aspx/Doedit",
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
                      url: "\../Page/TQF/TQF5.aspx/Doapprove",
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
                          url: "\../Page/TQF/TQF5.aspx/Send2validate",
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
                  url: "\../Page/TQF/TQF5.aspx/SelectTQF",
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
                      url: "\../Page/TQF/TQF5.aspx/DelTQF",
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


        function Deleteteachingoutput(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divteachingoutput').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $('#Divteachingoutput').find('select').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateteachingoutput",
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
                        url: "\../Page/TQF/TQF5.aspx/Deleteteachingoutput",
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
                            Getteachingoutput();
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
        function Newteachingoutput() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divteachingoutput').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $('#Divteachingoutput').find('select').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });

            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateteachingoutput",
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
                        url: "\../Page/TQF/TQF5.aspx/Newteachingoutput",
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
                            Getteachingoutput();
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
        function Getteachingoutput() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Getteachingoutput",
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
                    html += '<td>ผลการเรียนรู้';
                    html += '</td>';
                    html += '<td>วิธีการสอนที่ระบุในรายละเอียดรายวิชา';
                    html += '</td>';
                    html += '<td>ประสิทธิผล';
                    html += '</td>';
                    html += '<td>อุปสรรคของการใช้กลยุทธ์พร้อมข้อเสนอแนะในการแก้ไข';
                    html += '</td>';
                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<span>หัวข้อ</span>';
                            html += '<textarea style="margin-bottom:5px;" id="TxtteachingoutputN_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Outputname'] + '</textarea>';
                            html += '<span>รายละเอียด</span>';
                            html += '<textarea style="margin-bottom:5px;" id="TxtteachingoutputD_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Outputdesc'] + '</textarea>';
                            html += '</td>';
                            html += '<td style="verticle-alignment:middle;">';
                            html += '<textarea style="margin-bottom:5px;" id="TxtteachingoutputM_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Method'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<Select style="margin-bottom:5px;" id="CbteachingoutputI_' + res[i]['id'] + '" class="form-control">';
                            if (res[i]['Isbenefit'] == "True") {
                                html += '<option  value="true" selected>มี</option>';
                                html += '<option value="false">ไม่มี</option>';
                            }
                            else {
                                html += '<option value="true">มี</option>';
                                html += '<option value="false" selected>ไม่มี</option>';
                            }
                            html += '</Select>';
                            html += '</td>';
                            html += '<td>';
                            html += '<span>ข้อมูลอุปสรรค</span>';
                            html += '<textarea style="margin-bottom:5px;" id="TxtteachingoutputP_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Problem'] + '</textarea>';
                            html += '<span>ข้อมูลข้อเสนอแนะในการแก้ไข</span>';
                            html += '<textarea style="margin-bottom:5px;" id="TxtteachingoutputS_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Solution'] + '</textarea>';
                            html += '</td>';
                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deleteteachingoutput(' + res[i]['id'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="5" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divteachingoutput').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }



        function Deleteoutline(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divoutline').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $('#Divoutline').find('input').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateoutline",
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
                        url: "\../Page/TQF/TQF5.aspx/Deleteoutline",
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
                            Getoutline();
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
        function Newoutline() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divoutline').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $('#Divoutline').find('input').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });

            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateoutline",
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
                        url: "\../Page/TQF/TQF5.aspx/Newoutline",
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
                            Getoutline();
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
        function Getoutline() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Getoutline",
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
                    html += '<td>หัวข้อ/รายละเอียด';
                    html += '</td>';
                    html += '<td>จำนวนชั่วโมง';
                    html += '</td>';
                    html += '<td>จำนวนชั่วโมงที่สอนจริง';
                    html += '</td>';
                    html += '<td>ระบุสาเหตุที่การสอนจริงต่างจากแผนการสอนหากมีความแตกต่างเกิน 25 %';
                    html += '</td>';
                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<span>หัวข้อ</span>';
                            html += '<textarea style="margin-bottom:5px;" id="TxtoutlineN_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Outlinename'] + '</textarea>';
                            html += '<span>รายละเอียด</span>';
                            html += '<textarea style="margin-bottom:5px;" id="TxtoutlineD_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Outlinedesc'] + '</textarea>';
                            html += '</td>';
                            html += '<td style="verticle-alignment:middle;">';
                            html += '<div class="row">';
                            html += '<div class="col-12">';
                            html += '<span>ชั่วโมง : นาที</span>';
                            html += '</div>';
                            html += '</div>';
                            html += '<div class="row">';
                            html += '<div class="col-12">';
                            html += '<input style="width:100px;" type="text" id="TxtoutlineT_' + res[i]['id'] + '" class="form-control" Value="' + res[i]['Planingtotalhour'] + '"/>';
                            html += '</div>';
                            html += '</div>';
                            html += '</td>';
                            html += '<td>';
                            html += '<div class="row">';
                            html += '<div class="col-6">';
                            html += '<span>ชั่วโมง</span>';
                            html += '</div>';
                            html += '<div class="col-6">';
                            html += '<span>นาที</span>';
                            html += '</div>';
                            html += '</div>';
                            html += '<div class="row">';
                            html += '<div class="col-6">';
                            html += '<input style="width:50px;" type="text" id="TxtoutlineH_' + res[i]['id'] + '" class="form-control"  Value="' + res[i]['Actualhour'] + '"/>';
                            html += '</div>';
                            html += '<div class="col-6">';
                            html += '<input style="width:50px;" type="text" id="TxtoutlineM_' + res[i]['id'] + '" class="form-control"  Value="' + res[i]['Actualminute'] + '"/>';
                            html += '</div>';
                            html += '</div>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtoutlineC_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Cause'] + '</textarea>';
                            html += '</td>';
                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deleteoutline(' + res[i]['id'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="5" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divoutline').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }


        function Deleteproblemmanagement(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divproblemmanagement').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
           
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateproblemmanagement",
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
                        url: "\../Page/TQF/TQF5.aspx/Deleteproblemmanagement",
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
                            Getproblemmanagement();
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
        function Newproblemmanagement() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divproblemmanagement').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });


            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateproblemmanagement",
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
                        url: "\../Page/TQF/TQF5.aspx/Newproblemmanagement",
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
                            Getproblemmanagement();
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
        function Getproblemmanagement() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Getproblemmanagement",
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
                    html += '<td>อุปสรรคด้านการบริหารและองค์กร';
                    html += '</td>';
                    html += '<td>ผลกระทบต่อการเรียนรู้';
                    html += '</td>';


                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<textarea id="TxtproblemmanagementP_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Problem'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtproblemmanagementI_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Impact'] + '</textarea>';
                            html += '</td>';


                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deleteproblemmanagement(' + res[i]['id'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="3" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divproblemmanagement').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }

        function Deleteproblemlearningresource(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divproblemlearningresource').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateproblemlearningresource",
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
                        url: "\../Page/TQF/TQF5.aspx/Deleteproblemlearningresource",
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
                            Getproblemlearningresource();
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
        function Newproblemlearningresource() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divproblemlearningresource').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });


            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateproblemlearningresource",
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
                        url: "\../Page/TQF/TQF5.aspx/Newproblemlearningresource",
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
                            Getproblemlearningresource();
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
        function Getproblemlearningresource() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Getproblemlearningresource",
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
                    html += '<td>อุปสรรคในการใช้แหล่งทรัพยากรประกอบการเรียนและสิ่งอำนวยความสะดวก';
                    html += '</td>';
                    html += '<td>ผลกระทบต่อการเรียนรู้';
                    html += '</td>';
                   

                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<textarea id="TxtproblemlearningresourceP_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Problem'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtproblemlearningresourceI_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Impact'] + '</textarea>';
                            html += '</td>';
                           

                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deleteproblemlearningresource(' + res[i]['id'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="3" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divproblemlearningresource').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }


        function Deleteverify(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divverify').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateverify",
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
                        url: "\../Page/TQF/TQF5.aspx/Deleteverify",
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
                            Getverify();
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
        function Newverify() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divverify').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });


            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateverify",
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
                        url: "\../Page/TQF/TQF5.aspx/Newverify",
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
                            Getverify();
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
        function Getverify() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Getverify",
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
                    html += '<td>วิธีการทวนสอบ';
                    html += '</td>';
                    html += '<td>สรุปผล';
                    html += '</td>';
                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<textarea id="TxtverifyM_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Method'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtverifyS_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Summary'] + '</textarea>';
                            html += '</td>';
                         
                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deleteverify(' + res[i]['id'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="3" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divverify').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }

        function Deletedeviate(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divdeviate').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updatedeviate",
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
                        url: "\../Page/TQF/TQF5.aspx/Deletedeviate",
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
                            Getdeviate();
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
        function Newdeviate() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divdeviate').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });


            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updatedeviate",
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
                        url: "\../Page/TQF/TQF5.aspx/Newdeviate",
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
                            Getdeviate();
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
        function Getdeviate() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Getdeviate",
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
                    html += '<td>ด้าน';
                    html += '</td>';
                    html += '<td>ความคลาดเคลื่อน';
                    html += '</td>';
                    html += '<td>เหตุผล';
                    html += '</td>';

                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<textarea id="TxtdeviateT_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Topic'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtdeviateD_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Deviate'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtdeviateR_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Remark'] + '</textarea>';
                            html += '</td>';

                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deletedeviate(' + res[i]['id'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="4" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divdeviate').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }


        function Deleteproposal(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divproposal').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateproposal",
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
                        url: "\../Page/TQF/TQF5.aspx/Deleteproposal",
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
                            Getproposal();
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
        function Newproposal() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divproposal').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });


            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateproposal",
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
                        url: "\../Page/TQF/TQF5.aspx/Newproposal",
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
                            Getproposal();
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
        function Getproposal() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Getproposal",
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
                    html += '<td>กิจกรรมที่ต้องการ';
                    html += '</td>';
                    html += '<td>วันที่สิ้นสุดกิจกรรม';
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
                            html += '<textarea id="TxtproposalE_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Event'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtproposalD_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Eventdue'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtproposalR_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Responsible'] + '</textarea>';
                            html += '</td>';

                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deleteproposal(' + res[i]['id'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="4" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divproposal').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Updatetransition() {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divtransition').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updatetransition",
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
                    Gettransition();
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Gettransition() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Gettransition",
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
                    html += '<td>การเปลี่ยนแปลง';
                    html += '</td>';
                    html += '<td>ขอเสนอแนะ/ข้อคิดเห็นเพื่อการวางแผนในอนาคต';
                    html += '</td>';

                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td colspan="2">';
                            html += '<span>' + res[i]['Transition'] + '</span>';
                            html += '</td>';
                            html += '</tr>';
                            html += '<tr>';
                            html += '<td>';
                            html += '<textarea onblur="Updatetransition();" id="TxttransitionD_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Transitiondesc'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea onblur="Updatetransition();" id="TxttransitionR_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Remark'] + '</textarea>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="2" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divtransition').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Deletecoteacherplanning(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divcoteacherplanning').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updatecoteacherplanning",
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
                        url: "\../Page/TQF/TQF5.aspx/Deletecoteacherplanning",
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
                            Getcoteacherplanning();
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
        function Newcoteacherplanning() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divcoteacherplanning').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });


            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updatecoteacherplanning",
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
                        url: "\../Page/TQF/TQF5.aspx/Newcoteacherplanning",
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
                            Getcoteacherplanning();
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
        function Getcoteacherplanning() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Getcoteacherplanning",
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
                    html += '<td>แผนการเตรียม';
                    html += '</td>';
                    html += '<td>การเตรียมที่ต่างจากแผน';
                    html += '</td>';
                    html += '<td>ข้อเสนอแนะ / ข้อคิดเห็นเพื่อการวางแผนในอนาคต';
                    html += '</td>';

                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<textarea id="TxtcoteacherplanningP_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Primaryplan'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtcoteacherplanningS_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Secondaryplan'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtcoteacherplanningR_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Remark'] + '</textarea>';
                            html += '</td>';

                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deletecoteacherplanning(' + res[i]['id'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="4" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divcoteacherplanning').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Deleteteacherplanning(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divteacherplanning').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateteacherplanning",
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
                        url: "\../Page/TQF/TQF5.aspx/Deleteteacherplanning",
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
                            Getteacherplanning();
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
        function Newteacherplanning() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divteacherplanning').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });


            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateteacherplanning",
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
                        url: "\../Page/TQF/TQF5.aspx/Newteacherplanning",
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
                            Getteacherplanning();
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
        function Getteacherplanning() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Getteacherplanning",
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
                    html += '<td>แผนการเตรียม';
                    html += '</td>';
                    html += '<td>การเตรียมที่ต่างจากแผน';
                    html += '</td>';
                    html += '<td>ข้อเสนอแนะ / ข้อคิดเห็นเพื่อการวางแผนในอนาคต';
                    html += '</td>';

                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<textarea id="TxtteacherplanningP_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Primaryplan'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtteacherplanningS_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Secondaryplan'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtteacherplanningR_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Remark'] + '</textarea>';
                            html += '</td>';

                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deleteteacherplanning(' + res[i]['id'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="4" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divteacherplanning').html(html);
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Deletestudentplanning(x) {
            var json = $('#HdTQFId').val();
            var dat = '';
            $('#Divstudentplanning').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updatestudentplanning",
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
                        url: "\../Page/TQF/TQF5.aspx/Deletestudentplanning",
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
                            Getstudentplanning();
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
        function Newstudentplanning() {
            var json = $('#HdTQFId').val();
            var dat = '';

            $('#Divstudentplanning').find('textarea').each(function () {
                dat += $(this).attr('id') + ':' + $(this).val() + '|';
            });


            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updatestudentplanning",
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
                        url: "\../Page/TQF/TQF5.aspx/Newstudentplanning",
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
                            Getstudentplanning();
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
        function Getstudentplanning() {
            var json = $('#HdTQFId').val();
            var html = '';
            var count = 0;
            var i = 0;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Getstudentplanning",
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
                    html += '<td>แผนการเตรียม';
                    html += '</td>';
                    html += '<td>การเตรียมที่ต่างจากแผน';
                    html += '</td>';
                    html += '<td>ข้อเสนอแนะ / ข้อคิดเห็นเพื่อการวางแผนในอนาคต';
                    html += '</td>';

                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {
                            html += '<tr>';
                            html += '<td>';
                            html += '<textarea id="TxtstudentplanningP_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Primaryplan'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtstudentplanningS_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Secondaryplan'] + '</textarea>';
                            html += '</td>';
                            html += '<td>';
                            html += '<textarea id="TxtstudentplanningR_' + res[i]['id'] + '" class="form-control" style="height: 80px;">' + res[i]['Remark'] + '</textarea>';
                            html += '</td>';

                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deletestudentplanning(' + res[i]['id'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    }
                    else {
                        html += '<tr><td colspan="4" style="text-align:center;color:red;margin-top:10px;">ไม่พบข้อมูล</td></tr>'
                    }
                    html += '</table>'
                    $('#Divstudentplanning').html(html);
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
                url: "TQF/TQF5.aspx/Selectedtextbook",
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
                url: "TQF/TQF5.aspx/Selectedebook",
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
                url: "TQF/TQF5.aspx/Selectedinquiry",
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
                url: "TQF/TQF5.aspx/Selectedjournal",
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
                url: "TQF/TQF5.aspx/Selectedtool",
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
            ClearResource('TQF/TQF5.aspx', 'Gvsearchtextbook');
            var Cri = $('#HdTQFId').val();
            var Columns = ["Textbook!L"];
            var Data = ["Textbook"];
            var Searchcolumns = ["Textbook!L"];
            var SearchesDat = ["Textbook"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchtextbook', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divtextbookcont').html(Gv._Tables());
            Gv._Bind();
            $('#Divmodaltextbook').modal('show');
        }
        function Newebook() {
            ClearResource('TQF/TQF5.aspx', 'Gvsearchebook');
            var Cri = $('#HdTQFId').val();
            var Columns = ["E-Book!L"];
            var Data = ["Ebook"];
            var Searchcolumns = ["E-Book"];
            var SearchesDat = ["Ebook"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchebook', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divebookcont').html(Gv._Tables());
            Gv._Bind();
            $('#Divmodalebook').modal('show');
        }
        function Newinquiry() {
            ClearResource('TQF/TQF5.aspx', 'Gvsearchinquiry');
            var Cri = $('#HdTQFId').val();
            var Columns = ["ระบบสืบค้น!L"];
            var Data = ["Inquiry"];
            var Searchcolumns = ["ระบบสืบค้น"];
            var SearchesDat = ["Inquiry"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchinquiry', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divinquirycont').html(Gv._Tables());
            Gv._Bind();
            $('#Divmodalinquiry').modal('show');
        }
        function Newjournal() {
            ClearResource('TQF/TQF5.aspx', 'Gvsearchjournal');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วารสารวิชาการ!L"];
            var Data = ["Journal"];
            var Searchcolumns = ["วารสารวิชาการ"];
            var SearchesDat = ["Journal"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchjournal', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divjournalcont').html(Gv._Tables());
            Gv._Bind();
            $('#Divmodaljournal').modal('show');
        }
        function Newtool() {
            ClearResource('TQF/TQF5.aspx', 'Gvsearchtool');
            var Cri = $('#HdTQFId').val();
            var Columns = ["เครื่องมือ!L"];
            var Data = ["tool"];
            var Searchcolumns = ["เครื่องมือ"];
            var SearchesDat = ["tool"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchtool', 30, Width, Data, "", '', '2', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divtoolcont').html(Gv._Tables());
            Gv._Bind();
            $('#Divmodaltool').modal('show');
        }
        function Bindnewobjective() {

            ClearResource('TQF/TQF5.aspx', 'Gvnewobjective');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วัตถุประสงค์!L"];
            var Data = ["Objective"];
            var Searchcolumns = ["วัตถุประสงค์!L"];
            var SearchesDat = ["Objective"];
            var Width = ["100%"];
            var Gvnewobjective = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvnewobjective', 30, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', 'id', 'id', Cri, '');
            $('#Divmodalobjectivecont').html(Gvnewobjective._Tables());
            Gvnewobjective._Bind();
        }

        function Bindebook() {
            ClearResource('TQF/TQF5.aspx', 'Gvebook');
            var Cri = $('#HdTQFId').val();
            var Columns = ["E-Book!L"];
            var Data = ["Ebook"];
            var Searchcolumns = ["E-Book"];
            var SearchesDat = ["Ebook"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvebook', 30, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divebook').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindinquiry() {

            ClearResource('TQF/TQF5.aspx', 'Gvinquiry');
            var Cri = $('#HdTQFId').val();
            var Columns = ["ระบบสืบค้น!L"];
            var Data = ["Inquiry"];
            var Searchcolumns = ["ระบบสืบค้น"];
            var SearchesDat = ["Inquiry"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvinquiry', 30, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divinquiry').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindjournal() {

            ClearResource('TQF/TQF5.aspx', 'Gvjournal');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วารสารวิชาการ!L"];
            var Data = ["Journal"];
            var Searchcolumns = ["วารสารวิชาการ"];
            var SearchesDat = ["Journal"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvjournal', 30, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divjournal').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindtool() {

            ClearResource('TQF/TQF5.aspx', 'Gvtool');
            var Cri = $('#HdTQFId').val();
            var Columns = ["ตำรารอง / เอกสารเพิ่มเติม!L"];
            var Data = ["tool"];
            var Searchcolumns = ["ตำรารอง / เอกสารเพิ่มเติม"];
            var SearchesDat = ["tool"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvtool', 30, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divtool').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindtextbook() {

            ClearResource('TQF/TQF5.aspx', 'Gvtextbook');
            var Cri = $('#HdTQFId').val();
            var Columns = ["Textbook!L"];
            var Data = ["Textbook"];
            var Searchcolumns = ["Textbook!L"];
            var SearchesDat = ["Textbook"];
            var Width = ["100%"];
            var Gv = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvtextbook', 30, Width, Data, "", '', '', '', '', '1', '', '', '', 'id', '', '', 'id', Cri, '');
            $('#Divtextbook').html(Gv._Tables());
            Gv._Bind();
        }
        function Bindnewobjective() {

            ClearResource('TQF/TQF5.aspx', 'Gvnewobjective');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วัตถุประสงค์!L"];
            var Data = ["Objective"];
            var Searchcolumns = ["วัตถุประสงค์!L"];
            var SearchesDat = ["Objective"];
            var Width = ["100%"];
            var Gvnewobjective = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvnewobjective', 30, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', 'id', 'id', Cri, '');
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
                url: "\../Page/TQF/TQF5.aspx/Updatetqfestimate",
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
                url: "\../Page/TQF/TQF5.aspx/Updatetqfestimateobj",
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
                url: "\../Page/TQF/TQF5.aspx/Updatetqftrainingsource",
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
                url: "\../Page/TQF/TQF5.aspx/UpdatetqfserviceLv",
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
                url: "\../Page/TQF/TQF5.aspx/Updatetqfquality",
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
        function Updatetqfparticular(ctrl) {
            var json = '';


            json += 'ctrl:' + ctrl + '|';

            json += 'val:' + $('#' + ctrl).prop("checked") + '|';
            json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updatetqfparticular",
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
                url: "\../Page/TQF/TQF5.aspx/Getestimate",
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
            var x = 0;
            var isfound = false;
            var res;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Gettraining",
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
                    html += '<td>แหล่งฝึก';
                    html += '</td>';
                    html += '<td>ระดับสถานบริการ';
                    html += '</td>';
                    html += '<td>ระบบคุณภาพ';
                    html += '</td>';
                    html += '<td>&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                    if (res.length > 0) {
                        for (i = 0; i < res.length; i++) {

                            html += '<tr>';
                            html += '<td>';
                            for (j = 0; j < res[i]['Templatetrainingsource'].length; j++) {
                                html += '<div>';
                                isfound = false;
                                for (x = 0; x < res[i]['Trainingsource'].length; x++) {
                                    if (res[i]['Templatetrainingsource'][j]['Trainingsourceid'] == res[i]['Trainingsource'][x]['Trainingsourceid']) {
                                        isfound = true;
                                    }
                                }
                                if (isfound) {
                                    html += '<input type="checkbox" id="Chktrainingsource_' + res[i]['Trainingid'] + '_' + res[i]['Templatetrainingsource'][j]['Trainingsourceid'] + '" onclick="Updatetqftrainingsource(\'Chktrainingsource_' + res[i]['Trainingid'] + '_' + res[i]['Templatetrainingsource'][j]['Trainingsourceid'] + '\');" checked />&nbsp;<span>' + res[i]['Templatetrainingsource'][j]['Trainingsourcename'] + '</span>';
                                }
                                else {
                                    html += '<input type="checkbox" id="Chktrainingsource_' + res[i]['Trainingid'] + '_' + res[i]['Templatetrainingsource'][j]['Trainingsourceid'] + '" onclick="Updatetqftrainingsource(\'Chktrainingsource_' + res[i]['Trainingid'] + '_' + res[i]['Templatetrainingsource'][j]['Trainingsourceid'] + '\');" />&nbsp;<span>' + res[i]['Templatetrainingsource'][j]['Trainingsourcename'] + '</span>';
                                }
                                html += '<div>';
                            }
                            html += '</td>';
                            html += '<td>';
                            for (j = 0; j < res[i]['TemplateserviceLv'].length; j++) {
                                html += '<div>';
                                isfound = false;
                                for (x = 0; x < res[i]['ServiceLv'].length; x++) {
                                    if (res[i]['TemplateserviceLv'][j]['ServiceLvid'] == res[i]['ServiceLv'][x]['ServiceLvid']) {
                                        isfound = true;
                                    }
                                }
                                if (isfound) {
                                    html += '<input type="checkbox" id="ChkserviceLv_' + res[i]['Trainingid'] + '_' + res[i]['TemplateserviceLv'][j]['ServiceLvid'] + '" onclick="UpdatetqfserviceLv(\'ChkserviceLv_' + res[i]['Trainingid'] + '_' + res[i]['TemplateserviceLv'][j]['ServiceLvid'] + '\');" checked />&nbsp;<span>' + res[i]['TemplateserviceLv'][j]['ServiceLvname'] + '</span>';
                                }
                                else {
                                    html += '<input type="checkbox" id="ChkserviceLv_' + res[i]['Trainingid'] + '_' + res[i]['TemplateserviceLv'][j]['ServiceLvid'] + '" onclick="UpdatetqfserviceLv(\'ChkserviceLv_' + res[i]['Trainingid'] + '_' + res[i]['TemplateserviceLv'][j]['ServiceLvid'] + '\');" />&nbsp;<span>' + res[i]['TemplateserviceLv'][j]['ServiceLvname'] + '</span>';
                                }
                                html += '<div>';
                            }
                            html += '</td>';
                            html += '<td>';
                            for (j = 0; j < res[i]['Templatequality'].length; j++) {
                                html += '<div>';
                                isfound = false;
                                for (x = 0; x < res[i]['Quality'].length; x++) {
                                    if (res[i]['Templatequality'][j]['Qualityid'] == res[i]['Quality'][x]['Qualityid']) {
                                        isfound = true;
                                    }
                                }
                                if (isfound) {
                                    html += '<input type="checkbox" id="Chkquality_' + res[i]['Trainingid'] + '_' + res[i]['Templatequality'][j]['Qualityid'] + '" onclick="Updatetqfquality(\'Chkquality_' + res[i]['Trainingid'] + '_' + res[i]['Templatequality'][j]['Qualityid'] + '\');" checked />&nbsp;<span>' + res[i]['Templatequality'][j]['Qualityname'] + '</span>';
                                }
                                else {
                                    html += '<input type="checkbox" id="Chkquality_' + res[i]['Trainingid'] + '_' + res[i]['Templatequality'][j]['Qualityid'] + '" onclick="Updatetqfquality(\'Chkquality_' + res[i]['Trainingid'] + '_' + res[i]['Templatequality'][j]['Qualityid'] + '\');" />&nbsp;<span>' + res[i]['Templatequality'][j]['Qualityname'] + '</span>';
                                }
                                html += '<div>';
                            }
                            html += '</td>';
                            html += '<td style="vertical-align: middle;">';
                            html += '<button onclick="Deletetraining(' + res[i]['Trainingid'] + ');" class="btn btn-danger" style="border-radius: 1px;"><span class="fa fa-trash" style="color: white;"></span></button>';
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

                    $('#Divtraining').html(html);
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
            var x = 0;
            var isfound = false;
            var res;
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Getlearningoutput",
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
                    for (i = 0; i < res.length; i++) {

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
                            for (x = 0; x < res[i]['Particulars'].length; x++) {
                                if (res[i]['Templateparticulars'][j]['Particularid'] == res[i]['Particulars'][x]['Particularid']) {
                                    isfound = true;
                                }
                            }
                            if (isfound) {
                                html += '<input type="checkbox" id="Chklearningoutputparticular_' + res[i]['Learningoutputid'] + '_' + res[i]['Templateparticulars'][j]['Particularid'] + '" onclick="Updatetqfparticular(\'Chklearningoutputparticular_' + res[i]['Learningoutputid'] + '_' + res[i]['Templateparticulars'][j]['Particularid'] + '\');" checked />&nbsp;<span>' + res[i]['Templateparticulars'][j]['Particularname'] + '</span>';
                            }
                            else {
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
                    url: "\../Page/TQF/TQF5.aspx/Addnewobjective",
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

            ClearResource('TQF/TQF5.aspx', 'Gvnewobjective');
            var Cri = $('#HdTQFId').val();
            var Columns = ["วัตถุประสงค์!L"];
            var Data = ["Objective"];
            var Searchcolumns = ["วัตถุประสงค์!L"];
            var SearchesDat = ["Objective"];
            var Width = ["100%"];
            var Gvnewobjective = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvnewobjective', 30, Width, Data, "", '', '', '', '', '', '', '', '', 'id', '', 'id', 'id', Cri, '');
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
                url: "\../Page/TQF/TQF5.aspx/Getoutcome",
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
                        html += '<select class="form-control" onChange="Updateoutcome(\'' + res[i]['TQFoutcomeId'] + '\',\'Cboutcome_' + res[i]['TQFoutcomeId'] + '\');" id="Cboutcome_' + res[i]['TQFoutcomeId'] + '">';
                        if (res[i]['IsOK'] == "True") {
                            html += '<option Selected value="True">มี</option>';
                            html += '<option value="False">ไม่มี</option>';
                        }
                        else {
                            html += '<option value="True">มี</option>';
                            html += '<option Selected value="False">ไม่มี</option>';
                        }

                        html += '</select>';
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
                url: "\../Page/TQF/TQF5.aspx/Deleteestimate",
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
                url: "\../Page/TQF/TQF5.aspx/Deletetraining",
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
                url: "\../Page/TQF/TQF5.aspx/Updatereport",
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
                        url: "\../Page/TQF/TQF5.aspx/Deletereport",
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
                url: "\../Page/TQF/TQF5.aspx/Updateevent",
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
                        url: "\../Page/TQF/TQF5.aspx/Deleteevent",
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
                url: "\../Page/TQF/TQF5.aspx/Newestimate",
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
                url: "\../Page/TQF/TQF5.aspx/Newtraining",
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
                url: "\../Page/TQF/TQF5.aspx/Updatereport",
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
                        url: "\../Page/TQF/TQF5.aspx/Newreport",
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
                url: "\../Page/TQF/TQF5.aspx/Updateevent",
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
                        url: "\../Page/TQF/TQF5.aspx/Newevent",
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
                url: "\../Page/TQF/TQF5.aspx/Updatedevelopobjective",
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
                        url: "\../Page/TQF/TQF5.aspx/Deletedevelopobjective",
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
                url: "\../Page/TQF/TQF5.aspx/Updatedevelopobjective",
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
                        url: "\../Page/TQF/TQF5.aspx/Newdevelopobjective",
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
                url: "\../Page/TQF/TQF5.aspx/Getreport",
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
                url: "\../Page/TQF/TQF5.aspx/Getevent",
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
                            }
                            else {
                                html += '<option value="I" selected>เดี่ยว</option>';
                                html += '<option value="G" >กลุ่ม</option>';
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
                url: "\../Page/TQF/TQF5.aspx/Getdevelopobjective",
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
                url: "\../Page/TQF/TQF5.aspx/Getobjective",
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
            if (menu == "1") {
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
                    url: "\../Page/TQF/TQF5.aspx/Save",
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
                var json = $('#HdTQFId').val();
                var dat = '';

                $('#Divoutline').find('textarea').each(function () {
                    dat += $(this).attr('id') + ':' + $(this).val() + '|';
                });
                $('#Divoutline').find('input').each(function () {
                    dat += $(this).attr('id') + ':' + $(this).val() + '|';
                });

                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF5.aspx/Updateoutline",
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
                        $('#Divteachingoutput').find('textarea').each(function () {
                            dat += $(this).attr('id') + ':' + $(this).val() + '|';
                        });
                        $('#Divteachingoutput').find('Select').each(function () {
                            dat += $(this).attr('id') + ':' + $(this).val() + '|';
                        });
                        $.ajax({
                            type: "POST",
                            url: "\../Page/TQF/TQF5.aspx/Updateteachingoutput",
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
                                json = '';
                                json += 'menu:' + menu + '|';
                                json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                                json += 'Txtuncovetopic:' + $('#Txtuncovetopic').val() + '|';
                                json += 'Txtproposalforimprove:' + $('#Txtproposalforimprove').val() + '|';
                                $.ajax({
                                    type: "POST",
                                    url: "\../Page/TQF/TQF5.aspx/Save",
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
            else if (menu == "3") {
                
                var json = $('#HdTQFId').val();
                var dat = '';

                $('#Divdeviate').find('textarea').each(function () {
                    dat += $(this).attr('id') + ':' + $(this).val() + '|';
                });


                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF5.aspx/Updatedeviate",
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
                        $('#Divverify').find('textarea').each(function () {
                            dat += $(this).attr('id') + ':' + $(this).val() + '|';
                        });
                        $.ajax({
                            type: "POST",
                            url: "\../Page/TQF/TQF5.aspx/Updateverify",
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
                                json = '';
                                json += 'menu:' + menu + '|';
                                json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                                json += 'Cbisissueabnormalpoint:' + $('#Cbisissueabnormalpoint').val() + '|';
                                $.ajax({
                                    type: "POST",
                                    url: "\../Page/TQF/TQF5.aspx/Save",
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
            else if (menu == "4") {
                Msgboxsuccess('บันทึกเรียบร้อยแล้ว');
            }
            else if (menu == "5") {
              
                json += 'menu:' + menu + '|';
                json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                json += 'Txtestimatebystudent:' + $('#Txtestimatebystudent').val() + '|';
                json += 'Txtteacherremark2estimatebystudent:' + $('#Txtteacherremark2estimatebystudent').val() + '|';
                json += 'Txtestimateother:' + $('#Txtestimateother').val() + '|';
                json += 'Txtteacherremark2estimateother:' + $('#Txtteacherremark2estimateother').val() + '|';
                json += 'Txtother:' + $('#Txtother').val() + '|';
               
                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF5.aspx/Save",
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
            else if (menu == "6") {
                var json = $('#HdTQFId').val();
                var dat = '';

                $('#Divproposal').find('textarea').each(function () {
                    dat += $(this).attr('id') + ':' + $(this).val() + '|';
                });


                $.ajax({
                    type: "POST",
                    url: "\../Page/TQF/TQF5.aspx/Updateproposal",
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
                        json = '';
                        json += 'menu:' + menu + '|';
                        json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
                        json += 'Txtimproveresult:' + $('#Txtimproveresult').val() + '|';
                        json += 'Txtimproveprevioustraining:' + $('#Txtimproveprevioustraining').val() + '|';
                        json += 'Cbisfeedbackfromtrainingtoteacher:' + $('#Cbisfeedbackfromtrainingtoteacher').val() + '|';

                        
                        
                        
                        $.ajax({
                            type: "POST",
                            url: "\../Page/TQF/TQF5.aspx/Save",
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

            }
        }
        function Deleteobjective(TQFObjectiveid) {
            var json = '';
            json += TQFObjectiveid;

            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Deleteobjective",
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
                url: "\../Page/TQF/TQF5.aspx/Updateoutcome",
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
                },
                async: true,
                error: function (er) {

                }
            });
        }
        function Updateratio(Estimateid, ctrl) {
            var json = '';
            json += 'Estimateid:' + Estimateid + '|';
            json += 'val:' + $('#' + ctrl).val() + '|';
            $.ajax({
                type: "POST",
                url: "\../Page/TQF/TQF5.aspx/Updateratio",
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
                url: "\../Page/TQF/TQF5.aspx/Updateobjectiveremark",
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
                url: "\../Page/TQF/TQF5.aspx/Updatetext",
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
            ClearResource('TQF/TQF5.aspx', 'Gvsearchinstuctor');
            var Cri = x + '|' + $('#HdTQFId').val();
            var Columns = ["ชื่อ!L", "นามสกุล!L", "คุณวุฒิ!L"];
            var Data = ["firstname", "lastname", "Educationbackground"];
            var Searchcolumns = ["ชื่อ", "นามสกุล", "คุณวุฒิ"];
            var SearchesDat = ["firstname", "lastname", "Educationbackground"];
            var Width = ["20%", "20%", "60%"];
            var Gvsearchinstuctor = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchinstuctor', 1000, Width, Data, "", '', '2', '', '', '', '', '', '', 'm.Userid', 'm.Userid', '', 'm.Userid', Cri, '');
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
                url: "\../Page/TQF/TQF5.aspx/Getnewsubject",
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
                url: "\../Page/TQF/TQF5.aspx/Getnewyear",
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
                url: "\../Page/TQF/TQF5.aspx/Getnewclass",
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
                url: "\../Page/TQF/TQF5.aspx/Getnewterm",
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
                url: "\../Page/TQF/TQF5.aspx/Getcourse",
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
                url: "\../Page/TQF/TQF5.aspx/Getnewcollege",
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

            ClearResource('TQF/TQF5.aspx', 'GvregisterStudent');
            var Columns = ["รหัสนักศึกษา!L", "ชื่อ!L", "นามสกุล!L", "วันที่ลงทะเบียน!C"];
            var Data = ["Studentno", "Firstname", "Lastname", "Registerdate"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วิชา"];
            var SearchesDat = ["Studentno", "Firstname", "Lastname"];
            var Width = ["20%", "30%", "30%", "20%"];
            var GvregisterStudent = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'GvregisterStudent', 30, Width, Data, "", '', '', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#Divregistationsubject').html(GvregisterStudent._Tables());
            GvregisterStudent._Bind();
        }
        function BindresponsibleInstructor() {
            var Cri = $('#HdTQFId').val();
            ClearResource('TQF/TQF5.aspx', 'GvresponsibleInstructor');
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!C", "ประสบการณ์การสอนในสาขาที่เกี่ยวข้อง (จำนวนปี)!C"];
            var Data = ["Firstname", "Lastname", "Educationalbackground", "Exp"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "Educationalbackground"];
            var Width = ["20%", "20%", "20%", "40%"];
            var GvresponsibleInstructor = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'GvresponsibleInstructor', 1000, Width, Data, "", '', '', 'เพิ่มอาจารย์ผู้รับผิดชอบรายวิชา', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#DivresponsibleInstructor').html(GvresponsibleInstructor._Tables());
            GvresponsibleInstructor._Bind();
        }
        function BindtheoryInstructor() {
            var Cri = $('#HdTQFId').val();
            ClearResource('TQF/TQF5.aspx', 'GvtheoryInstructor');
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!C", "ประสบการณ์การสอนในสาขาที่เกี่ยวข้อง (จำนวนปี)!C"];
            var Data = ["Firstname", "Lastname", "Educationalbackground", "Exp"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "Educationalbackground"];
            var Width = ["20%", "20%", "20%", "40%"];
            var GvtheoryInstructor = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'GvtheoryInstructor', 1000, Width, Data, "", '', '', 'เพิ่มอาจารย์ภาคทฤษฎี', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#DivtheoryInstructor').html(GvtheoryInstructor._Tables());
            GvtheoryInstructor._Bind();
        }
        function BindextraInstructor() {

            var Cri = $('#HdTQFId').val();
            ClearResource('TQF/TQF5.aspx', 'GvextraInstructor');
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!C", "ประสบการณ์การสอนในสาขาที่เกี่ยวข้อง (จำนวนปี)!C"];
            var Data = ["Firstname", "Lastname", "Educationalbackground", "Exp"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "Educationalbackground"];
            var Width = ["20%", "20%", "20%", "40%"];
            var GvextraInstructor = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'GvextraInstructor', 1000, Width, Data, "", '', '', 'เพิ่มอาจารย์สอนภาคปฏิบัติ', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#DivextraInstructor').html(GvextraInstructor._Tables());
            GvextraInstructor._Bind();
        }

        function BindpreInstructor() {

            var Cri = $('#HdTQFId').val();
            ClearResource('TQF/TQF5.aspx', 'GvpreInstructor');
            var Columns = ["ชื่อ!L", "นามสกุล!L", "วุฒิการศึกษา!C", "ประสบการณ์การสอนในสาขาที่เกี่ยวข้อง (จำนวนปี)!C"];
            var Data = ["Firstname", "Lastname", "Educationalbackground", "Exp"];
            var Searchcolumns = ["หมวดวิชา", "หน่วยงานที่รับผิดชอบ", "วุฒิการศึกษา"];
            var SearchesDat = ["Firstname", "Lastname", "Educationalbackground"];
            var Width = ["20%", "20%", "20%", "40%"];
            var GvpreInstructor = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'GvpreInstructor', 1000, Width, Data, "", '', '', 'เพิ่มอาจารย์พิเศษ', '', '1', '', '', '', 'id', 'id', '', 'id', Cri, '');
            $('#DivpreInstructor').html(GvpreInstructor._Tables());
            GvpreInstructor._Bind();
        }

        function LoadTQFInfo(id) {
            var json = id;
            $.ajax({
                type: "POST",
                url: "TQF/TQF5.aspx/LoadTQFInfo",
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
                    if (res['Isissueabnormalpoint'] != '') {
                        $('#Cbisissueabnormalpoint').val(res['Isissueabnormalpoint']);
                    }

                    $('#Txtestimatebystudent').val(res['Estimatebystudent']);
                    $('#Txtteacherremark2estimatebystudent').val(res['Teacherremark2estimatebystudent']);
                    $('#Txtestimateother').val(res['Estimateother']);
                    
                    $('#Txtteacherremark2estimateother').val(res['TeacherRemark2estimateother']);
                    $('#Txtother').val(res['Other']);

                    $('#Txtpreviousimprove').val(res['Previousimprove']);
                    $('#Txtimproveresult').val(res['Improveresult']);
                    $('#Txtimproveprevioustraining').val(res['Improveprevioustraining']);
                    if (res['Isfeedbackfromtrainingtoteacher'] != '') {
                        $('#Cbisfeedbackfromtrainingtoteacher').val(res['Isfeedbackfromtrainingtoteacher']);
                    }

                    $('#Txtuncovetopic').val(res['Uncovetopic']);
                    $('#Txtproposalforimprove').val(res['Proposalforimprove']);
                    Getoutline();
                    Getteachingoutput();
                    Getdeviate();
                    Getverify();
                    Getproblemlearningresource();
                    Getproblemmanagement();
                    Getproposal();

                    BindresponsibleInstructor();
                    BindtheoryInstructor();
                    BindextraInstructor();
                    BindpreInstructor();
                  
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
                url: "TQF/TQF5.aspx/DonewTQF",
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
                url: "TQF/TQF5.aspx/Selectedinstuctor",
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
                url: "\../Page/TQF/TQF5.aspx/Getcourse",
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
        //    ClearResource('TQF/TQF5.aspx', 'Gvsearchcourse');
        //    var Columns = ["วิชา!L", "รุ่น!C", "ปี!C", "สถานะ!C"];
        //    var Data = ["subjectname", "Generation", "Year", "Statusname"];
        //    var Searchcolumns = ["วิชา"];
        //    var SearchesDat = ["subjectname"];
        //    var Width = ["50%", "10%", "10%", "10%"];

        //    var Gvsearchcourse = new Grid("TQF/TQF5.aspx", Columns, SearchesDat, Searchcolumns, 'Gvsearchcourse', 30, Width, Data, "", '', '', '', '', '', '', '', '', 'id', 'id', '', 'id', Cri, '');
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
                url: "\../Page/TQF/TQF5.aspx/Iseducate",
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
                    ข้อมูล มคอ.5 รายละเอียดของรายวิชา
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
                    ข้อมูลการอนุมัติ มคอ.5 
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
                                                     
                                                    <input id="Txtsubjectname" type="text" class="form-control" />
       
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
                                                    <input id="Txtsubjectdesc" type="text" class="form-control" style="display:none;" />
                                                    <select id="Cbsubjectgroup" class="form-control" ></select>
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
                                        <h6>8. สถานที่เรียน</h6>
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
                                <h6>หมวดที่ 2 การจัดการเรียนการสอนเปรียบเทียบกับแผนการสอน</h6>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. แผนการสอน</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newoutline();">เพิ่มแผนการสอน</button>
                                            </div>
                                            
                                            <div class="col-12" id="Divoutline" style="margin-top:20px;">
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
                                        <h6>2. หัวข้อที่สอนไม่ครอบคลุมตามแผน</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtuncovetopic" class="form-control" style="height: 100px;"></textarea>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>3. ประสิทธิผลของวิธีการสอนที่ทำให้เกิดผลการเรียนรู้ตามที่ระบุไว้ในรายละเอียดของรายวิชา</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                             <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newteachingoutput();">เพิ่มประสิทธิผลของวิธีการสอน</button>
                                            </div>
                                            <div class="col-12" style="margin-top:20px;" id="Divteachingoutput">
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
                                        <h6>4. ข้อเสนอการดำเนินการเพื่อปรับปรุงวิธีการสอน</h6>
                                    </div>
                                    <div class="card-body">

                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtproposalforimprove" class="form-control" style="height: 100px;"></textarea>
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
                                <button class="btn btn-info" style="border-radius: 1px;" onclick="Save('3');">บันทึกหมวด</button>
                            </div>
                        </div>
                        <div class="row mt-1">
                            <div class="col-12">
                                <hr />
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-12" style="text-align: center;">
                                <h6>หมวดที่ 3 สรุปผลการจัดการเรียนการสอนของรายวิชา</h6>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. ข้อมูลนิสิต/นักศึกษา</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <table class="table table-bordered">
                                                        <tbody>
                                                            <tr>
                                                                <td style="width: 40%; text-align: right;"><b>จำนวนผู้เรียนที่ลงทะเบียนเรียน</b></td>
                                                                <td style="width: 20%; text-align: center;"><b>0</b></td>
                                                                <td style="text-align: left; width: 60%;"><b>คน</b></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: right;"><b>จำนวนผู้เรียนที่คงอยู่เมือสิ้นสุดภาคการศึกษา</b></td>
                                                                <td style="vertical-align: middle; text-align: center;"><b></b></td>
                                                                <td style="text-align: left; width: 60%; vertical-align: middle;"><b>คน</b></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: right;"><b>จำนวนผู้เรียนที่ถอน</b></td>
                                                                <td style="vertical-align: middle; text-align: center;"><b>0</b></td>
                                                                <td style="text-align: left; width: 60%; vertical-align: middle;"><b>คน</b></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
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
                                        <h6>2. การกระจายของระดับคะแนน (เกรด)</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <table class="table table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 40%">ระดับคะแนน</th>
                                                                <th>จำนวน(คน)</th>
                                                                <th>คิดเป็นร้อยละ</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td style="width: 33%; text-align: center;">A</td>
                                                                <td style="width: 33%; text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('A'),1)"></a></b></td>
                                                                <td style="width: 33%; text-align: center;">-</td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center;">B+</td>
                                                                <td style="text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('B+'),1)"></a></b></td>
                                                                <td style="text-align: center;">-</td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center;">B</td>
                                                                <td style="text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('B'),1)"></a></b></td>
                                                                <td style="text-align: center;">-</td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center;">C+</td>
                                                                <td style="text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('C+'),1)"></a></b></td>
                                                                <td style="text-align: center;">-</td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center;">C</td>
                                                                <td style="text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('C'),1)"></a></b></td>
                                                                <td style="text-align: center;">-</td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center;">D+</td>
                                                                <td style="text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('D+'),1)"></a></b></td>
                                                                <td style="text-align: center;">-</td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center;">D</td>
                                                                <td style="text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('D'),1)"></a></b></td>
                                                                <td style="text-align: center;">-</td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center;">F</td>
                                                                <td style="text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('F'),1)"></a></b></td>
                                                                <td style="text-align: center;">-</td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center;">ไม่สมบูรณ์ (I)</td>
                                                                <td style="text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('I'),1)"></a></b></td>
                                                                <td style="text-align: center;">-</td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center;">การเรียนการสอนยังไม่สิ้นสุด (P)</td>
                                                                <td style="text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('P'),1)"></a></b></td>
                                                                <td style="text-align: center;">-</td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center;">ผ่าน (S)</td>
                                                                <td style="text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('S'),1)"></a></b></td>
                                                                <td style="text-align: center;">-</td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center;">ตก (U)</td>
                                                                <td style="text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('U'),1)"></a></b></td>
                                                                <td style="text-align: center;">-</td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center;">ถอน (W)</td>
                                                                <td style="text-align: center;"><b><a href="javascript:void(0)" onmousedown="show_studen(encodeURIComponent('W'),1)"></a></b></td>
                                                                <td style="text-align: center;">-</td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
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
                                        <h6>3. ปัจจัยที่ทำให้ระดับคะแนนผิดปกติ</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <select id="Cbisissueabnormalpoint" class="form-control">
                                                        <option value="True">มี</option>
                                                        <option value="False" selected>ไม่มี</option>
                                                    </select>
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
                                        <h6>4. ความคลาดเคลื่อนจากแผนการประเมินที่กำหนดไว้ในรายละเอียดรายวิชา</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newdeviate();">เพิ่มความคลาดเคลื่อน</button>
                                                </div>

                                                <div class="col-12" id="Divdeviate" style="margin-top: 20px;">
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
                                        <h6>5. การทวนสอบผลสัมฤทธิ์ของผู้เรียน</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newverify();">เพิ่มการทวนสอบ</button>
                                                </div>

                                                <div class="col-12" id="Divverify" style="margin-top: 20px;">
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
                                <h6>หมวดที่ 4 ปัญหาและผลกระทบต่อการดำเนินการ</h6>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. ประเด็นด้านทรัพยากรประกอบการเรียนและสิ่งอำนวยความสะดวก</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newproblemlearningresource();">เพิ่มประเด็นด้านทรัพยากรประกอบการเรียนและสิ่งอำนวยความสะดวก</button>
                                                </div>

                                                <div class="col-12" id="Divproblemlearningresource" style="margin-top: 20px;">
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
                                        <h6>2. ประเด็นด้านการบริหารและองค์กร</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newproblemmanagement();">เพิ่มประเด็นด้านการบริหารและองค์กร</button>
                                                </div>

                                                <div class="col-12" id="Divproblemmanagement" style="margin-top: 20px;">
                                                </div>
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
                                <h6>หมวดที่ 5 การประเมินรายวิชา</h6>
                            </div>
                        </div>



                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. ผลการประเมินรายวิชาโดยผู้เรียน</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <span>5.1.1 ข้อวิพากษ์ที่สำคัญจากผลการประเมินโดยผู้เรียน</span>
                                        </div>
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtestimatebystudent" class="form-control" style="height: 100px;"></textarea>
                                        </div>
                                        <div class="container" style="font-size: 1em !important;">
                                            <span>5.1.2 ความเห็นของอาจารย์ผู้สอนต่อข้อวิพากษ์ตามข้อ 5.1.1</span>
                                        </div>
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtteacherremark2estimatebystudent" class="form-control" style="height: 100px;"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>2. ผลการประเมินรายวิชาโดยวิธีอื่น</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <span>5.2.1 ข้อวิพากษ์ที่สำคัญจากผลการประเมินโดยวิธีอื่น</span>
                                        </div>
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtestimateother" class="form-control" style="height: 100px;"></textarea>
                                        </div>
                                        <div class="container" style="font-size: 1em !important;">
                                            <span>5.2.2 ความเห็นของอาจารย์ผู้สอนต่อข้อวิพากษ์ตามข้อ 5.2.1</span>
                                        </div>
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtteacherremark2estimateother" class="form-control" style="height: 100px;"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>3. อื่นๆ (เช่น การบริหารความเสี่ยง)</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtother" class="form-control" style="height: 100px;"></textarea>
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
                                <h6>หมวดที่ 6 แผนการปรับปรุง</h6>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>1. ความก้าวหน้าของการปรับปรุงการเรียนการสอนตามที่เสนอในรายงาน/รายวิชาครั้งที่ผ่านมา</h6>
                                    </div>
                                    <div class="card-body">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th style="width: 50%; text-align: center">แผนการปรับปรุงของภาคเรียน/ปีการศึกษาที่ผ่านมา</th>
                                                    <th style="width: 50%; text-align: center">ผลการดำเนินการ</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <textarea readonly="readonly" id="Txtpreviousimprove" class="form-control input-lg" style="resize: none; height: 200px;"></textarea></td>

                                                    <td>
                                                        <textarea class="form-control" id="Txtimproveresult" style="height: 200px;"></textarea></td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>2. การดำเนินการอื่นๆในการปรับปรุงรายวิชา/รายวิชาครั้งที่ผ่านมา</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <textarea id="Txtimproveprevioustraining" class="form-control" style="height: 100px;"></textarea>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6>3. ข้อเสนอแผนการปรับปรุงสำหรับภาคเรียน/ปีการศึกษาต่อไป</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <div class="row mt-1">
                                                <div class="col-12">
                                                    <button class="btn btn-primary" onclick="Newproposal();">เพิ่มเอกสารและข้อมูลสำคัญ</button>
                                                </div>

                                                <div class="col-12" id="Divproposal" style="margin-top: 20px;">
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
                                        <h6>4. ข้อเสนอแนะของอาจารย์ผู้รับผิดชอบรายวิชาต่ออาจารย์ผู้รับผิดชอบหลักสูตร</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="container" style="font-size: 1em !important;">
                                            <select id="Cbisfeedbackfromtrainingtoteacher" class="form-control">
                                                <option value="True">มี</option>
                                                <option value="False" selected>ไม่มี</option>
                                            </select>
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
            <input type="hidden" id="Hdapprove" value="" />
        <input type="hidden" id="Hdlearningsetid" value="" />
        <a id="back2Top" title="Back to top" href="#">&#10148;</a>
</body>
</html>
