GMRCSLM ;SLC/DCM,JFR - List Mgr routine for consult tracking list ;9/8/99 14:52
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,14,12,22**;DEC 27, 1997
EN ; -- main entry point for GMRC CONSULT TRACKING
 K GMRCOER
 S GMRCEN=1 K GMRCQUT
 ;IF Consults
 I $D(GMRCIS) D  I $D(GMRCQUT) K GMRCEN,GMRCIS,GMRCQUT Q
 .N DIR,DIRUT,DTOUT,DUOUT,Y
 .S DIR(0)="SB^R:REQUESTING;C:CONSULTING"
 .S DIR("A")="Are you the Requesting site or the Consulting site"
 .D ^DIR I $D(DIRUT) S GMRCQUT=1 Q
 .S GMRCIS=Y
 D SP K GMRCEN I $D(GMRCQUT) K GMRCQUT Q
 D EN^VALM("GMRC CONSULT TRACKING")
 Q
 ;
HDR ; -- header code
 ;override title if IF Consults
 I $D(GMRCIS) S VALM("TITLE")="IFC Requests: "_$S(GMRCIS="R":"Requesting",1:"Consulting")_" Site"
 D HDR1 ;format line 1 of header
 D:$L(GMRCWT) HDR2("")
 Q
 ;
HDR1 ;format VALMHDR(1) with patient information
 N GMRCX,GMRCX1,GMRCX2,GMRCX3,TIUCWAD,GMRVSTR,X
 ;Expects DFN
 S GMRVSTR="WT" D EN6^GMRVUTL
 S GMRCWT="Wt.(lb): "_$S($L($P(X,U,8)):$P(X,U,8),1:"No Entry")
 D DEM^GMRCU ;returns GMRCPNM,GMRCSN,GMRCAGE,SEX,GMRCWARD,GMRCRB,GMRCDOB,GMRCWLI
 S GMRCX1=GMRCPNM_"   "_GMRCSN
 ;
 S GMRCLOC=+$G(^DIC(42,+GMRCWLI,44))_";SC(" I 'GMRCLOC,'$D(XQAID) S GMRCLOC=""
 S GMRCX2="" I +$G(GMRCLOC) D
 . N L S L=$G(^SC(+GMRCLOC,0)),GMRCX2=$P(L,U,2)
 . S:'$L(GMRCX2) GMRCX2=$E($P(L,U),1,4)
 S:$L($G(GMRCRB)) GMRCX2=GMRCX2_"/"_GMRCRB
 ;
 S GMRCX=GMRCX1_$J(GMRCX2,40+($L(GMRCX2)\2)-$L(GMRCX1))
 S GMRCX3=" "_GMRCDOB_" ("_GMRCAGE_")"
 S TIUCWAD=$$CWAD^ORQPT2(+DFN) S:TIUCWAD]"" GMRCX3=GMRCX3_"   <"_TIUCWAD_">"
 S VALMHDR(1)=GMRCX_$J(GMRCX3,79-$L(GMRCX))
 K VALMHDR(2)
 Q
HDR2(GMRCX) ;format VALMHDR(2) with patient weight
 S VALMHDR(2)=$G(GMRCX)_$J($G(GMRCWT),79-$L($G(GMRCX)))
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("GMRCR",$J,"LIST")
 S DSPLINE=0,DATA="",VALMAR="^TMP(""GMRCR"",$J,""LIST"")"
 F LINE=1:1:LNCT S DSPLINE=$O(^TMP("GMRCR",$J,"CS",DSPLINE)) Q:DSPLINE=""!(DSPLINE?1A.E)  S DATA=^(DSPLINE,0) D SET^VALM10(LINE,DATA)
 S VALMCNT=LNCT,VALMPGE=1,XQORM("A")="Select Action: "
 K DSPLINE,DATA,LINE
 S:$D(^TMP("GMRC",$J,"CURRENT","MENU")) XQORM("HIJACK")=^("MENU")
 Q
 ;
HELP ; -- help code
 N X,DX,DY D FULL^VALM1
 W !!,"Enter the display number of the item you wish to act on, or select an action."
 W !!,"If you'd like another view of the consults, enter CV."
 W !!,"Status key:",!?5,"'a' - active",?27,"'c' - complete",?50,"'dc' - discontinued",!?5,"'p' - pending",?27,"'x' - cancelled",?50,"'pr' - partial results",!?5,"'s' - scheduled",?27,"'e' - expired"
 W !!,"Enter ?? to see a list of actions available for navigating the list."
 W !!,"Press <return> to continue ..." R X:DTIME
 S VALMBCK="R"
 ; S VALMSG=$$MSG
 S (DX,DY)=0 X ^%ZOSF("XY")
 D EXIT^GMRCSLMA("R")
 Q
 ;
EXIT ; -- exit code
 K ^TMP("GMRCR",$J,"LIST")
 K VALMCNT,VALMBCK,VALMPGE
 D ^GMRCREXT
 Q
 ;
PHYEN ;Entry Point When Provider's service is known and only needs to look at consults for that service
 Q:'$D(DUZ)  Q:'$D(^VA(200,DUZ,5))  Q:'$L(^VA(200,DUZ,5))
 S DIC="^DIC(49,",DIC(0)="MNO",X=^VA(200,DUZ,5) D ^DIC K DIC S GMRCSSNM=$S($L($P(Y,"^",2)):$P(Y,"^",2),1:"") I $L(GMRCSSNM) S GMRCSS=$O(^GMR(123.5,"B",GMRCSSNM,0))
 S GMRCFL=1 D SP I $D(GMRCQUT),GMRCQUT=1 Q
 D SPD I $D(GMRCQUT) D END,EXIT Q
 K GMRCFL
 D AD^GMRCSLM1
 I GMRCSSNM'["MEDICINE" D EN^VALM("GMRC CONSULT TRACKING"),END,EXIT Q
 D EN^VALM("GMRC TRK MEDICINE CONSULTS"),END,EXIT Q
 Q
SP ;;Select a new patient and return DFN and GMRCSSNM to display consults and requested Service.
 I $D(VALM) D FULL^VALM1
 K GMRCQUT S GMRCDFN1=$S($D(DFN):DFN,1:0)
 D SELPT^GMRCS I $S($D(GMRCQUT):1,'$D(DFN):1,1:0) S GMRCQUT=1,DFN=GMRCDFN1 G SPK
 I $D(Y),Y<0&(X["^") S GMRCQUT=1 G SPK
 I $D(Y),Y<0 S DFN=GMRCDFN1 S GMRCQUT=1 G SPK
 I $D(GMRC("NMBR")) D RESET^GMRCSLMV(GMRC("NMBR")) K GMRC("NMBR")
 S GMRCWRD=GMRCWARD
 I $D(GMRCFL) D SPK Q
 D ASRV^GMRCASV I $S($D(GMRCQUT):1,$D(DTOUT):1,$D(DUOUT):1,1:0) K DTOUT,DIROUT,DUOUT S (GMRCQUT,GMRCQIT)=1 Q
 S GMRCSS=GMRCDG,GMRCSSNM=$P(^GMR(123.5,GMRCSS,0),"^",1) S GMRCSTCK=""
 D EN^GMRCMENU
SPD ;Enter a date range for serching consults;  null entry selects all consults and does not exclude by date
 D ^GMRCSPD Q:$D(GMRCQUT)
 I $D(GMRCEN) D SPK Q  ;GMRCEN defined if branched to here from EN^GMRCSLM
 S GMRCOER=0
 D AD^GMRCSLM1 ;Do not delete. Needed to get new Pt. data into ^TMP("GMRCR",
 S VALMCNT=LNCT,VALMBCK="R",VALMPGE=1 K GMRCDFN1
 Q
SPQ ;New patient has not been selected - keep current patient
 I '$D(DFN),GMRCDFN1<1 S GMRCQUT=1 K GMRCDFN1 Q
 S DFN=GMRCDFN1 Q:DFN<1  W " "_GMRCPNM K GMRCDFN1
 S VALMBCK="R",GMRCQUT=1 K GMRCDFN1
SPK ;Kill variables
 ;I $D(GMRCTM),$D(GMRCBM),$D(IOSTBM) S IOTM=GMRCTM,IOBM=IOSTBM
 K GMRCDFN1,GMRCBM,GMRCTM
 Q
SS ;Select A New Service or ALL SERVICES to Display Patient Consults
 K GMRCQUT,GMRCVP S GMRCOER=0
 D FULL^VALM1
 D ASRV^GMRCASV I $D(GMRCQUT),GMRCQUT=1 Q
 S GMRCSS=GMRCDG,GMRCSSNM=$P(^GMR(123.5,GMRCSS,0),"^",1)
 D AD^GMRCSLM1,INIT,HDR
 S VALMBCK="R",VALMCNT=LNCT
 D EN^GMRCACTM,EN^GMRCMENU
 I $D(GMRC("NMBR")) D RESET^GMRCSLMV(GMRC("NMBR")) K GMRC("NMBR")
 Q
STS ;Select a status for view. i.e., only active, pendings, DC'd, etc.
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 S GMRCERR=0
 N DIR,X,Y
 S DIR(0)="SAOM^dc:Discontinued;c:Complete;p:Pending;a:Active;pr:Partial Results;s:Scheduled;x:Cancelled"
 S $P(DIR(0),U,2)="al:All Status's;"_$P(DIR(0),U,2)
 S DIR("A")="Only Display Consults With Status of: "
 S DIR("B")="All Status's"
 I $G(GMRCSTCK) D
 . S DIR("A")="Another Status to display: "
 . K DIR("B")
 D ^DIR
 I $D(DUOUT)!($D(DTOUT))!('$L(Y)) G END
 D STCK($$LOW^XLFSTR(Y)) I $G(GMRCSTCK)="" D:$D(GMRC("NMBR"))  G END
 . D RESET^GMRCSLMV(GMRC("NMBR"))
 . K GMRC("NMBR")
 . Q
 I $D(GMRC("NMBR")) D RESET^GMRCSLMV(GMRC("NMBR")) K GMRC("NMBR")
 G STS
STCK(RES)     ;change code to status
 N CODE
 I RES="al" S GMRCSTCK="" Q
 I RES="dc" S CODE=1
 I RES="c" S CODE=2
 I RES="p" S CODE=5
 I RES="a" S CODE=6
 I RES="pr" S CODE=9
 I RES="x" S CODE=13
 I RES="s" S CODE=8
 I $D(GMRCSTCK)  I $$FND(CODE) W $C(7),!,"Already selected" Q
 I +$G(GMRCSTCK) S GMRCSTCK=GMRCSTCK_","_CODE Q
 S GMRCSTCK=CODE
 Q
FND(CD) ;status already selected?
 I GMRCSTCK=CD Q 1
 I $F(GMRCSTCK,(CD_",")) Q 1
 I $E(GMRCSTCK,$L(GMRCSTCK))=CD Q 1
 Q 0
END K DIR,GMRCERR,Y
 Q
