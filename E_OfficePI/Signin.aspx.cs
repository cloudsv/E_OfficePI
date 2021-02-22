using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SVframework2016;
using System.Web.Services;
using E_OfficePI.Class;
using System.Data;
using Newtonsoft.Json;
namespace E_OfficePI
{
    public partial class Signin : System.Web.UI.Page
    {
        private static string connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string doForgotpassword(string json)
        {
            DataTable Dt = new DataTable();
            string Sqlcmd = "";
            string PrivateKey = "";
            string Username = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtusername");
            string NewPassword = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtnewpassword");
            string IPAddress = ClsEngine.GetIPAddress();
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            Sqlcmd = "select ConfigurationId,ConfigurationName,ConfigurationValue,isnull(ConfigurationDesc,'') as ConfigurationDesc from Sys_Conf_Configuration where isdelete = 0 and  ConfigurationGroup = 'PasswordPolicy' order by cast(ConfigurationId as int)";
            SVframework2016.SqlConnector Cn = new SVframework2016.SqlConnector(connectionstring, null);
            Sqlcmd = " Select ConfigurationValue from Sys_Conf_Configuration where isdelete = 0 and ConfigurationName = 'PrivateKey'";
            PrivateKey = Cn.Select(Sqlcmd).Rows[0][0].ToString();
           
            try
            {
                Sqlcmd = "Update Sys_Core_User set [Password] = '" + ClsEngine.Encrypt(NewPassword.Trim(), PrivateKey) + "',ModifyDate='" + DateTime.Now + "',ModifyBy='" + Username + "' Where Username ='" + Username + "'";
                Cn.Execute(Sqlcmd, null);
                if (HttpContext.Current.Session["Key"] != null)
                {
                    HttpContext.Current.Session.Remove("Key");
                }
                HttpContext.Current.Session["My"] = ClsEngine.Loadprofile(ref Cn, Username);
                return "";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            finally
            {
                Cn.Close();
                Cn.Dispose();
            }
        }
        [WebMethod]
        public static string Doforgotpasswordsendpass(string json)
        {
            const string TemplatedForgotpassId = "1";
            string Email = "";
            string LinkToken = "";
            string Id = "";
            string IPAddress = "";
            Clsuser Objuser = new Clsuser();
            string Userid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Hdforgotpassworduserid");
            System.Net.Mail.MailAddressCollection CC = new System.Net.Mail.MailAddressCollection();
            DataTable Dt = new DataTable();
            SVFrameWork.Datetime SvDatetime = new SVFrameWork.Datetime();

            List<ClsDictExtend> Dicts = new List<ClsDictExtend>();
            DataTable DtConfiguration = new DataTable();
            ClsMail ObjMail = new ClsMail(connectionstring);
            ClsDictExtend Objdict = new ClsDictExtend();
            string Sqlcmd = "select * from Sys_core_userprofile where userid = '" + Userid + "' and isdelete = 0 ";
            SqlConnector Cn = new SqlConnector(connectionstring, null);
            string Token = ClsEngine.Base64Encode(Userid + SvDatetime.Getcurrentdateyyyymmdd() + SvDatetime.GetCurrentHHMMSS());
            try
            {
                Dt = Cn.Select(Sqlcmd);
                if (Dt.Rows.Count > 0)
                {
                    Objuser = JsonConvert.DeserializeObject<Clsuser>(Dt.Rows[0]["Json"].ToString());
                    Id = ClsEngine.GenerateRunningId(Cn.Connectionstring, "Sys_Audit_ResetPassword", "Id");
                    Email = Objuser.email;
                    Sqlcmd = "select * from sys_conf_configuration where ConfigurationName = 'LinkToken' and IsDelete = 0";
                    DtConfiguration = Cn.Select(Sqlcmd);
                    LinkToken = DtConfiguration.Rows[0]["ConfigurationValue"].ToString();
                    LinkToken += "?Key=" + Token;
                    if (DtConfiguration.Rows.Count > 0)
                    {
                        Objdict = new ClsDictExtend();
                        Objdict.Name = "FirstName";
                        Objdict.Val = Objuser.firstnameth;
                        Dicts.Add(Objdict);
                        Objdict = new ClsDictExtend();
                        Objdict.Name = "Lastname";
                        Objdict.Val = Objuser.lastnameth;
                        Dicts.Add(Objdict);
                        Objdict = new ClsDictExtend();
                        Objdict.Name = "LinkToken";
                        Objdict.Val = LinkToken;
                        Dicts.Add(Objdict);
                        IPAddress = ClsEngine.GetIPAddress();
                        Sqlcmd = " INSERT INTO [Sys_Audit_ResetPassword] ";
                        Sqlcmd += " ([Id] ";
                        Sqlcmd += " ,[Username] ";
                        Sqlcmd += " ,[Token] ";
                        Sqlcmd += " ,[Email] ";
                        Sqlcmd += " ,[RequestDate] ";
                        Sqlcmd += " ,[RequestIP] ";
                        Sqlcmd += " ,[IsResponse] ";
                        Sqlcmd += " ,[IsDelete] ";
                        Sqlcmd += " ,[CreateDate] ";
                        Sqlcmd += " ,[CreateBy] ) ";
                        Sqlcmd += " VALUES ('" + Id + "','" + Userid + "','" + Token + "','" + Email + "','" + System.DateTime.Now + "','" + IPAddress + "',0,0,'" + System.DateTime.Now + "','" + Userid + "')";
                        Cn.Execute(Sqlcmd, null);
                        return ObjMail.SendMail(Email, TemplatedForgotpassId, "", "Forgotpassword", Userid, Dicts, CC);

                    }
                    else
                    {
                        return "Email กับ Username ไม่ตรงกันโปรดเปลี่ยนรหัสผ่านกับผู้ดูแลระบบ";
                    }

                }
                else
                {
                    return "";
                }
            }
            catch
            {
                return "";
            }
            finally
            {
                Cn.Close();
                Cn.Dispose();
            }
        }
        [WebMethod]
        public static Clsuser Validateforgotpassword(string json)
        {
            //json += 'Txtforgotpasswordemail :' + $('#Txtforgotpasswordemail').val() + '|'
            SqlConnector cn = new SqlConnector(connectionstring, null);
            Clsuser Objuser = new Clsuser();
            Clsuser _user = new Clsuser();
            string Username = "";
            string id = "";
            List<Clsuser> Users = new List<Clsuser>();
            string email = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtforgotpasswordemail");
            string sqlcmd = " Select * from Sys_Core_Userprofile where isdelete = 0 and  json like '%" + email + "%'";
            DataTable Dt = new DataTable();
            try
            {
                Dt = cn.Select(sqlcmd);
                if (Dt.Rows.Count == 0)
                {
                    Objuser.Err = "E-mail ไม่ถูกต้อง โปรดตรวจสอบ";
                    return Objuser;
                }
                else
                {
                    Username = cn.Select("Select Username from sys_core_user where id='" + Dt.Rows[0]["userid"].ToString() + "'").Rows[0]["Username"].ToString();
                }
                //foreach(DataRow dr in Dt.Rows)
                //{
                //    _user = new Clsuser();
                //    _user = JsonConvert.DeserializeObject<Clsuser>(dr["Json"].ToString());
                //    Users.Add(_user);

                //}
                try
                {
                    //foreach(Clsuser usr in Users)
                    //{
                    //    if (usr.email == email)
                    //    {
                    //        Username = usr.username;
                    //    }
                    //}
                    Objuser = ClsEngine.Loadprofile(ref cn, Username);
                    return Objuser;
                }
                catch
                {
                    Objuser.Err = "E-mail ไม่ถูกต้อง โปรดตรวจสอบ";
                    return Objuser;
                }
            }
            catch (Exception ex)
            {
                Objuser.Err = ex.Message;
                return Objuser;
            }
            finally
            {
                cn.Close();
            }
        }
        [WebMethod]
        public static string doSignin(string json)
        {
            SqlConnector cn = new SqlConnector(connectionstring, null);
            string username = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtusername");
            string password = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtpassword");
            string sqlcmd = "";

            sqlcmd = " Select ConfigurationValue from Sys_Conf_Configuration where isdelete = 0 and ConfigurationName = 'PrivateKey'";
            string PrivateKey = cn.Select(sqlcmd).Rows[0][0].ToString();
            sqlcmd = " select * from sys_core_user where username  = '" + username + "' and password = '" + ClsEngine.Encrypt(password, PrivateKey) + "'";
            try
            {
                if (cn.Select(sqlcmd).Rows.Count == 0)
                {
                    return "Username หรือ Password ไม่ถูกต้อง";
                }
                else if (ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtpassword") == "p@ssw0rd")
                {
                    return "";
                }
                HttpContext.Current.Session["My"] = ClsEngine.Loadprofile(ref cn, username);

                System.Collections.ArrayList Arrres = ClsEngine.Getsuborg(ref cn, ((Clsuser)HttpContext.Current.Session["My"]).iseducate);
                return "";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            finally
            {
                cn.Close();
            }
        }




    }
}