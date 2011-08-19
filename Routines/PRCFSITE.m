PRCFSITE ;WISC/CTB/CLH/DL-RETURNS PRC* VARIABLES ; 1/29/98  1315
V ;;5.1;IFCAP;**139**;Oct 20, 2000;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
DIVFY ;CHECK FOR STATION AND FY
 D DUZ G:'% Q
 I $D(PRC("FY")),PRC("FY")'?2N K PRC("FY")
 I '$D(DT) D NOW^%DTC S DT=X K %,%H,%I,X
 W ! I '$D(^PRC(411,0)) W "SITE PARAMETERS HAVE NOT YET BEEN ESTABLISHED, NO FURTHER PROCESSING CAN OCCUR",$C(7) G Q
 S U="^",B=^PRC(411,0) I +$P(B,U,4)<1 W !,"NO ENTRIES FOUND IN SITE PARAMETER FILE",$C(7) G Q
 I $D(%F) S PRCF("X")=%F
 S %=1 K PRC("SP") I '$D(PRCF("X")) S PRCF("X")="AFS"
 S:$G(^VA(200,+PRC("PER"),400))]"" PRC("SP")=1
 I $P(B,U,4)>1 S PRC("MDIV")="" S:PRCF("X")["B" PRC("MDIV")=""
 I '$D(PRC("SITE")),PRCF("X")["S"!(PRCF("X")["B") S PRC("SITE")=$S($O(^PRC(411,"AC","Y",0)):$O(^PRC(411,"AC","Y",0)),1:$O(^PRC(411,0)))
 I '$D(PRC("FY")) S %DT="",X="T" D ^%DT S A=$E(Y,2,3),B=$E(Y,4,5),PRC("FY")=$E(100+$S(+B>9:A+1,1:A),2,3),PRC("QTR")=$S(B<4:2,B<7:3,B<10:4,1:1) S X=""
 K PRC("FU") I PRCF("X")["A",'$G(PRC("SP")) D AFU^PRCFSI1 G:$G(PRC("FU")) Q
 I '$D(PRC("MDIV")) S PRC("SITE")=$O(^PRC(411,0))
SI I $D(PRC("MDIV")),PRCF("X")["S"!(PRCF("X")["B") W ! S DIC("A")="Select STATION NUMBER ('^' TO EXIT): ",DIC("B")=PRC("SITE"),DIC=411,DIC(0)="AEQMZ",DIC("S")="I +Y<1000000" D ^DIC K DIC G:+Y<0 Q S PRC("SITE")=+Y
 I PRCF("X")["A",'$G(PRC("SP")) D AFU1^PRCFSI1 G:$G(PRC("FU")) Q
FY K X I PRCF("X")["F"!(PRCF("X")["B") W !,"Select FISCAL YEAR ('^' to EXIT): ",PRC("FY"),"// " R X:$S($D(DTIME):DTIME,1:60) G:X["^" Q I (X["?")!(X'?2N&(X'="")) W $C(7) D HELP1 G FY
 S:'$D(X) X="" I X="" S X=PRC("FY")
 E  S PRC("FY")=X
QTR G:PRCF("X")'["Q" SE1 W !,"Select FISCAL QUARTER: "_$S($D(PRC("QTR")):PRC("QTR")_"// ",1:"") R X:$S($D(DTIME):DTIME,1:50)
 G:'$T!(X["^") Q I $L(X)>1!("1234"'[X) W !,$C(7),"Enter a number between 1 and 4 ONLY." G QTR
 I X]"" S PRC("QTR")=X
SE1 S X="" S:$D(PRC("SITE")) PRC("PARAM")=^PRC(411,PRC("SITE"),0)
ISMS I $D(PRCFASYS),$D(PRC("SITE")) S:$$ISMSFLAG^PRCPUX2(PRC("SITE"))=2 PRCFASYS=PRCFASYS_"ISM"
 I PRCF("X")["B" S PRCF("SIFY")=PRC("SITE")_"-"_PRC("FY"),PRCB("LAST")=100000-($O(^PRCF(421,"AD",PRCF("SIFY"),0)))
OUT S %=1 K %DT,DIC,PRC("SP"),PRC("MDIV"),PRC("L"),PRC("I"),PRCF("X"),%F,A,B,X,Y Q
FYQ ;RETURNS FY AND QTR GIVEN IN FILEMANAGER DATE IN 'X'
 G:'$D(X) Q G:X=""!($E(X,1,7)'?7N)!(+$E(X,1,7)'=$E(X,1,7)) Q S Y=$E(X,2,3),Y(1)=$E(X,4,5),PRC("FY")=$E(100+$S(+Y(1)>9:Y+1,1:Y),2,3),PRC("QTR")=$S(Y(1)<4:2,Y(1)<7:3,Y(1)<10:4,1:1) K Y S %=1 Q
Q K PRC,PRCF("X"),PRCB,%DT,DIC,%F,A,B,X,Y S %=0 Q
HELP1 W !,"ENTER LAST TWO DIGITS OF FISCAL YEAR, OR <CR> TO ACCEPT PROMPT" Q
A S %X=$P(^VA(200,+PRC("PER"),0),"^"),%X=$P(%X,",",2)_" "_$P(%X,",")_$P(%X,",",3),$P(^VA(200,+PRC("PER"),20),"^",2)=%X,X=%X K %X Q
DUZ K PRCFDEL,PRC("PER") S %=1 I $D(DUZ)#2,+DUZ>0 S PRC("PER")=+DUZ
 I '$D(PRC("PER")) S %=0 W !,$C(7),"YOU ARE NOT IN THE 'NEW PERSON' FILE.  CONTACT YOUR SITE MANAGER",! Q
 K X S X=$S('$D(^VA(200,+PRC("PER"),20)):"",1:^VA(200,+PRC("PER"),20))
 I $P(X,"^",2)="" D A
 S $P(PRC("PER"),"^",2,4)=$P(X,"^",2)_"^"_$P(X,"^",3)_"^"_$S($D(^VA(200,+PRC("PER"),.13)):$P(^(.13),"^",2),1:"")
 Q
INIT ;PRIMARY INIT POINT FOR PRC OPTIONS
 D DUZ Q:'%  I $D(DUZ(0)),$D(DT),$D(DTIME),+DT>0,+DTIME>0 Q
 D DT^DICRW Q
EX ;EXIT LINE FOR MENUMANAGER
 K P
NA S X="<No action taken>" D MSG^PRCFQ S X="" Q
PRIMARY ;INPUT TRANSFORM FOR FILE 411 FIELD 21 "PRIMARY STATION"
 N PRCFX,PRCFY,%A,%B,PRCFZ,N S PRCFX=X S PRCFY=$O(^PRC(411,"AC",1,0))
 I $S('PRCFY:1,PRCFY=DA:1,1:0) Q
 S PRCFZ=$P(^PRC(411,PRCFY,0),"^",9),%A="Station number "_PRCFZ_" has already been designated as 'PRIMARY'",%A(1)="OK to REPLACE",%B="",%=2 D ^PRCFYN I %'=1 D NA Q
 S %A="Are you sure you want to make STATION "_$P(^PRC(411,DA,0),"^",9)_" as 'PRIMARY'",%B="",%=2 D ^PRCFYN I %'=1 D NA Q
 ;CLEAN UP CURRENT ENTRIES
 F N=0:0 S N=$O(^PRC(411,"AC","Y",0)) Q:'N  K ^(N) S $P(^PRC(411,N,0),"^",2)=""
 S X=" <Primary Station Changed>*" D MSG^PRCFQ S X="Y" Q
