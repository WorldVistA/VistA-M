FHORX1A ; HISC/REL/NCA/RVD - Diet Activity Report (cont) ;3/17/95  10:06
 ;;5.5;DIETETICS;**1,5,8**;Jan 28, 2005;Build 28
 ;
 ;process inpatient data.
 S PG=0 S FHPIO="** INPATIENT **" D HDR
 S P0="",NN=0 F  S P0=$O(^TMP($J,"I",P0)) Q:P0=""  D LST
 ;
 ;process outpatient data.
 S FHPIO="** OUTPATIENT **" D HDR
 S (FHUSERNM,P0)="",(FHNMSV,NN)=0 F  S P0=$O(^TMP($J,"O",P0)) Q:P0=""  S (FHBRK,FHNON,FHEVE)=0 D LST1
 S:$G(FHP) $P(^FH(119.73,FHP,0),"^",2)=NOW
 I '$G(FHP) F FHII=0:0 S FHII=$O(^FH(119.73,FHII)) Q:FHII'>0  S $P(^FH(119.73,FHII,0),"^",2)=NOW
 Q
 ;
LST K PP S NP=0 F DA=0:0 S DA=$O(^TMP($J,"I",P0,DA)) Q:DA<1  S Z=^(DA) D L1
 D L2 Q
 ;
LST1 K PP S NP=0 F DA=0:0 S DA=$O(^TMP($J,"O",P0,DA)) Q:DA'>0  D T1
 Q
 ;
L1 ; Process event
 S ADM=$P(Z,"^",1),TYP=$P(Z,"^",2),ACT=$P(Z,"^",3),FHORD=$P(Z,"^",4),TXT=$P(Z,"^",5),CLK=$P(Z,"^",6)
 I 'FHORD S NN=NN+1,FHORD=NN
 I "DIT"[TYP D
 .I TYP="D",FHORD=1 S NP=1
 .I $D(PP(TYP,ADM_"~"_FHORD)),ACT="C" K PP(TYP,ADM_"~"_FHORD) Q
 .K PP(TYP) S PP(TYP,ADM_"~"_FHORD)=ACT_"^"_TXT_"^"_CLK Q
 I "OPSF"[TYP D
 .I $D(PP(TYP,ADM_"~"_FHORD)),ACT="C" K PP(TYP,ADM_"~"_FHORD) Q
 .S PP(TYP,ADM_"~"_FHORD)=ACT_"^"_TXT_"^"_CLK Q
 I "LM"[TYP S PP(TYP,ADM_"~"_FHORD)=ACT_"^"_TXT_"^"_CLK
 Q
 ;
L2 S W1=$P(P0,"~",2),R1=$P(P0,"~",4),FHDFN=$P(P0,"~",5)
 D PATNAME^FHOMUTL Q:'$G(DFN)
 S Y0=$G(^DPT(DFN,0))
 S N1=$P(Y0,"^",1)
 ;D PID^FHDPA
 S TC=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",5),SF=$P($G(^(0)),"^",7),SO=$D(^FHPT("ASP",FHDFN,ADM))
 D:$Y>(IOSL-6) HDR W !!,$E(W1_" "_R1,1,20),?22,N1,?50,BID,?63,$S(SF:"SF",1:""),?66,$S(SO:"SO",1:""),?73,TC
 D ALG^FHCLN W !,"Allergies: ",$S(ALG="":"None on file",1:ALG),!
 D ^FHORX1C D:NP NEWP Q
 ;
T1 ; Process outpatient event
 S FHTDAT=$G(^TMP($J,"O",P0,DA)),DFN=$P(P0,"~",4)
 S FHACTI=$P(FHTDAT,"^",1)
 S DTP=$P(FHTDAT,"^",2)
 S BID=$P(FHTDAT,"^",3)
 S FHDESC=$P(FHTDAT,"^",4)
 S FHTC=$P(FHTDAT,"^",5)
 ;I FHBRK=1,(FHDESC["Recurring Meal cancelled"),(FHDESC["Break") Q
 ;I FHNON=1,(FHDESC["Recurring Meal cancelled"),(FHDESC["Noon") Q
 ;I FHEVE=1,(FHDESC["Recurring Meal cancelled"),(FHDESC["Eve") Q
 ;I (FHDESC["Recurring Meal cancelled"),(FHDESC["Break") S FHBRK=1
 ;I (FHDESC["Recurring Meal cancelled"),(FHDESC["Noon") S FHNON=1
 ;I (FHDESC["Recurring Meal cancelled"),(FHDESC["Eve") S FHEVE=1
 S FHDES1=$P(FHDESC,",",1)
 S FHDIET=$P(FHDES1,":",2),FHDIET=$E(FHDIET,2,$L(FHDIET))
 I FHDIET'="",$D(^FH(111,"B",FHDIET)) S FHDIDA=$O(^FH(111,"B",FHDIET,0))
 I $G(FHDIDA),$D(^FH(111,FHDIDA,0)) S FHDIET=$P(^FH(111,FHDIDA,0),U,7)
 S:FHDIET="" FHDIET="NO ORDER"
 S Y=FHDIET
 S W1=$P(P0,"~",2),R1=$P(P0,"~",4),(N1,FHDPTN)=$P(P0,"~",5)
 ;T2
 I $D(^FH(119.8,DA,0)) S FHUSER=$P(^(0),U,9) S:$G(FHUSER) FHUSERN=$P(^VA(200,FHUSER,0),U,1)
 ;S EVT=FHDESC_" by "_FHUSERN
 I FHDESC["Standing" S FHSO1=$P(FHDESC,":",1),FHDESC="Outpatient SO"_$E(FHDESC,$L(FHSO1)+1,$L(FHDESC))
 I FHDESC["Supplemental" S FHSF1=$P(FHDESC,":",1),FHDESC="Outpatient SF"_$E(FHDESC,$L(FHSF1)+1,$L(FHDESC))
 S EVT=FHDESC
 I $Y>(IOSL-6) D HDR
 I (FHNMSV=0)!(FHNMSV'=P0) W !!,$E(W1,1,20),?22,FHDPTN,?50,BID,?73,FHTC D ALG^FHCLN W !,"Allergies: ",$S(ALG="":"None on file",1:ALG),!
 S FHNMSV=P0
 D LNE
 Q
 ;
HDR ;W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !?20,"D I E T   A C T I V I T Y   R E P O R T",?72,"Page ",PG
 W @IOF S PG=PG+1 W !?20,"D I E T   A C T I V I T Y   R E P O R T",?72,"Page ",PG
 W !!?(80-$L(H1)\2),H1
 W !,?30,FHPIO
 W !!,"Location",?22,"Patient",?50,"ID#",?62,"Sup/Std  Service"
 Q
 ;
NEWP K ALG I $G(DFN) D ALG^FHCLN I ALG'="" S EVT="Allergies: "_ALG,TYP="A" D LNE^FHORX1C
 Q:'$D(^FHPT(FHDFN,"P"))
 S X1="Pref:" F K=0:0 S K=$O(^FHPT(FHDFN,"P",K)) Q:K<1  S X=^(K,0) D N1
 W:$L(X1)>6 !?12,X1 Q
 ;
N1 S Y=$G(^FH(115.2,+X,0)) Q:$P(Y,"^",2)'="D"
 S Y=" "_$P(Y,"^",1)_" ("_$P(X,"^",2)_")"_$S($P(X,"^",4)="Y":" (D)",1:"") I $L(X1)+$L(Y)>48 W !?12,X1 S X1="Pref:"
 S X1=X1_Y Q
 ;
LNE ; Break line if longer than 58 chars
 I $Y>(IOSL-6) D HDR^FHORX1A W !
 I $L(EVT)<59 G EX
 F KK=59:-1:4 Q:$E(EVT,KK)?1P
 I KK=4 S KK=45 W !?5,$E(EVT,1,58)
 E  W !?5,$E(EVT,1,KK-1)
 S EVT="    "_$E(EVT,KK+1,999) G LNE
EX W !?5,EVT Q
