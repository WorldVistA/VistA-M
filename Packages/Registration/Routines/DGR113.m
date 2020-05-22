DGR113 ;ALB/TGH,HM,KUM,BDB - Health Benefit Plan View History - List Manager Screen ;5/21/19 10:56am 
 ;;5.3;Registration;**871,987,1006**;Aug 13, 1993;Build 6
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
 . . S LINEVAR=$$SETFLD^VALM1("["_VALMCNT_"]",LINEVAR,"NO") ; DG*5.3*987 KUM
 . . S LINEVAR=$$SETFLD^VALM1($S($P(DATA,"^",5)="A":" ASSIGN",1:" UNASSIGN"),LINEVAR,"ACTION") ; DG*5.3*987 HM
 . . S LINEVAR=$$SETFLD^VALM1(Y,LINEVAR,"DATE/TIME") ; DG*5.3*1006 BDB - Time to be displayed along with the date
 . . ; DG*5.3*987 KUM
 . . S LINEVAR=$$SETSTR^VALM1($P(DATA,"^",1),LINEVAR,37,139) ;DG*5.3*1006 BDB - Plan name begins at location 37
 . . D SET^VALM10(VALMCNT,LINEVAR,VALMCNT)
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
ACTION ; Get users entered data and process entry to add HBP
 ; DG*5.3*987 - KUM 
 N I,VALMY,VALMNOD
 D FULL^VALM1
 S VALMNOD="3^4450^Select HBP^1-36"
 D EN^VALM2(VALMNOD,"S")
 S I=""
 F  S I=$O(VALMY(I)) Q:I=""  D
 . S ACT=$O(@VALMAR@("IDX",I,""))
 . S DGNAME=@VALMAR@(ACT,0)
 . ; DG*5.3*966 - Plan name is at position 37
 . S DGACT=$$FIND1^DIC(25.11,,"XQ",$$TRIM^XLFSTR($E(DGNAME,37,999)))
 . D ACT(DGACT)
 Q
 ;
ACT(DGACT) ; Entry point for menu action selection
 ; INPUT: DGACT = Plan number to be assigned
 I $G(DGACT)="" Q
 ; Gather data and send to print in EXPND
 D GETDETL^DGHBPUTL(DGACT)
 Q
 ;
EXPND ; -- expand code
 ; DG*5.3*987 - KUM - For Expand Functionality
 N CNT,LST,ACT,DGNAME,DGACT
 D ACTION
 S VALMBCK="R"
 I $G(DGACT)="" Q
 D FULL^VALM1
 D EN^DGR1131(DFN,DGNAME,.HBP)
 S VALMBCK="R"
 Q
 ;
PEXIT ; MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
