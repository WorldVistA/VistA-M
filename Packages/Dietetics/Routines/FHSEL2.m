FHSEL2 ; HISC/REL/NCA/FAI - Tabulate Patient Preferences ;10/29/04  7:19
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
 ;patch #5 - screen for cancelled guest meals.
 S X="T",%DT="X" D ^%DT S DT=+Y
 S FHP=$O(^FH(119.72,0)) I FHP'<1,$O(^FH(119.72,FHP))<1 S FHP=0 G D1
D0 R !!,"Select SERVICE POINT (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S FHP=0
 E  K DIC S DIC="^FH(119.72,",DIC(0)="EMQ" D ^DIC G:Y<1 D0 S FHP=+Y
D1 R !!,"Tabulate By Menu Specific? N// ",D3:DTIME G:'$T!(D3="^") KIL
 S:D3="" D3="N" S X=D3 D TR^FH S D3=X I $P("YES",D3,1)'="",$P("NO",D3,1)'="" W *7,"  Answer YES or NO" G D1
 S D3=$E(D3,1) S:D3="Y" D3=D3="Y" I 'D3 S (D1,FHCY,FHDA)="" G R1
F1 S %DT("A")="Select Date: ",%DT="AEX" W ! D ^%DT G KIL:"^"[X!$D(DTOUT),F1:Y<1 S (X1,D1)=+Y
 I D1<DT W *7,"  [ Must NOT be before TODAY ]" G F1
 D E1^FHPRC1 I FHCY<1 W *7,!!,"No MENU CYCLE Defined for that Date!" G F1
 I '$D(^FH(116,FHCY,"DA",FHDA,0)) W *7,!!,"MENU CYCLE DAY Not Defined for that Date!" G F1
R1 R !!,"Select MEAL (B,N,E or ALL): ",MEAL:DTIME G:'$T!("^"[MEAL) KIL S X=MEAL D TR^FH S MEAL=X S:$P("ALL",MEAL,1)="" MEAL="A"
 I "BNEA"'[MEAL!(MEAL'?1U) W *7,!,"Select B for Breakfast, N for Noon, E for Evening or ALL for all meals" G R1
R2 R !!,"Break Down By Production Diets? N// ",SRT:DTIME G:'$T!(SRT="^") KIL S:SRT="" SRT="N" S X=SRT D TR^FH S SRT=X I $P("YES",SRT,1)'="",$P("NO",SRT,1)'="" W *7,"  Answer YES or NO" G R2
 S SRT=$E(SRT,1),SRT=SRT="Y"
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHSEL2",FHLST="D1^D3^FHP^FHCY^FHDA^MEAL^SRT" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Printing Tabulated Patient Preference
 S FHMLSAV=MEAL
 D NOW^%DTC S NOW=%,PG=0
 I MEAL'="A" G Q2
 F MEAL="B","N","E" D Q2
 Q
Q2 K ^TMP($J),D G:'D3 Q3
 S FHX1=^FH(116,FHCY,"DA",FHDA,0)
 I $D(^FH(116.3,D1,0)) S X=^(0) F LL=2:1:4 I $P(X,"^",LL) S $P(FHX1,"^",LL)=$P(X,"^",LL)
 S FHX1=$P(FHX1,"^",$F("BNE",MEAL)) I 'FHX1 Q
Q3 S:D1="" D1=NOW\1
 S TIM=D1\1_$S(MEAL="B":".07",MEAL="N":".11",1:".17")
 F WRD=0:0 S WRD=$O(^FH(119.6,WRD)) Q:WRD<1  S X=^(WRD,0) D D2 I D2'="" S WRDN=$P(X,"^",1) D W2
 ;process outpatient
 ;next recurring
 S FHD1=D1-1
 F FHK1=FHD1:0 S FHK1=$O(^FHPT("RM",FHK1)) Q:(FHK1'>0)!(FHK1>D1)  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("RM",FHK1,FHDFN)) Q:FHDFN'>0  D
 ..F FHKD=0:0 S FHKD=$O(^FHPT("RM",FHK1,FHDFN,FHKD)) Q:FHKD'>0  D
 ...S FHKDAT=^FHPT(FHDFN,"OP",FHKD,0)
 ...S (W1,FHW1)=$P(FHKDAT,U,3)
 ...S FHDIET=$P(FHKDAT,U,2),FHMEAL=$P(FHKDAT,U,4),FHSTAT=$P(FHKDAT,U,15)
 ...S:FHDIET="" FHDIET=$P(FHKDAT,U,7) S:FHDIET="" FHDIET=$P(FHKDAT,U,8)
 ...S:FHDIET="" FHDIET=$P(FHKDAT,U,9) S:FHDIET="" FHDIET=$P(FHKDAT,U,10)
 ...S:FHDIET="" FHDIET=$P(FHKDAT,U,11)
 ...I (FHMLSAV'="A"),(FHMEAL'=FHMLSAV) Q
 ...I FHSTAT="C" Q
 ...Q:'$D(^FH(119.6,FHW1,0))
 ...D W44
 ;next guest
 F FHKD=D1:0 S FHKD=$O(^FHPT("GM",FHKD)) Q:(FHKD'>0)!(FHKD>(D1+1))  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("GM",FHKD,FHDFN)) Q:FHDFN'>0  D
 ..S FHKDAT=^FHPT(FHDFN,"GM",FHKD,0)
 ..S (W1,FHW1)=$P(FHKDAT,U,5)
 ..S FHDIET=$P(FHKDAT,U,6),FHMEAL=$P(FHKDAT,U,3)
 ..I $P(FHKDAT,U,9)="C" Q
 ..I (FHMLSAV'="A"),(FHMEAL'=FHMLSAV) Q
 ..Q:'$D(^FH(119.6,FHW1,0))
 ..D W44
 ;next SPECIAL
 F FHKD=D1:0 S FHKD=$O(^FHPT("SM",FHKD)) Q:(FHKD'>0)!(FHKD>(D1+1))  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("SM",FHKD,FHDFN)) Q:FHDFN'>0  D
 ..S FHKDAT=^FHPT(FHDFN,"SM",FHKD,0)
 ..S (W1,FHW1)=$P(FHKDAT,U,3)
 ..S FHDIET=$P(FHKDAT,U,4),FHMEAL=$P(FHKDAT,U,9),FHSTAT=$P(FHKDAT,U,2)
 ..I (FHMLSAV'="A"),(FHMEAL'=FHMLSAV) Q
 ..I (FHSTAT="C")!(FHSTAT="D") Q
 ..Q:'$D(^FH(119.6,FHW1,0))
 ..D W44
 ;print report
 G ^FHSEL3
KIL K ^TMP($J) G KILL^XUSCLEAN
W2 I $O(^FHPT("AW",WRD,0))<1 Q
 F DFN=0:0 S DFN=$O(^FHPT("AW",WRD,DFN)) Q:DFN<1  S ADM=^(DFN) I ADM>0 D W3
 Q
W3 S K2=0 Q:'$D(^FHPT(DFN,"A",ADM,0))  S X0=^(0)
 S FHORD=$P(X0,"^",2),X1=$P(X0,"^",3) I FHORD<1 S A1=$O(^FHPT(DFN,"A",ADM,"AC",0)) Q:A1=""!(A1>NOW)  D U1 Q:'FHORD  G W4
 I X1>1,X1'>TIM D U1 Q:'FHORD
 I '$D(^FHPT(DFN,"A",ADM,"DI",FHORD,0)) D U1 Q:'FHORD
W4 S X=$G(^FHPT(DFN,"A",ADM,"DI",FHORD,0))
 S TC=$P(X,"^",8) Q:TC=""  S PD=$P(X,"^",13) Q:PD=""  S:TC="D" TC="T" Q:'$D(S(TC))  S:D2[TC K2=1 S:K2 SP=S(TC)
 S PD=$S('PD:"",$D(^FH(116.2,+PD,0)):$P(^(0),"^",2),1:"") Q:PD=""
 I K2 F K=0:0 S K=$O(^FHPT(DFN,"P",K)) Q:K<1  S Z=^(K,0) D
 .S FHMLZ2=$P(Z,U,2)
 .I FHMLZ2'[MEAL Q
 .S QTY=$P(Z,"^",3),Z=+Z
 .Q:'$G(Z)
 .S:'$D(^TMP($J,"P",Z,PD,SP)) ^TMP($J,"P",Z,PD,SP)=0 S ^(SP)=^(SP)+$S(QTY:QTY,1:1)
 Q
 ;sets tmp global for outpatient data.
W44 S X=^FH(119.6,FHW1,0)
 S (PD,TC)=""
 S TC=$P(X,"^",5) S:TC="" TC=$P(X,U,6) Q:TC=""
 I FHP,TC'=FHP Q
 I $D(^FH(119.72,TC,0)) S SP=TC,TC=$P(^FH(119.72,TC,0),U,2)
 S:$D(^FH(111,FHDIET,0)) PD=$P(^FH(111,FHDIET,0),U,5) Q:PD=""
 S PD=$S('PD:"",$D(^FH(116.2,+PD,0)):$P(^(0),"^",2),1:"") Q:PD=""
 F K=0:0 S K=$O(^FHPT(FHDFN,"P",K)) Q:K<1  S Z=^(K,0) D
 .S FHMLZ2=$P(Z,U,2)
 .I FHMLZ2'[MEAL Q
 .S QTY=$P(Z,"^",3),Z=+Z
 .Q:'$G(Z)
 .S:'$D(^TMP($J,"P",Z,PD,SP)) ^TMP($J,"P",Z,PD,SP)=0 S ^(SP)=^(SP)+$S(QTY:QTY,1:1)
 Q
D2 K S S D2=""
 F L=5,6 S XX=$P(X,"^",L) I XX=FHP!('FHP) S:XX S($E("TC",L-4))=XX,D(XX)="",D2=D2_$E("TC",L-4)
 Q
U1 S (A1,FHORD)=0 F K=0:0 S K=$O(^FHPT(DFN,"A",ADM,"AC",K)) Q:K<1!(K>TIM)  S A1=K
 Q:'A1  S X1=$P(^FHPT(DFN,"A",ADM,"AC",A1,0),"^",2) G U2:X1<1,U2:'$D(^FHPT(DFN,"A",ADM,"DI",X1,0)) S FHORD=X1 Q
U2 S X1="",A1=0
U3 S A1=$O(^FHPT(DFN,"A",ADM,"AC",A1)) G:A1="" U1 S X2=$P(^(A1,0),"^",2)
 I X2<1 K ^FHPT(DFN,"A",ADM,"AC",A1) G U3
 I '$D(^FHPT(DFN,"A",ADM,"DI",X2,0)) K ^FHPT(DFN,"A",ADM,"AC",A1) G U3
 G U3
