LRDRAW ;DALOI/CJS/RLM-WARD COLLECTION SUMMARY ;8/11/97
 ;;5.2;LAB SERVICE;**121,190,272,369**;Sep 27, 1994;Build 2
 ; Reference to ^%DT supported by DBIA #10003
 ; Reference to $$FMTE^XLFDT supported by IA #10103
 ; Reference to $$NOW^XLFDT supported by IA #10103
 ; Reference to ^DIC supported by IA #10007
 ; Reference to ^SC( supported by DBIA #908
 ; Reference to ^VA(200 supported by DBIA #10060
BEGIN S %DT="AE" D ^%DT Q:Y<1  S U="^",%ZIS="Q",LRODT=+Y D FNDLOC Q:LRLLOC[U  S ZTRTN="GO^LRDRAW" D IO^LRWU
END K DIC,%ZIS,LRODT,LRLLOC,LRPGM,LRIO,LRTIME,LRDC,LRDFN,LRDPF,LRIOZERO,LRLWC,LRSN,PNM,SSN,Z
 Q
GO S:$D(ZTQUEUED) ZTREQ="@" U IO S LRDC=0 W @IOF,!,"List of Patients with Lab Orders",?40,"Order Date: "_$$FMTE^XLFDT(LRODT,""),!
 W ?2,"Date/Time Printed: "_$$FMTE^XLFDT($$NOW^XLFDT,""),!
 I LRLLOC="" F I=0:0 S LRLLOC=$O(^LRO(69,LRODT,1,"AC",LRLLOC)) Q:LRLLOC=""  D ORD
 I LRLLOC'="" D ORD
 I 'LRDC W !!,"REPORT EMPTY."
 W !,"Report Completed",!
 Q
ORD S LRSN=0 F  S LRSN=$O(^LRO(69,LRODT,1,"AC",LRLLOC,LRSN)) Q:LRSN<1  D:'$D(^LRO(69,LRODT,1,LRSN,1))&$D(^LRO(69,LRODT,1,LRSN,0)) PRNT
 Q
PRNT S LRDFN=+^LRO(69,LRODT,1,LRSN,0),LRLWC=$P(^(0),U,4),LRDC=1
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3) D PT^LRX
 W !!,PNM,?30,SSN,?50,"ORDER NUMBER: ",$S($D(^LRO(69,LRODT,1,LRSN,.1)):+^(.1),1:"?"),!,"LOCATION: ",LRLLOC,?50,$S(LRLWC="SP":"SEND PATIENT",LRLWC="WC":"WARD COLLECT",LRLWC="LC":"LAB COLLECT",1:"")
 W !,"TESTS: " S I=0 F  S I=$O(^LRO(69,LRODT,1,LRSN,2,I)) Q:I<1  S X=^(I,0) W ?9,$P(^LAB(60,+X,0),U,1) W:$P(X,"^",11) ?30," Canceled by: "_$P(^VA(200,$P(X,"^",11),0),"^") W !
 Q
FNDLOC ;return a location from ^LRO(69,LRODT,1,"AC",LRLLOC,LRSN), from LRNODRQW, LRPHEXPT, LRPHITEM
LOOP S LRLLOC="" W !,$S($D(DIC("A")):DIC("A"),1:"Select PATIENT LOCATION: ")
 R "ALL// ",X:DTIME G:'$T LEND S:X="" X="ALL" S:X="ALL"!(X="all") X="" S LRLLOC=X Q:X=""  I $L(X) G LEND:X["^",LALL:X["?"!(X'?.ANP)
 I $L(X)<2!($L(X)>30) W "  Enter 2 - 30 alpha-numeric name" G LOOP
 I $D(^LRO(69,LRODT,1,"AC",X)) S LRLLOC=X K %,X,Y Q
 S DIC=44,DIC(0)="EMOZ",DIC("S")="I $L($P(^(0),U,2)),$D(^LRO(69,LRODT,1,""AC"",$P(^(0),U,2)))" D ^DIC K DIC
 I $D(DTOUT)!$D(DUOUT) K DTOUT,DUOUT G LOOP
 I Y>0 S LRLLOC=$P(Y(0),U,2) I $D(^LRO(69,LRODT,1,"AC",LRLLOC)) K %,X,Y Q
 I '$D(^LRO(69,LRODT,1,"AC",LRLLOC)) W !,"["_LRLLOC_"] is not a valid entry",$C(7),! G LOOP
SOME S Y=$O(^LRO(69,LRODT,1,"AC",X)) G LALL:Y=""!($E(Y,1,$L(LRLLOC))'=LRLLOC)
 S %=$O(^LRO(69,LRODT,1,"AC",Y)) I $E(%,1,$L(LRLLOC))'=LRLLOC W $E(Y,$L(LRLLOC)+1,$L(Y)) S LRLLOC=Y K %,Y,X Q
 K % S Y=X F %=1:1 S Y=$O(^LRO(69,LRODT,1,"AC",Y)) Q:Y=""!($E(Y,1,$L(LRLLOC))'=LRLLOC)  S %(%)=Y W !,?5,%,?9,Y I '(%#10) R !,"Press ""^"" to quit ",X:DTIME S:'$T X="^" Q:X["^"
 S %=%-1 W !,"CHOOSE 1-",%,": " R X:DTIME G:'$T LOOP G LALL:X["?" G LOOP:X["^"!(X="")
 I X\1'=+X!(X<1)!(X>%) W " ??",$C(7),! G LOOP
 S LRLLOC=%(X) K %,X,Y Q
LALL S X="?",DIC=44,DIC(0)="EMOQ",DIC("S")="I $L($P(^(0),U,2)),$D(^LRO(69,LRODT,1,""AC"",$P(^(0),U,2)))" D ^DIC K DIC
 S Y="" W !,"YOU MAY ALSO CHOOSE FROM:" F %=1:1 S Y=$O(^LRO(69,LRODT,1,"AC",Y)) Q:Y=""  D
 . I '$D(^SC("C",Y)) W !,?3,Y I '(%#10) R !,"Press ""^"" to quit ",X:DTIME S:'$T X="^" Q:X["^"
 G LOOP
LEND K %,X,Y S LRLLOC="^" Q
