PRCFAC4 ;WISC@ALTOONA/CTB-PRINT PO OBLIGATION HISTORY ;2/12/98  2:27 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S U="^",DIC="^PRC(442,",DIC(0)="AEQM",CNT=0,DIC("A")="PURCHASE ORDER NUMBER: " K ^TMP($J),^(U,$J)
 F PRCFI=1:1 D ^DIC Q:Y<0  S CNT=CNT+1,^TMP(U,$J,+Y)="",DIC("A")="ANOTHER ONE: "
 K DIC,PRCFI G Q:'CNT F D0=0:0 S D0=$O(^TMP(U,$J,D0)) Q:'D0  D B
 K PRCFI,PO G Q
B ;DISPLAY SINGLE HISTORY
 I $D(IOF),IOST'["PK-" W @IOF
 E  W !!
 K PO F I=0,1,7 S PO(I)=$S($D(^PRC(442,D0,I)):^(I),1:"")
 W !,?22,"PURCHASE ORDER NUMBER: ",$P(PO(0),U),!
 W !,?2,"DATE: " S Y=$P(PO(1),U,15) D DT
 W ?40,"FCP: " W $E($P(PO(0),U,3),1,30)
 W !?2,"STATUS: " S X=$P(PO(7),"^"),Y=$S($D(^PRCD(442.3,+X,0))#2:$E($P(^(0),U,1),1,30),1:"") W Y
 W !?2,"VENDOR: " S X=$P(PO(1),"^"),Y=$S($D(^PRC(440,+X,0))#2:$E($P(^(0),U,1),1,36),1:"") W Y
 W ?49,"TOTAL: " S X=$P(PO(0),"^",15) W $J(X,11,2)
 S N=0
LINE D HDR F LI=8:1:IOSL-4 S N=$O(^PRC(442,D0,10,N)) G PO:N="" S X=^(N,0) S X2=$P(X,"^",6),X1=$P(X,"^"),X3=$P(X,"^",2) S:X2="" X2=$E($P(X1,".",4),7,99) D WL
 D ASK Q:ASK  G LINE
PO W ! S %A="Would you like to review the entire purchase order",%B="" S %=2 D ^PRCFYN Q:%'=1  S PRC("SITE")=+PO(0) D ^PRCHDP1 Q
WL W !?2,$P(X1,".",1,2),?10,$P(X1,".",3),?19,$E($P(X1,".",4),1,6),?27 S Y=X2 D:+Y'=0 DD^%DT W Y Q:+X3=0  W:$D(^VA(200,X3,0)) ?49,$P(^(0),"^") Q
DT I Y W Y\100#100,"/",Y#100\1,"/",Y\10000+1700
 Q
HDR S (ASK,D1)=0 W !!,"FMS DOCUMENT(S): ",!,?2,"TT/SC",?10,"TR DATE",?19,"REF",?27,"SIG DATE/TIME",?49,"SIGNED BY:" Q
ASK W !!,"Press RETURN to continue, '^' to Quit" R X:$S($D(DTIME):DTIME,1:300) S:X["^"!(N="") ASK=1 I $D(IOF) W @IOF
 Q
Q K %,%W,ASK,DI,DIC,CNT,DA,D0,D1,DIWL,DIWR,I,J,K,LI,N,PO,POP,PRCHPO,^TMP($J),^(U,$J),X,X1,X2,X3,Y,Z Q
EN4 ;PRINT PO FOR RECEIVING
 S PRCF("X")="ASP" D ^PRCFSITE
EN40 D PO^PRCHRPT G:'$D(PRCHPO) EN4Q I X<10!(X>44) W " ??",$C(7) G EN40
 S Y=0 I $D(^PRC(442,DA,11,0)) S DIC="^PRC(442,DA,11,",DIC(0)="NEAZ",DIC("A")="RECEIVING REPORT DATE: " D ^DIC
 I Y>0 K PRCHQ("DEST2") S PRCHFPT=+Y,D0=PRCHPO,PRCHQ="^PRCHFPNT",PRCHQ("DEST")="R",PRCHQ("DEST2")="FR" D ^PRCHQUE,EN4Q
 G EN40
EN4Q K PRCHFPT,PRCHQ,PRCHPO,DIC,D0 Q
