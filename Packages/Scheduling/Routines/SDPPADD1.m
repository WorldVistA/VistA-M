SDPPADD1 ;ALB/CAW - Patient Profile - Add/Edits ; 10/26/99 1:55pm
 ;;5.3;Scheduling;**2,6,140,132,180**;Aug 13, 1993
 ;
EN1 ; Set up variables
 N SDPPBEG,SDPPEND,SDPPQ
 S SDPPBEG=$S($G(SDBEG):SDBEG,$G(SDBD):SDBD,1:2850101)
 S SDPPEND=$S($G(SDEND):SDEND,1:SDED)
 D OPEN^SDQ(.SDPPQ)
 D INDEX^SDQ(.SDPPQ,"PATIENT/DATE","SET")
 D PAT^SDQ(.SDPPQ,DFN,"SET")
 D DATE^SDQ(.SDPPQ,SDPPBEG,SDPPEND,"SET")
 D SCANCB^SDQ(.SDPPQ,"D CB^SDPPADD1(Y,Y0,.SDSTOP)","SET")
 D ACTIVE^SDQ(.SDPPQ,"TRUE","SET")
 D SCAN^SDQ(.SDPPQ,"BACKWARD")
 D CLOSE^SDQ(.SDPPQ)
 Q
 ;
CB(SDOE,SDOE0,SDSTOP) ; -- callback
 IF $P(SDOE0,U,8)'=2 G CBQ ; -- use only if stop addition type
 ;
 IF $D(SDY),$P(SDOE0,U,3)'=SDY G CBQ ; -- check for specific stop code
 ;
 N SDPPCPT,SDVCPT,SDVCPT0,SDDT,SDIV,SDDV,SDFST,SDSEC,X,SDOPE
 S SDFST=16,SDSEC=58
 D GETCPT^SDOE(SDOE,"SDPPCPT")
 ;
 ; Date/Time and Last Edited By
 S X="",X=$$SETSTR^VALM1("Date/Time:",X,5,10)
 S X=$$SETSTR^VALM1($TR($$FMTE^XLFDT(+SDOE0,"5F")," ","0"),X,SDFST,24)
 S X=$$SETSTR^VALM1("Last Edited By:",X,42,15)
 S X=$$SETSTR^VALM1($P($G(^VA(200,+$P(SDOE0,U,99),0)),U),X,SDSEC,23)
 D SET(X)
 ;
 ; Stop Code and Appt. Type
 S X="",X=$$SETSTR^VALM1("Stop Code:",X,5,10)
 S X=$$SETSTR^VALM1($P($G(^DIC(40.7,+$P(SDOE0,U,3),0)),U),X,SDFST,24)
 S X=$$SETSTR^VALM1("Appt. Type:",X,46,11)
 S X=$$SETSTR^VALM1($P($G(^SD(409.1,+$P(SDOE0,U,10),0)),U),X,SDSEC,23)
 D SET(X)
 ;
 ; Associated Clinic and Eligibility for Visit
 S X="",X=$$SETSTR^VALM1("Assoc. Clinic:",X,1,14)
 S X=$$SETSTR^VALM1($P($G(^SC(+$P(SDOE0,U,4),0)),U),X,SDFST,24)
 S X=$$SETSTR^VALM1("Elig. for Visit:",X,41,16)
 S X=$$SETSTR^VALM1($P($G(^DIC(8,+$P(SDOE0,U,13),0)),U),X,SDSEC,23)
 D SET(X)
 ;
 ;*** Retrieve Procedures (CPT codes)***
 I $D(SDPPCPT) D
 . N CPTINFO,MODINFO,MODCODE,MODPTR,PTR
 . S X=""
 .; S X=$$SETSTR^VALM1("Procedure(s): ",X,2,14)
 . S SDVCPT=0
 . F  S SDVCPT=$O(SDPPCPT(SDVCPT)) Q:'SDVCPT  D
 . . S X=$$SETSTR^VALM1("Procedure(s): ",X,2,14)
 . .; S SDVCPT0=SDPPCPT(SDVCPT)
 . .; S:X="" X=$$SETSTR^VALM1("              ",X,2,14)
 . .; S X=X_$P($G(^ICPT(+SDVCPT0,0)),U)_" x "_+$P(SDVCPT0,U,16)
 . . S CPTINFO=$$CPT^ICPTCOD(+$G(SDPPCPT(SDVCPT)),,1)
 . . Q:CPTINFO'>0
 . . S X=X_$P(CPTINFO,"^",2)_" x "_$P($G(SDPPCPT(SDVCPT)),"^",16)_"  "_$P(CPTINFO,"^",3)
 . . S:X="" X=$$SETSTR^VALM1("              ",X,2,14)
 . . ;S:$O(SDPPCPT(SDVCPT)) X=X_", "
 . .; IF $L(X)>(IOM-10) D SET(X) S X=""
 . . D SET(X) S X=""
 . .;
 . .;Retrieve Procedure (CPT) Codes and associated Modifiers
 . . S PTR=0
 . . F  S PTR=$O(SDPPCPT(SDVCPT,1,PTR)) Q:'PTR  D
 . . . S MODPTR=$G(SDPPCPT(SDVCPT,1,PTR,0))
 . . . S MODINFO=$$MOD^ICPTMOD(MODPTR,"I",,1)
 . . . Q:MODINFO'>0
 . . . S MODTEXT=$P(MODINFO,"^",3)
 . . . S MODCODE="-"_$P(MODINFO,"^",2)
 . . . S X=$$SETSTR^VALM1(MODCODE,X,18,21)
 . . . S X=$$SETSTR^VALM1(MODTEXT,X,27,45)
 . . . D SET(X) S X=""
 . D:X]"" SET(X)
 ;
 S X=""
 S SDOPE=$S($P(SDOE0,U,6):$P(SDOE0,U,6),1:SDOE)
 S SDSTATUS=$P($G(^SD(409.63,+$P($G(^SCE(SDOPE,0)),U,12),0)),U)
 S X=$$SETSTR^VALM1("Status:",X,7,13)
 S X=$$SETSTR^VALM1(SDSTATUS,X,SDFST,24)
 ;
 S SDIV=+$P(SDOE0,U,11)
 I SDIV D
 . S SDDV=$P($G(^DG(40.8,SDIV,0)),U)
 . S X=$$SETSTR^VALM1("Division:",X,48,15)
 . S X=$$SETSTR^VALM1(SDDV,X,SDSEC,23)
 D:X'="" SET(X)
 D SET("")
CBQ Q
 ;
SET(X) ; Set in ^TMP global for display
 ;
 S SDLN=SDLN+1,^TMP("SDPPALL",$J,SDLN,0)=X
 Q
