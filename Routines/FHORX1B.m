FHORX1B ; HISC/REL/RVD - Diet Activity Labels ;8/26/94  12:10
 ;;5.5;DIETETICS;**1,8**;Jan 28, 2005;Build 28
 ;
 ;^tmp($J,"I" - for inpatient data.
 ;^tmp($J,"O" - for outpatient data;
 ;
 ;S FHPIO="** INPATIENT **"
 S S2=LAB=2*5+36 I LAB<3 D LHD
 S COUNT=0,LINE=1
 S P0="",NN=0 F  S P0=$O(^TMP($J,"I",P0)) Q:P0=""  D LST
 ;S FHPIO="** OUTPATIENT **"
 D LST1    ;go process event for outpatient
 S:$G(FHP) $P(^FH(119.73,FHP,0),"^",3)=NOW
 I '$G(FHP) F FHII=0:0 S FHII=$O(^FH(119.73,FHII)) Q:FHII'>0  S $P(^FH(119.73,FHII,0),"^",3)=NOW
 I LAB>2 D DPLL^FHLABEL
 I LAB<3 F L=1:1:18 W !
 K ^TMP($J) D KILL^XUSCLEAN
 Q
LST K PP S NP=0,LOC=0 F DA=0:0 S DA=$O(^TMP($J,"I",P0,DA)) Q:DA<1  S Z=^(DA) D L1
 Q:LOC
 I $D(PP) D L2 D:$G(FHORD) WRT
 Q
 ;
LST1 ;process outpatient
 K PP S NP=0,LOC=0,P0="" F  S P0=$O(^TMP($J,"O",P0)) Q:P0=""  D T2
 Q
 ;
L1 ; Process event for inpatient
 S ADM=$P(Z,"^",1),TYP=$P(Z,"^",2),ACT=$P(Z,"^",3),FHORD=$P(Z,"^",4),TXT=$P(Z,"^",5)
 Q:"DIL"'[TYP  I 'FHORD S NN=NN+1,FHORD=NN
 I "DI"[TYP D
 .I $D(PP(TYP,ADM_"~"_FHORD)),ACT="C" K PP(TYP,ADM_"~"_FHORD) Q
 .K PP(TYP) S PP(TYP,ADM_"~"_FHORD)=ACT_"^"_TXT Q
 I TYP="L" D
 .I ACT="D" S LOC=1 Q
 .S PP(TYP,ADM_"~"_FHORD)=ACT_"^"_TXT S:ACT="A" NP=1 Q
 Q
 ;
L2 S W1=$P(P0,"~",2),R1=$P(P0,"~",4),FHDFN=$P(P0,"~",5)
 D PATNAME^FHOMUTL I DFN="" Q
 S Y0=$G(^DPT(DFN,0))
 S N1=$P(Y0,"^",1) D PID^FHDPA
 S TC=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",5),IS=$P($G(^(0)),"^",10),FHORD=+$P($G(^(0)),"^",2)
 Q:'FHORD
 I IS S IS=$G(^FH(119.4,IS,0)) I IS'="" S TC=TC_"-"_$P(IS,"^",2)_$P(IS,"^",3)
 S X=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)) D CUR
 Q
 ;
T2 ;get the last outpatient entry.
 K PP S NP=0,LOC=0 F FH8=0:0 S FH8=$O(^TMP($J,"O",P0,FH8)) Q:FH8'>0  D
 .S FHTDAT=$G(^TMP($J,"O",P0,FH8))
 .S FHACTI=$P(FHTDAT,"^",1)
 .Q:FHACTI'="O"
 .S BID=$P(FHTDAT,"^",3)
 .S FHDESC=$P(FHTDAT,"^",4)
 .S TC=$P(FHTDAT,"^",5)
 .S FHDES1=$P(FHDESC,",",1)
 .S FHDIET=$P(FHDES1,":",2),FHDIET=$E(FHDIET,2,$L(FHDIET))
 .I FHDIET'="",$D(^FH(111,"B",FHDIET)) S FHDIDA=$O(^FH(111,"B",FHDIET,0))
 .Q:'$G(FHDIDA)
 .I $G(FHDIDA),$D(^FH(111,FHDIDA,0)) S FHDIET=$P(^FH(111,FHDIDA,0),U,7)
 .;S:FHDIET="" FHDIET="NO ORDER"
 .S Y=FHDIET
 .S W1=$P(P0,"~",2),R1="",N1=$P(P0,"~",5)
 .D WRT
 Q
 ;
WRT S ALG="" D ALG^FHCLN
 I LAB>2 D LL Q
 W !,$E(N1,1,S2-5-$L(W1)),?(S2-3-$L(W1)),W1,!,BID W:NP " *"
 W @FHIO("EON") W ?(S2-3\2),TC W @FHIO("EOF") W ?(S2-3-$L(R1)),R1 W @FHIO("EON") I $L(Y)<S2 W:LAB=2 ! W !,$S(ALG="":"",1:"*ALG"),!,Y,!!
 E  S L=$S($L($P(Y,",",1,3))<S2:3,1:2) W !!,$P(Y,",",1,L) W:LAB=2 ! W !,$E($P(Y,",",L+1,5),2,99),!
 W @FHIO("EOF") W:LAB=2 ?(S2-20),$P(H1," - ",2),!! Q
 ;
LHD S A1=S2-30\2 W:LAB=2 ! W !?A1,"***************************",!?A1,"*",?(A1+26),"*",!?A1,"*",?(A1+5),$P(H1," - ",2),?(A1+26),"*"
 W !?A1,"*",?(A1+26),"*",!?A1,"***************************",! W:LAB=2 !! Q
CUR S Y="" Q:X=""  S FHOR=$P(X,"^",2,6),FHLD=$P(X,"^",7)
 I FHLD'="" S FHDU=";"_$P(^DD(115.02,6,0),"^",3),%=$F(FHDU,";"_FHLD_":") Q:%<1  S Y=$P($E(FHDU,%,999),";",1) Q
 F A1=1:1:5 S D3=$P(FHOR,"^",A1) I D3 S:Y'="" Y=Y_", " S Y=Y_$P(^FH(111,D3,0),"^",7)
 Q
LL ;
 S X1=TC S:NP BID=BID_" *"
 D LAB^FHLABEL Q
