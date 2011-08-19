PRCB1A3 ;WIOFO/DWA - CONTROL POINT LISTING W/COST CENTERS ;3/3/04 03:04 AM
 ;;5.1;IFCAP;**76,74**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q  ;invalid entry
 ;
EN1 ; entry point for CONTROL POINT LISTING W/COST CENTERS
 N L,DIC,FLDS,BY,DHD
 S L=0,DIC="^PRC(420,",FLDS="[PRCB CTRLPT]",BY=".01,1,1"
 ;S DIS(0)="I $P(^PRC(420,D0,1,D1,0),""^"",19)'=1"
 S DHD="CONTROL POINT LISTING W/ COST CENTERS          PRINTED BY: "_$$USER^PRCPUREP(DUZ)
 D EN1^DIP
 Q
 ;
EN2 ; entry point for CONTROL POINT LISTING W/COST CENTER EXCEPTIONS
 N STN,CP,CC,ACC,ACT,FUND,CPNAME,I,PAGE,LNCT,TODAY,EXC,CNT,RECORD
 N CP1,CP2,FUND1,L,LN,LN1,SCREEN,DEV,ABORT,FLG,STN1,%ZIS,ZTDESC
 N ZTRTN,ZTSAVE,X,Y,PAGE1
 D NOW^%DTC S Y=% D DD^%DT S TODAY=Y KILL ^XTMP($J)
 S (STN,CP,CC,ACC,ACT,FUND)=0,DEV=$J
 F  S STN=$O(^PRC(420,STN)) Q:'STN  D
 . S CP=0 F  S CP=$O(^PRC(420,STN,1,CP)) Q:'CP!(CP=9999)  D
 . . S RECORD=$G(^PRC(420,STN,1,CP,0)) I RECORD="" Q
 . . S FUND=$P(RECORD,"^",2) I 'FUND Q
 . . S FUND=$P($G(^PRCD(420.3,FUND,0)),"^")
 . . I (".0160.0162.0152.")'[("."_$E(FUND,1,4)_".") Q
 . . S CPNAME=$P(RECORD,"^")                ; format, nnn(n) xxxxx xxxx
 . . S ACT=$P(RECORD,"^",19)                ; 1=inactive
 . . S ACC=$P($G(^PRC(420,STN,1,CP,5)),"^",3)   ; pointer to ^PRCD(420.131,
 . . S:'ACC ACC="NONE" D
 . . . S:ACC'="NONE" ACC=$P($G(^PRCD(420.131,ACC,0)),"^")
 . . . Q
 . . S (CC,I)=0 F  S CC=$O(^PRC(420,STN,1,CP,2,CC)) Q:'CC  D
 . . . D PROCESS
 . . . I 'EXC Q
 . . . S I=$G(I)+1
 . . . S ^XTMP($J,"PRCCPE",STN,FUND,CP,I)=ACT_"^"_CPNAME_"^"_CC_"^"_ACC
 . . . Q
 . . Q
 . Q
 ;
 S %ZIS="Q"
 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="QUEUE^PRCB1A3"
 . S ZTDESC="CONTROL POINT LISTING W/EXCEPTIONS"
 . S ZTSAVE("TODAY")=""
 . S ZTSAVE("DUZ")=""
 . S ZTSAVE("DEV")=""
 . D ^%ZTLOAD
 . D HOME^%ZIS
 . KILL ZTST,IO("Q")
 ;
QUEUE U IO
 S (ABORT,PAGE,PAGE1,SCREEN)=0,LN1=45
 I $E(IOST,1,2)="C-" S SCREEN=1
 I SCREEN S LN1=17
 D HDR
 I SCREEN,IOSL>24 S PAGE1=1
 ;
 S (STN,STN1,CP,CC,ACC,ACT,FUND,FLG)=0
 S (CP1,CP2,FUND1)=""
 F  S STN=$O(^XTMP(DEV,"PRCCPE",STN)) Q:'STN  Q:ABORT  D
 . S FUND=0
 . F  S FUND=$O(^XTMP(DEV,"PRCCPE",STN,FUND)) Q:'FUND  Q:ABORT  D
 . . S CP=0
 . . F  S CP=$O(^XTMP(DEV,"PRCCPE",STN,FUND,CP)) Q:'CP  Q:ABORT  D
 . . . S CNT=0
 . . . F  S CNT=$O(^XTMP(DEV,"PRCCPE",STN,FUND,CP,CNT)) Q:'CNT  Q:ABORT  D
 . . . . S RECORD=^XTMP(DEV,"PRCCPE",STN,FUND,CP,CNT)
 . . . . S STATUS=$P(RECORD,U)
 . . . . I STATUS=0 S STATUS="(ACTIVE)"
 . . . . I STATUS=1 S STATUS="(INACTIVE)"
 . . . . S CP1=$E($P(RECORD,U,2),1,20)
 . . . . S CC=$P(RECORD,U,3)
 . . . . S CC=$G(^PRCD(420.1,CC,0))
 . . . . S CC=$E($P(CC,U),1,45)
 . . . . S ACC=$P(RECORD,U,4)
 . . . . I STN'=STN1 S FUND1=FUND W !!,STN,?6,FUND S LN=LN+1
 . . . . I FUND'=FUND1 S CP2=CP1 W !!,?7,FUND,!,?9,CP1," ",STATUS S LN=LN+1
 . . . . I CP1'=CP2 W !!,?9,CP1," ",STATUS S LN=LN+1
 . . . . W !,?13,CC,?60,ACC S LN=LN+1
 . . . . I STN'=STN1 S STN1=STN
 . . . . I FUND'=FUND1 S FUND1=FUND
 . . . . I CP1'=CP2 S CP2=CP1
 . . . . I LN>LN1 D HDR:'PAGE1 Q:ABORT 
 ;
 I 'ABORT W !!,"<End of Report>" R:SCREEN X:100
 D ^%ZISC
 Q
 ;
 ;--------------------------------------------------------------------
PROCESS ; determine if exception exists
 S EXC=0
 ;
 I $E(FUND,1,4)="0160" D
 . I CC<820100 S EXC=1
 . I CC>836400,CC<860100 S EXC=1
 . I CC>860300,CC<875000 S EXC=1
 . I CC>875200,CC<895900 S EXC=1
 . I CC>895900,CC<899100 S EXC=1
 . I CC>899600 S EXC=1
 . I CC=824300 S EXC=1
 . Q
 ;
 I $E(FUND,1,4)="0152" D
 . I CC<800100 S EXC=1
 . I CC>808300,CC<840100 S EXC=1
 . I CC>847000,CC<860500 S EXC=1
 . I CC>861700,CC<864900 S EXC=1
 . I CC>866000,CC<895000 S EXC=1
 . I CC>895900 S EXC=1
 . I CC=863100 S EXC=0
 . Q
 ;
 I $E(FUND,1,4)="0162" D
 . I CC<850100 S EXC=1
 . I CC>857500,CC<860400 S EXC=1
 . I CC>860400,CC<862100 S EXC=1
 . I CC>862300 S EXC=1
 . I CC=824300 S EXC=0
 . Q
 ;
 Q
 ;
 ;--------------------------------------------------------------
HDR ;PRINT THE HEADER
 I SCREEN,PAGE R !!,"Hit <RETURN> to continue, '^' to Exit ",X:100
 ;
 I SCREEN,X["^" S ABORT=1 Q
 ;
 S PAGE=$G(PAGE)+1
 W #
 W "CONTROL POINT LISTING W/EXCEPTIONS          "
 W "PRINTED BY: "_$$USER^PRCPUREP(DUZ)
 W !,"                                            "_TODAY
 W "     PAGE ",PAGE
 W !!,"STA#  FUND"
 W !,"         CONTROL POINT                                      ACC"
 W !,"             COST CENTER"
 W ! F L=1:1:80 W "-"
 S LN=8
 Q
