using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Configuration;
using E_OfficePI.Class;
using Newtonsoft.Json;
using SVframework2016;
namespace E_OfficePI.Page.HR
{
    public partial class Orgchart : System.Web.UI.Page
    {
        public static string Connectionstring = ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string Updateeducate(string json)
        {
            //json = $('#Hdorgid').val();
            //json += $('#Chkiseducate').prop('checked');
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string val = ClsEngine.FindValue(Dicts, "val");
            string id = ClsEngine.FindValue(Dicts, "id");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_Master_Organize set IsEducate = '" + val + "',modifydate=getdate(),modifyby ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id ='" + id + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }

        [WebMethod]
        public static string Deleteorg(string json)
        {
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            string orgid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "orgid");
            SqlConnector cn = new SqlConnector(Connectionstring,"");
            string sqlcmd = "";
            sqlcmd = " Update [Sys_Master_Organizeuser] ";
            sqlcmd += " Set Isdelete = 1,deletedate=getdate(),deleteby ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += " Where Orgid='" + orgid + "'";
            Arrcmd.Add(sqlcmd);

            sqlcmd = " Update [Sys_Master_Organize] ";
            sqlcmd += " Set Isdelete = 1,deletedate=getdate(),deleteby ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += " Where id  ='" + orgid + "'";
            Arrcmd.Add(sqlcmd);


            cn.Execute(Arrcmd,null);
            return "";
        }
        [WebMethod]
        public static string DeluserfromOrg(string json)
        {
            //json = 'userid :' + userid + '|';
            //json += 'orgid :' + orgid + '|';
            string userid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "userid");
            string orgid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "orgid");
            SqlConnector cn = new SqlConnector(Connectionstring,"");
            string sqlcmd = "";
            sqlcmd = " Update [Sys_Master_Organizeuser] ";
            sqlcmd += " Set Isdelete = 1,deletedate=getdate(),deleteby ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += " Where Userid ='" + userid + "' and Orgid='" + orgid + "'";
            cn.Execute(sqlcmd, null);
            return "";

        }
        [WebMethod]
        public static string Editparentorg(string json)
        {
            string orgname = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtparentorgname").Replace("'", "").Replace(",", "");
            string orgid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "orgid");
            SqlConnector cn = new SqlConnector(Connectionstring,null);
            string sqlcmd = "";
            sqlcmd = "  Update [Sys_Master_Organize] ";
            sqlcmd += "  Set [OrganizeNameTH] =' " + orgname + "'";
            sqlcmd += " ,[modifydate] = getdate()";
            sqlcmd += " ,[modifyBy] = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += "  Where id = '" + orgid + "'";
            cn.Execute(sqlcmd,null);
            return "";
        }
        [WebMethod]
        public static string Getorgname(string json)
        {
            string orgid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "orgid");
            SqlConnector cn = new SqlConnector(Connectionstring,null);

            string sqlcmd = "Select [OrganizeNameTH] from Sys_Master_Organize where isdelete = 0 and id  ='" + orgid + "'";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            return Dt.Rows[0][0].ToString();
        }
        [WebMethod]
        public static string Addparentorg(string json)
        {
            //json = 'orgid :' + orgid + '|';
            //json += 'Txtparentorgname :' + $('#Txtparentorgname').val() + '|';
            string orgname = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtparentorgname").Replace("'", "").Replace(",", "");
            string orgid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "orgid");

            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_Organize", "id");
            string sqlcmd = "";
            sqlcmd = " INSERT INTO [Sys_Master_Organize] ";
            sqlcmd += " ([id] ";
            sqlcmd += " ,[OrganizeNameTH] ";
            sqlcmd += " ,[ParentId] ";
            sqlcmd += " ,[Isdelete]";
            sqlcmd += " ,[Createdate]";
            sqlcmd += " ,[CreateBy] ) ";
            sqlcmd += " Values( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + orgname + "'";
            sqlcmd += ",'" + orgid + "'";
            sqlcmd += ",'0'";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += "  ) ";
            cn.Execute(sqlcmd,null);
            return "";
        }

        [WebMethod]
        public static string doAdduser2Org(string json)
        {
            //json = 'userid :' + userid + '|';
            //json += 'orgid :' + orgid + '|';

            string userid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "userid");
            string orgid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "orgid");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_Organizeuser", "id");
            string sqlcmd = "";
            sqlcmd = " INSERT INTO [Sys_Master_Organizeuser] ";
            sqlcmd += " ([Id]";
            sqlcmd += " ,[Orgid]";
            sqlcmd += " ,[Userid]";
            sqlcmd += " ,[Isdelete]";
            sqlcmd += " ,[Createdate]";
            sqlcmd += " ,[CreateBy] ) ";
            sqlcmd += " Values( ";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + orgid + "'";
            sqlcmd += ",'" + userid + "'";
            sqlcmd += ",'0'";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += "  ) ";
            cn.Execute(sqlcmd,null);
            return "";
        }
        [WebMethod]
        public static List<Clsuser> Getuser(string json)
        {
            string Searchkwd = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtusersearch");
            List<Clsuser> Users = new List<Clsuser>();
            SqlConnector cn = new SqlConnector(Connectionstring,null);
            Clsuser Objuser;
           
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_Core_User u inner join Sys_Core_Userprofile up on u.Id = up.Userid where u.isdelete =0  and up.isdelete = 0 and u.id not in (select userid from Sys_Master_Organizeuser where isdelete = 0) order by id ";
            Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Objuser = new Clsuser();
                Objuser = JsonConvert.DeserializeObject<Clsuser>(dr["Json"].ToString());
                Objuser.userid = dr["Userid"].ToString();
                Objuser.username = dr["Username"].ToString();
                Users.Add(Objuser);

            }
            if (Searchkwd != "")
            {
                return Users.FindAll(x => x.firstnameth.Contains(Searchkwd)
                    || x.lastnameth.Contains(Searchkwd)
                    || x.email.Contains(Searchkwd)
                    || x.tel.Contains(Searchkwd)
                );

            }
            else
            {
                return Users;
            }


        }
        [WebMethod]
        public static ClsOrg Orginfo(string id)
        {
            ClsOrg Obj = new ClsOrg();
            List<Clsuser> Users = new List<Clsuser>();
            Clsuser Objuser;
            DataTable Dt = new DataTable();
            SqlConnector cn = new SqlConnector(Connectionstring,"");
            string sqlcmd = "Select * from Sys_Master_Organize o left join Sys_Master_Organizeuser ou on o.id = ou.orgid and ou.isdelete = 0 left join Sys_Core_Userprofile u on ou.userid = u.UserId and u.isdelete = 0 where o.isdelete= 0  and o.id ='" + id + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count > 0)
            {
                Obj.Orgid = Dt.Rows[0]["id"].ToString();
                Obj.Orgname = Dt.Rows[0]["Organizenameth"].ToString();
                Obj.Iseducate = Dt.Rows[0]["Iseducate"].ToString();
                foreach (DataRow dr in Dt.Rows)
                {
                    if (dr["Userid"].ToString() != "")
                    {
                        Objuser = new Clsuser();
                       
                        Objuser = JsonConvert.DeserializeObject<Clsuser>(dr["Json"].ToString());
                        Objuser.userid = dr["Userid"].ToString();
                        Users.Add(Objuser);
                    }
                }

            }
            else
            {
                Obj.Orgid = "";
                Obj.Orgname = "";
            }
            Obj.Users = Users;
            return Obj;

        }


    }
}