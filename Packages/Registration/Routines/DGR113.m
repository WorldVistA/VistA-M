DGR113 ;ALB/TGH - Health Benefit Plan View History - List Manager Screen ;4/11/13 10:56am 
 ;;5.3;Registration;**871**;Aug 13, 1993;Build 84
 ;
EN(DFN) ;Main entry point to invoke the DGEN HBP VIEW list
 ; Input  -- DFN      Patient IEN
 ;
 D WAIT^DICD
 D EN^VALM("DGEN HBP VIEW")
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
 Q
 ;
INIT ;Build patient HBP View History screen
 N DGPLAN
 D CLEAN^VALM10
 D CLEAR^VALM1
 D GETPLAN
 Q
 ;
GETPLAN ;Load History from HBP array into TMP(VALMAR global for display
 N DTTIME,CNT,LINEVAR
 S VALMCNT=0
 S LINEVAR="HISTORY"
 D GETHBP^DGHBPUTL
 ; Go thru History and set individual values into Global for display
 S CNT=0
 F  S CNT=$O(HBP("HIS",CNT)) Q:CNT=""  D
 . S DTTIME=""
 . F  S DTTIME=$O(HBP("HIS",CNT,DTTIME)) Q:DTTIME=""  D
 . . N DATA,Y
 . . S DATA=HBP("HIS",CNT,DTTIME)
 . . S Y=DTTIME X ^DD("DD")
 . . S VALMCNT=VALMCNT+1
 . . S LINEVAR=$$SETFLD^VALM1($S($P(DATA,"^",5)="A":" ADD",1:" DELETE"),LINEVAR,"ACTION")
 . . S LINEVAR=$$SETFLD^VALM1($P($TR(Y,"@"," ")," ",1,2),LINEVAR,"DATE/TIME")
 . . S LINEVAR=$$SETSTR^VALM1($P(DATA,"^",1),LINEVAR,23,139)
 . . ;S LINEVAR=$$SETFLD^VALM1($E($$GET1^DIQ(200,$P(DATA,"^",3)_",",.01),1,20),LINEVAR,"USER")
 . . D SET^VALM10(VALMCNT,LINEVAR)
 Q
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;
