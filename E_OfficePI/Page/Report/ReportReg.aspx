<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportReg.aspx.cs" Inherits="E_OfficePI.Page.Report.ReportReg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body>
    <div class="container-fluid"  style="font-family: TH SarabunPSK; background-color: white; padding: 10px; width: 95%; min-height: 800px;margin-top: 30px;"> 
                            <div class="container">
                                <div class="row">
                                    <div  class="col-8" style="margin-bottom:10px;margin-top:10px;font-size:16px;">
                                        <span style="color:black;"><u>รายงานระบบทะเบียนและประมวลผล</u></span>
                                    </div>
                                    <div class="col-4" style="text-align: right;margin-bottom:10px;margin-top:10px;">
                                          <div class="input-group">
                                            <input type="text" class="form-control" style="border-radius: 1px;font-size:14px;" id="Txtsearchreport" placeholder="รหัสรายงาน,ชื่อรายงาน"/><button class="btn btn-primary waves-effect waves-light pull-right" style="border-radius: 1px;font-size:14px;">ค้นหา</button>
                                         </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <hr />
                                    </div>
                                </div>
                                 <div class="row">
                                    <div class="col-12">
                                       <div class="card">
                                          <div class="card-body">
                                            <div class="container">
                                                    <div class="row">
                                                    <div class="col-12" style="text-align:center;color:red;min-height:600px;margin-bottom:10px;">
                                                        ไม่พบรายงาน
                                                    </div>
                                                        </div>
                                              <%--  <div class="row">
                                                    <div class="col-3" style="text-align:right;">
                                                        <img style="width:40px;" src="https://png.pngtree.com/element_our/png_detail/20181206/report-vector-icon-png_260865.jpg" />
                                                    </div>
                                                    <div class="col-9">
                                                        <div style="color:blue;font-weight:bold;" >REP-0001 รายงานผลการเรียน</div>
                                                       
                                                        <div style="color:gray;font-size:0.8em;">ระบบทะเบียนนักศึกษา</div>
                                                    </div>
                                                </div>--%>
                                               
                                            </div>
                                          </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
    </div>
</body>
</html>
