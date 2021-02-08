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
    public partial class Emp : System.Web.UI.Page
    {
        public static string Connectionstring = ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;

        [WebMethod]
        public static string ChangeIns(string json)
        {
            //var json = 'type:' + type;
            //json += 'value:' + $("input[@id=" + ctrl + "]:checked");
            //json += 'Hdempid:' + $('#Hdempid').val();
            ArrayList Arrcmd = new ArrayList();
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string value = ClsEngine.FindValue(Dicts, "value");
            if (value.ToUpper() == "TRUE")
            {
                value = "1";
            }
            else
            {
                value = "0";
            }
            string sqlcmd = "";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            if (ClsEngine.FindValue(Dicts, "type") == "R")
            {
                sqlcmd = "Update Sys_HR_Empdetail set InsRegular ='" + value + "',Modifydate=getdate(),Modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where userid='" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                cn.Execute(sqlcmd, null);
                //Arrcmd.Add(sqlcmd);
                //sqlcmd = "Update Sys_Master_Instuctor set isdelete =1,Deletedate=getdate(),Deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where userid='" + ClsEngine.FindValue(Dicts, "Hdempid") + "' and  InstuctorType = '" + ClsEngine.FindValue(Dicts, "type") + "'";
                


            }
            else if (ClsEngine.FindValue(Dicts, "type") == "T")
            {
                sqlcmd = "Update Sys_HR_Empdetail set InsTheory ='" + value + "',Modifydate=getdate(),Modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where userid='" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                //Arrcmd.Add(sqlcmd);
                cn.Execute(sqlcmd, null);
            }
            else if (ClsEngine.FindValue(Dicts, "type") == "E")
            {
                sqlcmd = "Update Sys_HR_Empdetail set InsExtra ='" + value + "',Modifydate=getdate(),Modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where userid='" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                //Arrcmd.Add(sqlcmd);
                cn.Execute(sqlcmd, null);
            }


            sqlcmd = "Delete from Sys_Master_Instuctor Where userid='" + ClsEngine.FindValue(Dicts, "Hdempid") + "' and  InstuctorType = '" + ClsEngine.FindValue(Dicts, "type") + "'";
            //Arrcmd.Add(sqlcmd);
            cn.Execute(sqlcmd, null);
            if (value == "1")
            {
                sqlcmd = " INSERT [Sys_Master_Instuctor] ";
                sqlcmd += " ([Userid]";
                sqlcmd += " ,[Firstname]";
                sqlcmd += " ,[Lastname] ";
                sqlcmd += " ,[InstuctorType]";
                sqlcmd += " ,[isdelete]";
                sqlcmd += " ,[CreateDate]";
                sqlcmd += " ,[CreateBy] ) ";
                sqlcmd += " VALUES ";
                sqlcmd += " ( ";
                sqlcmd += "'" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "firstnameTH") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "LastnameTH") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "type") + "'";
                sqlcmd += ",0";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                //Arrcmd.Add(sqlcmd);
                cn.Execute(sqlcmd, null);
            }
            //cn.Execute(Arrcmd, null);
            return "";
        }

        [WebMethod]
        public static string Validateleave(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "select isnull(Remainleave,'0') as Remainleave  from Sys_HR_EmpLeave where [year] = year(getdate()) and Remainleave > 0 and isdelete = 0 and isconsolidate= 0 and userid = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "userid") + "' and Leavetype ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "type") + "'";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            try
            {
                if (Dt.Rows.Count == 0)
                {
                    return "ไม่มีวันหยุดเพียงพอหรือมีการยกยอดวันหยุดไปแล้ว";
                }
                else
                {
                    if (int.Parse(Dt.Rows[0][0].ToString()) == 0)
                    {
                        return "ไม่มีวันหยุดเพียงพอ";
                    }
                    else
                    {
                        return "";
                    }
                }
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
        public static ClsCallBackUpload CallBackUpload(string Ctrl, string RunningNo)
        {
            ClsCallBackUpload ObjCallBack = new ClsCallBackUpload();
            DataTable Dt = new DataTable();
            SqlConnector _Cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Trans_Attachment Where Id ='" + RunningNo + "'";
            try
            {
                ObjCallBack.src =  new System.IO.FileInfo(_Cn.Select(sqlcmd).Rows[0]["Path"].ToString()).Name;
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
        public static string Saveleave(string json)
        {
            //json = 'Hdempid:' + $('#Hdempid').val() + '|';
            //json += 'Hdleavetypeid:' + $('#Hdleavetypeid').val() + '|';
            //json += 'Txtleavesubject:' + $('#Txtleavesubject').val() + '|';
            //json += 'Cbleavecat:' + $('#Cbleavecat').val() + '|';
            //json += 'Txtstartleave:' + $('#Txtstartleave').val() + '|';
            //json += 'Txtstopleave:' + $('#Txtstopleave').val() + '|';
            //json += 'Txtpartleave:' + $('#Txtpartleave').val() + '|';
            //json += 'Cbleavepartstarttime:' + $('#Cbleavepartstarttime').val() + '|';
            //json += 'Cbleavepartstoptime:' + $('#Cbleavepartstoptime').val() + '|';
            //json += 'Txtleavedesc:' + $('#HdempTxtleavedescid').val() + '|';
            //json += 'Cbdelegate:' + $('#Cbdelegate').val() + '|';


            //Validate

            //Validate
            List<ClsDict> Dicts = new List<ClsDict>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new ArrayList();
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Leave_Empleave", "Id");
            int Leavedays = 0;

            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            sqlcmd += " INSERT INTO [Sys_Leave_Empleave]  ";
            sqlcmd += "([id]  ";
            sqlcmd += ",[Userid]  ";
            sqlcmd += ",[Leavetypeid]  ";
            sqlcmd += ",[Leavesubject]  ";
            sqlcmd += ",[Leavecat]  ";
            if (ClsEngine.FindValue(Dicts, "Cbleavecat") == "F")
            {
                sqlcmd += ",[Startleave]  ";
                sqlcmd += ",[Stopleave]  ";
                DateTime D1 = new DateTime();
                DateTime D2 = new DateTime();
                D1 = (DateTime)ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtstartleave"), '/');
                D2 = (DateTime)ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtstopleave"), '/');
                Leavedays = Math.Abs(D1.Subtract(D2).Days);
            }
            else
            {
                Leavedays = 1;
                sqlcmd += ",[Partleave]  ";
                sqlcmd += ",[Partstarttime]  ";
                sqlcmd += ",[Partstoptime]  ";
            }
            sqlcmd += ",[Leavedesc]  ";
          
            sqlcmd += ",[Delegateid]  ";
            sqlcmd += ",[Leavedays]  ";
            sqlcmd += ",[isdelete]  ";
            sqlcmd += ",[CreateDate]  ";
            sqlcmd += ",[CreateBy] ) Values ";
            sqlcmd += " ('" + id + "'";
            sqlcmd += " ('" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
            sqlcmd += " ,'" + ClsEngine.FindValue(Dicts, "Hdleavetypeid") + "'";
            sqlcmd += " ,'" + ClsEngine.FindValue(Dicts, "Txtleavesubject") + "'";
            sqlcmd += " ,'" + ClsEngine.FindValue(Dicts, "Cbleavecat") + "'";
            if (ClsEngine.FindValue(Dicts, "Cbleavecat") == "F")
            {
                sqlcmd += " ,'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtstartleave"),'/') + "'";
                sqlcmd += " ,'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtstopleave"), '/') + "'";
            }
            else
            {
                sqlcmd += " ,'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtpartleave"), '/') + "'";
                sqlcmd += " ,'" + ClsEngine.FindValue(Dicts, "Cbleavepartstarttime") + "'";
                sqlcmd += " ,'" + ClsEngine.FindValue(Dicts, "Cbleavepartstoptime") + "'";
            }
            sqlcmd += " ,'" + ClsEngine.FindValue(Dicts, "Txtleavedesc") + "'";
            sqlcmd += " ,'" + ClsEngine.FindValue(Dicts, "Cbdelegate") + "'";
            sqlcmd += " ,'" + Leavedays + "'";
            sqlcmd += " ,0 ";
            sqlcmd += " ,Getdate() ";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            Arrcmd.Add(sqlcmd);
            sqlcmd = "Update Sys_HR_EmpLeave Set Currentleave = Currentleave + " + Leavedays;
            sqlcmd += " ,Remainleave = Remainleave - " + Leavedays;
            sqlcmd += " Where Leavetype ='" + ClsEngine.FindValue(Dicts, "Hdleavetypeid") + "'";
            sqlcmd += " and isdone = 1 and isconsolidate = 0 and userid ='" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
            Arrcmd.Add(sqlcmd);
            cn.Execute(Arrcmd, null);
            return "";
        }
        [WebMethod]
        public static List<Clsempleave> Getleaves(string json)
        {
            string userid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Hdempid");
            string Sqlcmd = "";
            Sqlcmd = " Select ";
            Sqlcmd += " EL.Userid, L.id as Leavetype ";
            Sqlcmd += " ,L.Leavetypename ";
            Sqlcmd += " ,isnull(EL.Year, '') as Year ";
            Sqlcmd += " ,isnull(EL.Prevtotalleave, '0') as Prevtotalleave ";
            Sqlcmd += " ,isnull(EL.Settingleave, '0') as Settingleave ";
            Sqlcmd += " ,isnull(EL.Totalleave, '0') as Totalleave ";
            Sqlcmd += " ,isnull(EL.Currentleave, '0') as Currentleave ";
            Sqlcmd += " ,isnull(EL.Remainleave, '0') as Remainleave ";
            Sqlcmd += " from Sys_Master_Leavetype L ";
            Sqlcmd += " left ";
            Sqlcmd += " join Sys_HR_EmpLeave EL on L.id = EL.Leavetype  and isdone = 1 and Isconsolidate = 0  and EL.Userid = '" + userid + "'  and [Year] = year(getdate())";
            Sqlcmd += " where L.isdelete = 0  ";
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            Clsempleave Obj;
            List<Clsempleave> Objs = new List<Clsempleave>();
            Dt = cn.Select(Sqlcmd);
            foreach(DataRow dr in Dt.Rows)
            {
                Obj = new Clsempleave();
                Obj.Userid = dr["Userid"].ToString();
                Obj.Leavetype = dr["Leavetype"].ToString();
                Obj.Leavetypename = dr["Leavetypename"].ToString();
                Obj.Year = dr["Year"].ToString();
                Obj.Prevtotalleave = dr["Prevtotalleave"].ToString();
                Obj.Settingleave = dr["Settingleave"].ToString();
                Obj.Totalleave = dr["Totalleave"].ToString();
                Obj.Currentleave = dr["Currentleave"].ToString();
                Obj.Remainleave = dr["Remainleave"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }

        [WebMethod]
        public static ClsEmpInsignia Getinsigniainfo(string json)
        {
            DataTable Dt = new DataTable();
            ClsEmpInsignia Obj = new ClsEmpInsignia();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select hr.*,m.Insignianame from sys_hr_insignia hr left join sys_master_insignia m on hr.InsigniaId = m.id   where hr.isdelete = 0 and hr.id= '" + json.Replace("id:", "").Replace("|", "") + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count == 0)
            {
                Obj.Error = "ไม่สามารถดึงข้อมูลเครื่องราชอิสริยาภรณ์ได้ โปรดติดต่อผู้ดูแลระบบ ";
            }
            else
            {
                Obj.id = Dt.Rows[0]["id"].ToString();
                Obj.Insigniaid = Dt.Rows[0]["InsigniaId"].ToString();
                Obj.Insignianame = Dt.Rows[0]["Insignianame"].ToString();
                Obj.Bookno = Dt.Rows[0]["Bookno"].ToString();
                Obj.Orderno = Dt.Rows[0]["Orderno"].ToString();
                Obj.Pageno = Dt.Rows[0]["Pageno"].ToString();
                Obj.Paragraphno = Dt.Rows[0]["Paragraphno"].ToString();
                Obj.Yearno = Dt.Rows[0]["Yearno"].ToString();
                if (Dt.Rows[0]["AnounceDate"].ToString() != "")
                {
                    Obj.Anouncedate = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["AnounceDate"].ToString()));
                }
                else
                {
                    Obj.Anouncedate = "";
                }
                
                Obj.Error = "";
            }
            return Obj;
        }

        [WebMethod]
        public static List<ClsDict> Getpromotetype(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,promotetypename from Sys_Master_promotetype where isdelete = 0 order by promotetypename";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["promotetypename"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static string Savepromote(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            //json += 'Hdempid:' + $('#Hdempid').val() + '|';
            //json += 'Hdpromote:' + $('#Hdpromoteid').val() + '|';
            //json += 'Effectdate:' + $('#Txteffectdate').val() + '|';
            //json += 'Positionremark:' + $('#TxtPositionremark').val() + '|';
            //json += 'Lvremark:' + $('#Txtlvremark').val() + '|';
            //json += 'Salary:' + $('#Txtpromotesalary').val() + '|';
            //json += 'Referdocument:' + $('#Txtreferdocument').val() + '|';
            //json += 'Promotetypeid:' + $('#Cbpromotetype').val() + '|';
            //json += 'Managementpositionid:' + $('#Cbpromotemanagementposition').val() + '|';
            //json += 'Lineofjobpositionid:' + $('#Cblineofjobposition').val() + '|';
            //json += 'Workplace:' + $('#Txtpromoteworkplace').val() + '|';
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            if (ClsEngine.FindValue(Dicts, "Hdpromote") == "")
            {
                sqlcmd = " INSERT INTO [Sys_HR_Promote] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[Userid] ";
                sqlcmd += " ,[PositionRemark] ";
                sqlcmd += " ,[Positionno] ";
                sqlcmd += " ,[LvRemark] ";
                sqlcmd += " ,[Salary] ";
                sqlcmd += " ,[ReferDocument] ";
                sqlcmd += " ,[PromoteTypeid] ";
                sqlcmd += " ,[ManagementPositionId] ";
                sqlcmd += " ,[LineofJobPositionId] ";
                sqlcmd += " ,[Workplace] ";
                if (ClsEngine.FindValue(Dicts, "Effectdate") != "")
                {
                    sqlcmd += " ,[Effectdate] ";
                }
                sqlcmd += " ,[IsDelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += "  VALUES ( ";
                sqlcmd += "'" + ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_Promote", "id") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Positionremark") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Positionno") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Lvremark") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Salary") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Referdocument") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Promotetypeid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Managementpositionid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Lineofjobpositionid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Workplace") + "'";
                if (ClsEngine.FindValue(Dicts, "Effectdate") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Effectdate"), '/') + "'";
                }
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            else
            {
                sqlcmd = "   Update Sys_HR_Promote set ";
                sqlcmd += "  [PositionRemark] = '" + ClsEngine.FindValue(Dicts, "Positionremark") + "'";
                sqlcmd += " ,[Positionno]= '" + ClsEngine.FindValue(Dicts, "Positionno") + "'";
                sqlcmd += " ,[LvRemark] = '" + ClsEngine.FindValue(Dicts, "Lvremark") + "'";
                sqlcmd += " ,[Salary] = '" + ClsEngine.FindValue(Dicts, "Salary") + "'";
                sqlcmd += " ,[ReferDocument] = '" + ClsEngine.FindValue(Dicts, "Referdocument") + "'";
                sqlcmd += " ,[PromoteTypeid] = '" + ClsEngine.FindValue(Dicts, "Promotetypeid") + "'";
                sqlcmd += " ,[ManagementPositionId] = '" + ClsEngine.FindValue(Dicts, "Managementpositionid") + "'";
                sqlcmd += " ,[LineofJobPositionId] = '" + ClsEngine.FindValue(Dicts, "Lineofjobpositionid") + "'";
                sqlcmd += " ,[Workplace] = '" + ClsEngine.FindValue(Dicts, "Workplace") + "'";
                if (ClsEngine.FindValue(Dicts, "Effectdate") != "")
                {
                    sqlcmd += " ,[Effectdate] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Effectdate"), '/') + "'";
                }
                sqlcmd += " Where [id] = '" + ClsEngine.FindValue(Dicts, "Hdpromote") + "'";
                cn.Execute(sqlcmd, null);
            }
            return "";
        }

        [WebMethod]
        public static string Saveinsignia(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            //json += 'Hdempid:' + $('#Hdempid').val() + '|';
            //json += 'Hdinsignia:' + $('#Hdinsignia').val() + '|';
            //json += 'Cbdegree:' + $('#Cbdegree').val() + '|';
            //json += 'Cbinsignia:' + $('#Cbinsignia').val() + '|';
            //json += 'Cbmajor:' + $('#Cbmajor').val() + '|';
            //json += 'Cbacademy:' + $('#Cbacademy').val() + '|';
            //json += 'Cbcountry:' + $('#Cbcountry').val() + '|';
            //json += 'Txtinsigniastart:' + $('#Txtinsigniastart').val() + '|';
            //json += 'Txtinsigniastop:' + $('#Txtinsigniastop').val() + '|';
            //json += 'Txtstartemployinsignianame:' + $('#Txtstartemployinsignianame').val() + '|';
            //json += 'Cbismaxinsignia:' + $('#Cbismaxinsignia').val() + '|';
            //json += 'Cbisuseforstartaffair:' + $('#Cbisuseforstartaffair').val() + '|';
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            if (ClsEngine.FindValue(Dicts, "Hdinsignia") == "")
            {
                sqlcmd = " INSERT INTO [Sys_HR_insignia] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[Userid] ";
                sqlcmd += " ,[InsigniaId] ";
                sqlcmd += " ,[Yearno] ";
                sqlcmd += " ,[Bookno] ";
                sqlcmd += " ,[Paragraphno] ";
                sqlcmd += " ,[Pageno] ";
                sqlcmd += " ,[Orderno] ";
                if (ClsEngine.FindValue(Dicts, "Txtinsigniaanouncedate") != "")
                {
                    sqlcmd += " ,[AnounceDate] ";
                }
                sqlcmd += " ,[IsDelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += "  VALUES ( ";
                sqlcmd += "'" + ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_insignia", "id") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbinsignia") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtinsigniayearno") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtinsigniabookno") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtinsigniaparagraphno") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtinsigniapageno") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtinsigniaorderno") + "'";
                if (ClsEngine.FindValue(Dicts, "Txtinsigniaanouncedate") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtinsigniaanouncedate"), '/') + "'";
                }
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            else
            {
                sqlcmd = "     Update Sys_HR_insignia set ";
                sqlcmd += "    [insigniaid] = '" + ClsEngine.FindValue(Dicts, "Cbinsignia") + "'";
                sqlcmd += "   ,[Yearno] = '" + ClsEngine.FindValue(Dicts, "Txtinsigniayearno") + "'";
                sqlcmd += "   ,[Bookno]= '" + ClsEngine.FindValue(Dicts, "Txtinsigniabookno") + "'";
                sqlcmd += "   ,[Paragraphno] = '" + ClsEngine.FindValue(Dicts, "Txtinsigniaparagraphno") + "'";
                sqlcmd += "   ,[Pageno] = '" + ClsEngine.FindValue(Dicts, "Txtinsigniapageno") + "'";
                sqlcmd += "   ,[Orderno] = '" + ClsEngine.FindValue(Dicts, "Txtinsigniaorderno") + "'";
                if (ClsEngine.FindValue(Dicts, "Txtinsigniaanouncedate") != "")
                {
                    sqlcmd += " ,[AnounceDate] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtinsigniaanouncedate"), '/') + "'";
                }
                sqlcmd += " Where [id] = '" + ClsEngine.FindValue(Dicts, "Hdinsignia") + "'";
                cn.Execute(sqlcmd, null);
            }
            return "";
        }
        [WebMethod]
        public static List<ClsDict> Getinsignia(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,insignianame from Sys_Master_insignia where isdelete = 0 order by insignianame";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["insignianame"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }

        [WebMethod]
        public static string Saveexpertise(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            if (ClsEngine.FindValue(Dicts, "Hdexpertise") == "")
            {
                sqlcmd = " INSERT INTO [Sys_HR_expertise] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[Userid] ";
                sqlcmd += " ,[topic] ";
                sqlcmd += " ,[remark] ";
       
                sqlcmd += " ,[IsDelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += "  VALUES ( ";
                sqlcmd += "'" + ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_expertise", "id") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtexpertisetopic") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtexpertiseremark") + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            else
            {
                sqlcmd = "   Update Sys_HR_expertise set ";
                sqlcmd += "  [topic] = '" + ClsEngine.FindValue(Dicts, "Txtexpertisetopic") + "'";
                sqlcmd += " ,[remark] = '" + ClsEngine.FindValue(Dicts, "Txtexpertiseremark") + "'";
                sqlcmd += " Where [id] = '" + ClsEngine.FindValue(Dicts, "Hdexpertise") + "'";
                cn.Execute(sqlcmd, null);
            }

            return "";
        }


        [WebMethod]
        public static ClsEmpPromote Getpromoteinfo(string json)
        {
            DataTable Dt = new DataTable();
            ClsEmpPromote Obj = new ClsEmpPromote();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from sys_hr_promote hr  where hr.isdelete = 0 and hr.id= '" + json.Replace("id:", "").Replace("|", "") + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count == 0)
            {
                Obj.Error = "ไม่สามารถดึงข้อมูลวิชาชีพได้ โปรดติดต่อผู้ดูแลระบบ ";
            }
            else
            {
                Obj.id = Dt.Rows[0]["id"].ToString();
                Obj.Positionremark = Dt.Rows[0]["Positionremark"].ToString();
                Obj.Positionno = Dt.Rows[0]["Positionno"].ToString();
                Obj.Lvremark = Dt.Rows[0]["Lvremark"].ToString();
                Obj.Salary = Dt.Rows[0]["Salary"].ToString();
                Obj.Referdocument = Dt.Rows[0]["Referdocument"].ToString();
                Obj.Promotetypeid = Dt.Rows[0]["Promotetypeid"].ToString();
                Obj.Managementpositionid = Dt.Rows[0]["Managementpositionid"].ToString();
                Obj.Lineofjobpositionid = Dt.Rows[0]["Lineofjobpositionid"].ToString();
                Obj.Workplace = Dt.Rows[0]["Workplace"].ToString();
                if (Dt.Rows[0]["Effectdate"].ToString() != "")
                {
                    Obj.Effectdate = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Effectdate"].ToString()));
                }
                else
                {
                    Obj.Effectdate = "";
                }
                Obj.Error = "";
            }
            return Obj;
        }

        [WebMethod]
        public static ClsEmpProfressionCouncil Getprofessioncouncilinfo(string json)
        {
            DataTable Dt = new DataTable();
            ClsEmpProfressionCouncil Obj = new ClsEmpProfressionCouncil();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from sys_hr_professioncouncil hr  where hr.isdelete = 0 and hr.id= '" + json.Replace("id:", "").Replace("|", "") + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count == 0)
            {
                Obj.Error = "ไม่สามารถดึงข้อมูลวิชาชีพได้ โปรดติดต่อผู้ดูแลระบบ ";
            }
            else
            {
                Obj.id = Dt.Rows[0]["id"].ToString();
                Obj.Professioncouncilid = Dt.Rows[0]["id"].ToString();

                Obj.Professioncouncilno = Dt.Rows[0]["professioncouncilNo"].ToString();
                if (Dt.Rows[0]["professioncouncilstart"].ToString() != "")
                {
                    Obj.Professioncouncilstart = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["professioncouncilStart"].ToString()));
                }
                else
                {
                    Obj.Professioncouncilstart = "";
                }
                if (Dt.Rows[0]["professioncouncilend"].ToString() != "")
                {
                    Obj.Professioncouncilend = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["professioncouncilend"].ToString()));
                }
                else
                {
                    Obj.Professioncouncilend = "";
                }
                Obj.Error = "";
            }
            return Obj;
        }

        [WebMethod]
        public static string Saveprofessioncouncil(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            //json += 'Hdempid:' + $('#Hdempid').val() + '|';
            //json += 'Hdprofessioncouncil:' + $('#Hdprofessioncouncil').val() + '|';
            //json += 'Cbdegree:' + $('#Cbdegree').val() + '|';
            //json += 'Cbprofessioncouncil:' + $('#Cbprofessioncouncil').val() + '|';
            //json += 'Cbmajor:' + $('#Cbmajor').val() + '|';
            //json += 'Cbacademy:' + $('#Cbacademy').val() + '|';
            //json += 'Cbcountry:' + $('#Cbcountry').val() + '|';
            //json += 'Txtprofessioncouncilstart:' + $('#Txtprofessioncouncilstart').val() + '|';
            //json += 'Txtprofessioncouncilstop:' + $('#Txtprofessioncouncilstop').val() + '|';
            //json += 'Txtstartemployprofessioncouncilname:' + $('#Txtstartemployprofessioncouncilname').val() + '|';
            //json += 'Cbismaxprofessioncouncil:' + $('#Cbismaxprofessioncouncil').val() + '|';
            //json += 'Cbisuseforstartaffair:' + $('#Cbisuseforstartaffair').val() + '|';
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            if (ClsEngine.FindValue(Dicts, "Hdprofessioncouncil") == "")
            {
                sqlcmd = " INSERT INTO [Sys_HR_professioncouncil] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[Userid] ";
                sqlcmd += " ,[professioncouncilid] ";
                sqlcmd += " ,[professioncouncilNo] ";
                if (ClsEngine.FindValue(Dicts, "Txtprofessioncouncilstart") != "")
                {
                    sqlcmd += " ,[professioncouncilstart] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtprofessioncouncilstop") != "")
                {
                    sqlcmd += " ,[professioncouncilend] ";
                }
                sqlcmd += " ,[IsDelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += "  VALUES ( ";
                sqlcmd += "'" + ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_professioncouncil", "id") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbprofessioncouncil") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtprofessioncouncilno") + "'";
                if (ClsEngine.FindValue(Dicts, "Txtprofessioncouncilstart") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtprofessioncouncilstart"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtprofessioncouncilstop") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtprofessioncouncilstop"), '/') + "'";
                }
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            else
            {
                sqlcmd = "   Update Sys_HR_professioncouncil set ";
                sqlcmd += "   [professioncouncilid] = '" + ClsEngine.FindValue(Dicts, "Cbprofessioncouncil") + "'";
                sqlcmd += "  ,[professioncouncilNo] = '" + ClsEngine.FindValue(Dicts, "Txtprofessioncouncilno") + "'";
                if (ClsEngine.FindValue(Dicts, "Txtprofessioncouncilstart") != "")
                {
                    sqlcmd += " ,[professioncouncilstart] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtprofessioncouncilstart"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtprofessioncouncilstop") != "")
                {
                    sqlcmd += " ,[professioncouncilend] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtprofessioncouncilstop"), '/') + "'";
                }
                sqlcmd += " Where [id] = '" + ClsEngine.FindValue(Dicts, "Hdprofessioncouncil") + "'";
                cn.Execute(sqlcmd, null);
            }

            return "";
        }


        [WebMethod]
        public static List<ClsDict> Getprofessioncouncil(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,professionname from Sys_Master_profession where isdelete = 0 order by professionname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["professionname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static ClsEmpProfession Getprofessioninfo(string json)
        {
            DataTable Dt = new DataTable();
            ClsEmpProfession Obj = new ClsEmpProfession();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from sys_hr_profession hr  where hr.isdelete = 0 and hr.id= '" + json.Replace("id:", "").Replace("|", "") + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count == 0)
            {
                Obj.Error = "ไม่สามารถดึงข้อมูลวิชาชีพได้ โปรดติดต่อผู้ดูแลระบบ ";
            }
            else
            {
                Obj.id = Dt.Rows[0]["id"].ToString();
                Obj.Professionid = Dt.Rows[0]["id"].ToString();  

                Obj.Professionno = Dt.Rows[0]["professionNo"].ToString();
                if (Dt.Rows[0]["professionstart"].ToString() != "")
                {
                    Obj.Professionstart = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["professionStart"].ToString()));
                }
                else
                {
                    Obj.Professionstart = "";
                }
                if (Dt.Rows[0]["professionend"].ToString() != "")
                {
                    Obj.Professionend = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["professionend"].ToString()));
                }
                else
                {
                    Obj.Professionend = "";
                }
                Obj.Error = "";
            }
            return Obj;
        }
        [WebMethod]
        public static ClsEmpEducation Geteducationinfo(string json)
        {
            DataTable Dt = new DataTable();
            ClsEmpEducation Obj = new ClsEmpEducation();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from sys_hr_education where isdelete = 0 and id= '" + json.Replace("id:","").Replace("|","") + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count == 0)
            {
                Obj.Error = "ไม่สามารถดึงข้อมูลประวัติการศึกษาได้ โปรดติดต่อผู้ดูแลระบบ ";
            }
            else
            {
                Obj.id = Dt.Rows[0]["id"].ToString();
                Obj.Educationid = Dt.Rows[0]["Educationid"].ToString();
                Obj.Degreeid = Dt.Rows[0]["Degreeid"].ToString();
                Obj.Majorid = Dt.Rows[0]["Majorid"].ToString();
                Obj.Academyid = Dt.Rows[0]["Academyid"].ToString();
                Obj.Countryid = Dt.Rows[0]["Countryid"].ToString();
                if (Dt.Rows[0]["Educationstart"].ToString() != "")
                {
                    Obj.Educationstart = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Educationstart"].ToString()));
                }
                else
                {
                    Obj.Educationstart = "";
                }
                if (Dt.Rows[0]["Educationend"].ToString() != "")
                {
                    Obj.Educationend = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Educationend"].ToString()));
                }
                else
                {
                    Obj.Educationend = "";
                }
                Obj.IsmaxEducation = Dt.Rows[0]["IsmaxEducation"].ToString();
                Obj.Startemployprofession = Dt.Rows[0]["Startemployprofession"].ToString();
                Obj.IsuseforStartAffair = Dt.Rows[0]["IsuseforStartAffair"].ToString();
                Obj.Isnurse = Dt.Rows[0]["Isnurse"].ToString();
                Obj.Error = "";
            }
            return Obj;
        }
        [WebMethod]
        public static string Saveprofession(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            //json += 'Hdempid:' + $('#Hdempid').val() + '|';
            //json += 'Hdprofession:' + $('#Hdprofession').val() + '|';
            //json += 'Cbdegree:' + $('#Cbdegree').val() + '|';
            //json += 'Cbprofession:' + $('#Cbprofession').val() + '|';
            //json += 'Cbmajor:' + $('#Cbmajor').val() + '|';
            //json += 'Cbacademy:' + $('#Cbacademy').val() + '|';
            //json += 'Cbcountry:' + $('#Cbcountry').val() + '|';
            //json += 'Txtprofessionstart:' + $('#Txtprofessionstart').val() + '|';
            //json += 'Txtprofessionstop:' + $('#Txtprofessionstop').val() + '|';
            //json += 'Txtstartemployprofessionname:' + $('#Txtstartemployprofessionname').val() + '|';
            //json += 'Cbismaxprofession:' + $('#Cbismaxprofession').val() + '|';
            //json += 'Cbisuseforstartaffair:' + $('#Cbisuseforstartaffair').val() + '|';
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            if (ClsEngine.FindValue(Dicts, "Hdprofession") == "")
            {
                sqlcmd = " INSERT INTO [Sys_HR_profession] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[Userid] ";
                sqlcmd += " ,[professionid] ";
                sqlcmd += " ,[professionNo] ";
                if (ClsEngine.FindValue(Dicts, "Txtprofessionstart") != "")
                {
                    sqlcmd += " ,[professionstart] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtprofessionstop") != "")
                {
                    sqlcmd += " ,[professionend] ";
                }
                sqlcmd += " ,[IsDelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += "  VALUES ( ";
                sqlcmd += "'" + ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_profession", "id") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbprofession") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtprofessionno") + "'";
                if (ClsEngine.FindValue(Dicts, "Txtprofessionstart") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtprofessionstart"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtprofessionstop") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtprofessionstop"), '/') + "'";
                }
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            else
            {
                sqlcmd = "   Update Sys_HR_profession set ";
                sqlcmd += "  [professionNo] = '" + ClsEngine.FindValue(Dicts, "Txtprofessionno") + "'";
                sqlcmd += "  ,[professionid] = '" + ClsEngine.FindValue(Dicts, "Cbprofession") + "'";
                if (ClsEngine.FindValue(Dicts, "Txtprofessionstart") != "")
                {
                    sqlcmd += " ,[professionstart] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtprofessionstart"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtprofessionstop") != "")
                {
                    sqlcmd += " ,[professionend] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtprofessionstop"), '/') + "'";
                }
                sqlcmd += " Where [id] = '" + ClsEngine.FindValue(Dicts, "Hdprofession") + "'";
                cn.Execute(sqlcmd, null);
            }

            return "";
        }
        [WebMethod]
        public static string Saveeducation(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            //json += 'Hdempid:' + $('#Hdempid').val() + '|';
            //json += 'Hdeducation:' + $('#Hdeducation').val() + '|';
            //json += 'Cbdegree:' + $('#Cbdegree').val() + '|';
            //json += 'Cbeducation:' + $('#Cbeducation').val() + '|';
            //json += 'Cbmajor:' + $('#Cbmajor').val() + '|';
            //json += 'Cbacademy:' + $('#Cbacademy').val() + '|';
            //json += 'Cbcountry:' + $('#Cbcountry').val() + '|';
            //json += 'Txteducationstart:' + $('#Txteducationstart').val() + '|';
            //json += 'Txteducationstop:' + $('#Txteducationstop').val() + '|';
            //json += 'Txtstartemployprofessionname:' + $('#Txtstartemployprofessionname').val() + '|';
            //json += 'Cbismaxeducation:' + $('#Cbismaxeducation').val() + '|';
            //json += 'Cbisuseforstartaffair:' + $('#Cbisuseforstartaffair').val() + '|';
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            if (ClsEngine.FindValue(Dicts, "Hdeducation") == "")
            {
                sqlcmd = " INSERT INTO [Sys_HR_Education] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[Userid] ";
                sqlcmd += " ,[Educationid] ";
                sqlcmd += " ,[Degreeid] ";
                sqlcmd += " ,[Majorid] ";
                sqlcmd += " ,[Academyid] ";
                sqlcmd += " ,[Countryid] ";
                if (ClsEngine.FindValue(Dicts, "Txteducationstart") != "")
                {
                    sqlcmd += " ,[Educationstart] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txteducationstop") != "")
                {
                    sqlcmd += " ,[Educationend] ";
                }
                sqlcmd += " ,[IsmaxEducation] ";
                sqlcmd += " ,[StartEmployprofession] ";
                sqlcmd += " ,[IsuseforStartAffair] ";
                sqlcmd += " ,[Isnurse] ";
                sqlcmd += " ,[IsDelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += "  VALUES ( ";
                sqlcmd += "'" +  ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_Education", "id") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbeducation") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbdegree") + "'";

                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbmajor") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbacademy") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbcountry") + "'";
                if (ClsEngine.FindValue(Dicts, "Txteducationstart") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txteducationstart"),'/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txteducationstop") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txteducationstop"), '/') + "'";
                }
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbismaxeducation") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtstartemployprofessionname") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbisuseforstartaffair") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Chkisnurse") + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd,null);
            }
            else
            {
                sqlcmd = "   Update Sys_HR_Education set ";
                sqlcmd += "  [Degreeid] = '" + ClsEngine.FindValue(Dicts, "Cbdegree") + "'";
                sqlcmd += " ,[Majorid] = '" + ClsEngine.FindValue(Dicts, "Cbmajor") + "'";
                sqlcmd += " ,[Academyid] = '" + ClsEngine.FindValue(Dicts, "Cbacademy") + "'";
                sqlcmd += " ,[Educationid] = '" + ClsEngine.FindValue(Dicts, "Cbeducation") + "'";
                if (ClsEngine.FindValue(Dicts, "Txteducationstart") != "")
                {
                    sqlcmd += " ,[Educationstart] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txteducationstart"),'/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txteducationstop") != "")
                {
                    sqlcmd += " ,[Educationend] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txteducationstop"), '/') + "'";
                }
                sqlcmd += " ,[IsmaxEducation] = '" + ClsEngine.FindValue(Dicts, "Cbismaxeducation") + "'";
                sqlcmd += " ,[StartEmployprofession] = '" + ClsEngine.FindValue(Dicts, "Txtstartemployprofessionname") + "'";
                sqlcmd += " ,[IsuseforStartAffair] = '" + ClsEngine.FindValue(Dicts, "Cbisuseforstartaffair") + "'";
                sqlcmd += " ,[Isnurse] = '" + ClsEngine.FindValue(Dicts, "Chkisnurse") + "'";
                sqlcmd += " Where [id] = '" + ClsEngine.FindValue(Dicts, "Hdeducation") + "'";
                cn.Execute(sqlcmd, null);
            }

            return "";
        }
        [WebMethod]
        public static List<ClsDict> Getprofession(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,professionname from Sys_Master_profession where isdelete = 0 order by professionname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["professionname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }

        [WebMethod]
        public static List<ClsDict> Getcountry(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,countryname from Sys_Master_country where isdelete = 0 order by countryname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["countryname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getdegree(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,degreename from Sys_Master_degree where isdelete = 0 order by degreename";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["degreename"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Geteducation(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,educationname from Sys_Master_education where isdelete = 0 order by educationname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["educationname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }

        [WebMethod]
        public static List<ClsDict> Getmajor(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,majorname from Sys_Master_major where isdelete = 0 order by majorname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["majorname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }

        [WebMethod]
        public static List<ClsDict> Getacademy(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,academyname from Sys_Master_academy where isdelete = 0 order by academyname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["academyname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsEmpAddress> Getaddress(string json)
        {
            List<ClsEmpAddress> Dicts = new List<ClsEmpAddress>();
            string Sqlcmd = "Select at.id as masteraddrid,userid,Addresstype,[Address],Provinceid,Districtid,Subdistrictid,Postcode from Sys_Master_Addresstype at left join Sys_HR_Address a on at.id = a.Addresstypeid and a.isdelete =0 and a.Userid = '" + json + "' where at.isdelete = 0 ";
            DataTable Dt = new DataTable();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            ClsEmpAddress Objdict = new ClsEmpAddress();
            Dt = cn.Select(Sqlcmd);
            foreach (DataRow Dr  in Dt.Rows)
            {
                Objdict = new ClsEmpAddress();
                Objdict.id = Dr["masteraddrid"].ToString();
                Objdict.Userid = Dr["Userid"].ToString();
                Objdict.Addresstype = Dr["Addresstype"].ToString();
                Objdict.Address = Dr["Address"].ToString();
                Objdict.Provinceid = Dr["Provinceid"].ToString();
                Objdict.Districtid = Dr["Districtid"].ToString();
                Objdict.Subdistrictid = Dr["Subdistrictid"].ToString();
                Objdict.Postcode = Dr["Postcode"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }

        [WebMethod]
        public static string Generateempno(string json)
        {
            string sqlcmd = "select top 1 userid from Sys_HR_Empdetail order by userid desc";
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            string id = Cn.Select(sqlcmd).Rows[0][0].ToString();
            Cn.Close();
            return "PI-" + id.ToString().PadLeft(6, '0');
            
        }
        
        [WebMethod]
        public static ClsEmpHROPS7 GetHROPS7(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_HR_HROPS7 where isdelete = 0 and userid = '" + json + "'";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsEmpHROPS7 Obj = new ClsEmpHROPS7();
            if (Dt.Rows.Count == 0)
            {
                Obj.Error = "";
                return Obj;
            }
            else
            {
                Obj.Affairstart = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Affairstart"].ToString()));
                Obj.Startemploy = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Startemploy"].ToString()));
                Obj.Isinstructor = Dt.Rows[0]["Isinstructor"].ToString();
                Obj.Workplace = Dt.Rows[0]["Workplace"].ToString();
                Obj.Salary = Dt.Rows[0]["Salary"].ToString();
                Obj.Fieldid = Dt.Rows[0]["Fieldid"].ToString();

                Obj.Isreponsiblelab = Dt.Rows[0]["Isreponsiblelab"].ToString();
                Obj.Managementpositionid = Dt.Rows[0]["Managementpositionid"].ToString();

                Obj.Employtypeid = Dt.Rows[0]["Employtypeid"].ToString();
                Obj.Currentstatusid = Dt.Rows[0]["Currentstatusid"].ToString();
                Obj.Isoperate = Dt.Rows[0]["Isoperate"].ToString();
                
            }
            Obj.Error = "";
            return Obj;
        }

        [WebMethod]
        public static string Save(string json)
        {
 
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string Sqlcmd = "";
            ArrayList Arrcmd = new ArrayList();
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_HROPS7", "Id");
            if (ClsEngine.FindValue(Dicts, "x") == "7")
            {
                if (cn.Select("select * from Sys_HR_HROPS7 where isdelete = 0 and userid = '" + ClsEngine.FindValue(Dicts, "Hdempid") + "'").Rows.Count == 0)
                {
                    //Insert
                    Sqlcmd = " INSERT INTO [Sys_HR_HROPS7] ";
                    Sqlcmd += " ([Id] ";
                    Sqlcmd += " ,[Userid] ";
                    Sqlcmd += " ,[AffairStart] ";
                    Sqlcmd += " ,[StartEmploy] ";
                    Sqlcmd += " ,[Isinstructor] ";
                    Sqlcmd += " ,[WorkPlace] ";
                    Sqlcmd += " ,[Salary] ";
                    Sqlcmd += " ,[FieldId] ";
                    Sqlcmd += " ,[IsreponsibleLab] ";
                    Sqlcmd += " ,[ManagementPositionId] ";
                    Sqlcmd += " ,[EmployTypeId] ";
                    Sqlcmd += " ,[Currentstatusid] ";
                    Sqlcmd += " ,[Isoperate] ";
                    Sqlcmd += " ,[isdelete] ";
                    Sqlcmd += " ,[CreateDate] ";
                    Sqlcmd += " ,[CreateBy] ) ";
                    Sqlcmd += " Values ( ";
                    Sqlcmd += "'" + id + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                    Sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtaffairstart"),'/') + "'";
                    Sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtstartemploy"), '/') + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CbIsinstructor") + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtworkplace") + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtsalary") + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbfield") + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbisreponsiblelab") + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbmanagementposition") + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbemploytype") + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbcurrentstatus") + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbisoperate") + "'";
                    Sqlcmd += ",0";
                    Sqlcmd += ",getdate()";
                    Sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                }
                else
                {
                    //Update
                    Sqlcmd = " Update [Sys_HR_HROPS7] ";
                    Sqlcmd += "  Set ";
                    Sqlcmd += "  [AffairStart] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtaffairstart"), '/') + "'";
                    Sqlcmd += " ,[StartEmploy] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtstartemploy"), '/')  + "'";
                    Sqlcmd += " ,[Isinstructor] = '" + ClsEngine.FindValue(Dicts, "CbIsinstructor") + "'";
                    Sqlcmd += " ,[WorkPlace]= '" + ClsEngine.FindValue(Dicts, "Txtworkplace") + "'";
                    Sqlcmd += " ,[Salary] = '" + ClsEngine.FindValue(Dicts, "Txtsalary") + "'";
                    Sqlcmd += " ,[FieldId] = '" + ClsEngine.FindValue(Dicts, "Cbfield") + "'";
                    Sqlcmd += " ,[IsreponsibleLab]= '" + ClsEngine.FindValue(Dicts, "Cbisreponsiblelab") + "'";
                    Sqlcmd += " ,[ManagementPositionId]= '" + ClsEngine.FindValue(Dicts, "Cbmanagementposition") + "'";
                    Sqlcmd += " ,[EmployTypeId]= '" + ClsEngine.FindValue(Dicts, "Cbemploytype") + "'";
                    Sqlcmd += " ,[Currentstatusid] = '" + ClsEngine.FindValue(Dicts, "Cbcurrentstatus") + "'";
                    Sqlcmd += " ,[Isoperate] = '" + ClsEngine.FindValue(Dicts, "Cbisoperate") + "'";
     
                    Sqlcmd += " ,[ModifyDate]=getdate()";
                    Sqlcmd += " ,[ModifyBy] = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                    Sqlcmd += " Where userid='" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                }
                cn.Execute(Sqlcmd, null);
                return "";
                //json += 'Hdempid :' + $('#Hdempid').val() + '|';
                //json += 'Txtaffairstart :' + $('#Txtaffairstart').val() + '|';
                //json += 'Txtstartemploy :' + $('#Txtstartemploy').val() + '|';
                //json += 'CbIsinstructor :' + $('#CbIsinstructor').val() + '|';
                //json += 'Txtworkplace :' + $('#Txtworkplace').val() + '|';
                //json += 'Cbfield :' + $('#Cbfield').val() + '|';
                //json += 'Cbisreponsiblelab :' + $('#Cbisreponsiblelab').val() + '|';
                //json += 'Cbmanagementposition :' + $('#Cbmanagementposition').val() + '|';
                //json += 'Cbemploytype :' + $('#Cbemploytype').val() + '|';
                //json += 'Cbcurrentstatus :' + $('#Cbcurrentstatus').val() + '|';
                //json += 'Cbisoperate :' + $('#Cbisoperate').val() + '|';
            }

            else if (ClsEngine.FindValue(Dicts, "x") == "1")
            {
                Sqlcmd += " UPDATE [Sys_HR_Empdetail] ";
                Sqlcmd += " Set ";
                Sqlcmd += "  [Empno] = '" + ClsEngine.FindValue(Dicts, "Txtempno") + "'";
                Sqlcmd += " ,[Mymobile] = '" + ClsEngine.FindValue(Dicts, "Txtmymobile") + "'";
                Sqlcmd += " ,[Startemploydate] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtstartemploydate"), '/') + "'";
                Sqlcmd += " ,[Academicpositionid] = '" + ClsEngine.FindValue(Dicts, "Cbacademicposition") + "'";
                Sqlcmd += " ,[Imgempprofile] = '" + ClsEngine.FindValue(Dicts, "Imgempprofilesrc") + "'";
                Sqlcmd += " ,[Attachmentid] = '" + ClsEngine.FindValue(Dicts, "Imgempprofiledat") + "'";
                Sqlcmd += " ,[FirstnameTH] = '" + ClsEngine.FindValue(Dicts, "firstnameTH") + "'";
                Sqlcmd += " ,[LastnameTH] = '" + ClsEngine.FindValue(Dicts, "lastnameTH") + "'";
                Sqlcmd += " ,[FirstnameEN] = '" + ClsEngine.FindValue(Dicts, "firstnameEN") + "'";
                Sqlcmd += " ,[LastnameEN] = '" + ClsEngine.FindValue(Dicts, "lastnameEN") + "'";
                Sqlcmd += " ,[Titleid] = '" + ClsEngine.FindValue(Dicts, "Cbtitle") + "'";
                Sqlcmd += " ,[Genderid] = '" + ClsEngine.FindValue(Dicts, "Cbgender") + "'";
                Sqlcmd += " ,[Birthdate] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtbirthdate"), '/') + "'";
                Sqlcmd += " ,[Height] = '" + ClsEngine.FindValue(Dicts, "Txtheight") + "'";
                Sqlcmd += " ,[Weight] = '" + ClsEngine.FindValue(Dicts, "Txtweight") + "'";
                Sqlcmd += " ,[Provinceid] = '" + ClsEngine.FindValue(Dicts, "Cbprovince") + "'";
                Sqlcmd += " ,[Bloodid] = '" + ClsEngine.FindValue(Dicts, "Cbblood") + "'";
                Sqlcmd += " ,[Religionid] = '" + ClsEngine.FindValue(Dicts, "Cbreligion") + "'";
                Sqlcmd += " ,[Raceid] = '" + ClsEngine.FindValue(Dicts, "Cbrace") + "'";
                Sqlcmd += " ,[Nationid] = '" + ClsEngine.FindValue(Dicts, "Cbnation") + "'";
                Sqlcmd += " ,[Marystatusid] = '" + ClsEngine.FindValue(Dicts, "Cbmarystatus") + "'";
                Sqlcmd += " ,[cardid] = '" + ClsEngine.FindValue(Dicts, "Txtcardid") + "'";
                Sqlcmd += " ,[taxno] = '" + ClsEngine.FindValue(Dicts, "Txttaxno") + "'";
                Sqlcmd += " ,[accountno] = '" + ClsEngine.FindValue(Dicts, "Txtaccountno") + "'";

                Sqlcmd += " ,[email] = '" + ClsEngine.FindValue(Dicts, "email") + "'";
                Sqlcmd += " ,[website] = '" + ClsEngine.FindValue(Dicts, "Txtwebsite") + "'";
                Sqlcmd += " ,[interest] = '" + ClsEngine.FindValue(Dicts, "Txtinterest") + "'";
                Sqlcmd += " ,[motto] = '" + ClsEngine.FindValue(Dicts, "Txtmotto") + "'";
                Sqlcmd += " ,[facebook] = '" + ClsEngine.FindValue(Dicts, "Txtfacebook") + "'";
                Sqlcmd += " ,[pensionDate] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "TxtpensionDate"), '/') + "'";

                Sqlcmd += " ,[cooperative] = '" + ClsEngine.FindValue(Dicts, "Txtcooperative") + "'";
                Sqlcmd += " ,[accountnoGHB] = '" + ClsEngine.FindValue(Dicts, "TxtaccountnoGHB") + "'";
                Sqlcmd += " ,[accountnoGH] = '" + ClsEngine.FindValue(Dicts, "TxtaccountnoGH") + "'";
                Sqlcmd += " ,[welfareshop] = '" + ClsEngine.FindValue(Dicts, "Txtwelfareshop") + "'";
                Sqlcmd += " ,[cremation] = '" + ClsEngine.FindValue(Dicts, "Txtcremation") + "'";
                Sqlcmd += " ,[providentfund] = '" + ClsEngine.FindValue(Dicts, "Txtprovidentfund") + "'";

                Sqlcmd += " ,[socialsecurity] = '" + ClsEngine.FindValue(Dicts, "Txtsocialsecurity") + "'";
                //Sqlcmd += " ,[homephone] = '" + ClsEngine.FindValue(Dicts, "Txthomephone") + "'";
                //Sqlcmd += " ,[workphone] = '" + ClsEngine.FindValue(Dicts, "Txtworkphone") + "'";
                //Sqlcmd += " ,[mobile] = '" + ClsEngine.FindValue(Dicts, "Txtmobile") + "'";
                //Sqlcmd += " ,[internalphone] = '" + ClsEngine.FindValue(Dicts, "Txtinternalphone") + "'";
                Sqlcmd += " ,[ModifyDate] = Getdate() ";
                Sqlcmd += " ,[ModifyBy] = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                Sqlcmd += " Where userid='" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
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
                return "";
            }
            else if (ClsEngine.FindValue(Dicts, "x") == "2")
            {
                DataTable Dtaddress = new DataTable();
                string Addressid = ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_Address", "id");
                Sqlcmd = "Update Sys_HR_Address set isdelete = 1,deletedate =getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where Userid = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Hdempid") + "'";
                Arrcmd.Add(Sqlcmd);
                Dtaddress = cn.Select("Select id,Addresstype from Sys_Master_Addresstype where isdelete= 0 order by id");
                foreach (DataRow dr in Dtaddress.Rows)
                {
                    Sqlcmd = " INSERT INTO [Sys_HR_Address] ";
                    Sqlcmd += " ([id] ";
                    Sqlcmd += ",[Userid]";
                    Sqlcmd += ",[Addresstypeid]";
                    Sqlcmd += ",[Address]";
                    Sqlcmd += ",[Provinceid]";
                    Sqlcmd += ",[Districtid]";
                    Sqlcmd += ",[Subdistrictid]";
                    Sqlcmd += ",[Postcode]";
                    Sqlcmd += ",[IsDelete]";
                    Sqlcmd += ",[CreateDate]";
                    Sqlcmd += ",[CreateBy])";
                    Sqlcmd += "VALUES ";
                    Sqlcmd += "('" + Addressid + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Hdempid") + "'";
                    Sqlcmd += ",'" + dr["id"] + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtaddress_" + dr["id"].ToString()) + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbaddressprovince_" + dr["id"].ToString()) + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbaddressdistrict_" + dr["id"].ToString()) + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbaddresssubdistrict_" + dr["id"].ToString()) + "'";
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbaddresspostcode_" + dr["id"].ToString()) + "'";
                    Sqlcmd += ",'0'";
                    Sqlcmd += ",Getdate()";
                    Sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    Arrcmd.Add(Sqlcmd);
                    Addressid = (int.Parse(Addressid) + 1).ToString();
                }
                cn.Execute(Arrcmd, null);
                return "";
            }
            else 
            {
                return "";
            }
        }



        [WebMethod]
        public static ClsEmpdetail Savenewuser(string json)
        {
            //json += 'Txtusername :' + $('#Txtusername').val() + '|';
            //json += 'firstnameth :' + $('#Txtfirstnameth').val() + '|';
            //json += 'lastnameth :' + $('#Txtlastnameth').val() + '|';
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            List<ClsDict> Dicts = new List<ClsDict>();
            ClsEmpdetail Obj = new ClsEmpdetail();
            System.Collections.ArrayList Arrcmd = new ArrayList();
            string Sqlcmd = "";

            DataTable Dtmetadat = new DataTable();
            string Password = "p@ssw0rd";
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_core_user", "Id");
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            Sqlcmd = " Select ConfigurationValue from Sys_Conf_Configuration where isdelete = 0 and ConfigurationName = 'PrivateKey'";
            string PrivateKey = cn.Select(Sqlcmd).Rows[0][0].ToString();
            Password = ClsEngine.Encrypt(Password, PrivateKey);
            Sqlcmd = "Select * from Sys_Core_User where isdelete = 0 and username ='" + ClsEngine.FindValue(Dicts, "Txtusername") + "'";
            if (cn.Select(Sqlcmd).Rows.Count > 0)
            {
                Obj.Error = "Username ได้มีการใช้งานไปแล้ว";
                return Obj;
            }
            Sqlcmd = " INSERT INTO [Sys_Core_User] ";
            Sqlcmd += "  ([Id]";
            Sqlcmd += " ,[username]";
            Sqlcmd += " ,[password]";
            Sqlcmd += " ,[Isdelete]";
            Sqlcmd += " ,[Createdate]";
            Sqlcmd += " ,[CreateBy] )";
            Sqlcmd += " VALUES ( ";
            Sqlcmd += "'" + id + "'";
            Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtusername") + "'";
            Sqlcmd += ",'" + Password + "'";
            Sqlcmd += ",0";
            Sqlcmd += ",getdate()";
            Sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            Arrcmd.Add(Sqlcmd);
            string _json = "{";
            Dtmetadat = new DataTable();
            Dtmetadat = cn.Select("select * from [Sys_Core_Metadata] where Entityname = 'Sys_Core_Userprofile' and isdelete = 0");
            foreach (DataRow dr in Dtmetadat.Rows)
            {
                _json += "''" + dr["Fieldname"].ToString() + "'' : ''" + ClsEngine.FindValue(Dicts, dr["Fieldname"].ToString()) + "'',";
            }
            _json += "}";
            Sqlcmd = " INSERT INTO [Sys_Core_Userprofile] ";
            Sqlcmd += " ([Userid]";
            Sqlcmd += " ,[json]";
            Sqlcmd += " ,[Isdelete]";
            Sqlcmd += " ,[Createdate]";
            Sqlcmd += " ,[CreateBy] )";
            Sqlcmd += "  VALUES (";
            Sqlcmd += "'" + id + "'";
            Sqlcmd += ",'" + _json + "'";
            Sqlcmd += ",'0'";
            Sqlcmd += ",getdate()";
            Sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            Sqlcmd += "  ) ";
            Arrcmd.Add(Sqlcmd);
            Sqlcmd = "INSERT INTO [dbo].[Sys_HR_Empdetail] ";
            Sqlcmd += " ([userid] ";
            Sqlcmd += " ,[FirstnameTH]";
            Sqlcmd += " ,[LastnameTH]";
            Sqlcmd += " ,[Empno]";
            Sqlcmd += " ,[Isdelete]";
            Sqlcmd += " ,[Createdate]";
            Sqlcmd += " ,[CreateBy] )";
            Sqlcmd += "  VALUES (";
            Sqlcmd += "'" + id + "'";
            Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "firstnameth") + "'";
            Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "lastnameth") + "'";
            Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "newempno") + "'";
            Sqlcmd += ",'0'";
            Sqlcmd += ",getdate()";
            Sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            Sqlcmd += "  ) ";
            Arrcmd.Add(Sqlcmd);



            cn.Execute(Arrcmd, null);
            Obj.Userid = id;
            Obj.Error = "";
            return Obj;
        }
        [WebMethod]
        public static string GettitleEN(string json)
        {
            if (json == "" || json == "null")
            {
                return "";
            }
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select titlenameEN from Sys_Master_title where isdelete = 0 and id='" + json + "'";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count > 0)
            {
                return Dt.Rows[0][0].ToString();
            }
            else
            {
                return "";
            }
           
        }
        [WebMethod]
        public static List<ClsDict> Getparttime(string json)
        {
            int i = 0;
            int j = 0;
            string val = "";
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);

            for(i=0;i<=23;i++)
            {
                for (j = 0;j< 60; j+=15)
                {
                    val = i.ToString().PadLeft(2, '0') + ":" + j.ToString().PadLeft(2, '0');
                    Objdict = new ClsDict();
                    Objdict.Name = val;
                    Objdict.Val = val;
                    Dicts.Add(Objdict);
                }
            }
            return Dicts;
        }


        [WebMethod]
        public static List<ClsDict> Getdelegate(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select userid,Empno + ' - ' + FirstnameTH + ' ' + LastnameTH as Fullname from Sys_HR_Empdetail Where userid <> '" + ClsEngine.FindValue(ClsEngine.DeSerialized(json,':','|'), "Hdempid") + "' Order by Empno ";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["Fullname"].ToString();
                Objdict.Val = dr["userid"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getsubdistrict(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_SubDistrict where isdelete = 0 and Districtid = '" + json + "' Order by SubDistrictnameth ";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["Subdistrictnameth"].ToString();
                Objdict.Val = dr["Subdistrictid"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        
        [WebMethod]
        public static List<ClsDict> Getpostcode(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_Postcode where isdelete = 0 and Subdistrictid = '" + json + "' Order by Postcode ";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["Postcode"].ToString();
                Objdict.Val = dr["Postcodeid"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getdistrict(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_District where isdelete = 0 and ProvinceID = '"  + json + "' Order by Districtnameth ";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["Districtnameth"].ToString();
                Objdict.Val = dr["Districtid"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }

        [WebMethod]
        public static List<ClsDict> Gettitle(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,titlenameTH from Sys_Master_title where isdelete = 0 order by titlenameTH";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["titlenameTH"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getprovince(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select Provinceid,provincenameTH from Sys_Master_province where isdelete = 0 order by provincenameTH";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["provincenameTH"].ToString();
                Objdict.Val = dr["Provinceid"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getreligion(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,religionname from Sys_Master_religion where isdelete = 0 order by religionname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["religionname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> GetMaryStatus(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,MaryStatusname from Sys_Master_MaryStatus where isdelete = 0 order by MaryStatusname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["Marystatusname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getnation(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,nationname from Sys_Master_nation where isdelete = 0 order by nationname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["nationname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getlineofjobposition(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,lineofjobpositionname from Sys_Master_lineofjobposition where isdelete = 0 order by lineofjobpositionname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["lineofjobpositionname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getmanagementposition(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,managementpositionname from Sys_Master_managementposition where isdelete = 0 order by managementpositionname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["managementpositionname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getemploytype(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,employtypename from Sys_Master_employtype where isdelete = 0 order by employtypename";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["employtypename"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getcurrentstatus(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,currentstatusname from Sys_Master_currentstatus where isdelete = 0 order by currentstatusname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["currentstatusname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getfield(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,fieldname from Sys_Master_field where isdelete = 0 order by fieldname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["fieldname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getrace(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,racename from Sys_Master_race where isdelete = 0 order by racename";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["racename"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getgender(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,gendername from Sys_Master_gender where isdelete = 0 order by gendername";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["gendername"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getblood(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,bloodname from Sys_Master_blood where isdelete = 0 order by bloodname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["bloodname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getacademicposition(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,academicposition from Sys_Master_academicposition where isdelete = 0 order by academicposition";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["academicposition"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static string Deleteuser(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring,"");
            ArrayList Arrcmd = new ArrayList();
            string userid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "x");
            string sqlcmd = "";
            sqlcmd = "Update Sys_Core_User set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + userid + "'";
            Arrcmd.Add(sqlcmd);
            sqlcmd = "Update Sys_Core_Userprofile set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where userid='" + userid + "'";
            Arrcmd.Add(sqlcmd);
            cn.Execute(Arrcmd,null);
            return "";
        }



        [WebMethod]
        public static string Validateusername(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from sys_core_user where isdelete = 0 and username ='" + json + "'";
            if (cn.Select(sqlcmd).Rows.Count == 0)
            {
                return "";
            }
            else
            {
                return "Username " + json + " ได้มีการใช้งานไปแล้ว โปรดใช้ Username อื่น ";
            }
        }
        [WebMethod]
        public static ClsEmpdetail Getempinfo(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_HR_Empdetail E inner join Sys_Core_User u on e.userid = u.id where e.isdelete = 0 and u.isdelete = 0  and u.id ='" + json + "'";
            Dt = cn.Select(sqlcmd);
            ClsEmpdetail Obj = new ClsEmpdetail();
            if (Dt.Rows.Count == 0)
            {
                Obj.Error = "";
                return Obj;
            }
            else
            {


                Obj.Error = "";

                Obj.InsRegular = Dt.Rows[0]["InsRegular"].ToString();
                Obj.InsTheory = Dt.Rows[0]["InsTheory"].ToString();
                Obj.InsExtra = Dt.Rows[0]["InsExtra"].ToString();

                Obj.Username = Dt.Rows[0]["Username"].ToString();
                Obj.Mymobile = Dt.Rows[0]["Mymobile"].ToString();
                Obj.Empno= Dt.Rows[0]["Empno"].ToString();
                if (Dt.Rows[0]["Startemploydate"].ToString() == "")
                {
                    Obj.Startemploydate = "";
                }
                else
                {
                    Obj.Startemploydate = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Startemploydate"].ToString()));
                }

                Obj.Academicpositionid= Dt.Rows[0]["Academicpositionid"].ToString();
                Obj.Imgempprofile= Dt.Rows[0]["Imgempprofile"].ToString();
                Obj.Attachmentid = Dt.Rows[0]["Attachmentid"].ToString();
                Obj.FirstnameTH= Dt.Rows[0]["FirstnameTH"].ToString();
                Obj.LastnameTH= Dt.Rows[0]["LastnameTH"].ToString();
                Obj.FirstnameEN= Dt.Rows[0]["FirstnameEN"].ToString();
                Obj.LastnameEN= Dt.Rows[0]["LastnameEN"].ToString();
                Obj.Genderid= Dt.Rows[0]["Genderid"].ToString();
                if (Dt.Rows[0]["Birthdate"].ToString() == "")
                {
                    Obj.Birthdate = "";
                }
                else
                {
                    Obj.Birthdate = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Birthdate"].ToString()));
                }
                Obj.Titleid = Dt.Rows[0]["Titleid"].ToString();
                Obj.Height= Dt.Rows[0]["Height"].ToString();
                Obj.Weight= Dt.Rows[0]["Weight"].ToString();
                Obj.Provinceid= Dt.Rows[0]["Provinceid"].ToString();
                Obj.Bloodid= Dt.Rows[0]["Bloodid"].ToString();
                Obj.Religionid= Dt.Rows[0]["Religionid"].ToString();
                Obj.Raceid= Dt.Rows[0]["Raceid"].ToString();
                Obj.Nationid= Dt.Rows[0]["Nationid"].ToString();
                Obj.Marystatusid = Dt.Rows[0]["Marystatusid"].ToString();
                Obj.Cardid= Dt.Rows[0]["Cardid"].ToString();
                Obj.Taxno= Dt.Rows[0]["Taxno"].ToString();
                Obj.Accountno= Dt.Rows[0]["Accountno"].ToString();
                Obj.Email= Dt.Rows[0]["Email"].ToString();
                Obj.Website= Dt.Rows[0]["Website"].ToString();
                Obj.Interest= Dt.Rows[0]["Interest"].ToString();
                Obj.Motto= Dt.Rows[0]["Motto"].ToString();
                Obj.Facebook= Dt.Rows[0]["Facebook"].ToString();
                if (Dt.Rows[0]["PensionDate"].ToString() == "")
                {
                    Obj.PensionDate = "";
                }
                else
                {
                    Obj.PensionDate = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["PensionDate"].ToString()));
                }
                Obj.Cooperative= Dt.Rows[0]["Cooperative"].ToString();
                Obj.AccountnoGHB= Dt.Rows[0]["AccountnoGHB"].ToString();
                Obj.AccountnoGH= Dt.Rows[0]["AccountnoGH"].ToString();
                Obj.Welfareshop= Dt.Rows[0]["Welfareshop"].ToString();
                Obj.Cremation= Dt.Rows[0]["Cremation"].ToString();
                Obj.Providentfund= Dt.Rows[0]["Providentfund"].ToString();
                Obj.Socialsecurity= Dt.Rows[0]["Socialsecurity"].ToString();
                Obj.Homephone= Dt.Rows[0]["Homephone"].ToString();
                Obj.Workphone= Dt.Rows[0]["Workphone"].ToString();
                Obj.Mobile= Dt.Rows[0]["Mobile"].ToString();
                Obj.Internalphone= Dt.Rows[0]["Internalphone"].ToString();
                return Obj;

            }
           
        }
        [WebMethod]
        public static string Resetpass(string json)
        {
            SVFrameWork.Security Utility = new SVFrameWork.Security();
            SqlConnector cn = new SqlConnector(Connectionstring,"");
            string userid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "x");
            string sqlcmd = "";
            string privatekey = cn.Select("Select ConfigurationValue from Sys_Conf_Configuration where IsDelete =0  and ConfigurationName = 'Privatekey'").Rows[0][0].ToString();
            string newpassword = ClsEngine.Encrypt("p@ssw0rd", privatekey);
            sqlcmd = "Update Sys_Core_User set password ='" + newpassword + "',modifydate=getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + userid + "'";
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
            DataTable Dtemp = new DataTable();
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_Core_User u inner join Sys_Core_Userprofile up on u.Id = up.Userid where u.isdelete =0  and up.isdelete = 0 order by id ";
            Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            sqlcmd = "Select * from Sys_HR_Empdetail where isdelete = 0";
            Dtemp = cn.Select(sqlcmd);

            foreach (DataRow dr in Dt.Rows)
            {
                Objuser = new Clsuser();
                Objuser = JsonConvert.DeserializeObject<Clsuser>(dr["Json"].ToString());
                Objuser.userid = dr["Userid"].ToString();
                Objuser.avartarurl = Dtemp.Select("Userid = '" + Objuser.userid + "'")[0]["Imgempprofile"].ToString();
                Objuser.username = dr["Username"].ToString();
                Objuser.Empno = Dtemp.Select("Userid = '" + Objuser.userid + "'")[0]["Empno"].ToString();
                Objuser.email = Dtemp.Select("Userid = '" + Objuser.userid + "'")[0]["email"].ToString();
                Objuser.Mymobile = Dtemp.Select("Userid = '" + Objuser.userid + "'")[0]["Mymobile"].ToString();
                Users.Add(Objuser);

            }
            if (Searchkwd != "")
            {
                return Users.FindAll(x => x.firstnameth.Contains(Searchkwd)
                    || x.lastnameth.Contains(Searchkwd)
                    || x.email.Contains(Searchkwd)
                    || x.tel.Contains(Searchkwd)
                    || x.Empno.Contains(Searchkwd)
                    || x.Mymobile.Contains(Searchkwd)
                );

            }
            else
            {
                return Users;
            }


        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["ObjGrid"] == null)
            {
                ClsGrid Objgrid = new ClsGrid();
                HttpContext.Current.Session["ObjGrid"] = Objgrid;
            }
        }
        #region "Grid"
        
        [WebMethod]
        public static string ExecuteDeleteGrid(string Ctrl, string PK)
        {
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            List<ClsDict> Dats = new List<ClsDict>();
            Dats = ClsEngine.DeSerialized(PK, ':', '|'); //Data for Delete key:Value|

            if (Ctrl == "Gvleavedetail")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_Leave_Empleave] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvexpertise")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_HR_expertise] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvpromote")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_HR_promote] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gveducation")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_HR_Education] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvprofession")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_HR_profession] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvprofessioncouncil")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_HR_professioncouncil] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "Gvinsignia")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_HR_insignia] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
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
            List<ClsDict> CriterialMapping = new List<ClsDict>();
            ClsGrid Objgrid = new ClsGrid();
            Clsuser Objmy = (Clsuser)HttpContext.Current.Session["My"];

            if (Ctrl == "Gvleavedetail")
            {
                string id = "";
                PK = "id";
                Sqlcmd = " Select el.id,Leavesubject,convert(nvarchar,Startleave,103)  + ' - ' + convert(nvarchar,Stopleave,103)   as Fulldate,isnull(Status,'') as Status ";
                Sqlcmd += " ,convert(nvarchar,Partleave,103)  + ' ( ' + isnull(Partstarttime, '') + ' - ' +  isnull(Partstoptime, '') + ' ) ' as Partdate,Leavedesc  ";
                Sqlcmd += " ,isnull(u.firstnameth,'') + ' ' + isnull(u.lastnameth,'') as fullname ";
                Sqlcmd += " from[Sys_Leave_Empleave] EL ";
                Sqlcmd += " left join Sys_HR_Empdetail u on EL.Delegateid = u.userid where el.isdelete = 0 and Leavetypeid = '" + Criteria.Split('|')[1] + "'";
                Sqlcmd += " and el.userid= '" + Criteria.Split('|')[0] + "' and u.isdelete = 0";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);

                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        id = ((DataTable)HttpContext.Current.Session["RAW_Gvleavedetail"]).Rows[i]["id"].ToString();
                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {

                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Status".ToLower())
                            {
                                if (ObjGridResponse.ResData[i][j].Val.ToUpper() == "")
                                {
                                    ObjGridResponse.ResData[i][j].Val = "รอตรวจสอบ";
                                }
                                else if (ObjGridResponse.ResData[i][j].Val.ToUpper() == "V")
                                {
                                    ObjGridResponse.ResData[i][j].Val = "รออนุมัติ";
                                }
                                else if (ObjGridResponse.ResData[i][j].Val.ToUpper() == "A")
                                {
                                    ObjGridResponse.ResData[i][j].Val = "อนุมัติแล้ว";
                                }
                                else if (ObjGridResponse.ResData[i][j].Val.ToUpper() == "C")
                                {
                                    ObjGridResponse.ResData[i][j].Val = "ไม่ลงนาม/อนุมัติ";
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
            else if (Ctrl == "Gveducation")
            {
                PK = "id";
                Sqlcmd = " select hr.id as id,Degreename,Educationname,Majorname,CASE WHEN [EducationStart] IS NULL THEN '' ELSE convert(nvarchar,isnull([EducationStart],''),103)  END  + ' '  + CASE WHEN [EducationEnd] IS NULL THEN '' ELSE convert(nvarchar,isnull([EducationEnd],''),103)  END  as Educationperiod,Academyname";
                Sqlcmd += " from Sys_HR_Education hr";
                Sqlcmd += " left";
                Sqlcmd += " join Sys_Master_Education e on hr.Educationid = e.Id";
                Sqlcmd += " left";
                Sqlcmd += " join Sys_Master_Degree d on hr.Degreeid = d.Id";
                Sqlcmd += " left";
                Sqlcmd += " join Sys_Master_Major m on hr.Majorid = m.Id";
                Sqlcmd += " left";
                Sqlcmd += " join Sys_Master_Academy a on hr.Academyid = a.Id ";
                Sqlcmd += " Where Hr.userid= '" + Criteria + "' and hr.isdelete = 0";
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
            else if (Ctrl == "Gvexpertise")
            {
                PK = "id";
                Sqlcmd = " select hr.id as id,topic,remark ";
                Sqlcmd += " from Sys_HR_expertise hr";
                Sqlcmd += " Where hr.userid= '" + Criteria + "' and hr.isdelete = 0";
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
            else if (Ctrl == "Gvprofession")
            {
                PK = "id";
                Sqlcmd = " select hr.id as id,professionname,professionNo,CASE WHEN [professionstart] IS NULL THEN '' ELSE convert(nvarchar,isnull([professionstart],''),103)  END  as professionstart,CASE WHEN [professionend] IS NULL THEN '' ELSE convert(nvarchar,isnull([professionend],''),103)  END   as professionend";
                Sqlcmd += " from Sys_HR_profession hr";
                Sqlcmd += " left";
                Sqlcmd += " join Sys_Master_profession p on hr.professionid = p.id ";
                Sqlcmd += " Where hr.userid= '" + Criteria + "' and hr.isdelete = 0";
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
            else if (Ctrl == "Gvprofessioncouncil")
            {
                PK = "id";
                Sqlcmd = " select hr.id as id,professionname as  professioncouncilname,professioncouncilNo,CASE WHEN [professioncouncilstart] IS NULL THEN '' ELSE convert(nvarchar,isnull([professioncouncilstart],''),103)  END  as professioncouncilstart,CASE WHEN [professioncouncilend] IS NULL THEN '' ELSE convert(nvarchar,isnull([professioncouncilend],''),103)  END  as professioncouncilend";
                Sqlcmd += " from Sys_HR_professioncouncil hr";
                Sqlcmd += " left";
                Sqlcmd += " join Sys_Master_profession p on hr.professioncouncilid = p.id ";
                Sqlcmd += " Where hr.userid= '" + Criteria + "' and hr.isdelete = 0";
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
            else if (Ctrl == "Gvpromote")
            {
                PK = "id";
                Sqlcmd = " select Convert(nvarchar,Effectdate,103) as Effectdate,* from Sys_HR_Promote hr ";
                Sqlcmd += " Where hr.userid= '" + Criteria + "' and hr.isdelete = 0";
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
            else if (Ctrl == "Gvinsignia")
            {
                PK = "id";
                Sqlcmd = " select hr.id as id,Insignianame,Bookno,Pageno,Orderno,Paragraphno,Yearno, CASE WHEN [AnounceDate] IS NULL THEN '' ELSE convert(nvarchar,isnull([AnounceDate],''),103)  END  as AnounceDate";
                Sqlcmd += " from Sys_HR_Insignia hr";
                Sqlcmd += " left";
                Sqlcmd += " join Sys_Master_Insignia p on hr.Insigniaid = p.id ";
                Sqlcmd += " Where hr.userid= '" + Criteria + "' and hr.isdelete = 0";
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