DGR1131 ;ALB/KUM,BDB - Health Benefit Plan View History Expanded - List Manager Screen for screen 11.3.1 ;5/30/19 10:56am 
 ;;5.3;Registration;**987,1006**;Aug 13, 1993;Build 6
 ;
EN(DFN,DGNAME,HBP) ;Main entry point to invoke the DGEN HBP VIEWEXP list
 ; Input  --  DFN      Patient ID
 ;            DGNAME   Text for plan selected from the list in screen 11.3
 ;            HBP      Patient Plan Details array
 ;
 D WAIT^DICD
 D EN^VALM("DGEN HBP VIEWEXP")
 Q
 ;
HDR ;Header code
 N X,DGSTR,DGWD,DGSPC,DGPLAN
 D PID^VADPT
 S VALMHDR(1)=$E("Patient: "_$P($G(^DPT(DFN,0)),U),1,30)
 S VALMHDR(1)=VALMHDR(1)_" ("_VA("BID")_")"
 S X="PATIENT TYPE UNKNOWN"
 I $D(^DPT(DFN,"TYPE")),$D(^DG(391,+^("TYPE"),0)) S X=$P(^DG(391,+^DPT(DFN,"TYPE"),0),U,1)
 S VALMHDR(1)=$$SETSTR^VALM1(X,VALMHDR(1),60,80)
 S VALMHDR(2)=" "
 S VALMHDR(3)="Action   Date/Time             Profile" ;DG*5.3*1006 BDB ; Time is now displayed with the date
 S VALMHDR(4)="------   ---------             -------" ;DG*5.3*1006 BDB
 S DGSTR=$$TRIM^XLFSTR($E(DGNAME,6,999)),DGWD=80,DGSPC="                               "
 D FSTRING(DGSTR,DGWD,.DGPLAN)
 S VALMHDR(5)=DGPLAN(1,0)
 I DGPLAN=2 D
 .S VALMHDR(6)=DGSPC_DGPLAN(2,0)
 S VALMHDR(7)=" "
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
INIT ; -- init variables and list array
 N DGACT,LST,CNT
 D CLEAN^VALM10
 D CLEAR^VALM1
 S LST=$P(HBP("DETAIL",0),"^",4)
 ;I LST="" W !,"No detail description is available for this Veteran Medical Benefit Plan"
 I LST="" W !,"No detail description is available for this VHA Profile" ;DG*5.3*1006 BDB
 S DGACT=$$FIND1^DIC(25.11,,"XQ",$$TRIM^XLFSTR($E(DGNAME,37,999))) ;DG*5.3*1006 ; BDB; Plan name is at location 37
 F CNT=1:1:LST D SET^VALM10(CNT," "_HBP("DETAIL",DGACT,CNT))
 S VALMCNT=CNT
 S VALMBCK="R"
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
PEXIT ; MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
FSTRING(DGSTR,DGWD,DGARRAY) ;Parse text string into lines of length DGWD
 ; Input:
 ; DGSTR - (required) Text string to be parsed
 ;  DGWD - Length of parsed lines (default =80)
 ;
 ; Output:
 ; DGARRAY - (required) Result array of formatted output text, passed by reference
 ;
 N X,DGI,DIWL,DIWR,DIWF
 K DGARRAY,^UTILITY($J,"W")
 S X=$G(DGSTR)
 I X'="" S DIWL=1,DIWR=$G(DGWD,80),DIWF="" D ^DIWP
 I $D(^UTILITY($J,"W")) M DGARRAY=^UTILITY($J,"W",1)
 K ^UTILITY($J,"W")
 Q
