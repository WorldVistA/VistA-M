MDPSUL ; HOIFO/NCA - HS Component Utility;5/18/04  09:48 ;10/5/09  09:33
 ;;1.0;CLINICAL PROCEDURES;**21**;Apr 01, 2004;Build 30
 ; Integration Agreements:
 ; IA# 10103 [Supported] XLFDT calls
 ;
EN2 ; Print the List of Components that should be created in HS
 N DIC,MDSPEC,X,Y,DTOUT,DUOUT
 K IOP S %ZIS="MQ",%ZIS("A")="Select LIST Printer: ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP Q:POP
 I $D(IO("Q")) D QUE Q
 U IO D GETLIST D ^%ZISC K %ZIS,IOP Q
QUE ; Queue List
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE,ZTDESC,ZTSK S ZTRTN="GETLIST^MDPSUL",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTDESC="Print the List of Components that should be created in HS."
 D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",! K ZTSK Q
EX ; Exit
 Q
GETLIST ; [Procedure] Loop through Instruments and get active list
 N ANS,DTP,LN,MDLL,MDX,PG,S1
 S S1=$S(IOST?1"C".E:IOSL-8,1:IOSL-7)
 S (ANS,LN)="",$P(LN,"-",57)=""
 S PG=0 N % D NOW^%DTC S DTP=%,DTP=$$FMTE^XLFDT(DTP,"1P") D HDR
 F MDLL=0:0 S MDLL=$O(^MDS(702.09,MDLL)) Q:MDLL<1!(ANS="^")  S MDX=$G(^(MDLL,0)) D
 .Q:'$P(MDX,"^",9)
 .Q:'$P($G(^MDS(702.09,MDLL,.1)),"^",3)
 .D:$Y>(IOSL-8) HDR Q:ANS="^"
 .W !,$E($P(MDX,"^"),1,25),?27,"CPF;MDPSU",?50,"M",MDLL
 Q
HDR ; List Header
 Q:ANS="^"  D:$Y'<S1 PAUSE Q:ANS="^"
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !,DTP,?52,"Page ",PG,!!?10,"LIST  OF  HS  COMPONENTS  NEEDED",!!
 W !,"Name",?27,"Print Routine",?45,"Abbreviation",!,LN
 Q
PAUSE ; Pause For Scroll
 I IOST?1"C".E K DIR S DIR(0)="E",DIR("A")="Enter RETURN to Continue or '^' to Quit Listing"  D ^DIR I 'Y S ANS="^"
 Q
