using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class ClsTeachingplandetail
    {
        public string id { get; set; }
        public string TQFId { get; set; }
        public string Teachingplandetailsubject { get; set; }
        public string Teachingplandetaildesc { get; set; }
        public string Teachingplandetailstudent { get; set; }
        public string Teachingplandetailplace { get; set; }

        public List<ClsTeachingplandetailAttachment> Teachingplandetailattchmentplan { get; set; }
        public List<ClsTeachingplandetailAttachment> Teachingplandetailattchmentconclusion { get; set; }

    }
    public class ClsTeachingplandetailAttachment
    {
        public string Attachmentid { get; set; }
        public string Filename { get; set; }
        public string Url { get; set; }
    }
}