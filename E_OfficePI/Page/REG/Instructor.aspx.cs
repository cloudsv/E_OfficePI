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
namespace E_OfficePI.Page.REG
{
    public partial class Instructor : System.Web.UI.Page
    {
        public static string Connectionstring = ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["ObjGrid"] == null)
            {
                ClsGrid Objgrid = new ClsGrid();
                HttpContext.Current.Session["ObjGrid"] = Objgrid;
            }
        }
        [WebMethod]
        public static string Savegrade(string json)
        {
            //json += 'Txtsendgradepoint_: ' + $('#Txtsendgradepoint_' + id).val() + '|';
            //json += 'Cbsendgradegrade_: ' + $('#Cbsendgradegrade_' + id).val() + '|';
            //json += 'id: ' + id + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string Point = ClsEngine.FindValue(Dicts, "Txtsendgradepoint_");
            string Grade = ClsEngine.FindValue(Dicts, "Cbsendgradegrade_");
            string id = ClsEngine.FindValue(Dicts, "id");
            sqlcmd = " Update Sys_REG_Subject set point='" + Point + "'";
            sqlcmd += ",Grade='" + Grade + "'";
            sqlcmd += ",Modifydate=getdate(),Modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += " Where id = '" + id + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string CalGPAX(string json)
        {
            //json += 'Txtsendgradepoint_: ' + $('#Txtsendgradepoint_' + id).val() + '|';
            //json += 'Cbsendgradegrade_: ' + $('#Cbsendgradegrade_' + id).val() + '|';
            //json += 'id: ' + id + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string Point = ClsEngine.FindValue(Dicts, "Txtsendgradepoint_");
            string Grade = ClsEngine.FindValue(Dicts, "Cbsendgradegrade_");
            string id = ClsEngine.FindValue(Dicts, "id");
            sqlcmd = " Update Sys_REG_Subject set IscalGPAX ='1'";
            sqlcmd += ",Modifydate=getdate(),Modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += " Where id = '" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";

        }
        [WebMethod]
        public static List<Clssendgrade> Searchsendgrade(string json)
        {
            //json += 'Cbsendgradeyear:' + $('#Cbsendgradeyear').val() + '|';
            //json += 'Cbsendgradesubject:' + $('#Cbsendgradesubject').val() + '|';
            //json += 'Cbsendgradeclass:' + $('#Cbsendgradeclass').val() + '|';
            //json += 'Cbsendgradeterm:' + $('#Cbsendgradeterm').val() + '|';
            //json += 'Cbsendgradecourse:' + $('#Cbsendgradecourse').val() + '|';
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            List<ClsDict> Dicts = new List<ClsDict>();
            Clssendgrade Obj;
            List<Clssendgrade> Sendgrades = new List<Clssendgrade>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');

            string sqlcmd = "Select s.id as id, StudentId,Studentno,Firstname,Lastname,isnull(Point,'0') as point,isnull(grade,'') as grade,isnull(iscalgpax,'') as iscalgpax from Sys_REG_Subject s ";
            sqlcmd += " left join Sys_Master_Subject sj on s.subjectid = sj.Id and sj.IsDelete = 0 ";
            sqlcmd += " right join Sys_Registration_StudentRegister sr on sr.id =  s.Regsubjectid  and sr.isdelete = 0 and s.isdelete = 0";
            sqlcmd += " where sr.Class = '" + ClsEngine.FindValue(Dicts, "Cbsendgradeclass") + "' and sr.Year = '" + ClsEngine.FindValue(Dicts, "Cbsendgradeyear") + "' and sr.Term = '" + ClsEngine.FindValue(Dicts, "Cbsendgradeterm") + "' and sr.Courseid = '" + ClsEngine.FindValue(Dicts, "Cbsendgradecourse") + "' and s.subjectid = '" + ClsEngine.FindValue(Dicts, "Cbsendgradesubject") + "' ";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            foreach(DataRow dr in Dt.Rows)
            {
                Obj = new Clssendgrade();
                Obj.id = dr["id"].ToString();
                Obj.Studentid = dr["Studentid"].ToString();
                Obj.Studentno = dr["Studentno"].ToString();
                Obj.Firstname = dr["Firstname"].ToString();
                Obj.Lastname = dr["Lastname"].ToString();
                Obj.Point = dr["Point"].ToString();
                Obj.Grade = dr["Grade"].ToString();
                Obj.IscalGPAX = dr["IscalGPAX"].ToString();
                Sendgrades.Add(Obj);
            }
            return Sendgrades;
        }
        [WebMethod]
        public static List<ClsDict> Getterm(string json)
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
        public static List<ClsDict> Getclass(string json)
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
        public static List<ClsDict> Getsubject(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,subjectname from sys_master_subject where isdelete = 0 and courseid = '" +  json  + "' order by subjectname ";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["subjectname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getcourse(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,Coursename from Sys_Master_course where isdelete = 0  order by Coursename";
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
        [WebMethod]
        public static List<ClsDict> Getyear(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            ClsDict Objdict = new ClsDict();
            int minyear = System.DateTime.Now.AddYears(-10).Year;
            int maxyear = System.DateTime.Now.AddYears(+10).Year;
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
    }

}