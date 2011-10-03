SCENI0 ;ALB/SCK - INCOMPLETE ENCOUNTER MGMT MAIN LM DISPLAY ; 07-MAY-1997
 ;;5.3;Scheduling;**66**;AUG 13, 1993
 ;
EN ;  Entry point for IEMM LM display
 ; Variables
 ;   VAUTC,VAUTD -  Clinic and Division o/m/a arrays
 ;   SDENTYP     -  Search type, P:patient, C:Clinic, E:Error Code
 ;   SDCLN       -  Clinic from selection lookup
 ;   SDDT        -  Date range for search, Begin^End format
 ;   SDY         -  Local variable used in selection criteria
 ;   SDEVAL      -  Error code value
 ;   SDFN        -  Patient DFN for local use
 ;   SDIEMM      -  Flag for IEMM
 ;
 N SDENTYP,DFN,SDCLN,SDDT,VAUTC,VAUTD,SDY,SDEVAL,SDFN,SDIEMM
 K X,SDB,XQORNOD,DA,DR,DIE,%B
 ;
AGN Q:'$$ENTRY^SCUTIE2(.SDY)
 I $G(SDENTYP)']"" G AGN
 ;
 I SDENTYP["P" D
 . S SDFN=+SDY
 . S VAUTC=1
 . S X=$P($G(^DG(43,1,"SCLR")),U,12)
 . S SDDT=$$FMADD^XLFDT($$DT^XLFDT,-X)_U_$$DT^XLFDT
 ;
 I SDENTYP["C" D  G:'$$ASKDT^SCENI01(.SDDT) ENQ
 . S SDCLN=+SDY
 . S VAUTC=0,VAUTC(+SDY)=$P(^SC(+SDY,0),U)
 ;
 I SDENTYP["E" D  G:'$$ASKDT^SCENI01(.SDDT) ENQ
 . S VAUTC=1
 . S SDEVAL=+SDY
 ;
 S VAUTD=1
EN1 D WAIT^DICD
 I $G(FLG1) K XQORS,VALMEVL
 S SDIEMM=1
 D EN^VALM("SCENI INCOMPLETE ENC MGT")
ENQ Q
 ;
ENP(SDXPTR) ; Entry point for Data validation, Patient Predefined
 ;  This entry point will jump to the second LM screen and display any
 ;  errors for the encounter.
 ;
 ;  Input
 ;     SDXMT - Pointer to transmission file, 409.73
 ;
 ;  Variables
 ;     FLG1  - Flag for patient defined entry point
 ;
 N FLG1,SDIEMM
 S SDIEMM=1
 ;S VALMBCK="R"
 S FLG1=1
 D EN^SCENIA0
 Q
 ;
HDR ; -- header code
 N SDCLN
 ;
 S VALMHDR(1)="Date Range: "_$$FDATE^VALM1($P(SDDT,U))_" thru "_$$FDATE^VALM1($P(SDDT,U,2))
 ;
 I SDENTYP["P" D
 . S VALMHDR(2)="   Patient: "_$P(^DPT(SDFN,0),U)
 I SDENTYP["C" D
 . S SDCLN=$O(VAUTC(0))
 . S VALMHDR(2)="    Clinic: "_$E(VAUTC(SDCLN),1,25)
 I SDENTYP["E" D
 . S VALMHDR(2)="Error Code: "_$E($P(^SD(409.76,SDEVAL,1),U),1,60)
 S VALMSG="'*' Deleted Encounter            Enter ?? for more actions"
 Q
 ;
INIT ; -- init variables and list array
 N SDCNT
 ;
 K XQORNOD
 K ^TMP("SCENI",$J) ; Sorting global
 K ^TMP("SCEN LM",$J) ; LM Display global
 K ^TMP("SCENIDX",$J) ; Index for expand encounter
 D CLEAN^VALM10
 ;
 S BL="",$P(BL," ",30)=""
 S X=VALMDDF("INDEX"),IC=$P(X,U,2),IW=$P(X,U,3)
 S X=VALMDDF("ENCOUNTER"),EC=$P(X,U,2),EW=$P(X,U,3)
 S X=VALMDDF("SSN"),SC=$P(X,U,2),SW=$P(X,U,3)
 S X=VALMDDF("PATIENT"),PC=$P(X,U,2),PW=$P(X,U,3)
 S X=VALMDDF("DELETED"),DC=$P(X,U,2),DW=$P(X,U,3)
 ;
 D BLD,BLDLM
 I '$D(^TMP("SCENI",$J)) D
 . S (SDCNT,VALMCNT)=0
 . D SET(" "),SET("  No Incomplete Encounters found.")
 Q
 ;
BLD ; Order through the Xmited OE Error file on encounter Xref
 ;  Variables
 ;       SDOEDT  -  Encounter date
 ;       SDOE    -  Pointer to #409.68
 ;       SDE     -  End date of date range
 ;       SDCNT   -  Count of entries
 ;       SDXMT   -  Pointer to #409.73
 ;       SDXER   -  Pointer to #409.75
 ;
 N SDOEDT,SDOE,SDE,SDCNT,SDXMT,SDXER
 ;
 Q:'$D(SDDT)
 S SDOEDT=$P(SDDT,U)-.1,SDE=$P(SDDT,U,2)+.9,(SDCNT,VALMCNT)=0
 I SDENTYP["P" D PLKUP(SDFN) Q
 I SDENTYP["C" D CLKUP($O(VAUTC(0))) Q
 ;the remaining is for a error code look up
 F  S SDOEDT=$O(^SD(409.75,"AEDT",SDOEDT)) Q:'SDOEDT!(SDOEDT>SDE)  D
 . S SDXMT=0 F  S SDXMT=$O(^SD(409.75,"AEDT",SDOEDT,SDXMT)) Q:'SDXMT  D
 .. S SDXER=0 F  S SDXER=$O(^SD(409.75,"AEDT",SDOEDT,SDXMT,SDXER)) Q:'SDXER  I $D(^SD(409.75,SDXER,0)) D:$P(^SD(409.75,SDXER,0),U,2)=SDEVAL BLDA(SDXMT,SDOEDT)
 Q
 ;
BLDA(SDXMT,SDOEDT) ;  Build list entry, and retreive encounter information
 ;  Input
 ;      SDXMT - Pointer to $409.73
 ;     SDOEDT - Date of encounter
 ;
 ;  Out
 ;      ^TMP("SCEN LM",$J,Patient Name,Encounter Date,Xmt Ptr)=DFN^BID^Delete marker ('*')
 ;
 N DFN
 ;
 Q:'SDOEDT
 S SDCNT=SDCNT+1,SDDEL=""
 S SCSTAT=$$OPENC^SCUTIE1(SDXMT,"SCINF")
 ;
 S:SCSTAT=1 SDDEL="*"
 I SCSTAT<0 Q
 ;
 S SDNAME=$$LOWER^VALM1($P(^DPT(SCINF("DFN"),0),U))
 S DFN=SCINF("DFN")
 D PID^VADPT6
 S ^TMP("SCEN LM",$J,SDNAME,SDOEDT,SDXMT)=SCINF("DFN")_U_VA("BID")_U_$G(SDDEL)
 K SDDEL
 Q
 ;
BLDLM ; Build display list array for LM
 ;    Variables
 ;        SDN  - Patient Name
 ;        SDD  - Encounter Date
 ;        SDXT - Pointer to #409.73, transmission pointer
 ;
 S SDCNT=0
 S SDN="" F  S SDN=$O(^TMP("SCEN LM",$J,SDN)) Q:SDN']""  D
 . S SDD="" F  S SDD=$O(^TMP("SCEN LM",$J,SDN,SDD)) Q:'SDD  D
 .. S SDXT=""  F  S SDXT=$O(^TMP("SCEN LM",$J,SDN,SDD,SDXT)) Q:'SDXT  D BLDLM1(SDXT)
 Q
 ;
BLDLM1(SDXT) ; Build LM Display line
 ;    Input
 ;          SDXT - DFN^BID^Delete marker ('*')
 ;
 K SDX
 S SDCNT=SDCNT+1,SDX="",$P(SDX," ",VALMWD+1)=""
 S SDX=$E(SDX,1,IC-1)_$E(SDCNT_BL,1,IW)_$E(SDX,IC+IW+1,VALMWD)
 S SDX=$E(SDX,1,DC-1)_$E($P(^TMP("SCEN LM",$J,SDN,SDD,SDXT),U,3)_BL,1,DW)_$E(SDX,DC+DW+1,VALMWD)
 S SDX=$E(SDX,1,PC-1)_$E(SDN_BL,1,PW)_$E(SDX,PC+PW+1,VALMWD)
 S SDX=$E(SDX,1,SC-1)_$E($P(^TMP("SCEN LM",$J,SDN,SDD,SDXT),U,2)_BL,1,SW)_$E(SDX,SC+SW+1,VALMWD)
 S SDX=$E(SDX,1,EC-1)_$E($$FMTE^XLFDT(SDD,1)_BL,1,EW)_$E(SDX,EC+EW+1,VALMWD)
 D SET(SDX,SDXT)
 Q
 ;
SET(X,SDXMT) ;
 N SCEN
 ;
 S VALMCNT=VALMCNT+1,^TMP("SCENI",$J,VALMCNT,0)=X
 Q:'SDCNT
 S ^TMP("SCENI",$J,"IDX",VALMCNT,SDCNT)=""
 S ^TMP("SCENI",$J,SDCNT,0)=X
 S ^TMP("SCENI",$J,"XMT",SDCNT,SDXMT)=""
 ;
 I $$OPENC^SCUTIE1(SDXMT,"SCEN")>-1 D
 . S ^TMP("SCENIDX",$J,SDCNT)=VALMCNT_U_SCEN("DFN")_U_SCEN("ENCOUNTER")_U_SCEN("CLINIC")
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 I $D(VALMBCK),VALMBCK="R" D REFRESH^VALM S VALMBCK=$P(VALMBCK,"R")_$P(VALMBCK,"R",2) G EX1
 K ^TMP("SCENI",$J),^TMP("SCEN LM",$J),^TMP("SCENIDX",$J),^TMP("SCENI TMP",$J)
 I '$G(FLG1) K ^TMP("SDAMIDX",$J)
 K VA,SDCLN,SDIV,SDENDDT1,SDNR,SDPRDIV,ANS,DFN,EC,EW,IC,IW,PC,PW,SC,SW,SDX,DC,DW,SDNAME,SDFN,VAUTINI,SDCNT,DIC,BL
 K SDOK,SCINF,RTN,SCSTAT,SCEN,RESULT,SCTEXT,LINE,SDDEL,SDD,SDN,SDXT,SDBDT,SDCL,SDDA,SDOEDT,SDOEL,SDVIEN,SDXMT
 K VALMDDF
 D FULL^VALM1
 D CLEAN^VALM10
EX1 Q
 ;
PLKUP(SDFN) ;
 ;This is the lookup by patient.
 ;SDFN is the DFN of the patient.
 ;
 N COD,SDXER
 S COD=""
 F  S COD=$O(^SD(409.75,"ACOD",SDFN,COD)) Q:COD=""  S SDXER=0 F  S SDXER=$O(^SD(409.75,"ACOD",SDFN,COD,SDXER)) Q:SDXER=""  DO
 .N NODE,ANS
 .S NODE=$G(^SD(409.75,SDXER,0)) I NODE=""!($P(NODE,U,1)'>0) Q
 .S ANS=$$CHKDATE($P(NODE,U,1),SDOEDT,SDE)
 .I ANS D BLDA($P(NODE,U,1),$P(ANS,U,2))
 .Q
 Q
 ;
CLKUP(SDCLN) ;
 ;
 ;This is the lookup by clinic.
 ;SDCLN is the IEN of the clinic
 ;
 N SDXER,XMIT,ANS
 S SDXER=0
 F  S SDXER=$O(^SD(409.75,"AECL",SDCLN,SDXER)) Q:SDXER=""  S XMIT=$P($G(^SD(409.75,SDXER,0)),U,1) I XMIT]"" S ANS=$$CHKDATE(XMIT,SDOEDT,SDE) I ANS D BLDA(XMIT,$P(ANS,U,2))
 Q
 ;
CHKDATE(XMIT,BDT,EDT) ;
 ;this function call ensures that the date of the encounter is within
 ;the parameters.
 ;
 ;XMIT - IEN of 409.73
 ;BDT - the beginning date
 ;EDT - the ending date
 ;
 N ANS
 S XMIT=$G(^SD(409.73,XMIT,0))
 I XMIT="" S ANS=0 G CHKQ
 I $P(XMIT,U,2)]"" S DATE=$P($G(^SCE($P(XMIT,U,2),0)),U,1)
 I $P(XMIT,U,3)]"" S DATE=$P($G(^SD(409.74,$P(XMIT,U,3),0)),U,1)
 I (DATE<BDT)!(DATE>EDT) S ANS=0
 E  S ANS="1^"_DATE
CHKQ Q ANS
