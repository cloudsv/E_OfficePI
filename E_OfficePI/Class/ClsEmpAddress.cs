using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class ClsEmpAddress
    {
        public string id { get; set; }
        public string Userid { get; set; }

        public string Addresstype { get; set; }
        
        public string Address { get; set; }
        public string Provinceid { get; set; }
        public string Provincenameth { get; set; }
        public string Districtid { get; set; }
        public string Districtnameth { get; set; }
        public string Subdistrictid { get; set; }
        public string SubDistrictnameth { get; set; }
        public string Postcode { get; set; }
    }
}