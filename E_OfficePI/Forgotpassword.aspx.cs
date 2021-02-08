using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using E_OfficePI.Class;
using System.Data;
namespace E_OfficePI
{
    public partial class Forgotpassword : System.Web.UI.Page
    {

        private static string connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["Key"] != null)
            {
                HttpContext.Current.Session["Key"] = Request["Key"];
            }
        }
        [WebMethod]
        public static string doForgotpassword(string json)
        {
            DataTable Dt = new DataTable();
            string Sqlcmd = "";
            string PrivateKey = "";
            string UserName = "";
            string NewPassword = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtnewpassword");
            string IPAddress = ClsEngine.GetIPAddress();
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            Sqlcmd = "select ConfigurationId,ConfigurationName,ConfigurationValue,isnull(ConfigurationDesc,'') as ConfigurationDesc from Sys_Conf_Configuration where isdelete = 0 and  ConfigurationGroup = 'PasswordPolicy' order by cast(ConfigurationId as int)";
            SVframework2016.SqlConnector Cn = new SVframework2016.SqlConnector(connectionstring, null);
            Sqlcmd = " Select ConfigurationValue from Sys_Conf_Configuration where isdelete = 0 and ConfigurationName = 'PrivateKey'";
            PrivateKey = Cn.Select(Sqlcmd).Rows[0][0].ToString();
            Sqlcmd = " Select u.id, u.username from Sys_Audit_ResetPassword ar inner join sys_core_user u on u.id = ar.Username Where Token ='" + HttpContext.Current.Session["Key"] + "'";
            Dt = Cn.Select(Sqlcmd);
            try
            {
                Sqlcmd = "UPDATE [Sys_Audit_ResetPassword] SET IsResponse = 1 ,ResponseDate='" + System.DateTime.Now + "',ResponseIP ='" + IPAddress + "' Where Token ='" + HttpContext.Current.Session["Key"] + "'";
                Arrcmd.Add(Sqlcmd);
                Sqlcmd = "Update Sys_Core_User set [Password] = '" + ClsEngine.Encrypt(NewPassword.Trim(), PrivateKey) + "',ModifyDate='" + DateTime.Now + "',ModifyBy='" + Dt.Rows[0]["Username"].ToString() + "' Where Id ='" + Dt.Rows[0]["id"].ToString() + "'";
                Arrcmd.Add(Sqlcmd);
                Cn.Execute(Arrcmd, null);
                if (HttpContext.Current.Session["Key"] != null)
                {
                    HttpContext.Current.Session.Remove("Key");
                }
                HttpContext.Current.Session["My"] = ClsEngine.Loadprofile(ref Cn, Dt.Rows[0]["Username"].ToString());
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
        public static string IsTokenalive()
        {
            if (HttpContext.Current.Session["Key"] != null)
            {
                return "X";
            }
            else
            {
                return "";
            }
        }
        [WebMethod]
        public static string ValidateToken(string json)
        {
            string SqlCmd = "";
            string URL = System.Configuration.ConfigurationManager.AppSettings["InvalidURL"];

            if (HttpContext.Current.Session["Key"] == null)
            {
                return URL;
            }
            SVframework2016.SqlConnector Cn = new SVframework2016.SqlConnector(connectionstring, null);
            try
            {
                SqlCmd = "Select * from Sys_Audit_ResetPassword Where Token = '" + HttpContext.Current.Session["Key"] + "'";
                if (Cn.Select(SqlCmd).Rows.Count == 0)
                {
                    return URL;
                }
                else
                {
                    SqlCmd = "Select * from Sys_Audit_ResetPassword Where Token = '" + HttpContext.Current.Session["Key"] + "' and Isresponse =0";
                    if (Cn.Select(SqlCmd).Rows.Count == 0)
                    {
                        return URL;
                    }
                    else
                    {
                        return "";
                    }
                }
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
        public static string GetResetPasswordInfo()
        {

            string Sqlcmd = "";
            System.Data.DataTable Dt = new System.Data.DataTable();
            Sqlcmd = "Select up.username from Sys_Audit_ResetPassword AR left join Sys_Core_User Up on AR.username = up.id and up.IsDelete = 0 where Token  = '" + HttpContext.Current.Session["Key"] + "'";
            SVframework2016.SqlConnector Cn = new SVframework2016.SqlConnector(connectionstring, null);
            Dt = Cn.Select(Sqlcmd);
            try
            {
                if (Dt.Rows.Count == 0)
                {
                    return "";
                }
                else
                {
                    Clsuser Objuser = new Clsuser();
                    Objuser = ClsEngine.Loadprofile(ref Cn, Dt.Rows[0]["Username"].ToString());
                    return Objuser.firstnameth + " " + Objuser.lastnameth;
                }
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
    }
}