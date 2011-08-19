PRCHRPT1 ;ID/RSD,SF-ISC/TKW-PRINT OPTIONS ; [1/13/99 1:27pm]
V ;;5.1;IFCAP;**15,70,106,132**;Oct 20, 2000;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;DISPLAY ITEM HISTORY
 S PRCF("X")="SP",AGN=1,LLCT=0,LNCT=0 D ^PRCFSITE
EN0 Q:'$D(PRC("SITE"))  W !! S DIC="^PRC(441,",DIC(0)="QEAMNZ" D ^DIC G Q:Y<0 S D0=+Y I '$D(^(4,0)) W !,"History for this item does not yet exist.   Press <RETURN>" R X:DTIME G EN0
 S PRCHQ="ITEM^PRCHRPT1",ITMY=Y(0) D RDTXS G:'$D(PRC("SITE")) Q D ^PRCHQUE K DIC,ZTSK,D0
 G EN0
 ;
EN1 ;PRINT ITEM CATALOG
 S PRCF("X")="SP" D ^PRCFSITE
EN10 Q:'$D(PRC("SITE"))  K PRCHD S M="FUND CONTROL POINT",DIS(0)="I PRC(""SITE"")=$E($O(^PRC(441,D0,4,""B"",PRC(""SITE""))),1,3)" D RNG G Q:FR["^"!(TO["^") I FR["?"!(TO["?") D DSP^PRCHRPT2 G EN10
 I FR S X=+FR D FX S FR=X
 I TO S X=+TO D FX S TO=X
 S FR=FR_",!",TO=TO_",z",DIC="^PRC(441,",FLDS="[PRCHITCAT]",BY="#@FCP,FCP,FCP,LONG NAME;"""",@$E(SHORT DESCRIPTION,1,50)" S L=0 D EN1^DIP
 ;
Q K FR,TO,FLDS,BY,DIC,I,J,K,L,PRC,PRCHFCP,D0,DA,M,DIS,ZTSK
 K %,ABORT,DIR,FCPNO,FCPTCNT,FCPTPGS,FR1,FR2,FR3,FR4,ITMNO,ITMY,LCNT,LLIM,NXD,PRCHQ,PRCRI,PRCI,RTX,^TEMP("FCPCNT"),^TEMP("FCPDT"),^TEMP("FCPNAME"),^TEMP("FCPPGS"),TO1,TO2,TO3,TO4,TXCNT,TXFCP,TXIEN,TXR,TXS,TXSTN,X,Y
 K AGN,C,DDH,SCTL,STN,ITMDESC,^TMP("PRCHRPT1",$J)
 K COUNT,DIRUT,FLG,LLCT,LNCT,NX,PRCF("X"),PRCHPDAT,ZTRTN
 QUIT
 ;
FX I $D(^PRC(420,+PRC("SITE"),1,X,0)) S X=PRC("SITE")_$P($P(^(0),U,1)," ",1)
 Q
 ;
ITEM S TXR=$G(^TMP("PRCHITMH",0)) S:'TXR TXR=10
 S U="^" Q:'$D(^PRC(441,D0,0))  S W=$P(^(0),U,2),ASK=0,(W1,W(3),W(4))=0,W(2)="",PRC("SITE")=$S($D(PRC("SITE")):PRC("SITE"),1:0),W(1)=PRC("SITE")_0 K ^TMP("PRCHRPT1",$J)
 F W(1)=W(1):0 Q:'$O(^PRC(441,D0,4,"B",W(1)))  S W(1)=$O(^PRC(441,D0,4,"B",W(1))) S PRCHFCP=$S($D(^PRC(420,PRC("SITE"),1,+$E(W(1),4,9),0)):$P(^(0),U,1),1:$E(W(1),4,9)) K ^TMP("PRCHRPT1",$J) D ITEM0 Q:ASK
 K ASK,W,W1,DIC,COUNT,DIRUT,FLG,LLCT,LNCT,NX,PRCF("X"),PRCHPDAT
 D:$D(ZTSK) KILL^%ZTLOAD K ZTSK
 Q
 ;
ITEM0 I $D(^PRC(441,D0,4,W(1),1,"AC")) D
 . S W(2)=""
 . S W(3)=""
 . S FLG=""
 . S COUNT=""
 . F  S W(3)=$O(^PRC(441,D0,4,W(1),1,"AC",W(3))) Q:W(3)'>0  Q:FLG=1  D
 . . S W(4)=""
 . . F  S W(4)=$O(^PRC(441,D0,4,W(1),1,"AC",W(3),W(4))) Q:W(4)'>0  D
 . . . S ^TMP("PRCHRPT1",$J,(W(4)))=W(4)
 . . . S COUNT=COUNT+1
 . . . I COUNT=TXR S FLG=1 Q
 . . . Q
 . . Q
 . Q
 I '$D(^PRC(441,D0,4,W(1),1,"AC")) D  Q
 . D HDR Q:ASK=1
 . I $D(PRCHFCP) W !!,"FCP: "_PRCHFCP_" has no history for this item."
 . Q
 G:ASK=1 Q
NONE I $O(^TMP("PRCHRPT1",$J,0))="" W !,"A history for this item does not yet exist." D  Q
 . I $G(ZTSK)'>0 W !,"Press RETURN to continue." R X:DTIME Q
 I $G(LNCT)="" S LNCT=0
 I LNCT=0 D HDR
 I LNCT'=0,$E(IOST)="P" S LNCT=0  D HDR
 I LNCT'=0,$E(IOST)'="P" D ASK Q:ASK  S LNCT=0 D HDR
 ;
SKPTXS S NX=0 I $G(LNCT)="" S LNCT=0
 F K=1:1:TXR Q:'$O(^TMP("PRCHRPT1",$J,NX))  S NX=$O(^TMP("PRCHRPT1",$J,NX)),W(6)=^TMP("PRCHRPT1",$J,NX) Q:W(6)=""  S LNCT=LNCT+1,W(5)=0,W(5)=$O(^PRC(442,W(6),2,"AE",D0,W(5))) I W(5)'="" S W1=W1+1 D ITEM1 D CKLCT Q:ASK
 I 'W1 K ^TMP("PRCHRPT1",$J) G NONE
 Q
 ;
CKLCT I $E(IOST)'="P"&(LNCT=5) S LNCT=0 D ASK Q:ASK  D HDR:$O(^TMP("PRCHRPT1",$J,NX))
 I $E(IOST)="P"&(LNCT=50) S LNCT=0 D ASK Q:ASK  D HDR:$O(^TMP("PRCHRPT1",$J,NX))
 Q
 ;
ITEM1 W ! I $D(^PRC(442,W(6),1)),$P(^(1),U,15)'="" S Y=$P(^(1),U,15) D DD^%DT W Y
 W ?15,$P(^PRC(442,W(6),0),U,1)
 I $D(^PRC(442,W(6),2,W(5),2)) S W(7)=^(2) W ?26,$J($P(^(2),U,8),10)
 I $D(^PRC(442,W(6),2,W(5),0)) S W(8)=^(0) W:+$P(W(8),U,3) ?38,$P($G(^PRCD(420.5,+$P(W(8),U,3),0)),U,1)
 W:$D(W(8)) ?48,$J($P(W(8),U,9),9,2) W:$D(W(7)) ?59,$J($P(W(7),U,1),10,2) W:$D(W(8)) ?71,$J($P(W(8),U,2),8)
 I $P($G(^PRC(442,W(6),1)),U,1)>0 S W(8)=$P(^(1),U,1),W(8)=$P($G(^PRC(440,W(8),0)),U,1) I W(8)'="" W !,"Vendor: ",W(8)
 K W(7),W(8)
 Q
 ;
ASK Q:$E(IOST)="P"  W !!,"Press RETURN to continue, '^' to Quit" R X:DTIME I X["^" S ASK=1
 Q
 ;
RNG ; ALLOW ENTRY OF BEGINNING AND ENDING RANGE
 S FR="",TO="z" W !!!,"START WITH "_M_": FIRST//" R FR:DTIME S:$T=0 FR="^" I (FR["?")!(FR["^")!(FR="") Q
 I FR'="@",$D(PRCHD),PRCHD="DATE" K %DT S X=FR D ^%DT S FR=Y W:Y=-1 $C(7),!,"INVALID DATE" G:Y=-1 RNG D DD^%DT W "   ",Y
 W !!,"GO TO "_M_": LAST//" R TO:DTIME S:$T=0 TO="^" Q:(TO["^")!(TO["?")  S:TO="" TO="z" Q:TO="z"
 I $D(PRCHD),PRCHD="DATE" S X=TO D ^%DT S TO=Y W:Y=-1 $C(7),!,"INVALID DATE" G:Y=-1 RNG D DD^%DT W "   ",Y
 I (+FR=FR)&(+TO=TO) I FR>TO W $C(7),!,"INVALID RANGE" G RNG
 I FR'="@" I (+FR'=FR)!(+TO'=TO) I FR]TO W $C(7),!,"INVALID RANGE" G RNG
 Q
 ;
PDT ; ROUTINE ALLOWING ENTRY OF A DATE FOR PRINTING, ETC. (DEFAULTS TO NOW)
 W !!,"Enter date (and time, if not NOW) to "_M S %DT="AET",%DT("A")="DATE: NOW//" D ^%DT K %DT
 S:X="" X="NOW",Y=$H S PRCHPDAT=Y Q:X="NOW"!(X["^")  G:Y=-1 PDT
 I +$P(Y,".",2)'>0 W $C(7),!,"You must enter the time as well as the date to print the report" G PDT
 S PRCHPDAT=Y
 Q
 ;
SDEV ; SELECT DEVICE FOR QUEUED PRINTING
 W ! K %ZIS,IOP S %ZIS="Q",IOP="Q",%ZIS("B")="" D ^%ZIS
 S IOP=ION_";"_IOST_";"_IOM_";"_IOSL I IO=IO(0) D ^%ZIS U IO D @ZTRTN D ^%ZISC
 Q
HDR ;
 ;
 I $G(LNCT)>0&($E(IOST)'="P") D ASK Q:ASK
 W @IOF,!!,"Item Number: ",D0,?25,"Description: ",W,!?8,"FCP: ",PRCHFCP,!!,?26,"Quantity",!,?26,"Previously",?38,"Unit of",?71,"Quantity"
 W !,"Date Ordered",?15,"PO Number",?26,"Received",?38,"Purchase",?48,"Unit Cost",?59,"Total Cost",?71,"Ordered",! F I=1:1:80 W "_"
 Q
RDTXS ; Prompt for # back TX's to list for an FCP(default=10,max=9999)
 W !
RDTXS1 K DIR
 S DIR(0)="F^1:4"
 S DIR("A")="Enter # BACK TRANSACTIONS to list, 'S' to sort or '^' to EXIT"
 S DIR("B")=10
 S DIR("?")="Enter 1-9999 or 'S' to sort by PO Date, FCP, etc."
 S DIR("??")="^D WARN^PRCHRPT1"
 D ^DIR
 S TXS=X
 I $D(DIRUT) S ABORT=1 G Q
 I TXS?.N&((TXS<1)!(TXS>9999)) D QUESTION G RDTXS1
 I TXS?.N S TXR=TXS,^TMP("PRCHITMH",0)=TXR*1,TXR=^TMP("PRCHITMH",0),RTX="A" Q
 I TXS'="s"&(TXS'="S") W ! D QUESTION G RDTXS1
 S ITMNO=$P(ITMY,U,1) G EN^PRCHRPTX
 Q
 ;
QUESTION ;
 W !!,"Enter 1-9999 or 'S' to sort by PO Date, FCP, etc."
 Q
 ;
WARN ;
 W @IOF,!?10,"List Transaction History for Specified Item",!!
 W !,"You may obtain either a listing of a specified number of back transactions",!,"for the item or all transactions (by FCP) within a specified date range."
 W !!,"Please be aware that the latter involves complex sorting and may",!,"take awhile to complete.  Therefore, it is suggested that it be queued to",!,"a printer to immediately free your workstation.",!
 Q
