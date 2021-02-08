using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using SVframework2016;
using System.Data;
using System.Configuration;
using E_OfficePI.Class;
namespace E_OfficePI.Page.HR
{
    public partial class Org : System.Web.UI.Page
    {
        public static string Connectionstring = ConfigurationManager.ConnectionStrings["Primary"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static ClsTree RenderTree()
        {
            //ดูตามสิทธิ์ที่มีด้วย
     
            DataTable Dt = new DataTable();
            ClsTree Objtree = new ClsTree();
            ClsTree Objtree_result = new ClsTree();
            string sqlcmd = "Select * from Sys_Master_Organize where isdelete = 0 Order By id";
            SqlConnector Cn = new SqlConnector(Connectionstring,"");
            DataRow Dr;
            Dt = Cn.Select(sqlcmd);
            Dr = Dt.Select("id =" + ((Clsuser)HttpContext.Current.Session["My"]).organizeId)[0];
            //Dr = Dt.Select("parentid=0")[0];
            Objtree.OrgId = Dr["Id"].ToString();
            Objtree.OrgName = Dr["OrganizeNameTH"].ToString();
            Objtree.Trees = new List<ClsTree>();
            Objtree.Trees = FindSubTree(ref Dt, Objtree.OrgId);

        
            return Objtree;

        }
        public static List<ClsTree> FindSubTree( ref DataTable Dt, string Orgid)
        {
            DataRow[] Drs;

            List<ClsTree> Trees = new List<ClsTree>();
            ClsTree Objtree = new ClsTree();
            Drs = Dt.Select("parentid ='" + Orgid + "'");
            foreach (DataRow dr in Drs)
            {
                    Objtree = new ClsTree();
                    Objtree.OrgId = dr["Id"].ToString();
                    Objtree.OrgName = dr["OrganizeNameTH"].ToString();
                    Objtree.Trees = new List<ClsTree>();
                    Objtree.Trees = FindSubTree(ref Dt, Objtree.OrgId);
                    Trees.Add(Objtree);
                
            }
            return Trees;
        }
        
        [WebMethod]
        public static List<ClsDict> LoadParentOrganize()
        {
            DataTable Dt = new DataTable();
            List<ClsDict> Dicts = new List<ClsDict>();
            string sqlcmd = "Select * from Sys_Master_Organize Order By id";
            SqlConnector Cn = new SqlConnector(Connectionstring,"");
            ClsDict ObjDict;
            Dt = Cn.Select(sqlcmd);
            Cn.Close();
            ObjDict = new ClsDict();
            ObjDict.Name = "--โปรดระบุ--";
            ObjDict.Val = "";
            Dicts.Add(ObjDict);
            foreach (DataRow dr in Dt.Rows)
            {
                ObjDict = new ClsDict();
                ObjDict.Name = dr["OrganizeNameTH"].ToString();
                ObjDict.Val = dr["id"].ToString();
                Dicts.Add(ObjDict);
            }
            return Dicts;
        }
    }
}