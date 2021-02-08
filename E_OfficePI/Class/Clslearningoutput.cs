using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace E_OfficePI.Class
{
    public class Clslearningoutputset
    {
        public string id { get; set; }
        public List<Clslearningoutput> Learningoutputs { get; set; }
        public List<Clsparticular> Particulars { get; set; }
        public List<Clsestimate> Estimates { get; set; }
    }
    public class Clsparticular
    {

        public string Particularid { get; set; }
        public string Particularname { get; set; }


        public string Learningparticularid { get; set; }
        
    }
    public class Clsestimate
    {
        public string Estimateid { get; set; }
        public string Estimatename { get; set; }
        public string Learningestimateid { get; set; }
        public string EstiLearningestimateidmatename { get; set; }
        
    }
    public class Clslearningoutput
    {
        public string Learningoutputid { get; set; }
        public string Learningoutputname { get; set; }
        public string Learningoutputdesc { get; set; }
        
        public List<Clsparticular> MasterParticulars { get; set; }
        public List<Clsestimate> MasterEstimates { get; set; }

        public List<Clsparticular> Particulars { get; set; }
        public List<Clsestimate> Estimates { get; set; }


        public List<Clsestimate> TemplateEstimates { get; set; }

        public List<Clsparticular> Templateparticulars { get; set; }
        


    }
}