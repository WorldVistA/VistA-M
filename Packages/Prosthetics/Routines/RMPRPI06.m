RMPRPI06 ;HIN/RVD-PRINT INVENTORY BALANCE BY HCPCS ;3/8/05  11:36
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 ; DBIA #10090 - Read Access to entire file #4.
 ; DBIA #10096 - Access to all %ZOSF nodes.
 ;
 D DIV4^RMPRSIT I $D(Y),(Y<0) Q
 S X="NOW" D ^%DT D DD^%DT S RMDAT=Y
 ;
EN K ^TMP($J),RMPRI,RMPRFLG S RMPREND=0 D HOME^%ZIS
 S DIC="^RMPR(661.1,",DIC(0)="AEQM"
 S DIC("S")="I $D(^RMPR(661.1,+Y,0))"
 ;
EN1 ;
 S RAS1="Enter 'ALL' for all HCPCS or 'RETURN' "
 S RAS2="to select individual HCPCS: "
 W !!,RAS1,RAS2
 R RMENTER:DTIME G:$D(DTOUT)!$D(DUOUT)!(RMENTER="^") EXIT1
 G:RMENTER["?" EN1
 S X=RMENTER X ^%ZOSF("UPPERCASE") S RMENTER=Y
 I RMENTER="ALL" S RMPRI="*" G CONT
 ;
SEL W ! F RML=1:1 S DIC("A")="Select HCPCS "_RML_": " D ^DIC G:$D(DTOUT)!(X["^")!(X=""&(RML=1)) EXIT1 Q:X=""  D
 .S RMI=$P(^RMPR(661.1,+Y,0),U,1)
 .I $D(RMPRI(RMI)) W $C(7)," ??",?40,"..Duplicate HCPCS" S RML=RML-1 Q
 .S RMPRI(RMI)=+Y
 ;
CONT G:'$D(RMPRI) EXIT1 S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT1
 I '$D(IO("Q")) U IO G PRINT
 K IO("Q") S ZTDESC="PROSTHETIC INVENTORY LOCATION SUMMARY"
 S ZTRTN="PRINT^RMPRPI06",ZTIO=ION,ZTSAVE("RMPRI(")="",ZTSAVE("RMPRI")=""
 S ZTSAVE("RMPR(""STA"")")="",ZTSAVE("RMDAT")="",ZTSAVE("RMPR(")=""
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 1 G EXIT
 ;
PRINT I $E(IOST)["C" W !!,"Processing report......."
 S RMSUB="RM",RS=RMPR("STA")
 ;call API
 ;input variables:
 ;  RMSUB = 'RM' subscript
 ;  RS    = rmpr("sta")
 ;  rmpri = an array of Location
 ;S RMCHK=$$HBAL^RMPRPI01(RMSUB,RS,.RMPRI)
 ;I RMCHK W !!,"*** Error in API RMPRPI01 !!!" G EXIT
 D PROC^RMPRPI01(RMSUB,RS,.RMPRI)
 ;
 S RMPAGE=1,(RMTOBAL,RMPREND)=0
 I '$D(^TMP($J,"RM")) D NONE G EXIT
 W:$E(IOST)["C" @IOF
 D HEAD,WRI
 I RMSUF D TOTAL W !,"<End of Report>" G EXIT
 ;
 ;write/print report
 ;rh  = HCPCS
 ;rl  = Location
 ;j   = Item
 ;k   = Date
 ;
WRI S RH="",(RMPREND,RMSUF)=0 D HEAD1
 F  S RH=$O(^TMP($J,"RM",RH)) Q:(RH="")!(RMPREND)  D:RMSUF TOTAL S (RVA,RTO)=0,RHO=RH K RMPRFLG S RI=0 F  S RI=$O(^TMP($J,"RM",RH,RI)) Q:(RI'>0)!(RMPREND)  S J=0 D
 .F  S J=$O(^TMP($J,"RM",RH,RI,J)) Q:(J'>0)!(RMPREND)  S RMPRLOCN="" F  S RMPRLOCN=$O(^TMP($J,"RM",RH,RI,J,RMPRLOCN)) Q:(RMPRLOCN="")!(RMPREND)  D
 ..S RMAST="",RMTMP=^TMP($J,"RM",RH,RI,J,RMPRLOCN),RMQTY=$P(RMTMP,U,1)
 ..S RMVAL=$P(RMTMP,U,2),RMCOS=$P(RMTMP,U,3),RMVEN=$P(RMTMP,U,4)_"     "
 ..S RMIDE=$P(RMTMP,U,5),RMLOC=$P(RMTMP,U,6),RMUNI=$P(RMTMP,U,8)
 ..;S RMDAT=$E(J,4,5)_"/"_$E(J,6,7)_"/"_$E(J,2,3)
 ..S RMROR=$P(RMTMP,U,7)
 ..S RMSOR=$P(RMTMP,U,9)
 ..S:RMROR>RMQTY RMAST="*"
 ..S:RMQTY="" RMQTY=0
 ..S RTO=RTO+RMQTY,RVA=RVA+RMVAL
 ..S RMITEM=RI,RMHCPC=RH,RMSUF=1
 ..S RMIDE=$E(RMIDE,1,17)
 ..W !,RH_"-"_RI,?10,RMIDE,?28,RMSOR,?31,$E(RMLOC,1,8),?40,$E(RMVEN,1,7)
 ..W ?46,$J(RMROR,4),?52,RMUNI,?57,$J(RMQTY,4),?61,$J(RMCOS,8,2),?69,$J($FN(RMVAL,",",2),10)
 ..S RMPRFLG=1
 ..I $E(IOST)["C"&($Y>(IOSL-7)) S DIR(0)="E" D ^DIR S:$D(DTOUT)!(Y=0) RMPREND=1 Q:RMPREND  W @IOF D HEAD,HEAD1 Q
 ..I $Y>(IOSL-6) W @IOF D HEAD,HEAD1 K RMPRFLG Q
 Q
 ;
TOTAL W !,?56,"=======================",!,?31,"Totals for ",RHO," = "
 W ?54,$J(RTO,7),?69,$J($FN(RVA,",",2),10),!,RMPR("L")
 S RMSUF=0,RTO=0
 Q
 ;
HEAD W !,"*** PROSTHETICS INVENTORY BALANCE BY HCPCS ***"
 W ?68,"PAGE: ",RMPAGE,!,"Run Date: ",RMDAT
 W ?30,"station: ",$E($P($G(^DIC(4,RS,0)),U,1),1,20)
 S RMPAGE=RMPAGE+1
 Q
 ;
HEAD1 I $E(IOST)["C"&($Y>(IOSL-7)) S DIR(0)="E" D ^DIR S:$D(DTOUT)!(Y=0) RMPREND=1 Q:RMPREND  W @IOF D HEAD
 I $E(IOST)'["C"&($Y>(IOSL-6)) W @IOF D HEAD
 W !,RMPR("L")
 W !,?47,"RE-",?52,"UNIT"
 W !,?46,"ORDER",?53,"OF",?65,"UNIT",?74,"TOTAL"
 W !,"HCPCS",?10,"ITEM",?26,"SRC",?30,"LOCATION",?39,"VENDOR"
 W ?46,"LEVEL",?52,"ISSUE",?59,"QTY",?65,"COST",?74,"VALUE"
 W !,"-----",?10,"----",?26,"---",?30,"--------",?39,"------"
 W ?46,"-----",?52,"-----",?59,"---",?65,"----",?73,"------"
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
 D HEAD W !!,"NO DATA !!!!!"
 Q
