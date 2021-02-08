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
namespace E_OfficePI.Page.TQF
{
    public partial class MasterPreInstructor : System.Web.UI.Page
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
        public static string Savetitle(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            try
            {
                sqlcmd = "Update Sys_Trans_PreInstuctorattachment set title = '" + ClsEngine.FindValue(Dicts, "val") + "' Where attachmentid='" + ClsEngine.FindValue(Dicts, "Attachmentid") + "'";
                cn.Execute(sqlcmd, null);
                
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
        public static string Delattachment(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Update Sys_Trans_PreInstuctorattachment set isdelete = 1,deletedate=getdate(),deleteby = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where attachmentid='" + json + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static ClsCallBackUpload CallBackUpload(string Ctrl, string RunningNo, string Userid)
        {
            ClsCallBackUpload ObjCallBack = new ClsCallBackUpload();
            DataTable Dt = new DataTable();
            SqlConnector _Cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Trans_Attachment Where Id ='" + RunningNo + "'";
            string id = "";
            try
            {
                if (Ctrl == "attachment")
                {
                    id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Trans_PreInstuctorattachment", "id");
                    sqlcmd = "  INSERT INTO [Sys_Trans_PreInstuctorattachment] ";
                    sqlcmd += "  ([id]";
                    sqlcmd += "  ,[userid]";
                    sqlcmd += "  ,[Attachmentid]";
                    sqlcmd += "  ,[IsDelete]";
                    sqlcmd += "  ,[CreateDate]";
                    sqlcmd += "  ,[CreateBy] ) ";
                    sqlcmd += " VALUES ( ";
                    sqlcmd += "'" + id + "'";
                    sqlcmd += ",'" + Userid + "'";
                    sqlcmd += ",'" + RunningNo + "'";
                    sqlcmd += ",'0'";
                    sqlcmd += ",getdate()";
                    sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                    _Cn.Execute(sqlcmd, null);

                }
      
                return ObjCallBack;
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
        public static string Gettitle(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Trans_PreInstuctorattachment where id = '" + json + "'";
            try
            {
                return cn.Select(sqlcmd).Rows[0]["title"].ToString();
            }
            catch
            {
                return "";
            }
            finally
            {
                cn.Close();
            }
        }

        [WebMethod]
        public static List<ClsDocumentAttachment> Getattachment(string json)
        {
            List<ClsDocumentAttachment> Objs = new List<ClsDocumentAttachment>();
            ClsDocumentAttachment Obj;
            DataTable Dt = new DataTable();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Select * from Sys_Trans_PreInstuctorattachment p inner join Sys_Trans_Attachment a on p.attachmentid = a.id where p.isdelete = 0 and userid = '" + json + "'";
            Dt = Cn.Select(sqlcmd);
            Cn.Close();
            foreach (DataRow pdr in Dt.Rows)
            {
                Obj = new ClsDocumentAttachment();
                if (pdr["Title"].ToString().Trim() == "")
                {
                    Obj.Title = "กรอกรายละเอียดไฟล์";
                }
                else
                {
                    Obj.Title = pdr["Title"].ToString().Trim();
                }
                Obj.Attachmentid = pdr["Attachmentid"].ToString();
                Obj.Filename = pdr["filename"].ToString();
                Obj.Url = new System.IO.FileInfo(pdr["Path"].ToString()).Name;
                Objs.Add(Obj);
            }
            return Objs;
        }


        [WebMethod]
        public static string Savepreinstuctor(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            if (ClsEngine.FindValue(Dicts, "Userid") == "")
            {
                sqlcmd = " INSERT INTO [Sys_Master_PreInstuctor] ";
                sqlcmd += " ([Userid]";
                sqlcmd += ",[Firstname]";
                sqlcmd += ",[Lastname]";
                if (ClsEngine.FindValue(Dicts, "Birthdate") != "")
                {
                    sqlcmd += ",[Birthdate]";
                }
                sqlcmd += ",[CardId]";
                sqlcmd += ",[Position]";
                sqlcmd += ",[Yearno]";
                sqlcmd += ",[Academy]";
                sqlcmd += ",[Address]";
                sqlcmd += ",[EducationBackground]";
                sqlcmd += ",[Experience]";
                sqlcmd += " ,[IsDelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += "  VALUES ( ";
                sqlcmd += "'" + ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_PreInstuctor", "Userid") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Firstname") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Lastname") + "'";
                if (ClsEngine.FindValue(Dicts, "Birthdate") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Birthdate"),'/') + "'";
                }
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CardId") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Position") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Yearno") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Academy") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Address") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "EducationBackground") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Experience") + "'";
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            else
            {
                sqlcmd = "   Update Sys_Master_PreInstuctor set ";
                sqlcmd += "[Firstname]  = '" + ClsEngine.FindValue(Dicts, "Firstname") + "'";
                sqlcmd += ",[Lastname]  = '" + ClsEngine.FindValue(Dicts, "Lastname") + "'";
                if (ClsEngine.FindValue(Dicts, "Birthdate") != "")
                {
                    sqlcmd += ",[Birthdate]  = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Birthdate"), '/') + "'";
                }
                sqlcmd += ",[CardId]  = '" + ClsEngine.FindValue(Dicts, "CardId") + "'";
                sqlcmd += ",[Position]  = '" + ClsEngine.FindValue(Dicts, "Position") + "'";
                sqlcmd += ",[Yearno]  = '" + ClsEngine.FindValue(Dicts, "Yearno") + "'";
                sqlcmd += ",[Academy]  = '" + ClsEngine.FindValue(Dicts, "Academy") + "'";

                sqlcmd += ",[Address]  = '" + ClsEngine.FindValue(Dicts, "Address") + "'";
                sqlcmd += ",[EducationBackground]  = '" + ClsEngine.FindValue(Dicts, "EducationBackground") + "'";
                sqlcmd += ",[Experience]  = '" + ClsEngine.FindValue(Dicts, "Experience") + "'";

               


                sqlcmd += "  ,[modifyDate] =  getdate()";
                sqlcmd += "  ,[modifyby] = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                sqlcmd += " Where [Userid] = '" + ClsEngine.FindValue(Dicts, "Userid") + "'";
                cn.Execute(sqlcmd, null);
            }
            return "";
        }
        [WebMethod]
        public static Clspreinstuctor Getpreinstuctorinfo(string json)
        {
            DataTable Dt = new DataTable();
            Clspreinstuctor Obj = new Clspreinstuctor();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = " select * from Sys_Master_PreInstuctor where isdelete =0 and  Userid = '" + json.Replace("userid:", "").Replace("|", "") + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count == 0)
            {
                Obj.Error = "ไม่สามารถดึงข้อมูลได้ โปรดติดต่อผู้ดูแลระบบ ";
            }
            else
            {
               
                Obj.Userid = Dt.Rows[0]["Userid"].ToString();

                Obj.Firstname = Dt.Rows[0]["Firstname"].ToString();
                Obj.Lastname = Dt.Rows[0]["Lastname"].ToString();

                if (Dt.Rows[0]["Birthdate"].ToString() != "")
                {
                    Obj.Birthdate = ClsEngine.Convertdate2ddmmyyyy(DateTime.Parse(Dt.Rows[0]["Birthdate"].ToString()), "/", true);
                }
                else
                {
                    Obj.Birthdate = "";
                }
                Obj.Cardid = Dt.Rows[0]["Cardid"].ToString();
                Obj.Position = Dt.Rows[0]["Position"].ToString();
                Obj.Yearno = Dt.Rows[0]["Yearno"].ToString();

                Obj.Academy = Dt.Rows[0]["Academy"].ToString();
                Obj.Address = Dt.Rows[0]["Address"].ToString();
                Obj.Educationbackground = Dt.Rows[0]["Educationbackground"].ToString();
                Obj.Experience = Dt.Rows[0]["Experience"].ToString();
                Obj.Error = "";

            }
            return Obj;
        }
        #region "Grid"
      
        [WebMethod]
        public static string ExecuteDeleteGrid(string Ctrl, string PK)
        {
            System.Collections.ArrayList Arrcmd = new System.Collections.ArrayList();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            List<ClsDict> Dats = new List<ClsDict>();
            Dats = ClsEngine.DeSerialized(PK, ':', '|'); //Data for Delete key:Value|

            if (Ctrl == "GvPreInstuctor")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "Userid");
                sqlcmd = "Update [Sys_Master_PreInstuctor] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where Userid='" + id + "'";
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
            if (Ctrl == "GvPreInstuctor")
            {
                PK = "userid";
                Sqlcmd = "Select userid,Firstname,Lastname,EducationBackground from [Sys_Master_PreInstuctor] where isdelete = 0  ";
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
