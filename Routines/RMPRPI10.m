RMPRPI10 ;HIN/RVD-PRINT ITEM DETAIL OVER 30 DAYS ;3/8/05  11:40
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 ; DBIA #10090 - Read Access to entire file #4.
 ; DBIA #10096 - Access to all %ZOSF nodes.
 ;
 K DIC,DIR,%DT
 D DIV4^RMPRSIT I $D(Y),(Y<0) Q
 S X="NOW" D ^%DT D DD^%DT S RMDAT=Y
 ;
EN K RMPRI,RMPRFLG S RMPREND=0 D HOME^%ZIS
 S DIC="^RMPR(661.5,",DIC(0)="AEQ"
 S DIC("S")="I $P(^RMPR(661.5,+Y,0),U,2)=RMPR(""STA"")"
 ;
EN1 R !!,"Enter 'ALL' for all Locations or 'RETURN' to select individual Locations: ",RMENTER:DTIME G:$D(DTOUT)!$D(DUOUT)!(RMENTER="^") EXIT1
 G:RMENTER["?" EN1
 S X=RMENTER X ^%ZOSF("UPPERCASE") S RMENTER=Y
 I RMENTER="ALL" S RMPRI="*" G CONT
 W ! F RML=1:1 S DIC("A")="Select Location "_RML_": " D ^DIC G:$D(DTOUT)!(X["^")!(X=""&(RML=1)) EXIT1 Q:X=""  D
 .S RMLOCI=+Y
 .I $D(RMPRI(RMLOCI)) W $C(7)," ??",?40,"..Duplicate Location" S RML=RML-1 Q
 .S RMPRI(RMLOCI)=""
 ;
CONT ;
 K DIR
 S DIR("B")="NEW Items",DIR("A")="Enter a SOURCE Creteria"
 S DIR(0)="S^V:OLD Items;C:NEW Items"
 D ^DIR G:$D(DUOUT)!$D(DIRUT)!$D(DTOUT) EXIT1
 S RE=Y K DIR
 ;
DT ;
 W ! S %DT("A")="Beginning Date: ",%DT="AEPX",%DT("B")="T-30" D ^%DT S RMB=Y G:Y<0 EXIT1
ENDATE S %DT("A")="Ending Date: ",%DT="AEX",%DT("B")="TODAY" D ^%DT G:Y<0 EXIT1 I RMB>Y W !,$C(7),"Invalid Date Range Selection!!" G ENDATE
 S RME=Y
 ;
 G:'$D(RMPRI) EXIT1 S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT1
 I '$D(IO("Q")) U IO G PRINT
 K IO("Q") S ZTDESC="PROSTHETIC INVENTORY LOCATION SUMMARY"
 S ZTRTN="PRINT^RMPRPI10",ZTIO=ION,ZTSAVE("RMPRI(")=""
 S ZTSAVE("RMPR(""STA"")")="",ZTSAVE("RMDAT")="",ZTSAVE("RMPR(")=""
 S ZTSAVE("RE")="",ZTSAVE("RMPRI")=""
 S ZTSAVE("RME")="",ZTSAVE("RMB")=""
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 1 G EXIT1
 ;
PRINT I $E(IOST)["C" W !!,"Processing report....."
 ;
 ;call API
 ;input variables:
 ;    RM = any subscript to be used
 ;    RS = rmpr("sta")
 ;    RE = source (V or C)
 ;    RMPRI = rmpri(location array; '*' for all location )
 ;    RMB   = beginning date
 ;    RME   = ending date
 ;
 S X1=RME,X2=RMB
 D ^%DTC S RMCALDAY=X+1
 S Y=RMB D DD^%DT S RMBDAT=Y S Y=RME D DD^%DT S RMEDAT=Y
 D NOW^%DTC S Y=% X ^DD("DD") S RMDAT=Y
 S RSOU=$S(RE="V":"USED",RE="C":"NEW",1:"")
 S RS=RMPR("STA"),RM="RM"
 ;
 S RMCHK=$$LOC^RMPRPI07(RM,RS,.RMPRI,RE,RMB,RME)
 I RMCHK W !!,"ERROR NUMBER =   ",RMCHK,!,"***Error in API RMPRPI07 !!!!",!! G EXIT
 ;
 S RMPAGE=1,RMPREND=0
 I '$D(^TMP($J,"RM")) D NONE G EXIT
 W:$E(IOST)["C" @IOF
 D HEAD,WRI
 G EXIT
 ;
 ;write/print report
 ;rl = Location
 ;rh = HCPCS
 ;j  = Item
 ;k  = Item description
 ;
 ;
WRI S RL=""
 F  S RL=$O(^TMP($J,"RM",RL)) Q:(RL="")!(RMPREND)  K RMPRFLG S RH="" F  S RH=$O(^TMP($J,"RM",RL,RH)) Q:(RH="")!(RMPREND)  S J="" D
 .F  S J=$O(^TMP($J,"RM",RL,RH,J)) Q:(J="")!(RMPREND)  S K="" F  S K=$O(^TMP($J,"RM",RL,RH,J,K)) Q:(K="")!(RMPREND)  D
 ..S RM3=^TMP($J,"RM",RL,RH,J,K)
 ..S RMIT=K
 ..S RMQTY=$P(RM3,U,1)
 ..S RMCOS=$P(RM3,U,2)
 ..S RMDAU=RMQTY/RMCALDAY
 ..S RMDOH=""
 ..S RMSOH=$P(RM3,U,5)
 ..S:+RMDAU RMDOH=$J(RMSOH/RMDAU,0,1) S:RMDOH>999 RMDOH=">999"
 ..I 'RMDAU S RMDOH=">"_RMCALDAY
 ..S RMDAU=$J(RMDAU,0,3)
 ..S RMTDV=$P(RM3,U,6)
 ..I '$D(RMPRFLG) D HEAD1
 ..S RMIDE=$E(J,1,13)
 ..W !,RH_"-"_RMIT,?10,RMIDE,?24,$J(RMQTY,4),?29,$J($FN(RMCOS,",",2),9),?42,RMDAU,?54,$J(RMDOH,4)
 ..W ?61,$J(RMSOH,5),?70,$J($FN(RMTDV,",",2),10)
 ..S RMPRFLG=1
 ..I $E(IOST)["C",($Y>(IOSL-7)) S DIR(0)="E" D ^DIR S:$D(DTOUT)!(Y=0) RMPREND=1 Q:RMPREND  W @IOF D HEAD,HEAD1 Q
 ..I $Y>(IOSL-6) W @IOF D HEAD,HEAD1 Q
 W !,RMPR("L"),!,"<End of Report>"
 Q
 ;
HEAD W !,"*** STOCK ON HAND OVER DATE RANGE ***"," for ",RSOU," Items"
 W !,"Station: ",$E($P($G(^DIC(4,RS,0)),U,1),1,20),?30,"Run Date: ",RMDAT
 W ?68,"PAGE: ",RMPAGE
 W !,RMBDAT," to ",RMEDAT,?30,"[ ",RMCALDAY," calendar days ]"
 S RMPAGE=RMPAGE+1
 Q
 ;
HEAD1 I $E(IOST)["C",($Y>(IOSL-7)) S DIR(0)="E" D ^DIR S:$D(DTOUT)!(Y=0) RMPREND=1 Q:RMPREND  W @IOF D HEAD
 I $E(IOST)'["C",($Y>(IOSL-6)) W @IOF D HEAD
 W !,RMPR("L")
 W !,"Location: ",$P($G(^RMPR(661.5,RL,0)),"^",1)
 W !,?25,"QTY",?35,"$",?41,"DAYS AVE"
 W ?54,"DAYS",?62,"STOCK",?72,"TOTAL $"
 W !,"HCPCS",?10,"ITEM",?24,"ISSUE",?33,"VALUE"
 W ?40,"USAGE RATE",?52,"ON-HAND",?61,"ON-HAND",?70,"VAL ON-HND"
 W !,"-----",?10,"----",?24,"-----",?33,"-----"
 W ?40,"----------",?52,"-------",?61,"-------",?70,"----------"
 S RMPRFLG=1
 Q
 ;
EXIT I $E(IOST)["C",'RMPREND W ! S DIR(0)="E" D ^DIR
 ;
EXIT1 D ^%ZISC
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 K ^TMP($J)
 Q
 ;
NONE ;
 W:$E(IOST)["C" @IOF
 D HEAD
 W !,RMPR("L")
 W !!,"NO DATA to print !!!"
 Q
