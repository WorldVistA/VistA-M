FHORD10 ; HISC/REL/NCA - Diet Activity Report ;5/17/93  09:57 
 ;;5.5;DIETETICS;;Jan 28, 2005
 S FHP=$O(^FH(119.73,0)) I FHP'<1,$O(^FH(119.73,FHP))<1 G R1
R0 R !!,"Select COMMUNICATION OFFICE: ",X:DTIME G:'$T!("^"[X) KIL
 K DIC S DIC="^FH(119.73,",DIC(0)="EMQ" D ^DIC G:Y<1 R0 S FHP=+Y
R1 R !!,"Do you want labels? N// ",X:DTIME G:'$T!(X["^") KIL S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Enter YES or NO" G R1
 S LAB=X?1"Y".E,TIM=$P($G(^FH(119.73,FHP,0)),"^",2) I 'TIM D NOW^%DTC S TIM=%
 S DTP=TIM D DTP^FH
R2 R !!,"Do you wish to update ward/rooms? N // ",X:DTIME G:'$T!(X["^") KIL S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G R2
 S UPD=X?1"Y".E
R3 W !!,"Changes since Date/Time: ",DTP," // " R X:DTIME G:'$T!(X["^") KIL I X'="" S %DT="EXTS" D ^%DT K %DT G:Y<1 R3 S TIM=Y
 W ! K IOP,%ZIS S %ZIS("A")="Select "_$S(LAB:"LABEL",1:"LIST")_" Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHORD10",FHLST="TIM^LAB^FHP^UPD" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print Diet Activity Report
 K ^TMP($J) D NOW^%DTC S NOW=%,DTP=TIM,TIM=TIM-.0001 D DTP^FH S H1=DTP_" - " S DTP=NOW D DTP^FH S H1=H1_DTP D ^FHDEV
 I LAB S LAB=$P($G(^FH(119.9,1,"D",IOS,0)),"^",2) S:'LAB LAB=1
 F W1=0:0 S W1=$O(^FHPT("AW",W1)) Q:W1'>0  D WRD I FHP=D2 F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",W1,FHDFN)) Q:FHDFN=""  S ADM=$G(^FHPT("AW",W1,FHDFN)) D:ADM Q3
 G ^FHORD11
WRD S P0=$G(^FH(119.6,W1,0)),WRDN=$P(P0,"^",1),D2=$P(P0,"^",8),P0=$P(P0,"^",4) S:P0<1 P0=99 Q
Q3 Q:'$D(^FHPT(FHDFN,"A",ADM,0))
Q4 S X0=^FHPT(FHDFN,"A",ADM,0)
 S FHORD=$P(X0,"^",2),X1=$P(X0,"^",3) Q:'FHORD
 S E1="" F NX=TIM:0 S NX=$O(^FHPT(FHDFN,"A",ADM,"AC",NX)) Q:NX<1!(NX>NOW)  S E1=NX
 S OLW=$P(X0,"^",11),OLR=$P(X0,"^",12) I W1'=OLW S E1=1 I UPD S $P(^FHPT(FHDFN,"A",ADM,0),"^",11)=W1
 D PATNAME^FHOMUTL I DFN="" Q
 S R1=$G(^DPT(DFN,.101)) I R1'=OLR S E1=1 I UPD S $P(^FHPT(FHDFN,"A",ADM,0),"^",12)=R1
 S OLW=$S(OLW=W1:" ",'OLW:"",1:$P($G(^FH(119.6,OLW,0)),"^",1)),OLR=$S(R1=OLR:" ",1:OLR)
 S:E1 ^TMP($J,D2,$S(P0<10:"0"_P0,1:P0)_$S(R1'="":R1,1:"   "),FHDFN)=WRDN_"^"_R1_"^"_ADM_"^"_FHORD_"^"_$P(X0,"^",7)_"^"_$P(X0,"^",10)_"^"_OLW_"^"_OLR Q
KIL K %,%H,%I,%DT,A1,ADM,ALG,CADM,COM,D2,D3,DA,FHDFN,DFN,DIC,DTP,E1,FHOR,FHP,H1,IS,K,L1,L2,LAB,N1,NOW,NX,OLW,OLR,FHORD,FHDU,FHIO,FHLD
 K L,SF,SO,SVC,P0,PG,POP,R1,S1,S2,TC,TIM,UPD,W1,WRDN,X,X0,X1,X2,Y,Y0,^TMP($J) Q
