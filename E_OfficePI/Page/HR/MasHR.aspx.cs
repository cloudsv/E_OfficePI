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
namespace E_OfficePI.Page.HR
{
    public partial class MasHR : System.Web.UI.Page
    {
        public static string Connectionstring = ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string Consolidateleave(string json)
        {
            string id = "";
            ArrayList Arrcmd = new ArrayList();
            List<ClsDict> Dicts = new List<ClsDict>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string sqlcmd = "";
            DataTable Dt = new DataTable();
            if (ClsEngine.FindValue(Dicts, "Hdleavetype") == "")
            {
                return "โปรดระบุประเภทการลาก่อน";
            }
            if (ClsEngine.FindValue(Dicts, "Hdyear") == "")
            {
                return "โปรดระบุปีที่บันทึกการลาก่อน";
            }
            sqlcmd = "Select * from [Sys_HR_EmpLeave] where isdelete = 0 and Leavetype='" + ClsEngine.FindValue(Dicts, "Hdleavetype") + "' and  Year ='" + ClsEngine.FindValue(Dicts, "Hdyear") + "' and userid='" + ClsEngine.FindValue(Dicts, "userid") + "' and isdone= '1'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count == 0)
            {
                return "ไม่พบบุคคลากรที่จะยกยอดวันลาไป";
            }
            System.DateTime ObjDatetime = new DateTime(int.Parse(ClsEngine.FindValue(Dicts, "Hdyear")), 1, 1);
            
            //Insert
            id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_EmpLeave", "id");
            //Insert
            sqlcmd = " INSERT INTO [Sys_HR_EmpLeave] ";
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
            sqlcmd += "  ,'" + ObjDatetime.AddYears(1).Year + "'";
            sqlcmd += "  ,'" + Dt.Rows[0]["Remainleave"].ToString() +  "'"; //Prevtotalleave
            sqlcmd += "  ,'0'"; //Settingleave
            sqlcmd += "  ,'" + Dt.Rows[0]["Remainleave"].ToString() + "'"; //Total Leave
            sqlcmd += "  ,'0'"; //Currentleave
            sqlcmd += "  ,'" + Dt.Rows[0]["Remainleave"].ToString() + "'"; //Remainleave
            sqlcmd += "  ,'0'";
            sqlcmd += "  ,'0'";
            sqlcmd += "  ,'0'";
            sqlcmd += "  ,Getdate()";
            sqlcmd += "  ,'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            Arrcmd.Add(sqlcmd);

            sqlcmd = "  Update  [Sys_HR_EmpLeave] Set ";
            sqlcmd += " [Isconsolidate] ='1'";
            sqlcmd += " ,[ModifyDate] = getdate() ";
            sqlcmd += " ,[ModifyBy] = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += " Where ";
            sqlcmd += " [Userid]  = '" + ClsEngine.FindValue(Dicts, "userid") + "'";
            sqlcmd += " and [Leavetype] = '" + ClsEngine.FindValue(Dicts, "Hdleavetype") + "'";
            sqlcmd += " and [Year] = '" + ClsEngine.FindValue(Dicts, "Hdyear") + "'";
            Arrcmd.Add(sqlcmd);
            cn.Execute(Arrcmd, null);
            return "";
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
            if (ClsEngine.FindValue(Dicts, "Hdyear") ==  "")
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
            if (Dt.Rows.Count ==  0)
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
            cn.Execute(sqlcmd,null);
            return "";
        }
        [WebMethod]
        public static List<ClsDict> Getyear(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            ClsDict Objdict = new ClsDict();
            int minyear = System.DateTime.Now.AddYears(-10).Year;
            int maxyear = System.DateTime.Now.AddYears(+1).Year;
            int i = 0;
            if (minyear > 2500)
            {
                minyear -= 543;
            }
            if (maxyear > 2500)
            {
                maxyear -= 543;
            }
            for (i = minyear; i <= maxyear; i++)
            {
                Objdict = new ClsDict();
                Objdict.Name = (i + 543).ToString();
                Objdict.Val = i.ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsSettingLeave> Getsettingleave(string json)
        {
            //json += 'Cbsettingleaveyear:' + $('#Cbsettingleaveyear').val() + '|';
            //json += 'Cbsettingleavetype:' + $('#Cbsettingleavetype').val() + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            List<ClsSettingLeave> Objs = new List<ClsSettingLeave>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            ClsSettingLeave Obj;
            string sqlcmd = "";
            DataTable Dt = new DataTable();
            
            sqlcmd =  "  Select ";
            sqlcmd += "  emp.userid ";
            sqlcmd += " ,empno ";
            sqlcmd += " ,FirstnameTH ";
            sqlcmd += " ,LastnameTH ";
            sqlcmd += " ,Leavetype ";
            sqlcmd += " ,isnull(Prevtotalleave, 0) as Prevtotalleave ";
            sqlcmd += " ,isnull(Settingleave, 0) as Settingleave ";
            sqlcmd += " ,isnull(Totalleave, 0) as Totalleave ";
            sqlcmd += " ,isnull(Currentleave, 0) as Currentleave ";
            sqlcmd += " ,isnull(Remainleave, 0) as Remainleave ";
            sqlcmd += " ,Isdone  ";
            sqlcmd += " ,Isconsolidate  ";
            sqlcmd += " from Sys_HR_Empdetail emp  ";
            sqlcmd += " left ";
            sqlcmd += " join Sys_HR_EmpLeave L on emp.userid = L.userid and Leavetype = '" + ClsEngine.FindValue(Dicts, "Cbsettingleavetype") + "' and[Year] = '" + ClsEngine.FindValue(Dicts, "Cbsettingleaveyear") + "'";
            sqlcmd += " where emp.isdelete = 0 ";
           
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsSettingLeave();
                Obj.Userid = dr["userid"].ToString();
                Obj.Empno = dr["empno"].ToString();
                Obj.Firstname = dr["Firstnameth"].ToString();
                Obj.Lastname = dr["Lastnameth"].ToString();
                Obj.Leavetype = ClsEngine.FindValue(Dicts, "Cbsettingleavetype");
                Obj.Year = ClsEngine.FindValue(Dicts, "Cbsettingleaveyear");
                Obj.Prevtotalleave = dr["Prevtotalleave"].ToString();
                Obj.Settingleave = dr["Settingleave"].ToString();
                Obj.Totalleave = dr["Totalleave"].ToString();
                Obj.Currentleave = dr["Currentleave"].ToString();
                Obj.Remainleave = dr["Remainleave"].ToString();
                Obj.Isdone = dr["Isdone"].ToString();
                Obj.Isconsolidate = dr["Isconsolidate"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static List<ClsDict> Getleavetype(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,leavetypename from Sys_Master_leavetype where isdelete = 0 order by leavetypename";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            //Objdict = new ClsDict();
            //Objdict.Name = "--โปรดระบุ--";
            //Objdict.Val = "";
            //Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["leavetypename"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
    }
}