RMPRPI05 ;HIN/RVD-PRINT INVENTORY BALANCE BY LOCATION ;3/8/05  11:26
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 ; DBIA #10090 - Read Access to entire file #4.
 ; DBIA #10096 - Access to all %ZOSF nodes.
 ;
 D DIV4^RMPRSIT I $D(Y),(Y<0) Q
 S X="NOW" D ^%DT D DD^%DT S RMDAT=Y
 ;
EN K ^TMP($J),RMPRI,RMPRFLG S RMPREND=0 D HOME^%ZIS
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
CONT G:'$D(RMPRI) EXIT1 S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT1
 I '$D(IO("Q")) U IO G PRINT
 K IO("Q") S ZTDESC="PROSTHETIC INVENTORY LOCATION SUMMARY"
 S ZTRTN="PRINT^RMPRPI05",ZTIO=ION,ZTSAVE("RMPRI(")="",ZTSAVE("RMPRI")=""
 S ZTSAVE("RMPR(""STA"")")="",ZTSAVE("RMDAT")="",ZTSAVE("RMPR(")=""
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 1 G EXIT1
 ;
PRINT I $E(IOST)["C" W !!,"Processing report....."
 ;
 ;call API
 ;input variables:
 ;    RM = any subscript to be used
 ;    RS = rmpr("sta")
 ;    RMPRI = rmpri(location array)
 ;
 S RS=RMPR("STA"),RM="RM"
 ;S RMCHK=$$LBAL^RMPRPI02(RM,RS,.RMPRI)
 ;I RMCHK W !!,"***Error in API RMPRPI02 !!!!",!! G EXIT
 D PROC^RMPRPI02(RM,RS,.RMPRI)
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
 ;k  = Date
 ;
WRI S RL=""
 F  S RL=$O(^TMP($J,"RM",RL)) Q:(RL="")!(RMPREND)  K RMPRFLG S RH="",RLF=RL F  S RH=$O(^TMP($J,"RM",RL,RH)) Q:(RH="")!(RMPREND)  S J=0 D
 .F  S J=$O(^TMP($J,"RM",RL,RH,J)) Q:(J'>0)!(RMPREND)  S K=0 F  S K=$O(^TMP($J,"RM",RL,RH,J,K)) Q:(K'>0)!(RMPREND)  D
 ..S RM3=^TMP($J,"RM",RL,RH,J,K)
 ..S RMIT=J
 ..S RMDTE="        "
 ..S:K'=1 RMDTE=$E(K,4,5)_"/"_$E(K,6,7)_"/"_$E(K,2,3)
 ..S (RMAST,RMUNI)=""
 ..S RMROR=$P(RM3,U,7)
 ..S RMQTY=$P(RM3,U,1)
 ..S RMCOS=$P(RM3,U,3)
 ..S RMVAL=$P(RM3,U,2)
 ..S RMVEN=$P(RM3,U,4)
 ..S RMIDE=$P(RM3,U,5)
 ..S RMUNI=$P(RM3,U,8)
 ..S RMSOR=$P(RM3,U,9)
 ..S:RMROR>RMQTY RMAST="*"
 ..S:RMQTY="" RMQTY=0
 ..S RLO=RL
 ..I '$D(RMPRFLG) D HEAD1
 ..S RMIDE=$E(RMIDE,1,24)
 ..W !,RH_"-"_RMIT,?10,RMIDE,?35,RMSOR,?37,$E(RMVEN,1,6),?44,RMDTE,?54,RMUNI,?56,$J(RMQTY,4)
 ..W ?61,$J(RMCOS,8,2),?69,$J($FN(RMVAL,",",2),10)
 ..S RMPRFLG=1
 ..I $E(IOST)["C",($Y>(IOSL-7)) S DIR(0)="E" D ^DIR S:$D(DTOUT)!(Y=0) RMPREND=1 Q:RMPREND  W @IOF D HEAD,HEAD1 Q
 ..I $Y>(IOSL-6) W @IOF D HEAD,HEAD1 Q
 W !,RMPR("L"),!,"<End of Report>"
 Q
 ;
HEAD W !,"*** PROSTHETICS INVENTORY BALANCE BY LOCATION ***"
 W ?68,"PAGE: ",RMPAGE
 W !,"Run Date: ",RMDAT,?30,"station: ",$E($P($G(^DIC(4,RS,0)),U,1),1,20)
 S RMPAGE=RMPAGE+1
 Q
 ;
HEAD1 I $E(IOST)["C",($Y>(IOSL-7)) S DIR(0)="E" D ^DIR S:$D(DTOUT)!(Y=0) RMPREND=1 Q:RMPREND  W @IOF D HEAD
 I $E(IOST)'["C",($Y>(IOSL-6)) W @IOF D HEAD
 W !,RMPR("L")
 W !,"Location: ",RLO
 W !,?52,"UNIT"
 W !,?45,"DATE",?53,"OF",?65,"UNIT",?74,"TOTAL"
 W !,"HCPCS",?10,"ITEM",?33,"SRC",?37,"VENDOR"
 W ?45,"RECVD",?52,"ISSUE",?58,"QTY",?65,"COST",?74,"VALUE"
 W !,"-----",?10,"----",?33,"---",?37,"------"
 W ?45,"-----",?52,"-----",?58,"---",?65,"----",?73,"------"
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
 W !!,"NO DATA !!!!"
 Q
