DVBCAMR1 ;ALB/GTS-557/THM-REGIONAL OFFICE AMIS REPORT BULLETIN TEXT ; 9/28/91  6:39 AM
 ;;2.7;AMIE;**149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Input: DVBACDE - Priority of Exam code to get Totals for
BULLTXT(DVBACDE) ;
 N DVBATXT,DVBADTS
 S DVBATXT=$$PRHD^DVBCIUTL(DVBACDE)
 S DVBATXT=$S(DVBATXT["Excludes":"Report "_DVBATXT,1:"Report for "_DVBATXT)
 ;DES Type exams required to be completed in 45 days, all others 30
 S DVBADTS=$S(((";DCS;DFD;")[(";"_DVBACDE_";")):45,1:30)
 ;.01,.02 printed only in bulletin (if generated)
 S ^TMP($J,.01,0)=DVBATXT
 S ^TMP($J,.02,0)=" "
 S ^TMP($J,1,0)="For regional office: "_RONAME_" ("_RONUM_")"
 S ^TMP($J,2,0)=" "
 S ^TMP($J,3,0)="Requests sent for date range: "_TOT("SENT")
 S ^TMP($J,4,0)="Exams received incomplete: "_TOT("INCOMPLETE")
 S ^TMP($J,5,0)="Exams received complete: "_TOT("COMPLETED")
 S ^TMP($J,5.3,0)="Exams returned as insufficient: "_TOT("INSUFF")_"  ("_$S(TOT("SENT")>0:$J(TOT("INSUFF")/TOT("SENT")*100,0,0),1:0)_"%)"
 S ^TMP($J,6,0)="Pending for office "_RONUM_" at end of month: "_TOT("PENDADJ")
 S ^TMP($J,7,0)="Average processing time: "_TOT("AVGDAYS")_$S(TOT("AVGDAYS")>1!(TOT("AVGDAYS")<1):" days",1:" day")
 S ^TMP($J,8,0)=" "
 S ^TMP($J,9,0)="Greater than 3 days to schedule: "_TOT("3DAYSCH")
 S ^TMP($J,10,0)="Greater than "_DVBADTS_" days to examine: "_TOT("30DAYEX")
 S ^TMP($J,11,0)=" "
 S ^TMP($J,12,0)="Pending, 0-90 days: "_TOT("P90")
 S ^TMP($J,13,0)="Pending, 91-120 days: "_TOT("P121")
 S ^TMP($J,14,0)="Pending, 121-150 days: "_TOT("P151")
 S ^TMP($J,15,0)="Pending, 151-180 days: "_TOT("P181")
 S ^TMP($J,16,0)="Pending, 181-365 days: "_TOT("P365")
 S ^TMP($J,17,0)="Pending, 366 or more days: "_TOT("P366")
 Q
