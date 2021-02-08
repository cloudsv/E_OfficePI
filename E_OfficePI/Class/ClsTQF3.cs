using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class ClsTQF3
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

        
        public string Subjectgroup { get; set; }
        public string SubjectDesc { get; set; }
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
        public string Totalhour { get; set; }
        public string Theoryhour { get; set; }
        public string Addtionaltech { get; set; }
        public string Practicalhour { get; set; }
        public string Researchhour { get; set; }


        public string Stategybystudent { get; set; }
        public string Stategybyteaching { get; set; }
        public string Improveteaching { get; set; }
        public string Reestimate { get; set; }
        public string Planningimprove { get; set; }
        public string Stategyother { get; set; }

        public string error { get; set; }
        public List<TQFInstructor> ResponsibleInstructor { get; set; }
        public List<TQFInstructor> TheoryInstructor { get; set; }
        public List<TQFInstructor> ExtraInstructor { get; set; }
    }
    public class TQFInstructor
    {
        public string Id { get; set; }
        public string Empid { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
        public string Fullname { get; set; }
        public string EducationalBackground { get; set; }
        public string Exp { get; set; }
        public string Adviceplace { get; set; }
        public string AdviceEmail { get; set; }
        public string Advicedateandtime { get; set; }
    }
}