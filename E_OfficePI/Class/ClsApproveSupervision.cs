using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class ClsApproveSupervision
    {
        public string Userid { get; set; }
        public string Empno { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }

        public string Validatoruserid { get; set; }
        public string Validatorfullname { get; set; }
        public string Approveruserid { get; set; }
        public string Approverfullname { get; set; }

        public List<Clsapproverusers> Validatorusers { get; set; }
        public List<Clsapproverusers> Approverusers { get; set; }
    }
}