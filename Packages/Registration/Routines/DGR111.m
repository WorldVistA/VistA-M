DGR111 ;ALB/TGH,LMD - Health Benefit Plan Main Menu - List Manager Screen ;4/11/13 10:56am 
 ;;5.3;Registration;**871**;Aug 13, 1993;Build 84
 ;
EN(DFN) ;Main entry point to invoke the DGEN HBP PATIENT list
 ; Input  -- DFN      Patient IEN
 ;
 ; Set up to use two ListMan Menus dependent upon HBP source
 N HBP,DGHBP,HBPSRC,MENU
 D GETHBP^DGHBPUTL(DFN)
 S MENU="DGEN HBP PATIENT"
 D WAIT^DICD
 D EN^VALM(MENU)
 Q
 ;
HDR ;Header code
 N X
 D PID^VADPT
 S VALMHDR(1)=$E("Patient: "_$P($G(^DPT(DFN,0)),U),1,30)
 S VALMHDR(1)=VALMHDR(1)_" ("_VA("BID")_")"
 S X="PATIENT TYPE UNKNOWN"
 I $D(^DPT(DFN,"TYPE")),$D(^DG(391,+^("TYPE"),0)) S X=$P(^(0),U,1)
 S VALMHDR(1)=$$SETSTR^VALM1(X,VALMHDR(1),60,80)
 I '$D(^DPT(DFN,"HBP")) S VALMHDR(2)="No Currently Stored HBP Data"
 Q
 ; 
INIT ;Build patient HBP current screen
 D CLEAN^VALM10
 D CLEAR^VALM1
 D GETHBP(DFN)
 Q
 ;
GETHBP(DFN) ;Load HBPs from HBP array into TMP(VALMAR global for display
 ; INPUT:    DFN = Patient IEN
 N DGHBP,DGSEL,DGDATA,Z,HBPSRC,BRACKET
 S VALMCNT=0,(DGDATA,HBPSRC)=""
 D GETHBP^DGHBPUTL(DFN)
 S DGHBP=""
 F  S DGHBP=$O(HBP("CUR",DGHBP)) Q:DGHBP=""  D
 . S HBPSRC=$S(HBPSRC="E":"E",1:$P(HBP("CUR",DGHBP),"^",5))
 S BRACKET=$S(HBPSRC="E":"<>",1:"[]")
 F  S DGHBP=$O(HBP("CUR",DGHBP)) Q:DGHBP=""  D
 . S DGDATA=HBP("CUR",DGHBP)
 . S VALMCNT=VALMCNT+1
 . S Z=$E(BRACKET)_VALMCNT_$E(BRACKET,2)_"  "_DGHBP
 . S DGSEL(VALMCNT)=DGHBP
 . D SET^VALM10(VALMCNT,Z,VALMCNT)
 Q
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 ;K ^TMP("DGRP111",$J)
 Q
 ; 
PEXIT ;DGEN MSDS MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
ACT(DGACT) ; Entry point for menu action selection
 ;              = "VH" - View History - DGEN HBP View History protocol
 ;              = "VD" - View Detail of HBP
 N DGACTU,DA,DIE,DIC,DIK,DIPA,DR,X,Y,DGHBP,HPSRC,HBP
 I $G(DGACT)="" G ACTQ
 I $G(DGACT)="Q" Q
 ; Determine if any HBPs were processed by ESR
 S (DGDATA,HBPSRC)=""
 D GETHBP^DGHBPUTL(DFN)
 S DGHBP=""
 F  S DGHBP=$O(HBP("CUR",DGHBP)) Q:DGHBP=""  D
 . S HBPSRC=$S(HBPSRC="E":"E",1:$P(HBP("CUR",DGHBP),"^",5))
 ;
 D FULL^VALM1
 ; If action is a VH then View History display screen (DGR113) then return to main screen
 I DGACT="VH" D EN^DGR113(DFN) G ACTQ
 ; If action is a VD then View Detail display screen (DGR114) then return to main screen
 I DGACT="VD" D EN^DGR114(DFN) G ACTQ
 ; If user does not choose VH or VD return to main screen
 W !,"Health Benefit Plan Profiles can only be edited/modified by an ESC user,"
 W !,"please contact HEC to request changes/edits."
 D PAUSE^VALM1
 ;
ACTQ D INIT S VALMBCK="R" Q
 ;
EXPND ; -- expand code
 Q
 ;
