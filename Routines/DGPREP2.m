DGPREP2 ;ALB/SCK - Pre-Registration Cont. ; 12/31/96
 ;;5.3;Registration;**109**;Aug 13, 1993
 Q
 ;
EN ; -- main entry point for the DGPRE HIST protocol
 I '$D(^DGS(41.43,"C",PTIFN)) Q
 D EN^VALM("DGPRE HIST")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Calling History for "_$P(^DPT(PTIFN,0),U)
 Q
 ;
INIT ; -- init variables and list array
 ; Variables
 ;   DGPDT   - Formatted date from Call Log, #41.43
 ;   DGPDD   - Status entries from the DD for #41.43
 ;   DGPNR   - No. of entries, index for LM IDX global
 ;   DGPN1   - Local Var for $O
 ;   DGPDATA - 0 node from Call Log file, #41.43
 ;
 N DGPN1,DGPNR,DGPNDX,DGPDD,DGPDT,DGPDATA
 ;
 K ^TMP($J)
 K ^TMP("DGPPR2",$J)
 S DGPN1=0 F  S DGPN1=$O(^DGS(41.43,"C",PTIFN,DGPN1)) Q:'DGPN1  D
 . S ^TMP($J,$P(^DGS(41.43,DGPN1,0),U))=DGPN1
 S DGPNR=1
 S DGPDD=$P(^DD(41.43,3,0),U,3)
 S DGPN1=1 F  Q:$P(DGPDD,";",DGPN1)']""  S DGPT($P($P(DGPDD,";",DGPN1),":"))=$P($P(DGPDD,";",DGPN1),":",2),DGPN1=DGPN1+1
 S DGPN1=9999999.999999 F  S DGPN1=$O(^TMP($J,DGPN1),-1) Q:'DGPN1  D
 . S DGPDATA=^DGS(41.43,^TMP($J,DGPN1),0)
 . S DGPDT=$$FMTE^XLFDT($P(DGPDATA,U),1)
 . S X=$$SETFLD^VALM1(DGPNR,"","INDEX")
 . S X=$$SETFLD^VALM1(DGPDT,X,"DATE/TIME")
 . I $P(DGPDATA,U,3)]"" S X=$$SETFLD^VALM1($P(^VA(200,$P(DGPDATA,U,3),0),U),X,"CALLED BY")
 . I $P(DGPDATA,U,4)]"" S X=$$SETFLD^VALM1(DGPT($P(DGPDATA,U,4)),X,"STATUS")
 . S ^TMP("DGPPR2",$J,DGPNR,0)=X
 . S ^TMP("DGPPR2",$J,"IEN",DGPNR,^TMP($J,DGPN1))=""
 . S ^TMP("DGPPR2",$J,"IDX",DGPNR,DGPNR)=""
 . S DGPNR=DGPNR+1
 S VALMCNT=DGPNR-1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("DGPPR2",$J)
 K DGPDATA
 D FULL^VALM1
 D CLEAN^VALM10
 Q
 ;
EXPND ; -- expand on the selected call log entry
 ; Variables
 ;     DGPIEN  - IEN of selected patient
 ;     DGPCM   - Comments from the Call Log, displayed 1 line at a time
 ;     DGPN1-3 - Loacal Var's for $O
 ;
 N DGPN1,DGPIEN,DGPN2,DGPN3,DGPCM,VALMI,VALMAT,VALMY
 ;
 D FULL^VALM1
 D EN^VALM2(XQORNOD(0),"S") S VALMI=0
 I '$D(VALMY) S VALMBCK="R" Q
 ;
 S DGPN1="",DGPN2=$O(VALMY(DGPN1))
 S DGPIEN="",DGPIEN=$O(^TMP("DGPPR2",$J,"IEN",DGPN2,DGPIEN))
 ;
 S DGPN3=""
 F  S DGPN3=$O(^DGS(41.43,DGPIEN,1,DGPN3)) Q:DGPN3']""  D
 . S DGPCM=$G(^DGS(41.43,DGPIEN,1,DGPN3,0))
 . I DGPCM]"" W !,DGPCM
 D PAUSE^VALM1
 Q
 ;
INQ ;  Entry point for patient Inquiry
 ;
 N DGPRFLG
 S DGPRFLG=1
 D ^DGRPD
 Q
 ;
PTINQ ;  Patient inquiry protocol
 N DGPN1,DGPN2,DFN,DGPRFLG
 ;
 D FULL^VALM1
 D EN^VALM2(XQORNOD(0),"S") S VALMI=0
 ;
 I '$D(VALMY) S VALMBCK="R" Q
 S DGPN1="",DGPN2=$O(VALMY(DGPN1))
 S DFN="",DFN=$O(^TMP("DGPRERG",$J,"DFN",DGPN2,DFN))
 ;
 ; *** Force check for Sensitive patient
 S DIC=2,DIC(0)="ENQ",X=DFN D ^DIC K DIC
 Q:Y<0
 ;
 S DGPRFLG=1
 D EN^DGRPD
 D PAUSE^VALM1
 Q
