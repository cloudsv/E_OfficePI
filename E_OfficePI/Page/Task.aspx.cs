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
namespace E_OfficePI.Page
{
    public partial class Task : System.Web.UI.Page
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
        public static ClsLeaveApprovedetail Leaveinfo(string json)
        {
            ClsLeaveApprovedetail Obj = new ClsLeaveApprovedetail();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            string sqlcmd = "Select *,Ed.FirstnameTH + ' '  + Ed.LastnameTH as Delegatename from Sys_Leave_Empleave EL left join Sys_HR_Empdetail Ed on Delegateid = Ed.userid where El.isdelete = 0 and EL.id  = '" + json + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count > 0)
            {
                Obj.Stopleave = Dt.Rows[0]["Stopleave"].ToString();
                Obj.Startleave = Dt.Rows[0]["Startleave"].ToString();
                Obj.Parttime = Dt.Rows[0]["Partstarttime"].ToString() + " " + Dt.Rows[0]["Partstoptime"].ToString();
                Obj.Partleave = Dt.Rows[0]["Partleave"].ToString();
                Obj.Leavetypeid = Dt.Rows[0]["Leavetypeid"].ToString();
                Obj.Leavesubject = Dt.Rows[0]["Leavesubject"].ToString();
                if (Obj.Leavetypeid == "1")
                {
                    Obj.Leavetype = "ลาป่วย";
                }
                else if (Obj.Leavetypeid == "2")
                {
                    Obj.Leavetype = "ลากิจ";
                }
                else if (Obj.Leavetypeid == "3")
                {
                    Obj.Leavetype = "ลาดคลอดบุตร";
                }
                else if (Obj.Leavetypeid == "4")
                {
                    Obj.Leavetype = "ลาพักผ่อน";
                }
                Obj.Leavecat = Dt.Rows[0]["Leavecat"].ToString();
                Obj.Leavedesc = Dt.Rows[0]["Leavedesc"].ToString();
                Obj.Delegate = Dt.Rows[0]["Delegatename"].ToString();
            }
            cn.Close();
            return Obj;
        }

        [WebMethod]
        public static string doApprove(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string status = cn.Select("select isnull(status,'') as status from [Sys_Leave_Empleave] where isdelete = 0 and id='" + json + "'").Rows[0][0].ToString();
            string nextstatus = "";
            if (status == "")
            {
                nextstatus = "V";
            }
            if (status == "V")
            {
                nextstatus = "A";
            }
            string sqlcmd = "Update Sys_Leave_Empleave set status ='" + nextstatus + "' where id='" + json + "'";
            cn.Execute(sqlcmd,null);
            cn.Close();
            return "";
        }
        [WebMethod]
        public static string doReject(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_Leave_Empleave set status ='C' where id='" + json + "'";
            cn.Execute(sqlcmd, null);
            cn.Close();
            return "";
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

            if (Ctrl == "Gvterm")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_Conf_Term] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "GvCourse")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update Sys_Master_MapCourse Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "GvPosition")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update  Sys_Master_AcademicPosition   Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "GvAcademy")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update  [dbo].[Sys_Master_Academy]   Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "GvLeaveType")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update   [Sys_Master_Leavetype]   Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "GvPositionJob")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update   [Sys_Master_Lineofjobposition]   Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "GvPositionMange")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update  [Sys_Master_ManagementPosition]   Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "GvMajor")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update   [Sys_Master_Major]   Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
                Arrcmd.Add(sqlcmd);
                Cn.Execute(Arrcmd, null);
            }
            else if (Ctrl == "GvBlood")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update   [Sys_Master_Blood]   Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + id + "'";
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
            string id = "";
            string Modulecode = "";
            List<ClsDict> CriterialMapping = new List<ClsDict>();
            ClsGrid Objgrid = new ClsGrid();
            Clsuser Objmy = (Clsuser)HttpContext.Current.Session["My"];

            if (Ctrl == "Gvtask")
            {
                string userid = ((Clsuser)HttpContext.Current.Session["My"]).userid;
                PK = "id";
                Sqlcmd = "select E.id as id,'LEAVE'  as Modulecode, 'อนุมัติการลา' as Module,Leavesubject as Subject,'' as detail  from Sys_Leave_Empleave E inner  join [Sys_Master_ApproveLeave] AL on E.Userid = AL.userid and (Validatoruserid = '" + userid +  "' or Approveruserid = '" + userid + "') and AL.IsDelete = 0 and E.isdelete = 0";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        id = ((DataTable)HttpContext.Current.Session["RAW_Gvtask"]).Rows[i]["id"].ToString();
                        Modulecode = ((DataTable)HttpContext.Current.Session["RAW_Gvtask"]).Rows[i]["Modulecode"].ToString();
                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {

                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "detail".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;' onclick=\"Approve('" + Modulecode + "','" + id + "');\">ดำเนินการอนุมัติ</a>";
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