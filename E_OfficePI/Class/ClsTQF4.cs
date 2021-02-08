using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class ClsTQF4
    {
        public string id { get; set; }
        public string Coursegroupid { get; set; }
        public string Coursegroupname { get; set; }
        public string OwnerorgId { get; set; }
        public string Ownerorgname { get; set; }
        public string Courseid { get; set; }
        public string Coursename { get; set; }
        public string Subjectid { get; set; }
        public string Subjectname { get; set; }
        public string SubjectnameEN { get; set; }
        public string Credits { get; set; }
        public string SubjectDesc { get; set; }
        public string Subjectgroup { get; set; }
        
        public string Prerequisite { get; set; }
        public string Corequisite { get; set; }
        public string LearningPlace { get; set; }
        public string Lastupdatesubject { get; set; }
        public string Status { get; set; }
        public string Statusname { get; set; }
        public string Term { get; set; }
        public string Class { get; set; }
        public string Year { get; set; }
        public string Generation { get; set; }
        public string Quann { get; set; }
        public string Objectivedesc { get; set; }
        public string SubjectremarkTH { get; set; }
        public string SubjectremarkEN { get; set; }

        public string Followtrainingfield { get; set; }
        public string Responsibleinstuctor { get; set; }
        public string Responsibleinstuctorpractical { get; set; }
        public string Resibleteacherassist { get; set; }
        public string Guide { get; set; }
        public string Accessary { get; set; }

        public string Preparestudent { get; set; }

        public string Preparestudentmethod { get; set; }
        public string Preparestudentoutput { get; set; }
        public string Prepareteacher { get; set; }
        public string Prepareteacherpractical { get; set; }
        public string Managerisk { get; set; }

        public string Student { get; set; }
        public string Studentperiod { get; set; }
        public string Studentperson { get; set; }
        public string Nurse { get; set; }
        public string Improve { get; set; }
        public string Improveobjective { get; set; }
        public string Improvedata { get; set; }
        public string Improveperson { get; set; }
        public string Other { get; set; }
        public string Instuctor { get; set; }
        public string Instuctorpractical { get; set; }
        public string Reestimate { get; set; }
        public string Reestimateperson { get; set; }
        public string Reestimateperiod { get; set; }
        public string Estimatestudent { get; set; }
        public string Reponsibleteacher { get; set; }
        public string Reponsiblecoteacher { get; set; }
        public string Summaryestimate { get; set; }

        public string error { get; set; }
        public List<TQFInstructor> ResponsibleInstructor { get; set; }
        public List<TQFInstructor> TheoryInstructor { get; set; }
        public List<TQFInstructor> ExtraInstructor { get; set; }
    }
}
