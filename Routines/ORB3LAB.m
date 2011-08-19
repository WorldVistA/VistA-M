ORB3LAB ; slc/CLA/TC - Routine to trigger Lab-related notifications ;10/14/03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**210,243**;Dec 17, 1997;Build 242
 ;
LAB(ORDFN,ORLRDFN,ORLRI,ORLRA,ORLRSS,ORXQA) ;trigger Lab Anatomic Path notifs
 ; called by SEND^LRAPRES1 (DBIA #4287)
 ;
 N ORBMSG,ORAPMD,ORBADUZ,ORSRPT,ORACCNO
 I '$D(ORXQA) D
 . S ORAPMD=$S(ORLRSS="AU":$P(ORLRA,U,12),1:$P(ORLRA,U,7))  ;provider/physician "ordering" the ap test
 . I $L(ORAPMD) S ORBADUZ(ORAPMD)=""
 I $D(ORXQA) M ORBADUZ=ORXQA
 S ORSRPT=$S($D(^LR(ORLRDFN,84,0))!($D(^LR(ORLRDFN,ORLRSS,ORLRI,1.2,0))):" supplmntl rpt",1:"") ; AP supplmntl rpt - DBIA #5157
 S ORBMSG=$S(ORLRSS="AU":"Autopsy",ORLRSS="CY":"Cytology",ORLRSS="SP":"Surgical Pathology",ORLRSS="EM":"Electron Microscopy",1:"Anatomic Pathology")
 S ORBMSG=ORBMSG_ORSRPT_" results available."
 S ORACCNO=$P(ORLRA,U,6)  ;accession # of lab section
 D EN^ORB3(71,ORDFN,"",.ORBADUZ,ORBMSG,ORLRSS_U_ORACCNO_U_ORLRI)  ;XQADATA="Lab section^Accession#^DT specimen taken (inverse format)"
 Q
