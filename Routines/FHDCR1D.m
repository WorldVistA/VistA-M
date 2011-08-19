FHDCR1D ; HISC/REL/NCA/RVD - Build Separate Meal Diet Card ;2/23/00  09:52
 ;;5.5;DIETETICS;**3,5**;Jan 28, 2005;Build 53
 ;RVD 8/10/05 added logic on Food Preferences for Bread/Beverages default for outpatient.
 ;patch #5 - added outpatient SO and fix diet pattern for outpatient.
BLD ; Build Diet Card list for a patient in three per page format
 S X1=$G(^FHPT(+FHDFN,"A",+ADM,0)),FHORD=$P(X1,"^",2),SVC=$P(X1,"^",5),SF=$P(X1,"^",7),IS=$P(X1,"^",10),FHD=$P(X1,"^",16),(FHOR,X)=""
 I FHPAR'="Y" Q:SVC="C"
 I SVC="C" S:SP'=SP1 SP=SP1 Q:'SP
 Q:'FHORD  S X=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0))
 S PD=$P(X,"^",13),FHOR=$P(X,"^",2,6) Q:"^^^^"[FHOR
 I IS S IS=$G(^FH(119.4,+IS,0)) S:IS'="" SVC=SVC_"-"_$P(IS,"^",2)_$P(IS,"^",3)
 S:SF SVC=SVC_"  "_"SF"_"("_$S($P($G(^FHPT(FHDFN,"A",ADM,"SF",+SF,0)),"^",34)="Y":"M",1:"I")_")"
 I UPD D OLD^FHMTK11 I OLD=FHOR S FLG2=0 D EVT^FHDCR2 Q:'FLG2
 S STR=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,2))
 S DPAT=$O(^FH(111.1,"AB",FHOR,0))
 K FP,MP,N2,NN I $P(STR,";",$S(MEAL="B":1,MEAL="N":2,1:3))'="" D DECOD^FHDCR1B
 I DPAT S PD=$P($G(^FH(111.1,DPAT,0)),"^",7) D
 .I $P(STR,";",$S(MEAL="B":1,MEAL="N":2,1:3))="",$O(MP(MEAL,""))="" F X8=0:0 S X8=$O(^FH(111.1,DPAT,MEAL,X8)) Q:X8<1  S Z1=$G(^(X8,0)) D
 ..S ZZ=$G(^FH(114.1,+Z1,0)),NAM=$P(ZZ,"^",1)
 ..S K4=$P(ZZ,"^",3),K4=$S('K4:99,K4<10:"0"_K4,1:K4)
 ..S MP(MEAL,K4_"~"_+Z1_"~"_NAM)=$P(Z1,"^",2) Q
 .Q
 Q:PD=""  S PD=$P($G(^FH(116.2,PD,0)),"^",2) Q:PD=""  D CHK^FHMTK1B
 I NBR=3 D PRT^FHMTK1C K MM,PP,S S NBR=0
 S NBR=NBR+1 D PID^FHDPA
 F X6=0:0 S X6=$O(^FHPT(FHDFN,"P","B",X6)) Q:X6<1  F X7=0:0 S X7=$O(^FHPT(FHDFN,"P","B",X6,X7)) Q:X7<1  D
 .S PS=$P($G(^FH(115.2,+X6,0)),"^",4) I PS S P4=$G(^FH(114,+PS,0)),P1=$P(P4,"^",7)_"^"_+PS_"^"_$P(P4,"^",1) I +P1,$D(^TMP($J,"FHDEF",MEAL,+P1)) D
 ..S CHK="" F  S CHK=$O(^TMP($J,"DEF",MEAL,PD,CHK)) Q:CHK=""  S C1=$G(^(CHK)) I +CHK=+P1,$D(^TMP($J,"FHDEF",MEAL,+CHK,+C1)) D  Q
 ...S C2=$G(^FHPT(FHDFN,"P",+X7,0)) Q:$P(C2,"^",2)'[MEAL
 ...S P2=+P1,P3=$P(P1,"^",3) S:'$D(N2(P2,P3)) N2(P2,P3)=+$P(P1,"^",2)_"^"_P3 Q
 ..Q
 S LP="" F  S LP=$O(^TMP($J,"DEF",MEAL,PD,LP)) Q:LP=""  I '$D(N2(+LP)) D
 .S TST=$G(^TMP($J,"DEF",MEAL,PD,LP)),CHK="~"_$P(TST,"~",4,$L(TST,"~")) Q:'$F(CHK,"~"_SP_"~")
 .I '$D(FP(+TST)) S N2(+LP,$P(LP,"~",2))=+TST_"^"_$P(LP,"~",2) Q
 .Q:FLG
 .F X6=0:0 S X6=$O(^FHPT(FHDFN,"P","B",X6)) Q:X6<1  F X7=0:0 S X7=$O(^FHPT(FHDFN,"P","B",X6,X7)) Q:X7<1  D
 ..S PS=$P($G(^FH(115.2,+X6,0)),"^",4) I +PS S P4=$G(^FH(114,+PS,0)),P1=$P(P4,"^",7)_"^"_+PS_"^"_$P(P4,"^",1) I +P1,+P1=+LP D
 ...S C2=$G(^FHPT(FHDFN,"P",+X7,0)) Q:$P(C2,"^",2)'[MEAL
 ...S P2=+P1,P3=$P(P1,"^",3) S:'$D(N2(P2,P3)) N2(P2,P3)=+$P(P1,"^",2)_"^"_P3 Q
 ..Q
 S Y0=$P($G(^DPT(DFN,0)),"^",1)_" ("_BID_")"_"  "_SVC,S(NBR)=0,N1=0
 D CUR^FHORD7 S N1=N1+1 I $L(Y)<40 S PP(N1,NBR)=Y
 E  S L=$S($L($P(Y,",",1,3))<40:3,1:2) S PP(N1,NBR)=$P(Y,",",1,L),N1=N1+1,PP(N1,NBR)=$E($P(Y,",",L+1,5),2,99)
 S MM(0,NBR)=Y0_"^"_WRDN_"^"_RM
 I $G(DFN) D ALG^FHCLN S ALG="ALLGS.: "_$S(ALG="":"NONE ON FILE",1:ALG) S J=0 D BRK^FHMTK1B
 S X8="" F  S X8=$O(MP(MEAL,X8)) Q:X8=""  S X1=+MP(MEAL,X8) D
 .S Z1=+$P(X8,"~",2),QTY="" Q:'X1  S QTY=$S(+X1#1>0:$J(+X1,3,1),1:+X1_"  ")_" "
 .S Z1=+$P(X8,"~",2),QTY="" Q:'X1  S PAD=$E("    ",1,5-$L(X1)),QTY=+X1_PAD
 .I $D(N2(Z1)) D  Q
 ..S X7="" F  S X7=$O(N2(Z1,X7)) Q:X7=""  S C1=$P(X8,"~",1,2)_"~"_X7 I '$D(NN(C1)) S NN(C1)=QTY_X7
 ..Q
 .S NN(X8)=QTY_$P(X8,"~",3)
 .Q
 S X8="" F  S X8=$O(NN(X8)) Q:X8=""  D
 .S S(NBR)=S(NBR)+1,MM(S(NBR),NBR)=$G(NN(X8)) Q
 S S(NBR)=S(NBR)+1,MM(S(NBR),NBR)=""
 D SO^FHMTK1B
 S S(NBR)=S(NBR)+1,MM(S(NBR),NBR)=""
 D DISL
 Q
 ;
OUT ;process outpatient data
 S (SVC,SF,IS)=""
 I '$D(FHKDAT)!'$G(FHADM) Q
 S X1=FHKDAT
 S FHWARD=W1 D LOC^FHDCR11
 S (FHOR,FHORD)=$P(FHKDAT,U,2),FHD=$P(X1,"^",14)
 I FHPAR'="Y" Q:SVC="C"
 I SVC="C" S:SP'=SP1 SP=SP1 Q:'SP
 S:$D(^FHPT(FHDFN,0)) IS=$P(^FHPT(FHDFN,0),U,5)
 I $D(^FHPT(FHDFN,"OP",FHADM,"SF",0)) S SF=$P(^(0),U,3)
 I IS S IS=$G(^FH(119.4,+IS,0)) S:IS'="" SVC=SVC_"-"_$P(IS,"^",2)_$P(IS,"^",3)
 I SF,$D(^FHPT(FHDFN,"OP",FHADM,"SF",SF,0)),'$P(^(0),U,32) S SVC=SVC_"  "_"SF"_"("_$S($P($G(^FHPT(FHDFN,"OP",FHADM,"SF",+SF,0)),"^",34)="Y":"M",1:"I")_")"
 S MEAL=FHMEAL
 I UPD D OLD^FHMTK11 I OLD=FHOR S FLG2=0 D EVT^FHDCR2 Q:'FLG2
 S STR=""
 S:$G(FHOR) FHOR=FHOR_"^^^^"
 I FHOR="" S FHOR=$P(FHKDAT,U,7,11)
 S DPAT=$O(^FH(111.1,"AB",FHOR,0))
 K FP,MP,N2,NN
 S PD=""
 S:$G(MPD) PD=MPD
 I DPAT S PD=$P($G(^FH(111.1,DPAT,0)),"^",7) D
 .F X8=0:0 S X8=$O(^FH(111.1,DPAT,MEAL,X8)) Q:X8<1  S Z1=$G(^(X8,0)) D
 ..S ZZ=$G(^FH(114.1,+Z1,0)),NAM=$P(ZZ,"^",1)
 ..S K4=$P(ZZ,"^",3),K4=$S('K4:99,K4<10:"0"_K4,1:K4)
 ..S MP(MEAL,K4_"~"_+Z1_"~"_NAM)=$P(Z1,"^",2) Q
 Q:PD=""  S PD=$P($G(^FH(116.2,PD,0)),"^",2) Q:PD=""  D CHK^FHMTK1B
 ;
 I NBR=3 D PRT^FHMTK1C K MM,PP,S S NBR=0
 S NBR=NBR+1 D PATNAME^FHOMUTL
 ;
 F X6=0:0 S X6=$O(^FHPT(FHDFN,"P","B",X6)) Q:X6<1  F X7=0:0 S X7=$O(^FHPT(FHDFN,"P","B",X6,X7)) Q:X7<1  D
 .S PS=$P($G(^FH(115.2,+X6,0)),"^",4) I PS S P4=$G(^FH(114,+PS,0)),P1=$P(P4,"^",7)_"^"_+PS_"^"_$P(P4,"^",1) I +P1,$D(^TMP($J,"FHDEF",MEAL,+P1)) D
 ..S CHK="" F  S CHK=$O(^TMP($J,"DEF",MEAL,PD,CHK)) Q:CHK=""  S C1=$G(^(CHK)) I +CHK=+P1,$D(^TMP($J,"FHDEF",MEAL,+CHK,+C1)) D  Q
 ...S C2=$G(^FHPT(FHDFN,"P",+X7,0)) Q:$P(C2,"^",2)'[MEAL
 ...S P2=+P1,P3=$P(P1,"^",3) S:'$D(N2(P2,P3)) N2(P2,P3)=+$P(P1,"^",2)_"^"_P3 Q
 ..Q
 S LP="" F  S LP=$O(^TMP($J,"DEF",MEAL,PD,LP)) Q:LP=""  I '$D(N2(+LP)) D
 .S TST=$G(^TMP($J,"DEF",MEAL,PD,LP)),CHK="~"_$P(TST,"~",4,$L(TST,"~")) Q:'$F(CHK,"~"_SP_"~")
 .I '$D(FP(+TST)) S N2(+LP,$P(LP,"~",2))=+TST_"^"_$P(LP,"~",2) Q
 .Q:FLG
 .F X6=0:0 S X6=$O(^FHPT(FHDFN,"P","B",X6)) Q:X6<1  F X7=0:0 S X7=$O(^FHPT(FHDFN,"P","B",X6,X7)) Q:X7<1  D
 ..S PS=$P($G(^FH(115.2,+X6,0)),"^",4) I +PS S P4=$G(^FH(114,+PS,0)),P1=$P(P4,"^",7)_"^"_+PS_"^"_$P(P4,"^",1) I +P1,+P1=+LP D
 ...S C2=$G(^FHPT(FHDFN,"P",+X7,0)) Q:$P(C2,"^",2)'[MEAL
 ...S P2=+P1,P3=$P(P1,"^",3) S:'$D(N2(P2,P3)) N2(P2,P3)=+$P(P1,"^",2)_"^"_P3 Q
 ..Q
 ;
 S Y0=FHPTNM_" ("_FHBID_")"_"  "_SVC,S(NBR)=0,N1=0,Y="***"
 I '$G(FHDIET) S FHRNUM=FHKD D DIETPAT^FHOMRR1 S Y=$E(FHDIETP,1,18)
 S:$G(FHDIET) Y=$P(^FH(111,FHDIET,0),U,7)
 S N1=N1+1 I $L(Y)<40 S PP(N1,NBR)=Y
 E  S L=$S($L($P(Y,",",1,3))<40:3,1:2) S PP(N1,NBR)=$P(Y,",",1,L),N1=N1+1,PP(N1,NBR)=$E($P(Y,",",L+1,5),2,99)
 S MM(0,NBR)=Y0_"^"_WRDN_"^"_RM_"^^^^"_FHMEAL
 I $G(DFN) D ALG^FHCLN S ALG="ALLGS.: "_$S(ALG="":"NONE ON FILE",1:ALG) S J=0 D BRK^FHMTK1B
 ;
 S X8="" F  S X8=$O(MP(MEAL,X8)) Q:X8=""  S X1=+MP(MEAL,X8) D
 .S Z1=+$P(X8,"~",2),QTY="" Q:'X1  S QTY=$S(+X1#1>0:$J(+X1,3,1),1:+X1_"  ")_" "
 .S Z1=+$P(X8,"~",2),QTY="" Q:'X1  S PAD=$E("    ",1,5-$L(X1)),QTY=+X1_PAD
 .I $D(N2(Z1)) D  Q
 ..S X7="" F  S X7=$O(N2(Z1,X7)) Q:X7=""  S C1=$P(X8,"~",1,2)_"~"_X7 I '$D(NN(C1)) S NN(C1)=QTY_X7
 ..Q
 .S NN(X8)=QTY_$P(X8,"~",3)
 .Q
 S X8="" F  S X8=$O(NN(X8)) Q:X8=""  D
 .S S(NBR)=S(NBR)+1,MM(S(NBR),NBR)=$G(NN(X8)) Q
 I $G(FHKD) S ADM=FHKD D SOUT^FHMTK1B   ;get outpatient standing orders.
 S S(NBR)=S(NBR)+1,MM(S(NBR),NBR)=""
 D DISL
 Q
 ;
DISL ; Store patient dislikes
 F LL=0:0 S LL=$O(^TMP($J,"X",MEAL,LL)) Q:LL<1  D DL1
 Q
DL1 S X6=$O(^FHPT(FHDFN,"P","B",LL,0)) Q:X6<1
 S X2=$G(^FHPT(FHDFN,"P",X6,0)) Q:$P(X2,"^",2)'[MEAL
 S S(NBR)=S(NBR)+1
 S MM(S(NBR),NBR)="    "_$E($P($G(^FH(115.2,+X2,0)),"^",1),1,25)
 Q
