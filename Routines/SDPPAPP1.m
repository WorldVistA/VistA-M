SDPPAPP1 ;ALB/CAW - Display Appointments; 5/4/92
 ;;5.3;Scheduling;**6,22,140,80,517**;Aug 13, 1993;Build 4
 ;
 ;
EN1 ; Loop through appt. date/time
 N SDAP,SDCI,SDOB,SDPDATA,SDPOV,SDPV,SDWHEN,SDSTART,SDSTOP
 S SDFST=13,SDSEC=55,SDLEN=25,$P(SDASH,"-",IOM+1)="",SDSTART=$S($D(SDBEG):SDBEG,'SDBD:SDBD,1:SDBD-.1),SDSTOP=$S($D(SDEND):SDEND,1:SDED)
 F SDDT=SDSTART:0 S SDDT=$O(^DPT(DFN,"S",SDDT)) Q:'SDDT!(SDDT>(SDSTOP+.9))  D
 .S SDPDATA=^(SDDT,0)
 .I $D(SDY),SDY'=+SDPDATA Q
 .S ^TMP("SDAPT",$J,-SDDT,0)=SDPDATA
 .I $D(^DPT(DFN,"S",SDDT,"R")) S ^TMP("SDAPT",$J,-SDDT,"R")=^DPT(DFN,"S",SDDT,"R")
 .S POP=0 F SDAP=0:0 S SDAP=$O(^SC(+SDPDATA,"S",SDDT,1,SDAP)) Q:'SDAP  D CHK Q:POP  S SDCDATA=$G(^SC(+SDPDATA,"S",SDDT,1,SDAP,0)),SDCI=$G(^("C")),SDOB=$G(^("OB")) I +SDCDATA=DFN S ^TMP("SDAPT",$J,-SDDT,1)=SDCDATA,^("C")=SDCI  ;SD/517 added CHK
 .I '$D(SDCDATA) S (SDCDATA,SDCI,SDOB)=0 S ^TMP("SDAPT",$J,-SDDT,1)=SDCDATA,^("C")=SDCI
 .K SDCDATA
 F I=-9999999.99:0 S I=$O(^TMP("SDAPT",$J,I)) Q:'I  S SDWHEN=$E(I,2,999),SDPDATA=^(I,0),SDCDATA=$G(^(1)),SDCI=$G(^("C")),SDREMARK=$G(^("R")) D INFO
 K ^TMP("SDAPT",$J),POP
 Q
 ;
CHK ;SD/517
 Q:$D(^SC(+SDPDATA,"S",SDDT,1,SDAP,0))
 S SDCDATA=DFN_U_0
 S ^TMP("SDAPT",$J,-SDDT,1)=SDCDATA
 S POP=1
 Q
 ;
INFO ; Set information
 ;
DATE ; Date/Time and Type
 S X="",X=$$SETSTR^VALM1("Date/Time:",X,2,10)
 S X=$$SETSTR^VALM1($TR($$FMTE^XLFDT(SDWHEN,"5F")," ","0"),X,SDFST,SDLEN)
 S X=$$SETSTR^VALM1("Type:",X,49,5)
 S X=$$SETSTR^VALM1($P($G(^SD(409.1,+$P(SDPDATA,U,16),0)),U),X,SDSEC,SDLEN)
 D SET(X)
CLINIC ; Clinic and Eligibility of Visit
 S X="",X=$$SETSTR^VALM1("Clinic:",X,5,7)
 S X=$$SETSTR^VALM1($P($G(^SC(+SDPDATA,0)),U),X,SDFST,SDLEN)
 I $P(SDCDATA,U,10)'="" D
 .S X=$$SETSTR^VALM1("Elig. of Vst.:",X,40,14)
 .S X=$$SETSTR^VALM1($P($G(^DIC(8,+$P(SDCDATA,U,10),0)),U),X,SDSEC,SDLEN)
 D SET(X)
STAT ; Status and Clerk
 S X="",X=$$SETSTR^VALM1("Status:",X,5,7)
 S X=$$SETSTR^VALM1($P($$STATUS^SDAM1(DFN,SDWHEN,+SDPDATA,SDPDATA),";",3),X,SDFST,SDLEN)
 S X=$$SETSTR^VALM1("Clerk:",X,48,6)
 S X=$$SETSTR^VALM1($P($G(^VA(200,$S($P(SDCDATA,U,6):$P(SDCDATA,U,6),1:+$P(SDPDATA,U,18)),0)),U),X,SDSEC,SDLEN)
 D SET(X)
PURP ; Purpose of Visit and Date Appt. Made
 S X="",X=$$SETSTR^VALM1("POV:",X,8,4)
 S SDPOV=$P(SDPDATA,U,7),SDPV=$S(SDPOV=1:"C&P",SDPOV=2:"10-10",SDPOV=3:"SCHEDULED",SDPOV=4:"UNSCHEDULED",1:"UNKNOWN")
 S X=$$SETSTR^VALM1(SDPV,X,SDFST,SDLEN)
 S X=$$SETSTR^VALM1("Date Made:",X,44,10)
 S X=$$SETSTR^VALM1($TR($$FMTE^XLFDT($S($P(SDCDATA,U,7):$P(SDCDATA,U,7),1:$P(SDPDATA,U,19)),"5DF")," ","0"),X,SDSEC,SDLEN)
 D SET(X)
CI ; Checked-In and Checked-Out Times
 S X=""
 I +SDCI D
 .S X=$$SETSTR^VALM1("Checked-In:",X,1,11)
 .S X=$$SETSTR^VALM1($$FMTE^XLFDT($P(SDCI,U),"5"),X,SDFST,SDLEN)
 I $P(SDCI,U,3)'="" D
 .S X=$$SETSTR^VALM1("Checked-Out:",X,42,12)
 .S X=$$SETSTR^VALM1($TR($$FMTE^XLFDT($P(SDCI,U,3),"5F")," ","0"),X,SDSEC,SDLEN)
 ;following logic for Warning added per SD/517
 I $D(SDCDATA) I $P(SDCDATA,U,2)=0 D
 .S X="" D SET(X)
 .D SET("**************************** WARNING *******************************************")
 .D SET("There is a data inconsistency or data corruption problem with the above")
 .D SET("appointment.  Corrective action needs to be taken.  Please cancel")
 .D SET("the appointment above.  If it is a valid appointment, it will have to")
 .D SET("be re-entered via Appointment Management.")
 .D SET("********************************************************************************")
 .S X="" D SET(X)
 ;
 D:X'="" SET(X)
 D ^SDPPAPP2
 Q
SET(X) ; Set in ^TMP global for display
 ;
 S SDLN=SDLN+1,^TMP("SDPPALL",$J,SDLN,0)=X
 S VALMCNT=SDLN
 Q
