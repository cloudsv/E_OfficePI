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
namespace E_OfficePI.Page
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private static string Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static ClsDashboard Getdetail()
        {
            if (HttpContext.Current.Session["Dashboard"] == null)
            {
               return Getdashboard();
                
            }
            else
            {
                return (ClsDashboard)HttpContext.Current.Session["Dashboard"];
            }

        }
        [WebMethod]
        public static ClsDashboard Getdashboard()
        {
            ClsDashboard Obj = new ClsDashboard();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            string Sqlcmd = "";
            DataTable Dt = new DataTable();
            ClsDashboardSubject _ObjDashboardSubject;
            List<ClsDashboardSubject> DashboardSubjects = new List<ClsDashboardSubject>();
            ClsDashboardSubjectDraft DashboardSubjectDraft = new ClsDashboardSubjectDraft();
            ClsDashboardSubjectPending DashboardSubjectPending = new ClsDashboardSubjectPending();
            ClsDashboardSubjectCompleted DashboardSubjectCompleted = new ClsDashboardSubjectCompleted();
            ClsDashboardSubjectEdit DashboardSubjectEdit = new ClsDashboardSubjectEdit();
            int count = 0;
            int totalhours = 0;
            Sqlcmd = "Select Subjectcode,tqf.Subjectname,Cast(isnull(Theory,0) as int) + Cast(isnull(Practice,0) as int) as ResponsibilityHour from sys_tqf_tqf3 tqf left join Sys_Master_Subject s on tqf.Subjectid = s.id where tqf.CreateBy ='" +  ((Clsuser)HttpContext.Current.Session["My"]).userid + "' order by Subjectcode";
            Dt = Cn.Select(Sqlcmd);
            foreach(DataRow dr in Dt.Rows)
            {
                _ObjDashboardSubject = new ClsDashboardSubject();
                _ObjDashboardSubject.Subjectcode = dr["Subjectcode"].ToString();
                _ObjDashboardSubject.Subjectname = dr["Subjectname"].ToString();
                _ObjDashboardSubject.ResponsibilityHour = dr["ResponsibilityHour"].ToString();
                DashboardSubjects.Add(_ObjDashboardSubject);
                totalhours += int.Parse(_ObjDashboardSubject.ResponsibilityHour);
            }
            Obj.Fullname = ((Clsuser)HttpContext.Current.Session["My"]).firstnameth + " " + ((Clsuser)HttpContext.Current.Session["My"]).lastnameth;
            Obj.Subjects = DashboardSubjects;
            Obj.Totalhours = totalhours.ToString();
            //========================================= DRAFT  ============================== //
            Sqlcmd = "Select Subjectcode, tqf.Subjectname,Cast(isnull(Theory, 0) as int) + Cast(isnull(Practice, 0) as int) as Totalhours from sys_tqf_tqf3 tqf left join Sys_Master_Subject s on tqf.Subjectid = s.id where tqf.CreateBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid  + "' and[Status] = ''  order by Subjectcode";
            Dt = new DataTable();
            Dt = Cn.Select(Sqlcmd);
            count = 0;
            ClsDashboardSubjectStatus _ObjDashboardSubjectStatus_Drafts;
            List<ClsDashboardSubjectStatus> DashboardSubjectStatus_Drafts = new List<ClsDashboardSubjectStatus>();
            foreach (DataRow dr in Dt.Rows)
            {
                _ObjDashboardSubjectStatus_Drafts = new ClsDashboardSubjectStatus();
                _ObjDashboardSubjectStatus_Drafts.Subjectcode = dr["Subjectcode"].ToString();
                _ObjDashboardSubjectStatus_Drafts.Subjectname = dr["Subjectname"].ToString();
                _ObjDashboardSubjectStatus_Drafts.Status = "กำลังดำเนินการ";
                DashboardSubjectStatus_Drafts.Add(_ObjDashboardSubjectStatus_Drafts);
                count += 1;
            }
            DashboardSubjectDraft.Total = count.ToString();
            DashboardSubjectDraft.Subjectstatus = DashboardSubjectStatus_Drafts;
            Obj.DraftSubject = DashboardSubjectDraft;
            //========================================= DRAFT  ============================== //

            //========================================= Pending  ============================== //
            Sqlcmd = "Select Subjectcode, tqf.Subjectname,Cast(isnull(Theory, 0) as int) + Cast(isnull(Practice, 0) as int) as Totalhours from sys_tqf_tqf3 tqf left join Sys_Master_Subject s on tqf.Subjectid = s.id where tqf.CreateBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' and[Status] = 'V'  order by Subjectcode";
            Dt = new DataTable();
            Dt = Cn.Select(Sqlcmd);
            count = 0;
            ClsDashboardSubjectStatus _ObjDashboardSubjectStatus_Pendings;
            List<ClsDashboardSubjectStatus> DashboardSubjectStatus_Pendings = new List<ClsDashboardSubjectStatus>();
            foreach (DataRow dr in Dt.Rows)
            {
                _ObjDashboardSubjectStatus_Pendings = new ClsDashboardSubjectStatus();
                _ObjDashboardSubjectStatus_Pendings.Subjectcode = dr["Subjectcode"].ToString();
                _ObjDashboardSubjectStatus_Pendings.Subjectname = dr["Subjectname"].ToString();
                _ObjDashboardSubjectStatus_Pendings.Status = "รอตรวจ";
                DashboardSubjectStatus_Pendings.Add(_ObjDashboardSubjectStatus_Pendings);
                count += 1;
            }
            DashboardSubjectPending.Total = count.ToString();
            DashboardSubjectPending.Subjectstatus = DashboardSubjectStatus_Pendings;
            Obj.PendingSubject = DashboardSubjectPending;
            //========================================= Pending  ============================== //

            //========================================= Completed  ============================== //
            Sqlcmd = "Select Subjectcode, tqf.Subjectname,Cast(isnull(Theory, 0) as int) + Cast(isnull(Practice, 0) as int) as Totalhours from sys_tqf_tqf3 tqf left join Sys_Master_Subject s on tqf.Subjectid = s.id where tqf.CreateBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' and[Status] = 'A'  order by Subjectcode";
            Dt = new DataTable();
            Dt = Cn.Select(Sqlcmd);
            count = 0;
            ClsDashboardSubjectStatus _ObjDashboardSubjectStatus_Completeds;
            List<ClsDashboardSubjectStatus> DashboardSubjectStatus_Completeds = new List<ClsDashboardSubjectStatus>();
            foreach (DataRow dr in Dt.Rows)
            {
                _ObjDashboardSubjectStatus_Completeds = new ClsDashboardSubjectStatus();
                _ObjDashboardSubjectStatus_Completeds.Subjectcode = dr["Subjectcode"].ToString();
                _ObjDashboardSubjectStatus_Completeds.Subjectname = dr["Subjectname"].ToString();
                _ObjDashboardSubjectStatus_Completeds.Status = "ตรวจแล้ว";
                DashboardSubjectStatus_Completeds.Add(_ObjDashboardSubjectStatus_Completeds);
                count += 1;
            }
            DashboardSubjectCompleted.Total = count.ToString();
            DashboardSubjectCompleted.Subjectstatus = DashboardSubjectStatus_Completeds;
            Obj.CompletedSubject = DashboardSubjectCompleted;
            //========================================= Completed  ============================== //

            //========================================= Edit  ============================== //
            Sqlcmd = "Select Subjectcode, tqf.Subjectname,Cast(isnull(Theory, 0) as int) + Cast(isnull(Practice, 0) as int) as Totalhours from sys_tqf_tqf3 tqf left join Sys_Master_Subject s on tqf.Subjectid = s.id where tqf.CreateBy = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' and[Status] = 'W'  order by Subjectcode";
            Dt = new DataTable();
            Dt = Cn.Select(Sqlcmd);
            count = 0;
            ClsDashboardSubjectStatus _ObjDashboardSubjectStatus_Edits;
            List<ClsDashboardSubjectStatus> DashboardSubjectStatus_Edits = new List<ClsDashboardSubjectStatus>();
            foreach (DataRow dr in Dt.Rows)
            {
                _ObjDashboardSubjectStatus_Edits = new ClsDashboardSubjectStatus();
                _ObjDashboardSubjectStatus_Edits.Subjectcode = dr["Subjectcode"].ToString();
                _ObjDashboardSubjectStatus_Edits.Subjectname = dr["Subjectname"].ToString();
                _ObjDashboardSubjectStatus_Edits.Status = "ส่งแก้ไข";
                DashboardSubjectStatus_Edits.Add(_ObjDashboardSubjectStatus_Edits);
                count += 1;
            }
            DashboardSubjectEdit.Total = count.ToString();
            DashboardSubjectEdit.Subjectstatus = DashboardSubjectStatus_Edits;
            Obj.EditSubject = DashboardSubjectEdit;
            //========================================= Edit  ============================== //
            Cn.Close();
            HttpContext.Current.Session["Dashboard"] = Obj;
            return Obj;
        }
    }
}