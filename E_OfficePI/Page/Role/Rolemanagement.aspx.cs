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
using Newtonsoft.Json;
namespace E_OfficePI.Page.Role
{
    public partial class Rolemanagement : System.Web.UI.Page
    {
        private static string Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["ObjGrid"] == null)
            {
                ClsGrid Objgrid = new ClsGrid();
                HttpContext.Current.Session["ObjGrid"] = Objgrid;
            }
        }
        [WebMethod]
        public static ClsRole RoleUserInfo(string id)
        {
            ClsRole Obj = new ClsRole();
            List<Clsuser> Users = new List<Clsuser>();
            Clsuser Objuser;
            DataTable Dt = new DataTable();
            SqlConnector cn = new SqlConnector(Connectionstring, "");
            string sqlcmd = "Select * from Sys_Master_Role r left join Sys_Master_Roleuser ru on r.id = ru.roleid and ru.isdelete = 0 left join Sys_Core_Userprofile u on ru.userid = u.UserId and u.isdelete = 0 where r.isdelete= 0  and r.id ='" + id + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count > 0)
            {
                Obj.Roleid = Dt.Rows[0]["id"].ToString();
                Obj.Rolename = Dt.Rows[0]["rolename"].ToString();
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
                Obj.Roleid = "";
                Obj.Rolename = "";
            }
            Obj.Users = Users;
            return Obj;

        }
        [WebMethod]
        public static string Deluserfromrole(string json)
        {
            //json = 'userid :' + userid + '|';
            //json += 'orgid :' + orgid + '|';
            string userid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "userid");
            string roleid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "roleid");
            SqlConnector cn = new SqlConnector(Connectionstring, "");
            string sqlcmd = "";
            sqlcmd = " Update [Sys_Master_Roleuser] ";
            sqlcmd += " Set Isdelete = 1,deletedate=getdate(),deleteby ='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += " Where Userid ='" + userid + "' and Roleid ='" + roleid + "'";
            cn.Execute(sqlcmd, null);
            return "";

        }
        [WebMethod]
        public static string Getrolename(string RoleId)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            try
            {
                return cn.Select("Select * from sys_master_role where id = '" + RoleId + "'").Rows[0]["Rolename"].ToString();
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
        public static string View(string Ctrl, string check, string RoleId)
        {
            string[] Name;
            SqlConnector Cn = new SqlConnector(Connectionstring, null);

            DataTable DtCheck = new DataTable();
            Name = Ctrl.Split('_');
            string sqlcmd = "";
            if (Name[0] == "ChkCtrlView")
            {
                sqlcmd = "insert Sys_Admin_PageElement (Functionid, RoleId,PageId,PageKey, ElementId,ElementName,ElementRemark,ElementType,ElementControl,createdate,createby,isdelete )";
                sqlcmd += " select Functionid,'" + RoleId + "' as RoleId, PageId ,PageKey,ElementId,ElementName,ElementRemark,ElementType,ElementControl,getdate(),'" + ((Clsuser)HttpContext.Current.Session["My"]).username + "',0";
                sqlcmd += " from Sys_Admin_PageElementTemplate";
                sqlcmd += " Where   ElementId = '" + Name[1] + "' and isdelete = 0";
                sqlcmd += " and ElementId not in (select  ElementId from Sys_Admin_PageElement  Where  RoleId = '" + RoleId + "' and  ElementId = '" + Name[1] + "' and isdelete = 0 )"; ;
                Cn.Execute(sqlcmd, null);
                if (check == "true")
                {
                    sqlcmd = "Update Sys_Admin_PageElement Set IsView  = '1',ModifyDate = Getdate() ,ModifyBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).username + "'  Where RoleId = '" + RoleId + "' and  ElementId = '" + Name[1] + "' and isdelete = 0";
                }
                else
                {
                    sqlcmd = "Update Sys_Admin_PageElement Set IsView  = '0',ModifyDate = Getdate() ,ModifyBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'  Where RoleId = '" + RoleId + "' and  ElementId = '" + Name[1] + "' and isdelete = 0";
                }
            }
            else if (Name[0] == "ChkFuncView")
            {
                sqlcmd = "insert Sys_Admin_PageElement (Functionid, RoleId,PageId,PageKey, ElementId,ElementName,ElementRemark,ElementType,ElementControl,createdate,createby,isdelete )";
                sqlcmd += " select Functionid,'" + RoleId + "' as RoleId, PageId ,PageKey,ElementId,ElementName,ElementRemark,ElementType,ElementControl,getdate(),'" + ((Clsuser)HttpContext.Current.Session["My"]).username + "',0";
                sqlcmd += " from Sys_Admin_PageElementTemplate";
                sqlcmd += " Where  FunctionId = '" + Name[1] + "' and isdelete = 0";
                sqlcmd += " and ElementId not in (select  ElementId from Sys_Admin_PageElement  Where  RoleId = '" + RoleId + "' and  FunctionId = '" + Name[1] + "' and isdelete = 0)";
                Cn.Execute(sqlcmd, null);
                if (check == "true")
                {
                    sqlcmd = "Update Sys_Admin_PageElement Set IsView  = '1',ModifyDate = Getdate() ,ModifyBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).username + "'  Where RoleId = '" + RoleId + "' and FunctionId = '" + Name[1] + "' and isdelete = 0";
                }
                else
                {
                    sqlcmd = "Update Sys_Admin_PageElement Set IsView  = '0',ModifyDate = Getdate() ,ModifyBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).username + "'  Where RoleId = '" + RoleId + "' and  FunctionId = '" + Name[1] + "' and isdelete = 0";
                }
            }
            else if (Name[0] == "ChkView")
            {
                sqlcmd = "insert Sys_Admin_PageElement (Functionid, RoleId,PageId,PageKey, ElementId,ElementName,ElementRemark,ElementType,ElementControl,createdate,createby,isdelete )";
                sqlcmd += " select Functionid,'" + RoleId + "' as RoleId, PageId ,PageKey,ElementId,ElementName,ElementRemark,ElementType,ElementControl,getdate(),'" + ((Clsuser)HttpContext.Current.Session["My"]).username + "',0";
                sqlcmd += " from Sys_Admin_PageElementTemplate";
                sqlcmd += " Where  PageId = '" + Name[1] + "' and isdelete = 0";
                sqlcmd += " and ElementId not in (select  ElementId from Sys_Admin_PageElement  Where  RoleId = '" + RoleId + "' and  PageId = '" + Name[1] + "' and isdelete = 0)";
                Cn.Execute(sqlcmd, null);
                if (check == "true")
                {
                    sqlcmd = "Update Sys_Admin_PageElement Set IsView  = '1',ModifyDate = Getdate() ,ModifyBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).username + "'  Where PageId = '" + Name[1] + "' and RoleId = '" + RoleId + "' and isdelete = 0";
                }
                else
                {
                    sqlcmd = "Update Sys_Admin_PageElement Set IsView  = '0',ModifyDate = Getdate() ,ModifyBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).username + "'  Where PageId = '" + Name[1] + "' and RoleId = '" + RoleId + "' and isdelete = 0";
                }
            }
            Cn.Execute(sqlcmd, null);
            Cn.Close();
            return "";
        }
        [WebMethod]
        public static string Edit(string Ctrl, string check, string RoleId)
        {
            string[] Name;
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            Name = Ctrl.Split('_');
            if (Name[0] == "ChkCtrlEdit")
            {
                sqlcmd = "insert Sys_Admin_PageElement (Functionid, RoleId,PageId,PageKey, ElementId,ElementName,ElementRemark,ElementType,ElementControl,createdate,createby,isdelete )";
                sqlcmd += " select Functionid,'" + RoleId + "' as RoleId, PageId ,PageKey,ElementId,ElementName,ElementRemark,ElementType,ElementControl,getdate(),'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "',0";
                sqlcmd += " from Sys_Admin_PageElementTemplate";
                sqlcmd += " Where  PageId = '" + Name[1] + "' and isdelete = 0";
                sqlcmd += " and ElementId not in (select  ElementId from Sys_Admin_PageElement  Where  RoleId = '" + RoleId + "' and  ElementId = '" + Name[1] + "' and isdelete = 0)";
                Cn.Execute(sqlcmd, null);
                if (check == "true")
                {
                    sqlcmd = "Update Sys_Admin_PageElement Set IsEdit  = '1',ModifyDate = Getdate() ,ModifyBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'  Where RoleId = '" + RoleId + "' and  ElementId = '" + Name[1] + "' and isdelete = 0";
                }
                else
                {
                    sqlcmd = "Update Sys_Admin_PageElement Set IsEdit  = '0',ModifyDate = Getdate() ,ModifyBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'  Where RoleId = '" + RoleId + "' and  ElementId = '" + Name[1] + "' and isdelete = 0";
                }
            }
            else if (Name[0] == "ChkFuncEdit")
            {
                sqlcmd = "insert Sys_Admin_PageElement (Functionid, RoleId,PageId,PageKey, ElementId,ElementName,ElementRemark,ElementType,ElementControl,createdate,createby,isdelete )";
                sqlcmd += " select Functionid,'" + RoleId + "' as RoleId, PageId ,PageKey,ElementId,ElementName,ElementRemark,ElementType,ElementControl,getdate(),'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "',0";
                sqlcmd += " from Sys_Admin_PageElementTemplate";
                sqlcmd += " Where  FunctionId = '" + Name[1] + "' and isdelete = 0";
                sqlcmd += " and ElementId not in (select  ElementId from Sys_Admin_PageElement  Where  RoleId = '" + RoleId + "' and  FunctionId = '" + Name[1] + "' and isdelete = 0)";
                Cn.Execute(sqlcmd, null);
                if (check == "true")
                {
                    sqlcmd = "Update Sys_Admin_PageElement Set IsEdit  = '1',ModifyDate = Getdate() ,ModifyBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'  Where RoleId = '" + RoleId + "' and  FunctionId = '" + Name[1] + "' and isdelete = 0";
                }
                else
                {
                    sqlcmd = "Update Sys_Admin_PageElement Set IsEdit  = '0',ModifyDate = Getdate() ,ModifyBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'  Where RoleId = '" + RoleId + "' and  FunctionId = '" + Name[1] + "' and isdelete = 0";
                }
            }
            else if (Name[0] == "ChkEdit")
            {
                sqlcmd = "insert Sys_Admin_PageElement (Functionid, RoleId,PageId,PageKey, ElementId,ElementName,ElementRemark,ElementType,ElementControl,createdate,createby,isdelete )";
                sqlcmd += " select Functionid,'" + RoleId + "' as RoleId, PageId ,PageKey,ElementId,ElementName,ElementRemark,ElementType,ElementControl,getdate(),'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "',0";
                sqlcmd += " from Sys_Admin_PageElementTemplate";
                sqlcmd += " Where  PageId = '" + Name[1] + "' and isdelete = 0";
                sqlcmd += " and ElementId not in (select  ElementId from Sys_Admin_PageElement  Where  RoleId = '" + RoleId + "' and  PageId = '" + Name[1] + "' and isdelete = 0)";
                Cn.Execute(sqlcmd, null);
                if (check == "true")
                {
                    sqlcmd = "Update Sys_Admin_PageElement Set IsEdit  = '1',ModifyDate = Getdate() ,ModifyBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'  Where PageId = '" + Name[1] + "' and RoleId = '" + RoleId + "' and isdelete = 0";
                }
                else
                {
                    sqlcmd = "Update Sys_Admin_PageElement Set IsEdit  = '0',ModifyDate = Getdate() ,ModifyBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'  Where PageId = '" + Name[1] + "' and RoleId = '" + RoleId + "' and isdelete = 0";
                }
            }
            Cn.Execute(sqlcmd, null);
            Cn.Close();
            return "";
        }
        [WebMethod]
        public static List<ClsSecurEntity> LoadElementInfo(string PageKey, string FunctionId, string RoleId)
        {
            ClsSecurEntity Obj = new ClsSecurEntity();
            List<ClsSecurEntity> EntityPermissions = new List<ClsSecurEntity>();
            SqlConnector Cn = new SqlConnector(Connectionstring,"");
            string sqlcmd = "select pe.ElementId ,pe.ElementName,pe.ElementType,pe.ElementRemark ,isnull(pet.Isview,0) as Isview ,isnull(pet.IsEdit,0) as IsEdit from sys_admin_PageFunction PF Right join Sys_Admin_PageElementTemplate pe on pe.Functionid = pf.Functionid  and pe.IsDelete = '0' left join  Sys_Admin_PageElement pet on pet.ElementId = pe.ElementId and pet.IsDelete = '0' and pet.RoleId = '" + RoleId + "'   where pf.isdelete = 0  and pf.pagekey ='" + PageKey + "' and pf.FunctionId = '" + FunctionId + "'";
            DataTable Dt = new DataTable();
            Dt = Cn.Select(sqlcmd);
            Cn.Close();
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsSecurEntity();
                Obj.ElementId = dr["ElementId"].ToString();
                Obj.ElementName = dr["ElementName"].ToString();
                Obj.ElementType = dr["ElementType"].ToString();
                Obj.ElementRemark = dr["ElementRemark"].ToString();
                Obj.View = dr["Isview"].ToString();
                Obj.Edit = dr["IsEdit"].ToString();
                EntityPermissions.Add(Obj);
            }
            return EntityPermissions;
        }
        [WebMethod]
        public static List<ClsSecurEntity> LoadFunction(string PageId, string PageKey, string RoleId)
        {
            ClsSecurEntity Obj = new ClsSecurEntity();
            List<ClsSecurEntity> EntityPermissions = new List<ClsSecurEntity>();
            SqlConnector Cn = new SqlConnector(Connectionstring, "");
            //string sqlcmd = "Select case when isnull(IsView,0) = 0 then 0 else 1  end  as IsView   , case when isnull(IsEdit,0) = 0 then 0 else 1  end  as IsEdit, p.*,pf.* from sys_admin_pages p left join sys_admin_PageFunction PF on pf.Pageid = p.PageID left join (select sum(cast(IsView as int)) as IsView ,sum(cast(IsEdit as int))  as IsEdit ,Functionid,RoleId  from Sys_Admin_PageElement  where IsDelete = '0' and RoleId = '" + RoleId + "'   group by Functionid,RoleId) pe on pe.Functionid = pf.Functionid   where p.isdelete = 0 and isnull(IsPermissionPage,0) <> 0 and pf.pageid ='" + PageId + "' and PF.IsDelete = 0 ";
            //string sqlcmd = "Select * from sys_admin_pages p left join Sys_Admin_EntityPermission ep on p.PageID = ep.EntityId and ep.isdelete =  0 left join sys_admin_PageFunction PF on pf.Pageid = p.PageID where p.isdelete = 0 and isnull(PageURL,'') <> '' and pf.pageid ='" + PageId + "' and pf.RoleId = '" + RoleId + "'  and PF.IsDelete = 0 ";

            string sqlcmd = "Select * from Sys_Master_Function where pageid = '"+ PageId + "' and isdelete =0";
            DataTable Dt = new DataTable();
            Dt = Cn.Select(sqlcmd);
            Cn.Close();
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsSecurEntity();
                Obj.PageId = dr["PageId"].ToString();
                Obj.FunctionId = dr["id"].ToString();
                Obj.FunctionName = dr["FunctionNameTH"].ToString();
                Obj.Edit = dr["IsEdit"].ToString();
                Obj.View = dr["IsView"].ToString();
                EntityPermissions.Add(Obj);
            }
            return EntityPermissions;
        }
        [WebMethod]
        public static List<ClsSecurEntity> LoadEntity(string RoleId)
        {
            ClsSecurEntity Obj = new ClsSecurEntity();
            List<ClsSecurEntity> EntityPermissions = new List<ClsSecurEntity>();
            SqlConnector Cn = new SqlConnector(Connectionstring,"");
            string sqlcmd = "Select *  from sys_admin_pages p  ";
            //string sqlcmd = "Select isnull(IsView,0) as IsView ,isnull(IsEdit,0) as IsEdit, *  from sys_admin_pages p  left join Sys_Admin_EntityPermission ep on p.PageID = ep.EntityId and ep.isdelete =  0  left join ( select sum(cast(IsView as int)) as IsView ,sum(cast(IsEdit as int))  as IsEdit  ,RoleId  ,PageID from Sys_Admin_PageElement where IsDelete = '0' and RoleId = '" + RoleId + "' group by   RoleId  ,PageID  )FN on fn.PageID = p.PageID  inner join ( select  PageID from  Sys_Admin_PageElementTemplate  where IsDelete = '0'   group by    PageID  )FN1 on fn1.PageID = p.PageID   where p.isdelete = 0 and isnull(IsPermissionPage,0) <> 0 order by PageOrder ";
            DataTable Dt = new DataTable();
            Dt = Cn.Select(sqlcmd);
            Cn.Close();
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsSecurEntity();
                Obj.PageId = dr["PageId"].ToString();
                Obj.PageDescTH = dr["PageDescTH"].ToString();
                Obj.PageNameTH = dr["PageNameTH"].ToString();
                //Obj.Edit = dr["Editable"].ToString();
                //Obj.View = dr["Visible"].ToString();
                Obj.PageKey = "";
                Obj.View = "";
                Obj.Edit = "";
                EntityPermissions.Add(Obj);
            }
            return EntityPermissions;
        }
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
            if (Ctrl == "Gvrole")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_Master_Role] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id ='" + id + "'";
                Arrcmd.Add(sqlcmd);
                sqlcmd = "Update [Sys_Master_Roleuser] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where Roleid ='" + id + "'";
                Arrcmd.Add(sqlcmd);
                sqlcmd = "Update [Sys_Master_Rolefunction] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where Roleid ='" + id + "'";
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
        public static List<Clsuser> Getavailableuser(string json)
        {
            List<Clsuser> Objs = new List<Clsuser>();
            DataTable Dt = new DataTable();
            Clsuser Obj;
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "select hr.userid,FirstnameTH,LastnameTH,Imgempprofile  from Sys_HR_Empdetail hr where isdelete = 0 and userid not in (select userid from Sys_Master_Roleuser ru where isdelete = 0) and isdelete = 0  order by firstnameth,lastnameth ";
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new Clsuser();
                Obj.userid = dr["userid"].ToString();
                Obj.avartarurl = dr["Imgempprofile"].ToString();
                Obj.firstnameth = dr["firstnameth"].ToString();
                Obj.lastnameth = dr["lastnameth"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static string doAdduser2Org(string json)
        {
            //json = 'userid :' + userid + '|';
            //json += 'orgid :' + orgid + '|';

            string userid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "userid");
            string roleid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "roleid");
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            
            string sqlcmd = "";
            sqlcmd = " INSERT INTO [Sys_Master_roleuser] ";
            sqlcmd += " ([roleid]";
            sqlcmd += " ,[Userid]";
            sqlcmd += " ,[Isdelete]";
            sqlcmd += " ,[Createdate]";
            sqlcmd += " ,[CreateBy] ) ";
            sqlcmd += " Values( ";
            sqlcmd += "'" + roleid + "'";
            sqlcmd += ",'" + userid + "'";
            sqlcmd += ",'0'";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += "  ) ";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static List<Clsuser> Getuser(string json)
        {
            string Searchkwd = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtusersearch");
            string Roleid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Roleid");
            List<Clsuser> Users = new List<Clsuser>();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            Clsuser Objuser;

            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_Core_User u inner join Sys_Core_Userprofile up on u.Id = up.Userid where u.isdelete =0  and up.isdelete = 0 and u.id not in (select userid from Sys_Master_Roleuser where isdelete = 0 and roleid = '" + Roleid + "') order by id ";
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
        public static List<Clsuser> Getuserinrole(string json)
        {
            List<Clsuser> Objs = new List<Clsuser>();
            DataTable Dt = new DataTable();
            Clsuser Obj;
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select roleid,rolename,hr.userid,FirstnameTH,LastnameTH,Imgempprofile from Sys_Master_Roleuser ru inner join Sys_Master_Role r on r.id = ru.roleid inner join Sys_HR_Empdetail hr  on ru.userid = hr.userid  where roleid = '" + json + "'";
            Dt = cn.Select(sqlcmd);
            foreach(DataRow dr in Dt.Rows)
            {
                Obj = new Clsuser();
                Obj.userid = dr["userid"].ToString();
                Obj.avartarurl = dr["Imgempprofile"].ToString();
                Obj.firstnameth = dr["firstnameth"].ToString();
                Obj.lastnameth = dr["lastnameth"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
        }
        [WebMethod]
        public static ClsGridResponse Bind(string Ctrl, long PagePerItem, long CurrentPage, string SortName, string Order, string Column, string Data, string Initial, string SelectCat, string SearchMsg, string EditButton, string DeleteButton, string Panel, string FullRowSelect, string Multiselect, string Criteria, string SearchesDat, string Searchcolumns, string WPanel, string HPanel)
        {
            string Sqlcmd = "";
            string PK = "";
            string roleid = "";
            List<ClsDict> CriterialMapping = new List<ClsDict>();
            ClsGrid Objgrid = new ClsGrid();
            Clsuser Objmy = (Clsuser)HttpContext.Current.Session["My"];

            if (Ctrl == "Gvrole")
            {
                PK = "id";
                Sqlcmd = "Select id,Rolename,'' as Control from Sys_Master_Role Where isdelete = 0 ";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        roleid = ((DataTable)HttpContext.Current.Session["RAW_Gvrole"]).Rows[i]["id"].ToString();
                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {

                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Control".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;' onclick='Managerole(" + roleid +  ");'><i style='font-size:24px;' class=\"fa fa-cog fa-fw\" aria-hidden=\"true\"></i></a>";
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