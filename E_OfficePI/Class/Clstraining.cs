using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class Clstraining
    {
        public string Trainingid { get; set; }
        public string Trainingname { get; set; }
       
        public List<Clstrainingsource> Templatetrainingsource { get; set; }
        public List<ClsserviceLv> TemplateserviceLv { get; set; }
        public List<Clsquality> Templatequality { get; set; }
        public List<Clstrainingsource> Trainingsource { get; set; }
        public List<ClsserviceLv> ServiceLv { get; set; }
        public List<Clsquality> Quality { get; set; }
    }
    public class Clstrainingsource
    {
        public string Trainingsourceid { get; set; }
        public string Trainingsourcename { get; set; }
    }
    public class ClsserviceLv
    {
        public string ServiceLvid { get; set; }
        public string ServiceLvname { get; set; }
    }
    public class Clsquality
    {
        public string Qualityid { get; set; }
        public string Qualityname { get; set; }
    }
}