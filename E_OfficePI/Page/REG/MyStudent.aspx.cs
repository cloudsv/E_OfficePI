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
namespace E_OfficePI.Page.REG
{
    public partial class MyStudent : System.Web.UI.Page
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
        public static string Deletestudent(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, "");
            ArrayList Arrcmd = new ArrayList();
            string studentid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "x");
            string sqlcmd = "";
            sqlcmd = "Update Sys_master_student set isdelete = 1,deletedate=getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id='" + studentid + "'";
            Arrcmd.Add(sqlcmd);
            cn.Execute(Arrcmd, null);
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

            if (Ctrl == "Gvaddwithdraw")
            {
                string sqlcmd = "";
                string id = "";
                id = ClsEngine.FindValue(Dats, "id");
                sqlcmd = "Update [Sys_REG_Subject] Set IsDelete=1,DeleteDate='" + DateTime.Now + "',DeleteBy='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' Where id ='" + id + "'";
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
        public static string doConfirmpayment(string json)
        {
            //json += 'Txtreceiptno:' + $('#Txtreceiptno').val() + '|';
            //json += 'Hdpayment:' + $('#Hdpayment').val() + '|';
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Update Sys_Registration_StudentRegister set receiptdate=getdate(),receiptno='" + ClsEngine.FindValue(Dicts, "Txtreceiptno") + "', ispayment ='1',modifydate=getdate(),modifyby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where id = '" + ClsEngine.FindValue(Dicts, "Hdpayment") + "'";
            cn.Execute(sqlcmd, null);
            return "";
        }

        [WebMethod]
        public static string Selectedsubject(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_REG_Subject", "id");
            //json = 'subjectid :' + x + '|';
            //json += 'Hdregsubjectid' + $('#Hdregsubjectid').val() + '|';
            string sqlcmd = "";
            sqlcmd += " INSERT INTO [Sys_REG_Subject] ";
            sqlcmd += " ([id]";
            sqlcmd += " ,[Regsubjectid]";
            sqlcmd += " ,[subjectid]";
            sqlcmd += " ,[isdelete]";
            sqlcmd += " ,[CreateDate]";
            sqlcmd += " ,[CreateBy])";
            sqlcmd += " Values (";
            sqlcmd += "'" + id + "'";
            sqlcmd += ",'" + ClsEngine.FindValue(ClsEngine.DeSerialized(json,':','|'), "Hdregsubjectid") + "'";
            sqlcmd += ",'" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "subjectid") + "'";
            sqlcmd += ",0";
            sqlcmd += ",Getdate()";
            sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(sqlcmd, null);
            return "";
        }
        [WebMethod]
        public static ClsGridResponse Bind(string Ctrl, long PagePerItem, long CurrentPage, string SortName, string Order, string Column, string Data, string Initial, string SelectCat, string SearchMsg, string EditButton, string DeleteButton, string Panel, string FullRowSelect, string Multiselect, string Criteria, string SearchesDat, string Searchcolumns, string WPanel, string HPanel)
        {
            string Sqlcmd = "";
            string PK = "";
            List<ClsDict> CriterialMapping = new List<ClsDict>();
            ClsGrid Objgrid = new ClsGrid();
            Clsuser Objmy = (Clsuser)HttpContext.Current.Session["My"];
            string id = "";
            if (Ctrl == "Gvpayment")
            {
                PK = "id";
                Sqlcmd = " Select r.id,Year,Coursename,Term,Class,Studentno,Firstname,Lastname,sum(cast(isnull(amount,0) as numeric)) as amount,isnull(ispayment,0) as ispayment,'' as Ctrl";
                Sqlcmd += " from [Sys_Registration_StudentRegister] R  ";
                Sqlcmd += " left join Sys_Master_Course c on r.Courseid = c.id and c.isdelete = 0  ";
                Sqlcmd += " left join Sys_REG_Subject S on R.id = S.Regsubjectid and s.isdelete = 0  ";
                Sqlcmd += " left join Sys_Master_Subject sj on s.subjectid = sj.id and sj.isdelete = 0  ";
                Sqlcmd += " where  ";
                Sqlcmd += " (  ";
                Sqlcmd += " Studentno like '%" + Criteria + "%' and Firstname  like '%" + Criteria + "%' and Lastname  like '%" + Criteria + "%'  ";
                Sqlcmd += " )  ";
                Sqlcmd += " and isnull(ispayment,0)  = 0 and amount > 0 ";
                Sqlcmd += " group by r.id,Year,Coursename,Term,Class,Studentno,Firstname,Lastname,Ispayment  ";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        id = ((DataTable)HttpContext.Current.Session["Raw_Gvpayment"]).Rows[i]["id"].ToString();
          
                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {
                            
                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "amount".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = Double.Parse(ObjGridResponse.ResData[i][j].Val).ToString("N2");
                            }

                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "Ctrl".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = "<a style='color:red;' onclick='Confirmpayment(\"" + id + "\");'>กดเพื่อชำระเงิน</a>";
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
            else if (Ctrl == "Gvdebt")
            {
                PK = "id";
                Sqlcmd = " Select r.id,Year,Coursename,Term,Class,Studentno,Firstname,Lastname,sum(cast(isnull(amount,0) as numeric)) as amount,isnull(ispayment,0) as ispayment";
                Sqlcmd += " from [Sys_Registration_StudentRegister] R  ";
                Sqlcmd += " left join Sys_Master_Course c on r.Courseid = c.id and c.isdelete = 0  ";
                Sqlcmd += " left join Sys_REG_Subject S on R.id = S.Regsubjectid and s.isdelete = 0  ";
                Sqlcmd += " left join Sys_Master_Subject sj on s.subjectid = sj.id and sj.isdelete = 0  ";
                Sqlcmd += " where  ";
                Sqlcmd += " (  ";
                Sqlcmd += " Studentid ='" + Criteria + "'";
                Sqlcmd += " )  and amount > 0 ";
                Sqlcmd += " and isnull(ispayment,0)  = 0  ";
                Sqlcmd += " group by r.id,Year,Coursename,Term,Class,Studentno,Firstname,Lastname,Ispayment  ";
                Criteria = "";
                SqlConnector Cn = new SqlConnector(Connectionstring, null);
                try
                {
                    ClsGridResponse ObjGridResponse = Objgrid.Bind(ref Cn, Ctrl, PagePerItem, CurrentPage, SortName, Order, Column, Data, Initial, SelectCat, SearchMsg, EditButton, DeleteButton, Panel, FullRowSelect, Multiselect, Criteria, PK, Sqlcmd, CriterialMapping, SearchesDat, Searchcolumns, WPanel, HPanel);
                    for (int i = 0; i < ObjGridResponse.ResData.Count; i++)
                    {
                        id = ((DataTable)HttpContext.Current.Session["Raw_Gvdebt"]).Rows[i]["id"].ToString();

                        for (int j = 0; j < ObjGridResponse.ResData[i].Count; j++)
                        {

                            if (ObjGridResponse.ResData[i][j].Name.ToLower() == "amount".ToLower())
                            {
                                ObjGridResponse.ResData[i][j].Val = Double.Parse(ObjGridResponse.ResData[i][j].Val).ToString("N2");
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
            else if (Ctrl == "Gvaddwithdraw")
            {
                PK = "id";
                Sqlcmd = "Select RS.id,Subjectcode,Subjectname,Credit from Sys_REG_Subject RS inner join Sys_Master_Subject s on rs.subjectid = s.id where rs.isdelete = 0 and s.isdelete =0  and Regsubjectid ='" + Criteria + "'";
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
            else if (Ctrl == "Gvsearchsubject")
            {
                PK = "id";
                Sqlcmd = "Select id,subjectcode,subjectname,credit from sys_master_subject s where s.isdelete = 0 and s.id not in (select subjectid from Sys_REG_Subject where isdelete =0 and Regsubjectid ='" + Criteria + "') ";   
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

        [WebMethod]
        public static List<ClsStudentAddress> Getaddress(string json)
        {
            List<ClsStudentAddress> Dicts = new List<ClsStudentAddress>();
            string Sqlcmd = "Select at.id as masteraddrid,Studentid,Addresstype,[Address],Provinceid,Districtid,Subdistrictid,Postcode from Sys_Master_Addresstype at left join Sys_Student_Address a on at.id = a.Addresstypeid and a.isdelete =0 and a.Studentid = '" + json + "' where at.isdelete = 0 ";
            DataTable Dt = new DataTable();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            ClsStudentAddress Objdict = new ClsStudentAddress();
            Dt = cn.Select(Sqlcmd);
            foreach (DataRow Dr in Dt.Rows)
            {
                Objdict = new ClsStudentAddress();
                Objdict.id = Dr["masteraddrid"].ToString();
                Objdict.Studentid = Dr["Studentid"].ToString();
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
        public static ClsStudent Getstudentinfo(string json)
        {
            ClsStudent Obj = new ClsStudent();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from sys_master_student where id = '" + json + "'";
            DataTable Dt = new DataTable();
            Dt = Cn.Select(sqlcmd);
            if (Dt.Rows.Count > 0)
            {
                Obj.id = Dt.Rows[0]["id"].ToString();
                Obj.Titleid = Dt.Rows[0]["Titleid"].ToString();
                Obj.Avartarurl = Dt.Rows[0]["Avartarurl"].ToString();
                Obj.Studentno = Dt.Rows[0]["Studentno"].ToString();
                Obj.Firstname = Dt.Rows[0]["Firstname"].ToString();
                Obj.Lastname = Dt.Rows[0]["Lastname"].ToString();
                Obj.GPAX = Dt.Rows[0]["GPAX"].ToString();
                Obj.Class = Dt.Rows[0]["Class"].ToString();
                Obj.Courseid = Dt.Rows[0]["Courseid"].ToString();
                Obj.Registertypeid = Dt.Rows[0]["Registertypeid"].ToString();
                Obj.Registerquotaid = Dt.Rows[0]["Registerquotaid"].ToString();
                Obj.Studentstatusid = Dt.Rows[0]["Studentstatusid"].ToString();
                Obj.Degreeid = Dt.Rows[0]["Degreeid"].ToString();
                Obj.Educationid = Dt.Rows[0]["Educationid"].ToString();
                Obj.Year = Dt.Rows[0]["Year"].ToString();
                Obj.Fundprovinceid = Dt.Rows[0]["Fundprovinceid"].ToString();
                Obj.Fundingid = Dt.Rows[0]["Fundingid"].ToString();
                Obj.Fundtypeid = Dt.Rows[0]["Fundtypeid"].ToString();
                Obj.Cardid = Dt.Rows[0]["Cardid"].ToString();
                Obj.TitleEN = Dt.Rows[0]["TitleEN"].ToString();
                Obj.FirstnameEN = Dt.Rows[0]["FirstnameEN"].ToString();
                Obj.LastnameEN = Dt.Rows[0]["LastnameEN"].ToString();
                if (Dt.Rows[0]["Birthdate"].ToString() != "")
                {
                    Obj.Birthdate = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Birthdate"].ToString()));
                }
                else
                {
                    Obj.Birthdate = "";
                }
                Obj.Bloodid = Dt.Rows[0]["Bloodid"].ToString();
                Obj.Genderid = Dt.Rows[0]["Genderid"].ToString();
                Obj.Marystatusid = Dt.Rows[0]["Marystatusid"].ToString();
                Obj.Nationid = Dt.Rows[0]["Nationid"].ToString();
                Obj.Religionid = Dt.Rows[0]["Religionid"].ToString();
                Obj.Raceid = Dt.Rows[0]["Raceid"].ToString();
                Obj.Weight = Dt.Rows[0]["Weight"].ToString();
                Obj.Height = Dt.Rows[0]["Height"].ToString();
                Obj.Countryid = Dt.Rows[0]["Countryid"].ToString();
                Obj.Provinceid = Dt.Rows[0]["Provinceid"].ToString();
                Obj.Ismilitarystate = Dt.Rows[0]["Ismilitarystate"].ToString();
                Obj.Preveducation = Dt.Rows[0]["Preveducation"].ToString();
            }
            return Obj;
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
        public static List<ClsDict> Getdistrict(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_District where isdelete = 0 and ProvinceID = '" + json + "' Order by Districtnameth ";
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
        public static List<ClsDict> Getfundtype(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,fundtypename from Sys_Master_fundtype where isdelete = 0 order by fundtypename";
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
                Objdict.Name = dr["fundtypename"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }

        [WebMethod]
        public static List<ClsDict> Getfunding(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,fundingname from Sys_Master_funding where isdelete = 0 order by fundingname";
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
                Objdict.Name = dr["fundingname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }

        [WebMethod]
        public static List<ClsDict> Getstudentstatus(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,studentstatusname from Sys_Master_studentstatus where isdelete = 0 order by studentstatusname";
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
                Objdict.Name = dr["studentstatusname"].ToString();
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
        public static List<ClsStudent> Students(string json)
        {
            List<ClsStudent> Objs = new List<ClsStudent>();
            ClsStudent Obj = new ClsStudent();
            SqlConnector Cn = new SqlConnector(Connectionstring, null);
            string Searchkwd = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Txtusersearch");
            string sqlcmd = "Select s.*,t.titlenameth from Sys_Master_Student s left join Sys_Master_Title t on s.titleid = t.id where s.isdelete = 0 and (firstname like '%" + Searchkwd + "%'  or lastname like '%" + Searchkwd+ "%') ";
            DataTable Dt = new DataTable();
            Dt = Cn.Select(sqlcmd);
            foreach(DataRow dr in Dt.Rows)
            {
                Obj = new ClsStudent();
                Obj.id = dr["id"].ToString();
                Obj.Titlenameth = dr["Titlenameth"].ToString();
                Obj.Avartarurl = dr["Avartarurl"].ToString();
                Obj.Studentno = dr["Studentno"].ToString();
                Obj.Firstname = dr["Firstname"].ToString();
                Obj.Lastname = dr["Lastname"].ToString();
                Obj.Class = dr["Class"].ToString();
                Obj.GPAX = dr["GPAX"].ToString();
                Objs.Add(Obj);
            }
            return Objs;
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
          

             if (ClsEngine.FindValue(Dicts, "x") == "1")
             {
               
             
            
                Sqlcmd += " UPDATE [Sys_Master_Student] ";
                Sqlcmd += " Set ";
                Sqlcmd += " [titleid] = '" + ClsEngine.FindValue(Dicts, "Cbprofiletitle") + "'";
             
                Sqlcmd += " ,[Firstname] = '" + ClsEngine.FindValue(Dicts, "Txtprofilefirstname") + "'";
                Sqlcmd += " ,[Lastname] = '" + ClsEngine.FindValue(Dicts, "Txtprofilelastname") + "'";



                Sqlcmd += " ,[Class] = '" + ClsEngine.FindValue(Dicts, "Cbprofileclass") + "'";
                Sqlcmd += " ,[Courseid]  = '" + ClsEngine.FindValue(Dicts, "Cbprofilecourse") + "'";

                Sqlcmd += " ,[Studentstatusid]  = '" + ClsEngine.FindValue(Dicts, "Cbprofilestudentstatus") + "'";
                Sqlcmd += " ,[Degreeid]  = '" + ClsEngine.FindValue(Dicts, "Cbprofiledegree") + "'";
                Sqlcmd += " ,[Educationid]  = '" + ClsEngine.FindValue(Dicts, "Cbprofileeducation") + "'";
                Sqlcmd += " ,[Year]  = '" + ClsEngine.FindValue(Dicts, "Txtprofileyear") + "'";
                Sqlcmd += " ,[Fundprovinceid]  = '" + ClsEngine.FindValue(Dicts, "Cbprofilefundprovince") + "'";
                Sqlcmd += " ,[Fundingid]  = '" + ClsEngine.FindValue(Dicts, "Cbprofilefunding") + "'";
                Sqlcmd += " ,[Fundtypeid] = '" + ClsEngine.FindValue(Dicts, "Cbprofilefundtype") + "'";
                Sqlcmd += " ,[ModifyDate] = Getdate() ";
                Sqlcmd += " ,[ModifyBy] = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                Sqlcmd += " Where id ='" + ClsEngine.FindValue(Dicts, "Hdstudentid") + "'";
                Arrcmd.Add(Sqlcmd);
                cn.Execute(Arrcmd, null);
                return "";
            }
            else if (ClsEngine.FindValue(Dicts, "x") == "2")
            {
               
          
               
                Sqlcmd += " UPDATE [Sys_Master_Student] ";
                Sqlcmd += " Set ";
                Sqlcmd += "  [Cardid] = '" + ClsEngine.FindValue(Dicts, "Txtprofilecardid") + "'";
                Sqlcmd += " ,[TitleEN] = '" + ClsEngine.FindValue(Dicts, "TxtprofiletitleEN") + "'";
                Sqlcmd += " ,[FirstnameEN] = '" + ClsEngine.FindValue(Dicts, "TxtprofilefirstnameEN") + "'";
                Sqlcmd += " ,[LastnameEN] = '" + ClsEngine.FindValue(Dicts, "TxtprofilelastnameEN") + "'";

                if (ClsEngine.FindValue(Dicts, "Txtprofilebirthdate") != "")
                {
                    Sqlcmd += " ,[Birthdate] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtprofilebirthdate"), '/') + "'";
                }
                Sqlcmd += " ,[Bloodid] = '" + ClsEngine.FindValue(Dicts, "Cbprofileblood") + "'";
                Sqlcmd += " ,[Genderid] = '" + ClsEngine.FindValue(Dicts, "Cbprofilegender") + "'";
                Sqlcmd += " ,[Marystatusid]= '" + ClsEngine.FindValue(Dicts, "Cbprofilemarystatus") + "'";
                Sqlcmd += " ,[Nationid] = '" + ClsEngine.FindValue(Dicts, "Cbprofilenation") + "'";
                Sqlcmd += " ,[Religionid] = '" + ClsEngine.FindValue(Dicts, "Cbprofilereligion") + "'";
                Sqlcmd += " ,[Raceid]= '" + ClsEngine.FindValue(Dicts, "Cbprofilerace") + "'";
                Sqlcmd += " ,[Weight] = '" + ClsEngine.FindValue(Dicts, "Txtprofileweight") + "'";
                Sqlcmd += " ,[Height] = '" + ClsEngine.FindValue(Dicts, "Txtprofileheight") + "'";
                Sqlcmd += " ,[Countryid]= '" + ClsEngine.FindValue(Dicts, "Cbprofilecountry") + "'";
                Sqlcmd += " ,[Provinceid] = '" + ClsEngine.FindValue(Dicts, "Cbprofileprovince") + "'";
                Sqlcmd += " ,[Ismilitarystate]= '" + ClsEngine.FindValue(Dicts, "Cbprofileismilitarystate") + "'";
                Sqlcmd += " ,[Preveducation]= '" + ClsEngine.FindValue(Dicts, "Txtpreveducation") + "'";
                Sqlcmd += " ,[ModifyDate] = Getdate() ";
                Sqlcmd += " ,[ModifyBy] = '" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "'";
                Sqlcmd += " Where id ='" + ClsEngine.FindValue(Dicts, "Hdstudentid") + "'";
                Arrcmd.Add(Sqlcmd);
                cn.Execute(Arrcmd, null);
                return "";
            }
            else if (ClsEngine.FindValue(Dicts, "x") == "3")
            {
                DataTable Dtaddress = new DataTable();
                string Addressid = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Student_Address", "id");
                Sqlcmd = "Update Sys_Student_Address set isdelete = 1,deletedate =getdate(),deleteby='" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "' where studentid = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Hdstudentid") + "'";
                Arrcmd.Add(Sqlcmd);
                Dtaddress = cn.Select("Select id,Addresstype from Sys_Master_Addresstype where isdelete= 0 order by id");
                foreach (DataRow dr in Dtaddress.Rows)
                {
                    Sqlcmd = " INSERT INTO [Sys_Student_Address] ";
                    Sqlcmd += " ([id] ";
                    Sqlcmd += ",[studentid]";
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
                    Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Hdstudentid") + "'";
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
        public static ClsStudent Savenewstudent(string json)
        {
            //json += 'Txtstudentno :' + $('#Txtstudentno').val() + '|';
            //json += 'Txtfirstname :' + $('#Txtfirstname').val() + '|';
            //json += 'Txtlastname :' + $('#Txtlastname').val() + '|';
            //json += 'Cbstudentcourse :' + $('#Cbstudentcourse').val() + '|';
            //json += 'Cbstudentregistertype :' + $('#Cbstudentregistertype').val() + '|';
            //json += 'Cbstudentregisterquota :' + $('#Cbstudentregisterquota').val() + '|';
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            List<ClsDict> Dicts = new List<ClsDict>();
            ClsStudent Obj = new ClsStudent();
            string Sqlcmd = "";
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            string id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_Student", "Id");
            Sqlcmd = "Select * from Sys_Master_Student where isdelete = 0 and Studentno ='" + ClsEngine.FindValue(Dicts, "Txtstudentno") + "'";
            if (cn.Select(Sqlcmd).Rows.Count > 0)
            {
                Obj.Error = "รหัสนักศึกษานี้ ได้มีการใช้งานไปแล้ว";
                return Obj;
            }
            Sqlcmd = " INSERT INTO [Sys_Master_Student]";
            Sqlcmd += "  ([Id]";
            Sqlcmd += "  ,[Studentno]";
            Sqlcmd += "  ,[Firstname]";
            Sqlcmd += "  ,[Lastname]";
            Sqlcmd += "  ,[Courseid]";
            Sqlcmd += "  ,[Registertypeid]";
            Sqlcmd += "  ,[Registerquotaid]";
            Sqlcmd += " ,[Isdelete]";
            Sqlcmd += " ,[Createdate]";
            Sqlcmd += " ,[CreateBy] )";
            Sqlcmd += " VALUES ( ";
            Sqlcmd += "'" + id + "'";
            Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtstudentno") + "'";
            Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtfirstname") + "'";
            Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtlastname") + "'";
            Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbstudentcourse") + "'";
            Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbstudentregistertype") + "'";
            Sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbstudentregisterquota") + "'";
            Sqlcmd += ",0";
            Sqlcmd += ",getdate()";
            Sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
            cn.Execute(Sqlcmd, null);
            Obj.id = id;
            Obj.Error = "";
            return Obj;
        }

        [WebMethod]
        public static string Validatestudentno(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_Student where isdelete = 0 and studentno ='" + json + "'";
            if (cn.Select(sqlcmd).Rows.Count == 0)
            {
                return "";
            }
            else
            {
                return "รหัสนักศึกษานี้ " + json + " ได้มีการใช้งานไปแล้ว โปรดใช้รหัสนักศึกษาอื่น ";
            }
        }
        [WebMethod]
        public static string Searchmystudent(string json)
        {
            //json += 'Cbmystudentyearno:' + $('#Cbmystudentyearno').val() + '|';
            //json += 'Cbmystudentcourse:' + $('#Cbmystudentcourse').val() + '|';
            //json += 'Cbmystudentclass:' + $('#Cbmystudentclass').val() + '|';
            //json += 'Cbmystudentterm:' + $('#Cbmystudentterm').val() + '|';
            //json += 'Cbmystudentid:' + $('#Cbmystudentid').val() + '|';
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            DataTable Dt = new DataTable();
            DataTable Dtstudent = new DataTable();
            string id = "";
            string sqlcmd = "select * from Sys_Registration_StudentRegister r ";
            sqlcmd += " where isdelete = 0 ";
            sqlcmd += " and Year='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbmystudentyearno") + "'";
            sqlcmd += " and Courseid ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbmystudentcourse") + "'";
            sqlcmd += " and Class ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbmystudentclass") + "'";
            sqlcmd += " and Term ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbmystudentterm") + "'";
            sqlcmd += " and Studentid ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbmystudent") + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count == 0)
            {
                Dtstudent = cn.Select("Select * from sys_master_student where id='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbmystudent") + "'");


                //insert
                id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Registration_StudentRegister", "id");
                sqlcmd = " INSERT INTO [Sys_Registration_StudentRegister] ";
                sqlcmd += " ([id] ";
                sqlcmd += " ,[Courseid] ";
                sqlcmd += " ,[Year] ";
                sqlcmd += " ,[Term] ";
                sqlcmd += " ,[StudentId] ";
                sqlcmd += " ,[Studentno] ";
                sqlcmd += " ,[Firstname] ";
                sqlcmd += " ,[Lastname] ";
                sqlcmd += " ,[Class] ";
                sqlcmd += " ,[Registerdate] ";
                sqlcmd += " ,[IsDelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += " VALUES ";
                sqlcmd += " ( ";
                sqlcmd += "'" + id + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbmystudentcourse") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbmystudentyearno") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbmystudentterm") + "'";
                sqlcmd += ",'" + Dtstudent.Rows[0]["id"].ToString() + "'";
                sqlcmd += ",'" + Dtstudent.Rows[0]["Studentno"].ToString() + "'";
                sqlcmd += ",'" + Dtstudent.Rows[0]["Firstname"].ToString() + "'";
                sqlcmd += ",'" + Dtstudent.Rows[0]["Lastname"].ToString() + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbmystudentclass") + "'";
                sqlcmd += ",getdate()";
                sqlcmd += ",0";
                sqlcmd += ",getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
                return id;
            }
            else if (cn.Select("select * from Sys_REG_Subject where  Regsubjectid = '" + Dt.Rows[0]["id"].ToString() + "' and isdelete = 0 and isnull(iscalgpax,'0') = 1").Rows.Count > 0)
            {
                return "-1";
            }
            else
            {
                return Dt.Rows[0]["id"].ToString();
            }
        }
        [WebMethod]
        public static List<ClsDict> Getyear(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            ClsDict Objdict = new ClsDict();
            int minyear = System.DateTime.Now.AddYears(-10).Year;
            int maxyear = System.DateTime.Now.AddYears(+10).Year;
            int i = 0;
            if (minyear > 2500)
            {
                minyear -= 543;
            }
            if (maxyear > 2500)
            {
                maxyear -= 543;
            }
            for (i = minyear; i <= maxyear; i++)
            {
                Objdict = new ClsDict();
                Objdict.Name = (i + 543).ToString();
                Objdict.Val = i.ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getstudent(string json)
        {

            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Master_Student where isdelete = 0 and Class='" + json + "'";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["firstname"].ToString() + " " + dr["lastname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getclass(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,class from Sys_Master_class where isdelete = 0  order by class";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["class"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        
        [WebMethod]
        public static List<ClsDict> Getcourse(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,Coursename from Sys_Master_course where isdelete = 0  order by Coursename";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["Coursename"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getregisterquota(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,registerquotaname from Sys_Master_registerquota where isdelete = 0  order by registerquotaname";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["registerquotaname"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }

        [WebMethod]
        public static List<ClsDict> Getregistertype(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,registertypename from Sys_Master_registertype where isdelete = 0  order by registertypename";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["registertypename"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
        [WebMethod]
        public static List<ClsDict> Getterm(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,term from Sys_Master_term where isdelete = 0  order by term";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsDict Objdict;
            List<ClsDict> Dicts = new List<ClsDict>();
            foreach (DataRow dr in Dt.Rows)
            {
                Objdict = new ClsDict();
                Objdict.Name = dr["term"].ToString();
                Objdict.Val = dr["id"].ToString();
                Dicts.Add(Objdict);
            }
            return Dicts;
        }
    }
}