FHORD11 ; HISC/REL/NCA - Diet Activity Report (cont) ;4/26/93  16:37 
 ;;5.5;DIETETICS;;Jan 28, 2005
 S PG=0,S2=LAB=2*5+36 D HDR:'LAB,LHD:LAB
 F D2=0:0 S D2=$O(^TMP($J,D2)) Q:D2<1  S P0="" F E1=0:0 S P0=$O(^TMP($J,D2,P0)) Q:P0=""  F FHDFN=0:0 S FHDFN=$O(^TMP($J,D2,P0,FHDFN)) Q:FHDFN<1  S X=$G(^TMP($J,D2,P0,FHDFN)) D LST
 D DISC I LAB F L=1:1:18 W !
 W:'LAB ! I UPD S $P(^FH(119.73,FHP,0),"^",2)=NOW
 Q
LST D PATNAME^FHOMUTL I DFN="" Q
 S W1=$P(X,"^",1),R1=$P(X,"^",2),ADM=$P(X,"^",3),FHORD=$P(X,"^",4),SF=$P(X,"^",5),IS=$P(X,"^",6),OLW=$P(X,"^",7),OLR=$P(X,"^",8) Q:'$D(^DPT(DFN,0))  S Y0=^(0)
 S SO=$D(^FHPT("ASP",FHDFN,ADM))
 S W1=$E(W1,1,15),R1=$E(R1,1,10),N1=$E($P(Y0,"^",1),1,22) D PID^FHDPA
 S X0=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)),COM=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,1))
 S TC=$P(X0,"^",8) I IS S IS=$G(^FH(119.4,IS,0)) I IS'="" S TC=TC_"-"_$P(IS,"^",2)_$P(IS,"^",3)
 G:LAB L1 D:$Y>54 HDR W !!,W1,?18,R1,?31,N1,?54,BID W:OLW="" " *" W ?63,$S(SF:"SF",1:""),?66,$S(SO:"SO",1:""),?73,TC W:" "'[OLW ?81,$E(OLW,1,15) W:" "'[OLR ?99,$E(OLR,1,10)
 D:OLW="" NEWP D OLD S X=X0 D CUR W !?18,"Diet: ",Y W:COM'="" !?24,COM Q
L1 S X=X0 D CUR W !,$E(N1,1,S2-5-$L(W1)),?(S2-3-$L(W1)),W1,!,BID W:OLW="" " *"
 W @FHIO("EON") W ?(S2-3\2),TC W @FHIO("EOF") W ?(S2-3-$L(R1)),R1 W @FHIO("EON") I $L(Y)<S2 W:LAB=2 ! W !!,Y,!!
 E  S L=$S($L($P(Y,",",1,3))<S2:3,1:2) W !!,$P(Y,",",1,L) W:LAB=2 ! W !,$E($P(Y,",",L+1,5),2,99),!
 W @FHIO("EOF") W:LAB=2 ?(S2-20),$P(H1," - ",2),!! Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !?35,"D I E T   A C T I V I T Y   R E P O R T",?102,"Page ",PG
 W !!?(110-$L(H1)\2),H1
 W !!,"Ward",?18,"Room",?31,"Patient",?55,"ID#",?62,"Sup/Std  Service   Old Ward",?99,"Old Room" Q
LHD S A1=S2-30\2 W:LAB=2 ! W !?A1,"***************************",!?A1,"*",?(A1+26),"*",!?A1,"*",?(A1+5),$P(H1," - ",2),?(A1+26),"*"
 W !?A1,"*",?(A1+26),"*",!?A1,"***************************",! W:LAB=2 !! Q
CUR S Y="" Q:X=""  S FHOR=$P(X,"^",2,6),FHLD=$P(X,"^",7)
 I FHLD'="" S FHDU=";"_$P(^DD(115.02,6,0),"^",3),%=$F(FHDU,";"_FHLD_":") Q:%<1  S Y=$P($E(FHDU,%,999),";",1) Q
 F A1=1:1:5 S D3=$P(FHOR,"^",A1) I D3 S:Y'="" Y=Y_", " S Y=Y_$P(^FH(111,D3,0),"^",7)
 Q
OLD S X2="" F NX=0:0 S NX=$O(^FHPT(FHDFN,"A",ADM,"AC",NX)) Q:NX<1!(NX>TIM)  S X2=$P(^(NX,0),"^",2)
 Q:X2=FHORD!(X2="")  S X=$G(^FHPT(FHDFN,"A",ADM,"DI",X2,0)) D CUR
 W !?18,"Old:  ",Y Q
NEWP D ALG^FHCLN W:ALG'="" !?18,"Allergies: ",ALG
 S X1="Pref:" F K=0:0 S K=$O(^FHPT(FHDFN,"P",K)) Q:K<1  S X=^(K,0) D N1
 W:$L(X1)>6 !?18,X1 Q
N1 S Y=$G(^FH(115.2,+X,0)) Q:$P(Y,"^",2)'="D"
 S Y=" "_$P(Y,"^",1)_" ("_$P(X,"^",2)_")"_$S($P(X,"^",4)="Y":" (D)",1:"") I $L(X1)+$L(Y)>92 W !?18,X1 S X1="Pref:"
 S X1=X1_Y Q
DISC F NX=TIM:0 S NX=$O(^DGPM("ATT3",NX)) Q:NX<1!(NX>NOW)  F DA=0:0 S DA=$O(^DGPM("ATT3",NX,DA)) Q:DA'>0  D D2
 Q
D2 S X=$G(^DGPM(DA,0)),DFN=$P(X,"^",3),ADM=$P(X,"^",14) Q:'DFN!('ADM)
 S W1=$G(^DPT(DFN,.1)),CADM=$S(W1="":"",$D(^DPT("CN",W1,DFN)):^(DFN),1:"") Q:CADM
 S X=$P(X,"^",18) I X=41!(X=42)!(X=46)!(X=47) Q
 S X=^DPT(DFN,0),N1=$P(X,"^",1),(R1,W1,SF,SO,D2)="" D PID^FHDPA
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 I $D(^FHPT(FHDFN,"A",ADM,0)) S X=^(0),W1=$P(X,"^",11),R1=$P(X,"^",12),SF=$P(X,"^",7)
 S SO=$D(^FHPT("ASP",FHDFN,ADM))
 S OLW=W1 D:'W1 D3 I W1 S D2=$P($G(^FH(119.6,W1,0)),"^",8),W1=$P($G(^FH(119.6,W1,0)),"^",1)
 I FHP,FHP'=D2 Q
 S W1=$E(W1,1,15),R1=$E(R1,1,10),N1=$E(N1,1,22)
 I 'LAB D:$Y>54 HDR W !!,"** DISCHARGED **",?31,N1,?54,BID,?63,$S(SF:"SF",1:""),?66,$S(SO:"SO",1:""),?81,W1,?99,R1 Q
 W !,$E(N1,1,S2-5-$L(W1)),?(S2-3-$L(W1)),W1,!,BID W:OLW="" " *" W ?(S2-3-$L(R1)),R1 W !!?(S2-18\2),"** DISCHARGED **",!! W:LAB=2 !?(S2-20),$P(H1," - ",2),!! Q
D3 S W1="" F L1=0:0 S L1=$O(^DGPM("APMV",DFN,ADM,L1)) Q:L1=""  F L2=0:0 S L2=$O(^DGPM("APMV",DFN,ADM,L1,L2)) Q:L2=""  S X1=$P($G(^DGPM(L2,0)),"^",6) I X1 S W1=X1 G D4
D4 S:W1 W1=$O(^FH(119.6,"AW",W1,0)) Q
