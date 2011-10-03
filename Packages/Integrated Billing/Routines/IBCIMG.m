IBCIMG ;DSI/JSR - IBCI CLAIMS MANAGER MGR WORKSHEET ;6-MAR-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;; Program Description:
 ;  This routine is a ListManager routine invoked when the user is in
 ;  the bill edit screen.  This is a hybrid routine used for 3 reasons:
 ;     1) To define and display all ListManager Template data with
 ;        aesthetic consistency.
 ;     2) To permit Overriding Access for override CM errors.
 ;     3) To Define and display MailMan header claims specific
 ;        information 
 ;  IBCIMG is the main routine utilized when calling all 3 ListManager
 ;  templates.  IBCIMG contains all the visual display details for all
 ;  LM templates and is also utilized for the building of MailMan 
 ;  Messages.
 ;  Manager Access:
 ;  Is only permitted when IBCIMG security key action is  
 ;  allocated for Manager Override access.
 ;  MailMan Messages:
 ;  Invoked by IBCIUT6 with a call to HDR^IBCIMG.  
EN ; -- main entry point
 D EN^VALM("IBCI CLAIMSMANAGER MGR WK")
 Q
 ;
HDR ; -- header code
 S:'$D(IBCINAM) IBCINAM=IBCIPAD
 S:'$D(IBCICLNO) IBCICLNO=IBCIPAD
 S:'$D(IBCIBIR) IBCIBIR=IBCIPAD
 S:'$D(IBCISEX) IBCISEX=IBCIPAD
 S:'$D(IBCICNM) IBCICNM=IBCIPAD
 S:'$D(IBCIASN) IBCIASN=IBCIPAD
 S:'$D(IBCIBIL) IBCIBIL=IBCIPAD
 S:'$D(IBCISRR) IBCISRR=IBCIPAD
 S:'$D(IBCIEVV) IBCIEVV=IBCIPAD
 S:'$D(IBCICAR) IBCICAR=IBCIPAD_IBCIPAD
 S VALMHDR(1)=" Name: "_$E(IBCINAM,1,27)_"Sex: "_$E(IBCISEX,1)_"  DOB: "_$E(IBCIBIR,1,11)_"  Claim: "_$E(IBCICLNO,1,8)_"("_IBCISRR_")"
 S VALMHDR(2)="  Ins: "_$E(IBCICAR,1,40)_"    Provider: "_$E(IBCIPRV,1,16)
 S VALMHDR(3)="Coder: "_$E(IBCICNM,1,16)_"  Biller: "_$E(IBCIBIL,1,16)_"  Assigned: "_$E(IBCIASN,1,16)
 Q
 ;
INIT ; -- init variables and list array
 S QUITDP=0
 K ^TMP("IBCIMG",$J),^TMP("IBCIMG1",$J)
 S IBCICMP=""
 F I=1:1:50 S IBCICMP=IBCICMP_" "
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 ; User is prompted to enter comments for each claim that has error if
 ; they exit before fixing the claim.
 I ($G(Y)="Q")!($G(Y)=-1) D
 . D UTIL2
 . I Y'=1 S QUITDP=1 Q
 . D CLEAR^VALM1,CLEAN^VALM10
 . D COMMENT^IBCIUT7(IBIFN,1)
 K ^TMP("IBCILM",$J)
 K ^TMP("IBCIMG",$J),^TMP("IBCIMG1",$J)
 Q
 ;
BLD ; build array for display
 N IBRT,IBCISEQ,IBCICNT,IBTC,IBTW,IBSW,IBLR,IBLN,IBT,IBD,IBGRPB,IBGRPE
 N ICDL,ICDSP,ICDXX,LMDX,LMDX2,MODS,MOD2,EOLM
 S (IBCICNT,VALMCNT)=1
 S IBPREV=""
 S IBTC(1)=1,IBTC(2)=30,IBTW(1)=1,IBTW(2)=10,IBSW(1)=79,IBSW(2)=12
 ; create LM display array
 S IBCIERL=0 F  S IBCIERL=$O(^TMP("IBCILM",$J,IBCIERL)) Q:'IBCIERL  D
 . S YARR=""
 . S IBCIZZZ=^TMP("IBCILM",$J,IBCIERL,0)
 . S IBCIYYY=$TR(IBCIZZZ,"~","^")
 . S TYPE=$P($G(IBCIYYY),U,1)
 . S IBLINE=$P($G(IBCIYYY),U,2)
 . S IBCILEV=$P($G(IBCIYYY),U,3)
 . I IBLINE'=IBPREV D
 .. S LMLINE="Line: "_IBLINE
 .. S IBCILD1=$G(^IBA(351.9,IBIFN,5,IBLINE,0))
 .. S IBCILD2=$G(^IBA(351.9,IBIFN,5,IBLINE,2))
 .. S LMBDATE=$P($G(IBCILD1),U,6)
 .. S LMEDATE=$P($G(IBCILD1),U,7)
 .. S LMPOS=$P($G(IBCILD1),U,8)
 .. S LMTOS=$P($G(IBCILD2),U,11)
 .. S LMUNIT=$P($G(IBCILD2),U,12)
 .. S LMCPT=$P($G(IBCILD1),U,9)
 .. S LMCHARG=$P($G(IBCILD1),U,11)
 .. S MODS=$TR($P($G(^IBA(351.9,IBIFN,5,IBLINE,3)),U,1),",","")
 .. S LMMOD=$E(MODS,1,6)
 .. S MOD2=$E(MODS,7,14)
 .. S YARR=$$SETFLD^VALM1(LMTOS,YARR,"TOS")
 .. S YARR=$$SETFLD^VALM1(LMPOS,YARR,"POS")
 .. S YARR=$$SETFLD^VALM1(($E(LMBDATE,5,6)_"/"_$E(LMBDATE,7,8)_"/"_$E(LMBDATE,1,4)),YARR,"BDATE")
 .. S YARR=$$SETFLD^VALM1(($E(LMEDATE,5,6)_"/"_$E(LMEDATE,7,8)_"/"_$E(LMEDATE,1,4)),YARR,"EDATE")
 .. S YARR=$$SETFLD^VALM1($J($FN(LMCHARG,"",2),7),YARR,"CHARGE")  ;JSR 6/22/2001 Number Format fix
 .. S YARR=$$SETFLD^VALM1(LMCPT,YARR,"CPT")
 .. S YARR=$$SETFLD^VALM1(LMMOD,YARR,"MODIFY")
 .. S YARR=$$SETFLD^VALM1(LMUNIT,YARR,"UNITS")
 .. S YARR=$$SETFLD^VALM1(LMLINE,YARR,"LINE")
 .. I IBCICNT'=1 S IBT="",IBD="" S IBCICNT=$$SET(IBT,IBD,IBCICNT,1)
 .. S IBT="",IBD=YARR S IBCICNT=$$SET(IBT,IBD,IBCICNT,1)
 .. D CNTRL^VALM10((IBCICNT-1),1,79,IOINHI,IOINORM)
 .. ; ******
 .. D DIAG^IBCIUT1(IBIFN)
 .. S ICDXX=""
 .. S ICDSP=""
 .. S ICDL=""
 .. F  S ICDL=$O(^TMP("DISPLAY",$J,IBIFN,"ICD",IBLINE,ICDL)) Q:ICDL=""  D
 ... S ICDXX=ICDXX_ICDSP_^TMP("DISPLAY",$J,IBIFN,"ICD",IBLINE,ICDL)
 ... S ICDSP=" / "
 .. S LMDX=" Dx's: "
 .. S LMDX2=ICDXX
 .. ;
 .. ; esg - 10/26/01 - squeeze in 4th thru 7th modifiers on the 2nd line
 .. I $L(ICDXX)<46,MOD2'="" S LMDX2=ICDXX_$J("",47-$L(ICDXX))_MOD2
 .. S IBLR=1
 .. S IBT=$E(LMDX,1,60),IBD=LMDX2 S IBCICNT=$$SET(IBT,IBD,IBCICNT,IBLR)
 .. D CNTRL^VALM10((IBCICNT-1),1,79,IOINHI,IOINORM)
 .. ;  ***** 
 .. S IBGRPB=IBCICNT
 . I IBLINE=IBPREV D
 .. S IBGRPB=IBCICNT,IBLR=1
 .. S IBT="",IBD="" S IBCICNT=$$SET(IBT,IBD,IBCICNT,IBLR)
 . S IBGRPB=IBCICNT,IBLR=1
 . S IBPREV=IBLINE
 . S IBCISEQ=0 F  S IBCISEQ=$O(^TMP("IBCILM",$J,IBCIERL,IBCISEQ)) Q:'IBCISEQ  D
 .. S IBCICM2="Error Level: "_IBCILEV
 .. S IBCICM1="("_IBCIERL_") "_"ClaimsManager Error: "_TYPE_IBCICMP
 .. S IBT=$E(IBCICM1,1,60),IBD=IBCICM2 S IBCICNT=$$SET(IBT,IBD,IBCICNT,IBLR)
 .. S IBCIERT=0 F  S IBCIERT=$O(^TMP("IBCILM",$J,IBCIERL,IBCISEQ,IBCIERT)) Q:'IBCIERT  D
 ... S IBGRPB=IBCICNT,IBLR=1
 ... S DATA=$G(^TMP("IBCILM",$J,IBCIERL,IBCISEQ,IBCIERT,0))
 ... S IBT="     ",IBD=DATA S IBCICNT=$$SET(IBT,IBD,IBCICNT,IBLR)
 ... S IBGRPE=IBCICNT,IBCICNT=IBGRPB,IBLR=2
 ... S (IBCICNT,VALMCNT)=$S(IBCICNT>IBGRPE:IBCICNT,1:IBGRPE)
 F I=1:1:5 S IBT="",IBD="" S IBCICNT=$$SET(IBT,IBD,IBCICNT,1)
 S EOLM=IBCICNT-7
 ;
 I EOLM=-1 S IBCICNT=$$SET(" ","",1,1),IBCICNT=$$SET("No ERRORS defined for claim EVENT DATE: "_IBCIEVV,"",2,1),VALMSG="No Errors found by ClaimsManager."
 ;
 K ^TMP("DISPLAY",$J)  ; This is the arrary for the dx & line assoc.
 Q
 ;
SETO(RT,LN) ;
 ; set line number of beginning line of ClaimsManager error message
 S ^TMP("IBCIMG1",$J,+$G(RT))=+$G(LN)
 Q
 ;
SET(TTL,DATA,LN,LR) ;
 N IBY
 S IBY=$J(TTL,IBTW(LR))_DATA D SET1(IBY,LN,IBTC(LR),(IBTW(LR)+IBSW(LR)))
 S LN=LN+1
 Q LN
 ;
SET1(STR,LN,COL,WD,RV) ; set up TMP array with screen data
 N IBX S IBX=$G(^TMP("IBCIMG",$J,LN,0))
 S IBX=$$SETSTR^VALM1(STR,IBX,COL,WD)
 D SET^VALM10(LN,IBX) I $G(RV)'="" D CNTRL^VALM10(LN,COL,WD,IORVON,IORVOFF)
 Q
CBILL ;Cancel Bill
 ; Uses core IB and takes user cancel and populates Comment
 D CLEAR^VALM1
 N IBQUIT,IBCCCC,I,IBCICNCL
 S IBCICNCL=1
 D PROCESS^IBCC(IBIFN) I IBQUIT=1 S VALMBCK="R" Q
 S VALMBCK="Q"
 K ^TMP("IBCILM",$J)
 Q
EBILL ; re-edit action no need to capture comments
 ; Uses core IB routines and allows user to re-edit bill
 D CLEAR^VALM1,CLEAN^VALM10
 S IBCIREDT=1
 Q
ABILL ; override action
 ; This Protocol driven option only appears for those user witht he override key
 N IBCISNT
 S VALMBCK="R"
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to Override the errors of this bill"
 S DIR("B")="YES"
 D ^DIR K DIR
 Q:$D(DIRUT)
 I Y'=1 Q
 S VALMBCK="Q"
 D CLEAR^VALM1,CLEAN^VALM10
 S IBCISNT=5
 D ST2^IBCIST
 D COMMENT^IBCIUT7(IBIFN,2)
 Q
XIT ;
 S VALMBCK="R"
 D UTIL2
 I Y'=1 Q
 S VALMBCK="Q"
 D CLEAR^VALM1,CLEAN^VALM10
 D COMMENT^IBCIUT7(IBIFN,1)
 Q
 ;
UTIL2 ;
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to Exit the ClaimsManager Interface process"
 S DIR("B")="YES"
 D ^DIR K DIR
 I $D(DIRUT) S Y=1
 K DIRUT
 Q
