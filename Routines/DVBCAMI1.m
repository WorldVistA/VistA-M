DVBCAMI1 ;ALB/GTS-557/THM-AMIS REPORT/BULLETIN TEXT ; 10/4/91  8:48 AM
 ;;2.7;AMIE;**17,149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Input : DVBACDE - Priority of Exam code to get Totals for
BULLTXT(DVBACDE) ;
 N DVBATXT,DVBADTS
 S TOTRECV=TOT("RECEIVED")+TOT("INSUFF"),TOTRVTN=TOTRECV+TOT("TRANSIN")
 S DVBATXT=$$PRHD^DVBCIUTL(DVBACDE)
 S DVBATXT=$S(DVBATXT["Excludes":"Report "_DVBATXT,1:"Report for "_DVBATXT)
 ;DES Type exams required to be completed in 45 days, all others 30
 S DVBADTS=$S(((";DCS;DFD;")[(";"_DVBACDE_";")):45,1:30)
 ;.01,.02 printed only in bulletin (if generated)
 S ^TMP($J,.01,0)=DVBATXT
 S ^TMP($J,.02,0)=" "
 S ^TMP($J,1,0)="Processing date: "_$$FMTE^XLFDT(DT,"5DZ")
 S ^TMP($J,2,0)=" "
 S ^TMP($J,3,0)="Total pending from previous month: "_PREVMO
 S ^TMP($J,4,0)=" "
 S ^TMP($J,5,0)="Requests received for date range: "_TOT("RECEIVED")
 S ^TMP($J,5.1,0)=" "
 S ^TMP($J,5.3,0)="Exams returned as insufficient: "_TOT("INSUFF")_"  ("_$S(TOTRECV>0:$J(TOT("INSUFF")/TOTRECV*100,0,0),1:0)_"%)"
 S ^TMP($J,6,0)="Requests returned complete: "_TOT("COMPLETED")
 S ^TMP($J,7,0)="Requests returned incomplete: "_TOT("INCOMPLETE")
 S ^TMP($J,8,0)=" "
 S ^TMP($J,8.1,0)="Total processing time: "_TOT("DAYS")_$S(TOT("DAYS")=1:" day",1:" days")
 S ^TMP($J,8.2,0)=" "
 S ^TMP($J,9,0)="Pending end of month: "_TOT("PENDADJ")
 S ^TMP($J,10,0)="Average processing time: "_TOT("AVGDAYS")_$S(TOT("AVGDAYS")>1!(TOT("AVGDAYS")<1):" days",1:" day")
 S ^TMP($J,11,0)=" "
 S ^TMP($J,12,0)="Greater than 3 days to schedule: "_TOT("3DAYSCH")
 S ^TMP($J,13,0)="Greater than "_DVBADTS_" days to examine: "_TOT("30DAYEX")
 S ^TMP($J,14,0)=" "
 S ^TMP($J,15,0)="Pending, 0-90 days: "_TOT("P90")
 S ^TMP($J,16,0)="Pending, 91-120 days: "_TOT("P121")
 S ^TMP($J,17,0)="Pending, 121-150 days: "_TOT("P151")
 S ^TMP($J,18,0)="Pending, 151-180 days: "_TOT("P181")
 S ^TMP($J,19,0)="Pending, 181-365 days: "_TOT("P365")
 S ^TMP($J,20,0)="Pending, 366 or more days: "_TOT("P366")
 S ^TMP($J,21,0)=" "
 S ^TMP($J,22,0)="Transfers in from other sites: "_TOT("TRANSIN")_"  ("_$S(TOTRVTN>0:$J(TOT("TRANSIN")/TOTRVTN*100,0,0),1:0)_"%)"
 S ^TMP($J,23,0)="Transfers returned to other sites: "_TOT("TRNRETTO")
 S ^TMP($J,24,0)="Transfers pending return to other sites: "_TOT("TRNPNDTO")
 S ^TMP($J,25,0)=" "
 S ^TMP($J,26,0)="Transfers out to other sites: "_TOT("TRANSOUT")_"  ("_$S(TOTRVTN>0:$J(TOT("TRANSOUT")/TOTRVTN*100,0,0),1:0)_"%)"
 S ^TMP($J,27,0)="Transfers returned from other sites: "_TOT("TRNRETFR")
 S ^TMP($J,28,0)="Transfers pending return from other sites: "_TOT("TRNPNDFR")
 S ^TMP($J,29,0)=" "
 S ^TMP($J,32,0)=" ** Transfer figures are for information only **"
 S ^TMP($J,33,0)="* and should not be used to balance this report *"
 K DIC,DIE,DR,DA,TOTRECV,TOTRVTN
 Q
