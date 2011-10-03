PRCSQR ;WISC/KMB-QUARTERLY REPORT ;10/17/94 9:00
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 N TY,PONUM,OBLAMT,ESTAMT,TOTAL,Z D EN1^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0 S PRCSZ=Z
 K IO("Q") S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) S ZTRTN="PROCESS^PRCSQR",ZTDESC="ESTIMATED BALANCE REPORT",ZTSAVE("TY")="",ZTSAVE("PRC*")="" D ^%ZTLOAD D ^%ZISC D W1 G EXIT:%'=1 W !! G START
 D PROCESS D ^%ZISC D W1 G EXIT:%'=1 W @IOF G START
PROCESS ;
 U IO S Z1="",P=0 D NOW^%DTC S Y=% D DD^%DT S TY=Y
 S (N,Z,Z(0))=PRCSZ,Z(0)=Z(0)_"-"
 S PRCS("PRE")=0,PRCS("O")=0,PRCS("C")=0,N(1)="" D HDR
 F I=0:1 S N=$O(^PRCS(410,"B",N)) Q:N=""!(N'[Z(0))  S N(1)=$O(^PRCS(410,"B",N,0)) Q:N(1)=""  D PROCESS1 Q:Z1=U
 Q:Z1=U  S L="",$P(L,"=",IOM)="=" W !,L S L="" H 2 D NONE^PRCSFMS1 Q:Z1=U
 H 2 D ^PRCSFMS1 Q:Z1=U
 S REPORT2=1 D WRITE,T2^PRCSAPP1
 K REPORT2,PRCS QUIT
 ;
PROCESS1 ;
 N PRCA,PRCB,PRCF,PRCG,PRCH,PRCJ,PRCACP
 S TOTAL1="" S:$D(^PRCS(410,N(1),4)) TOTAL1=^(4) S X=^(0),Z=$P(X,"^",2),PONUM=$P(TOTAL1,"^",5),ADJAMT=$P(TOTAL1,"^",6),ESTAMT=$P(TOTAL1,"^",8),OBLAMT=$P(TOTAL1,"^",3),PRCA=$G(^(4)),PRCB=$G(^(7)),PRCH="*^*",PRCACP=$P(PRCA,"^",14)
 S PRCF=$G(^PRCS(410,N(1),0)),PRCG=$P(PRCF,"^",2),PRCF=$P(PRCF,"^",4)
 I PRCG="A",PRCF=1 S:$P(PRCB,"^",6)]"" PRCS("C")=PRCS("C")-ESTAMT,$P(PRCH,"^")="" S:$P(PRCA,"^",10)]"" PRCS("O")=PRCS("O")-OBLAMT,$P(PRCH,"^",2)="" S PRCS("PRE")=PRCS("PRE")-ESTAMT D PROCESS2 Q
 I PRCG="O" D
 .S:$P(PRCB,"^",6)]"" PRCS("C")=PRCS("C")-ESTAMT,$P(PRCH,"^")=""
 .S:$P(PRCA,"^",10)]"" PRCS("O")=PRCS("O")-OBLAMT,$P(PRCH,"^",2)=""
 .S PRCS("PRE")=PRCS("PRE")-ESTAMT
 .S PRCJ=$O(^PRC(442,"B",PRC("SITE")_"-"_PONUM,0)) I +PRCJ'=0,$P($G(^PRC(442,PRCJ,0)),"^",2)=25 S PRCH="@^@"
 I PRCG="C" S PRCH="",PRCS("C")=PRCS("C")+ESTAMT,PRCS("O")=PRCS("O")+OBLAMT
 I PRCG="A" S PRCH="",PRCS("C")=PRCS("C")-ESTAMT S:PRCACP'="Y" PRCS("O")=PRCS("O")-OBLAMT S PRCS("PRE")=PRCS("PRE")-ESTAMT
 I PRCG="CA" S PRCH="#^#"
 D PROCESS2
 QUIT
 ;
PROCESS2 ;
 D:IOSL-$Y<3 HOLD Q:Z1=U  S X1=$S(Z="C":"CEI",Z="O":"OBL",Z="A":"ADJ",Z="CA":"CAN",1:"")
 S:PRCF=5 X1="ISS"
 W !,$P($P(X,"^"),"-",5),?6,X1,?11,PONUM
 W ?19,$J(ESTAMT,10,2),$P(PRCH,"^",1)
 I OBLAMT W ?29,$J(OBLAMT,10,2),$P(PRCH,"^",2)
 S T(1)=$P($G(^PRCS(410,N(1),1)),"^",4),T(2)=$P($G(^PRCS(410,N(1),4)),"^",4),T(3)=$P($G(^PRCS(410,N(1),9)),"^",3) S:Z="A" T(2)=$P($G(^PRCS(410,N(1),4)),"^",7)
 F I=1:1:3 S Y=T(I) D DD^%DT S PLACE=(I*12)+31,PLACE=PLACE+2 W ?PLACE,Y
 W !,?29,$J(PRCS("PRE"),10,2)
 W ?44,$J(PRCS("C"),10,2)
 W ?59,$J(PRCS("O"),10,2)
 W !,$P($G(^PRCS(410,N(1),2)),"^")
 N STR S STR=$P($G(^PRCS(410,N(1),"IT",1,1,1,0)),"^") W ?40,$E(STR,1,40)
 W !,$G(^PRCS(410,N(1),"CO",1,0)),!
 QUIT
 ;
HOLD ;
 G HDR:$E(IOST,1,2)'="C-" W !,"Press return to continue, uparrow (^) to exit: " R Z1:DTIME S:'$T Z1=U D:Z1'=U HDR Q
HDR ;
 S P=P+1 W @IOF,"QUARTERLY REPORT - ",Z(0)_" "_$E($P(PRC("CP")," ",2),1,15),?53,TY,?76,"PAGE: ",P
 W !,?21,"TRANS $",?33,"OBL/CEIL",?45,"DATE",?57,"DATE",?69,"DATE",!,"SEQ#",?6,"TYPE",?11,"PO/OBL#",?21,"AMOUNT",?33,"$ AMOUNT",?45,"REQ.",?57,"OBL.",?69,"REC'D."
 W !,?29,"CONTROL POINT",?44,"UNCOMMITTED",?59,"UNOBLIGATED",!,?29,"REQUEST TOTAL",?44,"BALANCE",?59,"BALANCE"
 W !,"VENDOR",?40,"FIRST LINE DESCRIPTION",!,"COMMENT"
 S L="",$P(L,"-",IOM)="-" W !,L S L="" Q
WRITE ;
 S (SIGN(1),SIGN(2),SIGN(3))="$" S J=1 F I="PRE","C","O" S:PRCS(I)<0 PRCS(I)=-PRCS(I),SIGN(J)="-$" S J=J+1
 W !!,"Total Request Amount: ",SIGN(1)_$J(PRCS("PRE"),0,2),!,"Control Point Official's Balance: ",SIGN(2)_$J(PRCS("C"),0,2),!,"Fiscal's Unobligated Balance: ",SIGN(3)_$J(PRCS("O"),0,2),! H 4
 S J=1 F I="PRE","C","O" S:SIGN(J)="-$" PRCS(I)=-PRCS(I) S J=J+1
 QUIT
W1 ;
 W !,"Would you like to run another quarterly balance report" S %=2 D YN^DICN G W1:%=0 Q
W2 ;
 W !,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
EXIT K X,SIGN QUIT
