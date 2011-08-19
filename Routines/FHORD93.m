FHORD93 ; HISC/NCA/RVD - Diet Census Percentage (Cont.) ;1/23/98  16:09
 ;;5.5;DIETETICS;**3**;Jan 28, 2005
 ;RVD patch #3 7/20/05 remove dependency with FHPRO* routines.
 ;
Q1 ; Calculate Census
 S X=D1 D DOW^%DTC S DOW=Y+1 D NOW^%DTC S NOW=% S PG=0
 G:FHAN'="Y" GET
 I MEAL'="A" G Q2
 F MEAL="B","N","E" D Q2
 Q
Q2 S K3=$F("BNE",MEAL)-1,FHX1=$P(FHDA,"^",K3+1) D CEN:FHP1["C",FOR:FHP1["F",LST
 Q 
CEN ;census
 S X=D1_"@"_$S(MEAL="B":"7AM",MEAL="N":"11AM",1:"4PM"),%DT="TX" D ^%DT S TIM=Y
 K D,P F WRD=0:0 S WRD=$O(^FH(119.6,WRD)) Q:WRD<1  S X=^(WRD,0) D
 .I $G(FHSITE),($P(X,U,8)'=FHSITE) Q
 .S FHSER=$P(X,U,5) S:$G(FHSER) SP(FHSER)=""
 .S FHSER=$P(X,U,6) S:$G(FHSER) SP(FHSER)=""
 .I '$G(FHSITE) D WRD^FHORD9 Q
 .I $G(FHSITE),$P(X,U,8)=FHSITE D WRD^FHORD9
 ;
OUT ;process outpatient data
REC S FHTIM=D1-.000001,FHDT299=D1+.99999
 F FHIR=FHTIM:0 S FHIR=$O(^FHPT("RM",FHIR)) Q:(FHIR'>0)!(FHIR>(FHDT299))  F FHIDFN=0:0 S FHIDFN=$O(^FHPT("RM",FHIR,FHIDFN)) Q:FHIDFN'>0  D
 .F FHIEN=0:0 S FHIEN=$O(^FHPT("RM",FHIR,FHIDFN,FHIEN)) Q:FHIEN'>0  D
 ..S FHREDAT=$G(^FHPT(FHIDFN,"OP",FHIEN,0))
 ..Q:$P(FHREDAT,U,4)'=MEAL
 ..Q:$P(FHREDAT,U,15)="C"
 ..S FHLOC=$P(FHREDAT,U,3) Q:'$G(FHLOC)
 ..I $G(FHSITE),$P($G(^FH(119.6,FHLOC,0)),U,8)'=FHSITE Q
 ..S FHRDIET=$P(FHREDAT,U,2) Q:'$G(FHRDIET)
 ..S FHPDIET=$P($G(^FH(111,FHRDIET,0)),U,5)
 ..I $G(FHLOC) D
 ...S FHSER=$P($G(^FH(119.6,FHLOC,0)),U,5) S:$G(FHSER) SP(FHSER)=""
 ...I '$G(FHSER) S FHSER=$P($G(^FH(119.6,FHLOC,0)),U,6) S:$G(FHSER) SP(FHSER)=""
 ...I '$G(FHSER) S FHSER=$O(^FH(119.72,0)) S:$G(FHSER) SP(FHSER)=""
 ..Q:'$G(FHSER)
 ..I $D(^FH(119.72,FHSER,0)),$P(^FH(119.72,FHSER,0),U,3)'=FHP Q
 ..S FHDIET=$P($G(^FH(119.9,1,0)),U,2)
 ..S:'$D(P(FHPDIET,FHSER)) P(FHPDIET,FHSER)=0
 ..S P(FHPDIET,FHSER)=P(FHPDIET,FHSER)+1
 ..S:'$D(P(.6,FHSER)) P(.6,FHSER)=0 S P(.6,FHSER)=P(.6,FHSER)+1
 ..;if tubefeeding and not cancelled, also count the TF data.
 ..I $D(^FHPT(FHIDFN,"OP",FHIEN,"TF")) D
 ...Q:$P(^FHPT(FHIDFN,"OP",FHIEN,3),U,5)="C"
 ...I '$D(P(.7,FHSER)) S P(.7,FHSER)=1
 ...E  S P(.7,FHSER)=P(.7,FHSER)+1
 ...S:'$D(P(.6,FHSER)) P(.6,FHSER)=0 S P(.6,FHSER)=P(.6,FHSER)+1
 ;
 S FHDT=D1+.999999
 D GETSM^FHOMRBLD(FHTIM,FHSITE,"","")
 D SPEC^FHORD9
 D GETGM^FHOMRBL1(FHTIM,FHSITE,"","")
 D GUEST^FHORD9
 ;
COMB ;
 K D,NP,T F LP=0:0 S LP=$O(P(.5,LP)) Q:LP<1  S:'$D(NP(.5,LP)) NP(.5,LP)=0 S NP(.5,LP)=NP(.5,LP)+P(.5,LP) S:'$D(D(LP)) D(LP)=0 S D(LP)=D(LP)+P(.5,LP)
 K P(.5) F LP=0:0 S LP=$O(P(.7,LP)) Q:LP<1  S:'$D(NP(.7,LP)) NP(.7,LP)=0 S NP(.7,LP)=NP(.7,LP)+P(.7,LP) S:'$D(D(LP)) D(LP)=0 S D(LP)=D(LP)+P(.7,LP)
 K P(.7) F LL=0:0 S LL=$O(P(.6,LL)) Q:LL<1  S:'$D(NP(.6,LL)) NP(.6,LL)=0 S NP(.6,LL)=NP(.6,LL)+P(.6,LL)
 K P(.6) F LL=0:0 S LL=$O(P(.8,LL)) Q:LL<1  S:'$D(NP(.8,LL)) NP(.8,LL)=0 S NP(.8,LL)=NP(.8,LL)+P(.8,LL) S:'$D(D(LL)) D(LL)=0 S D(LL)=D(LL)+P(.8,LL)
 K P(.8) F LL=0:0 S LL=$O(P(LL)) Q:LL<1  F P0=0:0 S P0=$O(P(LL,P0)) Q:P0<1  S:'$D(T(P0)) T(P0)=0 S T(P0)=T(P0)+P(LL,P0)
 F LP=0:0 S LP=$O(NP(.6,LP)) Q:LP<1  S:$D(T(LP)) NP(.6,LP)=NP(.6,LP)-T(LP)-$G(D(LP)) S:'$D(D(LP)) D(LP)=0 S D(LP)=D(LP)+NP(.6,LP)
 F P0=0:0 S P0=$O(^FH(119.72,P0)) Q:P0<1  I $P(^(P0,0),"^",3)=FHP I $D(^FH(119.72,P0,"B")) D D0
 K ^TMP($J) F LL=0:0 S LL=$O(P(LL)) Q:LL<1  S P(LL,0)=0 F P0=0:0 S P0=$O(P(LL,P0)) Q:P0<1  S ^TMP($J,P0,LL)=P(LL,P0) S:'$D(D(P0)) D(P0)="" S D(P0)=D(P0)+P(LL,P0),P(LL,0)=P(LL,0)+P(LL,P0)
 F P0=0:0 S P0=$O(D(P0)) Q:P0<1  S ^TMP($J,P0)=D(P0)
 F LL=0:0 S LL=$O(P(LL)) Q:LL<1  I $G(P(LL,0)) S ^TMP($J,0,LL)=P(LL,0)
 K P,D Q
D0 ;
 I '$D(SP(P0)) Q
 I $G(^FH(119.72,P0,"I"))="Y" Q
 F LL=0:0 S LL=$O(^FH(119.72,P0,"B",LL)) Q:LL<1  S Y=$P(^(LL,0),"^",3*DOW-2+K3) I Y>0 S:'$D(P(LL,P0)) P(LL,P0)=0 S P(LL,P0)=P(LL,P0)+Y
 Q
 ;
FOR ;FORCAST
 K ^TMP($J) F P0=0:0 S P0=$O(M2(P0)) Q:P0<1  S ^TMP($J,P0)=M2(P0)
 K D F P0=0:0 S P0=$O(M2(P0)) Q:P0<1  S S1=M2(P0) D PER S ^TMP($J,P0)=S0
 F P0=0:0 S P0=$O(^TMP($J,P0)) Q:P0<1  I $D(^FH(119.72,P0,"B")) D F1
 F LL=0:0 S LL=$O(D(LL)) Q:LL<1  S ^TMP($J,0,LL)=D(LL)
 K D Q
F1 F LL=0:0 S LL=$O(^FH(119.72,P0,"B",LL)) Q:LL<1  S Y=$P(^(LL,0),"^",3*DOW-2+K3) I Y>0 S D(LL)=$G(D(LL))+Y,^TMP($J,P0)=^TMP($J,P0)+Y,^TMP($J,P0,LL)=$G(^TMP($J,P0,LL))+Y
 Q
PER S S0=0 F K=0:0 S K=$O(^FH(119.72,P0,"A",K)) Q:K<1  S Z=$P($G(^(K,0)),"^",DOW+1),Z=$J(Z*S1/100,0,0) I Z S ^TMP($J,P0,K)=Z,S0=S0+Z,D(K)=$G(D(K))+Z
 Q
 ;
GET F WRD=0:0 S WRD=$O(^FH(119.6,WRD)) Q:WRD<1  S X=^(WRD,0),TIM=D1 I $P(X,U,8)=FHSITE D WRD^FHORD9
 ;get outpatient data
 S FHTIM=D1-.000001
 F FHIR=FHTIM:0 S FHIR=$O(^FHPT("RM",FHIR)) Q:(FHIR'>0)!(FHIR>(FHTIM+1))  F FHIDFN=0:0 S FHIDFN=$O(^FHPT("RM",FHIR,FHIDFN)) Q:FHIDFN'>0  D
 .F FHIEN=0:0 S FHIEN=$O(^FHPT("RM",FHIR,FHIDFN,FHIEN)) Q:FHIEN'>0  D
 ..S FHREDAT=$G(^FHPT(FHIDFN,"OP",FHIEN,0))
 ..S FHLOC=$P(FHREDAT,U,3)
 ..Q:$P(FHREDAT,U,5)="C"    ;quit if cancelled
 ..Q:$P($G(^FH(119.6,FHLOC,0)),U,8)'=FHSITE
 ..S FHRDIET=$P(FHREDAT,U,2),FHPDIET=$P($G(^FH(111,FHRDIET,0)),U,5)
 ..S:$G(FHLOC) FHSER=$P($G(^FH(119.6,FHLOC,0)),U,5)
 ..S:'$G(FHSER) FHSER=$P($G(^FH(119.6,FHLOC,0)),U,6)
 ..S:'$G(FHSER) FHSER=$O(^FH(119.72,0))
 ..I $D(^FH(119.72,FHSER,0)),$P(^FH(119.72,FHSER,0),U,3)'=FHP Q
 ..S FHDIET=$P($G(^FH(119.9,1,0)),U,2)
 ..S:'$D(P(FHPDIET,FHSER)) P(FHPDIET,FHSER)=0
 ..S P(FHPDIET,FHSER)=P(FHPDIET,FHSER)+1
 ..S:'$D(P(.6,FHSER)) P(.6,FHSER)=0 S P(.6,FHSER)=P(.6,FHSER)+1
 ..;if tubefeeding and not cancelled, count the TF data.
 ..I $D(^FHPT(FHIDFN,"OP",FHIEN,"TF")) D
 ...Q:$P(^FHPT(FHIDFN,"OP",FHIEN,3),U,5)="C"
 ...I '$D(P(.7,FHSER)) S P(.7,FHSER)=1
 ...E  S P(.7,FHSER)=P(.7,FHSER)+1
 ...S:'$D(P(.6,FHSER)) P(.6,FHSER)=0 S P(.6,FHSER)=P(.6,FHSER)+1
 S FHPLNM=$P($G(^FH(119.73,FHSITE,0)),U,1)
 S FHDT=D1+.999999
 D GETSM^FHOMRBLD(FHTIM,FHSITE,"","")
 D SPEC^FHORD9
 D GETGM^FHOMRBL1(FHTIM,FHSITE,"","")
 D GUEST^FHORD9
 ;
 K D,NP F LP=0:0 S LP=$O(P(.5,LP)) Q:LP<1  S:'$D(NP(.5,LP)) NP(.5,LP)=0 S NP(.5,LP)=NP(.5,LP)+P(.5,LP) S:'$D(D(LP)) D(LP)=0 S D(LP)=D(LP)+P(.5,LP)
 K P(.5) F LP=0:0 S LP=$O(P(.7,LP)) Q:LP<1  S:'$D(NP(.7,LP)) NP(.7,LP)=0 S NP(.7,LP)=NP(.7,LP)+P(.7,LP) S:'$D(D(LP)) D(LP)=0 S D(LP)=D(LP)+P(.7,LP)
 K P(.7) F LP=0:0 S LP=$O(P(.6,LP)) Q:LP<1  S:'$D(NP(.6,LP)) NP(.6,LP)=0 S NP(.6,LP)=NP(.6,LP)+P(.6,LP)
 K P(.6) F LP=0:0 S LP=$O(P(.8,LP)) Q:LP<1  S:'$D(NP(.8,LP)) NP(.8,LP)=0 S NP(.8,LP)=NP(.8,LP)+P(.8,LP) S:'$D(D(LP)) D(LP)=0 S D(LP)=D(LP)+P(.8,LP)
 K P(.8),^TMP($J) F LL=0:0 S LL=$O(P(LL)) Q:LL<1  S P(LL,0)=0 F P0=0:0 S P0=$O(P(LL,P0)) Q:P0<1  S ^TMP($J,P0,LL)=P(LL,P0) S:'$D(D(P0)) D(P0)="" S D(P0)=D(P0)+P(LL,P0),P(LL,0)=P(LL,0)+P(LL,P0)
 F LP=0:0 S LP=$O(NP(.6,LP)) Q:LP<1  S:$D(D(LP)) NP(.6,LP)=NP(.6,LP)-D(LP) S:'$D(D(LP)) D(LP)=0 S D(LP)=D(LP)+NP(.6,LP)
 F P0=0:0 S P0=$O(D(P0)) Q:P0<1  S ^TMP($J,P0)=D(P0)
 F LL=0:0 S LL=$O(P(LL)) Q:LL<1  I $G(P(LL,0)) S ^TMP($J,0,LL)=P(LL,0)
 K P,D
 ;
LST K S S L1=30
 F P0=0:0 S P0=$O(^TMP($J,P0)) Q:P0=""  S X=^FH(119.72,P0,0),N1=$P(X,"^",1),N2=$P(X,"^",2),N3=$P(X,"^",4) S:N3="" N3=$E(N1,1,6) S S(N3,P0)=$J(N3,8)_"^"_N2,L1=L1+10
 S:L1<80 L1=80 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 S Z=$S(FHP1["F":"F O R E C A S T E D",1:"A C T U A L")_"   D I E T   C E N S U S"
 S DTP=NOW D DTP^FH W !,DTP,?(L1-$L(Z)\2),Z,?(L1-7),"Page ",PG,!?(L1-21\2),"P E R C E N T A G E S"
 W !,$G(FHSITENM)
 S Z=$P(^FH(119.71,FHP,0),"^",1),DTP=D1 D DTP^FH
 S X=D1\1 D DOW^%DTC S DOW=Y+1,X=$P("Sun^Mon^Tues^Wednes^Thurs^Fri^Satur","^",DOW)_"day  "_DTP I FHAN="Y" S X=X_"  "_$P("BREAKFAST^NOON^EVENING","^",K3)
 S DTP=D1\1 D DTP^FH W !!?(L1-$L(Z)\2),Z,!!?(L1-$L(X)\2),X
 W !!?(L1-31\2),"P R O D U C T I O N   D I E T S",!!?29
 S X="" F  S X=$O(S(X)) Q:X=""  F K=0:0 S K=$O(S(X,K)) Q:K=""  W $P(S(X,K),"^",1)_" %"
 W !
 F P1=0:0 S P1=$O(^FH(116.2,"AP",P1)) Q:P1<1  F K=0:0 S K=$O(^FH(116.2,"AP",P1,K)) Q:K<1  I $D(^TMP($J,0,K)) D PRO
 I FHP1'["F" W !?3,"N P O",?31 S K=.5 D P1 K NP(.5)
 I FHP1'["F" W !?3,"P A S S",?31 S K=.8 D P1 K NP(.8)
 I FHP1'["F" W !?3,"TF Only",?31 S K=.7 D P1 K NP(.7)
 I FHP1'["F" W !?3,"No Order",?31 S K=.6 D P1 K NP(.6)
 W !
 Q
PRO W !,$P($G(^FH(116.2,K,0)),"^",1),?31
P1 F  S X=$O(S(X)) Q:X=""  F K1=0:0 S K1=$O(S(X,K1)) Q:K1=""  S Z=$S(K>.9:$G(^TMP($J,K1,K)),1:$G(NP(K,K1))),Z=$S($G(^TMP($J,K1)):Z/$G(^TMP($J,K1))*100,1:"") W $J(Z,8,1),"  "
 Q
