using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using SVframework2016;
using System.Data;
using E_OfficePI.Class;
using System.Collections;
namespace E_OfficePI.Page.TQF
{
    public partial class TQF4 : System.Web.UI.Page
    {
        private static string Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;
        [WebMethod]
        public static string Deleteoutcome(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_Outcome Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Updateoutcome(string json, string dat)
        {
           

            //TxtdevoO_1: 1 | TxtdevoD_1:2 | TxtdevoS_1:3 | TxtdevoR_1:4 | TxtdevoO_4:5 | TxtdevoD_4:6 | TxtdevoS_4:7 | TxtdevoR_4:8 |
            dat = dat.Replace("Txtoutcome_", "");
            string sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            string[] Arrcomp;
            Arrcomp = dat.Split('|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            foreach (string str in Arrcomp)
            {
                if (str.Trim() != "")
                {

                    sqlcmd = "Update Sys_TQF_Outcome set Value ='" + str.Split(':')[1] + "',modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + str.Split(':')[0] + "'";
                    Arrcmd.Add(sqlcmd);
                }


            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }
        [WebMethod]
        public static string Newoutcome(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Outcome", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_Outcome] ";
            sqlcmd += " ([Id]";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[IsDelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[Createby])";
            sqlcmd += " Values(";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Savequality(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_quality", "Id");
            string sqlcmd = "";
            if (json == "")
            {
                return "ข้อมูลห้ามเป็นค่าว่าง";
            }
            if (cn.Select("Select * from sys_master_quality where isdelete =0 and name ='" + json.Replace(",", "").Replace("'", "") + "'").Rows.Count > 0)
            {
                return "รายการ " + json.Replace(",", "").Replace("'", "") + " ซ้ำ โปรดตรวจสอบ";
            }

            sqlcmd += " INSERT INTO [Sys_Master_quality] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[name]  ";
            sqlcmd += " ,[Isdelete]  ";
            sqlcmd += " ,[Createdate]  ";
            sqlcmd += " ,[CreateBy] ) ";
            sqlcmd += " VALUES ";
            sqlcmd += " ('" + id + "'";
            sqlcmd += ",'" + json.Replace(",", "").Replace("'", "") + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }


        [WebMethod]
        public static string Saveservicelv(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_servicelv", "Id");
            string sqlcmd = "";
            if (json == "")
            {
                return "ข้อมูลห้ามเป็นค่าว่าง";
            }
            if (cn.Select("Select * from sys_master_servicelv where isdelete =0 and name ='" + json.Replace(",", "").Replace("'", "") + "'").Rows.Count > 0)
            {
                return "รายการ " + json.Replace(",", "").Replace("'", "") + " ซ้ำ โปรดตรวจสอบ";
            }

            sqlcmd += " INSERT INTO [Sys_Master_servicelv] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[name]  ";
            sqlcmd += " ,[Isdelete]  ";
            sqlcmd += " ,[Createdate]  ";
            sqlcmd += " ,[CreateBy] ) ";
            sqlcmd += " VALUES ";
            sqlcmd += " ('" + id + "'";
            sqlcmd += ",'" + json.Replace(",", "").Replace("'", "") + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }


        [WebMethod]
        public static string Savetrainingsource(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_trainingsource", "Id");
            string sqlcmd = "";
            if (json == "")
            {
                return "ข้อมูลห้ามเป็นค่าว่าง";
            }
            if (cn.Select("Select * from sys_master_trainingsource where isdelete =0 and name ='" + json.Replace(",", "").Replace("'", "") + "'").Rows.Count > 0)
            {
                return "รายการ " + json.Replace(",", "").Replace("'", "") + " ซ้ำ โปรดตรวจสอบ";
            }

            sqlcmd += " INSERT INTO [Sys_Master_trainingsource] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[name]  ";
            sqlcmd += " ,[Isdelete]  ";
            sqlcmd += " ,[Createdate]  ";
            sqlcmd += " ,[CreateBy] ) ";
            sqlcmd += " VALUES ";
            sqlcmd += " ('" + id + "'";
            sqlcmd += ",'" + json.Replace(",", "").Replace("'", "") + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }


     

            [WebMethod]
        public static string Deltrainingsource(string json)
        {
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string Trainingid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Trainingid");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_trainingsource set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and Trainingid='" + Trainingid + "' and trainingsourceid ='" + val + "'";
            cn.Execute(sqlcmd, null);
            return "";

        }

        
        [WebMethod]
        public static string Deltraining(string json)
        {
 
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string Trainingid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Trainingid");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_Training set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and Id='" + Trainingid +  "'";
            cn.Execute(sqlcmd, null);
            return "";

        }

        [WebMethod]
        public static string Delservicelv(string json)
        {
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string Trainingid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Trainingid");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_ServiceLv set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and Trainingid='" + Trainingid + "' and Servicelvid ='" + val + "'";
            cn.Execute(sqlcmd, null);
            return "";

        }
        [WebMethod]
        public static string Delquality(string json)
        {
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string Trainingid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Trainingid");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_Quality set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and Trainingid='" + Trainingid + "' and qualityid ='" + val + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Updatequality(string json)
        {
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string Trainingid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Trainingid").Split('_')[1];
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = "";
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_quality set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and Trainingid ='" + Trainingid + "'";
            cn.Execute(sqlcmd, null);
            id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_quality", "id");
            sqlcmd = " INSERT INTO [Sys_TQF_quality] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[Trainingid]";
            sqlcmd += " ,[qualityid]";
            sqlcmd += " ,[Isdelete]";
            sqlcmd += " ,[Createdate]";
            sqlcmd += " ,[CreateBy] )";
            sqlcmd += " VALUES ( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + TQFId + "'";
            sqlcmd += ",'" + Trainingid + "'";
            sqlcmd += ",'" + val + "'";
            sqlcmd += ",'0'";
            sqlcmd += ",Getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }

        [WebMethod]
        public static string Updatetrainingsource(string json)
        {
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string Trainingid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Trainingid").Split('_')[1];
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = "";
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_trainingsource set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and Trainingid ='" + Trainingid + "'";
            cn.Execute(sqlcmd, null);
            id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_trainingsource", "id");
            sqlcmd = " INSERT INTO [Sys_TQF_trainingsource] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[Trainingid]";
            sqlcmd += " ,[trainingsourceid]";
            sqlcmd += " ,[Isdelete]";
            sqlcmd += " ,[Createdate]";
            sqlcmd += " ,[CreateBy] )";
            sqlcmd += " VALUES ( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + TQFId + "'";
            sqlcmd += ",'" + Trainingid + "'";
            sqlcmd += ",'" + val + "'";
            sqlcmd += ",'0'";
            sqlcmd += ",Getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }

        [WebMethod]
        public static string Updateservicelv(string json)
        {
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string Trainingid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Trainingid").Split('_')[1];
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = "";
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_ServiceLv set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and Trainingid ='" + Trainingid + "'";
            cn.Execute(sqlcmd, null);
            id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_ServiceLv", "id");
            sqlcmd = " INSERT INTO [Sys_TQF_ServiceLv] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[Trainingid]";
            sqlcmd += " ,[servicelvid]";
            sqlcmd += " ,[Isdelete]";
            sqlcmd += " ,[Createdate]";
            sqlcmd += " ,[CreateBy] )";
            sqlcmd += " VALUES ( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + TQFId + "'";
            sqlcmd += ",'" + Trainingid + "'";
            sqlcmd += ",'" + val + "'";
            sqlcmd += ",'0'";
            sqlcmd += ",Getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static List<ClsDict> Getsubjectgroup(string json)
        {
            string TQFId = json;
            ClsDict Obj;
            List<ClsDict> Objs = new List<ClsDict>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            DataTable Dt = new DataTable();
            //ตรวจก่อนว่ามีหรือไม่

            Dt = new DataTable();
            sqlcmd = "Select id,Subjectgroupname from sys_master_subjectgroup where isdelete = 0 ";
            Dt = cn.Select(sqlcmd);
            cn.Close();
            Obj = new ClsDict();
            Obj.Val = "";
            Obj.Name = "--ไม่ระบุ--";
            Objs.Add(Obj);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsDict();
                Obj.Val = dr["id"].ToString();
                Obj.Name = dr["Subjectgroupname"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static string Updateinquiry(string json, string dat)
        {

            //TxtdevoO_1: 1 | TxtdevoD_1:2 | TxtdevoS_1:3 | TxtdevoR_1:4 | TxtdevoO_4:5 | TxtdevoD_4:6 | TxtdevoS_4:7 | TxtdevoR_4:8 |
            dat = dat.Replace("Txtinquiry_", "");
            string sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            string[] Arrcomp;
            Arrcomp = dat.Split('|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            foreach (string str in Arrcomp)
            {
                if (str.Trim() != "")
                {

                    sqlcmd = "Update Sys_TQF_inquiry set Value ='" + str.Split(':')[1] + "',modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + str.Split(':')[0] + "'";
                    Arrcmd.Add(sqlcmd);
                }


            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }
        [WebMethod]
        public static List<Clsinquiry> Getinquiry(string json)
        {
            string TQFId = json;
            Clsinquiry Obj;
            List<Clsinquiry> Objs = new List<Clsinquiry>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            DataTable Dt = new DataTable();
            //ตรวจก่อนว่ามีหรือไม่


            Dt = new DataTable();
            sqlcmd = "Select o.id as tqfinquiryid,Value from sys_tqf_inquiry o  where o.isdelete = 0  and o.tqfid = '" + TQFId + "'";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsinquiry();
                Obj.TQFinquiryId = dr["TQFinquiryId"].ToString();
                Obj.Value = dr["Value"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static string Deleteinquiry(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_inquiry Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Newinquiry(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_inquiry", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_inquiry] ";
            sqlcmd += " ([Id]";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[IsDelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[Createby])";
            sqlcmd += " Values(";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }



        [WebMethod]
        public static string UpdateTool(string json, string dat)
        {

            //TxtdevoO_1: 1 | TxtdevoD_1:2 | TxtdevoS_1:3 | TxtdevoR_1:4 | TxtdevoO_4:5 | TxtdevoD_4:6 | TxtdevoS_4:7 | TxtdevoR_4:8 |
            dat = dat.Replace("TxtTool_", "");
            string sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            string[] Arrcomp;
            Arrcomp = dat.Split('|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            foreach (string str in Arrcomp)
            {
                if (str.Trim() != "")
                {

                    sqlcmd = "Update Sys_TQF_Tool set Value ='" + str.Split(':')[1] + "',modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + str.Split(':')[0] + "'";
                    Arrcmd.Add(sqlcmd);
                }


            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }
        [WebMethod]
        public static List<Clstool> GetTool(string json)
        {
            string TQFId = json;
            Clstool Obj;
            List<Clstool> Objs = new List<Clstool>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            DataTable Dt = new DataTable();
            //ตรวจก่อนว่ามีหรือไม่


            Dt = new DataTable();
            sqlcmd = "Select o.id as tqfToolid,Value from Sys_TQF_Tool o  where o.isdelete = 0  and o.tqfid = '" + TQFId + "'";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clstool();
                Obj.TQFToolId = dr["TQFToolId"].ToString();
                Obj.Value = dr["Value"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static string DeleteTool(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_Tool Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string NewTool(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Tool", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_Tool] ";
            sqlcmd += " ([Id]";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[IsDelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[Createby])";
            sqlcmd += " Values(";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }



        [WebMethod]
        public static string Updatejournal(string json, string dat)
        {

            //TxtdevoO_1: 1 | TxtdevoD_1:2 | TxtdevoS_1:3 | TxtdevoR_1:4 | TxtdevoO_4:5 | TxtdevoD_4:6 | TxtdevoS_4:7 | TxtdevoR_4:8 |
            dat = dat.Replace("Txtjournal_", "");
            string sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            string[] Arrcomp;
            Arrcomp = dat.Split('|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            foreach (string str in Arrcomp)
            {
                if (str.Trim() != "")
                {

                    sqlcmd = "Update Sys_TQF_journal set Value ='" + str.Split(':')[1] + "',modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + str.Split(':')[0] + "'";
                    Arrcmd.Add(sqlcmd);
                }


            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }
        [WebMethod]
        public static List<Clsjournal> Getjournal(string json)
        {
            string TQFId = json;
            Clsjournal Obj;
            List<Clsjournal> Objs = new List<Clsjournal>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            DataTable Dt = new DataTable();
            //ตรวจก่อนว่ามีหรือไม่


            Dt = new DataTable();
            sqlcmd = "Select o.id as tqfjournalid,Value from sys_tqf_journal o  where o.isdelete = 0  and o.tqfid = '" + TQFId + "'";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsjournal();
                Obj.TQFjournalId = dr["TQFjournalId"].ToString();
                Obj.Value = dr["Value"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static string Deletejournal(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_journal Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Newjournal(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_journal", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_journal] ";
            sqlcmd += " ([Id]";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[IsDelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[Createby])";
            sqlcmd += " Values(";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }







        [WebMethod]
        public static string Updateebook(string json, string dat)
        {

            //TxtdevoO_1: 1 | TxtdevoD_1:2 | TxtdevoS_1:3 | TxtdevoR_1:4 | TxtdevoO_4:5 | TxtdevoD_4:6 | TxtdevoS_4:7 | TxtdevoR_4:8 |
            dat = dat.Replace("Txtebook_", "");
            string sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            string[] Arrcomp;
            Arrcomp = dat.Split('|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            foreach (string str in Arrcomp)
            {
                if (str.Trim() != "")
                {

                    sqlcmd = "Update Sys_TQF_ebook set Value ='" + str.Split(':')[1] + "',modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + str.Split(':')[0] + "'";
                    Arrcmd.Add(sqlcmd);
                }


            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }
        [WebMethod]
        public static List<Clsebook> Getebook(string json)
        {
            string TQFId = json;
            Clsebook Obj;
            List<Clsebook> Objs = new List<Clsebook>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            DataTable Dt = new DataTable();
            //ตรวจก่อนว่ามีหรือไม่


            Dt = new DataTable();
            sqlcmd = "Select o.id as tqfebookid,Value from sys_tqf_ebook o  where o.isdelete = 0  and o.tqfid = '" + TQFId + "'";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsebook();
                Obj.TQFebookId = dr["TQFebookId"].ToString();
                Obj.Value = dr["Value"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static string Deleteebook(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_ebook Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Newebook(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_ebook", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_ebook] ";
            sqlcmd += " ([Id]";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[IsDelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[Createby])";
            sqlcmd += " Values(";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }





        [WebMethod]
        public static string Showcomment(string json)
        {
            string comment = "";
            string sqlcmd = "Select * from Sys_TQF_TQF4 where id = '" + json + "'";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            comment = cn.Select(sqlcmd).Rows[0]["comment"].ToString();
            cn.Close();
            return comment;

        }

        [WebMethod]
        public static string Doapprove(string json)
        {
            //json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            //json += 'Hdapprove:' + $('#Hdapprove').val() + '|';
            //json += 'Txtcomment:' + $('#Txtcomment').val() + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            if (ClsEngine.FindValue(Dicts, "Txtcomment") == "")
            {
                return "โปรดระบุความคิดเห็นเพิ่มเติม";
            }
            if (ClsEngine.FindValue(Dicts, "Hdapprove") == "V")
            {
                sqlcmd = "Update Sys_TQF_TQF4 Set Status ='V',Statusname='รออนุมัติ',Comment ='" + ClsEngine.FindValue(Dicts, "Txtcomment").Replace("'", "").Replace(",", "") + "' Where Id ='" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            else if (ClsEngine.FindValue(Dicts, "Hdapprove") == "A")
            {
                sqlcmd = "Update Sys_TQF_TQF4 Set Status ='A',Statusname='อนุมัติแล้ว',Comment ='" + ClsEngine.FindValue(Dicts, "Txtcomment").Replace("'", "").Replace(",", "") + "' Where Id ='" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Doreject(string json)
        {
            //json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            //json += 'Hdapprove:' + $('#Hdapprove').val() + '|';
            //json += 'Txtcomment:' + $('#Txtcomment').val() + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            if (ClsEngine.FindValue(Dicts, "Txtcomment") == "")
            {
                return "โปรดระบุความคิดเห็นเพิ่มเติม";
            }
            sqlcmd = "Update Sys_TQF_TQF4 Set Status ='R',Statusname='ปฏิเสธ',Comment ='" + ClsEngine.FindValue(Dicts, "Txtcomment").Replace("'", "").Replace(",", "") + "' Where Id ='" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Doedit(string json)
        {
            //json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            //json += 'Hdapprove:' + $('#Hdapprove').val() + '|';
            //json += 'Txtcomment:' + $('#Txtcomment').val() + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            if (ClsEngine.FindValue(Dicts, "Txtcomment") == "")
            {
                return "โปรดระบุความคิดเห็นเพิ่มเติม";
            }
            if (ClsEngine.FindValue(Dicts, "Hdapprove") == "V")
            {
                sqlcmd = "Update Sys_TQF_TQF4 Set Status ='',Statusname='',Comment ='" + ClsEngine.FindValue(Dicts, "Txtcomment").Replace("'", "").Replace(",", "") + "' Where Id ='" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            else if (ClsEngine.FindValue(Dicts, "Hdapprove") == "A")
            {
                sqlcmd = "Update Sys_TQF_TQF4 Set Status ='W',Statusname='รอตรวจสอบ',Comment ='" + ClsEngine.FindValue(Dicts, "Txtcomment").Replace("'", "").Replace(",", "") + "' Where Id ='" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string SelectTQF(string json)
        {
            string status = "";
            string sqlcmd = "Select * from Sys_TQF_TQF4 where id = '" + json + "'";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            status = cn.Select(sqlcmd).Rows[0]["status"].ToString();
            cn.Close();
            if (status != "")
            {
                return "ไม่สามารถจัดการข้อมูลได้เนื่องจากอยู่ใน ระหว่างตรวจสอบ/อนุมัติ หรืออนุมัติ / ปฏิเสธแล้ว";
            }
            else
            {
                return "";
            }

        }
        [WebMethod]
        public static string Send2validate(string json)
        {
            DataTable Dt = new DataTable();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from [Sys_Master_ApproveTQF] where userid = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count == 0)
            {
                return "ไม่พบข้อมูลผู้ตรวจสอบและอนุมัติ";
            }
            else if (Dt.Rows[0]["Validatoruserid"].ToString() == "")
            {
                return "ไม่พบข้อมูลผู้ตรวจสอบ";
            }
            else if (Dt.Rows[0]["Approveruserid"].ToString() == "")
            {
                return "ไม่พบข้อมูลผู้อนุมัติ";
            }
            sqlcmd = "Update Sys_TQF_TQF4 Set Comment='', Status ='W',Statusname='รอตรวจสอบ',Validateuserid='" + Dt.Rows[0]["Validatoruserid"].ToString() + "',Approveuserid='" + Dt.Rows[0]["Approveruserid"].ToString() + "' Where Id ='" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }

       
        [WebMethod]
        public static string DelTQF(string json)
        {
            ArrayList Arrcmd = new ArrayList();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            string id = "";
            id = json;
            sqlcmd = "Update [Sys_TQF_TQF4] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
            Arrcmd.Add(sqlcmd);
            sqlcmd = "Update [Sys_TQF_TQF] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
            Arrcmd.Add(sqlcmd);
            Cn.Execute(Arrcmd, null);
            return "";
        }

        [WebMethod]
        public static string Iseducate()
        {
            return ((Clsuser)HttpContext.Current.Session["My"]).iseducate;
        }

        [WebMethod]
        public static List<Clsconfidentdocument> Getconfidentdocument(string json)
        {
            Clsconfidentdocument Obj;
            List<Clsconfidentdocument> Objs = new List<Clsconfidentdocument>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_TQF_confidentdocument where TQFId='" + json + "' and isdelete = 0 Order by id ";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsconfidentdocument();
                Obj.id = dr["Id"].ToString();
                Obj.Confidentdocument = dr["Confidentdocument"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static string Deleteconfidentdocument(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_confidentdocument Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Updateconfidentdocument(string json, string dat)
        {
            //TxtdevoO_1: 1 | TxtdevoD_1:2 | TxtdevoS_1:3 | TxtdevoR_1:4 | TxtdevoO_4:5 | TxtdevoD_4:6 | TxtdevoS_4:7 | TxtdevoR_4:8 |
            dat = dat.Replace("Txtconf_", "");
            string sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            string[] Arrcomp;
            string confidentdocumentid = "";
            string value = "";
            Arrcomp = dat.Split('|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            foreach (string str in Arrcomp)
            {
                if (str.Trim() != "")
                {
                    confidentdocumentid = str.Split(':')[0].Trim();
                    value = str.Split(':')[1].Trim();
                    if (value == "")
                    {
                        value = "''";
                    }
                    else
                    {
                        value = "'" + value + "'";
                    }
                    sqlcmd = "Update Sys_TQF_confidentdocument set Confidentdocument =" + value + ",modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + confidentdocumentid + "'";
                    Arrcmd.Add(sqlcmd);
                }
            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }
        [WebMethod]
        public static string Newconfidentdocument(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_confidentdocument", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_confidentdocument] ";
            sqlcmd += " ([Id]";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[IsDelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[Createby])";
            sqlcmd += " Values(";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Selectedinquiry(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            string sqlcmd = "";
            string id = "";
            string TQFId = "";
            string x = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            try
            {
                Dicts = ClsEngine.DeSerialized(json, ':', '|');
                TQFId = ClsEngine.FindValue(Dicts, "TQFId");
                x = ClsEngine.FindValue(Dicts, "x");
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Inquiry", "Id");
                sqlcmd = " INSERT INTO [Sys_TQF_Inquiry] ";
                sqlcmd += " ([Id] ";
                sqlcmd += " ,[TQFId] ";
                sqlcmd += " ,[Inquiryid] ";
                sqlcmd += " ,[Isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " VALUES (";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + TQFId + "'";
                sqlcmd += ",'" + x + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            finally
            {
                cn.Close();
            }
            return "";
        }
        [WebMethod]
        public static string Selectedjournal(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            string sqlcmd = "";
            string id = "";
            string TQFId = "";
            string x = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            try
            {
                Dicts = ClsEngine.DeSerialized(json, ':', '|');
                TQFId = ClsEngine.FindValue(Dicts, "TQFId");
                x = ClsEngine.FindValue(Dicts, "x");
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Journal", "Id");
                sqlcmd = " INSERT INTO [Sys_TQF_Journal] ";
                sqlcmd += " ([Id] ";
                sqlcmd += " ,[TQFId] ";
                sqlcmd += " ,[Journalid] ";
                sqlcmd += " ,[Isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " VALUES (";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + TQFId + "'";
                sqlcmd += ",'" + x + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            finally
            {
                cn.Close();
            }
            return "";
        }
        [WebMethod]
        public static string Selectedother(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            string sqlcmd = "";
            string id = "";
            string TQFId = "";
            string x = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            try
            {
                Dicts = ClsEngine.DeSerialized(json, ':', '|');
                TQFId = ClsEngine.FindValue(Dicts, "TQFId");
                x = ClsEngine.FindValue(Dicts, "x");
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Otherdocument", "Id");
                sqlcmd = " INSERT INTO [Sys_TQF_Otherdocument] ";
                sqlcmd += " ([Id] ";
                sqlcmd += " ,[TQFId] ";
                sqlcmd += " ,[Otherid] ";
                sqlcmd += " ,[Isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " VALUES (";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + TQFId + "'";
                sqlcmd += ",'" + x + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            finally
            {
                cn.Close();
            }
            return "";
        }
        [WebMethod]
        public static string Selectedtool(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            string sqlcmd = "";
            string id = "";
            string TQFId = "";
            string x = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            try
            {
                Dicts = ClsEngine.DeSerialized(json, ':', '|');
                TQFId = ClsEngine.FindValue(Dicts, "TQFId");
                x = ClsEngine.FindValue(Dicts, "x");
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_tool", "Id");
                sqlcmd = " INSERT INTO [Sys_TQF_tool] ";
                sqlcmd += " ([Id] ";
                sqlcmd += " ,[TQFId] ";
                sqlcmd += " ,[toolId] ";
                sqlcmd += " ,[Isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " VALUES (";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + TQFId + "'";
                sqlcmd += ",'" + x + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            finally
            {
                cn.Close();
            }
            return "";
        }
        [WebMethod]
        public static string Selectedebook(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            string sqlcmd = "";
            string id = "";
            string TQFId = "";
            string x = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            try
            {
                Dicts = ClsEngine.DeSerialized(json, ':', '|');
                TQFId = ClsEngine.FindValue(Dicts, "TQFId");
                x = ClsEngine.FindValue(Dicts, "x");
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Ebook", "Id");
                sqlcmd = " INSERT INTO [Sys_TQF_Ebook] ";
                sqlcmd += " ([Id] ";
                sqlcmd += " ,[TQFId] ";
                sqlcmd += " ,[Ebookid] ";
                sqlcmd += " ,[Isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " VALUES (";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + TQFId + "'";
                sqlcmd += ",'" + x + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            finally
            {
                cn.Close();
            }
            return "";
        }
        [WebMethod]
        public static string Selectedtextbook(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            string sqlcmd = "";
            string id = "";
            string TQFId = "";
            string x = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            try
            {
                Dicts = ClsEngine.DeSerialized(json, ':', '|');
                TQFId = ClsEngine.FindValue(Dicts, "TQFId");
                x = ClsEngine.FindValue(Dicts, "x");
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Textbook", "Id");
                sqlcmd = " INSERT INTO [Sys_TQF_Textbook] ";
                sqlcmd += " ([Id] ";
                sqlcmd += " ,[TQFId] ";
                sqlcmd += " ,[Textbookid] ";
                sqlcmd += " ,[Isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " VALUES (";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + TQFId + "'";
                sqlcmd += ",'" + x + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            finally
            {
                cn.Close();
            }
            return "";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["ObjGrid"] == null)
            {
                ClsGrid Objgrid = new ClsGrid();
                HttpContext.Current.Session["ObjGrid"] = Objgrid;
            }
        }
        private static List<Clsparticular> Gettemplatedparticular()
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_Particular where isdelete = 0 ";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            List<Clsparticular> Objs = new List<Clsparticular>();
            Clsparticular Obj;
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsparticular();
                Obj.Particularid = dr["id"].ToString();
                Obj.Particularname = dr["Particular"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        private static List<Clsquality> Gettemplatedquality()
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_Quality where isdelete = 0";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            List<Clsquality> Objs = new List<Clsquality>();
            Clsquality Obj;
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsquality();
                Obj.Qualityid = dr["id"].ToString();
                Obj.Qualityname = dr["name"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        private static List<Clsestimateobjective> Gettemplatedobjective()
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_Objective where isdelete = 0";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            List<Clsestimateobjective> Objs = new List<Clsestimateobjective>();
            Clsestimateobjective Obj;
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsestimateobjective();
                Obj.Objectiveid = dr["id"].ToString();
                Obj.Objectivename = dr["Code"].ToString() + " " + dr["Objective"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }

        private static List<ClsserviceLv> GettemplatedserviceLv()
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_ServiceLv where isdelete = 0";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            List<ClsserviceLv> Objs = new List<ClsserviceLv>();
            ClsserviceLv Obj;
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsserviceLv();
                Obj.ServiceLvid = dr["id"].ToString();
                Obj.ServiceLvname = dr["name"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        private static List<Clstrainingsource> Gettemplatedtrainingsource()
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_trainingsource where isdelete = 0";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            List<Clstrainingsource> Objs = new List<Clstrainingsource>();
            Clstrainingsource Obj;
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clstrainingsource();
                Obj.Trainingsourceid = dr["id"].ToString();
                Obj.Trainingsourcename = dr["name"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        private static List<Clsestimate> Gettemplatedestimate()
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_Estimate where isdelete = 0";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            List<Clsestimate> Objs = new List<Clsestimate>();
            Clsestimate Obj;
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsestimate();
                Obj.Estimateid = dr["id"].ToString();
                Obj.Estimatename = dr["Estimate"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }


        
        [WebMethod]
        public static List<Clstqfestimate> Getestimate(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            List<Clstqfestimate> Objs = new List<Clstqfestimate>();
            Clstqfestimate Obj;
            Clsestimateobjective _ES;
            List<Clsestimateobjective> Ess = new List<Clsestimateobjective>();
            string sqlcmd = "";
            DataTable Dt = new DataTable();
            DataTable Dtestimateobjective = new DataTable();
            DataRow[] Drs;
            sqlcmd = "Select id as estimateid,ratio from Sys_TQF_estimate where isdelete = 0 and TQFId = '" + json + "'";
            Dt = cn.Select(sqlcmd);


            sqlcmd = "Select Estimateid,d.estimateobjectiveid as objid,m.code,m.Objective,m.id as id from sys_tqf_estimateobjective d inner join sys_master_objective m on m.Id = d.estimateobjectiveid where m.isdelete =0 and d.isdelete = 0 and d.tqfid = '" + json + "'";
            Dtestimateobjective = cn.Select(sqlcmd);
           
            foreach (DataRow dr in Dt.Rows)
            {
                Ess = new List<Clsestimateobjective>();
                Obj = new Clstqfestimate();
                Obj.Estimateid = dr["Estimateid"].ToString();
                Obj.Ratio = dr["Ratio"].ToString();
                Obj.Objective = new List<Clsestimateobjective>(); //ตัวที่เลือก
                Drs = Dtestimateobjective.Select("Estimateid='" + Obj.Estimateid + "'");
                foreach (DataRow _mdr in Drs)
                {
                    _ES = new Clsestimateobjective();
                    _ES.Objectiveid = _mdr["objid"].ToString();
                    _ES.Objectivename = _mdr["code"].ToString() + " " + _mdr["Objective"].ToString();
                    Ess.Add(_ES);
                }
                Obj.Objective = Ess;
                Obj.Templateobjective = Gettemplatedobjective();
                Objs.Add(Obj);

            }
            return Objs;
        }
        [WebMethod]
        public static List<Clstraining> Gettraining(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            List<Clstraining> Objs = new List<Clstraining>();
            Clstraining Obj;
            Clstrainingsource _TS;
            ClsserviceLv _SV;
            Clsquality _QA;
            List<Clstrainingsource> Tss = new List<Clstrainingsource>();
            List<ClsserviceLv> Svs = new List<ClsserviceLv>();
            List<Clsquality> Qas = new List<Clsquality>();
            string sqlcmd = "";
            DataTable Dt = new DataTable();
            DataTable Dttrainingsource = new DataTable();
            DataTable DtserviceLv = new DataTable();
            DataTable Dtquality = new DataTable();
            DataRow[] Drs;
            sqlcmd = "Select id as trainingid from  Sys_TQF_training where isdelete = 0 and TQFId = '" + json + "'";
            Dt = cn.Select(sqlcmd);

           
            sqlcmd = "Select Trainingid,m.id as tsid,m.Name,d.id as id from sys_tqf_trainingsource d inner join sys_master_trainingsource m on m.Id = d.Trainingsourceid where m.isdelete =0 and d.isdelete = 0 and d.tqfid = '" + json + "'";
            Dttrainingsource = cn.Select(sqlcmd);

            
            sqlcmd = "Select Trainingid,m.id as svid,m.Name,d.id as id from sys_tqf_serviceLv d inner join sys_master_serviceLv m on m.Id = d.serviceLvid where m.isdelete =0 and d.isdelete = 0 and d.tqfid = '" + json + "'";
            //sqlcmd = "Select Trainingid,d.id as svid,m.Name,m.id as id from sys_tqf_serviceLv d inner join sys_master_serviceLv m on m.Id = d.serviceLvid where m.isdelete =0 and d.isdelete = 0 and d.tqfid = '" + json + "'";
            DtserviceLv = cn.Select(sqlcmd);
            sqlcmd = "Select Trainingid,m.id as qaid,m.Name,d.id as id from sys_tqf_quality d inner join sys_master_quality m on m.Id = d.qualityid where m.isdelete =0 and d.isdelete = 0 and d.tqfid = '" + json + "'";
            Dtquality = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Tss = new List<Clstrainingsource>();
                Svs = new List<ClsserviceLv>();
                Qas = new List<Clsquality>();
                Obj = new Clstraining();
                Obj.Trainingid = dr["trainingid"].ToString();
               
                Obj.Trainingsource = new List<Clstrainingsource>(); //ตัวที่เลือก
                Drs = Dttrainingsource.Select("trainingid='" + Obj.Trainingid + "'");
                foreach (DataRow _mdr in Drs)
                {
                    _TS = new Clstrainingsource();
                    _TS.Trainingsourceid = _mdr["tsid"].ToString();
                    _TS.Trainingsourcename = _mdr["Name"].ToString();
                    Tss.Add(_TS);
                }
                Obj.Trainingsource = Tss;



                Obj.ServiceLv = new List<ClsserviceLv>(); //ตัวที่เลือก
                Drs = DtserviceLv.Select("trainingid='" + Obj.Trainingid + "'");
                foreach (DataRow _mdr in Drs)
                {
                    _SV = new ClsserviceLv();
                    _SV.ServiceLvid = _mdr["svid"].ToString();
                    _SV.ServiceLvname = _mdr["Name"].ToString();
                    Svs.Add(_SV);
                }
                Obj.ServiceLv = Svs;

                Obj.Quality = new List<Clsquality>(); //ตัวที่เลือก
                Drs = Dtquality.Select("trainingid='" + Obj.Trainingid + "'");
                foreach (DataRow _mdr in Drs)
                {
                    _QA = new Clsquality();
                    _QA.Qualityid = _mdr["qaid"].ToString();
                    _QA.Qualityname = _mdr["Name"].ToString();
                    Qas.Add(_QA);
                }
                Obj.Quality = Qas;


                Obj.Templatetrainingsource = Gettemplatedtrainingsource();
                Obj.TemplateserviceLv = GettemplatedserviceLv();
                Obj.Templatequality = Gettemplatedquality();
                Objs.Add(Obj);

            }
            return Objs;
        }
        //[WebMethod]
        //public static List<Clslearningoutput> Getlearningoutput(string json)
        //{
        //    SqlConnector cn = new SqlConnector(Connectionstring, null);
        //    List<Clslearningoutput> Objs = new List<Clslearningoutput>();
        //    Clslearningoutput Obj;
        //    Clsparticular _Par;
        //    Clsestimate _Est;
        //    List<Clsestimate> Ests = new List<Clsestimate>();
        //    List<Clsparticular> Pars = new List<Clsparticular>();
        //    string sqlcmd = "";
        //    DataTable Dt = new DataTable();
        //    DataTable Dtparticular = new DataTable();
        //    DataTable Dtestimate = new DataTable();
        //    DataRow[] Drs;
        //    sqlcmd = "Select Learningoutputid,l.id as id,l.output as Learningoutputname,Outputdesc from Sys_Master_Learningoutput l inner join Sys_TQF_Learningoutput tl on l.id  = tl.Learningoutputid where tl.TQFTypeId = '4'";
        //    Dt = cn.Select(sqlcmd);
        //    sqlcmd = "Select Learningoutputid,Lp.id as Learningparticularid,Particular,p.id as particularid from Sys_TQF_Learningpartcular Lp inner join Sys_Master_Particular p on lp.Particularid = p.id where lp.TQFId = '" + json + "' and p.isdelete = 0 and lp.isdelete = 0";
        //    Dtparticular = cn.Select(sqlcmd);
        //    sqlcmd = "Select Learningoutputid,Te.id as Learningestimateid,Estimate,e.id as estimateid from Sys_TQF_LearningEstimate TE inner join Sys_Master_Estimate E on te.Estimateid = E.id where Te.isdelete = 0 and E.isdelete = 0 and TQFId = '" + json + "'";
        //    Dtestimate = cn.Select(sqlcmd);
        //    foreach (DataRow dr in Dt.Rows)
        //    {
        //        Pars = new List<Clsparticular>();
        //        Ests = new List<Clsestimate>();
        //        Obj = new Clslearningoutput();
        //        Obj.Learningoutputid = dr["id"].ToString();
        //        Obj.Learningoutputname = dr["Learningoutputname"].ToString();
        //        Obj.Learningoutputdesc = dr["Outputdesc"].ToString();
        //        Obj.Particulars = new List<Clsparticular>(); //ตัวที่เลือก
        //        Drs = Dtparticular.Select("Learningoutputid='" + Obj.Learningoutputid + "'");
        //        foreach (DataRow _mdr in Drs)
        //        {
        //            _Par = new Clsparticular();
        //            _Par.Learningparticularid = _mdr["Learningparticularid"].ToString();
        //            _Par.Particularid = _mdr["Particularid"].ToString();
        //            _Par.Particularname = _mdr["Particular"].ToString();
        //            Pars.Add(_Par);
        //        }
        //        Obj.Particulars = Pars;

        //        Drs = Dtestimate.Select("Learningoutputid='" + Obj.Learningoutputid + "'");
        //        foreach (DataRow _mdr in Drs)
        //        {
        //            _Est = new Clsestimate();
        //            _Est.Learningestimateid = _mdr["Learningestimateid"].ToString();
        //            _Est.Estimateid = _mdr["Estimateid"].ToString();
        //            _Est.Estimatename = _mdr["Estimate"].ToString();
        //            Ests.Add(_Est);
        //        }
        //        Obj.Estimates = Ests;
        //        Obj.TemplateEstimates = Gettemplatedestimate();
        //        Obj.Templateparticulars = Gettemplatedparticular();

        //        Objs.Add(Obj);

        //    }
        //    return Objs;
        //}


        [WebMethod]
        public static string Updatetqfestimate(string json)
        {
            string Learningoutputid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "ctrl").Replace("Chklearningoutputestimate_", "").Split('_')[0];
            string estimateid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "ctrl").Replace("Chklearningoutputestimate_", "").Split('_')[1];
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = "";
            string sqlcmd = "";
            if (val == "true")
            {
                if (cn.Select("Select * from [Sys_TQF_Learningestimate] Where isdelete = 0 and LearningoutputId='" + Learningoutputid + "' and estimateid='" + estimateid + "' and tqfid = '" + TQFId + "'").Rows.Count == 0)
                {
                    id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Learningestimate", "id");

                    sqlcmd = " INSERT INTO [Sys_TQF_Learningestimate] ";
                    sqlcmd += " ([id] ";
                    sqlcmd += " ,[TQFId]";
                    sqlcmd += " ,[LearningoutputId]";
                    sqlcmd += " ,[estimateid]";
                    sqlcmd += " ,[Isdelete]";
                    sqlcmd += " ,[Createdate]";
                    sqlcmd += " ,[CreateBy] )";
                    sqlcmd += " VALUES ( ";
                    sqlcmd += "'" + id + "'";
                    sqlcmd += ",'" + TQFId + "'";
                    sqlcmd += ",'" + Learningoutputid + "'";
                    sqlcmd += ",'" + estimateid + "'";
                    sqlcmd += ",'0'";
                    sqlcmd += ",Getdate()";
                    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    cn.Execute(sqlcmd, null);
                }
            }
            else
            {
                sqlcmd = "Update Sys_TQF_Learningestimate set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and LearningoutputId='" + Learningoutputid + "' and estimateid ='" + estimateid + "'";
                cn.Execute(sqlcmd, null);
            }

            return "";
        }
        [WebMethod]
        public static string Updatetqfquality(string json)
        {
            string Trainingid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "ctrl").Replace("Chkquality_", "").Split('_')[0];
            string Qualityid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "ctrl").Replace("Chkquality_", "").Split('_')[1];
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = "";
            string sqlcmd = "";
            if (val == "true")
            {
                if (cn.Select("Select * from [Sys_TQF_Quality] Where isdelete = 0 and Trainingid='" + Trainingid + "' and Qualityid ='" + Qualityid + "' and tqfid='" + TQFId + "'").Rows.Count == 0)
                {
                    id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Quality", "id");

                    sqlcmd = " INSERT INTO [Sys_TQF_Quality] ";
                    sqlcmd += " ([id] ";
                    sqlcmd += " ,[TQFId]";
                    sqlcmd += " ,[Trainingid]";
                    sqlcmd += " ,[Qualityid]";
                    sqlcmd += " ,[Isdelete]";
                    sqlcmd += " ,[Createdate]";
                    sqlcmd += " ,[CreateBy] )";
                    sqlcmd += " VALUES ( ";
                    sqlcmd += "'" + id + "'";
                    sqlcmd += ",'" + TQFId + "'";
                    sqlcmd += ",'" + Trainingid + "'";
                    sqlcmd += ",'" + Qualityid + "'";
                    sqlcmd += ",'0'";
                    sqlcmd += ",Getdate()";
                    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    cn.Execute(sqlcmd, null);
                }
            }
            else
            {
                sqlcmd = "Update Sys_TQF_Quality set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and Trainingid='" + Trainingid + "' and Qualityid ='" + Qualityid + "'";
                cn.Execute(sqlcmd, null);
            }

            return "";
        }
        [WebMethod]
        public static string UpdatetqfserviceLv(string json)
        {
            string Trainingid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "ctrl").Replace("ChkserviceLv_", "").Split('_')[0];
            string ServiceLvid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "ctrl").Replace("ChkserviceLv_", "").Split('_')[1];
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = "";
            string sqlcmd = "";
            if (val == "true")
            {
                if (cn.Select("Select * from [Sys_TQF_ServiceLv] Where isdelete = 0 and Trainingid='" + Trainingid + "' and ServiceLvid ='" + ServiceLvid + "' and tqfid='" + TQFId + "'").Rows.Count == 0)
                {
                    id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_ServiceLv", "id");

                    sqlcmd = " INSERT INTO [Sys_TQF_ServiceLv] ";
                    sqlcmd += " ([id] ";
                    sqlcmd += " ,[TQFId]";
                    sqlcmd += " ,[Trainingid]";
                    sqlcmd += " ,[ServiceLvid]";
                    sqlcmd += " ,[Isdelete]";
                    sqlcmd += " ,[Createdate]";
                    sqlcmd += " ,[CreateBy] )";
                    sqlcmd += " VALUES ( ";
                    sqlcmd += "'" + id + "'";
                    sqlcmd += ",'" + TQFId + "'";
                    sqlcmd += ",'" + Trainingid + "'";
                    sqlcmd += ",'" + ServiceLvid + "'";
                    sqlcmd += ",'0'";
                    sqlcmd += ",Getdate()";
                    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    cn.Execute(sqlcmd, null);
                }
            }
            else
            {
                sqlcmd = "Update Sys_TQF_ServiceLv set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and Trainingid='" + Trainingid + "' and ServiceLvid ='" + ServiceLvid + "'";
                cn.Execute(sqlcmd, null);
            }

            return "";
        }
        [WebMethod]
        public static string Updatetqfestimateobj(string json)
        {
            string Estimateid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "ctrl").Replace("Chkestimateobjective_", "").Split('_')[0];
            string Estimateobjectiveid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "ctrl").Replace("Chkestimateobjective_", "").Split('_')[1];
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = "";
            string sqlcmd = "";
            if (val == "true")
            {
                
                if (cn.Select("Select * from [Sys_TQF_EstimateObjective] Where isdelete = 0 and Estimateid='" + Estimateid + "' and estimateobjectiveid ='" + Estimateobjectiveid + "' and tqfid='" + TQFId + "'").Rows.Count == 0)
                {
                    id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_EstimateObjective", "id");

                    sqlcmd = " INSERT INTO [Sys_TQF_EstimateObjective] ";
                    sqlcmd += " ([id] ";
                    sqlcmd += " ,[TQFId]";
                    sqlcmd += " ,[Estimateid]";
                    sqlcmd += " ,[estimateobjectiveid]";
                    sqlcmd += " ,[Isdelete]";
                    sqlcmd += " ,[Createdate]";
                    sqlcmd += " ,[CreateBy] )";
                    sqlcmd += " VALUES ( ";
                    sqlcmd += "'" + id + "'";
                    sqlcmd += ",'" + TQFId + "'";
                    sqlcmd += ",'" + Estimateid + "'";
                    sqlcmd += ",'" + Estimateobjectiveid + "'";
                    sqlcmd += ",'0'";
                    sqlcmd += ",Getdate()";
                    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    cn.Execute(sqlcmd, null);
                }
            }
            else
            {
                sqlcmd = "Update Sys_TQF_EstimateObjective set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and Estimateid='" + Estimateid + "' and Estimateobjectiveid ='" + Estimateobjectiveid + "'";
                cn.Execute(sqlcmd, null);
            }

            return "";
        }
        [WebMethod]
        public static string Updatetqftrainingsource(string json)
        {
            string Trainingid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "ctrl").Replace("Chktrainingsource_", "").Split('_')[0];
            string Trainingsourceid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "ctrl").Replace("Chktrainingsource_", "").Split('_')[1];
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = "";
            string sqlcmd = "";
            if (val == "true")
            {
                if (cn.Select("Select * from [Sys_TQF_Trainingsource] Where isdelete = 0 and Trainingid='" + Trainingid + "' and Trainingsourceid ='" + Trainingsourceid + "' and tqfid='" + TQFId + "'").Rows.Count == 0)
                {
                    id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Trainingsource", "id");

                    sqlcmd = " INSERT INTO [Sys_TQF_Trainingsource] ";
                    sqlcmd += " ([id] ";
                    sqlcmd += " ,[TQFId]";
                    sqlcmd += " ,[Trainingid]";
                    sqlcmd += " ,[Trainingsourceid]";
                    sqlcmd += " ,[Isdelete]";
                    sqlcmd += " ,[Createdate]";
                    sqlcmd += " ,[CreateBy] )";
                    sqlcmd += " VALUES ( ";
                    sqlcmd += "'" + id + "'";
                    sqlcmd += ",'" + TQFId + "'";
                    sqlcmd += ",'" + Trainingid + "'";
                    sqlcmd += ",'" + Trainingsourceid + "'";
                    sqlcmd += ",'0'";
                    sqlcmd += ",Getdate()";
                    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    cn.Execute(sqlcmd, null);
                }
            }
            else
            {
                sqlcmd = "Update Sys_TQF_Trainingsource set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and Trainingid='" + Trainingid + "' and Trainingsourceid ='" + Trainingsourceid + "'";
                cn.Execute(sqlcmd, null);
            }

            return "";
        }

        [WebMethod]
        public static string Updatetqfparticular(string json)
        {
            string Learningoutputid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "ctrl").Replace("Chklearningoutputparticular_", "").Split('_')[0];
            string Particularid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "ctrl").Replace("Chklearningoutputparticular_", "").Split('_')[1];
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = "";
            string sqlcmd = "";
            if (val == "true")
            {
                if (cn.Select("Select * from [Sys_TQF_Learningpartcular] Where isdelete = 0 and LearningoutputId='" + Learningoutputid + "' and Particularid='" + Particularid + "' and tqfid='" + TQFId + "'").Rows.Count == 0)
                {
                    id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Learningpartcular", "id");

                    sqlcmd = " INSERT INTO [Sys_TQF_Learningpartcular] ";
                    sqlcmd += " ([id] ";
                    sqlcmd += " ,[TQFId]";
                    sqlcmd += " ,[LearningoutputId]";
                    sqlcmd += " ,[Particularid]";
                    sqlcmd += " ,[Isdelete]";
                    sqlcmd += " ,[Createdate]";
                    sqlcmd += " ,[CreateBy] )";
                    sqlcmd += " VALUES ( ";
                    sqlcmd += "'" + id + "'";
                    sqlcmd += ",'" + TQFId + "'";
                    sqlcmd += ",'" + Learningoutputid + "'";
                    sqlcmd += ",'" + Particularid + "'";
                    sqlcmd += ",'0'";
                    sqlcmd += ",Getdate()";
                    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    cn.Execute(sqlcmd, null);
                }
            }
            else
            {
                sqlcmd = "Update Sys_TQF_Learningpartcular set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and LearningoutputId='" + Learningoutputid + "' and Particularid ='" + Particularid + "'";
                cn.Execute(sqlcmd, null);
            }

            return "";
        }
        [WebMethod]
        public static string Deletereport(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_report Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Deleteestimate(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_Estimate Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Deletetraining(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_Training Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Deleteevent(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_event Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Deletedevelopobjective(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_Developobjective Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }


        [WebMethod]
        public static string Updateadvice(string json, string dat)
        {
            string field = "";
            //TxtdevoO_1: 1 | TxtdevoD_1:2 | TxtdevoS_1:3 | TxtdevoR_1:4 | TxtdevoO_4:5 | TxtdevoD_4:6 | TxtdevoS_4:7 | TxtdevoR_4:8 |
            dat = dat.Replace("Txtadvice", "");
            string sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            string[] Arrcomp;
            string TQFInstuctorid = "";
            string value = "";
            Arrcomp = dat.Split('|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            foreach (string str in Arrcomp)
            {
                if (str.Trim() != "")
                {
                    TQFInstuctorid = "";
                    value = "";
                    field = "";
                    if (str.Split(':')[0].Split('_')[0].Trim() == "P") //Objective
                    {
                        TQFInstuctorid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();
                        field = "Adviceplace";
                    }
                    else if (str.Split(':')[0].Split('_')[0].Trim() == "E") //Solution
                    {
                        TQFInstuctorid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();

                        field = "AdviceEmail";
                    }
                    else if (str.Split(':')[0].Split('_')[0].Trim() == "D") //Objective
                    {
                        TQFInstuctorid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();
                        field = "Advicedatetime";
                    }
                    if (value == "")
                    {
                        value = "''";
                    }
                    else
                    {
                        value = "'" + value + "'";
                    }
                    if (field != "")
                    {
                        sqlcmd = "Update Sys_TQF_Instructor set " + field + "=" + value + ",modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + TQFInstuctorid + "'";
                        Arrcmd.Add(sqlcmd);
                    }
                }


            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }

        [WebMethod]
        public static string Updatereport(string json, string dat)
        {
            string field = "";
            //TxtdevoO_1: 1 | TxtdevoD_1:2 | TxtdevoS_1:3 | TxtdevoR_1:4 | TxtdevoO_4:5 | TxtdevoD_4:6 | TxtdevoS_4:7 | TxtdevoR_4:8 |
            dat = dat.Replace("Txtreport", "");
            string sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            string[] Arrcomp;
            string reportid = "";
            string value = "";
            Arrcomp = dat.Split('|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            foreach (string str in Arrcomp)
            {
                if (str.Trim() != "")
                {
                    reportid = "";
                    value = "";
                    field = "";
                    if (str.Split(':')[0].Split('_')[0].Trim() == "N") //Objective
                    {
                        reportid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();
                        field = "reportname";
                    }
                    else if (str.Split(':')[0].Split('_')[0].Trim() == "D") //Solution
                    {
                        reportid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();

                        field = "reportdue";
                    }
                    if (value == "")
                    {
                        value = "''";
                    }
                    else
                    {
                        value = "'" + value + "'";
                    }
                    sqlcmd = "Update Sys_TQF_report set " + field + "=" + value + ",modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + reportid + "'";
                    Arrcmd.Add(sqlcmd);
                }
            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }

        [WebMethod]
        public static string Updateevent(string json, string dat)
        {
            string field = "";
            //TxtdevoO_1: 1 | TxtdevoD_1:2 | TxtdevoS_1:3 | TxtdevoR_1:4 | TxtdevoO_4:5 | TxtdevoD_4:6 | TxtdevoS_4:7 | TxtdevoR_4:8 |
            dat = dat.Replace("Txtevent", "");
            dat = dat.Replace("Txtevent", "");
            dat = dat.Replace("Cbevent", "");
            string sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            string[] Arrcomp;
            string eventid = "";
            string value = "";
            Arrcomp = dat.Split('|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            foreach (string str in Arrcomp)
            {
                if (str.Trim() != "")
                {
                    eventid = "";
                    value = "";
                    field = "";
                    if (str.Split(':')[0].Split('_')[0].Trim() == "E") //Objective
                    {
                        eventid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();
                        field = "Eventexp";
                    }
                    else if (str.Split(':')[0].Split('_')[0].Trim() == "T") //Solution
                    {
                        eventid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();

                        field = "Eventtype";
                    }
                    else if (str.Split(':')[0].Split('_')[0].Trim() == "N") //Objective
                    {
                        eventid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();
                        field = "Eventname";
                    }
                    
                    if (value == "")
                    {
                        value = "''";
                    }
                    else
                    {
                        value = "'" + value + "'";
                    }
                    sqlcmd = "Update Sys_TQF_event set " + field + "=" + value + ",modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + eventid + "'";
                    Arrcmd.Add(sqlcmd);
                }


            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }


        [WebMethod]
        public static string Updatedevelopobjective(string json, string dat)
        {
            string field = "";
            //TxtdevoO_1: 1 | TxtdevoD_1:2 | TxtdevoS_1:3 | TxtdevoR_1:4 | TxtdevoO_4:5 | TxtdevoD_4:6 | TxtdevoS_4:7 | TxtdevoR_4:8 |
            dat = dat.Replace("Txtdevo", "");
            string sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            string[] Arrcomp;
            string Developobjectiveid = "";
            string value = "";
            Arrcomp = dat.Split('|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            foreach (string str in Arrcomp)
            {
                if (str.Trim() != "")
                {
                    Developobjectiveid = "";
                    value = "";
                    field = "";
                    if (str.Split(':')[0].Split('_')[0].Trim() == "O") //Objective
                    {
                        Developobjectiveid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();
                        field = "Objective";
                    }
                    else if (str.Split(':')[0].Split('_')[0].Trim() == "S") //Solution
                    {
                        Developobjectiveid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();

                        field = "Solution";
                    }
                    else if (str.Split(':')[0].Split('_')[0].Trim() == "R") //Objective
                    {
                        Developobjectiveid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();
                        field = "Response";
                    }
                    else if (str.Split(':')[0].Split('_')[0].Trim() == "D") //Objective
                    {
                        Developobjectiveid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();
                        field = "Data";
                    }
                    if (value == "")
                    {
                        value = "''";
                    }
                    else
                    {
                        value = "'" + value + "'";
                    }
                    sqlcmd = "Update Sys_TQF_DevelopObjective set " + field + "=" + value + ",modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + Developobjectiveid + "'";
                    Arrcmd.Add(sqlcmd);
                }


            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }
        [WebMethod]
        public static string Newdevelopobjective(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_DevelopObjective", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_DevelopObjective] ";
            sqlcmd += " ([Id]";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[IsDelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[Createby])";
            sqlcmd += " Values(";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Newreport(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_report", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_report] ";
            sqlcmd += " ([Id]";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[IsDelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[Createby])";
            sqlcmd += " Values(";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Newestimate(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Estimate", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_Estimate] ";
            sqlcmd += " ([Id]";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[IsDelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[Createby])";
            sqlcmd += " Values(";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Newtraining(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Training", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_Training] ";
            sqlcmd += " ([Id]";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[IsDelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[Createby])";
            sqlcmd += " Values(";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Newevent(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_event", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_event] ";
            sqlcmd += " ([Id]";
            sqlcmd += " ,[TQFId]";
            sqlcmd += " ,[IsDelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[Createby])";
            sqlcmd += " Values(";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static List<Clsreport> Getreport(string json)
        {
            Clsreport Obj;
            List<Clsreport> Objs = new List<Clsreport>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_TQF_report where TQFId='" + json + "' and isdelete = 0 Order by id ";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsreport();
                Obj.Reportid = dr["Id"].ToString();
                Obj.Reportname = dr["reportname"].ToString();
                Obj.Reportdue = dr["Reportdue"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static List<Clsevent> Getevent(string json)
        {
            Clsevent Obj;
            List<Clsevent> Objs = new List<Clsevent>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_TQF_Event where TQFId='" + json + "' and isdelete = 0 Order by id ";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsevent();
                Obj.Eventid = dr["Id"].ToString();
                Obj.Eventname = dr["Eventname"].ToString();
                Obj.Eventtype = dr["Eventtype"].ToString();
                Obj.Eventexp = dr["Eventexp"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }

        [WebMethod]
        public static List<ClsDevelopobjective> Getdevelopobjective(string json)
        {
            ClsDevelopobjective Obj;
            List<ClsDevelopobjective> Objs = new List<ClsDevelopobjective>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_TQF_DevelopObjective where TQFId='" + json + "' and isdelete = 0 Order by id ";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsDevelopobjective();
                Obj.Devlopobjectiveid = dr["Id"].ToString();
                Obj.Objective = dr["Objective"].ToString();
                Obj.Data = dr["Data"].ToString();
                Obj.Solution = dr["Solution"].ToString();
                Obj.Response = dr["Response"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static List<Clsoutcome> Getoutcome(string json)
        {
            string TQFId = json;
            Clsoutcome Obj;
            List<Clsoutcome> Objs = new List<Clsoutcome>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            string id = "";
            DataTable Dt = new DataTable();
            //ตรวจก่อนว่ามีหรือไม่

            sqlcmd = "Select * from sys_tqf_outcome where isdelete = 0 and tqfid = '" + TQFId + "'";
            Dt = cn.Select(sqlcmd);

            if (Dt.Rows.Count == 0)
            {
                sqlcmd = "Select * from sys_master_outcome where isdelete = 0 and tqftype='4' order by id";
                Dt = cn.Select(sqlcmd);
                id = ClsEngine.GenerateRunningId(Connectionstring, "sys_tqf_outcome", "Id");
                foreach (DataRow dr in Dt.Rows)
                {
                    sqlcmd = " INSERT INTO [sys_tqf_outcome]";
                    sqlcmd += " ([Id]";
                    sqlcmd += " ,[TQFId]";
                    sqlcmd += " ,[OutcomeId]";
                    sqlcmd += " ,[IsOK]";
                    sqlcmd += " ,[IsDelete]";
                    sqlcmd += " ,[CreateDate]";
                    sqlcmd += " ,[CreateBy] )";
                    sqlcmd += " VALUES (";
                    sqlcmd += "'" + id + "'";
                    sqlcmd += ",'" + TQFId + "'";
                    sqlcmd += ",'" + dr["id"].ToString() + "'";
                    sqlcmd += ",0";
                    sqlcmd += ",0";
                    sqlcmd += ",Getdate()";
                    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    Arrcmd.Add(sqlcmd);
                    id = (int.Parse(id) + 1).ToString();

                }
                cn.Execute(Arrcmd, null);
            }
            Dt = new DataTable();
            sqlcmd = "Select o.id as tqfoutcomeid,oc.topic,oc.id as outcomeid,isok as isok,Value from sys_tqf_outcome o inner join sys_master_outcome oc on o.outcomeid = oc.id where o.isdelete = 0 and oc.isdelete = 0  and o.tqfid = '" + TQFId + "'";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsoutcome();
                Obj.TQFoutcomeId = dr["TQFoutcomeId"].ToString();
                Obj.Topic = dr["Topic"].ToString();
                Obj.Value = dr["Value"].ToString();
                Obj.OutcomeId = dr["outcomeid"].ToString();
                Obj.IsOK = dr["IsOK"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        //[WebMethod]
        //public static List<Clsoutcome> Getoutcome(string json)
        //{
        //    string TQFId = json;
        //    Clsoutcome Obj;
        //    List<Clsoutcome> Objs = new List<Clsoutcome>();
        //    SqlConnector cn = new SqlConnector(Connectionstring, null);
        //    string sqlcmd = "";
        //    System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
        //    string id = "";
        //    DataTable Dt = new DataTable();
        //    //ตรวจก่อนว่ามีหรือไม่

        //    sqlcmd = "Select * from sys_tqf_outcome where isdelete = 0 and tqfid = '" + TQFId + "'";
        //    Dt = cn.Select(sqlcmd);

        //    if (Dt.Rows.Count == 0)
        //    {
        //        sqlcmd = "Select * from sys_master_outcome where isdelete = 0 and tqftype='4' order by id";
        //        Dt = cn.Select(sqlcmd);
        //        id = ClsEngine.GenerateRunningId(Connectionstring, "sys_tqf_outcome", "Id");
        //        foreach (DataRow dr in Dt.Rows)
        //        {
        //            sqlcmd = " INSERT INTO [sys_tqf_outcome]";
        //            sqlcmd += " ([Id]";
        //            sqlcmd += " ,[TQFId]";
        //            sqlcmd += " ,[OutcomeId]";
        //            sqlcmd += " ,[IsOK]";
        //            sqlcmd += " ,[IsDelete]";
        //            sqlcmd += " ,[CreateDate]";
        //            sqlcmd += " ,[CreateBy] )";
        //            sqlcmd += " VALUES (";
        //            sqlcmd += "'" + id + "'";
        //            sqlcmd += ",'" + TQFId + "'";
        //            sqlcmd += ",'" + dr["id"].ToString() + "'";
        //            sqlcmd += ",0";
        //            sqlcmd += ",0";
        //            sqlcmd += ",Getdate()";
        //            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
        //            Arrcmd.Add(sqlcmd);
        //            id = (int.Parse(id) + 1).ToString();

        //        }
        //        cn.Execute(Arrcmd, null);
        //    }
        //    Dt = new DataTable();
        //    sqlcmd = "Select o.id as tqfoutcomeid,oc.topic,oc.id as outcomeid,isok as isok from sys_tqf_outcome o inner join sys_master_outcome oc on o.outcomeid = oc.id where o.isdelete = 0 and oc.isdelete = 0  and o.tqfid = '" + TQFId + "'";
        //    Dt = cn.Select(sqlcmd);
        //    foreach (DataRow dr in Dt.Rows)
        //    {
        //        Obj = new Clsoutcome();
        //        Obj.TQFoutcomeId = dr["TQFoutcomeId"].ToString();
        //        Obj.Topic = dr["Topic"].ToString();
        //        Obj.OutcomeId = dr["outcomeid"].ToString();
        //        Obj.IsOK = dr["IsOK"].ToString();
        //        Objs.Add(Obj);
        //    }
        //    return Objs;
        //}
        [WebMethod]
        public static string Deleteobjective(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_Objective Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Addnewobjective(string json)
        {
            //json += 'HdTQFId:' + $('#HdTQFId').val();
            //json += 'Ctrl:' + Ctrl;
            //json += 'val:' + val;
            DataTable Dt = new DataTable();
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            List<ClsDict> Dicts = new List<ClsDict>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string sqlcmd = "";
            string id = "";
            string TQFId = ClsEngine.FindValue(Dicts, "HdTQFId");
            string val = ClsEngine.FindValue(Dicts, "val");
            sqlcmd = "Select * from Sys_Master_Objective where isdelete = 0 and id in(" + val + ")";
            Dt = cn.Select(sqlcmd);
            id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Objective", "Id");
            foreach (DataRow dr in Dt.Rows)
            {
                sqlcmd = " INSERT INTO [Sys_TQF_Objective]";
                sqlcmd += " ([Id]";
                sqlcmd += " ,[TQFId]";
                sqlcmd += " ,[ObjectiveId]";
                sqlcmd += " ,[IsCustomize]";
                sqlcmd += " ,[IsDelete]";
                sqlcmd += " ,[CreateDate]";
                sqlcmd += " ,[CreateBy] )";
                sqlcmd += " VALUES (";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + TQFId + "'";
                sqlcmd += ",'" + dr["id"].ToString() + "'";
                sqlcmd += ",1";
                sqlcmd += ",0";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                Arrcmd.Add(sqlcmd);
                id = (int.Parse(id) + 1).ToString();
            }
            cn.Execute(Arrcmd, null);
            return "";
        }
        [WebMethod]
        public static List<ClsObjective> Getobjective(string json)
        {
            string TQFId = json;
            ClsObjective Obj;
            List<ClsObjective> Objs = new List<ClsObjective>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            string id = "";
            DataTable Dt = new DataTable();
            //ตรวจก่อนว่ามีหรือไม่

            sqlcmd = "select TObj.id as TQFObjectiveid,TObj.Objectiveid,Code,Objective from [Sys_TQF_Objective] TOBJ left join Sys_Master_Objective Obj on TOBJ.ObjectiveId = Obj.id where Tobj.isdelete = 0  and Obj.isdelete = 0 and tqfid = '" + TQFId + "'";
            Dt = cn.Select(sqlcmd);

            if (Dt.Rows.Count == 0)
            {
                sqlcmd = "Select obj.id,obj.code,obj.objective from sys_master_objective obj inner join sys_master_tqfobjective tqf on obj.id = tqf.Objectiveid where obj.isdelete = 0 and tqf.isdelete = 0 and tqf.tqftype='4'";
                Dt = cn.Select(sqlcmd);
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Objective", "Id");
                foreach (DataRow dr in Dt.Rows)
                {
                    sqlcmd = " INSERT INTO [Sys_TQF_Objective]";
                    sqlcmd += " ([Id]";
                    sqlcmd += " ,[TQFId]";
                    sqlcmd += " ,[ObjectiveId]";
                    sqlcmd += " ,[IsDelete]";
                    sqlcmd += " ,[CreateDate]";
                    sqlcmd += " ,[CreateBy] )";
                    sqlcmd += " VALUES (";
                    sqlcmd += "'" + id + "'";
                    sqlcmd += ",'" + TQFId + "'";
                    sqlcmd += ",'" + dr["id"].ToString() + "'";
                    sqlcmd += ",0";
                    sqlcmd += ",Getdate()";
                    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    Arrcmd.Add(sqlcmd);
                    id = (int.Parse(id) + 1).ToString();

                }
                cn.Execute(Arrcmd, null);
            }
            Dt = new DataTable();
            sqlcmd = "select TObj.id as TQFObjectiveid,TObj.Objectiveid,Code,Objective,remark,iscustomize from [Sys_TQF_Objective] TOBJ left join Sys_Master_Objective Obj on TOBJ.ObjectiveId = Obj.id where Tobj.isdelete = 0  and Obj.isdelete = 0 and tqfid = '" + TQFId + "'";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsObjective();
                Obj.TQFObjectivesId = dr["TQFObjectiveid"].ToString();
                Obj.Code = dr["Code"].ToString();
                Obj.Objective = dr["Objective"].ToString();
                Obj.Remark = dr["Remark"].ToString();
                Obj.iscustomize = dr["iscustomize"].ToString();
                Objs.Add(Obj);
            }
            return Objs;

        }
        [WebMethod]
        public static string Save(string json)
        {
            //json += 'menu:' + menu + '|';
            //json += 'HdTQFId:' + $('#HdTQFId').val() + '|';
            //json += 'Txtcredits:' + $('#Txtcredits').val() + '|';
            //json += 'TxtsubjectDesc:' + $('#TxtsubjectDesc').val() + '|';
            //json += ':' + $('#Txtprerequisite').val() + '|';
            //json += ':' + $('#Txtcorequisite').val() + '|';
            //json += 'TxtlearningPlace:' + $('#TxtlearningPlace').val() + '|';
            //json += 'Txtlastupdatesubject:' + $('#Txtlastupdatesubject').val() + '|';
            //json += 'Txtgeneration:' + $('#Txtgeneration').val() + '|';
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            List<ClsDict> Dicts = new List<ClsDict>();
            string sqlcmd = "";
            Dicts = ClsEngine.DeSerialized(json, ':', '|');

            if (ClsEngine.FindValue(Dicts, "menu") == "7")
            {

                sqlcmd = " UPDATE [Sys_TQF_TQF4] Set ";
                sqlcmd += "  reestimate ='" + ClsEngine.FindValue(Dicts, "Txtreestimate") + "'";
                sqlcmd += "  ,reestimateperiod ='" + ClsEngine.FindValue(Dicts, "Txtreestimateperiod") + "'";
                sqlcmd += "  ,reestimateperson ='" + ClsEngine.FindValue(Dicts, "Txtreestimateperson") + "'";
                sqlcmd += " ,improve ='" + ClsEngine.FindValue(Dicts, "Txtimprove") + "'";
                sqlcmd += " ,improveobjective ='" + ClsEngine.FindValue(Dicts, "Txtimproveobjective") + "'";
                sqlcmd += " ,improvedata ='" + ClsEngine.FindValue(Dicts, "Txtimprovedata") + "'";
                sqlcmd += " ,improveperson ='" + ClsEngine.FindValue(Dicts, "Txtimproveperson") + "'";
                sqlcmd += " ,other ='" + ClsEngine.FindValue(Dicts, "Txtother") + "'";
                sqlcmd += " ,instuctor ='" + ClsEngine.FindValue(Dicts, "Txtinstuctor") + "'";
                sqlcmd += " ,instuctorpractical ='" + ClsEngine.FindValue(Dicts, "Txtinstuctorpractical") + "'";
                sqlcmd += " ,nurse ='" + ClsEngine.FindValue(Dicts, "Txtnurse") + "'";
                sqlcmd += " ,student ='" + ClsEngine.FindValue(Dicts, "Txtstudent") + "'";
                sqlcmd += " ,studentperiod ='" + ClsEngine.FindValue(Dicts, "Txtstudentperiod") + "'";
                sqlcmd += " ,studentperson ='" + ClsEngine.FindValue(Dicts, "Txtstudentperson") + "'";
       
                sqlcmd += " Where id= '" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }

            else if (ClsEngine.FindValue(Dicts, "menu") == "1")
            {
                sqlcmd = " UPDATE [Sys_TQF_TQF4] Set ";
                sqlcmd += "  Credits ='" + ClsEngine.FindValue(Dicts, "Txtcredits") + "'";
                sqlcmd += " ,Subjectgroup ='" + ClsEngine.FindValue(Dicts, "Cbsubjectgroup") + "'";
                sqlcmd += " ,SubjectDesc ='" + ClsEngine.FindValue(Dicts, "Txtsubjectdesc") + "'";
                sqlcmd += " ,Prerequisite ='" + ClsEngine.FindValue(Dicts, "Txtprerequisite") + "'";
                sqlcmd += " ,Corequisite ='" + ClsEngine.FindValue(Dicts, "Txtcorequisite") + "'";
                sqlcmd += " ,LearningPlace ='" + ClsEngine.FindValue(Dicts, "TxtlearningPlace") + "'";
                try
                {
                    sqlcmd += " ,Lastupdatesubject ='" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtlastupdatesubject"), '/') + "'";
                }
                catch (Exception ex)
                {
                    sqlcmd += " ,Lastupdatesubject =null";
                }
                sqlcmd += " ,Generation ='" + ClsEngine.FindValue(Dicts, "Txtgeneration") + "'";
                sqlcmd += " ,Quann ='" + ClsEngine.FindValue(Dicts, "Txtquann") + "'";
                sqlcmd += " Where id= '" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            else if (ClsEngine.FindValue(Dicts, "menu") == "2")
            {
                sqlcmd = " UPDATE [Sys_TQF_TQF4] Set ";
                sqlcmd += "  ObjectiveDesc ='" + ClsEngine.FindValue(Dicts, "Txtobjectivedesc") + "'";
                sqlcmd += " Where id= '" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            else if (ClsEngine.FindValue(Dicts, "menu") == "4")
            {
                sqlcmd = " UPDATE [Sys_TQF_TQF4] Set ";
                sqlcmd += "subjectremarkTH ='" + ClsEngine.FindValue(Dicts, "TxtsubjectremarkTH") + "'";
                sqlcmd += ",subjectremarkEN ='" + ClsEngine.FindValue(Dicts, "TxtsubjectremarkEN") + "'";
                sqlcmd += ",followtrainingfield ='" + ClsEngine.FindValue(Dicts, "Txtfollowtrainingfield") + "'";
                sqlcmd += ",responsibleinstuctor ='" + ClsEngine.FindValue(Dicts, "Txtresponsibleinstuctor") + "'";
                sqlcmd += ",responsibleinstuctorpractical ='" + ClsEngine.FindValue(Dicts, "Txtresponsibleinstuctorpractical") + "'";
                sqlcmd += ",resibleteacherassist ='" + ClsEngine.FindValue(Dicts, "Txtresibleteacherassist") + "'";
                sqlcmd += ",guide ='" + ClsEngine.FindValue(Dicts, "Txtguide") + "'";
                sqlcmd += ",accessary ='" + ClsEngine.FindValue(Dicts, "Txtaccessary") + "'";
                sqlcmd += " Where id= '" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            else if (ClsEngine.FindValue(Dicts, "menu") == "5")
            {
                sqlcmd = " UPDATE [Sys_TQF_TQF4] Set ";
                sqlcmd += "Preparestudent ='" + ClsEngine.FindValue(Dicts, "Txtpreparestudent") + "'";

                sqlcmd += ",Preparestudentmethod ='" + ClsEngine.FindValue(Dicts, "Txtpreparestudentmethod") + "'";
                sqlcmd += ",Preparestudentoutput ='" + ClsEngine.FindValue(Dicts, "Txtpreparestudentoutput") + "'";


                sqlcmd += ",Prepareteacher ='" + ClsEngine.FindValue(Dicts, "Txtprepareteacher") + "'";
                sqlcmd += ",Prepareteacherpractical ='" + ClsEngine.FindValue(Dicts, "Txtprepareteacherpractical") + "'";
                sqlcmd += ",Managerisk ='" + ClsEngine.FindValue(Dicts, "Txtmanagerisk") + "'";
                sqlcmd += " Where id= '" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            else if (ClsEngine.FindValue(Dicts, "menu") == "6")
            {
                sqlcmd = " UPDATE [Sys_TQF_TQF4] Set ";
                sqlcmd += " estimatestudent ='" + ClsEngine.FindValue(Dicts, "Txtestimatestudent") + "'";
                sqlcmd += ",reponsibleteacher ='" + ClsEngine.FindValue(Dicts, "Txtreponsibleteacher") + "'";
                sqlcmd += ",reponsiblecoteacher ='" + ClsEngine.FindValue(Dicts, "Txtreponsiblecoteacher") + "'";
                sqlcmd += ",summaryestimate ='" + ClsEngine.FindValue(Dicts, "Txtsummaryestimate") + "'";
                sqlcmd += " Where id= '" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            Cn.Execute(sqlcmd, null);
            return "";

        }
        //[WebMethod]
        //public static string Updateoutcome(string json)
        //{

        //    List<ClsDict> Dicts = new List<ClsDict>();
        //    SqlConnector cn = new SqlConnector(Connectionstring, null);
        //    Dicts = ClsEngine.DeSerialized(json, ':', '|');
        //    string sqlcmd = "Update Sys_TQF_outcome set Value ='" + ClsEngine.FindValue(Dicts, "val") + "' Where id='" + ClsEngine.FindValue(Dicts, "TQFoutcomeid") + "'";
        //    cn.Execute(sqlcmd, null);
        //    return "";


        //}

        [WebMethod]
        public static string Updateratio(string json)
        {
            //json += 'TQFInstuctorid:' + TQFInstuctorid + '|';
            //json += 'val:' + $('#' + ctrl).val() + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string sqlcmd = "Update Sys_TQF_Estimate set Ratio ='" + ClsEngine.FindValue(Dicts, "val") + "' Where id='" + ClsEngine.FindValue(Dicts, "Estimateid") + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Updateobjectiveremark(string json)
        {
            //json += 'TQFInstuctorid:' + TQFInstuctorid + '|';
            //json += 'val:' + $('#' + ctrl).val() + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string sqlcmd = "Update Sys_TQF_Objective set Remark ='" + ClsEngine.FindValue(Dicts, "val") + "' Where id='" + ClsEngine.FindValue(Dicts, "TQFObjectiveid") + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Updatetext(string json)
        {
            //json += 'TQFInstuctorid:' + TQFInstuctorid + '|';
            //json += 'val:' + $('#' + ctrl).val() + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string sqlcmd = "Update Sys_TQF_Instructor set Exp='" + ClsEngine.FindValue(Dicts, "val") + "' Where id='" + ClsEngine.FindValue(Dicts, "TQFInstuctorid") + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Selectedinstuctor(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            string sqlcmd = "";
            string id = "";
            string TQFId = "";
            DataTable Dt = new DataTable();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            //json += 'x :' + x + '|';
            //json += 'HdInstuctortypeid :' + $('#HdInstuctortypeid').val() + '|';
            try
            {  
                Dicts = ClsEngine.DeSerialized(json, ':', '|');
                if (ClsEngine.FindValue(Dicts, "HdInstuctortypeid") != "P")
                {
                    sqlcmd = "select * from Sys_Master_Instuctor where userid = '" + ClsEngine.FindValue(Dicts, "x") + "'";
                }
                else
                {
                    sqlcmd = "select * from Sys_Master_PreInstuctor where userid = '" + ClsEngine.FindValue(Dicts, "x") + "'";
                }
                Dt = cn.Select(sqlcmd);
                TQFId = ClsEngine.FindValue(Dicts, "TQFId");
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Instructor", "Id");
                sqlcmd = " INSERT INTO [Sys_TQF_Instructor] ";
                sqlcmd += " ([Id] ";
                sqlcmd += " ,[TQFId] ";
                sqlcmd += " ,[Userid] ";
                sqlcmd += " ,[Firstname] ";
                sqlcmd += " ,[Lastname] ";
                sqlcmd += " ,[EducationalBackground] ";
                sqlcmd += " ,[InstuctorType] ";
                sqlcmd += " ,[Isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " VALUES (";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + TQFId + "'";
                sqlcmd += ",'" + Dt.Rows[0]["Userid"].ToString() + "'";
                sqlcmd += ",'" + Dt.Rows[0]["Firstname"].ToString() + "'";
                sqlcmd += ",'" + Dt.Rows[0]["Lastname"].ToString() + "'";
                sqlcmd += ",'" + Dt.Rows[0]["Educationbackground"].ToString() + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "HdInstuctortypeid") + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            finally
            {
                cn.Close();
            }
            return "";
        }
        [WebMethod]
        public static ClsTQF4 LoadTQFInfo(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from [Sys_TQF_TQF4] where id = '" + json + "'";
            DataTable Dt = new DataTable();
            ClsTQF4 Obj = new ClsTQF4();
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count == 0)
            {
                Obj.error = "ไม่พบรายการ โปรดติดต่อผู้ดูแลระบบ";
            }
            Obj.id = json;
            Obj.Coursegroupid = Dt.Rows[0]["Coursegroupid"].ToString();
            Obj.Coursegroupname = Dt.Rows[0]["Coursegroupname"].ToString();
            Obj.OwnerorgId = Dt.Rows[0]["OwnerorgId"].ToString();
            Obj.Ownerorgname = Dt.Rows[0]["Ownerorgname"].ToString();
            Obj.Courseid = Dt.Rows[0]["Courseid"].ToString();
            Obj.Coursename = Dt.Rows[0]["Coursename"].ToString();
            Obj.Subjectid = Dt.Rows[0]["Subjectid"].ToString();
            Obj.Subjectname = Dt.Rows[0]["Subjectname"].ToString();
            Obj.SubjectnameEN = Dt.Rows[0]["SubjectnameEN"].ToString();
            Obj.Credits = Dt.Rows[0]["Credits"].ToString();



            Obj.Subjectgroup = Dt.Rows[0]["Subjectgroup"].ToString();
            Obj.SubjectDesc = Dt.Rows[0]["SubjectDesc"].ToString();
            Obj.Prerequisite = Dt.Rows[0]["Prerequisite"].ToString();
            Obj.Corequisite = Dt.Rows[0]["Corequisite"].ToString();
            Obj.LearningPlace = Dt.Rows[0]["LearningPlace"].ToString();
            if (Dt.Rows[0]["Lastupdatesubject"].ToString() == "")
            {
                Obj.Lastupdatesubject = "";
            }
            else
            {
                Obj.Lastupdatesubject = ClsEngine.Convertdate2ddmmyyyy(DateTime.Parse(Dt.Rows[0]["Lastupdatesubject"].ToString()), "/", true);

            }
            Obj.Term = Dt.Rows[0]["Term"].ToString();
            Obj.Class = Dt.Rows[0]["Class"].ToString();
            Obj.Year = (int.Parse(Dt.Rows[0]["Year"].ToString()) + 543).ToString();
            Obj.Generation = Dt.Rows[0]["Generation"].ToString();
            Obj.Quann = Dt.Rows[0]["Quann"].ToString();
            Obj.Objectivedesc = Dt.Rows[0]["Objectivedesc"].ToString();
            Obj.SubjectremarkTH = Dt.Rows[0]["SubjectremarkTH"].ToString();
            Obj.SubjectremarkEN = Dt.Rows[0]["SubjectremarkEN"].ToString();
            Obj.Followtrainingfield = Dt.Rows[0]["Followtrainingfield"].ToString();
            Obj.Responsibleinstuctor = Dt.Rows[0]["responsibleinstuctor"].ToString();
            Obj.Responsibleinstuctorpractical = Dt.Rows[0]["responsibleinstuctorpractical"].ToString();
            Obj.Resibleteacherassist = Dt.Rows[0]["resibleteacherassist"].ToString();
            Obj.Guide = Dt.Rows[0]["guide"].ToString();
            Obj.Accessary = Dt.Rows[0]["accessary"].ToString();

            Obj.Student = Dt.Rows[0]["Student"].ToString();
            Obj.Studentperiod = Dt.Rows[0]["Studentperiod"].ToString();
            Obj.Studentperson = Dt.Rows[0]["Studentperson"].ToString();
            Obj.Nurse = Dt.Rows[0]["Nurse"].ToString();
            Obj.Improve = Dt.Rows[0]["Improve"].ToString();
            Obj.Improveobjective = Dt.Rows[0]["Improveobjective"].ToString();
            Obj.Improvedata = Dt.Rows[0]["Improvedata"].ToString();
            Obj.Improveperson = Dt.Rows[0]["Improveperson"].ToString();
            Obj.Other = Dt.Rows[0]["Other"].ToString();
            Obj.Instuctor = Dt.Rows[0]["Instuctor"].ToString();
            Obj.Instuctorpractical = Dt.Rows[0]["Instuctorpractical"].ToString();
            Obj.Reestimate = Dt.Rows[0]["Reestimate"].ToString();
            Obj.Reestimateperiod = Dt.Rows[0]["Reestimateperiod"].ToString();
            Obj.Reestimateperson = Dt.Rows[0]["Reestimateperson"].ToString();
            Obj.Preparestudent = Dt.Rows[0]["Preparestudent"].ToString();

            Obj.Preparestudentmethod = Dt.Rows[0]["Preparestudentmethod"].ToString();
            Obj.Preparestudentoutput = Dt.Rows[0]["Preparestudentoutput"].ToString();
            Obj.Prepareteacher = Dt.Rows[0]["Prepareteacher"].ToString();
            Obj.Prepareteacherpractical = Dt.Rows[0]["Prepareteacherpractical"].ToString();
            Obj.Managerisk = Dt.Rows[0]["Managerisk"].ToString();
            Obj.Estimatestudent = Dt.Rows[0]["Estimatestudent"].ToString();
            Obj.Reponsibleteacher = Dt.Rows[0]["Reponsibleteacher"].ToString();
            Obj.Reponsiblecoteacher = Dt.Rows[0]["Reponsiblecoteacher"].ToString();
            Obj.Summaryestimate = Dt.Rows[0]["Summaryestimate"].ToString();

            Obj.error = "";
            //Instuctor Load ใส่ Grid เอา
            return Obj;
        }
        [WebMethod]
        public static ClsTQF4 DonewTQF(string json)
        {
            //json += 'Cbnewcollege :' + $('#Cbnewcollege').val() + '|'
            //json += 'Cbnewcourse :' + $('#Cbnewcourse').val() + '|'
            //json += 'Cbnewsubject :' + $('#Cbnewsubject').val() + '|'
            //json += 'Cbnewterm :' + $('#Cbnewterm').val() + '|'
            //json += 'Cbnewclass :' + $('#Cbnewclass').val() + '|'
            //json += 'Cbnewyear :' + $('#Cbnewyear').val() + '|'
            ClsTQF4 Obj = new ClsTQF4();
            string Subjectname = "";
            string Year = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbnewyear");
            string Term = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbnewterm");
            string Class = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbnewclass");
            string Courseid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbnewcourse");
            string Subjectid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbnewsubject");
            string Generation = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtnewgeneration");
            string sqlcmd = "Select c.Coursename,cg.Id as Coursegroupid,cg.Coursegroup,o.id as orgid,OrganizenameTH from Sys_Master_Course c left join Sys_Master_Coursegroup cg on c.Coursegroupid = cg.id left join Sys_Master_Organize o on c.OwnerorgId = o.id where c.isdelete = 0 and cg.isdelete = 0 and c.Id = '" + Courseid + "'";
            DataTable Dt = new DataTable();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dt = cn.Select(sqlcmd);
            DataTable Dtsubject = new DataTable();

            sqlcmd = "Select * from sys_master_subject where isdelete = 0 and id ='" + Subjectid + "'";
            Dtsubject = cn.Select(sqlcmd);
            Subjectname = Dtsubject.Rows[0]["Subjectname"].ToString();
            ArrayList Arrcmd = new ArrayList();
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_TQF", "Id");
            const string TQFType = "4";
            sqlcmd = " INSERT INTO [Sys_TQF_TQF]  ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[TQFType] ";
            sqlcmd += " ,[IsDelete] ";
            sqlcmd += " ,[CreateDate] ";
            sqlcmd += " ,[CreateBy] ) ";
            sqlcmd += " Values( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + TQFType + "'";
            sqlcmd += ",0 ";
            sqlcmd += ",getdate() ";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            Arrcmd.Add(sqlcmd);
            sqlcmd = " INSERT INTO [Sys_TQF_TQF4] ";
            sqlcmd += " ([Id] ";
            sqlcmd += " ,[Coursegroupid] ";
            sqlcmd += " ,[Coursegroupname] ";
            sqlcmd += " ,[OwnerorgId] ";
            sqlcmd += " ,[Ownerorgname] ";
            sqlcmd += " ,[Courseid] ";
            sqlcmd += " ,[Coursename] ";
            sqlcmd += " ,[Subjectid] ";
            sqlcmd += " ,[Subjectname] ";
            sqlcmd += " ,[Term] ";
            sqlcmd += " ,[Class] ";
            sqlcmd += " ,[Year] ";
            sqlcmd += " ,[Status]  ";
            sqlcmd += " ,[Statusname] ";

            sqlcmd += " ,[SubjectDesc] ";
            sqlcmd += " ,[SubjectGroup] ";
            sqlcmd += " ,[Credits] ";
            sqlcmd += " ,[SubjectnameEN] ";
            sqlcmd += " ,[SubjectRemarkTH] ";
            sqlcmd += " ,[SubjectRemarkEN] ";
            sqlcmd += " ,[Generation] ";
            sqlcmd += " ,[IsDelete] ";
            sqlcmd += " ,[CreateDate] ";
            sqlcmd += " ,[Modifydate] ";
            sqlcmd += " ,[ModifyBy] ";
            sqlcmd += " ,[CreateBy] ) ";
            sqlcmd += " VALUES ";
            sqlcmd += "( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + Dt.Rows[0]["Coursegroupid"].ToString() + "'";
            sqlcmd += ",'" + Dt.Rows[0]["Coursegroup"].ToString() + "'";
            sqlcmd += ",'" + Dt.Rows[0]["orgid"].ToString() + "'";
            sqlcmd += ",'" + Dt.Rows[0]["organizenameth"].ToString() + "'";
            sqlcmd += ",'" + Courseid + "'";
            sqlcmd += ",'" + Dt.Rows[0]["Coursename"].ToString() + "'";
            sqlcmd += ",'" + Subjectid + "'";
            sqlcmd += ",'" + Subjectname + "'";
            sqlcmd += ",'" + Term + "'";
            sqlcmd += ",'" + Class + "'";
            sqlcmd += ",'" + Year + "'";
            sqlcmd += ",''";
            sqlcmd += ",'บันทึกแบบร่าง'";

            sqlcmd += ",'" + Dtsubject.Rows[0]["SubjectDesc"].ToString() + "'";
            sqlcmd += ",'" + Dtsubject.Rows[0]["SubjectGroup"].ToString() + "'";

            sqlcmd += ",'" + Dtsubject.Rows[0]["Credit"].ToString() + "'";
            sqlcmd += ",'" + Dtsubject.Rows[0]["SubjectnameEN"].ToString() + "'";
            sqlcmd += ",'" + Dtsubject.Rows[0]["SubjectRemark"].ToString() + "'";
            sqlcmd += ",'" + Dtsubject.Rows[0]["SubjectRemarkEN"].ToString() + "'";
            sqlcmd += ",'" + Generation + "'";


            sqlcmd += ",'0'";
            sqlcmd += ",getdate() ";
            sqlcmd += ",getdate() ";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            Arrcmd.Add(sqlcmd);
            cn.Execute(Arrcmd, null);
            Obj.error = "";
            Obj.id = id;
            return Obj;
        }
        [WebMethod]
        public static List<ClsDict> Getnewyear(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            ClsDict Objdict;
            int minyear = System.DateTime.Now.AddYears(-5).Year;
            int maxyear = System.DateTime.Now.Year;
            if (minyear > 2500)
            {
                minyear = minyear - 543;
            }
            if (maxyear > 2500)
            {
                maxyear = maxyear - 543;
            }
            for (int i = maxyear; i >= minyear; i--)
            {
                Objdict = new ClsDict();
                Objdict.Name = (i + 543).ToString();
                Objdict.Val = i.ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getnewclass(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,class from Sys_Master_class where isdelete = 0  order by class";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["class"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getnewterm(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,term from Sys_Master_term where isdelete = 0  order by term";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["term"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getnewcollege(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_Organize where isdelete = 0 and id ='" + ((Clsuser)HttpContext.Current.Session["My"]).iseducate + "'";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["Organizenameth"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getnewsubject(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,Subjectname from Sys_Master_Subject where isdelete = 0 and courseid= '" + json + "' order by Subjectname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["Subjectname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getcourse(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,Coursename from Sys_Master_Course where isdelete = 0  and OwnerorgId = '" + ((Clsuser)HttpContext.Current.Session["My"]).iseducate + "' order by Coursename";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["Coursename"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        //[WebMethod]
        //public static List<ClsDict> Getcourse(string json)
        //{
        //    SqlConnector cn = new SqlConnector(Connectionstring, null);
        //    string sqlcmd = "Select id,Coursename from Sys_Master_Course where isdelete = 0  order by Coursename";
        //    DataTable Dt = new DataTable();
        //    Dt = cn.Select(sqlcmd);
        //    ClsDict Objdict;
        //    List<ClsDict> Dicts = new List<ClsDict>();
        //    foreach (DataRow dr in Dt.Rows)
        //    {
        //        Objdict = new ClsDict();
        //        Objdict.Name = dr["Coursename"].ToString();
        //        Objdict.Val = dr["id"].ToString();
        //        Dicts.Add(Objdict);
        //    }
        //    return Dicts;
        //}

        #region "Grid"
        [WebMethod]
        public static string CallBackUpload(string ProjectCode, string Ctrl, string RunningNo)
        {
            return "";
        }
        [WebMethod]
        public static string ExecuteDeleteGrid(string Ctrl, string PK)
        {
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            List<ClsDict> Dats = new List<ClsDict>();
            Dats = ClsEngine.DeSerialized(PK, ':', '|'); //Data for Delete key:Value|
            if (Ctrl == "GvresponsibleInstructor")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_Instructor] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvtool")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_tool] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvother")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_Otherdocument] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvjournal")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_Journal] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvebook")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_Ebook] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvinquiry")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_Inquiry] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvtextbook")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_Textbook] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "GvtheoryInstructor")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_Instructor] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "GvextraInstructor")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_Instructor] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "GvpreInstructor")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_Instructor] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            return "";
        }
        [WebMethod]
        public static string ExecuteGrid(string Mode, string Ctrl, string Dat, string PK)
        {
            return "";
        }
        [WebMethod]
        public static string GetTotalRecord(string Ctrl)
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            return ObjGrid.GetTotalRecord(Ctrl);
        }
        [WebMethod]
        public static string GetCriteriaValue()
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            return ObjGrid.GetCriteriaValue();
        }
        [WebMethod]
        public static void ClearResource(string Ctrl)
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            ObjGrid.ClearResource(Ctrl);
        }
        [WebMethod]
        public static void Selected(string Ctrl, string ProjectId) //Finished
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            ObjGrid.Selected(Ctrl, ProjectId);

        }
        [WebMethod]
        public static ClsDictExtend DatSelect(string Ctrl, string PK, string SelName)
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            return ObjGrid.DatSelect(Ctrl, PK, SelName);
        }
        [WebMethod]
        public static void UnSelected(string Ctrl, string ProjectId) //Finished
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            ObjGrid.UnSelected(Ctrl, ProjectId);
        }
        [WebMethod]
        public static void SelectAll(string Ctrl, string PK)
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            ObjGrid.SelectAll(Ctrl, PK);
        }


        [WebMethod] //Finished
        public static string UnSelectAll(string Ctrl)
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            return ObjGrid.UnSelectAll(Ctrl);
        }

        [WebMethod]
        public static ClsGridResponse Bind(string Ctrl, long PagePerItem, long CurrentPage, string SortName, string Order, string Column, string Data, string Initial, string SelectCat, string SearchMsg, string EditButton, string DeleteButton, string Panel, string FullRowSelect, string Multiselect, string Criteria, string SearchesDat, string Searchcolumns, string WPanel, string HPanel)
        {
            string Sqlcmd = "";
            string PK = "";
            string instuctorid = "";
            List<ClsDict> CriterialMapping = new List<ClsDict>();
            ClsGrid Objgrid = new ClsGrid();
            Clsuser Objmy = (Clsuser)HttpContext.Current.Session["My"];
            if (Ctrl == "Gvsearchother")
            {
                PK = "id";
                Sqlcmd = "Select m.id,otherdocument from Sys_Master_Otherdocument m where m.id not in (select Otherid from Sys_TQF_Otherdocument d where isdelete = 0 and TQFId = '" + Criteria + "') and m.isdelete = 0 ";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvsearchebook")
            {
                PK = "id";
                Sqlcmd = "Select m.id,m.Ebook from Sys_Master_Ebook m where m.id not in (select Ebookid from Sys_TQF_Ebook d where isdelete = 0 and TQFId = '" + Criteria + "') and m.isdelete = 0 ";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvsearchinquiry")
            {
                PK = "id";
                Sqlcmd = "Select m.id,m.Inquiry from Sys_Master_Inquiry m where m.id not in (select Inquiryid from Sys_TQF_Inquiry d where isdelete = 0 and TQFId = '" + Criteria + "') and m.isdelete = 0 ";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvsearchjournal")
            {
                PK = "id";
                Sqlcmd = "Select m.id,m.Journal from Sys_Master_Journal m where m.id not in (select Journalid from Sys_TQF_Journal d where isdelete = 0 and TQFId = '" + Criteria + "') and m.isdelete = 0 ";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvsearchtool")
            {
                PK = "id";
                Sqlcmd = "Select m.id,m.tool from Sys_Master_tool m where m.id not in (select toolId from Sys_TQF_tool d where isdelete = 0 and TQFId = '" + Criteria + "') and m.isdelete = 0 ";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvsearchtextbook")
            {
                PK = "id";
                Sqlcmd = "Select m.id,m.Textbook from Sys_Master_Textbook m where m.id not in (select TextbookId from Sys_TQF_Textbook d where isdelete = 0 and TQFId = '" + Criteria + "') and m.isdelete = 0 ";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }


            else if (Ctrl == "Gvother")
            {
                PK = "id";
                Sqlcmd = "Select od.id as id,Otherdocument from Sys_TQF_Otherdocument od inner join Sys_Master_Otherdocument m on m.id = od.Otherid where m.isdelete =0  and od.isdelete = 0 and tqfid = '" + Criteria + "'";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvebook")
            {
                PK = "id";
                Sqlcmd = "Select d.id as id,Ebook from Sys_TQF_ebook d inner join Sys_Master_ebook m on m.id = d.ebookid where m.isdelete =0  and d.isdelete = 0 and tqfid = '" + Criteria + "'";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvinquiry")
            {
                PK = "id";

                Sqlcmd = "Select d.id as id,Inquiry from Sys_TQF_inquiry d inner join Sys_Master_inquiry m on m.id = d.Inquiryid where m.isdelete =0  and d.isdelete = 0 and tqfid = '" + Criteria + "'";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);

                    string id = "";
                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        id = ((DataTable)HttpContext.Current.Session["RAW_Gvinquiry"]).Rows[i]["id"].ToString();
                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {

                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Inquiry".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<a style='text-decoration:underline;' target='_blank' href='http://" + ObjGridResponse.ResData[i][j].Val.Replace("http://", "") + "'>" + ObjGridResponse.ResData[i][j].Val + "</a>";
                            }
                        }
                    }


                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            //else if (Ctrl == "Gvinquiry")
            //{
            //    PK = "id";
            //    Sqlcmd = "Select d.id as id,Inquiry from Sys_TQF_inquiry d inner join Sys_Master_inquiry m on m.id = d.Inquiryid where m.isdelete =0  and d.isdelete = 0 and tqfid = '" + Criteria + "'";
            //    Criteria = "";
            //    SqlConnector Cn = new SqlConnector(Connectionstring, null);
            //    try
            //    {
            //        ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
            //        return ObjGridResponse;
            //    }
            //    catch (Exception ex)
            //    {
            //        return null;
            //    }
            //    finally
            //    {
            //        Cn.Close();
            //    }
            //}
            else if (Ctrl == "Gvjournal")
            {
                PK = "id";
                Sqlcmd = "Select d.id as id,Journal from Sys_TQF_journal d inner join Sys_Master_Journal m on m.id = d.Journalid where m.isdelete =0  and d.isdelete = 0 and tqfid = '" + Criteria + "'";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvtool")
            {
                PK = "id";
                Sqlcmd = "Select d.id as id,tool from Sys_TQF_tool d inner join Sys_Master_tool m on m.id = d.toolId where m.isdelete =0  and d.isdelete = 0 and tqfid = '" + Criteria + "'";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvtextbook")
            {
                PK = "id";
                Sqlcmd = "Select d.id as id,Textbook from Sys_TQF_Textbook d inner join Sys_Master_Textbook m on m.id = d.TextbookId where m.isdelete =0  and d.isdelete = 0 and tqfid = '" + Criteria + "'";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvnewobjective")
            {
                PK = "id";

                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                Sqlcmd = "Select id,code + ' ' + Objective as Objective from Sys_Master_Objective where isdelete = 0 and id not in (Select objectiveid from Sys_TQF_Objective where isdelete =0  and TQFId = '" + Criteria + "')";
                Criteria = "";
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "GvregisterStudent")
            {
                PK = "id";
                DataTable Dtinfo = new DataTable();
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                Dtinfo = Cn.Select("Select * from Sys_TQF_TQF4 where isdelete = 0 and id='" + Criteria + "'");
                Sqlcmd = "Select Studentno,Firstname,lastname,CONVERT(nvarchar,registerdate,103) as registerdate from Sys_Registration_StudentRegister where isdelete = 0 and[Courseid] = '" + Dtinfo.Rows[0]["Courseid"].ToString() + "' and[Subjectid] = '" + Dtinfo.Rows[0]["Subjectid"].ToString() + "' and[year] = '" + Dtinfo.Rows[0]["Year"].ToString() + "' and class = '" + Dtinfo.Rows[0]["Class"].ToString() + "' and term = '" + Dtinfo.Rows[0]["Term"].ToString() + "'";
                Criteria = "";
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvsearchinstuctor")
            {
                if (Criteria.Split('|')[0] != "P")
                {
                    PK = "Userid";
                    Sqlcmd = "Select * from [Sys_Master_Instuctor] M inner join Sys_Master_Organizeuser d on m.Userid = d.Userid where  m.isdelete = 0 and d.Orgid = '" + ((Clsuser)HttpContext.Current.Session["My"]).iseducate + "' and InstuctorType='" + Criteria.Split('|')[0] + "' and m.Userid  not in (Select userid from Sys_TQF_Instructor where isdelete = 0 and InstuctorType = '" + Criteria.Split('|')[0] + "' and TQFid = '" + Criteria.Split('|')[1] + "')";
                    //Sqlcmd = "Select * from [Sys_Master_Instuctor] where isdelete = 0 and InstuctorType='" + Criteria.Split('|')[0] + "' and Userid  not in (Select userid from Sys_TQF_Instructor where isdelete = 0 and InstuctorType = '" + Criteria.Split('|')[0] + "' and TQFid = '" + Criteria.Split('|')[1] + "')";
                    //PK = "Userid";
                    //Sqlcmd = "Select * from [Sys_Master_Instuctor] where isdelete = 0 and InstuctorType='" + Criteria.Split('|')[0] + "' and Userid  not in (Select userid from Sys_TQF_Instructor where isdelete = 0 and InstuctorType = '" + Criteria.Split('|')[0] + "' and TQFid = '" + Criteria.Split('|')[1] + "')";
                }
                else
                {
                    PK = "Userid";
                    Sqlcmd = "Select * from [Sys_Master_PreInstuctor] where isdelete = 0 and  Userid  not in (Select userid from Sys_TQF_Instructor where isdelete = 0 and InstuctorType = '" + Criteria.Split('|')[0] + "' and TQFid = '" + Criteria.Split('|')[1] + "')";
                }
                //Sqlcmd = "Select * from [Sys_Master_Instuctor] where isdelete = 0 and InstuctorType='" + Criteria + "'";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }

            else if (Ctrl == "GvtheoryInstructor")
            {
                PK = "id";
                Sqlcmd = "Select * from Sys_TQF_Instructor where isdelete = 0 and InstuctorType = 'T' and TQFId = '" + Criteria + "'";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);

                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        instuctorid = ((DataTable)HttpContext.Current.Session["RAW_GvtheoryInstructor"]).Rows[i]["id"].ToString();
                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {

                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Exp".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<input type='text' onblur=\"Updatetext('" + instuctorid + "','TxtGvtheoryInstructor_" + instuctorid + "');\" class='form-control' id='TxtGvtheoryInstructor_" + instuctorid + "' value='" + ObjGridResponse.ResData[i][j].Val + "'>";
                            }
                        }
                    }
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "GvextraInstructor")
            {
                PK = "id";
                Sqlcmd = "Select * from Sys_TQF_Instructor where isdelete = 0 and InstuctorType = 'E' and TQFId = '" + Criteria + "'";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);

                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        instuctorid = ((DataTable)HttpContext.Current.Session["RAW_GvextraInstructor"]).Rows[i]["id"].ToString();
                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {

                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Exp".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<input type='text' onblur=\"Updatetext('" + instuctorid + "','TxtGvextraInstructor_" + instuctorid + "');\" class='form-control' id='TxtGvextraInstructor_" + instuctorid + "' value='" + ObjGridResponse.ResData[i][j].Val + "'>";
                            }
                        }
                    }
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }

            else if (Ctrl == "GvpreInstructor")
            {
                PK = "id";
                Sqlcmd = "Select * from Sys_TQF_Instructor where isdelete = 0 and InstuctorType = 'P' and TQFId = '" + Criteria + "'";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);

                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        instuctorid = ((DataTable)HttpContext.Current.Session["RAW_GvpreInstructor"]).Rows[i]["id"].ToString();
                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {

                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Exp".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<input type='text' onblur=\"Updatetext('" + instuctorid + "','TxtGvpreInstructor_" + instuctorid + "');\" class='form-control' id='TxtGvpreInstructor_" + instuctorid + "' value='" + ObjGridResponse.ResData[i][j].Val + "'>";
                            }
                        }
                    }
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }

            else if (Ctrl == "GvresponsibleInstructor")
            {
                PK = "id";
                Sqlcmd = "Select * from Sys_TQF_Instructor where isdelete = 0 and InstuctorType = 'R' and TQFId = '" + Criteria + "'";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);

                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        instuctorid = ((DataTable)HttpContext.Current.Session["RAW_GvresponsibleInstructor"]).Rows[i]["id"].ToString();
                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {

                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Exp".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<input type='text' onblur=\"Updatetext('" + instuctorid + "','TxtGvresponsibleInstructor_" + instuctorid + "');\" class='form-control' id='TxtGvresponsibleInstructor_" + instuctorid + "' value='" + ObjGridResponse.ResData[i][j].Val + "'>";
                            }
                        }
                    }
                    return ObjGridResponse;
                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvsearchcourse")
            {
                string comment = "";
                string id = "";
                string status = "";
                PK = "id";
                Sqlcmd = "Select Comment, Status,subjectname,Generation, cast(Year as int) + 543 as year, id,Coursegroupname,Ownerorgname,Coursename,convert(nvarchar,modifydate,103) as modifydate,Statusname,'' as Del,'' as Action  from sys_TQF_TQF4 where isdelete = 0 and Createby ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                if (Criteria != "")
                {
                    Sqlcmd += " and Courseid='" + Criteria + "'";
                }
                Criteria = "";

                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        comment = ((DataTable)HttpContext.Current.Session["RAW_Gvsearchcourse"]).Rows[i]["comment"].ToString();
                        status = ((DataTable)HttpContext.Current.Session["RAW_Gvsearchcourse"]).Rows[i]["status"].ToString();
                        id = ((DataTable)HttpContext.Current.Session["RAW_Gvsearchcourse"]).Rows[i]["id"].ToString();
                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {
                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Statusname".ToLower())
                            {
                                if (status == "W")
                                {
                                    ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;color:blue;'>รอตรวจสอบ</a>";
                                }
                                else if (status == "")
                                {
                                    if (comment != "")
                                    {
                                        ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;color:blue;' >ขอแก้ไขเพิ่มเติม</a><br>";
                                        ObjGridResponse.ResData[i][j].Val += "<a style='cursor:pointer;color:blue;' onclick='Showcomment(" + id + ");' >ดูความคิดเห็น</a>";
                                    }
                                    else
                                    {
                                        ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;color:blue;' >บันทึกแบบร่าง</a>";
                                    }

                                }
                                else if (status == "V")
                                {
                                    ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;color:blue;'>รออนุมัติ</a>";
                                }
                                else if (status == "A")
                                {
                                    if (comment != "")
                                    {
                                        ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;color:green;' >อนุมัติแล้ว</a><br>";
                                        ObjGridResponse.ResData[i][j].Val += "<a style='cursor:pointer;color:blue;' onclick='Showcomment(" + id + ");' >ดูความคิดเห็น</a>";
                                    }
                                    else
                                    {
                                        ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;color:green;' >อนุมัติแล้ว</a>";
                                    }

                                }
                                else if (status == "R")
                                {
                                    if (comment != "")
                                    {
                                        ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;color:red;'>ไม่อนุมัติ</a><br>";
                                        ObjGridResponse.ResData[i][j].Val += "<a style='cursor:pointer;color:blue;' onclick='Showcomment(" + id + ");' >ดูความคิดเห็น</a>";
                                    }
                                    else
                                    {
                                        ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;color:red;'>ไม่อนุมัติ</a>";
                                    }

                                }
                            }
                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "subjectname".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;' onclick='SelectTQF(" + id + ");'>" + ObjGridResponse.ResData[i][j].Val + "</a>";
                            }
                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Del".ToLower())
                            {
                                if (status == "")
                                {
                                    ObjGridResponse.ResData[i][j].Val = "<button style='z-index:9999;font-size:9px !important;'  class='btn btn-danger' onclick='DelTQF(" + id + ");'><i class='fa fa-trash' style='font-size:9px !important;' aria-hidden='true'></i></button>";
                                }
                                else
                                {
                                    ObjGridResponse.ResData[i][j].Val = "-";
                                }

                            }
                        }
                    }
                    return ObjGridResponse;

                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            else if (Ctrl == "Gvsearchcourseapprove")
            {
                string comment = "";
                string id = "";
                string status = "";
                PK = "id";
                Sqlcmd = "Select comment,Status,subjectname,Generation cast(Year as int) + 543 as year, id,Coursegroupname,Ownerorgname,Coursename,convert(nvarchar,modifydate,103) as modifydate,Status,Statusname from sys_TQF_TQF4 where isdelete = 0 and ( (Validateuserid ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' and status = 'W') OR (Approveuserid ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' and status = 'V'))";
                Criteria = "";

                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        comment = ((DataTable)HttpContext.Current.Session["RAW_Gvsearchcourseapprove"]).Rows[i]["comment"].ToString();
                        status = ((DataTable)HttpContext.Current.Session["RAW_Gvsearchcourseapprove"]).Rows[i]["status"].ToString();
                        id = ((DataTable)HttpContext.Current.Session["RAW_Gvsearchcourseapprove"]).Rows[i]["id"].ToString();
                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {
                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Statusname".ToLower())
                            {
                                if (status == "W")
                                {

                                    ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;color:blue;' onclick='Validate(" + id + ");'>กดเพื่อตรวจสอบ</a><br>";
                                    if (comment != "")
                                    {
                                        ObjGridResponse.ResData[i][j].Val += "<a style='cursor:pointer;color:blue;' onclick='Showcomment(" + id + ");' >ดูความคิดเห็น</a>";
                                    }
                                }
                                else if (status == "V")
                                {
                                    ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;color:blue;' onclick='Approve(" + id + ");'>กดเพื่ออนุมัติ</a><br>";
                                    if (comment != "")
                                    {
                                        ObjGridResponse.ResData[i][j].Val += "<a style='cursor:pointer;color:blue;' onclick='Showcomment(" + id + ");' >ดูความคิดเห็น</a>";
                                    }
                                }

                            }
                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "subjectname".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;' >" + ObjGridResponse.ResData[i][j].Val + "</a>";
                            }

                        }
                    }
                    return ObjGridResponse;

                }
                catch (Exception ex)
                {
                    return null;
                }
                finally
                {
                    Cn.Close();
                }
            }
            //else if (Ctrl == "Gvsearchcourse")
            //{
            //    PK = "id";
            //    Sqlcmd = "Select subjectname,Generation, cast(Year as int) + 543 as year,id,Coursegroupname,Ownerorgname,Coursename,convert(nvarchar,modifydate,103) as modifydate,Statusname from sys_TQF_TQF4 where isdelete = 0 and Createby ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            //    if (Criteria != "")
            //    {
            //        Sqlcmd += " and Courseid='" + Criteria + "'";
            //    }
            //    Criteria = "";

            //    SqlConnector Cn = new SqlConnector(Connectionstring, null);
            //    try
            //    {
            //        ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
            //        return ObjGridResponse;
            //    }
            //    catch (Exception ex)
            //    {
            //        return null;
            //    }
            //    finally
            //    {
            //        Cn.Close();
            //    }
            //}

            return null;
        }
        [WebMethod]
        public static List<ClsDict> Load2GridPanel(string Ctrl, string dat)
        {
            return null;
        }
        [WebMethod]
        public static string Sort(string Ctrl, string ColName)
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            return ObjGrid.Sort(Ctrl, ColName);
        }
        [WebMethod]
        public static ClsGridResponse GetResource(string Ctrl)
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            return ObjGrid.GetResource(Ctrl);
        }
        [WebMethod]
        public static string UpdCurrentPage(string Ctrl, string CurrentPage)
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            return ObjGrid.UpdCurrentPage(Ctrl, CurrentPage);
        }
        [WebMethod]
        public static string UpdInitial(string Ctrl, string Initial)
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            return ObjGrid.UpdInitial(Ctrl, Initial);
        }
        [WebMethod]
        public static string Export(string Ctrl)
        {
            ClsGrid ObjGrid;
            ObjGrid = (ClsGrid)HttpContext.Current.Session["ObjGrid"];
            return ObjGrid.Export(Ctrl);
        }

        #endregion
    }
}