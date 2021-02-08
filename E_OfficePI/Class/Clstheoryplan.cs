using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class Clstheoryplan
    {
        public string id { get; set; }
        public string TQFId { get; set; }
        public string Weekno { get; set; }
        public string Trdate { get; set; }
        public string Trtime { get; set; }


        public string Teachingplanname { get; set; }
        public string Teachingplantopicname { get; set; }
        public string Instructorid { get; set; }
        public string Instructornameth { get; set; }

        public List<Clsapproverusers> Instructors { get; set; }

        public List<ClsTheoryplannobjective> Theoryplanobjective { get; set; }
        public List<ClsTheoryplannparticular> Theoryplannparticular { get; set; }
        //public List<ClsTheoryplanntopic> Theoryplanntopic { get; set; }
        public List<ClsTheoryplannestimate> Theoryplannestimate { get; set; }
        public string Createbynameth { get; set; }


    }
    public class ClsTheoryplannestimate
    {
        public string id { get; set; }
        public string Estimateid { get; set; }
        public string Estimatename { get; set; }
        public string Selected { get; set; }
    }
    public class ClsTheoryplannparticular
    {
        public string id { get; set; }
        public string Particularid { get; set; }
        public string Particularname { get; set; }
        public string Selected { get; set; }
    }
    public class ClsTheoryplannobjective
    {
        public string id { get; set; }
        public string Objectiveid { get; set; }
        public string Code { get; set; }
        public string Objective { get; set; }
        public string Selected { get; set; }
    }

    public class ClsTheoryplanntopic
    {
        public string id { get; set; }
        public string Teachingtopicid { get; set; }
        public string Teachingplanid { get; set; }
        public string Teachingplanname { get; set; }
        public string Teachingtopicname { get; set; }
        public string Teachingtopicdesc { get; set; }
    }
}