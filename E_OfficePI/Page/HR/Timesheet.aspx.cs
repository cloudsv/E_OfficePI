using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Services;
using SVframework2016;
using E_OfficePI.Class;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.HPSF;
using NPOI.HSSF.Util;
using NPOI.POIFS.FileSystem;
using NPOI.XSSF.Util;
using NPOI.XSSF.UserModel;
using NPOI.XSSF.Model;
using System.IO;
namespace E_OfficePI.Page.HR
{
    public partial class Timesheet : System.Web.UI.Page
    {
        public static string Connectionstring = ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string Export(string json)
        {
            string Filename = Guid.NewGuid().ToString();
            string Path = System.Configuration.ConfigurationManager.AppSettings["Initial_Templated"].ToString();
            FileStream fs = new FileStream(Path, FileMode.Open, FileAccess.ReadWrite);
            Path = System.Configuration.ConfigurationManager.AppSettings["Initial_OutputFolder"].ToString() + @"\" + Filename + ".xls";
            FileStream fsout = new FileStream(Path, FileMode.Create);
            HSSFWorkbook templateWorkbook = new HSSFWorkbook(fs, true);
            HSSFSheet sheet = (HSSFSheet)templateWorkbook.GetSheet("Sheet1");
            HSSFRow row1 = null;
            HSSFCell dataCell;
            int r = 0;
            int c = 0;
            DataTable Dt = new DataTable();
            Dt = ((DataTable)HttpContext.Current.Session["TS"]);
            row1 = (HSSFRow)sheet.CreateRow(r);
            foreach (DataColumn DC in Dt.Columns)
            {
                dataCell = (HSSFCell)row1.CreateCell(c);
                dataCell.SetCellValue(DC.ColumnName);
                dataCell.CellStyle.IsLocked = true;
                c++;
            }
            r++;
            c = 0;
            foreach (DataRow e_dr in Dt.Rows)
            {
                row1 = (HSSFRow)sheet.CreateRow(r);
                foreach (DataColumn DC in Dt.Columns)
                {
                    dataCell = (HSSFCell)row1.CreateCell(c);
                    dataCell.SetCellValue(e_dr[DC.ColumnName].ToString().Trim());
                    dataCell.CellStyle.IsLocked = true;
                    c++;
                }
                c = 0;
                r++;
            }
            sheet.ForceFormulaRecalculation = true;
            templateWorkbook.Write(fsout);
            fsout.Flush();
            fsout.Close();
            fsout.Dispose();
            return System.Configuration.ConfigurationManager.AppSettings["Initial_OutputUrl"].ToString() + @"/" + Filename + ".xls";
        }
    
        [WebMethod]
        public static string Saveleave(string json)
        {
            //json = 'userid :' + x + '|';
            //json += 'settingleave :' + $('#Txtsettingleave_' + x).val() + '|';
            //json += 'Hdleavetype :' + $('#Hdleavetype').val() + '|';
            //json += 'Hdyear :' + $('#Hdyear').val() + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            string sqlcmd = "";
            string id = "";
            DataTable Dt = new DataTable();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dicts = ClsEngine.DeSerialized(json, ':', '|');

            if (ClsEngine.FindValue(Dicts, "Hdleavetype") == "")
            {
                return "โปรดระบุประเภทการลาก่อน";
            }
            if (ClsEngine.FindValue(Dicts, "Hdyear") == "")
            {
                return "โปรดระบุปีที่บันทึกการลาก่อน";
            }
            if (ClsEngine.FindValue(Dicts, "settingleave") == "")
            {
                return "วันลาที่กำหนดห้ามเป็นค่าว่าง";
            }
            if (int.Parse(ClsEngine.FindValue(Dicts, "settingleave")) == 0)
            {
                return "วันลาที่กำหนดห้ามน้อยกว่าหรือเท่ากับ 0";
            }
            id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_EmpLeave", "id");
            //ตรวจก่อนว่ามีข้อมูลหรือไม่
            sqlcmd = "Select * from [Sys_HR_EmpLeave] where isdelete = 0 and Leavetype='" + ClsEngine.FindValue(Dicts, "Hdleavetype") + "' and  Year ='" + ClsEngine.FindValue(Dicts, "Hdyear") + "' and userid='" + ClsEngine.FindValue(Dicts, "userid") + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count == 0)
            {
                //Insert
                sqlcmd = " INSERT INTO  [Sys_HR_EmpLeave] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[Userid] ";
                sqlcmd += " ,[Leavetype] ";
                sqlcmd += " ,[Year] ";
                sqlcmd += " ,[Prevtotalleave] ";
                sqlcmd += " ,[Settingleave] ";
                sqlcmd += " ,[Totalleave] ";
                sqlcmd += " ,[Currentleave] ";
                sqlcmd += " ,[Remainleave] ";
                sqlcmd += " ,[Isdone] ";
                sqlcmd += " ,[Isconsolidate] ";
                sqlcmd += " ,[Isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " VALUES (";
                sqlcmd += "  '" + id + "'";
                sqlcmd += "  ,'" + ClsEngine.FindValue(Dicts, "userid") + "'";
                sqlcmd += "  ,'" + ClsEngine.FindValue(Dicts, "Hdleavetype") + "'";
                sqlcmd += "  ,'" + ClsEngine.FindValue(Dicts, "Hdyear") + "'";
                sqlcmd += "  ,'0'"; //Prevtotalleave
                sqlcmd += "  ,'" + ClsEngine.FindValue(Dicts, "settingleave") + "'"; //Settingleave
                sqlcmd += "  ,'" + ClsEngine.FindValue(Dicts, "settingleave") + "'"; //Total Leave
                sqlcmd += "  ,'0'"; //Currentleave
                sqlcmd += "  ,'" + ClsEngine.FindValue(Dicts, "settingleave") + "'"; //Remainleave
                sqlcmd += "  ,'1'";
                sqlcmd += "  ,'0'";
                sqlcmd += "  ,'0'";
                sqlcmd += "  ,Getdate()";
                sqlcmd += "  ,'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            }
            else
            {
                double Totalleave = double.Parse(Dt.Rows[0]["Totalleave"].ToString());
                double Prevtotalleave = double.Parse(Dt.Rows[0]["Prevtotalleave"].ToString());
                double Remainleave = double.Parse(Dt.Rows[0]["Remainleave"].ToString());
                double Currentleave = double.Parse(Dt.Rows[0]["Currentleave"].ToString());
                double settingleave = double.Parse(ClsEngine.FindValue(Dicts, "settingleave"));


                Totalleave = Prevtotalleave + settingleave;
                Remainleave = Totalleave - Currentleave;
                sqlcmd = "  Update  [Sys_HR_EmpLeave] Set ";
                sqlcmd += "  [Settingleave] = '" + settingleave + "'";
                sqlcmd += " ,[Totalleave]  ='" + Totalleave + "'";
                sqlcmd += " ,[Remainleave] ='" + Remainleave + "'";
                sqlcmd += " ,[Isdone] ='1'";
                sqlcmd += " ,[ModifyDate] = getdate() ";
                sqlcmd += " ,[ModifyBy] = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                sqlcmd += " Where ";
                sqlcmd += " [Userid]  = '" + ClsEngine.FindValue(Dicts, "userid") + "'";
                sqlcmd += " and [Leavetype] = '" + ClsEngine.FindValue(Dicts, "Hdleavetype") + "'";
                sqlcmd += " and [Year] = '" + ClsEngine.FindValue(Dicts, "Hdyear") + "'";
                //Update
            }
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static List<ClsDict> GetTSOrg(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            ClsDict Objdict = new ClsDict();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_Master_Organize where isdelete= 0  order by id";
            Dt = Cn.Select(sqlcmd);
            foreach(DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["Organizenameth"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static string GetToday(string json)
        {
            return ClsEngine.Convertdate2ddmmyyyy(System.DateTime.Now, "/", true);
        }
        [WebMethod]
        public static string CallBackUpload(string Label, string Running)
        {
            ArrayList Arrcmd = new ArrayList();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Trans_Attachment Where Id ='" + Running + "'";
            DataTable DtResult = new DataTable();
            string _path = Cn.Select(sqlcmd).Rows[0]["Path"].ToString();
            try
            {
                DtResult = ClsEngine.GetExcel(_path, true, "sheet1");
                List<ClsDict> Dicts = new List<ClsDict>();
                Dicts = (List<ClsDict>)HttpContext.Current.Session["datSearch"];
                sqlcmd = "Update Sys_HR_TimeSheet Set isdelete=1,Deletedate=getdate(),deleteby='sys' Where Transactiondate = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "TxtTSdate"), '/') + "' and Orgid ='" + ClsEngine.FindValue(Dicts, "CbTSOrg") + "'";
                Arrcmd.Add(sqlcmd);
                foreach (DataRow dr in DtResult.Rows)
                {
                    sqlcmd = " INSERT INTO [Sys_HR_TimeSheet] ";
                    sqlcmd += " ([Id] ";
                    sqlcmd += " ,[Userid] ";
                    sqlcmd += " ,[Empno] ";
                    sqlcmd += " ,[Orgid] ";
                    sqlcmd += " ,[TransactionDate] ";
                    sqlcmd += " ,[Intime] ";
                    sqlcmd += " ,[Outtime] ";
                    sqlcmd += " ,[Attachmentid] ";
                    sqlcmd += " ,[Isdone] ";
                    sqlcmd += " ,[IsDelete] ";
                    sqlcmd += " ,[CreateDate] ";
                    sqlcmd += " ,[CreateBy] ) ";
                    sqlcmd += " VALUES ( ";
                    sqlcmd += "'" + Guid.NewGuid().ToString() + "'";
                    sqlcmd += ",'" + dr["Userid"].ToString() + "'";
                    sqlcmd += ",'" + dr["Empno"].ToString() + "'";
                    sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CbTSOrg") + "'";
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "TxtTSdate"), '/') + "'";
                    sqlcmd += ",'" + dr["Intime"].ToString() + "'";
                    sqlcmd += ",'" + dr["Outtime"].ToString() + "'";
                    sqlcmd += ",'" + Running + "'";
                    sqlcmd += ",0";
                    sqlcmd += ",0";
                    sqlcmd += ",getdate()";
                    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    Arrcmd.Add(sqlcmd);
                }
                Cn.Execute(Arrcmd, null);
                return Running;
            }
            catch(Exception ex)
            {
                return ex.Message;
            }
        }
        [WebMethod]
        public static List<ClsTimeSheet> GetTimesheet(string json)
        {
            //json += 'CbTSOrg:' + $('#CbTSOrg').val() + '|';
            //json += 'TxtTSdate:' + $('#TxtTSdate').val() + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            List<ClsTimeSheet> Objs = new List<ClsTimeSheet>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            ClsTimeSheet Obj;
            string sqlcmd = "";
            DataTable Dt = new DataTable();

            sqlcmd = "  Select e.userid,e.empno,FirstnameTH,LastnameTH,Intime,Outtime from Sys_HR_Empdetail E Inner join Sys_Master_Organizeuser ou on e.userid = ou.Userid and ou.isdelete = 0 inner join Sys_Master_Organize o on ou.Orgid = o.id  and ou.isdelete = 0 left join Sys_HR_TimeSheet TS on e.userid = TS.Userid  and TS.isdelete = 0 and TransactionDate  = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "TxtTSdate"),'/') + "'";
            sqlcmd += " Where Ou.Orgid = '" + ClsEngine.FindValue(Dicts, "CbTSOrg") + "'";
            Dt = cn.Select(sqlcmd);
            HttpContext.Current.Session["TS"] = Dt;
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsTimeSheet();
                Obj.Userid = dr["userid"].ToString();
                Obj.Empno = dr["empno"].ToString();
                Obj.Firstname = dr["Firstnameth"].ToString();
                Obj.Lastname = dr["Lastnameth"].ToString();
                Obj.Intime = dr["Intime"].ToString();
                Obj.Outtime = dr["Outtime"].ToString();

                Objs.Add(Obj);
            }
            HttpContext.Current.Session["datSearch"] = Dicts;
            return Objs;
        }
     
    }
}