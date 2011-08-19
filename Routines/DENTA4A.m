DENTA4A ;WASH-ISC/HAG,JAH-NON CLINIC TIME REPORT BY PROVIDER ;4/29/96  13:45
 ;;1.2;DENTAL;**17,20**;Apr 15, 1996
 ;VERSION 1.2
 D DATE^DENTA1 G EXIT:Y<0
A W !!,"Would you like to review the data for all providers" S %=1 D YN^DICN D:%=0 Q^DENTAR11 G A:%=0,EXIT:%<0,SKP:%=1
S R !,"Select DENTAL PROVIDER NAME: ",X:DTIME G EXIT:X=""!(X=U)
 S DIC="^DENT(220.5,",DIC(0)="EQMZ" D ^DIC G S:X["?" K DIC I Y>0 S (DENTP,DENTPRV)=$P(Y(0),"^",2) G SKP
 G:X?4N SK:$D(^DENT(226,"C",X))
 W !!,"Provider does not exist." G S
SK W !!,"Provider not in provider file, entries in treatment file okay" S %=1 D YN^DICN G S:%=2 S (DENTP,DENTPRV)=X
SKP S %ZIS="MQ" K IO("Q") D ^%ZIS G EXIT:IO=""
 I $D(IO("Q")) S ZTRTN="QUE^DENTA4A",ZTSAVE("DENTED")="",ZTSAVE("DENTSD")="",ZTSAVE("DENTSTA")="",ZTSAVE("H1")="",ZTSAVE("H2")="",ZTSAVE("U")="" D ^%ZTLOAD K ZTSK,ZTRTN,ZTSAVE G EXIT
QUE U IO
 S DENTSD=DENTSD-.0001,DENTPRV1=$S($D(DENTPRV):DENTPRV,1:""),DENTPRV=$S($D(DENTPRV):DENTPRV-1,1:""),X2="^^^",Z5="" S:$L(DENTPRV)<4&(DENTPRV]"") DENTPRV=$E("000"_DENTPRV,$L(DENTPRV),$L(DENTPRV)+3) S DENTPRV2=DENTPRV
 F I=0:0 S DENTSD=$O(^DENT(226,"AC",DENTSTA,DENTSD)) Q:DENTSD>DENTED!(DENTSD="")  S DENTPRV=DENTPRV2 F J=0:0 S DENTPRV=$O(^DENT(226,"AC",DENTSTA,DENTSD,DENTPRV)) Q:$S(DENTPRV1="":DENTPRV="",1:DENTPRV'=DENTPRV1)  D RPT
 S ^UTILITY($J,"DENTR")=X2 K DENTPRV1,DENTSD,DENTED,X G PRT
RPT S DENT="" F K=0:0 S DENT=$O(^DENT(226,"AC",DENTSTA,DENTSD,DENTPRV,DENT)) Q:DENT=""  D:$D(^DENT(226,DENT,0)) P1
 Q
P1 S X=^DENT(226,DENT,0) I '$D(^UTILITY($J,"DENTR",DENTPRV)) S ^(DENTPRV)="^^^"
 S X1=$P(X,"^",4),X1=$S(X1="R":1,X1="E":2,X1="F":3,1:4) S $P(^UTILITY($J,"DENTR",DENTPRV),"^",X1)=$P(^UTILITY($J,"DENTR",DENTPRV),"^",X1)+$P(X,"^",5),$P(X2,"^",X1)=$P(X2,"^",X1)+$P(X,"^",5) Q
PRT ;PRINT/DISPLAY REPORT
 S DENTPRV="" F I=0:1 S DENTPRV=$O(^UTILITY($J,"DENTR",DENTPRV)) Q:DENTPRV=""  D:'I HDR D:$Y#(IOSL-2)=0 HOLD Q:Z5=U  D PRT1
 I 'I W !!,"There are no non clinical time entries for the time frame you specified" W:$D(DENTP) !,"for provider number ",DENTP W "."
 I I S X=^UTILITY($J,"DENTR"),X2=$P(X,"^",1)+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4) W !!,?34,"TOTAL",?41,$J($P(X,"^",1)+4\8,5),?52,$J($P(X,"^",2)+4\8,5),?61,$J($P(X,"^",3)+4\8,5),?68,$J($P(X,"^",4)+4\8,5),?75,$J(X2+4\8,5)
 W ! D:Z5'=U HOLD G EXIT:$D(ZTSK) D EXIT G DENTA4A
PRT1 S X=^UTILITY($J,"DENTR",DENTPRV),X2=$P(X,"^",1)+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)
 ; Set variable XX to $O to check if provider # exist in "C" X'Ref
 ; and Quit if it does not.  Kill variable XX at label EXIT.
 S XX=$O(^DENT(220.5,"C",DENTPRV,0)) Q:'XX  S X1=$P(^DENT(220.5,XX,0),"^",1) I X1,$D(^VA(200,X1,0)) S X1=$P(^(0),"^",1)
 W !,?4,DENTPRV,?15,X1,?43,$J(($P(X,"^",1)+4\8),3),?54,$J(($P(X,"^",2)+4\8),3),?63,$J(($P(X,"^",3)+4\8),3),?70,$J(($P(X,"^",4)+4\8),3),?75,$J(X2+4\8,5) Q
HDR S H3="DENTAL NON CLINICAL TIME REPORT - SUMMARY REPORT BY PROVIDER",H5=$S(H1=H2:"FOR "_H1,1:"FROM "_H1_" TO "_H2)_"   STATION NO.: "_DENTSTA,H7="(All values are in days)"
 W @IOF,!,?(80-$L(H3)/2),H3,!,?(80-$L(H5)/2),H5,!,?(80-$L(H7)/2),H7
 W !!!,"PROVIDER NO.",?15,"PROVIDER NAME",?41,"RESEARCH",?51,"EDUCATION",?63,"FEE",?68,"ADMIN",?75,"TOTAL",!,"------------",?15,"-------------",?41,"--------",?51,"---------",?63,"---",?68,"-----",?75,"-----" Q
HOLD Q:$D(ZTSK)!(IO'=IO(0))  S Z5="" R !!,"Press return to continue, uparrow (^) to exit: ",Z5:DTIME S:'$T Z5=U Q
EXIT X ^%ZIS("C")
 K %,%DT,DENT,DENTED,DENTP,DENTPRV,DENTPRV1,DENTPRV2,DENTSD,DIC,H1,H2,H3,H5,H7,I,J,K,X,X1,X2,XX,Z1,Z2,Z5,^UTILITY($J,"DENTR") K:$D(ZTSK) ^%ZTSK(ZTSK),ZTSK Q
