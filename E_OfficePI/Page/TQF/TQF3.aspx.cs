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
    public partial class TQF3 : System.Web.UI.Page
    {
        private static string Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;

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
        public static string Updateother(string json, string dat)
        {

            //TxtdevoO_1: 1 | TxtdevoD_1:2 | TxtdevoS_1:3 | TxtdevoR_1:4 | TxtdevoO_4:5 | TxtdevoD_4:6 | TxtdevoS_4:7 | TxtdevoR_4:8 |
            dat = dat.Replace("Txtother_", "");
            string sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            string[] Arrcomp;
            Arrcomp = dat.Split('|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            foreach (string str in Arrcomp)
            {
                if (str.Trim() != "")
                {

                    sqlcmd = "Update Sys_TQF_Otherdocument set Value ='" + str.Split(':')[1] + "',modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + str.Split(':')[0] + "'";
                    Arrcmd.Add(sqlcmd);
                }


            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }
        [WebMethod]
        public static List<Clsother> Getother(string json)
        {
            string TQFId = json;
            Clsother Obj;
            List<Clsother> Objs = new List<Clsother>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            DataTable Dt = new DataTable();
            //ตรวจก่อนว่ามีหรือไม่


            Dt = new DataTable();
            sqlcmd = "Select o.id as tqfotherid,Value from Sys_TQF_Otherdocument o  where o.isdelete = 0  and o.tqfid = '" + TQFId + "'";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsother();
                Obj.TQFotherId = dr["TQFotherId"].ToString();
                Obj.Value = dr["Value"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static string Deleteother(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_Otherdocument Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Newother(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Otherdocument", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_Otherdocument] ";
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
        public static string Updaterecommenddocument(string json, string dat)
        {
  
            //TxtdevoO_1: 1 | TxtdevoD_1:2 | TxtdevoS_1:3 | TxtdevoR_1:4 | TxtdevoO_4:5 | TxtdevoD_4:6 | TxtdevoS_4:7 | TxtdevoR_4:8 |
            dat = dat.Replace("Txtrecommenddocument_", "");
            string sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            string[] Arrcomp;
            Arrcomp = dat.Split('|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            foreach (string str in Arrcomp)
            {
                if (str.Trim() != "")
                {

                    sqlcmd = "Update Sys_TQF_recommenddocument set Value ='" + str.Split(':')[1] + "',modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + str.Split(':')[0] + "'";
                    Arrcmd.Add(sqlcmd);
                }


            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }
        [WebMethod]
        public static List<Clsrecommenddocument> Getrecommenddocument(string json)
        {
            string TQFId = json;
            Clsrecommenddocument Obj;
            List<Clsrecommenddocument> Objs = new List<Clsrecommenddocument>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            DataTable Dt = new DataTable();
            //ตรวจก่อนว่ามีหรือไม่

           
            Dt = new DataTable();
            sqlcmd = "Select o.id as tqfrecommenddocumentid,Value from sys_tqf_recommenddocument o  where o.isdelete = 0  and o.tqfid = '" + TQFId + "'";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsrecommenddocument();
                Obj.TQFrecommenddocumentId = dr["TQFrecommenddocumentId"].ToString();
                Obj.Value = dr["Value"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static string Deleterecommenddocument(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_recommenddocument Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Newrecommenddocument(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_recommenddocument", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_recommenddocument] ";
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
            string sqlcmd = "Select * from Sys_TQF_TQF3 where id = '" + json + "'";
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
                sqlcmd = "Update Sys_TQF_TQF3 Set Status ='V',Statusname='รออนุมัติ',Comment ='" + ClsEngine.FindValue(Dicts, "Txtcomment").Replace("'", "").Replace(",", "") + "' Where Id ='" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            else if (ClsEngine.FindValue(Dicts, "Hdapprove") == "A")
            {
                sqlcmd = "Update Sys_TQF_TQF3 Set Status ='A',Statusname='อนุมัติแล้ว',Comment ='" + ClsEngine.FindValue(Dicts, "Txtcomment").Replace("'", "").Replace(",", "") + "' Where Id ='" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
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
            sqlcmd = "Update Sys_TQF_TQF3 Set Status ='R',Statusname='ปฏิเสธ',Comment ='" + ClsEngine.FindValue(Dicts, "Txtcomment").Replace("'", "").Replace(",", "") + "' Where Id ='" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
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
                sqlcmd = "Update Sys_TQF_TQF3 Set Status ='',Statusname='',Comment ='" + ClsEngine.FindValue(Dicts, "Txtcomment").Replace("'", "").Replace(",", "") + "' Where Id ='" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            else if (ClsEngine.FindValue(Dicts, "Hdapprove") == "A")
            {
                sqlcmd = "Update Sys_TQF_TQF3 Set Status ='W',Statusname='รอตรวจสอบ',Comment ='" + ClsEngine.FindValue(Dicts, "Txtcomment").Replace("'", "").Replace(",", "") + "' Where Id ='" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string SelectTQF(string json)
        {
            string status = "";
            string sqlcmd = "Select * from Sys_TQF_TQF3 where id = '" + json + "'";
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
            sqlcmd = "Update Sys_TQF_TQF3 Set Comment='', Status ='W',Statusname='รอตรวจสอบ',Validateuserid='" + Dt.Rows[0]["Validatoruserid"].ToString() + "',Approveuserid='" + Dt.Rows[0]["Approveruserid"].ToString() + "' Where Id ='" + json + "'";
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
            sqlcmd = "Update [Sys_TQF_TQF3] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
            Arrcmd.Add(sqlcmd);
            sqlcmd = "Update [Sys_TQF_TQF] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
            Arrcmd.Add(sqlcmd);
            Cn.Execute(Arrcmd, null);
            return "";
        }
        [WebMethod]
        public static string Saveteachingplandetail(string json,string dat)
        {

            //Txtteachingplandetailsubject_2: 33 | Txtteachingplandetaildesc_2:33 | Txtteachingplandetailstudent_2:44 | Txtteachingplandetailplace_2:5 |
            List<ClsDict> Dicts = new List<ClsDict>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new ArrayList();
            Dicts = ClsEngine.DeSerialized(dat, ':', '|');
            foreach(ClsDict Objdict in Dicts)
            {
                if (Objdict.Name.Contains("Txtteachingplandetailsubject_"))
                {
                    sqlcmd = "Update [Sys_TQF_Teachingplandetail] Set Teachingplandetailsubject ='" + Objdict.Val + "',modifydate=getdate(),modifyby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + Objdict.Name.Replace("Txtteachingplandetailsubject_","") + "'";
                }
                else if (Objdict.Name.Contains("Txtteachingplandetaildesc_"))
                {
                    sqlcmd = "Update [Sys_TQF_Teachingplandetail] Set Teachingplandetaildesc ='" + Objdict.Val + "',modifydate=getdate(),modifyby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + Objdict.Name.Replace("Txtteachingplandetaildesc_", "") + "'";
                }
                else if (Objdict.Name.Contains("Txtteachingplandetailstudent_"))
                {
                    sqlcmd = "Update [Sys_TQF_Teachingplandetail] Set Teachingplandetailstudent ='" + Objdict.Val + "',modifydate=getdate(),modifyby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + Objdict.Name.Replace("Txtteachingplandetailstudent_", "") + "'";
                }
                else if (Objdict.Name.Contains("Txtteachingplandetailplace_"))
                {
                    sqlcmd = "Update [Sys_TQF_Teachingplandetail] Set Teachingplandetailplace ='" + Objdict.Val + "',modifydate=getdate(),modifyby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + Objdict.Name.Replace("Txtteachingplandetailplace_", "") + "'";
                }
                Arrcmd.Add(sqlcmd);
            }
            cn.Execute(Arrcmd, null);
            return "";
        }
        [WebMethod]
        public static string Savecost(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new ArrayList();
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_OfficialVisitCost", "id");
            sqlcmd = " Update [Sys_TQF_Cost] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            Arrcmd.Add(sqlcmd);
            DataTable Dtcost = new DataTable();
            Dtcost = cn.Select("Select * from sys_master_cost where isdelete = 0");
            foreach (DataRow dr in Dtcost.Rows)
            {
                foreach (ClsDict Objdict in Dicts)
                {
                    if (Objdict.Name.Replace("Txtcostvalue_", "") == dr["id"].ToString())
                    {

                        sqlcmd = " INSERT INTO [Sys_TQF_Cost] ";
                        sqlcmd += " ([id] ";
                        sqlcmd += " ,[TQFId] ";
                        sqlcmd += " ,[costid] ";
                        sqlcmd += " ,[Costvalue] ";
                        sqlcmd += " ,[isdelete]";
                        sqlcmd += " ,[CreateDate]";
                        sqlcmd += " ,[CreateBy] ) ";
                        sqlcmd += " Values (";
                        sqlcmd += "'" + id + "'";
                        sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
                        sqlcmd += ",'" + dr["id"].ToString() + "'"; // Costid
                        sqlcmd += ",'" + Objdict.Val + "'";
                        sqlcmd += ",0";
                        sqlcmd += ",getdate()";
                        sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                        Arrcmd.Add(sqlcmd);
                        id = (int.Parse(id) + 1).ToString();
                    }
                }
            }
            cn.Execute(Arrcmd, null);
            return "";
        }
        [WebMethod] //Finished
        public static List<ClsCost> Costdetail(string json)
        {
            List<ClsCost> Objs = new List<ClsCost>();
            ClsCost Obj;
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select c.id as costid, Costname,isnull(Costvalue,'') as Costvalue from Sys_Master_Cost c left join [SYS_TQF_COST] ovc on c.id = ovc.costid and ovc.isdelete = 0  and ovc.TQFID = '" + json + "'";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsCost();
                Obj.Costid = dr["Costid"].ToString();
                Obj.Costname = dr["Costname"].ToString();
                Obj.Costvalue = dr["Costvalue"].ToString();
                Objs.Add(Obj);
            }
            return Objs;

        }


        [WebMethod]
        public static string SelEst(string json)
        {
            ClsCallBackUpload ObjCallBack = new ClsCallBackUpload();
            DataTable Dt = new DataTable();
            SqlConnector _Cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            string id = "";
            List<ClsDict> Dicts = new List<ClsDict>();

            try
            {
                Dicts = ClsEngine.DeSerialized(json, ':', '|');
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_LearningEstimate", "id");
                sqlcmd = " INSERT INTO [dbo].[Sys_TQF_LearningEstimate] ";
                sqlcmd += "  ([Id] ";
                sqlcmd += "  ,[TQFId] ";
                sqlcmd += "  ,[LearningSetId] ";
                sqlcmd += "  ,[Estimateid] ";
                sqlcmd += "  ,[IsDelete]";
                sqlcmd += "  ,[CreateDate]";
                sqlcmd += "  ,[CreateBy] ) ";
                sqlcmd += " VALUES ( ";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "TQFId") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "LearningSetId") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Estimateid") + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                _Cn.Execute(sqlcmd, null);
                return "";
            }
            catch (Exception ex)
            {
                return null;
            }
            finally
            {
                _Cn.Close();
            }
        }

        [WebMethod]
        public static string SelPar(string json)
        {
            ClsCallBackUpload ObjCallBack = new ClsCallBackUpload();
            DataTable Dt = new DataTable();
            SqlConnector _Cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            string id = "";
            List<ClsDict> Dicts = new List<ClsDict>();
            
            try
            {
                Dicts = ClsEngine.DeSerialized(json, ':', '|');
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Learningpartcular", "id");
                sqlcmd = " INSERT INTO [Sys_TQF_Learningpartcular] ";
                sqlcmd += "  ([id] ";
                sqlcmd += "  ,[TQFId] ";
                sqlcmd += "  ,[LearningSetId] ";
                sqlcmd += "  ,[Particularid] ";
                sqlcmd += "  ,[IsDelete]";
                sqlcmd += "  ,[CreateDate]";
                sqlcmd += "  ,[CreateBy] ) ";
                sqlcmd += " VALUES ( ";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "TQFId") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "LearningSetId") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Particularid") + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                _Cn.Execute(sqlcmd, null);
                return "";
            }
            catch (Exception ex)
            {
                return null;
            }
            finally
            {
                _Cn.Close();
            }
        }
        [WebMethod]
        public static string SelLen(string json)
        {
            ClsCallBackUpload ObjCallBack = new ClsCallBackUpload();
            DataTable Dt = new DataTable();
            SqlConnector _Cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            string id = "";
            List<ClsDict> Dicts = new List<ClsDict>();
            
            try
            {
                Dicts = ClsEngine.DeSerialized(json, ':', '|');
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Learningoutput", "id");
                sqlcmd = " INSERT INTO [Sys_TQF_Learningoutput] ";
                sqlcmd += "  ([id] ";
                sqlcmd += "  ,[TQFId] ";
                sqlcmd += "  ,[LearningSetId] ";
                sqlcmd += "  ,[Learningoutputid] ";
                sqlcmd += "  ,[IsDelete]";
                sqlcmd += "  ,[CreateDate]";
                sqlcmd += "  ,[CreateBy] ) ";
                sqlcmd += " VALUES ( ";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts,"TQFId") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "LearningSetId") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Learningoutputid") + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                _Cn.Execute(sqlcmd, null);
                return "";
            }
            catch (Exception ex)
            {
                return null;
            }
            finally
            {
                _Cn.Close();
            }
        }

        
        [WebMethod]
        public static string DelLen(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_Learningoutput set isdelete = 1,deletedate=getdate(),deleteby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id ='" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";

        }

       

        [WebMethod]
        public static string DelEst(string json)
        {
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string Learningoutputid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Learningoutputid");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_Learningestimate set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "'  and Estimateid ='" + val + "'";
            cn.Execute(sqlcmd, null);
            return "";

        }

        

        [WebMethod]
        public static string DelInstructor(string json)
        {
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string Theoryplan = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Theoryplan");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update [Sys_TQF_TheoryplanInstructor] set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "'  and Theoryplanid ='" + Theoryplan + "' and Instructorid ='" + val + "'";
            cn.Execute(sqlcmd, null);
            cn.Close();
            return "";

        }

        [WebMethod]
        public static string DelPar(string json)
        {
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string Learningoutputid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Learningoutputid");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_Learningpartcular set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "'  and Particularid ='" + val + "'";
            cn.Execute(sqlcmd, null);
            return "";

        }
        [WebMethod]
        public static string DelLearningset(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_Leaningoutputset set isdelete = 1,deletedate=getdate(),deleteby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id ='" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";

        }
        [WebMethod]
        public static string Delteachingplandetail(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_Teachingplandetail set isdelete = 1,deletedate=getdate(),deleteby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id ='" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";

        }
        [WebMethod]
        public static string Delteachingplandetailattachmentconclusion(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_TeachingplandetailAttachmentConclusion set isdelete = 1,deletedate=getdate(),deleteby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where attachmentid='" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";

        }
        [WebMethod]
        public static string Delteachingplandetailattachmentplan(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update Sys_TQF_TeachingplandetailAttachmentPlan set isdelete = 1,deletedate=getdate(),deleteby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where attachmentid='" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
            
        }
        [WebMethod]
        public static ClsCallBackUpload CallBackUpload(string Ctrl, string RunningNo,string Teachingplandetailid,string TQFId)
        {
            ClsCallBackUpload ObjCallBack = new ClsCallBackUpload();
            DataTable Dt = new DataTable();
            SqlConnector _Cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Trans_Attachment Where Id ='" + RunningNo + "'";
            string id = "";
            try
            {
                if (Ctrl == "teachingplandetail")
                {
                    id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_TeachingplandetailAttachmentPlan", "id");
                    sqlcmd = "  INSERT INTO [Sys_TQF_TeachingplandetailAttachmentPlan] ";
                    sqlcmd += "  ([id]";
                    sqlcmd += "  ,[TQFId]";
                    sqlcmd += "  ,[Teachingplandetailid]";
                    sqlcmd += "  ,[Attachmentid]";
                    sqlcmd += "  ,[IsDelete]";
                    sqlcmd += "  ,[CreateDate]";
                    sqlcmd += "  ,[CreateBy] ) ";
                    sqlcmd += " VALUES ( ";
                    sqlcmd += "'" + id + "'";
                    sqlcmd += ",'" + TQFId + "'";
                    sqlcmd += ",'" + Teachingplandetailid + "'";
                    sqlcmd += ",'" + RunningNo + "'";
                    sqlcmd += ",'0'";
                    sqlcmd += ",getdate()";
                    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    _Cn.Execute(sqlcmd, null);

                }
                else if (Ctrl == "teachingplandetailconclusion")
                {
                    id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_TeachingplandetailAttachmentConclusion", "id");
                    sqlcmd = "  INSERT INTO [Sys_TQF_TeachingplandetailAttachmentConclusion] ";
                    sqlcmd += "  ([id]";
                    sqlcmd += "  ,[TQFId]";
                    sqlcmd += "  ,[Teachingplandetailid]";
                    sqlcmd += "  ,[Attachmentid]";
                    sqlcmd += "  ,[IsDelete]";
                    sqlcmd += "  ,[CreateDate]";
                    sqlcmd += "  ,[CreateBy] ) ";
                    sqlcmd += " VALUES ( ";
                    sqlcmd += "'" + id + "'";
                    sqlcmd += ",'" + TQFId + "'";
                    sqlcmd += ",'" + Teachingplandetailid + "'";
                    sqlcmd += ",'" + RunningNo + "'";
                    sqlcmd += ",'0'";
                    sqlcmd += ",getdate()";
                    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    _Cn.Execute(sqlcmd, null);
                }
                return ObjCallBack;
            }
            catch(Exception ex)
            {
                return null;
            }
            finally
            {
                _Cn.Close();
            }
        }

        
        [WebMethod]
        public static string Newlearningset(string json)
        {
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Leaningoutputset", "id");
            sqlcmd = " INSERT INTO [Sys_TQF_Leaningoutputset] ";
            sqlcmd += " ([Id] ";
            sqlcmd += ",[TQFId] ";
            sqlcmd += ",[IsDelete] ";
            sqlcmd += ",[CreateDate]";
            sqlcmd += ",[CreateBy] ) ";
            sqlcmd += "VALUES ";
            sqlcmd += "( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Newteachingplandetail(string json)
        {
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Teachingplandetail", "id");
            sqlcmd =  " INSERT INTO [Sys_TQF_Teachingplandetail] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[TQFId] ";
            sqlcmd += ",[IsDelete] ";
            sqlcmd += ",[CreateDate]";
            sqlcmd += ",[CreateBy] ) ";
            sqlcmd += "VALUES ";
            sqlcmd += "( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd,null);
            return "";
        }
        [WebMethod]
        public static List<ClsTeachingplandetail> Getteachingplandetail(string json)
        {
            List<ClsTeachingplandetail> Objs = new List<ClsTeachingplandetail>();
            ClsTeachingplandetail Obj;
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            DataTable Dtattchmentplan = new DataTable();
            DataTable Dtattchmentconclusion = new DataTable();
            DataRow[] Drs;
            ClsTeachingplandetailAttachment ObjTeachingplandetailAttachment;
            List<ClsTeachingplandetailAttachment> TeachingplandetailAttachments = new List<ClsTeachingplandetailAttachment>();
            sqlcmd = "Select * from Sys_TQF_Teachingplandetail where isdelete = 0 and tqfid ='" + json + "'";
            Dt = cn.Select(sqlcmd);

            sqlcmd = "Select * from Sys_TQF_TeachingplandetailAttachmentPlan p inner join Sys_Trans_Attachment a on p.attachmentid = a.id where p.isdelete = 0 and tqfid ='" + json + "'";
            Dtattchmentplan = cn.Select(sqlcmd);


            sqlcmd = "Select * from Sys_TQF_TeachingplandetailAttachmentConclusion  p inner join Sys_Trans_Attachment a on p.attachmentid = a.id where p.isdelete = 0 and tqfid ='" + json + "'";
            Dtattchmentconclusion = cn.Select(sqlcmd);


            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsTeachingplandetail();
                Obj.id = dr["id"].ToString();
                Obj.Teachingplandetailsubject  = dr["Teachingplandetailsubject"].ToString();
                Obj.Teachingplandetaildesc = dr["Teachingplandetaildesc"].ToString();
                Obj.Teachingplandetailstudent = dr["Teachingplandetailstudent"].ToString();
                Obj.Teachingplandetailplace = dr["Teachingplandetailplace"].ToString();
                //Attachment Section
                Obj.Teachingplandetailattchmentplan = new List<ClsTeachingplandetailAttachment>();
                TeachingplandetailAttachments = new List<ClsTeachingplandetailAttachment>();
                Drs = Dtattchmentplan.Select("Teachingplandetailid ='" + dr["id"].ToString() + "'");
                foreach(DataRow pdr in Drs)
                {
                    ObjTeachingplandetailAttachment = new ClsTeachingplandetailAttachment();
                    ObjTeachingplandetailAttachment.Attachmentid = pdr["Attachmentid"].ToString();
                    ObjTeachingplandetailAttachment.Filename = pdr["filename"].ToString();
                    ObjTeachingplandetailAttachment.Url = new System.IO.FileInfo(pdr["Path"].ToString()).Name;
                    TeachingplandetailAttachments.Add(ObjTeachingplandetailAttachment);
                }
                Obj.Teachingplandetailattchmentplan = TeachingplandetailAttachments;


                Obj.Teachingplandetailattchmentconclusion = new List<ClsTeachingplandetailAttachment>();
                TeachingplandetailAttachments = new List<ClsTeachingplandetailAttachment>();
                Drs = Dtattchmentconclusion.Select("Teachingplandetailid ='" + dr["id"].ToString() + "'");
                foreach (DataRow pdr in Drs)
                {
                    ObjTeachingplandetailAttachment = new ClsTeachingplandetailAttachment();
                    ObjTeachingplandetailAttachment.Attachmentid = pdr["Attachmentid"].ToString();
                    ObjTeachingplandetailAttachment.Filename = pdr["filename"].ToString();
                    ObjTeachingplandetailAttachment.Url = new System.IO.FileInfo(pdr["Path"].ToString()).Name;
                    TeachingplandetailAttachments.Add(ObjTeachingplandetailAttachment);
                }
                Obj.Teachingplandetailattchmentconclusion = TeachingplandetailAttachments;
                Objs.Add(Obj);
            }
            return Objs;
        }

        [WebMethod]
        public static string Saveestimateplan(string json)
        {
            //Txttpweekno_4:| Txttptrdate_4:| Txttptrtime_undefined:| Chktpobjecttive_4_1:on | Chktpobjecttive_4_2:on | Chktpobjecttive_4_3:on | Chktpobjecttive_4_4:on | Chktpparticular_4_1:on | Chktpparticular_4_2:on | Chktpestimate_4_1:on | Chktpestimate_4_2:on | Chktpestimate_4_3:on | Cbtpteachingplan_4:| Cbtpteachingtopic_4:|
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            ArrayList Arrcmd = new ArrayList();
            DataTable Dt = new DataTable();
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string id = "";
    
            string sqlcmd = "Select * from Sys_TQF_estimatePlan where tqfid ='" + ClsEngine.FindValue(Dicts, "TQFid") + "' and isdelete = 0";
            Dt = cn.Select(sqlcmd);

            

            foreach (DataRow dr in Dt.Rows)
            {
                id = dr["id"].ToString();
                foreach (ClsDict Objdict in Dicts)
                {
                    if (Objdict.Name.Contains("Txtestimateweek_" + id)) // Weekno
                    {
                        sqlcmd = "Update Sys_TQF_estimatePlan set week ='" + Objdict.Val.Replace(","," ") + "',modifydate=getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                        Arrcmd.Add(sqlcmd);
                    }
                    
                    if (Objdict.Name.Contains("Txtestimatepercent_" + id)) // trtime
                    {
                        sqlcmd = "Update Sys_TQF_estimatePlan set [percent] ='" + Objdict.Val + "',modifydate=getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                        Arrcmd.Add(sqlcmd);
                    }
                }

            }
            cn.Execute(Arrcmd, null);
            return "";
        }

        [WebMethod]
        public static string Savetheoryplan(string json)
        {
            //Txttpweekno_4:| Txttptrdate_4:| Txttptrtime_undefined:| Chktpobjecttive_4_1:on | Chktpobjecttive_4_2:on | Chktpobjecttive_4_3:on | Chktpobjecttive_4_4:on | Chktpparticular_4_1:on | Chktpparticular_4_2:on | Chktpestimate_4_1:on | Chktpestimate_4_2:on | Chktpestimate_4_3:on | Cbtpteachingplan_4:| Cbtpteachingtopic_4:|
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            ArrayList Arrcmd = new ArrayList();
            DataTable Dt = new DataTable();
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string id = "";
            //string teachingplanid = "";
            string _id = "";
            string sqlcmd = "Select * from Sys_TQF_TheoryPlan where tqfid ='" + ClsEngine.FindValue(Dicts, "TQFid") + "' and isdelete = 0";
            Dt = cn.Select(sqlcmd);

            _id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_TheoryplanTeachingTopic", "id");

            foreach (DataRow dr in Dt.Rows)
            {
                id = dr["id"].ToString();
                foreach(ClsDict Objdict in Dicts)
                {
                    if (Objdict.Name.Contains("Txttpweekno_" + id)) // Weekno
                    {
                        sqlcmd = "Update Sys_TQF_TheoryPlan set weekno ='" + Objdict.Val + "',modifydate=getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id  + "'";
                        Arrcmd.Add(sqlcmd);
                    }
                    if (Objdict.Name.Contains("Txttptrdate_" + id)) // trdate
                    {
                        if (Objdict.Val != "")
                        {
                            sqlcmd = "Update Sys_TQF_TheoryPlan set trdate ='" + ClsEngine.ConvertDateforSavingDatabase(Objdict.Val,'/') + "',modifydate=getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                            Arrcmd.Add(sqlcmd);
                        }
                    }
                    if (Objdict.Name.Contains("Txttptrtime_" + id)) // trtime
                    {
                        sqlcmd = "Update Sys_TQF_TheoryPlan set trtime ='" + Objdict.Val + "',modifydate=getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                        Arrcmd.Add(sqlcmd);
                    }
                    if (Objdict.Name.Contains("Txttptrtime_" + id)) // trtime
                    {
                        sqlcmd = "Update Sys_TQF_TheoryPlan set trtime ='" + Objdict.Val + "',modifydate=getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                        Arrcmd.Add(sqlcmd);
                    }
                    if (Objdict.Name.Contains("Txttpteachingplan_" + id)) // trtime
                    {
                        sqlcmd = "Update Sys_TQF_TheoryPlan set Teachingplanname ='" + Objdict.Val + "',modifydate=getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                        Arrcmd.Add(sqlcmd);
                    }
                    if (Objdict.Name.Contains("Txttpteachingtopic_" + id)) // trtime
                    {
                        sqlcmd = "Update Sys_TQF_TheoryPlan set Teachingplantopicname ='" + Objdict.Val + "',modifydate=getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                        Arrcmd.Add(sqlcmd);
                    }
                    //if (Objdict.Name.Contains("Cbtpins_" + id)) // trtime
                    //{
                    //    sqlcmd = "Update Sys_TQF_TheoryPlan set Instructorid ='" + Objdict.Val + "',modifydate=getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                    //    Arrcmd.Add(sqlcmd);
                    //}


                    //if (Objdict.Name.Contains("Cbtpteachingplan_" + id)) 
                    //{
                    //    teachingplanid = Objdict.Val;
                    //}
                    //if (Objdict.Name.Contains("Cbtpteachingtopic_" + id)) 
                    //{
                    //    sqlcmd = "Update [Sys_TQF_TheoryplanTeachingTopic] set isdelete =1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                    //    Arrcmd.Add(sqlcmd);

                    //    sqlcmd = " INSERT INTO [Sys_TQF_TheoryplanTeachingTopic] ";
                    //    sqlcmd += " ([id] ";
                    //    sqlcmd += " ,[TQFId] ";
                    //    sqlcmd += " ,[Theoryplanid] ";
                    //    sqlcmd += " ,Teachingplanid";
                    //    sqlcmd += " ,[Teachingtopicid] ";
                    //    sqlcmd += " ,[isdelete] ";
                    //    sqlcmd += " ,[CreateDate] ";
                    //    sqlcmd += " ,[CreateBy]) ";
                    //    sqlcmd += " Values('" + _id + "'";
                    //    sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "TQFid") + "'";
                    //    sqlcmd += ",'" + id + "'";
                    //    sqlcmd += ",'" + teachingplanid + "'";
                    //    sqlcmd += ",'" + Objdict.Val + "'";
                    //    sqlcmd += ",'0'";
                    //    sqlcmd += ",getdate()";
                    //    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    //    Arrcmd.Add(sqlcmd);
                    //    _id = (int.Parse(_id) + 1).ToString();

                    //}
                }
               
            }
            cn.Execute(Arrcmd, null);
            return "";
        }

        [WebMethod]
        public static string Iseducate()
        {
            return ((Clsuser)HttpContext.Current.Session["My"]).iseducate;
        }
        [WebMethod]
        public static string Deltheoryplan(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_TheoryPlan Set isdelete =1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Delestimateplan(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_estimatePlan Set isdelete =1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static List<ClsEstimatePlan> Getestimateplan(string json)
        {
            ClsEstimatePlan Obj;
            ClsEstimateplannestimate EObj;
           
            ClsEstimateplannobjective OObj;
           
            List<ClsEstimatePlan> Objs = new List<ClsEstimatePlan>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from [Sys_TQF_Estimateplan] where isdelete = 0 and tqfid ='" + json + "'";
            DataTable Dt = new DataTable();
            DataTable Dtobjective = new DataTable();
            DataTable Dtestimate = new DataTable();
            Dt = cn.Select(sqlcmd);




            foreach (DataRow dr in Dt.Rows)
            {
                //Dtobjective = new DataTable();
                //sqlcmd = "Select o.id as objectiveid, isnull(tf.id,'0') as id,o.code,o.objective as objective   from Sys_Master_Objective o left join [Sys_TQF_EstimateplanObjective]  tf on o.id = tf.ObjectiveId and Estimateplanid = '" + dr["id"].ToString() + "' and tf.isdelete = 0 where o.IsDelete = 0 ";
                //Dtobjective = cn.Select(sqlcmd);



                //Dtestimate = new DataTable();
                //sqlcmd = "Select  o.id as estimateid, isnull(tf.id,'0') as id,o.Estimate  from Sys_Master_Estimate o left join [Sys_TQF_EstimateplanEstimate]  tf on o.id = tf.estimateid and Estimateplanid = '" + dr["id"].ToString() + "' and tf.isdelete = 0 where o.IsDelete = 0 ";
                //Dtestimate = cn.Select(sqlcmd);


                Dtobjective = new DataTable();
                sqlcmd = "Select isnull(tf.id,0) as tpoid,d.id,[Output] as Output  from Sys_Master_Learningoutput m inner join Sys_Master_Learningoutputsubject d  on m.id = d.learningoutputid left join sys_TQF_TQF3 TQF on d.subjectid = tqf.subjectid  left join [Sys_TQF_estimateplanObjective] tf on d.id = tf.ObjectiveId and estimateplanid = '" + dr["id"].ToString() + "' and tf.isdelete = 0 where m.isdelete = 0 and d.isdelete = 0 and TQF.id = '" + json + "'";
                //sqlcmd = "Select o.id as objectiveid, isnull(tf.id,'0') as id,o.code,o.objective as objective   from Sys_Master_Objective o left join [Sys_TQF_estimateplanObjective]  tf on o.id = tf.ObjectiveId and estimateplanid = '" + dr["id"].ToString() + "' and tf.isdelete = 0 where o.IsDelete = 0 ";
                Dtobjective = cn.Select(sqlcmd);

               

                Dtestimate = new DataTable();
                sqlcmd = "Select distinct o.id as estimateid, isnull(tf.id,'0') as tpoid,o.estimate  from Sys_Master_estimate o right join Sys_TQF_LearningEstimate d on  d.TQFid ='" + json + "' and o.id = d.estimateid and d.isdelete = 0 left join[Sys_TQF_estimateplanestimate]  tf on o.id = tf.estimateid and estimateplanid = '" + dr["id"].ToString() + "' and tf.isdelete = 0 where o.IsDelete = 0 ";
                //sqlcmd = "Select o.id as estimateid, isnull(tf.id,'0') as id,o.Estimate  from Sys_Master_Estimate o left join [Sys_TQF_estimateplanEstimate]  tf on o.id = tf.estimateid and estimateplanid = '" + dr["id"].ToString() + "' and tf.isdelete = 0 where o.IsDelete = 0 ";
                Dtestimate = cn.Select(sqlcmd);



                Obj = new ClsEstimatePlan();
                Obj.id = dr["id"].ToString();
                Obj.Week = dr["Week"].ToString();
                if (dr["Percent"].ToString() != "")
                {
                    Obj.Percent = dr["Percent"].ToString();
                }
                else
                {
                    Obj.Percent = "0";
                }
                Obj.Estimateplanobjective = new List<ClsEstimateplannobjective>();
                foreach (DataRow o_dr in Dtobjective.Rows)
                {
                    OObj = new ClsEstimateplannobjective();
                    if (o_dr["tpoid"].ToString() != "0")
                    {
                        OObj.Selected = "X";
                    }
                    else
                    {
                        OObj.Selected = "";
                    }
                    OObj.Objectiveid = o_dr["id"].ToString();
                    OObj.Code = "";
                    OObj.Objective = o_dr["Output"].ToString();
                    Obj.Estimateplanobjective.Add(OObj);
                }
                Obj.Estimateplannestimate = new List<ClsEstimateplannestimate>();
                foreach (DataRow e_dr in Dtestimate.Rows)
                {
                    EObj = new ClsEstimateplannestimate();
                    if (e_dr["tpoid"].ToString() != "0")
                    {
                        EObj.Selected = "X";
                    }
                    else
                    {
                        EObj.Selected = "";
                    }
                    EObj.Estimateid = e_dr["Estimateid"].ToString();
                    EObj.Estimatename = e_dr["Estimate"].ToString();
                    Obj.Estimateplannestimate.Add(EObj);
                }
                Objs.Add(Obj);
            }
            cn.Close();
            return Objs;
        }

        [WebMethod]
        public static List<Clstheoryplan> Getheoryplan(string json)
        {
            Clstheoryplan Obj;
            ClsTheoryplannestimate EObj;
            ClsTheoryplannparticular PObj;
            ClsTheoryplannobjective OObj;
            //ClsTheoryplanntopic TObj;
            List<Clstheoryplan> Objs = new List<Clstheoryplan>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from [Sys_TQF_Theoryplan] where isdelete = 0 and tqfid ='" + json + "'";
            DataTable Dt = new DataTable();
            //DataTable Dttopic = new DataTable();
            DataTable Dtobjective = new DataTable();
            DataTable Dtparticular = new DataTable();
            DataTable Dtestimate = new DataTable();
            DataTable Dtins = new DataTable();
            DataTable Dtinstructor = new DataTable();
            Clsapproverusers _I;
            Clsapproverusers _V;
            List<Clsapproverusers> Vs = new List<Clsapproverusers>();
            Dt = cn.Select(sqlcmd);
            ArrayList ArrRes = new ArrayList();

            ArrRes = ClsEngine.Getsuborg(ref cn, ((Clsuser)HttpContext.Current.Session["My"]).iseducate);


            sqlcmd = "  Select isnull(e.InsRegular,'0'),isnull(e.InsTheory,'0'),isnull(e.InsExtra,'0'), u.id as Userid,isnull(FirstnameTH,'') as FirstnameTH, LastnameTH as LastnameTH  from sys_core_user u inner join Sys_HR_Empdetail e on u.id = e.userid left join Sys_Master_Organizeuser ou on ou.Userid = e.userid where u.isdelete =0  and e.isdelete = 0  and (isnull(e.InsRegular,'0') <> '0' OR isnull(e.InsTheory,'0') <> '0' OR isnull(e.InsExtra,'0') <> '0')  and Ou.Orgid in (" + ClsEngine.Serial(ArrRes) + ")";
            Dtins = cn.Select(sqlcmd);
            Dtinstructor = new DataTable();
            
            sqlcmd = "Select * from [Sys_TQF_TheoryplanInstructor] i inner join Sys_HR_Empdetail hr on i.Instructorid = hr.userid where i.isdelete = 0 and hr.isdelete = 0 and tqfid = '" + json + "'";
            Dtinstructor = cn.Select(sqlcmd);

            foreach (DataRow dr in Dt.Rows)
            {
                Dtobjective = new DataTable();
                sqlcmd = "Select isnull(tf.id,0) as tpoid,d.id,[Output] as Output  from Sys_Master_Learningoutput m inner join Sys_Master_Learningoutputsubject d  on m.id = d.learningoutputid left join sys_TQF_TQF3 TQF on d.subjectid = tqf.subjectid  left join [Sys_TQF_TheoryplanObjective] tf on d.id = tf.ObjectiveId and theoryplanid = '" + dr["id"].ToString() + "' and tf.isdelete = 0 where m.isdelete = 0 and d.isdelete = 0 and TQF.id = '" + json + "'";
                //sqlcmd = "Select o.id as objectiveid, isnull(tf.id,'0') as id,o.code,o.objective as objective   from Sys_Master_Objective o left join [Sys_TQF_TheoryplanObjective]  tf on o.id = tf.ObjectiveId and theoryplanid = '" + dr["id"].ToString() + "' and tf.isdelete = 0 where o.IsDelete = 0 ";
                Dtobjective = cn.Select(sqlcmd);

                Dtparticular = new DataTable();

                sqlcmd = " Select distinct o.id as particularid, isnull(tf.id, '0') as tpoid,o.Particular from Sys_Master_Particular o right join Sys_TQF_Learningpartcular d on o.id = d.particularid and tqfid ='" + json + "' and d.isdelete = 0 left join[Sys_TQF_Theoryplanparticular]  tf on o.id = tf.particularid and theoryplanid = '" + dr["id"].ToString() + "' and tf.isdelete = 0 where o.IsDelete = 0 ";
                //sqlcmd = "Select o.id as particularid, isnull(tf.id,'0') as id,o.Particular  from Sys_Master_Particular o left join [Sys_TQF_Theoryplanparticular]  tf on o.id = tf.particularid and theoryplanid = '" + dr["id"].ToString() + "' and tf.isdelete = 0 where o.IsDelete = 0 ";
                Dtparticular = cn.Select(sqlcmd);

                Dtestimate = new DataTable();
                sqlcmd = "Select distinct o.id as estimateid, isnull(tf.id,'0') as tpoid,o.estimate  from Sys_Master_estimate o right join Sys_TQF_LearningEstimate d on o.id = d.estimateid and d.isdelete = 0  and tqfid ='" + json + "'  left join[Sys_TQF_Theoryplanestimate]  tf on o.id = tf.estimateid and theoryplanid = '" + dr["id"].ToString() + "' and tf.isdelete = 0 where o.IsDelete = 0 ";
                //sqlcmd = "Select o.id as estimateid, isnull(tf.id,'0') as id,o.Estimate  from Sys_Master_Estimate o left join [Sys_TQF_TheoryplanEstimate]  tf on o.id = tf.estimateid and theoryplanid = '" + dr["id"].ToString() + "' and tf.isdelete = 0 where o.IsDelete = 0 ";
                Dtestimate = cn.Select(sqlcmd);

             

                Obj = new Clstheoryplan();
                Obj.id = dr["id"].ToString();
                Obj.Weekno = dr["Weekno"].ToString();
                Obj.Trdate = ClsEngine.ValidateDateBud(DateTime.Parse(dr["Trdate"].ToString()));
                Obj.Trtime = dr["Trtime"].ToString();

                Obj.Teachingplantopicname = dr["Teachingplantopicname"].ToString();
                Obj.Teachingplanname = dr["Teachingplanname"].ToString();

                Obj.Instructors = new List<Clsapproverusers>();
                foreach(DataRow _idr in Dtinstructor.Select("Theoryplanid ='" + dr["id"].ToString() + "'"))
                {
                    _I = new Clsapproverusers();
                    _I.Userid = _idr["Userid"].ToString();
                    _I.Firstname = _idr["FirstnameTH"].ToString();
                    _I.Lastname = _idr["LastnameTH"].ToString();
                    Obj.Instructors.Add(_I);
                }
                Vs = new List<Clsapproverusers>();
                foreach (DataRow _dr in Dtins.Rows)
                {
                    _V = new Clsapproverusers();
                    _V.Userid = _dr["Userid"].ToString();
                    _V.Firstname = _dr["FirstnameTH"].ToString();
                    _V.Lastname = _dr["LastnameTH"].ToString();
                    Vs.Add(_V);
                }
                Obj.TemplateInstructors = Vs;

            


                Obj.Createbynameth = dr["Createbynameth"].ToString();
                Obj.Theoryplanobjective = new List<ClsTheoryplannobjective>();
                foreach (DataRow o_dr in Dtobjective.Rows)
                {
                    OObj = new ClsTheoryplannobjective();
                    if (o_dr["tpoid"].ToString() != "0")
                    {
                        OObj.Selected = "X";
                    }
                    else
                    {
                        OObj.Selected = "";
                    }
                    OObj.Objectiveid = o_dr["id"].ToString();
                    OObj.Code = "";
                    OObj.Objective = o_dr["output"].ToString();
                    Obj.Theoryplanobjective.Add(OObj);
                }

                Obj.Theoryplannparticular = new List<ClsTheoryplannparticular>();
                foreach (DataRow p_dr in Dtparticular.Rows)
                {
                    PObj = new ClsTheoryplannparticular();
                    if (p_dr["tpoid"].ToString() != "0")
                    {
                        PObj.Selected = "X";
                    }
                    else
                    {
                        PObj.Selected = "";
                    }
                    PObj.Particularid = p_dr["Particularid"].ToString();
                    PObj.Particularname = p_dr["Particular"].ToString();
                    Obj.Theoryplannparticular.Add(PObj);
                }

                Obj.Theoryplannestimate = new List<ClsTheoryplannestimate>();
                foreach (DataRow e_dr in Dtestimate.Rows)
                {
                    EObj = new ClsTheoryplannestimate();
                    if (e_dr["tpoid"].ToString() != "0")
                    {
                        EObj.Selected = "X";
                    }
                    else
                    {
                        EObj.Selected = "";
                    }
                    EObj.Estimateid = e_dr["Estimateid"].ToString();
                    EObj.Estimatename = e_dr["Estimate"].ToString();
                    Obj.Theoryplannestimate.Add(EObj);
                }


                Objs.Add(Obj);
            }
            cn.Close();
            return Objs;
        }
        [WebMethod] 
        public static string Newtheoryplan(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Theoryplan", "id");
            sqlcmd = " INSERT INTO [Sys_TQF_Theoryplan] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[TQFId] ";
            sqlcmd += " ,[Trdate] ";
            sqlcmd += " ,[Createbyid] ";
            sqlcmd += " ,[Createbynameth] ";
            sqlcmd += " ,[isdelete] ";
            sqlcmd += " ,[CreateDate] ";
            sqlcmd += " ,[CreateBy] )";
            sqlcmd += " VALUES ";
            sqlcmd += "( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).firstnameth + " " + ((Clsuser)HttpContext.Current.Session["My"]).lastnameth + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd,null);
            return "";
        }

        [WebMethod]
        public static string Newestimateplan(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_estimateplan", "id");
            sqlcmd = " INSERT INTO [Sys_TQF_estimateplan] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[TQFId] ";
            sqlcmd += " ,[isdelete] ";
            sqlcmd += " ,[CreateDate] ";
            sqlcmd += " ,[CreateBy] )";
            sqlcmd += " VALUES ";
            sqlcmd += "( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + json + "'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Updateestimateobjective(string json)
        {
            //val:true|ctrl:Chktpparticular_1_1|
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string theoyplanid = ClsEngine.FindValue(Dicts, "ctrl").ToString().Replace("Chkepobjecttive_", "").Split('_')[0];
            string id = ClsEngine.FindValue(Dicts, "ctrl").ToString().Replace("Chkepobjecttive_", "").Split('_')[1];

            if (ClsEngine.FindValue(Dicts, "val") == "false")
            {
                sqlcmd = "update [Sys_TQF_estimateplanobjective] Set isdelete = 1,DeleteDate = getdate(),deleteby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where estimateplanid = '" + theoyplanid + "' and objectiveId = '" + id + "'";
            }
            else
            {
                sqlcmd = " INSERT INTO [Sys_TQF_estimateplanobjective] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[TQFid] ";
                sqlcmd += " ,[estimateplanid] ";
                sqlcmd += " ,[ObjectiveId] ";
                sqlcmd += " ,[isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " Values(";
                sqlcmd += "'" + ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_estimateplanobjective", "id") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "TQFid").ToString() + "'";
                sqlcmd += ",'" + theoyplanid + "'";
                sqlcmd += ",'" + id + "'";
                sqlcmd += ",0";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            }
            cn.Execute(sqlcmd, null);
            cn.Close();
            return "";
        }



        [WebMethod]
        public static string Updatetheoryobjective(string json)
        {
            //val:true|ctrl:Chktpparticular_1_1|
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string theoyplanid = ClsEngine.FindValue(Dicts, "ctrl").ToString().Replace("Chktpobjecttive_", "").Split('_')[0];
            string id = ClsEngine.FindValue(Dicts, "ctrl").ToString().Replace("Chktpobjecttive_", "").Split('_')[1];

            if (ClsEngine.FindValue(Dicts, "val") == "false")
            {
                sqlcmd = "update [Sys_TQF_Theoryplanobjective] Set isdelete = 1,DeleteDate = getdate(),deleteby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where Theoryplanid = '" + theoyplanid + "' and objectiveId = '" + id + "'";
            }
            else
            {
                sqlcmd = " INSERT INTO [Sys_TQF_Theoryplanobjective] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[TQFid] ";
                sqlcmd += " ,[Theoryplanid] ";
                sqlcmd += " ,[ObjectiveId] ";
                sqlcmd += " ,[isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " Values(";
                sqlcmd += "'" + ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Theoryplanobjective", "id") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "TQFid").ToString() + "'";
                sqlcmd += ",'" + theoyplanid + "'";
                sqlcmd += ",'" + id + "'";
                sqlcmd += ",0";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            }
            cn.Execute(sqlcmd, null);
            cn.Close();
            return "";
        }


        [WebMethod]
        public static string Updateestimateestimate(string json)
        {
            //val:true|ctrl:Chktpparticular_1_1|
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string theoyplanid = ClsEngine.FindValue(Dicts, "ctrl").ToString().Replace("Chkepestimate_", "").Split('_')[0];
            string id = ClsEngine.FindValue(Dicts, "ctrl").ToString().Replace("Chkepestimate_", "").Split('_')[1];

            if (ClsEngine.FindValue(Dicts, "val") == "false")
            {
                sqlcmd = "update [Sys_TQF_estimateplanestimate] Set isdelete = 1,DeleteDate = getdate(),deleteby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where estimateplanid = '" + theoyplanid + "' and estimateId = '" + id + "'";
            }
            else
            {
                sqlcmd = " INSERT INTO [Sys_TQF_estimateplanestimate] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[TQFid] ";
                sqlcmd += " ,[estimateplanid] ";
                sqlcmd += " ,[estimateId] ";
                sqlcmd += " ,[isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " Values(";
                sqlcmd += "'" + ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_estimateplanestimate", "id") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "TQFid").ToString() + "'";
                sqlcmd += ",'" + theoyplanid + "'";
                sqlcmd += ",'" + id + "'";
                sqlcmd += ",0";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            }
            cn.Execute(sqlcmd, null);
            cn.Close();
            return "";
        }

        [WebMethod]
        public static string Updatetheoryestimate(string json)
        {
            //val:true|ctrl:Chktpparticular_1_1|
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string theoyplanid = ClsEngine.FindValue(Dicts, "ctrl").ToString().Replace("Chktpestimate_", "").Split('_')[0];
            string id = ClsEngine.FindValue(Dicts, "ctrl").ToString().Replace("Chktpestimate_", "").Split('_')[1];

            if (ClsEngine.FindValue(Dicts, "val") == "false")
            {
                sqlcmd = "update [Sys_TQF_Theoryplanestimate] Set isdelete = 1,DeleteDate = getdate(),deleteby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where Theoryplanid = '" + theoyplanid + "' and estimateId = '" + id + "'";
            }
            else
            {
                sqlcmd = " INSERT INTO [Sys_TQF_Theoryplanestimate] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[TQFid] ";
                sqlcmd += " ,[Theoryplanid] ";
                sqlcmd += " ,[estimateId] ";
                sqlcmd += " ,[isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " Values(";
                sqlcmd += "'" + ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Theoryplanestimate", "id") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "TQFid").ToString() + "'";
                sqlcmd += ",'" + theoyplanid + "'";
                sqlcmd += ",'" + id + "'";
                sqlcmd += ",0";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            }
            cn.Execute(sqlcmd, null);
            cn.Close();
            return "";
        }
        

        [WebMethod]
        public static string Updatetheoryparticular(string json)
        {
            //val:true|ctrl:Chktpparticular_1_1|
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string theoyplanid = ClsEngine.FindValue(Dicts, "ctrl").ToString().Replace("Chktpparticular_", "").Split('_')[0];
            string id = ClsEngine.FindValue(Dicts, "ctrl").ToString().Replace("Chktpparticular_", "").Split('_')[1];
          
            if (ClsEngine.FindValue(Dicts, "val") == "false")
            {
                sqlcmd = "update [Sys_TQF_Theoryplanparticular] Set isdelete = 1,DeleteDate = getdate(),deleteby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where Theoryplanid = '" + theoyplanid + "' and ParticularId = '" + id + "'";
            }
            else
            {
                sqlcmd = " INSERT INTO [Sys_TQF_Theoryplanparticular] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[TQFid] ";
                sqlcmd += " ,[Theoryplanid] ";
                sqlcmd += " ,[ParticularId] ";
                sqlcmd += " ,[isdelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " Values(";
                sqlcmd += "'" + ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Theoryplanparticular", "id") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "TQFid").ToString() + "'";
                sqlcmd += ",'" + theoyplanid + "'";
                sqlcmd += ",'" + id + "'";
                sqlcmd += ",0";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            }
            cn.Execute(sqlcmd,null);
            cn.Close();
            return "";
        }
        [WebMethod]
        public static List<ClsDict> Getteachingtopic(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            ClsDict Obj;
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_Master_Teachingtopic where isdelete = 0 and Teachingplanid ='" + json + "' order by teachingtopicname";
            Dt = cn.Select(sqlcmd);
            Obj = new ClsDict();
            Obj.Name = "--ไม่ระบุ--";
            Obj.Val = "";
            Dicts.Add(Obj);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsDict();
                Obj.Name = dr["teachingtopicname"].ToString();
                Obj.Val = dr["id"].ToString();
                Dicts.Add(Obj);
            }
            cn.Close();
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getteachingtopicplan(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            ClsDict Obj;
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_Master_Teachingplan where isdelete = 0 order by teachingplanname";
            Dt = cn.Select(sqlcmd);

            Obj = new ClsDict();
            Obj.Name = "--ไม่ระบุ--";
            Obj.Val = "";
            Dicts.Add(Obj);

            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsDict();
                Obj.Name = dr["Teachingplanname"].ToString();
                Obj.Val = dr["id"].ToString();
                Dicts.Add(Obj);
            }
            cn.Close();
            return Dicts;
        }


        [WebMethod]
        public static ClsDictExtend Getteachingtopicinfo(string json)
        {
            ClsDictExtend Obj = new ClsDictExtend();
            DataTable Dt = new DataTable();
            string sqlcmd = "Select t.id,t.Teachingtopicname,t.[Desc] as Remark ,p.Teachingplanname,p.id as Teachingplanid from Sys_Master_Teachingtopic t inner join Sys_Master_Teachingplan p on t.Teachingplanid = p.id where t.isdelete = 0 and t.id = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "id") + "'";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dt = cn.Select(sqlcmd);
            Obj.Val = Dt.Rows[0]["id"].ToString();
            Obj.Name = Dt.Rows[0]["Teachingtopicname"].ToString();
            Obj.Extend1 = Dt.Rows[0]["Teachingplanid"].ToString();
            Obj.Extend2 = Dt.Rows[0]["Remark"].ToString();
            cn.Close();
            return Obj;
        }

        [WebMethod]
        public static ClsDict Getteachingplaninfo(string json)
        {
            ClsDict Obj = new ClsDict();
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_Master_Teachingplan where isdelete = 0 and id = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(json,':','|'),"id") + "'";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dt = cn.Select(sqlcmd);
            Obj.Val = Dt.Rows[0]["id"].ToString();
            Obj.Name = Dt.Rows[0]["Teachingplanname"].ToString();
            cn.Close();
            return Obj;
        }

        [WebMethod]
        public static string doSaveteachingtopic(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            string id = "";
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            if (ClsEngine.FindValue(Dicts, "id") == "")
            {
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_Teachingtopic", "id");
                sqlcmd = "insert into Sys_Master_Teachingtopic(id,Teachingplanid,teachingtopicname,[desc],isdelete,createdate,createby)";
                sqlcmd += "Values('" + id + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbteachingtopicplan") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtteachingtopicname") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtteachingtopicdesc") + "'";
                sqlcmd += ",0";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            }
            else
            {
                id = ClsEngine.FindValue(Dicts, "id");
                sqlcmd = "Update  Sys_Master_Teachingtopic set teachingtopicname ='" + ClsEngine.FindValue(Dicts, "Txtteachingtopicname") + "'";
                sqlcmd += ",Teachingplanid ='" + ClsEngine.FindValue(Dicts, "Cbteachingtopicplan") + "'";
                sqlcmd += ",[desc] ='" + ClsEngine.FindValue(Dicts, "Txtteachingtopicdesc") + "'";
                sqlcmd += ",Modifydate =getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                sqlcmd += " Where id='" + id + "'";
            }
            cn.Execute(sqlcmd, null);
            cn.Close();
            return "";
        }

        [WebMethod]
        public static string doSaveteachingplan(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            string id = "";
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            if (ClsEngine.FindValue(Dicts, "id") == "")
            {
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_Teachingplan", "id");
                sqlcmd = "insert into Sys_Master_Teachingplan(id,teachingplanname,isdelete,createdate,createby)";
                sqlcmd += "Values('" + id + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtteachingplanname") + "'";
                sqlcmd += ",0";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            }
            else
            {
                id = ClsEngine.FindValue(Dicts, "id");
                sqlcmd = "Update  Sys_Master_Teachingplan set teachingplanname ='" + ClsEngine.FindValue(Dicts, "Txtteachingplanname") + "'";
                sqlcmd += ",Modifydate =getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                sqlcmd += " Where id='" + id + "'";
            }
            cn.Execute(sqlcmd, null);
            cn.Close();
            return "";
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
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Otherdocumentdocument", "Id");
                sqlcmd = " INSERT INTO [Sys_TQF_Otherdocumentdocument] ";
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
        public static string Selectedrecommenddocument(string json)
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
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_Recommenddocument", "Id");
                sqlcmd = " INSERT INTO [Sys_TQF_Recommenddocument] ";
                sqlcmd += " ([Id] ";
                sqlcmd += " ,[TQFId] ";
                sqlcmd += " ,[RecommenddocumentId] ";
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
            foreach(DataRow dr in Dt.Rows)
            {
                Obj = new Clsparticular();
                Obj.Particularid = dr["id"].ToString();
                Obj.Particularname = dr["Particular"].ToString();
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
        public static List<Clsparticular> Getparticular()
        {
            Clsparticular Obj;
            List<Clsparticular> Objs = new List<Clsparticular>();
            DataTable Dt = new DataTable();  
            string sqlcmd = "Select *  from Sys_Master_Particular where isdelete = 0 ";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dt = cn.Select(sqlcmd);
            //Obj = new Clsparticular();
            //Obj.Particularid ="";
            //Obj.Particularname = "โปรดระบุ";
            //Objs.Add(Obj);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsparticular();
                Obj.Particularid = dr["id"].ToString();
                Obj.Particularname = dr["Particular"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }

        [WebMethod]
        public static string Saveest(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_Estimate", "Id");
            string sqlcmd = "";
            if (json == "")
            {
                return "ข้อมูลห้ามเป็นค่าว่าง";
            }
            if (cn.Select("Select * from Sys_Master_Estimate where isdelete =0 and Estimate ='" + json.Replace(",", "").Replace("'", "") + "'").Rows.Count > 0)
            {
                return "รายการ " + json.Replace(",", "").Replace("'", "") + " ซ้ำ โปรดตรวจสอบ";
            }
            sqlcmd += " INSERT INTO [Sys_Master_Estimate] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[Estimate]  ";
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
        public static string Savepar(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_Particular", "Id");
            string sqlcmd = "";
            if (json =="")
            {
                return "ข้อมูลห้ามเป็นค่าว่าง";
            }
            if (cn.Select("Select * from sys_master_particular where isdelete =0 and particular ='" + json.Replace(",", "").Replace("'", "") + "'").Rows.Count > 0)
            {
                return "รายการ " + json.Replace(",", "").Replace("'", "") + " ซ้ำ โปรดตรวจสอบ";
            }

            sqlcmd += " INSERT INTO [Sys_Master_Particular] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[Particular]  ";
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
        public static List<Clsestimate> Getestimate()
        {
            Clsestimate Obj;
            List<Clsestimate> Objs = new List<Clsestimate>();
            DataTable Dt = new DataTable();
            string sqlcmd = "Select *  from Sys_Master_Estimate where isdelete = 0 ";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dt = cn.Select(sqlcmd);
            Obj = new Clsestimate();
            Obj.Estimateid = "";
            Obj.Estimatename = "โปรดระบุ";
            Objs.Add(Obj);
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
        public static Clslearningoutput Getlearningoutput(string json)
        {
            Clslearningoutput Obj = new Clslearningoutput();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Clslen _Len;
            Clsparticular _Par;
            Clsestimate _Est;
            List<Clsestimate> Ests = new List<Clsestimate>();
            List<Clsparticular> Pars = new List<Clsparticular>();
            List<Clslen> Lens = new List<Clslen>();
            string sqlcmd = "";
            
            DataTable Dtparticular = new DataTable();
            DataTable Dtestimate = new DataTable();
            DataTable Dtlearningoutput = new DataTable();
           


            sqlcmd = "Select d.id,[Output] as Output from Sys_Master_Learningoutput m  inner join Sys_Master_Learningoutputsubject d  on m.id = d.learningoutputid left join sys_TQF_TQF3 TQF on d.subjectid = tqf.subjectid where m.isdelete = 0 and d.isdelete = 0 and TQF.id = '" + json + "'";
            Dtlearningoutput = cn.Select(sqlcmd);
            sqlcmd = "Select d.id as Learningparticularid, * from Sys_TQF_Learningpartcular d inner join Sys_Master_Particular m on d.Particularid = m.id where d.isdelete = 0 and TQFId = '" + json + "'";
            Dtparticular = cn.Select(sqlcmd);
            sqlcmd = "Select d.id as Learningestimateid, * from Sys_TQF_LearningEstimate d inner join Sys_Master_Estimate m on d.Estimateid = m.id where d.isdelete = 0 and TQFId = '" + json + "'";
            Dtestimate = cn.Select(sqlcmd);


            List<Clsestimate> MasterEsts = new List<Clsestimate>();
            List<Clsparticular> MasterPars = new List<Clsparticular>();

            MasterEsts = Getestimate();
            MasterPars = Getparticular();

            

            Lens = new List<Clslen>();
            Pars = new List<Clsparticular>();
            Ests = new List<Clsestimate>();



            foreach (DataRow _dr in Dtlearningoutput.Rows)
            {
                _Len = new Clslen();
                _Len.Learningoutputid = _dr["id"].ToString();
                _Len.Learningoutputname = _dr["Output"].ToString();
                Lens.Add(_Len);
            }
            Obj.Lens = Lens;
            Obj.MasterEstimates = MasterEsts;
            Obj.MasterParticulars = MasterPars;
            foreach (DataRow dr in Dtparticular.Rows)
            {
                _Par = new Clsparticular();
                _Par.Learningparticularid = dr["Learningparticularid"].ToString();
                _Par.Particularid = dr["Particularid"].ToString();
                _Par.Particularname = dr["Particular"].ToString();
                Pars.Add(_Par);
            }
            Obj.Particulars = Pars;



               
            foreach (DataRow dr in Dtestimate.Rows)
            {
                _Est = new Clsestimate();
                _Est.Estimateid = dr["Estimateid"].ToString();
                _Est.Estimatename = dr["Estimate"].ToString();
                Ests.Add(_Est);
            }
            Obj.Estimates = Ests;
            return Obj;
        }
        //[WebMethod]
        //public static List<Clslearningoutput> Getlearningoutput(string json)
        //{
        //    SqlConnector cn = new SqlConnector(Connectionstring, null);
        //    //List<Clslearningoutputset> Objs = new List<Clslearningoutputset>();
        //    //Clslearningoutputset Obj = new Clslearningoutputset();

        //    Clslearningoutput _Len;
        //    Clsparticular _Par;
        //    Clsestimate _Est;
        //    List<Clsestimate> Ests = new List<Clsestimate>();
        //    List<Clsparticular> Pars = new List<Clsparticular>();
        //    List<Clslearningoutput> Lens = new List<Clslearningoutput>();
        //    string sqlcmd = "";
        //    //DataTable Dt = new DataTable();
        //    DataTable Dtparticular = new DataTable();
        //    DataTable Dtestimate = new DataTable();
        //    DataTable Dtlearningoutput = new DataTable();
        //    DataRow[] Drs;


        //    sqlcmd = "Select d.id,[Output] as Output from Sys_Master_Learningoutput m  inner join Sys_Master_Learningoutputsubject d  on m.id = d.learningoutputid left join sys_TQF_TQF3 TQF on d.subjectid = tqf.subjectid where m.isdelete = 0 and d.isdelete = 0 and TQF.id = '" + json + "'";
        //    //sqlcmd = "Select * from Sys_TQF_Learningoutput d inner join Sys_Master_Learningoutput m on d.Learningoutputid = m.id where d.isdelete = 0 and TQFId = '" + json + "'";
        //    Dtlearningoutput = cn.Select(sqlcmd);
        //    sqlcmd = "Select * from Sys_TQF_Learningpartcular d inner join Sys_Master_Particular m on d.Particularid = m.id where d.isdelete = 0 and TQFId = '" + json + "'";
        //    Dtparticular = cn.Select(sqlcmd);
        //    sqlcmd = "Select * from Sys_TQF_LearningEstimate d inner join Sys_Master_Estimate m on d.Estimateid = m.id where d.isdelete = 0 and TQFId = '" + json + "'";
        //    Dtestimate = cn.Select(sqlcmd);


        //    List<Clsestimate> MasterEsts = new List<Clsestimate>();
        //    List<Clsparticular> MasterPars = new List<Clsparticular>();

        //    MasterEsts = Getestimate();
        //    MasterPars = Getparticular();

        //    //sqlcmd = "Select * from Sys_TQF_Leaningoutputset where isdelete = 0 and tqfid = '" + json + "'";
        //    //Dt = cn.Select(sqlcmd);

        //    Lens = new List<Clslearningoutput>();

        //    foreach (DataRow _dr in Dtlearningoutput.Rows)
        //    {
               
        //        Pars = new List<Clsparticular>();
        //        Ests = new List<Clsestimate>();

        //        _Len = new Clslearningoutput();
        //        _Len.Learningoutputid = _dr["id"].ToString();
        //        _Len.Learningoutputname = _dr["Output"].ToString();
        //        _Len.MasterEstimates = MasterEsts;
        //        _Len.MasterParticulars = MasterPars;
        //        Drs = Dtparticular.Select("LearningoutputId ='" + _dr["id"].ToString() + "'");
        //        foreach (DataRow dr in Drs)
        //        {
        //            _Par = new Clsparticular();
        //            _Par.Particularid = dr["Particularid"].ToString();
        //            _Par.Particularname = dr["Particular"].ToString();
        //            Pars.Add(_Par);
        //        }
        //        _Len.Particulars = Pars;



        //        Drs = Dtestimate.Select("LearningoutputId ='" + _dr["id"].ToString() + "'");
        //        foreach (DataRow dr in Drs)
        //        {
        //            _Est = new Clsestimate();
        //            _Est.Estimateid = dr["Estimateid"].ToString();
        //            _Est.Estimatename = dr["Estimate"].ToString();
        //            Ests.Add(_Est);
        //        }
        //        _Len.Estimates = Ests;
        //        Lens.Add(_Len);
        //    }
        //    return Lens;
        // }
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
        public static string Updateestimate(string json)
        {
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string Learningoutputid = "0"; // ไม่ได้ใช้แล้ว
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = "";
            string sqlcmd = "";
            if (cn.Select("Select * from Sys_TQF_Learningestimate where isdelete = 0 and TQFId ='" + TQFId + "'  and estimateid ='" + val + "'").Rows.Count > 0)
            {
                return "รายการที่เลือกซ้ำ";
            }
            //sqlcmd = "Update Sys_TQF_Learningestimate set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "' and LearningoutputId='" + Learningoutputid + "' and estimateid ='" + val + "'";
            //cn.Execute(sqlcmd, null);
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
            sqlcmd += ",'" + val + "'";
            sqlcmd += ",'0'";
            sqlcmd += ",Getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);

            return "";
        }
        [WebMethod]
        public static string Updatetheoryplaninstructor(string json)
        {
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string prevIns = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Theoryplan").Split('_')[2];
            string Theoryplan = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Theoryplan").Split('_')[1];
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = "";
            string sqlcmd = "";


            if (cn.Select("Select * from [Sys_TQF_TheoryplanInstructor] where isdelete = 0 and TQFId ='" + TQFId + "'  and Theoryplanid ='" + Theoryplan + "' and Instructorid ='" + val + "'").Rows.Count > 0)
            {
                return "รายการที่เลือกซ้ำ";
            }
            sqlcmd = "Update Sys_TQF_TheoryplanInstructor set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "'  and Theoryplanid ='" + Theoryplan + "' and Instructorid ='" + prevIns + "'";
            cn.Execute(sqlcmd, null);
            id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_TheoryplanInstructor", "id");
            sqlcmd = " INSERT INTO [Sys_TQF_TheoryplanInstructor] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[TQFId] ";
            sqlcmd += " ,[Theoryplanid] ";
            sqlcmd += " ,[Instructorid] ";
            sqlcmd += " ,[Isdelete]";
            sqlcmd += " ,[Createdate]";
            sqlcmd += " ,[CreateBy] )";
            sqlcmd += " VALUES ( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + TQFId + "'";
            sqlcmd += ",'" + Theoryplan + "'";
            sqlcmd += ",'" + val + "'";
            sqlcmd += ",'0'";
            sqlcmd += ",Getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);

            return "";
        }

        [WebMethod]
        public static string Updateparticular(string json)
        {
            string val = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "val");
            string TQFId = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "HdTQFId");
            string Learningoutputid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Learningparticularid").Split('_')[1];
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = "";
            string sqlcmd = "";


           if (cn.Select("Select * from Sys_TQF_Learningpartcular where isdelete = 0 and TQFId ='" + TQFId + "'  and Particularid ='" + val + "'").Rows.Count > 0)
            {
                return "รายการที่เลือกซ้ำ";
            }




            //sqlcmd = "Update Sys_TQF_Learningpartcular set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where TQFId ='" + TQFId + "'  and Particularid ='" + val + "'";
            //cn.Execute(sqlcmd, null);
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
            sqlcmd += ",'0'";
            sqlcmd += ",'" + val + "'";
            sqlcmd += ",'0'";
            sqlcmd += ",Getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);

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
                if(cn.Select("Select * from [Sys_TQF_Learningpartcular] Where isdelete = 0 and LearningoutputId='" + Learningoutputid + "' and Particularid='" + Particularid + "' and tqfid = '" + TQFId + "'").Rows.Count ==0)
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
                    cn.Execute(sqlcmd,null);
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
        public static string Deleteadvice(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_advice Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }


        
        [WebMethod]
        public static string Deleteoutcome(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_TQF_Outcome Set isdelete = 1,deletedate = getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + json + "'";
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
                    else if (str.Split(':')[0].Split('_')[0].Trim() == "F") //Objective
                    {
                        TQFInstuctorid = str.Split(':')[0].Split('_')[1].Trim();
                        value = str.Split(':')[1].Trim();
                        field = "Fullname";
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
                        sqlcmd = "Update Sys_TQF_Advice set " + field + "=" + value + ",modifydate = getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id = '" + TQFInstuctorid + "'";
                        Arrcmd.Add(sqlcmd);
                    }
                }


            }
            cn.Execute(Arrcmd, null);
            cn.Close();
            return "";
        }

        [WebMethod]
        public static string Updateoutcome(string json, string dat)
        {
            string field = "";
           
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
        public static string Updatedevelopobjective(string json,string dat)
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
            foreach(string str in Arrcomp)
            {
                if (str.Trim() != "")
                {
                    Developobjectiveid = "";
                    value = "";
                    field = "";
                    if (str.Split(':')[0].Split('_')[0].Trim()== "O") //Objective
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
        public static string Newadvice(string json)
        {
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_advice", "id");
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            sqlcmd = " INSERT INTO  [Sys_TQF_advice] ";
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
            cn.Execute(sqlcmd,null);
            return "";
        }

        
        [WebMethod]
        public static List<TQFInstructor> Getadvice(string json)
        {
            TQFInstructor Obj;
            List<TQFInstructor> Objs = new List<TQFInstructor>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from [Sys_TQF_Advice] where TQFId='" + json + "' and isdelete = 0 Order by id ";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new TQFInstructor();
                Obj.Id = dr["Id"].ToString();
                Obj.Fullname = dr["Fullname"].ToString();
                Obj.Adviceplace = dr["Adviceplace"].ToString();
                Obj.AdviceEmail = dr["AdviceEmail"].ToString();
                Obj.Advicedateandtime = dr["Advicedatetime"].ToString();
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

            //sqlcmd = "Select * from sys_tqf_outcome where isdelete = 0 and tqfid = '" + TQFId + "'";
            //Dt = cn.Select(sqlcmd);

            //if (Dt.Rows.Count == 0)
            //{
            //    sqlcmd = "Select * from sys_master_outcome where isdelete = 0 and tqftype='3' order by id";
            //    Dt = cn.Select(sqlcmd);
            //    id = ClsEngine.GenerateRunningId(Connectionstring, "sys_tqf_outcome", "Id");
            //    foreach (DataRow dr in Dt.Rows)
            //    {
            //        sqlcmd = " INSERT INTO [sys_tqf_outcome]";
            //        sqlcmd += " ([Id]";
            //        sqlcmd += " ,[TQFId]";
            //        sqlcmd += " ,[OutcomeId]";
            //        sqlcmd += " ,[IsOK]";
            //        sqlcmd += " ,[IsDelete]";
            //        sqlcmd += " ,[CreateDate]";
            //        sqlcmd += " ,[CreateBy] )";
            //        sqlcmd += " VALUES (";
            //        sqlcmd += "'" + id + "'";
            //        sqlcmd += ",'" + TQFId + "'";
            //        sqlcmd += ",'" + dr["id"].ToString() + "'";
            //        sqlcmd += ",0";
            //        sqlcmd += ",0";
            //        sqlcmd += ",Getdate()";
            //        sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            //        Arrcmd.Add(sqlcmd);
            //        id = (int.Parse(id) + 1).ToString();

            //    }
            //    cn.Execute(Arrcmd, null);
            //}
            Dt = new DataTable();
            sqlcmd = "Select o.id as tqfoutcomeid,isok as isok,Value from sys_tqf_outcome o  where o.isdelete = 0  and o.tqfid = '" + TQFId + "'";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsoutcome();
                Obj.TQFoutcomeId = dr["TQFoutcomeId"].ToString();
                Obj.Value = dr["Value"].ToString();
                Obj.IsOK = dr["IsOK"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
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

            if (Dt.Rows.Count ==0 )
            {
                sqlcmd = "Select obj.id,obj.code,obj.objective from sys_master_objective obj inner join sys_master_tqfobjective tqf on obj.id = tqf.Objectiveid where obj.isdelete = 0 and tqf.isdelete = 0 and tqf.tqftype='3'";
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
                sqlcmd = " UPDATE [Sys_TQF_TQF3] Set ";
                sqlcmd += "  Stategybystudent ='" + ClsEngine.FindValue(Dicts, "TxtStategybystudent") + "'";
                sqlcmd += " ,Stategybyteaching ='" + ClsEngine.FindValue(Dicts, "TxtStategybyteaching") + "'";
                sqlcmd += " ,Improveteaching ='" + ClsEngine.FindValue(Dicts, "TxtImproveteaching") + "'";
                sqlcmd += " ,Reestimate ='" + ClsEngine.FindValue(Dicts, "TxtReestimate") + "'";
                sqlcmd += " ,Planningimprove ='" + ClsEngine.FindValue(Dicts, "TxtPlanningimprove") + "'";
                sqlcmd += " ,Stategyother ='" + ClsEngine.FindValue(Dicts, "TxtStategyother") + "'";
                sqlcmd += " Where id= '" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }

            else if (ClsEngine.FindValue(Dicts, "menu") == "1")
            {
                sqlcmd = " UPDATE [Sys_TQF_TQF3] Set ";
                sqlcmd += "  Credits ='" + ClsEngine.FindValue(Dicts, "Txtcredits") + "'";

                sqlcmd += " ,Subjectgroup ='" + ClsEngine.FindValue(Dicts, "Cbsubjectgroup") + "'";
                sqlcmd += " ,SubjectDesc ='" + ClsEngine.FindValue(Dicts, "Txtsubjectdesc") + "'";
                sqlcmd += " ,Prerequisite ='" + ClsEngine.FindValue(Dicts, "Txtprerequisite") + "'";
                sqlcmd += " ,Corequisite ='" + ClsEngine.FindValue(Dicts, "Txtcorequisite") + "'";
                sqlcmd += " ,LearningPlace ='" + ClsEngine.FindValue(Dicts, "TxtlearningPlace") + "'";
                try
                {
                    sqlcmd += " ,Lastupdatesubject ='" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtlastupdatesubject"),'/') + "'";
                }
                catch(Exception ex)
                {
                    sqlcmd += " ,Lastupdatesubject =null";
                }
                sqlcmd += " ,Generation ='" + ClsEngine.FindValue(Dicts, "Txtgeneration") + "'";
                sqlcmd += " ,Quann ='" + ClsEngine.FindValue(Dicts, "Txtquann") + "'";
                sqlcmd += " Where id= '" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            else if (ClsEngine.FindValue(Dicts, "menu") == "2")
            {
                sqlcmd = " UPDATE [Sys_TQF_TQF3] Set ";
                sqlcmd += "  ObjectiveDesc ='" + ClsEngine.FindValue(Dicts, "Txtobjectivedesc") + "'";
                sqlcmd += " Where id= '" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            else if (ClsEngine.FindValue(Dicts, "menu") == "3")
            {
                
                sqlcmd = " UPDATE [Sys_TQF_TQF3] Set ";
                sqlcmd += "subjectremarkTH ='" + ClsEngine.FindValue(Dicts, "TxtsubjectremarkTH") + "'";
                sqlcmd += ",subjectremarkEN ='" + ClsEngine.FindValue(Dicts, "TxtsubjectremarkEN") + "'";
                sqlcmd += ",totalhour ='" + ClsEngine.FindValue(Dicts, "Txttotalhour") + "'";
                sqlcmd += ",theoryhour ='" + ClsEngine.FindValue(Dicts, "Txttheoryhour") + "'";
                sqlcmd += ",addtionaltech ='" + ClsEngine.FindValue(Dicts, "Txtaddtionaltech") + "'";
                sqlcmd += ",practicalhour ='" + ClsEngine.FindValue(Dicts, "Txtpracticalhour") + "'";
                sqlcmd += ",researchhour ='" + ClsEngine.FindValue(Dicts, "Txtresearchhour") + "'";
                sqlcmd += " Where id= '" + ClsEngine.FindValue(Dicts, "HdTQFId") + "'";
            }
            Cn.Execute(sqlcmd,null);
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
                cn.Execute(sqlcmd,null);
            }
            catch(Exception ex)
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
        public static ClsTQF3 LoadTQFInfo(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from [Sys_TQF_TQF3] where id = '" + json + "'";
            DataTable Dt = new DataTable();
            ClsTQF3 Obj = new ClsTQF3();
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
            Obj.Totalhour = Dt.Rows[0]["Totalhour"].ToString();
            Obj.Theoryhour = Dt.Rows[0]["Theoryhour"].ToString();
            Obj.Addtionaltech = Dt.Rows[0]["Addtionaltech"].ToString();
            Obj.Practicalhour = Dt.Rows[0]["Practicalhour"].ToString();
            Obj.Researchhour = Dt.Rows[0]["Researchhour"].ToString();

            Obj.Stategybystudent = Dt.Rows[0]["Stategybystudent"].ToString();
            Obj.Stategybyteaching = Dt.Rows[0]["Stategybyteaching"].ToString();
            Obj.Improveteaching = Dt.Rows[0]["Improveteaching"].ToString();
            Obj.Reestimate = Dt.Rows[0]["Reestimate"].ToString();
            Obj.Planningimprove = Dt.Rows[0]["Planningimprove"].ToString();
            Obj.Stategyother = Dt.Rows[0]["Stategyother"].ToString();

            Obj.error = "";
            //Instuctor Load ใส่ Grid เอา
            return Obj;
        }
        [WebMethod]
        public static ClsTQF3 DonewTQF(string json)
        {
            //json += 'Cbnewcollege :' + $('#Cbnewcollege').val() + '|'
            //json += 'Cbnewcourse :' + $('#Cbnewcourse').val() + '|'
            //json += 'Cbnewsubject :' + $('#Cbnewsubject').val() + '|'
            //json += 'Cbnewterm :' + $('#Cbnewterm').val() + '|'
            //json += 'Cbnewclass :' + $('#Cbnewclass').val() + '|'
            //json += 'Cbnewyear :' + $('#Cbnewyear').val() + '|'
            ClsTQF3 Obj = new ClsTQF3();
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
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_TQF_TQF", "Id");
            System.Collections.ArrayList Arrcmd = new ArrayList();
            const string TQFType = "3";
            sqlcmd = " INSERT INTO [Sys_TQF_TQF]  ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[TQFType] ";
            sqlcmd += " ,[IsDelete] ";
            sqlcmd += " ,[CreateDate] ";
            sqlcmd += " ,[CreateBy] ) ";
            sqlcmd += " Values ( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + TQFType + "'";
            sqlcmd += ",0 ";
            sqlcmd += ",getdate() ";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            Arrcmd.Add(sqlcmd);
            sqlcmd = " INSERT INTO [Sys_TQF_TQF3] ";
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
            sqlcmd += " ,[Subjectgroup] ";
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
            sqlcmd += ",'" + Dtsubject.Rows[0]["Subjectgroup"].ToString() + "'";
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
            //json += 'Cbnewcollege :' + $('#Cbnewcollege').val() + '|'
            //json += 'Cbnewcourse :' + $('#Cbnewcourse').val() + '|'
            //json += 'Cbnewsubject :' + $('#Cbnewsubject').val() + '|'
            //json += 'Cbnewterm :' + $('#Cbnewterm').val() + '|'
            //json += 'Cbnewclass :' + $('#Cbnewclass').val() + '|'
            //json += 'Cbnewyear :' + $('#Cbnewyear').val() + '|'
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
            for (int i =maxyear;i>=minyear;i--)
            {
                Objdict = new ClsDict();
                Objdict.Name = (i+543).ToString();
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
            foreach(DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["Coursename"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }

        #region "Grid"
       
        [WebMethod]
        public static string ExecuteDeleteGrid(string Ctrl, string PK)
        {
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            List<ClsDict> Dats = new List<ClsDict>();
            Dats = ClsEngine.DeSerialized(PK, ':', '|'); //Data for Delete key:Value|
            if (Ctrl == "Gvteachingplan")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_Master_Teachingplan] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvteachingtopic")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_Master_Teachingtopic] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "GvresponsibleInstructor")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_Instructor] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvrecommenddocument")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_Recommenddocument] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvother")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_TQF_Otherdocumentdocument] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
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



            if (Ctrl == "Gvlearningoutput")
            {
                PK = "id";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                Sqlcmd = "Select id,[Output] as Output from Sys_Master_Learningoutput M where isdelete = 0 and id not in (Select Learningoutputid from Sys_TQF_Learningoutput where isdelete = 0 and Learningsetid ='" + Criteria + "') ";
                Criteria = "";
                return Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
            }
            else if (Ctrl == "Gvparticular")
            {
                PK = "id";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                Sqlcmd = "Select id,[Particular] from Sys_Master_Particular M where isdelete = 0 and id not in (Select Particularid from Sys_TQF_Learningpartcular where isdelete = 0 and Learningsetid ='" + Criteria + "') ";
               
                Criteria = "";
                return Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
            }
            else if (Ctrl == "Gvestimate")
            {
                PK = "id";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                Sqlcmd = "Select id,[Estimate] from Sys_Master_Estimate M where isdelete = 0 and id not in (Select Estimateid from Sys_TQF_LearningEstimate where isdelete = 0 and Learningsetid ='" + Criteria + "') ";
                Criteria = "";
                return Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
            }
            else if (Ctrl == "Gvteachingtopic")
            {
                PK = "id";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                Sqlcmd = "Select t.id,t.Teachingtopicname,p.Teachingplanname from Sys_Master_Teachingtopic t inner join Sys_Master_Teachingplan p on t.Teachingplanid = p.id where t.isdelete = 0 ";
                return Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
            }
            else if (Ctrl == "Gvteachingplan")
            {
                PK = "id";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                Sqlcmd = "Select id,Teachingplanname from Sys_Master_Teachingplan where isdelete = 0 ";
                return Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
            }

            else if (Ctrl == "Gvsearchother")
            {
                PK = "id";
                Sqlcmd = "Select m.id,otherdocument from Sys_Master_Otherdocument m where m.id not in (select Otherid from Sys_TQF_Otherdocumentdocument d where isdelete = 0 and TQFId = '" + Criteria + "') and m.isdelete = 0 ";
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
            else if (Ctrl == "Gvsearchrecommenddocument")
            {
                PK = "id";
                Sqlcmd = "Select m.id,m.Recommenddocument from Sys_Master_Recommenddocument m where m.id not in (select RecommenddocumentId from Sys_TQF_Recommenddocument d where isdelete = 0 and TQFId = '" + Criteria + "') and m.isdelete = 0 ";
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
                Sqlcmd = "Select od.id as id,Otherdocument from Sys_TQF_Otherdocumentdocument od inner join Sys_Master_Otherdocument m on m.id = od.Otherid where m.isdelete =0  and od.isdelete = 0 and tqfid = '" + Criteria + "'";
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
                               ObjGridResponse.ResData[i][j].Val = "<a style='text-decoration:underline;' target='_blank' href='http://" + ObjGridResponse.ResData[i][j].Val.Replace("http://","") + "'>" + ObjGridResponse.ResData[i][j].Val + "</a>";
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
            else if (Ctrl == "Gvrecommenddocument")
            {
                PK = "id";
                Sqlcmd = "Select d.id as id,Recommenddocument from Sys_TQF_Recommenddocument d inner join Sys_Master_Recommenddocument m on m.id = d.RecommenddocumentId where m.isdelete =0  and d.isdelete = 0 and tqfid = '" + Criteria + "'";
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
                Dtinfo = Cn.Select("Select * from Sys_TQF_TQF3 where isdelete = 0 and id='" + Criteria + "'");
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
                }
                else
                {
                    PK = "Userid";
                    Sqlcmd = "Select * from [Sys_Master_PreInstuctor] as m where isdelete = 0 and  Userid  not in (Select userid from Sys_TQF_Instructor where isdelete = 0 and InstuctorType = '" + Criteria.Split('|')[0] + "' and TQFid = '" + Criteria.Split('|')[1] + "')";
                }
                //Sqlcmd = "Select * from [Sys_Master_Instuctor] where isdelete = 0 and InstuctorType='" + Criteria.Split('|')[0] + "' and ";
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
                Sqlcmd = "Select * from Sys_TQF_Instructor where isdelete = 0 and InstuctorType = 'R' and TQFId = '" + Criteria +  "'";
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
                Sqlcmd = "Select Comment, Status,subjectname,Generation, cast(Year as int) + 543 as year, id,Coursegroupname,Ownerorgname,Coursename,convert(nvarchar,modifydate,103) as modifydate,Statusname,'' as Del,'' as Action  from sys_TQF_TQF3 where isdelete = 0 and Createby ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
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
                Sqlcmd = "Select comment,Status,subjectname,Generation, cast(Year as int) + 543 as year, id,Coursegroupname,Ownerorgname,Coursename,convert(nvarchar,modifydate,103) as modifydate,Status,Statusname from sys_TQF_TQF3 where isdelete = 0 and ( (Validateuserid ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' and status = 'W') OR (Approveuserid ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' and status = 'V'))";
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