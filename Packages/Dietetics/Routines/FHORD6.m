FHORD6 ; HISC/REL/NCA/JH/RTK - Diet Inquiry ;5/3/01  11:04
 ;;5.5;DIETETICS;**1,5**;Jan 28, 2005;Build 53
 S FHALL=1 D ^FHOMDPA I 'FHDFN G KIL
 D MONUM^FHOMUTL I FHNUM="" Q
 I FHDFN,DFN="" D ^FHOMPP Q  ;profile for file #200 outpatients
 I FHDFN,$G(^DPT(DFN,.1))="" D ^FHOMPP Q  ;profile for file #2 outpts
 K IOP S %ZIS="MQ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="F0^FHORD6",FHLST="FHDFN^DFN^PID^ADM^FHNUM" D EN2^FH G KIL
 U IO D F0 D ^%ZISC K %ZIS,IOP G FHORD6
F0 ; Display Diet
 D NOW^%DTC S NOW=%,DT=NOW\1,QT=""
 S WARD=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8) S:WARD WARD=$P($G(^FH(119.6,WARD,0)),"^",1)
 S Y(0)=^DPT(DFN,0),SEX=$P(Y(0),"^",2),DOB=$P(Y(0),"^",3)
 S AGE=$E(NOW,1,3)-$E(DOB,1,3)-($E(NOW,4,7)<$E(DOB,4,7)),X=$P($G(^DPT(DFN,.101)),"^",1),RM=$E(WARD,1,15) S:X'="" RM=RM_"/"_X
 S QT="",PG=0 D HDR
 D ALG^FHCLN I ALG'="" W !!,"Allergies: ",ALG
 K N S P1=1 F K=0:0 S K=$O(^FHPT(FHDFN,"P",K)) Q:K<1  S X=^(K,0),M=$P(X,"^",2) S:M="A" M="BNE" D SP
 I $O(N(""))="" W !!,"No Food Preferences on file",! G A0
 W !!,"Food Preferences Currently on file",!!?23,"Likes",?57,"Dislikes",!
 W ! S (M,MM)="" F  S M=$O(N(M)) Q:M=""  I $D(N(M)) W $P(M,"~",2) D  Q:QT="^"  S MM=M ;P32
 .  S (P1,P2)=0 F  S:P1'="" P1=$O(N(M,"L",P1)) S X1=$S(P1>0:N(M,"L",P1),1:"") S:P2'="" P2=$O(N(M,"D",P2)) S X2=$S(P2>0:N(M,"D",P2),1:"") Q:P1=""&(P2="")  D W0 Q:QT="^"  W:MM'=M ! ;P32
 .  Q
 W ! K L,N,M,M1,M2
 G:QT="^" KIL ;P32
A0 S X(0)=^FHPT(FHDFN,"A",ADM,0),X=$P(X(0),"^",10) G:X="" F1
 D:$Y>(IOSL-3) HDR G:QT="^" KIL W !!,"Isolation/Precaution Type is ",$P($G(^FH(119.4,X,0)),"^",1)
F1 D CUR^FHORD7 D:$Y>(IOSL-6) HDR G:QT="^" KIL W !!,"Current Diet: ",$S(Y'="":Y,1:"No current order")
 I Y'="",FHORD>0 I $D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,1)) S COM=^(1) W:COM'="" !,"Comment: ",COM
 S TYP=$P(X,"^",8) I TYP'="" W !,"Service: ",$S(TYP="T":"Tray",TYP="D":"Dining Room",1:"Cafeteria")
 S DTP=$P(X(0),"^",3) I DTP D DTP^FH W !,"Expires: ",DTP
 S TF=$P(X(0),"^",4) G:TF<1 F2
 S Y=^FHPT(FHDFN,"A",ADM,"TF",TF,0)
 S DTP=$P(Y,"^",1),COM=$P(Y,"^",5),TQU=$P(Y,"^",6),CAL=$P(Y,"^",7)
 D DTP^FH W !!,"Tubefeed Ordered: ",DTP
 F TF2=0:0 S TF2=$O(^FHPT(FHDFN,"A",ADM,"TF",TF,"P",TF2)) Q:TF2<1  S XY=^(TF2,0) D LP
 W !,"Total Quantity: ",TQU," ml",?42,"Total KCAL: ",CAL
 W:COM'="" !,"Comment: ",COM
F2 S NO=$P(X(0),"^",7),Y=$S('NO:"",1:^FHPT(FHDFN,"A",ADM,"SF",NO,0)) D:$Y>(IOSL-3) HDR G:QT="^" KIL
 S L=$P(Y,"^",4) W !!,"Supplemental Feeding: ",$S('L:"No Order",1:$P(^FH(118.1,L,0),"^",1)) G:'NO F3
 S DTP=$P(Y,"^",30) D DTP^FH W ?50,"Reviewed: ",DTP
 S L=4 F K1=1:1:3 S K=0,N(K1)="" F K2=1:1:4 S Z=$P(Y,U,L+1),Q=$P(Y,U,L+2),L=L+2 I Z'="" S:'Q Q=1 S:N(K1)'="" N(K1)=N(K1)_"; " S N(K1)=N(K1)_Q_" "_$P(^FH(118,Z,0),"^",1)
 D:$Y>(IOSL-4) HDR G:QT="^" KIL F K1=1:1:3 I N(K1)'="" W !?5,$P("10am; 2pm; 8pm",";",K1),":",?13,N(K1)
F3 G ^FHORD61
LP S TUN=$P(XY,"^",1),STR=$P(XY,"^",2),QUA=$P(XY,"^",3)
 I QUA["CC" S QUAFI=$P(QUA,"CC",1),QUASE=$P(QUA,"CC",2),QUA=QUAFI_"ML"_QUASE
 W !,"Product: ",$P($G(^FH(118.2,TUN,0)),"^",1),", ",$S(STR=4:"Full",STR=1:"1/4",STR=2:"1/2",1:"3/4")," Str., ",QUA Q
SP S Z=$G(^FH(115.2,+X,0)),L1=$P(Z,"^",1),KK=$P(Z,"^",2),M1="",DAS=$P(X,"^",4)
 I KK="L" S Q=$P(X,"^",3),L1=$S(Q:Q,1:1)_" "_L1
 I M="BNE" S M1="1~All Meals" G SP1
 S Z1=$E(M,1) I Z1'="" S M1=$S(Z1="B":"2~Break",Z1="N":"3~Noon",1:"4~Even")
 S Z1=$E(M,2) I Z1'="" S M1=M1_","_$S(Z1="B":"Break",Z1="N":"Noon",1:"Even")
SP1 S:'$D(N(M1,KK,P1)) N(M1,KK,P1)="" I $L(N(M1,KK,P1))+$L(L1)<255 S N(M1,KK,P1)=N(M1,KK,P1)_$S(N(M1,KK,P1)="":"",1:", ")_L1_$S(DAS="Y":" (D)",1:"")
 E  S:'$D(N(M1,KK,K)) N(M1,KK,K)="" S N(M1,KK,K)=L1_$S(DAS="Y":" (D)",1:"") S P1=K
 Q
W0 I X1'="" W ?12 S X=X1 D W1 S X1=X
 I X2'="" W ?46 S X=X2 D W1 S X2=X
 Q:X1=""&(X2="")  D:$Y'<(IOSL-2) HDR Q:QT="^"  W ! G W0 ;P32
W1 I $L(X)<34 W X S X="" Q
 F KK=35:-1:1 Q:$E(X,KK-1,KK)=", "
 W $E(X,1,KK-2) S X=$E(X,KK+1,999) Q
PAUSE ; Pause For Scroll
 I $E(IOST,1,2)="C-",PG R !!,"Press return to continue  ",YN:DTIME S:'$T!(YN["^") QT="^" Q:QT="^"  I "^"'[YN W !,"Enter a RETURN to Continue." G PAUSE
 Q
HDR ; Print Header
 D PAUSE Q:QT="^"
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !,PID,?16,$P(Y(0),"^",1),?48,SEX," Age ",AGE,?(79-$L(RM)),RM Q
KIL ; Final variable kill
 K %,%H,%I,%T,%ZIS,A1,ADM,AGE,ALG,ALL,BAG,C,CAL,COM,CON,CT,D3,DA,DAS,FHDU,FHDFN,DFN,DOB,DTP,FHOR,FHLD,I,IOP,K,K1,K2,KK,L,L1,LST,MEAL,N,NO,NOW,FHORD,FHWF,FHPV
 K POP,Q,QUA,QT,QTY,RM,SEX,PID,BID,STR,TYP,TF,TF2,TIM,TQU,TUN,WARD,X,X1,X2,XY,Y,YN,Z,Z1 Q
