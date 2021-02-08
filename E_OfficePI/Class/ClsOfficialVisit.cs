using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class ClsOfficialVisit
    {
       public string id { get; set; }
        public string Docno { get; set; }
        public string Documentdate { get; set; }
        public string Attachmentid { get; set; }
        public string OffialVisitName { get; set; }
        public string Requestuserid { get; set; }
        public string RequestFullname { get; set; }
        public string RequestPositionName { get; set; }
        public string WorkStart { get; set; }
        public string WorkEnd { get; set; }
        public string PartialDate { get; set; }
        public string PartialTimeHH { get; set; }
        public string PartialTimeMM { get; set; }
        public string TravelStart { get; set; }
        public string TravelEnd { get; set; }
        public string IsRequestforWithoutPublicHoliday { get; set; }
        public string Place { get; set; }
        public string Provinceid { get; set; }
        public string Countryid { get; set; }
        public string ProjectOwner { get; set; }
        public string ProjectOwnerOrgType { get; set; }
        public string ProjectOwnerOrgId { get; set; }
        public string DevelopTypeId { get; set; }
        public string OfficialVisitTypeId { get; set; }
        public string VehicleTypeId { get; set; }

    }
}