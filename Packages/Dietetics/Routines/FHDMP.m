FHDMP ; HISC/REL/NCA/JH/RK/FAI - Patient Data Log ;10/19/04  13:26
 ;;5.5;DIETETICS;**1,2**;Jan 28, 2005
BEGIN S ADM="",FHALL=1 D ^FHOMDPA
 G:'FHDFN CLEAN
 I $O(^FHPT(FHDFN,"A",0))<1 W !!,"NO ADMISSIONS ON FILE!" G OMDATE
 S DIC="^FHPT(FHDFN,""A"",",DIC(0)="Q",DA=FHDFN,X="??" D ^DIC
 S WARD="" I $G(DFN)'="" S WARD=$G(^DPT(DFN,.1))
 K ADM
A0 W !!,"Select ADMISSION or RETURN for OUTPATIENT ",$S(WARD'="":" (or C for CURRENT)",1:""),": " R X:DTIME G:X["^" KIL D:X="c" TR^FH
 I (X="")&'($D(^FHPT(FHDFN,"OP"))!$D(^FHPT(FHDFN,"GM"))!$D(^FHPT(FHDFN,"SM"))) W !!,"NO OUTPATIENT DATA ON FILE!" G FHDMP
 I (X="")&($D(^FHPT(FHDFN,"OP"))!$D(^FHPT(FHDFN,"GM"))!$D(^FHPT(FHDFN,"SM"))) G OMDATE
 I WARD'="",X="C" S ADM=$G(^DPT("CN",WARD,DFN)) G CAD:ADM
 S DIC="^FHPT(FHDFN,""A"",",DIC(0)="EQM" D ^DIC G:Y<1 A0 S ADM=+Y
CAD I ADM,$G(^FHPT(FHDFN,"A",ADM,0)) S (SDT,STDT)=$P(^FHPT(FHDFN,"A",ADM,0),U,1),ENDT=DT G P0:SDT
 ;
OMDATE I '($D(^FHPT(FHDFN,"OP"))!$D(^FHPT(FHDFN,"GM"))!$D(^FHPT(FHDFN,"SM"))) W !!,"NO OUTPATIENT DATA ON FILE!" G FHDMP
 W !!,"This report will also display any existing outpatient meals data."
 W !,"Enter the Start Date and End Date for outpatient data.",!
 D STDATE^FHOMUTL S SDT=STDT I STDT="" Q
 S X="T+30" D ^%DT S ENDT=Y
 D DD^%DT S FHDTDF=Y K DIR
 S DIR("A")="Select End Date: ",DIR("B")=FHDTDF,DIR(0)="DAO^"_STDT
 D ^DIR
 Q:$D(DIRUT)  S ENDT=Y S Y=ENDT D DD^%DT W "  ",Y
 D P0
 Q
P0 K IOP S %ZIS="MQ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="INOUT^FHDMP",FHLST="ADM^FHDFN^DFN^IEN200^PID^OPSD^STDT^ENDT^SDT" D EN2^FH G KIL
 U IO D INOUT D ^%ZISC K %ZIS,IOP G FHDMP
 Q
INOUT D F0
 Q:QT="^"  I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 Q:$G(ADM)
 W:QT'="^" !,LN,!,?15,"*** O U T P A T I E N T   M E A L   D A T A ***"
 Q:QT="^"  D DISP^FHOMRMD I EX=U Q
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 Q:QT="^"  D ^FHDPSM I EX=U Q
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 Q:QT="^"  D ^FHDPGM I EX=U Q
CLEAN G KILL^XUSCLEAN
F0 D NOW^%DTC S DT=%\1,DTP=% D DTP^FH S NOW=DTP,S1=$S(IOST?1"C".E:IOSL,1:IOSL-6)
 D PATNAME^FHOMUTL
 ;S Y(0)=^DPT(DFN,0)
 S NAM=FHPTNM,SEX=FHSEX,DOB=FHDOB,PID=$G(PID),AGE=FHAGE,PG=0,QT=""
 S PRTFM=STDT_" TO  "_ENDT
 S DTP=STDT D DTP^FH S SDT1=DTP
 S DTP=ENDT D DTP^FH S EDT1=DTP
 S PRTFM=SDT1_"  TO  "_EDT1
 S LN="",$P(LN,"-",80)=""
 D HDR
 D ALG^FHCLN W !!,"Allergies: " S ALG=$S(ALG="":"None on file",1:ALG) D LNE
 W !!,"Food Preferences Currently on file:",!!?26,"Likes",?58,"Dislikes",!
 K N S P1=1 F K=0:0 S K=$O(^FHPT(FHDFN,"P",K)) Q:K<1  S X=^(K,0) D SP
 W ! S (M1,MM)="",L=0 F  S M1=$O(N(M1)) Q:M1=""  I $D(N(M1)) W $P(M1,"~",2) D  S MM=M1
 .  S (P1,P2)=0 F  S:P1'="" P1=$O(N(M1,"L",P1)) S X1=$S(P1>0:N(M1,"L",P1),1:"") S:P2'="" P2=$O(N(M1,"D",P2)) S X2=$S(P2>0:N(M1,"D",P2),1:"") Q:P1=""&(P2="")  D W0 W:MM'=M1 !
 .  Q
 I $O(N(""))="" W !!,"No Food Preferences on file",! D ^FHDMP1 Q
 W ! K L,N,M,M1,M2 D ^FHDMP1 Q
W0 I X1'="" W ?12 S X=X1 D W1 S X1=X
 I X2'="" W ?46 S X=X2 D W1 S X2=X
 Q:X1=""&(X2="")  S:$Y'<S1 L=1 D:$Y'<S1 HDR G:QT="^" KIL W ! W:L ! S L=0 G W0
W1 I $L(X)<34 W X S X="" Q
 F KK=35:-1:1 Q:$E(X,KK-1,KK)=", "
 W $E(X,1,KK-2) S X=$E(X,KK+1,999) Q
SP S M=$P(X,"^",2) S:M="A" M="BNE" S Z=$G(^FH(115.2,+X,0)),L1=$P(Z,"^",1),KK=$P(Z,"^",2),M1="",DAS=$P(X,"^",4)
 I KK="L" S Q=$P(X,"^",3),L1=$S(Q:Q,1:1)_" "_L1
 I M="BNE" S M1="1~All Meals" G SP1
 S Z1=$E(M,1) I Z1'="" S M1=$S(Z1="B":"2~Break",Z1="N":"3~Noon",1:"4~Even")
 S Z1=$E(M,2) I Z1'="" S M1=M1_","_$S(Z1="B":"Break",Z1="N":"Noon",1:"Even")
SP1 S:'$D(N(M1,KK,P1)) N(M1,KK,P1)="" I $L(N(M1,KK,P1))+$L(L1)<255 S N(M1,KK,P1)=N(M1,KK,P1)_$S(N(M1,KK,P1)="":"",1:", ")_L1_$S(DAS="Y":" (D)",1:"")
 E  S:'$D(N(M1,KK,K)) N(M1,KK,K)="" S N(M1,KK,K)=L1_$S(DAS="Y":" (D)",1:"") S P1=K
 Q
LNE ; Break Line if longer than 65 chars
 I $L(ALG)<66 W ALG Q
 F L=67:-1:1 Q:$E(ALG,L-1,L)=", "
 W $E(ALG,1,L-2)
 S ALG=$E(ALG,L+1,999)
 Q:ALG=""  W !?11
 G LNE
HDR ; Print Header
 S (EX,QT)="" I PG,IOST?1"C".E W:$X>1 ! W *7 R QT:DTIME S:'$T QT="^" Q:QT="^"
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !,?15,"P  A  T  I  E  N  T     D  A  T  A     L  O  G",!
 W !,"Date Range:  ",PRTFM,?62,NOW,!!,PID,?17,NAM,?49,$S(SEX="M":"Male",SEX="F":"Female",1:""),?58,"Age ",AGE,?72,"Page ",PG Q
DTP ; Printable Date/Time
 Q:Y<1  W $J(+$E(Y,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(Y,4,5))_"-"_$E(Y,2,3)
 I Y["." S %=+$E(Y_"0",9,10) W $J($S(%>12:%-12,1:%),3)_":"_$E(Y_"000",11,12)_$S(%<12:"am",%<24:"pm",1:"m")
 K % Q
KIL ; User exit
 Q
