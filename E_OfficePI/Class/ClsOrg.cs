using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class ClsOrg
    {
        public string Orgid { get; set; }
        public string Orgname { get; set; }
        public string Iseducate { get; set; }
        public List<Clsuser> Users { get; set; }
    }
}