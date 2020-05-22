DGR114 ;ALB/TGH,JAM,BDB - Health Benefit Plan View Detail - List Manager Screen ;7/8/19 10:56am 
 ;;5.3;Registration;**871,987,1006**;Aug 13, 1993;Build 6
 ;
EN(DFN) ;Main entry point to invoke the DGEN HBP DETAIL list
 ; Input  -- DFN      Patient IEN
 ;
 D WAIT^DICD
 D EN^VALM("DGEN HBP DETAIL")
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
INIT ;Build patient HBP current screen
 D CLEAN^VALM10
 D CLEAR^VALM1
 D GETPLAN
 Q
 ;
GETPLAN ;Load Plans from HBP array into TMP(VALMAR global for display
 N DGPLAN,Z,DGHBIEN
 D GETPLAN^DGHBPUTL
 S DGPLAN="",VALMCNT=0
 F  S DGPLAN=$O(HBP("PLAN",DGPLAN)) Q:DGPLAN=""  D
 . ;DG*5.3*987 - JAM - Filter out Inactive Plans
 . S DGHBIEN=HBP("PLAN",DGPLAN)
 . I $P($G(^DGHBP(25.11,DGHBIEN,0)),"^",4)="Y" Q
 .;
 . S VALMCNT=VALMCNT+1
 . S Z="["_VALMCNT_"]"_"  "_DGPLAN
 . D SET^VALM10(VALMCNT,Z,VALMCNT)
 Q
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
ACTION ; Get users entered data and process entry to add HBP
 N I,VALMY,VALMNOD
 D FULL^VALM1
 S VALMNOD="3^4450^Select HBP^1-36"
 D EN^VALM2(VALMNOD,"S")
 S I=""
 F  S I=$O(VALMY(I)) Q:I=""  D
 . S ACT=$O(@VALMAR@("IDX",I,""))
 . S DGNAME=$P(@VALMAR@(ACT,0)," ",3,99)
 . S DGACT=HBP("PLAN",DGNAME)
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
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 Q
 ;
PEXIT ; MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
EXPND ; -- expand code
 N CNT,LST,ACT,DGNAME,DGACT
 D ACTION
 S VALMBCK="R"   ; CCR 13613 - fix
 I $G(DGACT)="" Q
 S LST=$P(HBP("DETAIL",0),"^",4)
 ;I LST="" W !,"No detail description is available for this Veteran Medical Benefit Plan" ;DG*5.3*987 HM
 I LST="" W !,"No detail description is available for this VHA Profile" ;DG*5.3*1006 BDB;DG*5.3*987 HM 
 F CNT=1:1:LST W !,HBP("DETAIL",DGACT,CNT)
 S VALMBCK="R"
 D PAUSE^VALM1
 Q
 ;
