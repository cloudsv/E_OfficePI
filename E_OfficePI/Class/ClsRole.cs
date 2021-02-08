using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class ClsRole
    {
        public string Roleid { get; set; }
        public string Rolename { get; set; }
        public List<Clsuser> Users { get; set; }
    }
}