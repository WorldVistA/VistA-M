SD53P511 ;ALB/RLC;POST-INIT RTN FOR EMERGENCY PATCH SD*5.3*511 ; 4/5/07 9:30am
 ;;5.3;Scheduling;**511**;Aug 13, 1993;Build 4
 ;
 ;The purpose of this post-init routine is to update all encounters that
 ;were created on or after March 1, 2007, through April 8, 2007 (the
 ;compliance date for patch SD*5.3*500).  Patch SD/500 inactivated
 ;Stop Code 101 and activated Stop Code 130 (which replaces 101), both
 ;effective March 1, 2007.  However, the patch was not released until
 ;March 8, 2007, with a compliance date of April 8, 2007.
 ;This routine will change the Stop Code from 101 to 130, for all
 ;applicable encounters that are within the above date range.
 ;
EN ;
 K ^TMP("UPDATE",$J)
 N BEG,END,OLD,ACT,EIN,NODE
 S BEG=3070301,END=3070408.999999
 S OLD=$O(^DIC(40.7,"C",101,"")),ACT=$O(^DIC(40.7,"C",130,""))
 F  S BEG=$O(^SCE("B",BEG)) Q:BEG>END!('BEG)  D
 .S EIN=0
 .F  S EIN=$O(^SCE("B",BEG,EIN)) Q:'EIN  S NODE=^SCE(EIN,0) D
 ..Q:$P(NODE,U,3)'=OLD
 ..S $P(^SCE(EIN,0),U,3)=ACT
 ..S ^TMP("UPDATE",$J,EIN)=""
 D MSG
 K BEG,END,EIN,NODE,CNT,OLD,ACT,^TMP("UPDATE",$J)
 Q
 ;
MSG ;
 N DVPARAM,XMDUZ,XMSUB,XMTEXT,XMY,MSGTXT,CT,UPD,PAT,SSN,ENCDT
 S CT=0
 S CT=CT+1,MSGTXT(CT)="The following list of encounters have had their stop code"
 S CT=CT+1,MSGTXT(CT)="updated from 101 to 130 in the Outpatient Encounter file."
 S CT=CT+1,MSGTXT(CT)=""
 I '$D(^TMP("UPDATE",$J)) S CT=CT+1,MSGTXT(CT)="No encounters found, for the date range March 1, 2007 to April 8, 2007,",CT=CT+1,MSGTXT(CT)="that require updating." G SEND
 S EIN=0,UPD=""
 F  S EIN=$O(^TMP("UPDATE",$J,EIN)) Q:'EIN  D
 .S UPD=^SCE(EIN,0)
 .S ENCDT=$$FMTE^XLFDT($P(UPD,U,1),"2FP"),PAT=$P(^DPT($P(UPD,U,2),0),U,1),SSN=$P(^DPT($P(UPD,U,2),0),U,9),SSN=$E(SSN,6,9)
 .S CT=CT+1,MSGTXT(CT)="PATIENT: "_PAT
 .S CT=CT+1,MSGTXT(CT)="    SSN: "_SSN_"     ENC DATE/TIME: "_ENCDT
 .S CT=CT+1,MSGTXT(CT)=""
SEND S XMTEXT="MSGTXT"
 S DVPARAM("FROM")="EMERGENCY PATCH SD*5.3*511"
 S XMDUZ=DUZ,XMSUB="STOP CODE UPDATE FROM 101 TO 130",XMY(DUZ)=""
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.DVPARAM,"","")
 K XMDUZ,XMSUB,XMY,CT,MSGTXT,UPD,PAT,SSN,ENCDT
 Q
