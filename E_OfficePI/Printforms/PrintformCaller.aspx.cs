using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SVframework2016; 
using System.Data;
using System.Net;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.ReportAppServer;
using System.IO;
using E_OfficePI.Class;
using Newtonsoft.Json; 
using System.Configuration;  

namespace E_OfficePI.Printforms
{
    public partial class PrintformCaller : System.Web.UI.Page
    {
        public static string Connectionstring = ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;
        string PF_PDFPath = System.Configuration.ConfigurationManager.AppSettings["PF_PDFPath"];
        protected void Page_Load(object sender, EventArgs e)
        {

            SqlConnector Cn = null;
            try
            {

                if (Request["Val"] != null)
                {
                    string PrintformCode = "";
                    string ProjectCode = "";
                    string Engine = "";
                    string sqlcmd = "";
                    string Cmd = "";
                    Cn = new SqlConnector(Connectionstring,null);
                    DataTable DtPrintform = new DataTable();
                    DataTable DtPrintformParameter = new DataTable();
                    ClsEngine Obj = new ClsEngine();
                    List<ClsDict> Values = new List<ClsDict>();
                    List<ClsDict> ObjResults = new List<ClsDict>();
                    List<ClsDict> Parameters = new List<ClsDict>();
                   
                    Values = ClsEngine.DeSerialized(ClsEngine.Base64Decode(Request["Val"].ToString()), '=', '&');

                    if (ClsEngine.FindValue(Values, "Cmd") == "INVHISTORY")
                    {

                        sqlcmd = "select * from sys_trans_printform Where Id = '" + ClsEngine.FindValue(Values, "PrintformId") + "'";
                        string Filename = Cn.Select(sqlcmd).Rows[0]["FileName"].ToString();
                        //string PF_PDFPath = ClsEngine.GetConfigurationValue(Cn, ClsEngine.PF_PDFPath().ToString());
                        string filepath = PF_PDFPath + Filename;
                        WebClient User = new WebClient();
                        Byte[] FileBuffer = User.DownloadData(filepath);
                        if (FileBuffer != null)
                        {
                            Response.ContentType = "application/pdf";
                            Response.AddHeader("content-length", FileBuffer.Length.ToString());
                            Response.BinaryWrite(FileBuffer);
                        }
                    }
                    else
                    {
                        foreach (ClsDict ObjVal in Values)
                        {
                            if (ObjVal.Name == ClsEngine.PrintformCodeKey())
                            {
                                PrintformCode = ObjVal.Val;
                            }
                            else if (ObjVal.Name == ClsEngine.ProjectCodeKey())
                            {
                                ProjectCode = ObjVal.Val;
                            }
                            else if (ObjVal.Name == ClsEngine.EngineKey())
                            {
                                Engine = ObjVal.Val;
                            }
                            else if (ObjVal.Name == ClsEngine.CmdKey())
                            {
                                Cmd = ObjVal.Val;
                            }
                        }
                        sqlcmd = "Select * from Sys_Conf_Printform Where PrintformId = '" + PrintformCode + "' and isdelete = 0 ";
                        if (ProjectCode != "")
                        {
                            sqlcmd += " and ProjectCode = '" + ProjectCode + "' ";
                        }
                        DtPrintform = Cn.Select(sqlcmd);

                        if (DtPrintform.Rows.Count > 0)
                        {
                            sqlcmd = "Select * from Sys_Conf_PrintformParameter Where PrintformId = '" + PrintformCode + "' ";
                            DtPrintformParameter = Cn.Select(sqlcmd);
                            foreach (DataRow dr in DtPrintformParameter.Rows)
                            {
                                foreach (ClsDict ObjVal in Values)
                                {
                                    if (dr["UrlParameter"].ToString().ToLower() == ObjVal.Name.ToLower())
                                    {
                                        ClsDict ObjParameter = new ClsDict();
                                        ObjParameter.Name = dr["ParameterName"].ToString();
                                        ObjParameter.Val = ObjVal.Val;
                                        Parameters.Add(ObjParameter);
                                    }
                                }
                            }
                            //Parameters ready ! and Print form have a only one record
                            if (Engine == ClsEngine.CrystalReportEngineKey())
                            {
                                CrystalReportPF(DtPrintform, Parameters, Cmd);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<font style='color:red;font-size:16px;'>" + ex.Message + "</font>");
            }
            finally
            {

            }
        }
        private void CrystalReportPF(DataTable Dtprintform, List<ClsDict> Parameters, string Cmd)
        {
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            string path = Dtprintform.Rows[0]["PrintformPath"].ToString().Trim();
            string StoreProc = Dtprintform.Rows[0]["StoreProc"].ToString().Trim();
            string PrintformId = Dtprintform.Rows[0]["PrintformId"].ToString().Trim();
            string StoreProcCommand = ""; 
            //string PF_PDFPath = ObjFMSPro.GetConfigurationValue(Cn, ClsSiamCar.PF_PDFPath());
            string sqlcmd = "Exec " + StoreProc;
            string password = "";
            System.Collections.ArrayList ArrCmd = new System.Collections.ArrayList();
            DataTable Dt = new DataTable();
            DataTable DtSubReport = new DataTable();
            DataTable DtSubReportItem = new DataTable();
            int i = 0;
            foreach (ClsDict ObjParameter in Parameters)
            {
                if (i > 0)
                {
                    sqlcmd += ",";
                }
                sqlcmd += "'" + ObjParameter.Val + "'";
                i++;
            }
            Dt = Cn.Select(sqlcmd);
            StoreProcCommand = sqlcmd;
            ReportDocument cryRpt = new ReportDocument();
            cryRpt.Load(path);
            ExportOptions CrExportOptions;

            DiskFileDestinationOptions CrDiskFileDestinationOptions = new DiskFileDestinationOptions();
            PdfRtfWordFormatOptions CrFormatTypeOptions = new PdfRtfWordFormatOptions();

            Dt.TableName = "Test";
            cryRpt.SetDataSource(Dt);
            //Sub Report Section
            //Validate Sub Report 
            //User Parameter from Main Report 
            string[] SupReportParametrers = { };
            sqlcmd = "Select * from sys_conf_subprintform where isdelete = 0 and PrintformId = '" + PrintformId + "'";
            DtSubReport = Cn.Select(sqlcmd);
            foreach (DataRow s_dr in DtSubReport.Rows)
            {
                i = 0;
                SupReportParametrers = s_dr["Parameters"].ToString().Split(',');
                sqlcmd = "Exec " + s_dr["StoreProc"].ToString() + " ";
                DtSubReportItem = new DataTable();
                foreach (ClsDict ObjParameter in Parameters)
                {
                    foreach (string strsubparam in SupReportParametrers)
                    {
                        if (ObjParameter.Name == strsubparam)
                        {
                            if (i > 0)
                            {
                                sqlcmd += ",";
                            }
                            sqlcmd += "'" + ObjParameter.Val + "'";
                            i++;
                        }
                    }
                }
                DtSubReportItem = Cn.Select(sqlcmd);
                cryRpt.Subreports[s_dr["SubPrintformName"].ToString()].Database.Tables[0].SetDataSource(DtSubReportItem);
            }

            PdfFormatOptions formatOpt = new PdfFormatOptions();
            formatOpt.FirstPageNumber = 0;
            formatOpt.LastPageNumber = 0;
            formatOpt.UsePageRange = false;
            formatOpt.CreateBookmarksFromGroupTree = false;

            string filepath = PF_PDFPath + Guid.NewGuid() + ".pdf";
            CrDiskFileDestinationOptions.DiskFileName = filepath;
            CrExportOptions = cryRpt.ExportOptions;

            {
                CrExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
                CrExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;
                CrExportOptions.DestinationOptions = CrDiskFileDestinationOptions;
                CrExportOptions.FormatOptions = CrFormatTypeOptions;
                CrExportOptions.ExportFormatOptions = formatOpt;
            }

            cryRpt.Export();

            WebClient User = new WebClient();
            Byte[] FileBuffer = User.DownloadData(filepath);
            if (FileBuffer != null)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-length", FileBuffer.Length.ToString());
                Response.BinaryWrite(FileBuffer);
            }

            //Save to History Log Bin Mode
            //byte[] file;
            //string RunningNo;
            //Cn.ObjectCommand = new System.Data.SqlClient.SqlCommand();
            //using (var stream = new FileStream(filepath, FileMode.Open, FileAccess.Read))
            //{
            //    using (var reader = new BinaryReader(stream))
            //    {
            //        file = reader.ReadBytes((int)stream.Length);
            //    }
            //}
            //RunningNo = ObjFMSPro.GenerateRunningId(Cn.Connectionstring, "Sys_Trans_Printform", "Id");
            //sqlcmd = "INSERT INTO [Sys_Trans_Printform] ([Id],[SessionId],[FileName],[Password],[PrinformId],[StoreProcCommand],[Path],[Bin],[Createdate],[CreateBy]) ";
            //sqlcmd += "VALUES('" + RunningNo + "','" + HttpContext.Current.Session.SessionID + "','" + new FileInfo(filepath).Name + "','" + password + "','" + new FileInfo(path).Name + "','" + StoreProcCommand.Replace("'","|") + "','" + filepath + "',@File,'" + System.DateTime.Now + "','" + ((ClsMy)HttpContext.Current.Session["My"]).Username + "')";
            //Cn.ObjectCommand.Parameters.Add("@File", SqlDbType.VarBinary, file.Length).Value = file;
            //Save to History Log Bin Mode
            string RunningNo;
            RunningNo = ClsEngine.GenerateRunningId(Cn.Connectionstring, "Sys_Trans_Printform", "Id");
            sqlcmd = "INSERT INTO [Sys_Trans_Printform] ([Id],[SessionId],[FileName],[Password],[PrinformId],[StoreProcCommand],[Path],[Createdate],[CreateBy]) ";
            sqlcmd += "VALUES('" + RunningNo + "','" + HttpContext.Current.Session.SessionID + "','" + new FileInfo(filepath).Name + "','" + password + "','" + new FileInfo(path).Name + "','" + StoreProcCommand.Replace("'", "|") + "','" + filepath + "','" + System.DateTime.Now + "','SYS')";
            Cn.Execute(sqlcmd, null);
            CrystalReportViewer1.ReportSource = cryRpt; 
            Cn.Close();
            Cn.Dispose();
            cryRpt.Close();
            cryRpt.Dispose();
            GC.Collect();
        }

    }
}