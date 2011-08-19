SDPP ;ALB/CAW - Patient Profile - Main ; 20 Oct 98 11:15 PM
 ;;5.3;Scheduling;**2,6,132,163**;Aug 13, 1993
 ;
EN ;
 K ^TMP("SDPP",$J) N SDBD,SDED
 S VALMBCK=""
 W ! D EN^VALM("SDPP PATIENT PROFILE")
 S VALMBCK="R"
 Q
 ;
HDR ; Header
 N VA,VAERR
 Q:'$D(DFN)
 D PID^VADPT
 S VALMHDR(1)=$E($P("Patient: "_$G(^DPT(DFN,0)),"^",1),1,30)_" ("_VA("BID")_")"_"     "_$S('$G(SDHDR):$$FDATE^VALM1(SDBD)_" to "_$$FDATE^VALM1(SDED),1:"All Dates")
 S X=$S($D(^DPT(DFN,.1)):"Ward: "_^(.1),1:"Outpatient")
 S VALMHDR(1)=$$SETSTR^VALM1(X,VALMHDR(1),81-$L(X),$L(X))
 Q
 ;
INIT ; Gather generic patient info
 D QUIT1 S (SDLN,SDERR,SDPRINT)=0
 S DIC=2,DIC(0)="AEMQ" D ^DIC K DIC S:Y<0 VALMQUIT="" G:Y<0 INITQ S DFN=+Y
 D DIR I SDERR S VALMQUIT="" G INITQ
 I 'SDRANGE S (SDBD,SDBEG)=2800101,(SDED,SDEND)=$$ENDDT() S SDHDR=1 G INIT0
 S SDT00="AEX" D DATE^SDUTL I '$D(SDED) S VALMQUIT="",SDERR=1 G INITQ
 S SDED=SDED_.24
INIT0 D DIR1 I SDERR S VALMQUIT="" G INITQ
 I SDYES S SDPRINT=1 D ^SDPPRT S VALMQUIT="" K:'$D(VALMHDR(1)) ^TMP("SDPP",$J) D QUIT1 G INIT
 ;
INIT1 N VA,VAERR K VALMQUIT
 D PID^VADPT
 S (SDERR,SDLN)=0 D ^SDPPAT1 ;    Generic Patient Information
 S VALMCNT=SDLN
INITQ Q
 ;
ENDDT() ;Calculate end date for "all" dates
 N X S X=$O(^DPT(DFN,"S",""),-1) S:X<DT X=DT_.24 Q X
 ;
QUIT ;
 K BEGDATE,CNT,DFN,SDCDATA,SDOPE,SDHDR,VA,VAERR,VALMBCK,VALMESC,^TMP("SDPP",$J),^TMP("SDPPALL",$J),^TMP("SD",$J) D KILL^%ZISS
QUIT1 K ENDDATE,ROU,SD,SDACT,SDADD,SDCT,SDCNT,SDASH,SDBD,SDBEG,SDED,SDEND,SDERR,SDDIS,SDDT,SDELIG,SDFST,SDFSTCOL,SDLEN,SDLN,SDLN1,SDPAGE,SDRANGE,SDSEC,SDSECCOL,SDLN,SDDEP,SDPRINT,SDRANGE,SDWHERE,SDYES,SDX
 Q
CHPT ; Change Patient within Patient Profile
 S DIC=2,DIC(0)="AEMQ" D ^DIC K DIC I Y<0 W !,"Patient has not been changed." S VALMBCK="R" Q
 K ^TMP("SDPP",$J) S DFN=+Y,SDLN=0
CHDT K:$G(SDEND)'=9999999 SDHDR D INIT1,HDR S VALMBCK="R"
 Q
DIR ; DIR call
 S (SDYES,SDRANGE)=0,DIR("B")="All" K SDHDR
 S DIR(0)="S^R:Range;A:All",DIR("A")="Do you want a (R)ange or (A)ll"
 S DIR("?",1)="",DIR("?",2)="     (A)ll gives the user all dates.",DIR("?")="     (R)ange allows the user to select a range of dates."
 D ^DIR K DIR I $D(DIRUT) S SDERR=1 G DIRQ
 I "RA"'[Y W !!,"Enter 'R' for a date range or 'A' for all dates." G DIR
 I "R"[Y S SDRANGE=1
 Q
DIR1 ;
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to print the profile"
 S DIR("?",1)="     Enter 'YES' to print the profile.",DIR("?")="     If you enter 'NO', it will take you to the Patient Profile screens."
 D ^DIR K DIR I $D(DIRUT) S SDERR=1 G DIRQ
 I Y S SDYES=1
DIRQ Q
