DGPREP0 ;Boise/WRL/ALB/SCK-Program to Display Pre-Registration List ; 2/24/04 2:11pm
 ;;5.3;Registration;**109,546,586,581**;Aug 13, 1993
 Q
 ;
EN ; -- main entry point
 N VAUTD,X1
 ;
 I '$D(^XUSEC("DGPRE EDIT",DUZ))&('$D(^XUSEC("DGPRE SUPV",DUZ))) D  G ENQ
 . W !!,"You do not have the requisite key allocated, contact your Supervisor."
 ;  *** Select Divisions
 I $P($G(^DG(43,1,"GL")),U,2) D
 . D DIVISION^VAUTOMA
 E  D
 . S DGSNGLDV=1
 . S VAUTD=1
 ;
 D EN^VALM("DGPRE RG")
ENQ Q
 ;
HDR ; -- header code
 ; Variables
 ;   DGPSRT  - Sort Method for call list display
 ;
 N DGPSRT
 I $D(VAUTD) S VALMHDR(1)="Call List sorted by Division and then "
 S DGPSRT=$P($G(^DG(43,1,"DGPRE")),U)
 S VALMHDR(1)=$G(VALMHDR(1))_"Sorted by "_$S(DGPSRT="P":"Patient Name",DGPSRT="S":"Medical Service")_"."
 I $G(VAUTD) S VALMHDR(2)="All Divisions selected."
 Q
 ;
INIT ; -- Retrieve data from call list and build TMP global for sorting Call lsit
 ;  Variables
 ;    DGPNR    - 
 ;    DGPDATA  - 0 Node from ^DGS(41.42,X
 ;    DGPDATA1 - 1 Node from ^DGS(41.42,X
 ;    DGPDIV   - Division IEN from ^DGS(41.42,
 ;    DGPDVN   - Division Name
 ;    DGPSV    - Medical Service for appointment clinic
 ;    DGPAT    - Appt. date/time
 ;    DGPPN    - Patients name
 ;    DGPNR    - Index No. for LM
 ;    DGPSRT   - Call list sort method
 ;    DGPN0,DGPN1,DGPNX - Local Var's for $O
 ;
 N DGQ,DGPDATA,DGPDATA1,DGPDIV,DGPDVN,DGPNX,DGPN1,DGPN2
 ;
 K ^TMP("DGPRERG",$J)
 K ^TMP($J)
 S DGPSRT=$P($G(^DG(43,1,"DGPRE")),U)
 I $P($G(^DGS(41.42,0)),U,4)>1 W !!,"Sorting Entries..."
 ;
 S DGPN1=0 F  S DGPN1=$O(^DGS(41.42,DGPN1)) Q:'DGPN1  D
 . S DGPDATA=$G(^DGS(41.42,DGPN1,0)),DGPDATA1=$G(^DGS(41.42,DGPN1,1))
 . Q:DGPDATA']""!(DGPDATA1']"")
 . ; ****  Division handling
 . S DGPDIV=$P(DGPDATA,U,2)
 . I +DGPDIV'>0 D
 .. I $G(DGSNGLDV) S DGPDIV=$S($D(^DG(40.8,1)):1,1:0) Q
 .. S DGPDIV=-1
 . K DGQ
 . I '$G(DGSNGLDV) D  Q:$G(DGQ)
 .. I '$G(VAUTD),'$D(VAUTD(DGPDIV)) S DGQ=1
 . ;
 . S DGPSV=$P(DGPDATA1,U)
 . S DGPAT=$P(DGPDATA,U,8)
 . S DGPPN=$P(^DPT($P(^DGS(41.42,DGPN1,0),U),0),U)
 . ;
 . I DGPSRT="S" D
 .. I DGPSV']"" W !,"NO SERVICE ENTRY FOR RECORD# ",DGPN1 Q
 .. S ^TMP($J,DGPDIV,DGPSV,DGPN1)=$P(^DGS(41.42,DGPN1,0),U)
 . ;
 . I DGPSRT="P" D
 .. I DGPPN']"" W !,"NO PATIENT ENTRY FOR RECORD# ",DGPN1 Q
 .. S ^TMP($J,DGPDIV,DGPPN,DGPN1)=$P($G(^DGS(41.42,DGPN1,0)),U)
 . ;
 . I DGPSRT']"" D
 .. I DGPPN']"" W !,"NO PATIENT ENTRY FOR RECORD# ",DGPN1 Q
 .. S ^TMP($J,DGPDIV,DGPPN,DGPN1)=$P(^DGS(41.42,DGPN1,0),U)
 . W "."
 ;
 I $D(^TMP($J)) W !!,"Loading Sorted Entries into List..."
 E  D
 . W *7,!!,"No appointments were found for the selected divisions"
 . K DIR S DIR(0)="E" D ^DIR K DIR
 ;
 ; Retreive sorted call list form ^TMP and build LM arrays
 ;
 S DGPNR=1
 S DGPN0="" F  S DGPN0=$O(^TMP($J,DGPN0)) Q:DGPN0=""  D
 . S DGPN1="" F  S DGPN1=$O(^TMP($J,DGPN0,DGPN1)) Q:DGPN1=""  D
 .. S DGPNX="" F  S DGPNX=$O(^TMP($J,DGPN0,DGPN1,DGPNX)) Q:DGPNX=""  D
 ... S DGPDATA=$G(^DGS(41.42,DGPNX,0))
 ... S DGPDATA1=$G(^DGS(41.42,DGPNX,1))
 ... S DGPSV=$P(DGPDATA1,U)
 ... S X=$$SETFLD^VALM1(DGPNR,"","INDEX")
 ... S X=$$SETFLD^VALM1($E($P(^DPT($P(DGPDATA,U),0),U),1,30),X,"PATIENT")
 ... S DGPDFN=$P(DGPDATA,U)
 ... D BLDHIST
 ... S X=$$SETFLD^VALM1($P(DGPDATA1,U,2),X,"SSN")
 ... S X=$$SETFLD^VALM1(DGPSV,X,"SVC")
 ... S X=$$SETFLD^VALM1($E($P(DGPDATA1,U,3),1,18),X,"PHONE")
 ... S X=$$SETFLD^VALM1($$FMTE^XLFDT($P(DGPDATA,U,5),"2D"),X,"LAST")
 ... I $P(DGPDATA,U,6)="Y" D
 .... ;S X=$$SETFLD^VALM1("*",X,"CALL")
 ... S DGPDVN=$S(+$G(DGPN0)>0:$P(^DG(40.8,DGPN0,0),U),DGPN0<0:"",1:DGPN0)
 ... S X=$$SETFLD^VALM1($E(DGPDVN,1,20),X,"DIVISION")
 ... S ^TMP("DGPRERG",$J,DGPNR,0)=X
 ... S ^TMP("DGPRERG",$J,"DA",DGPNR,DGPN1)=""
 ... S ^TMP("DGPRERG",$J,"DFN",DGPNR,DGPDFN)=""
 ... S ^TMP("DGPRERG",$J,"SSN",DGPNR,$P(DGPDATA1,U,2))=""
 ... S ^TMP("DGPRERG",$J,"IDX",DGPNR,DGPNR)=""
 ... S ^TMP("DGPRERG",$J,"DIV",DGPNR,DGPN0)=""
 ... S DGPNR=DGPNR+1
 ... W "."
 S VALMCNT=DGPNR-1
 I VALMCNT'>0 S VALMQUIT=1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- Exit code
 K ^TMP("DGPRERG",$J)
 K DGPAT,DGPCH,DGPCL,DGPDA,DGPDATA,DGPDATA1,DGPDFN,DGPEDIT,DGPENT,DGPFLG,DGPIFN
 K DGPLOC,DGPN0,DGPN1,DGPN2,DGPN3,DGPNR,DGPP1,DGPP2,DGPP3,DGPPN
 K DGPPSRT,DGPST,DGPSV,DGPTAT,DA,X,Y,DIR,DIC,DIE
 D FULL^VALM1
 D CLEAN^VALM10
 Q
 ;
BLDHIST ;  Build history of call attempts from ^DGS(41.43, Call log
 N DGPN2,DGPN3
 ;
 S DGPN2=0 F  S DGPN2=$O(^DGS(41.43,"C",DGPDFN,DGPN2)) Q:'DGPN2  D
 . S:$P(^DGS(41.43,DGPN2,0),U,4)]"" ^TMP("STAT",$J,$P(^DGS(41.43,DGPN2,0),U,1))=$P(^DGS(41.43,DGPN2,0),U,4)
 I $D(^TMP("STAT",$J)) D
 . S DGPTAT=""
 . S DGPN3=9999999.999999 F  S DGPN3=$O(^TMP("STAT",$J,DGPN3),-1) Q:'DGPN3  D
 .. S DGPTAT=DGPTAT_^TMP("STAT",$J,DGPN3)
 . S X=$$SETFLD^VALM1(DGPTAT,X,"HIST")
 . K ^TMP("STAT",$J)
 Q
