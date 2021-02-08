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
    public partial class ApproveOfficialvisit : System.Web.UI.Page
    {
        public static string Connectionstring = ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string ChangeValidate(string json)
        {
            //json = 'userid :' + userid + '|';
            //json += 'validatoruserid :' + $('#' + validatoruserid).val() + '|';
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');

            if (cn.Select("Select * from Sys_Master_ApproveOfficialvisit where isdelete = 0 and userid = '" + ClsEngine.FindValue(Dicts, "userid") + "'").Rows.Count == 0)
            {
                string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_ApproveOfficialvisit", "id");
                //insert

                sqlcmd = " INSERT INTO [Sys_Master_ApproveOfficialvisit] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[userid] ";
                sqlcmd += " ,[Validatoruserid] ";
                sqlcmd += " ,[IsDelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy])";
                sqlcmd += " VALUES ( ";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "userid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "validatoruserid") + "'";
                sqlcmd += ",0";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            }
            else
            {
                sqlcmd = "Update Sys_Master_ApproveOfficialvisit set ";
                sqlcmd += " [Validatoruserid] ='" + ClsEngine.FindValue(Dicts, "validatoruserid") + "'";
                sqlcmd += ",Modifydate=getdate(),modifyby ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                sqlcmd += " Where userid ='" + ClsEngine.FindValue(Dicts, "userid") + "'";
                //update
            }
            cn.Execute(sqlcmd, null);
            return "";
        }


        [WebMethod]
        public static string ChangeApprove(string json)
        {
            //json = 'userid :' + userid + '|';
            //json += 'Approveruserid :' + $('#' + Approveruserid).val() + '|';
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');

            if (cn.Select("Select * from Sys_Master_ApproveOfficialvisit where isdelete = 0 and userid = '" + ClsEngine.FindValue(Dicts, "userid") + "'").Rows.Count == 0)
            {
                string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_ApproveOfficialvisit", "id");
                //insert

                sqlcmd = " INSERT INTO [Sys_Master_ApproveOfficialvisit] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[userid] ";
                sqlcmd += " ,[Approveruserid] ";
                sqlcmd += " ,[IsDelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy])";
                sqlcmd += " VALUES ( ";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "userid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Approveruserid") + "'";
                sqlcmd += ",0";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            }
            else
            {
                sqlcmd = "Update Sys_Master_ApproveOfficialvisit set ";
                sqlcmd += " [Approveruserid] ='" + ClsEngine.FindValue(Dicts, "Approveruserid") + "'";
                sqlcmd += ",Modifydate=getdate(),modifyby ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                sqlcmd += " Where userid ='" + ClsEngine.FindValue(Dicts, "userid") + "'";
                //update
            }
            cn.Execute(sqlcmd, null);
            return "";
        }

        [WebMethod]
        public static List<ClsDict> GetAPOrg(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            ClsDict Objdict = new ClsDict();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_Master_Organize where isdelete= 0 and id = '" + ((Clsuser)HttpContext.Current.Session["My"]).iseducate + "'  order by id";
            Dt = Cn.Select(sqlcmd);
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
        public static List<ClsApproveOfficialvisit> GetApproverOfficialvisit(string json)
        {
            //json += 'CbAPOrg:' + $('#CbAPOrg').val() + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            List<ClsApproveOfficialvisit> Objs = new List<ClsApproveOfficialvisit>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            ClsApproveOfficialvisit Obj;
            string sqlcmd = "";
            DataTable Dt = new DataTable();
            List<Clsapproverusers> Validators = new List<Clsapproverusers>();
            List<Clsapproverusers> Approvers = new List<Clsapproverusers>();
            DataTable Dtuser = new DataTable();
            Clsapproverusers _V;
            Clsapproverusers _A;

            sqlcmd = "  Select e.userid,e.empno,E.FirstnameTH,E.LastnameTH ,EV.userid as Validatoruserid,isnull(EV.FirstnameTH,'') + ' ' +  isnull(EV.LastnameTH,'') as Validatorfullname ,EP.userid as Approveruserid,isnull(EP.FirstnameTH,'') + ' ' +  isnull(EP.LastnameTH,'') as Approverfullname ";
            sqlcmd += " from ";
            sqlcmd += " Sys_HR_Empdetail E";
            sqlcmd += " Inner";
            sqlcmd += " join Sys_Master_Organizeuser ou on e.userid = ou.Userid and ou.isdelete = 0";
            sqlcmd += " inner join Sys_Master_Organize o on ou.Orgid = o.id  and ou.isdelete = 0";
            sqlcmd += " left join[Sys_Master_ApproveOfficialvisit] AP on e.userid = AP.Userid and AP.isdelete = 0";
            sqlcmd += " left join[Sys_HR_Empdetail] EV on EV.userid = AP.Validatoruserid";
            sqlcmd += " left join[Sys_HR_Empdetail] EP on EP.userid = AP.Approveruserid ";
            sqlcmd += " Where Ou.Orgid = '" + ClsEngine.FindValue(Dicts, "CbAPOrg") + "'";
            Dt = cn.Select(sqlcmd);
            sqlcmd = "Select u.id,isnull(FirstnameTH,'') + ' ' + isnull(LastnameTH,'') as fullname from sys_core_user u inner join Sys_HR_Empdetail e on u.id = e.userid where u.isdelete =0  and e.isdelete = 0 ";
            Dtuser = cn.Select(sqlcmd);

            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsApproveOfficialvisit();
                Obj.Userid = dr["userid"].ToString();
                Obj.Empno = dr["empno"].ToString();
                Obj.Firstname = dr["Firstnameth"].ToString();
                Obj.Lastname = dr["Lastnameth"].ToString();
                Obj.Validatoruserid = dr["Validatoruserid"].ToString();
                Obj.Validatorfullname = dr["Validatorfullname"].ToString();
                Obj.Approveruserid = dr["Approveruserid"].ToString();
                Obj.Approverfullname = dr["Approverfullname"].ToString();
                Approvers = new List<Clsapproverusers>();
                Validators = new List<Clsapproverusers>();
                foreach (DataRow _dr in Dt.Rows)
                {
                    _V = new Clsapproverusers();
                    _V.Userid = _dr["Userid"].ToString();
                    _V.Firstname = _dr["FirstnameTH"].ToString();
                    _V.Lastname = _dr["LastnameTH"].ToString();
                    if (_V.Userid == Obj.Validatoruserid)
                    {
                        _V.Selected = "X";
                    }
                    Validators.Add(_V);

                    _A = new Clsapproverusers();
                    _A.Userid = _dr["Userid"].ToString();
                    _A.Firstname = _dr["FirstnameTH"].ToString();
                    _A.Lastname = _dr["LastnameTH"].ToString();
                    if (_A.Userid == Obj.Approveruserid)
                    {
                        _A.Selected = "X";
                    }
                    Approvers.Add(_A);
                }
                Obj.Validatorusers = Validators;
                Obj.Approverusers = Approvers;
                Objs.Add(Obj);
            }
            HttpContext.Current.Session["datSearch"] = Dicts;
            return Objs;
        }

    }
}