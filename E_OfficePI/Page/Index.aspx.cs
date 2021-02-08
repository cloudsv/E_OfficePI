using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using E_OfficePI.Class;
using SVframework2016;
using System.Data;
namespace E_OfficePI.Page
{
    public partial class Index : System.Web.UI.Page
    {
        private static string connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;
        [WebMethod]
        public static ClsCallBackUpload CallBackUpload(string Ctrl, string RunningNo)
        {
            ClsCallBackUpload ObjCallBack = new ClsCallBackUpload();
            DataTable Dt = new DataTable();
            SqlConnector _Cn = new SqlConnector(connectionstring, null);
            string sqlcmd = "Select * from Sys_Trans_Attachment Where Id ='" + RunningNo + "'";
            try
            {
                ObjCallBack.src = new System.IO.FileInfo(_Cn.Select(sqlcmd).Rows[0]["Path"].ToString()).Name;
                ObjCallBack.AttachmentId = RunningNo;
                return ObjCallBack;
            }
            catch
            {
                return null;
            }
            finally
            {
                _Cn.Close();
            }
        }
        [WebMethod]
        public static string Changepassword(string json)
        {
            DataTable Dt = new DataTable();
            string Sqlcmd = "";
            string PrivateKey = "";
            string OldPassword = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtpassword");
            string NewPassword = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtnewpassword");
            string IPAddress = ClsEngine.GetIPAddress();
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            Sqlcmd = "select ConfigurationId,ConfigurationName,ConfigurationValue,isnull(ConfigurationDesc,'') as ConfigurationDesc from Sys_Conf_Configuration where isdelete = 0 and  ConfigurationGroup = 'PasswordPolicy' order by cast(ConfigurationId as int)";
            SVframework2016.SqlConnector Cn = new SVframework2016.SqlConnector(connectionstring, null);
            Sqlcmd = " Select ConfigurationValue from Sys_Conf_Configuration where isdelete = 0 and ConfigurationName = 'PrivateKey'";
            PrivateKey = Cn.Select(Sqlcmd).Rows[0][0].ToString();

            try
            {
                if (Cn.Select(" select * from sys_core_user where username  = '" + ((Clsuser)HttpContext.Current.Session["My"]).username + "' and password = '" + ClsEngine.Encrypt(OldPassword, PrivateKey) + "'").Rows.Count == 0)
                {
                    return "รหัสผ่านเก่าไม่ถูกต้อง โปรดตรวจสอบอีกครั้ง";
                }
                Sqlcmd = "Update Sys_Core_User set [Password] = '" + ClsEngine.Encrypt(NewPassword.Trim(), PrivateKey) + "',ModifyDate='" + DateTime.Now + "',ModifyBy='" + ((Clsuser)HttpContext.Current.Session["My"]).username + "' Where Username ='" + ((Clsuser)HttpContext.Current.Session["My"]).username + "'";
                Cn.Execute(Sqlcmd, null);
                
               
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
        public static string Savemyprofile(string json)
        {
            //json += 'Txtmyprofilefirstname :' + $('#Txtmyprofilefirstname').val() + '|';
            //json += 'Txtmyprofilelastname:' + $('#Txtmyprofilelastname').val() + '|';
            //json += 'Txtmyprofileemail:' + $('#Txtmyprofileemail').val() + '|';
            //json += 'Txtmyprofilemymobile:' + $('#Txtmyprofilemymobile').val() + '|';
      
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            List<ClsDict> Dicts = new List<ClsDict>();
            SqlConnector cn = new SqlConnector(connectionstring, null);
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string Sqlcmd =  "";
            try
            {
                Sqlcmd += " UPDATE [Sys_HR_Empdetail] ";
                Sqlcmd += " Set ";
                Sqlcmd += "  [Mymobile] = '" + ClsEngine.FindValue(Dicts, "Txtmyprofilemymobile") + "'";
                Sqlcmd += " ,[Imgempprofile] = '" + ClsEngine.FindValue(Dicts, "Imgmyprofilesrc") + "'";
                Sqlcmd += " ,[Attachmentid] = '" + ClsEngine.FindValue(Dicts, "Imgmyprofiledat") + "'";
                Sqlcmd += " ,[FirstnameTH] = '" + ClsEngine.FindValue(Dicts, "Txtmyprofilefirstname") + "'";
                Sqlcmd += " ,[LastnameTH] = '" + ClsEngine.FindValue(Dicts, "Txtmyprofilelastname") + "'";
                Sqlcmd += " ,[email] = '" + ClsEngine.FindValue(Dicts, "Txtmyprofileemail") + "'";
                Sqlcmd += " ,[ModifyDate] = Getdate() ";
                Sqlcmd += " ,[ModifyBy] = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                Sqlcmd += " Where userid='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                Arrcmd.Add(Sqlcmd);
                string _json = "{";
                DataTable Dtmetadat = new DataTable();
                Dtmetadat = cn.Select("select * from [Sys_Core_Metadata] where Entityname = 'Sys_Core_Userprofile' and isdelete = 0");
                foreach (DataRow dr in Dtmetadat.Rows)
                {
                    _json += "''" + dr["Fieldname"].ToString() + "'' : ''" + ClsEngine.FindValue(Dicts, dr["Fieldname"].ToString()) + "'',";
                }
                _json += "}";
                Sqlcmd = " Update [Sys_Core_Userprofile]  Set";
                Sqlcmd += "  [json] = '" + _json + "'";
                Sqlcmd += " ,[modifydate] = getdate()";
                Sqlcmd += " ,[modifyBy] ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                Sqlcmd += " Where userid ='" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                Arrcmd.Add(Sqlcmd);
                cn.Execute(Arrcmd, null);
                HttpContext.Current.Session["My"] = ClsEngine.Loadprofile(ref cn, ((Clsuser)HttpContext.Current.Session["My"]).username);
                return "";
            }
            catch(Exception ex)
            {
                return ex.Message;
            }
            finally
            {
                cn.Close();
            }
        }

        [WebMethod]
        public static Clsuser Myprofile()
        {
            return (Clsuser)HttpContext.Current.Session["My"];
        }
        [WebMethod]
        public static string Logout(string json)
        {
            HttpContext.Current.Session.Clear();
            return "";
        }
        [WebMethod]
        public static Clsuser Loadprofile(string json)
        {
            if (HttpContext.Current.Session["My"] == null)
            {
                Clsuser Objuser = new Clsuser();
                Objuser.Err = "Session is expired,Please re-login again";
                return Objuser;
            }
            ((Clsuser)HttpContext.Current.Session["My"]).Err = "";
            return (Clsuser)HttpContext.Current.Session["My"];
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}