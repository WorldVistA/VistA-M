SDAMQ ;ALB/MJK - AM Background Job ; 12/1/91
 ;;5.3;Scheduling;**44,132,153**;Aug 13, 1993
 ;
EN ; -- manual entry point
 I '$$SWITCH D MES G ENQ
 N SDBEG,SDEND,SDAMETH
 S (SDBEG,SDEND)="",SDAMETH=2 G ENQ:'$$RANGE(.SDBEG,.SDEND,.SDAMETH)
 ;D START G ENQ ; line for testing
 S ZTIO="",ZTRTN="START^SDAMQ",ZTDESC="ReCalc Appointment Status"
 F X="SDBEG","SDEND","SDAMETH" S ZTSAVE(X)=""
 K ZTSK D ^%ZTLOAD W:$D(ZTSK) "  (Task: #",ZTSK,")"
ENQ Q
 ;
START ;
 G STARTQ:'$$SWITCH
 N SDSTART,SDFIN
 K ^TMP("SDSTATS",$J)
 S SDSTART=$$NOW^SDAMU D ADD^SDAMQ1
 D EN^SDAMQ3(SDBEG,SDEND)  ; appointments
 D EN^SDAMQ4(SDBEG,SDEND)  ; add/edits
 D EN^SDAMQ5(SDBEG,SDEND)  ; dispositions
 S SDFIN=$$NOW^SDAMU D UPD^SDAMQ1(SDBEG,SDEND,SDFIN,.05)
 D BULL^SDAMQ1
STARTQ K SDBEG,SDEND,SDAMETH,^TMP("SDSTATS",$J) Q
 ;
AUTO ; -- nightly job entry point
 G:'$$SWITCH AUTOQ
 ; -- do yesterday's first
 S X1=DT,X2=-1 D C^%DTC
 S (SDOPCDT,SDBEG)=X,SDEND=X+.24,SDAMETH=1 D START
 ; -- check previous 30 days starting with the day before yesterday
 F SDBACK=2:1:31 S X1=DT,X2=-SDBACK D C^%DTC Q:X<$$SWITCH^SDAMU  I '$P($G(^SDD(409.65,+$O(^SDD(409.65,"B",X,0)),0)),U,5) S SDBEG=X,SDEND=X+.24,SDAMETH=1 D START
AUTOQ K SDOPCDT,SDBEG,SDEND,SDAMETH,SDBACK,X,X1,X2 Q
 ;
SWITCH() ;
 Q $$SWITCH^SDAMU<DT
 ;
MES ;
 W !!,*7,"The date when all appointemnts must be checked-in to obtain"
 W !,"OPC credit is ",$$FDATE^VALM1($$SWITCH^SDAMU),"."
 W !!,"It is too soon to run this option."
 Q
 ;
RANGE(SDBEG,SDEND,SDAMETH) ; -- select range
 N SDWITCH,SDT,X1,X2,X
 S (SDBEG,SDEND)=0,SDT=DT
 I $G(SDAMETH)>0 S X1=DT,X2=-1 D C^%DTC S SDT=X
 S DIR("B")=$$FDATE^VALM1(SDT),SDWITCH=$$SWITCH^SDAMU
 S DIR(0)="DA"_U_SDWITCH_":"_SDT_":EX",DIR("A")="Select Beginning Date: "
 S DIR("?",1)="Enter a date between "_$$FDATE^VALM1(SDWITCH)_" to "_$$FDATE^VALM1(SDT)_".",DIR("?")=" "
 W ! D ^DIR K DIR G RANGEQ:Y'>0 S SDBEG=Y
 S DIR("B")=$$FDATE^VALM1(SDT)
 S DIR(0)="DA"_U_SDBEG_":"_SDT_":EX",DIR("A")="Select    Ending Date: "
 S DIR("?",1)="Enter a date between "_$$FDATE^VALM1(SDBEG)_" to "_$$FDATE^VALM1(SDT)_".",DIR("?")=" "
 D ^DIR K DIR G RANGEQ:Y'>0 S SDEND=Y_".24"
RANGEQ Q SDEND
 ;
DIV(SDIV,SDNAME,SDLEN) ; -- get division ifn and name
 ;  input:   SDIV := candidate division ifn
 ;          SDLEN := length of name to pass back [optional]
 ; output: SDNAME := name of division
 ; return:        := division ifn
 ;
 N X
 I '$D(SDLEN) N SDLEN S SDLEN=35
 S X=$S('$P($G(^DG(43,1,"GL")),U,2):+$O(^DG(40.8,0)),$D(^DG(40.8,+SDIV,0)):+SDIV,1:+$O(^DG(40.8,0)))
 S SDNAME=$E($S($D(^DG(40.8,X,0)):$P(^(0),U),1:"UNKNOWN"),1,SDLEN)
 Q X
 ;
CO(SDOE) ; -- has co process completed
 Q $P($G(^SCE(+SDOE,0)),U,7)>0
