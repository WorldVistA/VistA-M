VAFCEHLM ;ALB/JLU,LTL-FILE UTILITIES FOR 391.98 ;12/07/00
 ;;5.3;Registration;**149,255,307,333,477**;Aug 13, 1993
 ;
 ;Reference to VTQ^MPIFSAQ supported by IA #2941
 ;
EN ; -- main entry point for VAFC EXCPT SUM SCR
 ;fix records stuck in 'being reviewed' status
 S IEN=0 F  S IEN=$O(^DGCN(391.98,"AST",5,IEN)) Q:'IEN  D  ;**255
 . L +^DGCN(391.98,IEN,0):0 I '$T Q  ;record is truly being reviewed
 . S XX=$$EDIT^VAFCEHU1(IEN,"AR") ;change record to action required
 . L -^DGCN(391.98,IEN,0)
 L +^DGCN(391.98,"VAFC PDR PURGE"):0 I '$T W $C(7),!!,"The Purge Patient Data Reviews process is currently running." QUIT
 L -^DGCN(391.98,"VAFC PDR PURGE")
 D EN^VALM("VAFC EXCPT SUM SCR")
 Q
 ;
HDR ; -- header code
 N RGSTRNG
 S RGSTRNG="Review(s) currently on file."
 S VALMHDR(1)=$$CENTER(RGSTRNG)
 Q
 ;
INIT ; -- init variables and list array
 ;checking for sort variable
 N XQORNOD
 I '$D(VAFCSORT) S VAFCSORT="SN"
 ;
INIT2 ;enter at this point to reset the screens after editing etc.
 K @VALMAR
 D SORTS^VAFCEHU2(VAFCSORT,VALMAR)
 D FORMAT^VAFCEHU2(VALMAR,.VALMCNT,.VALMQUIT)
 Q
 ;
HELP ; -- help code
 S X="?",VALMSG="Select patient for detailed display or change sorting"
 D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K @VALMAR,VAFCSORT
 Q
 ;
EXPND ; -- expand code
 Q
 ;
SACT D HDR
 D INIT
 S VALMBCK="R"
 Q
 ;
FULL S VALMSG="** = Different, ->  = Edited, <UR> = Unresolved" D REVFUL^VAFCEHU2
 S VALMBCK="R"
 Q
 ;
DIFF S VALMBCK="R"
 Q
 ;
INQ ; Patient Inquiry ;**255
 N DFN
 S DFN=+$P($G(^DGCN(391.98,IENPDR,0)),"^",1) ;**477
 S VALMBCK=""
 D FULL^VALM1
 D EN^DGRPD
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
DISP ; Display Only Query to MPI ;**307
 S VALMBCK=""
 D FULL^VALM1
 S MPIVAR("DFN")=$P(EXCPT,"^",1)
 S MPIVAR("SSN")=$P($G(^DPT(+$P(EXCPT,"^",1),0)),"^",9)
 S MPIVAR("NM")=$P($G(^DPT(+$P(EXCPT,"^",1),0)),"^",1)
 S MPIVAR("DOB")=$P($P($G(^DPT(+$P(EXCPT,"^",1),0)),"^",3),".",1)
 D VTQ^MPIFSAQ(.MPIVAR)
 D PAUSE^VALM1
 S VALMBCK="R"
 K MPIVAR
 Q
 ;
PDAT ;report to list CMOR, TF's & SUB's ;**333
 N DFN
 S DFN=+$P($G(^DGCN(391.98,IEN,0)),"^",1)
 S VALMBCK=""
 D FULL^VALM1
 D START^VAFCPDAT
 ;D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
CENTER(STRG) ;
 ;
 N LEN,FIL,FIL1
 S LEN=80-$L(STRG)
 S FIL=LEN/2
 S $P(FIL1," ",FIL)=""
 Q FIL1_STRG
 ;
PDRPRG ;Purge PDRs ;**477
 L +^DGCN(391.98,"VAFC PDR PURGE"):0 I '$T W $C(7),!!,"The Purge Patient Data Reviews process is currently running." Q
 L -^DGCN(391.98,"VAFC PDR PURGE")
 N TDATE,MAXDT,PDATE,X1,X2,X,Y
 S NDATE=""
 D NOW^%DTC S TDATE=X
 S X1=TDATE,X2=-30 D C^%DTC
 S (Y,MAXDT)=X D DD^%DT S PDATE=Y
 S DIR("?")="Enter a date at least 30 days in the past."
 S DIR("A")="Purge all Patient Data Reviews prior to "
 S DIR("B")=PDATE,DIR(0)="DAO^:"_MAXDT_":EPX" D ^DIR K DIR Q:$D(DIRUT)
 S NDATE=Y
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Are you sure you want to purge Patient Data Reviews? " D ^DIR K DIR Q:$D(DIRUT)
 Q:Y=0
 ;
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTREQ
 S ZTRTN="QPRG^VAFCEHLM",ZTDESC="PURGE PATIENT DATA REVIEWS OVER 30 DAYS OLD OR X DAYS OLD AS SPECIFIED BY USER."
 D NOW^%DTC
 S ZTIO="",ZTDTH=%
 I $D(DUZ) S ZTSAVE("DUZ")=DUZ,ZTSAVE("NDATE")=NDATE
 D ^%ZTLOAD
 W !!?15,"Patient Data Review Purge Queued, Task #"_ZTSK
 D HOME^%ZIS K IO("Q")
 Q
QPRG ;
 I $D(ZTQUEUED) S ZTREQ="@"
 L +^DGCN(391.98,"VAFC PDR PURGE"):0 I '$T Q
 N PDR,EVTDT,ERR S PDR=0,EVTDT=""
 F  S EVTDT=$O(^DGCN(391.98,"EVT",EVTDT)) Q:EVTDT>NDATE  D
 . F  S PDR=$O(^DGCN(391.98,"EVT",EVTDT,PDR)) Q:'PDR  D
 .. S ERR=$$DELEXCPT^VAFCEHU1(PDR)
 L -^DGCN(391.98,"VAFC PDR PURGE")
 K NDATE
 Q
