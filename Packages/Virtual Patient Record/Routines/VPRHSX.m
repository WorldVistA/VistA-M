VPRHSX ;SLC/MKB -- HS Mgt Options ;09/18/18 4:36pm
 ;;1.0;VIRTUAL PATIENT RECORD;**8,15,25,27**;Sep 01, 2011;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; DIE                          10018
 ; DIR                          10026
 ; MPIF001                       2701
 ; VADPT                         3744
 ; XLFDT                        10103
 ; XLFSTR                       10104
 ; XUPROD                        4440
 ;
ON ; -- Turn monitoring on/off [VPR HS ENABLE]
 N X0,DA,DR,DIE,X,Y
 S X0=$G(^VPR(1,0)) I '$P(X0,U,2) D  Q  ;off -- turn on
 . S DA=1,DR=".02",DIE="^VPR(" D ^DIE
 . I $P($G(^VPR(1,0)),U,2) S $P(^VPR(1,0),U,4)=$$NOW^XLFDT
 ; 
 I $$PROD^XUPROD D  Q:'$$SURE
 . W !,$C(7) ;On in production
 . W !,"WARNING: Turning off data monitoring will cause the Regional Health Connect"
 . W !,"         server to become out of synch with VistA!!",!
 . W !,"    ***  Do NOT proceed unless directed to do so by Health Product Support"
 . W !,"         or VPR development staff!",!
 W ! S DA=1,DR=".02",DIE="^VPR(" D ^DIE
 I '$P($G(^VPR(1,0)),U,2) S $P(^VPR(1,0),U,3,4)=$$NOW^XLFDT_U
 Q
 ;
SURE() ; -- are you sure?
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="ARE YOU SURE? ",DIR("?")="Enter YES to continue with disabling data monitoring for HealthShare"
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y="^"
 Q Y
 ;
 ;
PATS ; -- Inquire if patient is subscribed [VPR HS PATIENTS]
 N PAT,DFN,SUB,ICN,X
P1 W ! S PAT=$$PATIENT^VPRHST,ICN="" Q:PAT<1
 S SUB=$$SUBS^VPRHS(+PAT),ICN=$$GETICN^MPIF001(+PAT)
 W !!,$P(PAT,U,2)_" is "_$S('SUB:"NOT ",1:"")_"subscribed in HealthShare"
 W !,"DFN: "_+PAT
 W !,"ICN: "_$S(ICN>0:ICN,1:$P(ICN,U,2))
 ; show other validity checks
 S X=+$G(^DPT(+PAT,.35)) I X W !,">> Patient DIED on "_$$FMTE^XLFDT(X)
 I $$TESTPAT^VADPT(+PAT),$$PROD^XUPROD W !,">> TEST PATIENT"
 I $$MERGED^VPRHS(+PAT) D
 . N X S X=$G(^DPT(+PAT,-9))
 . W !,">> Patient is being MERGED"_$S(X:" into DFN "_X,1:"")
 W ! G P1
 Q
 ;
 ;
GET ; -- Add patient/container/record to GET list [VPR HS PUSH]
 G GET^VPRHSX1
 Q
 ;
LAST ; -- Reset last seq# [VPR HS CLEAR LIST]
 W !!,"OUT OF ORDER",$C(7) ;option removed
 Q
 ;
 ;
LOG ; -- Turn update logging on/off for debugging [VPR HS LOG]
 N X0,ACT S X0=$G(^VPR(1,0))
 I '$P(X0,U,2) W !,"NOTE: Data monitoring is not running!!"
 ;
 I '$P(X0,U,5) D  Q  ;off -- turn on logging?
 . N X,Y,DIR
 . W !!,"Upload list logging is currently OFF",!
 . S DIR(0)="YA",DIR("B")="NO"
 . S DIR("A")="Would you like to turn it ON? "
 . S DIR("?",1)="Enter YES to begin saving a copy of the upload list nodes in ^XTMP;"
 . S DIR("?")="logged data will be kept for three days."
 . D ^DIR I Y>0 S $P(^VPR(1,0),U,5)=1
 . D KILL
 ;
 ; on -- turn off logging?
 W !!,"Upload list logging is currently ON",!
 F  S ACT=$$ACTION Q:ACT="^"  D @ACT W !
 Q
 ;
ACTION() ; -- select log action
 N X,Y,Z,DIR,DUOUT,DTOUT
 S DIR(0)="SA^V:VIEW;O:OFF;Q:QUIT;",DIR("A")="Select log action: "
 S DIR("B")=$S($O(^XTMP("VPRHS-0"))?1"VPRHS-"1.N:"VIEW",1:"QUIT")
 S DIR("?")="     Enter QUIT to exit this option."
 S DIR("L",1)="     Enter VIEW to select a date to view data."
 S DIR("L")="     Enter OFF to turn logging of the Upload List off."
 D ^DIR S Z=$G(Y(0)) S:$D(DUOUT)!$D(DTOUT)!(Y="Q") Z="^"
 Q Z
 ;
OFF ; -- turn off logging?
 K DIR S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Would you like to turn logging OFF? "
 S DIR("?")="Enter YES to stop saving a copy of the update list nodes in ^XTMP"
 D ^DIR Q:Y'>0  S $P(^VPR(1,0),U,5)=0
 D KILL
 Q
 ;
KILL ; remove log too?
 N I,X,Y,DIR
 S I=$O(^XTMP("VPRHS-0")),X=+$O(^(I,0)) Q:X<1  ;no data
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Would you like to remove existing logs? "
 S DIR("?",1)="Enter YES to kill any existing logs in ^XTMP; NO will keep the logs"
 S DIR("?")="available until "_$$FMTE^XLFDT(X,2)_"."
 D ^DIR Q:Y<1
 S I="VPRHS-0" F  S I=$O(^XTMP(I)) Q:I'?1"VPRHS-"5N  K ^XTMP(I)
 Q
 ;
VIEW ; -- display ^XTMP log
 N VPRH,PAT,SEQ,LCNT,DFN,STR,DONE
V1 S VPRH=$$DATE Q:"^"[VPRH
 S SEQ=$$NUM(VPRH) Q:"^"[SEQ
 S PAT=$$PATIENT^VPRHST Q:$D(DUOUT)!$D(DTOUT)  S:+PAT<0 PAT=""
 D HDR S LCNT=2 K DONE
 F  S SEQ=$O(^XTMP("VPRHS-"_VPRH,SEQ)) Q:SEQ<1  D  I $G(DONE) W ! Q
 . S DFN=+$O(^XTMP("VPRHS-"_VPRH,SEQ,0)),STR=$G(^(DFN))
 . I PAT,DFN'=+PAT Q
 . S LCNT=LCNT+1 I LCNT>(IOSL-2) D READ Q:$G(DONE)  D HDR S LCNT=3
 . W !,SEQ,?10,DFN,?20,STR
 I '$G(DONE) D READ W !
 G V1
 Q
 ;
HDR ; -- write captions
 W !!,"SEQ",?10,"DFN",?20,$$HTE^XLFDT(VPRH) W:PAT " for ",$P(PAT,U,2)
 W !,$$REPEAT^XLFSTR("-",79)
 Q
 ;
DATE() ; -- select a date from ^XTMP("VPRHS",date)
 N X1,X2,X,Y,DIR,DUOUT,DTOUT,Z
 S X1=$O(^XTMP("VPRHS-0")),X1=+$P(X1,"-",2)
 I 'X1 W !,"There are no log entries to display." Q "^"
 S X2=$O(^XTMP("VPRHS-AAAAA"),-1),X2=+$P(X2,"-",2),DIR("A")="Select a date: "
 S DIR(0)="DAO^"_$$HTFM^XLFDT(X1)_":"_$$HTFM^XLFDT(X2)_":EX"
 S Z=$$HTE^XLFDT(X2),DIR("B")=Z ;latest date available
 I X1=X2 S DIR("?")="Available date is "_Z
 E  S DIR("?")="Available dates are "_$$HTE^XLFDT(X1)_" to "_Z
 S DIR("?")=DIR("?")_", or enter ^ to exit"
 D ^DIR S Z="" S:$D(DUOUT)!$D(DUOUT) Z="^"
 I Y>0 S Z=$P($$FMTH^XLFDT(Y),",")
 Q Z
 ;
NUM(DAY) ; -- select a starting seq#
 N A,Z,X,Y
 S A=+$O(^XTMP("VPRHS-"_DAY,0)),Z=+$O(^XTMP("VPRHS-"_DAY,"A"),-1)
N1 W !,"Starting sequence#: FIRST// "
 R X:DTIME I '$T!(X["^") Q "^"
 I "FIRST"[$$UP^XLFSTR(X) Q 0
 I +X=X,X'<A,X'>Z Q (X-1)
 W !!,"Sequence numbers for this date are "_A_"-"_Z,!
 G N1
 Q
 ;
READ ; -- continue?
 N X K DONE
 W !!,"Press <return> to continue ..." R X:DTIME
 S:X["^" DONE=1
 Q
