using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class ClsTree
    {
        public string OrgId { get; set; }
        public string OrgCode { get; set; }
        public string OrgName { get; set; }
        public string IsEducate { get; set; }
        public List<ClsTree> Trees { get; set; }
    }
}