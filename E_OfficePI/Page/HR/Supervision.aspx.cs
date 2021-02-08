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
namespace E_OfficePI.Page.HR
{
    public partial class Supervision : System.Web.UI.Page
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
        public static string Print(string json)
        {
            const string Eformcode = "HR002";
            string StrMsg = "PrintformCode=" + Eformcode + "&Engine=CrystalReport&ID=" + json;
            StrMsg = ClsEngine.Base64Encode(StrMsg);
            return  StrMsg;
        }
        [WebMethod]
        public static string CallBackUpload(string Label, string Running)
        {
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Trans_Attachment Where Id ='" + Running + "'";
            string filename = System.IO.Path.GetFileName(Cn.Select(sqlcmd).Rows[0]["Path"].ToString());
            Cn.Close();
            return filename;
        }
        [WebMethod]
        public static string Savecost(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            System.Collections.ArrayList Arrcmd = new ArrayList();
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_SupervisionCost", "id");
            sqlcmd = " Update [Sys_HR_SupervisionCost] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where ovid ='" + ClsEngine.FindValue(Dicts, "HdSupervisionid") + "'";
            Arrcmd.Add(sqlcmd);
            DataTable Dtcost = new DataTable();
            Dtcost = cn.Select("Select * from sys_master_cost where isdelete = 0");
            foreach (DataRow dr in Dtcost.Rows)
            {
                foreach (ClsDict Objdict in Dicts)
                {
                    if (Objdict.Name.Replace("Txtcostvalue_", "") == dr["id"].ToString())
                    {

                        sqlcmd = " INSERT INTO [Sys_HR_SupervisionCost] ";
                        sqlcmd += " ([id] ";
                        sqlcmd += " ,[ovid] ";
                        sqlcmd += " ,[costid] ";
                        sqlcmd += " ,[Costvalue] ";
                        sqlcmd += ",[isdelete]";
                        sqlcmd += " ,[CreateDate]";
                        sqlcmd += " ,[CreateBy] ) ";
                        sqlcmd += " Values (";
                        sqlcmd += "'" + id + "'";
                        sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "HdSupervisionid") + "'";
                        sqlcmd += ",'" + dr["id"].ToString() + "'"; // Costid
                        sqlcmd += ",'" + Objdict.Val + "'";
                        sqlcmd += ",0";
                        sqlcmd += ",getdate()";
                        sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                        Arrcmd.Add(sqlcmd);
                        id = (int.Parse(id) + 1).ToString();
                    }
                }
            }
            cn.Execute(Arrcmd, null);
            return "";
        }


        [WebMethod] //Finished
        public static List<ClsCost> Detail(string json)
        {
            List<ClsCost> Objs = new List<ClsCost>();
            ClsCost Obj;
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select c.id as costid, Costname,isnull(Costvalue,'') as Costvalue from Sys_Master_Cost c left join [Sys_HR_SupervisionCost] ovc on c.id = ovc.costid and ovc.isdelete = 0  and ovc.ovid = '" + json + "'";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            foreach (DataRow dr in Dt.Rows)
            {
                Obj = new ClsCost();
                Obj.Costid = dr["Costid"].ToString();
                Obj.Costname = dr["Costname"].ToString();
                Obj.Costvalue = dr["Costvalue"].ToString();
                Objs.Add(Obj);
            }
            return Objs;

        }
        [WebMethod] //Finished
        public static string Del(string json)
        {
            string sqlcmd = "";
            string id = json;
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            sqlcmd = "Update [Sys_HR_Supervision] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id ='" + id + "'";
            Cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static string Getrequest(string json)
        {
            return ((Clsuser)HttpContext.Current.Session["My"]).firstnameth + " " + ((Clsuser)HttpContext.Current.Session["My"]).lastnameth;
        }

        [WebMethod]
        public static string Save(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            List<ClsDict> Dicts = new List<ClsDict>();
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_HR_Supervision", "id");
            //CbProvinceid:| CbCountryid:| CbProjectownerorgid:| CbDeveloptypeid:| CbSupervisiontypeid:| 
            //CbVehicletypeid:| Txtattachment:| TxtDocno:| TxtDocumentdate:| TxtRequestfullname:ผู้อบรม #1
            //|Txtsupervisionname:|TxtWorkstart:|TxtWorkend:|TxtTravelstart:|TxtTravelend:
            //|TxtPlace:|TxtProjectowner:|Txtattachmentcont:|
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            sqlcmd = "  INSERT INTO [Sys_HR_Supervision] ";
            sqlcmd += " ([id]";
            sqlcmd += " ,[Docno]";
            if (ClsEngine.FindValue(Dicts, "TxtDocumentdate") != "")
            {
                sqlcmd += " ,[Documentdate]";
            }
            sqlcmd += " ,[Attachmentid]";
            sqlcmd += " ,[supervisionname]";
            sqlcmd += " ,[Requestuserid]";
            sqlcmd += " ,[RequestFullname]";
            sqlcmd += " ,[RequestPositionName]";
            if (ClsEngine.FindValue(Dicts, "TxtWorkstart") != "")
            {
                sqlcmd += " ,[WorkStart]";
            }
            if (ClsEngine.FindValue(Dicts, "TxtWorkend") != "")
            {
                sqlcmd += " ,[WorkEnd]";
            }
            if (ClsEngine.FindValue(Dicts, "TxtTravelstart") != "")
            {
                sqlcmd += " ,[TravelStart]";
            }
            if (ClsEngine.FindValue(Dicts, "TxtTravelend") != "")
            {
                sqlcmd += " ,[TravelEnd]";
            }
            sqlcmd += " ,[Place]";
            sqlcmd += " ,[Provinceid]";
            sqlcmd += " ,[Countryid]";
            sqlcmd += " ,[ProjectOwner]";
            sqlcmd += " ,[ProjectOwnerOrgId]";
            sqlcmd += " ,[DevelopTypeId]";
            sqlcmd += " ,[SupervisionTypeId]";
            sqlcmd += " ,[VehicleTypeId]";
            sqlcmd += ",[status]";
            sqlcmd += ",[isdelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[CreateBy] ) ";
            sqlcmd += " Values (";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "TxtDocno") + "'";
            if (ClsEngine.FindValue(Dicts, "TxtDocumentdate") != "")
            {
                sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "TxtDocumentdate"), '/') + "'";
            }
            sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtattachmentcont") + "'";
            sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "TxtSupervisionname") + "'";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).firstnameth + " " + ((Clsuser)HttpContext.Current.Session["My"]).lastnameth + "'";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).positionnameth + "'";
            if (ClsEngine.FindValue(Dicts, "TxtWorkstart") != "")
            {
                sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "TxtWorkstart"), '/') + "'";
            }
            if (ClsEngine.FindValue(Dicts, "TxtWorkend") != "")
            {
                sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "TxtWorkend"), '/') + "'";
            }
            if (ClsEngine.FindValue(Dicts, "TxtTravelstart") != "")
            {
                sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "TxtTravelstart"), '/') + "'";
            }
            if (ClsEngine.FindValue(Dicts, "TxtTravelend") != "")
            {
                sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "TxtTravelend"), '/') + "'";
            }
            sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "TxtPlace") + "'";
            sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CbProvinceid") + "'";
            sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CbCountryid") + "'";
            sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "TxtProjectowner") + "'";
            sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CbProjectownerorgid") + "'";
            sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CbDeveloptypeid") + "'";
            sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CbSupervisiontypeid") + "'";
            sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CbVehicletypeid") + "'";
            sqlcmd += ",'W'";
            sqlcmd += ",0";
            sqlcmd += ",getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);


            return "";
        }

        [WebMethod]
        public static List<ClsDict> Getorg(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            ClsDict Objdict = new ClsDict();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            string sqlcmd = "Select * from Sys_Master_Organize where isdelete= 0  order by id";
            Dt = Cn.Select(sqlcmd);
            Objdict = new ClsDict();
            Objdict.Name = "--โปรดระบุ--";
            Objdict.Val = "";
            Dicts.Add(Objdict);
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["Organizenameth"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> GetSupervisiontype(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,Supervisiontypename from Sys_Master_Supervisiontype where isdelete = 0 order by Supervisiontypename";
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
                Objdict.Name = dr["Supervisiontypename"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }

        [WebMethod]
        public static List<ClsDict> Getvehicletype(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,vehicletypename from Sys_Master_vehicletype where isdelete = 0 order by vehicletypename";
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
                Objdict.Name = dr["vehicletypename"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getdeveloptype(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,developtypename from Sys_Master_developtype where isdelete = 0 order by developtypename";
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
                Objdict.Name = dr["developtypename"].ToString();
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
        #region "Grid"
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
                sqlcmd = "Update [Sys_HR_Supervision] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id ='" + id + "'";
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
            List<ClsDict> CriterialMapping = new List<ClsDict>();
            ClsGrid Objgrid = new ClsGrid();
            Clsuser Objmy = (Clsuser)HttpContext.Current.Session["My"];

            if (Ctrl == "Gvsupervision")
            {
                PK = "id";
                Sqlcmd = "Select id, docno,convert(nvarchar,isnull(documentdate,''),103) as documentdate,supervisionname,place, convert(nvarchar,isnull(WorkStart,''),103) + ' - ' + convert(nvarchar,isnull(WorkEnd,''),103) as Duration,'' as Detail,'' as del,'' as [print] from Sys_HR_Supervision where isdelete = 0 ";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        id = ((DataTable)HttpContext.Current.Session["RAW_GvSupervision"]).Rows[i]["id"].ToString();
                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {

                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Detail".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;font-size:18px;color:orange;text-decoration:underline;' onclick='Detail(" + id + ");'>ปรับ Cost</a>";
                            }
                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "del".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;' onclick='Del(" + id + ");'><i style='font-size:18px;' class=\"fa fa-trash fa-fw\" aria-hidden=\"true\"></i></a>";
                            }
                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Print".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<a style='cursor:pointer;' onclick='Print(" + id + ");'><i style='font-size:18px;' class=\"fa fa-print fa-fw\" aria-hidden=\"true\"></i></a>";
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