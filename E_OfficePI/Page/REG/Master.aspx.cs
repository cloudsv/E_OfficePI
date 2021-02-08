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
    public partial class Master : System.Web.UI.Page
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
        public static ClsConfCalendar Searchcalendar(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select * from Sys_Conf_Calendar where isdelete = 0";
            sqlcmd += " and Yearno ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json,':','|'), "Cbcalendaryearno") +"'";
            sqlcmd += " and Courseid ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendarcourse") + "'";
            sqlcmd += " and Class ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendarclass") + "'";
            sqlcmd += " and Term ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendarterm") + "'";
            DataTable Dt = new DataTable();
            Dt = cn.Select(sqlcmd);
            ClsConfCalendar Obj = new ClsConfCalendar();
            Obj.Yearno = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendaryearno");
            Obj.Term = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendarterm");
            Obj.Class = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendarclass");
            Obj.Courseid = ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendarcourse");
            if (Dt.Rows.Count > 0)
            {
                if (Dt.Rows[0]["Opendatefrom"].ToString().Trim() != "")
                {
                    Obj.Opendatefrom = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Opendatefrom"].ToString().Trim()));
                }
                else
                {
                    Obj.Opendatefrom = "";
                }

                if (Dt.Rows[0]["Opendateto"].ToString().Trim() != "")
                {
                    Obj.Opendateto = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Opendateto"].ToString().Trim()));
                }
                else
                {
                    Obj.Opendateto = "";
                }



                if (Dt.Rows[0]["Registerdatefrom"].ToString().Trim() != "")
                {
                    Obj.Registerdatefrom = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Registerdatefrom"].ToString().Trim()));
                }
                else
                {
                    Obj.Registerdatefrom = "";
                }

                if (Dt.Rows[0]["Registerdateto"].ToString().Trim() != "")
                {
                    Obj.Registerdateto = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Registerdateto"].ToString().Trim()));
                }
                else
                {
                    Obj.Registerdateto = "";
                }

                if (Dt.Rows[0]["Addwithdrawdatefrom"].ToString().Trim() != "")
                {
                    Obj.Addwithdrawdatefrom = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Addwithdrawdatefrom"].ToString().Trim()));
                }
                else
                {
                    Obj.Addwithdrawdatefrom = "";
                }

                if (Dt.Rows[0]["Addwithdrawdateto"].ToString().Trim() != "")
                {
                    Obj.Addwithdrawdateto = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Addwithdrawdateto"].ToString().Trim()));
                }
                else
                {
                    Obj.Addwithdrawdateto = "";
                }

                if (Dt.Rows[0]["Paymentdatefrom"].ToString().Trim() != "")
                {
                    Obj.Paymentdatefrom = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Paymentdatefrom"].ToString().Trim()));
                }
                else
                {
                    Obj.Paymentdatefrom = "";
                }

                if (Dt.Rows[0]["Paymentdateto"].ToString().Trim() != "")
                {
                    Obj.Paymentdateto = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Paymentdateto"].ToString().Trim()));
                }
                else
                {
                    Obj.Paymentdateto = "";
                }

                if (Dt.Rows[0]["Midexamdatefrom"].ToString().Trim() != "")
                {
                    Obj.Midexamdatefrom = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Midexamdatefrom"].ToString().Trim()));
                }
                else
                {
                    Obj.Midexamdatefrom = "";
                }

                if (Dt.Rows[0]["Midexamdateto"].ToString().Trim() != "")
                {
                    Obj.Midexamdateto = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Midexamdateto"].ToString().Trim()));
                }
                else
                {
                    Obj.Midexamdateto = "";
                }

                if (Dt.Rows[0]["Finalexamdatefrom"].ToString().Trim() != "")
                {
                    Obj.Finalexamdatefrom = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Finalexamdatefrom"].ToString().Trim()));
                }
                else
                {
                    Obj.Finalexamdatefrom = "";
                }

                if (Dt.Rows[0]["Finalexamdateto"].ToString().Trim() != "")
                {
                    Obj.Finalexamdateto = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Finalexamdateto"].ToString().Trim()));
                }
                else
                {
                    Obj.Finalexamdateto = "";
                }


                if (Dt.Rows[0]["Sendgradedatefrom"].ToString().Trim() != "")
                {
                    Obj.Sendgradedatefrom = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Sendgradedatefrom"].ToString().Trim()));
                }
                else
                {
                    Obj.Sendgradedatefrom = "";
                }

                if (Dt.Rows[0]["Sendgradedateto"].ToString().Trim() != "")
                {
                    Obj.Sendgradedateto = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Sendgradedateto"].ToString().Trim()));
                }
                else
                {
                    Obj.Sendgradedateto = "";
                }
                Obj.Error = "";
            }
            else
            {
                
                Obj.Opendatefrom = "";
                Obj.Opendateto = "";
                Obj.Registerdatefrom = "";
                Obj.Registerdateto = "";
                Obj.Addwithdrawdatefrom = "";
                Obj.Addwithdrawdateto = "";
                Obj.Paymentdatefrom = "";
                Obj.Paymentdateto = "";
                Obj.Midexamdatefrom = "";
                Obj.Midexamdateto = "";
                Obj.Finalexamdatefrom = "";
                Obj.Finalexamdateto = "";
                Obj.Sendgradedatefrom = "";
                Obj.Sendgradedateto = "";
                Obj.Error = "";
            }
            return Obj;
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
            for(i=minyear;i<=maxyear;i++)
            {
                Objdict = new ClsDict();
                Objdict.Name = (i + 543).ToString();
                Objdict.Val = i.ToString();
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
        [WebMethod]
        public static ClsConfTerm Getterminfo(string json)
        {
            DataTable Dt = new DataTable();
            ClsConfTerm Obj = new ClsConfTerm();
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select t.*,c.Coursename from Sys_Conf_Term t left join Sys_Master_Course c on t.Courseid = c.Id where t.isdelete =0 and t.id= '" + json.Replace("id:", "").Replace("|", "") + "'";
            Dt = cn.Select(sqlcmd);
            if (Dt.Rows.Count == 0)
            {
                Obj.Error = "ไม่สามารถดึงข้อมูลเครื่องราชอิสริยาภรณ์ได้ โปรดติดต่อผู้ดูแลระบบ ";
            }
            else
            {
                Obj.id = Dt.Rows[0]["id"].ToString();
                Obj.Yearno = Dt.Rows[0]["Yearno"].ToString();
                Obj.Class = Dt.Rows[0]["Class"].ToString();
                Obj.Courseid = Dt.Rows[0]["Courseid"].ToString();
                if (Dt.Rows[0]["Openterm1"].ToString() != "")
                {
                    Obj.Openterm1 = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Openterm1"].ToString()));
                }
                else
                {
                    Obj.Openterm1 = "";
                }
                if (Dt.Rows[0]["Openterm2"].ToString() != "")
                {
                    Obj.Openterm2 = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Openterm2"].ToString()));
                }
                else
                {
                    Obj.Openterm2 = "";
                }
                if (Dt.Rows[0]["Openterm3"].ToString() != "")
                {
                    Obj.Openterm3 = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Openterm3"].ToString()));
                }
                else
                {
                    Obj.Openterm3 = "";
                }
                if (Dt.Rows[0]["Closeterm"].ToString() != "")
                {
                    Obj.Closeterm = ClsEngine.ValidateDateBud(DateTime.Parse(Dt.Rows[0]["Closeterm"].ToString()));
                }
                else
                {
                    Obj.Closeterm = "";
                }
                Obj.Error = "";
            }
            return Obj;
        }
        
        [WebMethod]
        public static string Savecalendar(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            //json += 'Cbcalendaryearno:' + $('#Cbcalendaryearno').val() + '|';
            //json += 'Cbcalendarcourse:' + $('#Cbcalendarcourse').val() + '|';
            //json += 'Cbcalendarclass:' + $('#Cbcalendarclass').val() + '|';
            //json += 'Cbcalendarterm:' + $('#Cbcalendarterm').val() + '|';
            //json += 'Txtopendatefrom:' + $('#Txtopendatefrom').val() + '|';
            //json += 'Txtopendateto:' + $('#Txtopendateto').val() + '|';
            //json += 'Txtregisterdatefrom:' + $('#Txtregisterdatefrom').val() + '|';
            //json += 'Txtregisterdateto:' + $('#Txtregisterdateto').val() + '|';
            //json += 'Txtaddwithdrawdatefrom:' + $('#Txtaddwithdrawdatefrom').val() + '|';
            //json += 'Txtaddwithdrawdateto:' + $('#Txtaddwithdrawdateto').val() + '|';
            //json += 'Txtpaymentdatefrom:' + $('#Txtpaymentdatefrom').val() + '|';
            //json += 'Txtpaymentdateto:' + $('#Txtpaymentdateto').val() + '|';
            //json += 'Txtmidexamdatefrom:' + $('#Txtmidexamdatefrom').val() + '|';
            //json += 'Txtmidexamdateto:' + $('#Txtmidexamdateto').val() + '|';
            //json += 'Txtfinalexamdatefrom:' + $('#Txtfinalexamdatefrom').val() + '|';
            //json += 'Txtfinalexamdateto:' + $('#Txtfinalexamdateto').val() + '|';
            //json += 'Txtsendgradedatefrom:' + $('#Txtsendgradedatefrom').val() + '|';
            //json += 'Txtsendgradedateto:' + $('#Txtsendgradedateto').val() + '|';

            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            sqlcmd = "Select * from Sys_Conf_Calendar where isdelete = 0";
            sqlcmd += " and Yearno ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendaryearno") + "'";
            sqlcmd += " and Courseid ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendarcourse") + "'";
            sqlcmd += " and Class ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendarclass") + "'";
            sqlcmd += " and Term ='" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendarterm") + "'";
            if (cn.Select(sqlcmd).Rows.Count  == 0)
            {
                sqlcmd = "  INSERT INTO [Sys_Conf_Calendar] ";
                sqlcmd += " ([Yearno]";
                sqlcmd += " ,[Term]";
                sqlcmd += " ,[Class]";
                sqlcmd += " ,[Courseid]";
                if (ClsEngine.FindValue(Dicts, "Txtopendatefrom") != "")
                {
                    sqlcmd += " ,Opendatefrom ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtopendateto") != "")
                {
                    sqlcmd += " ,[Opendateto] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtregisterdatefrom") != "")
                {
                    sqlcmd += " ,[Registerdatefrom] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtregisterdateto") != "")
                {
                    sqlcmd += " ,[Registerdateto] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtaddwithdrawdatefrom") != "")
                {
                    sqlcmd += " ,[addwithdrawdatefrom] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtaddwithdrawdateto") != "")
                {
                    sqlcmd += " ,[addwithdrawdateto] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtpaymentdatefrom") != "")
                {
                    sqlcmd += " ,[paymentdatefrom] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtpaymentdateto") != "")
                {
                    sqlcmd += " ,[paymentdateto] ";
                }
                 if (ClsEngine.FindValue(Dicts, "Txtmidexamdatefrom") != "")
                {
                    sqlcmd += " ,[midexamdatefrom] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtmidexamdateto") != "")
                {
                    sqlcmd += " ,[midexamdateto] ";
                }

                if (ClsEngine.FindValue(Dicts, "Txtfinalexamdatefrom") != "")
                {
                    sqlcmd += " ,[finalexamdatefrom] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtfinalexamdateto") != "")
                {
                    sqlcmd += " ,[finalexamdateto] ";
                }

                if (ClsEngine.FindValue(Dicts, "Txtsendgradedatefrom") != "")
                {
                    sqlcmd += " ,[sendgradedatefrom] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtsendgradedateto") != "")
                {
                    sqlcmd += " ,[sendgradedateto] ";
                }
                sqlcmd += " ,[IsDelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += "  VALUES ( ";
                sqlcmd += " '" + ClsEngine.FindValue(Dicts, "Cbcalendaryearno") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbcalendarterm") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbcalendarclass") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbcalendarcourse") + "'";
                if (ClsEngine.FindValue(Dicts, "Txtopendatefrom") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtopendatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtopendateto") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtopendateto"), '/') + "'";
                }



                if (ClsEngine.FindValue(Dicts, "Txtregisterdatefrom") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtregisterdatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtregisterdateto") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtregisterdateto"), '/') + "'";
                }

                if (ClsEngine.FindValue(Dicts, "Txtaddwithdrawdatefrom") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtaddwithdrawdatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtaddwithdrawdateto") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtaddwithdrawdateto"), '/') + "'";
                }

                if (ClsEngine.FindValue(Dicts, "Txtpaymentdatefrom") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtpaymentdatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtpaymentdateto") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtpaymentdateto"), '/') + "'";
                }

                if (ClsEngine.FindValue(Dicts, "Txtmidexamdatefrom") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtmidexamdatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtmidexamdateto") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtmidexamdateto"), '/') + "'";
                }


                if (ClsEngine.FindValue(Dicts, "Txtfinalexamdatefrom") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtfinalexamdatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtfinalexamdateto") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtfinalexamdateto"), '/') + "'";
                }


                if (ClsEngine.FindValue(Dicts, "Txtsendgradedatefrom") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtsendgradedatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtsendgradedateto") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtsendgradedateto"), '/') + "'";
                }
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            else
            {


                sqlcmd = "   Update Sys_Conf_Calendar set ";
                if (ClsEngine.FindValue(Dicts, "Txtopendatefrom") != "")
                {
                    sqlcmd += " [opendatefrom] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtopendatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtopendateto") != "")
                {
                    sqlcmd += " ,[opendateto] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtopendateto"), '/') + "'";
                }

                if (ClsEngine.FindValue(Dicts, "Txtregisterdatefrom") != "")
                {
                    sqlcmd += " ,[registerdatefrom] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtregisterdatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtregisterdateto") != "")
                {
                    sqlcmd += " ,[registerdateto] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtregisterdateto"), '/') + "'";
                }

                if (ClsEngine.FindValue(Dicts, "Txtaddwithdrawdatefrom") != "")
                {
                    sqlcmd += " ,[addwithdrawdatefrom] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtaddwithdrawdatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtaddwithdrawdateto") != "")
                {
                    sqlcmd += " ,[addwithdrawdateto] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtaddwithdrawdateto"), '/') + "'";
                }

                if (ClsEngine.FindValue(Dicts, "Txtpaymentdatefrom") != "")
                {
                    sqlcmd += " ,[paymentdatefrom] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtpaymentdatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtpaymentdateto") != "")
                {
                    sqlcmd += " ,[paymentdateto] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtpaymentdateto"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtmidexamdatefrom") != "")
                {
                    sqlcmd += " ,[midexamdatefrom] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtmidexamdatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtmidexamdateto") != "")
                {
                    sqlcmd += " ,[midexamdateto] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtmidexamdateto"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtfinalexamdatefrom") != "")
                {
                    sqlcmd += " ,[finalexamdatefrom] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtfinalexamdatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtfinalexamdateto") != "")
                {
                    sqlcmd += " ,[finalexamdateto] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtfinalexamdateto"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtsendgradedatefrom") != "")
                {
                    sqlcmd += " ,[sendgradedatefrom] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtsendgradedatefrom"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtsendgradedateto") != "")
                {
                    sqlcmd += " ,[sendgradedateto] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtsendgradedateto"), '/') + "'";
                }
                sqlcmd += " Where isdelete = 0 ";
                sqlcmd += "and Yearno = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendaryearno") + "'";
                sqlcmd += "and Courseid = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendarcourse") + "'";
                sqlcmd += "and Class = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendarclass") + "'";
                sqlcmd += "and Term = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(json, ':', '|'), "Cbcalendarterm") + "'";

                cn.Execute(sqlcmd, null);
            }
            return "";
        }


        [WebMethod]
        public static string SaveCourse(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|'); 
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            try
            {
                string sqlcmd = "";
                string[] str = ClsEngine.FindValue(Dicts, "SubjectId").Split(',');
                string Id = ClsEngine.GenerateRunningId(Connectionstring, "Sys_Master_MapCourse", "Id");
                System.Collections.ArrayList Arr = new ArrayList();
                foreach (string Str in str)
                {
                    if (Str != "0")
                    {
                        sqlcmd = " INSERT INTO [Sys_Master_MapCourse] (";
                        sqlcmd += "  [Id]";
                        sqlcmd += " ,[CourseId]";
                        sqlcmd += " ,[SubjectId]";
                        sqlcmd += " ,[Year]";
                        sqlcmd += " ,[Term]";
                        sqlcmd += " ,[Class]";
                        sqlcmd += " ,[IsDelete]";
                        sqlcmd += " ,[CreateDate]";
                        sqlcmd += " ,[CreateBy] )";
                        sqlcmd += "  VALUES ( ";
                        sqlcmd += "'" + Id + "'";
                        sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CbCoursecourse") + "'";
                        sqlcmd += ",'" + Str + "'";
                        sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CbCourseyearno") + "'";
                        sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CbCourseterm") + "'";
                        sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "CbCourseclass") + "'";
                        sqlcmd += ",'0'";
                        sqlcmd += ",Getdate()";
                        sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                        Id = (int.Parse(Id) + 1).ToString();
                        Arr.Add(sqlcmd);
                    }
                
                }
                cn.Execute(Arr, null);
                return "";
            }
            catch( Exception Ex)
            {
                return Ex.Message;
            }
            finally
            {
                cn.Close();
            }
          
        }
        [WebMethod]
        public static string Saveterm(string json)
        {
            List<ClsDict> Dicts = new List<ClsDict>();
            Dicts = ClsEngine.DeSerialized(json, ':', '|');
            //json += 'Hdterm:' + $('#Hdtermid').val() + '|';
            //json += 'Cbcourse:' + $('#Cbcourse').val() + '|';
            //json += 'Txtyearno:' + $('#Txtyearno').val() + '|';
            //json += 'Cbclass:' + $('#Cbclass').val() + '|';
            //json += 'Txtopenterm1:' + $('#Txtopenterm1').val() + '|';
            //json += 'Txtopenterm2:' + $('#Txtopenterm2').val() + '|';
            //json += 'Txtopenterm3:' + $('#Txtopenterm3').val() + '|';
            //json += 'Txtcloseterm:' + $('#Txtcloseterm').val() + '|';
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "";
            if (ClsEngine.FindValue(Dicts, "Hdterm") == "")
            {
                sqlcmd = " INSERT INTO [Sys_Conf_Term]";
                sqlcmd += " ([id]";
                sqlcmd += " ,[yearno]";
                sqlcmd += " ,[Class]";
                sqlcmd += " ,[Courseid]";
                if (ClsEngine.FindValue(Dicts, "Txtopenterm1") != "")
                {
                    sqlcmd += " ,[Openterm1] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtopenterm2") != "")
                {
                    sqlcmd += " ,[Openterm2] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtopenterm3") != "")
                {
                    sqlcmd += " ,[Openterm3] ";
                }
                if (ClsEngine.FindValue(Dicts, "Txtcloseterm") != "")
                {
                    sqlcmd += " ,[Closeterm] ";
                }
                sqlcmd += " ,[IsDelete] ";
                sqlcmd += " ,[CreateDate] ";
                sqlcmd += " ,[CreateBy]) ";
                sqlcmd += "  VALUES ( ";
                sqlcmd += "'" + ClsEngine.GenerateRunningId(Connectionstring, "Sys_Conf_Term", "id") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Txtyearno") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbclass") + "'";
                sqlcmd += ",'" + ClsEngine.FindValue(Dicts, "Cbcourse") + "'";
                if (ClsEngine.FindValue(Dicts, "Txtopenterm1") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtopenterm1"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtopenterm2") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtopenterm2"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtopenterm3") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtopenterm3"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtcloseterm") != "")
                {
                    sqlcmd += ",'" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtcloseterm"), '/') + "'";
                }
                sqlcmd += ",'0'";
                sqlcmd += ",Getdate()";
                sqlcmd += ",'" + ((Clsuser)HttpContext.Current.Session["My"]).userid + "')";
                cn.Execute(sqlcmd, null);
            }
            else
            {
                sqlcmd = "   Update Sys_Conf_term set ";
                sqlcmd += "  [Yearno] = '" + ClsEngine.FindValue(Dicts, "Txtyearno") + "'";
                sqlcmd += " ,[Class]= '" + ClsEngine.FindValue(Dicts, "Cbclass") + "'";
                sqlcmd += " ,[Courseid] = '" + ClsEngine.FindValue(Dicts, "Cbcourse") + "'";
              
                if (ClsEngine.FindValue(Dicts, "Txtopenterm1") != "")
                {
                    sqlcmd += " ,[Openterm1] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtopenterm1"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtopenterm2") != "")
                {
                    sqlcmd += " ,[Openterm2] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtopenterm2"), '/') + "'";
                }
                if (ClsEngine.FindValue(Dicts, "Txtopenterm3") != "")
                {
                    sqlcmd += " ,[Openterm3] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtopenterm3"), '/') + "'";
                }

                if (ClsEngine.FindValue(Dicts, "Txtcloseterm") != "")
                {
                    sqlcmd += " ,[Closeterm] = '" + ClsEngine.ConvertDateforSavingDatabase(ClsEngine.FindValue(Dicts, "Txtcloseterm"), '/') + "'";
                }
                sqlcmd += " Where [id] = '" + ClsEngine.FindValue(Dicts, "Hdterm") + "'";
                cn.Execute(sqlcmd, null);
            }
            return "";
        }
        [WebMethod]
        public static List<ClsDict> Getcourse(string json)
        {
            SqlConnector cn = new SqlConnector(Connectionstring, null);
            string sqlcmd = "Select id,Coursename from Sys_Master_Course where isdelete = 0  order by Coursename";
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
            if (Ctrl == "Gvterm")
            {
                PK = "id";
                Sqlcmd = " Select Convert(nvarchar,Openterm1,103) as Openterm1,Convert(nvarchar,Openterm2,103) as Openterm2,Convert(nvarchar,Openterm3,103) as Openterm3,Convert(nvarchar,Closeterm,103) as Closeterm,t.*,c.Coursename from Sys_Conf_Term t left join Sys_Master_Course c on t.Courseid = c.Id where t.isdelete =0 ";
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
            if (Ctrl == "GvCourse")
            {
                PK = "id";
                Sqlcmd = "select mc.id , s.*,c.*,mc.*	from sys_master_mapcourse mc	inner  join Sys_Master_Course c on   c.Id = mc.courseid and isnull(c.isdelete ,0) = 0	inner join Sys_Master_Subject s on s.CourseId = c.Id and s.Id = mc.SubjectId and isnull(s.IsDelete,0) = 0	where isnull(mc.isdelete,0) = 0 ";
                if(ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbCourseyearno") != "")
                {
                    Sqlcmd += " and mc.Year = '"+ ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbCourseyearno") + "'";
                }
                if (ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbCoursecourse") != "")
                {
                    Sqlcmd += " and mc.CourseId = '" +ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbCoursecourse") + "'";
                }
                if (ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbCourseclass") != "")
                {
                    Sqlcmd += " and mc.Class = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbCourseclass") + "'";
                }
                if (ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbCourseterm") != "")
                {
                    Sqlcmd += " and mc.Term = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbCourseterm") + "'";
                }

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
            if (Ctrl == "GvSubject")
            {
                PK = "id";
                Sqlcmd = "select * from (select * from Sys_Master_Subject s  	where isnull(s.isdelete,0) = 0 ";  
                if (ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbAddcourse") != "")
                {
                    Sqlcmd += " and CourseId = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbAddcourse") + "'";
                } 
                Sqlcmd += "and s.id not in(  select  mc.subjectid	from sys_master_mapcourse mc	inner  join Sys_Master_Course c on   c.Id = mc.courseid and isnull(c.isdelete ,0) = 0	inner join Sys_Master_Subject s on s.CourseId = c.Id and s.Id = mc.SubjectId and isnull(s.IsDelete,0) = 0	where isnull(mc.isdelete,0) = 0 ";
                if (ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbAddYearNo") != "")
                {
                    Sqlcmd += " and mc.Year = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbAddYearNo") + "'";
                }
                if (ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbAddcourse") != "")
                {
                    Sqlcmd += " and mc.CourseId = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbAddcourse") + "'";
                }
                if (ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbAddclass") != "")
                {
                    Sqlcmd += " and mc.Class = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbAddclass") + "'";
                }
                if (ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbAddTerm") != "")
                {
                    Sqlcmd += " and mc.Term = '" + ClsEngine.FindValue(ClsEngine.DeSerialized(Criteria, ':', '|'), "CbAddTerm") + "'";
                }
                Sqlcmd += " )";
                Sqlcmd += " ) a where 1 = 1 ";
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