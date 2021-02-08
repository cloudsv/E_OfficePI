using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class ClsEstimatePlan
    {
        public string id { get; set; }
        public string TQFId { get; set; }
        public string Week { get; set; }
        public string Percent { get; set; }
        public List<ClsEstimateplannobjective> Estimateplanobjective { get; set; }
        public List<ClsEstimateplannestimate> Estimateplannestimate { get; set; }

    }


    public class ClsEstimateplannestimate
    {
        public string id { get; set; }
        public string Estimateid { get; set; }
        public string Estimatename { get; set; }
        public string Selected { get; set; }
    }
    
    public class ClsEstimateplannobjective
    {
        public string id { get; set; }
        public string Objectiveid { get; set; }
        public string Code { get; set; }
        public string Objective { get; set; }
        public string Selected { get; set; }
    }

   
}