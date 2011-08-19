PRCEFIS5 ;WISC/CTB/CLH-DISPLAY 1358 TRANSACTIONS ;05/19/94
V ;;5.1;IFCAP;**148**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 N PO,PODA,PRCFA,PRC410
 I '$D(PRC("SITE")) N PRC,% S PRCF("X")="AS" D ^PRCFSITE Q:'%
EN1 N Y,DIR,PRCFAUTH,ZTSAVE,ZTRTN,ZTDESC
 D HILO^PRCFQ
 I '$D(PO(0)) N PODA D OBLK^PRCH58OB(.PODA) Q:'PODA  D PO^PRCH58OB(PODA,.PO) Q:$G(PO(0))=""  S PRCFA("PODA")=PODA
 S PRC410(1)=$G(^PRCS(410,+$P($G(PO(0)),"^",12),1)),PRC410(11)=$G(^(11))
 W !!,"SERVICE START DATE: ",$$FMTE^XLFDT($P(PRC410(1),"^",6),"2DZ"),"     SERVICE END DATE: ",$$FMTE^XLFDT($P(PRC410(1),"^",7),"2DZ")
 W !,"AUTHORITY: ",$P($G(^PRCS(410.9,+$P(PRC410(11),"^",4),0)),"^")," ",$P($G(^(0)),"^",2)
 W:$P(PRC410(11),"^",5) !,"SUB: ",$P($G(^PRCS(410.9,+$P(PRC410(11),"^",5),0)),"^")," ",$P($G(^(0)),"^",2) W !
 S DIR("A")="Do you wish to view the Authorization information",DIR("B")="No",DIR(0)="YO",DIR("?")="Enter YES to view authorization information" D ^DIR Q:Y["^"  K DIR S:Y=1 PRCFAUTH=""
 S ZTSAVE("PO*")="",ZTSAVE("PR*")="",ZTSAVE("PRCFAUTH")="",ZTDESC="DISPLAY 1358 "_$P(PO(0),"^"),ZTRTN="Q^PRCEFIS5" D ^PRCFQ
 Q
 ;
Q ;Entry point for queued report
 N %X,AUTHAMT,C,CT,DATE,DIC,DREC,I,LIQAMT,OBNUM,S,TMP,UL,UT,X,X1,Z,ZX,DIR
 S $P(UL,"_",80)="",OBNUM=$S($D(PO(0)):$P(PO(0),U),$D(PRCFA("PODA")):$P(^PRC(442,PRCFA("PODA"),0),U),1:"")
 I '$D(DA) S DA=$S($D(PO(0)):+$P(PO(0),U,12),$D(PRCFA("PODA")):$P(^PRC(442,PRCFA("PODA"),0),U,12),1:0)
 D HDR
 I 'OBNUM!('$D(^PRC(424,"AD",OBNUM))) W !,"Daily Record entries have not yet been entered for this request.",!,"The total committed cost of this request is $" W $S($D(^PRCS(410,DA,4)):$J($P(^(4),U),0,2),1:0),!,UL D:'$D(ZTQUEUED) PAUSE^PRCFQ Q
 S %=1,(X1,CT,UT)="" F  S X1=$O(^PRC(424,"AD",OBNUM,X1)) Q:X1'>0  I $D(^PRC(424,X1,0)) S DREC=^(0) D   I ($G(IOSL)-$Y<4) D:'$D(ZTQUEUED) PAUSE^PRCFQ Q:'%  D HDR
   . I '$D(PRCFAUTH),$P(DREC,U,3)="AU" Q
   . S S="|",X=$P(DREC,U,7) D CNVD^PRCFQ S DATE=Y S TYPE=$P(DREC,U,3)
   . I TYPE="" Q
   . S AUTHAMT=$S(TYPE="AU":-$P(DREC,U,12),TYPE="O":$P(DREC,U,6),TYPE="A":$P(DREC,U,6),1:"")
   . S LIQAMT=$S(TYPE="L":-$P(DREC,U,4),TYPE="O":$P(DREC,U,6),TYPE="A":$P(DREC,U,6),1:"")
   . W !,DATE,?16,S," ",$S(TYPE="O":"OBLIGATION",TYPE="A":"ADJUSTMENT",1:$E($P(DREC,U,10),1,12)),?30,S
   . I AUTHAMT]"",$D(PRCFAUTH) W $J(AUTHAMT,11,2),?42,S S CT=CT+AUTHAMT W $J(CT,11,2),?54,S
   . E  W ?42,S,?54,S
   . I LIQAMT]"" W $J(LIQAMT,12,2),?67,S S UT=UT+LIQAMT W $J(UT,11,2)
   . E  W ?67,S
   . K LIQAMT,AUTHAMT,ADJAMT,X,DREC,DATE,TYPE,Y
 W !,UL D:'$D(ZTQUEUED) PAUSE^PRCFQ
 Q
 ;
HDR W @IOF W ?25,"Obligation #: ",IOINHI,$P(PO(0),"^"),IOINORM
 I $D(PO(8)) W !?$X+4,"Total Authorization:",IOINHI," $ "_$J($FN($P(PO(8),U,3),",",2),12),?$X+5,IOINORM,"Total Liquidation:",IOINHI," $ "_$J($FN($P(PO(8),U,2),",",2),12),IOINORM
 W !?30,"|AUTHORIZATION/ORDER REC|",?59,"LIQUIDATION RECORD"
 W !,?2,"Date/Time",?18,"Reference No",?30,"|Indiv/Daily",?48,"Cumul",?54,"|  Liq. Amt",?67,"| Unliq Bal." W !,UL
 Q
