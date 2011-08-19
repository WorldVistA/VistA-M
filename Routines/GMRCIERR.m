GMRCIERR ;SLC/JFR - process IFC message error alert ;07/08/03 11:16
 ;;3.0;CONSULT/REQUEST TRACKING;**22,28,30,35,58**;DEC 27, 1997;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
EN(GMRCLOG,GMRCDA,GMRCACT,GMRCRPT) ;start here
 ;Build ^TMP array for processing alert
 ;
 K ^TMP("GMRCIERR",$J)
 N GMRCPNM,GMRCACTV,GMRCERR,GMRCRP,GMRCEP,GMRCACTM,GMRCCOM,GMRCSS
 N GMRCPROC,GMRCSITE,GMRCFCN,GMRCPT,GMRCSSN,VAHOW,VAROOT
 I '$D(^GMR(123.6,GMRCLOG,0)) D  Q
 . S ^TMP("GMRCIERR",$J,1,0)="Message log entry no longer exists"
 I $P(^GMR(123.6,GMRCLOG,0),U,4)'=GMRCDA D  Q
 . S ^TMP("GMRCIERR",$J,1,0)="Message log entry and Consult# don't match"
 I $P(^GMR(123.6,GMRCLOG,0),U,5)'=GMRCACT D  Q
 . S ^TMP("GMRCIERR",$J,1,0)="Message log entry & activity# don't match"
 S DFN=$P(^GMR(123,GMRCDA,0),U,2),VAROOT="GMRCPT",VAHOW=1
 D DEM^VADPT
 S GMRCPNM=GMRCPT("NM")
 S GMRCSSN=$P(GMRCPT("SS"),U,2)
 S GMRCACTV=$G(^GMR(123,GMRCDA,40,GMRCACT,0))
 S GMRCRP=$$GET1^DIQ(200,+$P(GMRCACTV,U,4),.01)
 S GMRCEP=$$GET1^DIQ(200,+$P(GMRCACTV,U,5),.01)
 S GMRCACTM=$$FMTE^XLFDT($P(GMRCACTV,U,3))
 S GMRCACTV=$$GET1^DIQ(123.1,$P(GMRCACTV,U,2),.01)
 S GMRCCOM=$O(^GMR(123,GMRCDA,40,GMRCACT,1,0))
 S GMRCSS=$$GET1^DIQ(123.5,+$P(^GMR(123,GMRCDA,0),U,5),.01)
 S GMRCPROC=$$GET1^DIQ(123.3,+$P(^GMR(123,GMRCDA,0),U,8),.01)
 S GMRCFCN=$P(^GMR(123,GMRCDA,0),U,22)
 D F4^XUAF4($$STA^XUAF4($P(^GMR(123,GMRCDA,0),U,23)),.GMRCSITE)
 N LN S LN=1
 S ^TMP("GMRCIERR",$J,LN,0)="An error occurred transmitting the following inter-facility consult ",LN=LN+1
 S ^TMP("GMRCIERR",$J,LN,0)="activity to "_GMRCSITE("NAME")_":",LN=LN+1
 S ^TMP("GMRCIERR",$J,LN,0)="",LN=LN+1
 S ^TMP("GMRCIERR",$J,LN,0)="Consult #: "_GMRCDA,LN=LN+1
 S ^TMP("GMRCIERR",$J,LN,0)="Remote Consult #: "_GMRCFCN,LN=LN+1
 S ^TMP("GMRCIERR",$J,LN,0)="Patient Name: "_GMRCPNM,LN=LN+1
 S ^TMP("GMRCIERR",$J,LN,0)="SSN: "_GMRCSSN,LN=LN+1
 S ^TMP("GMRCIERR",$J,LN,0)="To Service: "_GMRCSS,LN=LN+1
 I $L(GMRCPROC) S ^TMP("GMRCIERR",$J,LN,0)="Procedure: "_GMRCPROC,LN=LN+1
 S ^TMP("GMRCIERR",$J,LN,0)="",LN=LN+1
 I '$D(GMRCRPT) D ACTLG(GMRCDA,GMRCACT,GMRCLOG,.LN)
 Q
ACTLG(GMRCDA,GMRCACT,LOG,LN) ;build activity log entry
 N GMRCCT,TAB,GMRCERR,GMRCDIF
 S TAB="",$P(TAB," ",30)=""
 S GMRCERR=$T(@("ERR"_$P(^GMR(123.6,LOG,0),U,8)_"^GMRCIUTL"))
 S GMRCERR=$S($L(GMRCERR):$P(GMRCERR,";",2),1:"Technical error")
 S ^TMP("GMRCIERR",$J,LN,0)="Activity #: "_GMRCACT,LN=LN+1
 S ^TMP("GMRCIERR",$J,LN,0)="Activity"_$E(TAB,1,17)_"Date/Time/Zone"_$E(TAB,1,6)_"Responsible Person"_$E(TAB,1,2)_"Entered By",LN=LN+1
 S GMRCCT=LN
 D BLDALN^GMRCSLM4(GMRCDA,GMRCACT)
 S ^TMP("GMRCIERR",$J,LN,0)="",LN=LN+1
 S ^TMP("GMRCIERR",$J,LN,0)="",LN=LN+1
 S ^TMP("GMRCIERR",$J,LN,0)="The error was: "_GMRCERR
 M ^TMP("GMRCIERR",$J)=^TMP("GMRCR",$J,"DT")
 K ^TMP("GMRCR",$J,"DT")
 Q
 ;
DIALOG(GMRCDATA) ;ask user what to do based on error and activity
 ;Input:
 ;  GMRCDATA  = XQADATA from alert handler
 ;      in form:   IFC_msg_log#|consult#|activity#
 ;
 ;Output:
 ;  value to set XQAKILL to
 N DIR,X,Y,LN,DUOUT,DTOUT
 D EN($P(GMRCDATA,"|"),$P(GMRCDATA,"|",2),$P(GMRCDATA,"|",3))
 W @IOF
 S LN=0 F  S LN=$O(^TMP("GMRCIERR",$J,LN)) Q:'LN  W !,^(LN,0)
 W !
 I $O(^TMP("GMRCIERR",$J," "),-1)<2 Q 0 ;some problem so delete alert
 S DIR(0)="E" D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q "@"
 W !
 I $O(^GMR(123.6,"AC",$P(GMRCDATA,"|",2),$P(GMRCDATA,"|",3)),-1) D  Q "@"
 . W !,"There is at least one earlier incomplete transaction for this"
 . W !,"consult, all incomplete transactions should be processed in "
 . W !,"order.",!
 . W !,"You can use the List incomplete IFC transactions option to"
 . W !,"locate and process the incomplete transactions for this consult."
 . S DIR(0)="E" D ^DIR
 S DIR(0)="YA",DIR("B")="N"
 S DIR("A",1)="If you have corrected this problem you may resend this activity!"
 S DIR("A",2)=" "
 S DIR("A")="Do you want to retransmit this? " D ^DIR
 I $G(Y)=1 D  Q 0
 . D TRIGR^GMRCIEVT($P(GMRCDATA,"|",2),$P(GMRCDATA,"|",3)) ; re-transmit
 K DIR
 W !
 S DIR(0)="YA",DIR("B")="N"
 S DIR("A")="Do you want to delete this alert for all recipients? "
 D ^DIR
 I $G(Y)=1 Q 0
 W !
 S DIR(0)="YA",DIR("B")="N"
 S DIR("A")="Do you want to delete this alert for yourself only? "
 D ^DIR
 I $G(Y)=1 Q 1
 Q "@"
 ;
FOLLUP ;action to take from alert
 S XQAKILL=$$DIALOG(XQADATA)
 I XQAKILL="@" K XQAKILL
 K ^TMP("GMRCIERR",$J)
 Q
 ;
SNDALRT(GMRCLOG,TYPE,XQAMSG) ; send an alert on some errors
 ;Input:
 ; GMRCLOG = IFC MESSAGE LOG entry
 ; TYPE    = "C" for a clinical error, "T" for a technical error
 ;
 N XQA,XQAROU,XQADATA,XQAID,GROUP,GMRCACT,GMRCDA,GMRCLOG0
 S GMRCLOG0=$G(^GMR(123.6,GMRCLOG,0)) Q:'$L(GMRCLOG0)
 S GMRCDA=$P(GMRCLOG0,U,4) Q:'GMRCDA
 S GMRCACT=$P(GMRCLOG0,U,5) Q:'GMRCACT
 S GROUP=$S(TYPE="C":"G.IFC CLIN ERRORS",1:"G.IFC TECH ERRORS")
 S XQA(GROUP)=""
 I '$D(XQAMSG) S XQAMSG="Failed IFC transaction"
 S XQAROU="FOLLUP^GMRCIERR"
 S XQAID="GMRCIFC,trans error,"_GMRCLOG
 S XQADATA=GMRCLOG_"|"_GMRCDA_"|"_GMRCACT
 D SETUP^XQALERT
 Q
PTERRMSG(GMRCPID,GMRCSTA,GMRCDOM,GMRCOBR) ;send IFC pt err to mail group
 ;Input:
 ;  GMRCPID = PID seg from IFC message
 ;  GMRCSTA = station # of site where message originated
 ;  GMRCDOM = domain to send the message to, if defined   (optional)
 ;  GMRCOBR = OBR segment from IFC msg  (optional)
 ;
 ;Output:
 ;  mail message containing patient demographics
 ;
 N GMRCGRP,GMRCMSG,GMRCNM,GMRCNAM,GMRCDOB
 N XMERR,GMRCSUB,GMRCSITE,GMRCERR,GMRCICN
 N XMTEXT,XMY,XMDUZ,XMSUB,XMZ,XMMG
 S GMRCNAM=$P(GMRCPID,"|",5)
 S GMRCNM("FAMILY")=$P(GMRCNAM,U),GMRCNM("GIVEN")=$P(GMRCNAM,U,2)
 S GMRCNM("MIDDLE")=$P(GMRCNAM,U,3),GMRCNM("SUFFIX")=$P(GMRCNAM,U,4)
 S GMRCNAM=$$NAMEFMT^XLFNAME(.GMRCNM,"F","CL56Xc")
 S GMRCDOB=$$HL7TFM^XLFDT($P(GMRCPID,"|",7))
 S GMRCDOB=$$FMTE^XLFDT(GMRCDOB)
 S GMRCICN=+$P(GMRCPID,"|",2)
 D F4^XUAF4(GMRCSTA,.GMRCSITE)
 S GMRCMSG(1,0)="An Inter-facility Consult for the following patient has been requested."
 S GMRCMSG(2,0)="The patient has either never been registered at your facility or the national"
 S GMRCMSG(3,0)="MPI ICN for this patient at your site does not match that from the requesting"
 S GMRCMSG(4,0)="site. Please refer to the Master Patient Index/Patient Demographics (MPI/PD)"
 S GMRCMSG(5,0)="User Manual and Master Patient Index/Patient Demographics Exception"
 S GMRCMSG(6,0)="Handling Manuals to resolve this error so the request may be processed."
 S GMRCMSG(7,0)=" ",GMRCMSG(8,0)=" "
 S GMRCMSG(9,0)="Patient demographics from "_GMRCSITE("NAME")
 S GMRCMSG(10,0)="   Patient name: "_GMRCNAM
 S GMRCMSG(11,0)="            SSN: "_$P(GMRCPID,"|",19)
 S GMRCMSG(12,0)="  Date of birth: "_GMRCDOB
 S GMRCMSG(13,0)="            Sex: "_$P(GMRCPID,"|",8)
 S GMRCMSG(14,0)="     Remote ICN: "_GMRCICN
 S GMRCMSG(15,0)=" "
 ;
 S XMSUB="Incoming IFC patient error, "_GMRCNAM
 S XMDUZ="Consult/Request Tracking Package"
 D XMZ^XMA2
 I $L($G(GMRCOBR)) D
 . N GMRCITM
 . S GMRCITM=$P(GMRCOBR,"|",4)
 . I $P(GMRCITM,U,2)["SUICIDE HOTLINE" D
 .. N DIE,DA,DR
 .. S DIE=3.9,DA=XMZ,DR="1.7////P" D ^DIE K DIE,DA,DR
 . I GMRCITM["VA1235" S GMRCITM="Ordered service: "_$P(GMRCITM,U,2)
 . I GMRCITM["VA1233" S GMRCITM="  Ordered proc.: "_$P(GMRCITM,U,2)
 . S GMRCMSG(16,0)=GMRCITM
 S GMRCMSG(17,0)=" "
 S GMRCMSG(18,0)="   The error is: Unknown Patient (201)"
 D  ; set XMY to local group or remote group
 . I $D(GMRCDOM) S XMY("G.IFC CLIN ERRORS@"_GMRCDOM)="" Q
 . S XMY("G.IFC PATIENT ERROR MESSAGES")=""
 S XMTEXT="GMRCMSG("
 D EN1^XMD
 Q
 ;
PTMPIER(GMRCDFN) ;send IFC local MPI error to MAS mail group
 ;Input:
 ;  GMRCDFN = DFN from file 2 of patient with MPI problem
 ;
 ;Output:
 ;  mail message containing patient demographics
 ;
 N DFN,GMRCPT,GMRCMSG,VAHOW,VAROOT
 N XMTEXT,XMY,XMDUZ,XMSUB,XMZ,XMMG
 S DFN=GMRCDFN,VAHOW=1,VAROOT="GMRCPT"
 D DEM^VADPT
 S GMRCMSG(1,0)="An Inter-facility Consult for the following patient has been requested."
 S GMRCMSG(2,0)="The PATIENT file is either missing an ICN or contains a local ICN."
 S GMRCMSG(3,0)="Please refer to the Master Patient Index/Patient Demographics(MPI/PD) User"
 S GMRCMSG(4,0)="and Master Patient Index/Patient Demographics Exception Handling Manuals"
 S GMRCMSG(5,0)="to resolve this error so request may be processed."
 S GMRCMSG(6,0)=" "
 S GMRCMSG(7,0)="   Patient name: "_GMRCPT("NM")
 S GMRCMSG(8,0)="            SSN: "_$P(GMRCPT("SS"),U,2)
 S GMRCMSG(9,0)="  Date of birth: "_$P(GMRCPT("DB"),U,2)
 S GMRCMSG(10,0)="            Sex: "_$P(GMRCPT("SX"),U,2)
 S GMRCMSG(11,0)="  "
 S GMRCMSG(12,0)="   The error is: Local or unknown MPI identifiers (202)"
 ;
 S XMY("G.IFC PATIENT ERROR MESSAGES")=""
 S XMSUB="Outgoing IFC patient error, "_GMRCPT("NM")
 S XMDUZ="Consult/Request Tracking Package"
 S XMTEXT="GMRCMSG("
 D ^XMD
 Q
