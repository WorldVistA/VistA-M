FHORD2 ; HISC/REL/NCA - Review Diet Orders ;11/7/92  09:57 
 ;;5.5;DIETETICS;**1**;Jan 28, 2005
F0 S ALL=0 D ^FHDPA G KIL:'DFN,KIL:'FHDFN,F0:'$D(^DGPM(ADM,0))
 S DTP=$P(^DGPM(ADM,0),"^",1) D DTP^FH
F01 W !!,"List Orders from Date/Time: "_DTP_" // " R X:DTIME G:'$T!(X["^") KIL S:X="" Y=0 I X'="" S %DT="EXTS" D ^%DT G:Y<1 F01
 S D4=Y D CUR^FHORD7 W !!,"Current Diet: ",$S(Y'="":Y,1:"No current order")
 I Y'="",FHORD>0 I $D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,1)) W !,"Comment: ",^(1)
 S X1=^FHPT(FHDFN,"A",ADM,0),DTP=$P(X1,"^",3) I DTP D DTP^FH W !,"Expires: ",DTP
 S TF=$P(X1,"^",4) G:TF<1 F1
 S Y=^FHPT(FHDFN,"A",ADM,"TF",TF,0)
 S DTP=$P(Y,"^",1),COM=$P(Y,"^",5),TQU=$P(Y,"^",6),CAL=$P(Y,"^",7)
 D DTP^FH W !!,"Tubefeed Ordered: ",DTP
 F TF2=0:0 S TF2=$O(^FHPT(FHDFN,"A",ADM,"TF",TF,"P",TF2)) Q:TF2<1  S XY=^(TF2,0) D LP
 W !,"Total Quantity: ",TQU," ml",?42,"Total KCAL: ",CAL
 W:COM'="" !,"Comment: ",COM
F1 S CT=0 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"OO",K)) Q:K<1  S X=^(K,0) I $P(X,"^",2)'<D4,$P(X,"^",5)="S" D L1
 S N1=0 F FHORD=0:0 S FHORD=$O(^FHPT(FHDFN,"A",ADM,"DI",FHORD)) Q:FHORD<1  S X=^(FHORD,0) D LST
 I 'N1 W !!,"No Diet Orders Entered",! G F0
 D TLN G F0
KIL K %,%DT,A1,ADM,ALL,C,CAL,COM,CT,D1,D2,D3,D4,DA,DTP,FHDFN,DFN,FHDU,FHLD,FHOR,I,K,KK,N1,NOW,FHORD,FHWF,FHPV,POP,TYP,TF,TF2,TQU,TUN,STR,QUA,WARD,X,X1,X2,XY,Y Q
LP S TUN=$P(XY,"^",1),STR=$P(XY,"^",2),QUA=$P(XY,"^",3)
 I QUA["CC" S QUAFI=$P(QUA,"CC",1),QUASE=$P(QUA,"CC",2),QUA=QUAFI_"ML"_QUASE
 W !,"Product: ",$P($G(^FH(118.2,TUN,0)),"^",1),", ",$S(STR=4:"Full",STR=1:"1/4",STR=2:"1/2",1:"3/4")," Str., ",QUA Q
L1 I 'CT W !!,"Saved Additional Orders:",! S CT=1
 S DTP=$P(X,"^",2) D DTP^FH W !,DTP,?20,$P(X,"^",3) Q
LST S COM=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,1)) Q:$P(X,"^",9)<D4
 I 'N1 W !!,"    Effective         Expires         Type  Order",!
 S FHOR=$P(X,"^",2,6),FHLD=$P(X,"^",7),D1=$P(X,"^",9),D2=$P(X,"^",10),TYP=$P(X,"^",8),D3=$P(X,"^",12),N1=N1+1
 S DTP=D1 D DTP^FH W !,DTP I D2 S DTP=D2 D DTP^FH W ?20,DTP
 W ?40,TYP,?44 D ORD I $L(Y)<36 W Y
 E  W $P(Y,", ",1,3) W:$P(Y,", ",4)'="" ",",!?44,$P(Y,", ",4,5)
 W:COM'="" !?44,COM Q
ORD S Y="" I FHLD'="" S FHDU=";"_$P(^DD(115.02,6,0),"^",3),%=$F(FHDU,";"_FHLD_":") Q:%<1  S Y=$P($E(FHDU,%,999),";",1) Q
 F A1=1:1:5 S D3=$P(FHOR,"^",A1) I D3 S:Y'="" Y=Y_", " S Y=Y_$P(^FH(111,D3,0),"^",7)
 Q
TLN W !!?24,"----- Diet Orders Time Line -----",!,"    Effective     Type  Order",!
 F KK=0:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1  S FHORD=$P(^(KK,0),"^",2) D T1
 Q
T1 S X=^FHPT(FHDFN,"A",ADM,"DI",FHORD,0) Q:$P(X,"^",9)<D4
 S FHOR=$P(X,"^",2,6),FHLD=$P(X,"^",7),TYP=$P(X,"^",8)
 S DTP=KK D DTP^FH W !,DTP,?20,TYP,?24 D ORD I $L(Y)<56 W Y Q
 W $P(Y,", ",1,4),",",!?24,$P(Y,", ",5) Q
