IBJDI21 ;ALB/CPM - VETERANS WITH UNVERIFIED ELIGIBILITY (CONT'D) ;16-DEC-96
 ;;2.0;INTEGRATED BILLING;**118,249**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; - Find inpatients treated within the user-specified date range.
 S IBD=IBBDT-.01 F  S IBD=$O(^DGPM("ATT3",IBD)) Q:'IBD!(IBD\1>IBEDT)  D  Q:IBQ
 .S IBPM=0 F  S IBPM=$O(^DGPM("ATT3",IBD,IBPM)) Q:'IBPM  D  Q:IBQ
 ..I IBPM#100=0 Q:$$STOP(.IBQ,"Unverified Eligibility Report")
 ..S IBPMD=$G(^DGPM(IBPM,0)) Q:'IBPMD
 ..I IBSORT S IBDIV=$$DIV(1,+$P(IBPMD,U,6)) Q:'$D(IB(IBDIV))
 ..S DFN=+$P(IBPMD,U,3) Q:'DFN
 ..;
 ..; - Process patient.
 ..I '$D(^TMP("IBJDI21",$J,DFN)) D PROC(DFN,"*",.IBQUERY)
 ;
 D CLOSE^IBSDU(.IBQUERY)
 I IBQ G ENQ
 ;
 ; - Find outpatients treated within the user-specified date range.
 D OUTPT("",IBBDT,IBEDT,"S:IBQ SDSTOP=1 I 'IBQ,$$ENCHK^IBJDI5(Y0) D ENC^IBJDI21(Y0,.IBQUERY1)","Unverified Eligibility Report",.IBQ,"IBJDI21",.IBQUERY)
 D CLOSE^IBSDU(.IBQUERY),CLOSE^IBSDU(.IBQUERY1)
 ;
 I IBQ G ENQ
 ;
 ; - Extract summary data.
 I $G(IBXTRACT) D  G ENQ
 .F X="DEC","NOT","PEN","TOT","VER","VERO" S IB(X)=$G(IB("ALL",X))
 .D E^IBJDE(2,0)
 ;
 ; - If detail, look up next appt
 I IBRPT="D" S IBARRAY("SORT")="P",IBARRAY("FLDS")=1,IBARRAY(1)=$$NOW^XLFDT_";9999999",IBARRAY(4)="^TMP(""IBDFN"",$J,",IBCOUNT=$$SDAPI^SDAMA301(.IBARRAY)
 ;
 ; - Print the reports.
 S IBQ=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 S IBDIV="" F  S IBDIV=$O(IB(IBDIV)) Q:IBDIV=""  D  Q:IBQ
 .S IBPAG=0 D:IBRPT="D" DET I 'IBQ D SUM,PAUSE
 ;
ENQ Q
 ;
OUTPT(DFN,IBBDT,IBEDT,IBCBK,IBMSG,IBQ,IBSUBSCR,IBQUERY,IBDIR) ;
 ; Input:   DFN = IEN of patient if using PATIENT/DATE index, otherwise,
 ;                if null or 0, DATE/TIME index will be used
 ;        IBCBK = The MUMPS code to execute when valid enctr found
 ;        IBBDT/IBEDT = The start/end dates
 ;        IBMSG = The text to send to STOP PROCESSING CALL (if null, no
 ;                call made)
 ;          IBQ = Flag that says whether or not the process was stopped
 ;                by user
 ;      IBQUERY = The # of the QUERY OBJECT to be used to extract outpt
 ;                visits
 ;        IBDIR = Null to look forward, 'B' to look backward thru file
 ;
 N IBVAL,IBFILTER
 S IBVAL("BDT")=IBBDT,IBVAL("EDT")=IBEDT_".99" S:$G(DFN) IBVAL("DFN")=DFN
 ;
 ; - Look at parent encounters, completely checked out, check user
 ;   requested to quit, process each pt only once if IBSUBSCR'=null
 S IBFILTER=""
 S IBCBK="I "_$S($G(IBSUBSCR)'="":"'$D(^TMP(IBSUBSCR,$J,+$P(Y0,U,2))),",1:"")_"'$P(Y0,U,6),$P(Y0,U,7),$S((Y#100)'=0:1,$G(IBMSG)="""":1,1:'$$STOP^IBJDI21(.IBQ,IBMSG))"_" "_IBCBK
 S IBDIR=$S($G(IBDIR)="":"",1:"BACKWARD")
 D SCAN^IBSDU($S($G(DFN):"PATIENT/DATE",1:"DATE/TIME"),.IBVAL,IBFILTER,IBCBK,0,.IBQUERY,IBDIR) K ^TMP("DIERR",$J)
 Q
 ;
STOP(IBQ,MSG) ; - Check if user wants to stop.
 N Y,Y0 S IBQ=$$STOP^IBOUTL(MSG)
 Q IBQ
 ;
ENC(IBOED,IBQUERY1) ; - Encounter extract for all patients loop.
 ; IBQUERY1 = the # of the QUERY to use to do the extract.
 ; Pre-set variables IB array, IBSORT are required.
 ;
 I IBSORT S IBDIV=$$DIV(0,+$P(IBOED,U,11)) Q:'$D(IB(IBDIV))
 D PROC(+$P(IBOED,U,2),"",.IBQUERY1) ; Process patient.
 Q
 ;
PROC(DFN,IBIPC,IBQUERY) ; - Process each specific patient.
 ; Input:     DFN = Pointer to the patient in file #2
 ;          IBIPC = Inpatient treatment marker
 ;                  ("*"=Had inpat. treatment, null=No inpat. treatment)
 ;        IBQUERY = The # of the QUERY OBJECT to be used to extract
 ;                  outpatient visits
 ;
 ; Pre-set variables IB array, IBDIV are required.
 ;
 I $$TESTP^IBJDI1(DFN) Q  ;      Test patient.
 D ELIG^VADPT I 'VAEL(4) G PRCQ ; Patient is not a vet.
 ;
 ; - Set patient index and 'total' accumulator.
 S ^TMP("IBJDI21",$J,DFN)="",IB(IBDIV,"TOT")=IB(IBDIV,"TOT")+1
 ;
 I $G(^DPT(DFN,.35)) S IB(IBDIV,"DEC")=IB(IBDIV,"DEC")+1 ; Deceased.
 ;
 ; - Elig. status is Verified, Pending, Re-pending, or null.
 S IBES=$P(VAEL(8),U)
 I IBES="V" D  G PRCS:X'<730,PRCQ
 .S IB(IBDIV,"VER")=IB(IBDIV,"VER")+1
 .S IBESD=+$P($G(^DPT(DFN,.361)),U,2),X1=DT,X2=IBESD D ^%DTC
 .S:X'<730 IB(IBDIV,"VERO")=IB(IBDIV,"VERO")+1,^TMP("IBJDI23",$J,DFN)=" (on "_$$DAT1^IBOUTL(IBESD)_")"
 I IBES="P"!(IBES="R") S IB(IBDIV,"PEN")=IB(IBDIV,"PEN")+1 G PRCS
 S IB(IBDIV,"NOT")=IB(IBDIV,"NOT")+1
 ;
PRCS I IBRPT="D" D SET(.IBQUERY)
 ;
PRCQ K VA,VAERR,VAEL
 Q
 ;
SET(IBQUERY) ; - Set up detailed information to appear on the report.
 ; Working variable definitions:
 ;    IBLT = Last treatment date
 ;    IBDN = Zero node of Patient file entry
 ;   IBDOD = Patient's date of death (if any)
 ;  IBNUMO = No. outpatient visits in date range
 ;  IBNUMD = No. discharges in date range
 ;  IBNEXT = Next scheduled treatment date
 ; IBQUERY = The # of the QUERY OBJECT to be used to extract outpatient
 ;           visits
 ;
 S (IBNUMD,IBNUMO,IBLT)=0
 ;
 ; - Get # of discharges; look for LTD.
 S IBDT=0 F  S IBDT=$O(^DGPM("ATID3",DFN,IBDT)) Q:'IBDT  D
 .S IBDTF=9999999.9999999-IBDT\1
 .S:IBDTF>IBLT IBLT=IBDTF I IBDTF<IBBDT!(IBDTF>IBEDT) Q
 .S IBNUMD=IBNUMD+1
 ;
 ; - Get # of outpatient visits; look for LTD.
 D OUTPT(DFN,IBBDT,9991231,"S IBDTF=Y0\1 S:IBDTF>IBLT IBLT=IBDTF I IBDTF'<IBBDT,IBDTF'>IBEDT S IBNUMO=IBNUMO+1","","","",.IBQUERY)
 ;
 ; - If current inpatient, set LTD to today.
 I $G(^DPT(DFN,.105)) S IBLT=DT
 ;
 ; - Find next scheduled treatment date.
 S IBNEXT=""
 I $$GETICN^MPIF001(DFN) S ^TMP("IBDFN",$J,DFN)="" ;set tmp sched appt.
 S X=0 F  S X=$O(^DGS(41.1,"B",DFN,X)) Q:'X  D  ;   Scheduled adm.
 .S X1=$G(^DGS(41.1,X,0))
 .S X2=$P(X1,U,2)\1
 .I X2<DT Q  ;       Must be old scheduled admission.
 .I $P(X1,U,13) Q  ; Sched adm is cancelled.
 .I $P(X1,U,17) Q  ; Patient already admitted.
 .I X2>IBNEXT S IBNEXT=X2
 ;
 S IBDN=$G(^DPT(DFN,0))
 S IBDOD=$S(+$G(^DPT(DFN,.35)):$$DAT1^IBOUTL(+$G(^(.35))\1),1:"")
 ;
 S ^TMP("IBJDI22",$J,IBDIV,$E($P(IBDN,U),1,25)_IBIPC_"@@"_DFN)=$P(IBDN,U,9)_U_$E($P(VAEL(1),U,2),1,23)_U_IBES_U_IBNUMO_U_IBNUMD_U_IBLT_U_IBNEXT_U_IBDOD
 Q
 ;
DIV(X,Y) ; - Return division name.
 ;  Input: X=1-Inpatient, 0-Outpatient
 ;         Y=IEN of file #42 (If X=1) or IEN of file #40.8 (If X=0)
 I X S Y=+$P($G(^DIC(42,Y,0)),U,11)
 S Z=$P($G(^DG(40.8,Y,0)),U) I Z="" S Z=$P($$SITE^VASITE,U,2)
 Q Z
 ;
DET ; - Print the detailed report.
 D HDET Q:IBQ
 I '$D(^TMP("IBJDI22",$J,IBDIV)) W !!,"There were no patients treated in this date range with unverified eligibility." G DETQ
 ;
 S IBXX="" F  S IBXX=$O(^TMP("IBJDI22",$J,IBDIV,IBXX)) Q:IBXX=""  S IBX=^(IBXX) D  Q:IBQ
 .I $Y>(IOSL-2) D PAUSE Q:IBQ  D HDET Q:IBQ
 .W !,$P(IBXX,"@@"),?28,$$SSN($P(IBX,U)),?42,$P(IBX,U,2)
 .W ?67,$$ESTAT($P(IBX,U,3)),$G(^TMP("IBJDI23",$J,IBDIV,+$P(IBXX,"@@",2)))
 .W ?93,$J($P(IBX,U,4),3),?98,$J($P(IBX,U,5),3)
 .W ?104,$$DAT1^IBOUTL($P(IBX,U,6))
 .S IBCOUNT=$O(^TMP($J,"SDAMA301",+$P(IBXX,"@@",2),0))
 .S:IBCOUNT $P(IBX,"^",7)=$S('$P(IBX,"^",7):IBCOUNT,IBCOUNT<$P(IBX,"^",7):IBCOUNT,1:$P(IBX,"^",7))
 .W ?114,$$DAT1^IBOUTL($P(IBX,U,7))
 .W ?124,$P(IBX,U,8)
 ;
DETQ I 'IBQ D PAUSE
 Q
 ;
HDET ; - Write the detail report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W !,"Veterans with Unverified Eligibilities",$S(IBDIV'="ALL":" for "_IBDIV,1:""),?80,"Run Date: ",IBRUN,?123,"Page: ",IBPAG
 W !,"Patients who were treated in the period ",$$DAT1^IBOUTL(IBBDT)," to ",$$DAT1^IBOUTL(IBEDT)
 W !?91,"# Opt   #      Last   Nxt Sched  Date of"
 W !,"Patient (*=Had inpt. care)",?28,"SSN",?42,"Primary Eligibility"
 W ?67,"Eligibility Status",?91,"Visits Disc    Seen   Visit/Adm   Death"
 W !,$$DASH(IOM),!
 S IBQ=$$STOP(0,"Unverified Eligibility Report")
 Q
 ;
SUM ; - Print the summary report.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W !!?21,"VETERANS WITH UNVERIFIED ELIGIBILITY",!
 I IBDIV'="ALL" W ?(61-$L(IBDIV))\2,"SUMMARY REPORT for ",IBDIV
 E  W ?33,"SUMMARY REPORT"
 W !!?19,"Patients treated from ",$$DAT1^IBOUTL(IBBDT)," - ",$$DAT1^IBOUTL(IBEDT)
 W !!?24,"Run Date: ",IBRUN,!?13,$$DASH(53),!!
 ;
 S IBPERV=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"VER")/IB(IBDIV,"TOT")*100),0,2)
 S IBPERP=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"PEN")/IB(IBDIV,"TOT")*100),0,2)
 S IBPERD=$J($S('IB(IBDIV,"TOT"):0,1:IB(IBDIV,"DEC")/IB(IBDIV,"TOT")*100),0,2)
 S IBPERO=$J($S('IB(IBDIV,"VER"):0,1:IB(IBDIV,"VERO")/IB(IBDIV,"VER")*100),0,2)
 W ?29,"Number of Patients Treated:",?58,$J(IB(IBDIV,"TOT"),5)
 W !?28,"Number of Deceased Patients:",?58,$J(IB(IBDIV,"DEC"),5),?67,"(",IBPERD,"%)"
 W !?11,"Number of Patients with Verified Eligibility:",?58,$J(IB(IBDIV,"VER"),5),?67,"(",IBPERV,"%)"
 W !?5,"Number of Patients Whose Verified Eligibility Date"
 W !?13,"is At Least 2 Years Old (from above total):",?58,$J(IB(IBDIV,"VERO"),5),?67,"(",IBPERO,"%)"
 W !?10,"Number of Patients with a Pending Eligibility:",?58,$J(IB(IBDIV,"PEN"),5),?67,"(",IBPERP,"%)"
 W !?24,"Number of Patients Not Verified:",?58,$J(IB(IBDIV,"NOT"),5),?67,"(",$J($S('IB(IBDIV,"TOT"):0,1:100-IBPERV-IBPERP),0,2),"%)"
 Q
 ;
DASH(X) ; - Return a dashed line.
 Q $TR($J("",X)," ","=")
 ;
PAUSE ; - Page break.
 I $E(IOST,1,2)'="C-" Q
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
 ;
SSN(X) ; - Format the SSN.
 Q $S(X]"":$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,10),1:"")
 ;
ESTAT(X) ; - Decode the eligibility status.
 Q $S(X="V":"VERIFIED",X="P":"PENDING VERIFICATION",X="R":"PENDING RE-VERIFICATION",1:"NOT VERIFIED")
