PXRMP4IW ; SLC/PKR - PXRM*2.0*4 init routine. ;08/14/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 Q
 ;
 ;==========================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 S ARRAY(1,1)="VA-WH BILATERAL MASTECTOMY"
 I MODE S ARRAY(1,2)="07/06/2005@14:12:52"
 S ARRAY(2,1)="VA-MST SCREENING"
 I MODE S ARRAY(2,2)="07/11/2005@14:08:48"
 S ARRAY(3,1)="VA-GEC REFERRAL CARE RECOMMENDATION"
 I MODE S ARRAY(3,2)="07/11/2005@14:13:35"
 S ARRAY(4,1)="VA-MHV INFLUENZA VACCINE"
 I MODE S ARRAY(4,2)="11/22/2005@14:34:28"
 ;S ARRAY(5,1)="VA-HTN ASSESSMENT BP >=160/100 REMINDER ONLY"
 ;I MODE S ARRAY(5,2)="12/05/2005@13:50:07"
 S ARRAY(6,1)="VA-QUERI LIST RULE UPDATE"
 I MODE S ARRAY(6,2)="04/11/2006@14:31:20"
 S ARRAY(6,1)="VA-GEC REFERRAL CARE RECOMMENDATION"
 I MODE S ARRAY(6,2)="04/27/2006@15:16:55"
 S ARRAY(6,1)="VA-GEC REFERRAL NURSING ASSESSMENT"
 I MODE S ARRAY(6,2)="04/27/2006@15:16:08"
 S ARRAY(7,1)="VA-*QUERI LIST RULE UPDATES"
 I MODE S ARRAY(6,2)="07/03/2006@11:00:54"
 S ARRAY(8,1)="VA-HTN ASSESSMENT BP >=140/90"
 I MODE S ARRAY(8,2)="07/11/2006@14:35:17"
 S ARRAY(9,1)="VA-HTN ASSESSMENT BP >=160/100"
 I MODE S ARRAY(9,2)="07/11/2006@14:35:42"
 Q
 ;
 ;===============================================================
MHVWEB ;Change the URL for the MHV reminders.
 N DA,FDA,MSG,NAME,TITLE,URL
 F NAME="VA-MHV CERVICAL CANCER SCREEN","VA-MHV DIABETES FOOT EXAM","VA-MHV DIABETES RETINAL EXAM","VA-MHV HYPERTENSION","VA-MHV INFLUENZA VACCINE","VA-MHV MAMMOGRAM SCREENING" D
 .S DA=$O(^PXD(811.9,"B",NAME,"")) Q:DA'>0
 .K ^PXD(811.9,DA,50)
 .S DA(1)=DA,DA=0
 .I NAME="VA-MHV CERVICAL CANCER SCREEN" D
 ..S TITLE="PAP TEST",URL="https://www2.healthwise.net/myhealthevet/Content/StdDocument.aspx?DOCHWID=hw5266&SECHWID=hw5269"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 ..;
 ..S TITLE="Cervical Cancer",URL="https://www2.healthwise.net/myhealthevet/Content/StdDocument.aspx?DOCHWID=tw9600&SECHWID=tw9601"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 .;
 .I NAME="VA-MHV DIABETES FOOT EXAM" D
 ..S TITLE="American Diabetes Association Foot Complications",URL="http://www.diabetes.org/type-2-diabetes/foot-complications.jsp"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 ..;
 ..S TITLE="Diabetic Neuropathy",URL="https://www2.healthwise.net/myhealthevet/Content/StdDocument.aspx?DOCHWID=tf4413&SECHWID=tf4416"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 ..;
 ..S TITLE="Diabetes and Foot Problems",URL="https://www2.healthwise.net/myhealthevet/Content/StdDocument.aspx?DOCHWID=uq2525abc&SECHWID=uq2525abc-sec"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 .;
 .I NAME="VA-MHV DIABETES RETINAL EXAM" D
 ..S TITLE="Diabetic Eye Disease",URL="https://www2.healthwise.net/myhealthevet/Content/StdDocument.aspx?DOCHWID=tf1308&SECHWID=tf1311"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 ..;
 ..S TITLE="American Diabetes Association- Eye Complications",URL="http://www.diabetes.org/type-2-diabetes/eye-complications.jsp"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 .;
 .I NAME="VA-MHV HYPERTENSION" D
 ..S TITLE="NHLBI: Your Guide to Lowering High Blood Pressure",URL="http://www.nhlbi.nih.gov/hbp/index.html"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 ..;
 ..S TITLE="Hypertension",URL="https://www2.healthwise.net/myhealthevet/Content/StdDocument.aspx?DOCHWID=hw62787&SECHWID=hw62789"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 .;
 .I NAME="VA-MHV INFLUENZA VACCINE" D
 ..S TITLE="CDC Website on Influenza",URL="http://www.cdc.gov/flu/"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 ..;
 ..S TITLE="Influenza",URL="https://www2.healthwise.net/myhealthevet/Content/StdDocument.aspx?DOCHWID=hw122012&SECHWID=hw122014"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 .;
 .I NAME="VA-MHV MAMMOGRAM SCREENING" D
 ..S TITLE="Breast Cancer",URL="https://www2.healthwise.net/myhealthevet/Content/StdDocument.aspx?DOCHWID=tv3614&SECHWID=tv3617"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 ..;
 ..S TITLE="Mammogram",URL="https://www2.healthwise.net/myhealthevet/Content/StdDocument.aspx?DOCHWID=hw214210&SECHWID=hw214213"
 ..S FDA(811.9002,"?+1,"_DA(1)_",",.01)=URL,FDA(811.9002,"?+1,"_DA(1)_",",.02)=TITLE
 ..D UPDATE^DIE("","FDA","","MSG") I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 Q
 ;
 ;===============================================================
LTL(LIST) ;This is the list of list templates that being distributed
 ;in the patch.
 S LIST(1)="PXRM EXTRACT COUNT RULE EDIT"
 S LIST(2)="PXRM EXTRACT COUNTING GROUPS"
 S LIST(3)="PXRM EXTRACT COUNTING GRP EDIT"
 S LIST(4)="PXRM EXTRACT COUNTING RULES"
 S LIST(5)="PXRM EXTRACT DEF DISPLAY"
 S LIST(6)="PXRM EXTRACT DEFINITION EDIT"
 S LIST(7)="PXRM EXTRACT DEFINITIONS"
 S LIST(8)="PXRM EXTRACT HELP"
 S LIST(9)="PXRM EXTRACT HISTORY"
 S LIST(10)="PXRM EXTRACT MANAGEMENT"
 S LIST(11)="PXRM EXTRACT SUMMARY"
 S LIST(12)="PXRM EXTRACT TRANSMISSIONS"
 S LIST(13)="PXRM LIST RULE MANAGEMENT"
 S LIST(14)="PXRM PATIENT LIST CREATION DOC"
 S LIST(15)="PXRM PATIENT LIST PATIENTS"
 S LIST(16)="PXRM PATIENT LIST USER"
 S LIST(17)="PXRM RULE SET TEST"
 Q
 ;
