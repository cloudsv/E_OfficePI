using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class Clstqfestimate
    {
        public string Estimateid { get; set; }
        public string Ratio { get; set; }
        public List<Clsestimateobjective> Objective { get; set; }
        public List<Clsestimateobjective> Templateobjective { get; set; }
    }
    public class Clsestimateobjective
    {
        public string Objectiveid { get; set; }
        public string Objectivename { get; set; }
    }
}