FHOMTK2 ;Hines OIFO/RTK OUTPATIENT MEALS BUILD TRAY TICKETS  ;2/11/04  13:45
 ;;5.5;DIETETICS;**5,8**;Jan 28, 2005;Build 28
BLD ; Build Tray Ticket list for a patient
 D GETOPV  ; GET OUTPATIENT VARIABLES - FHDIET, FHLOC, FHLOCNM
 I FHDIET=""!(FHLOC="") W !!,"NO DIET OR NO NUTRITION LOCATION!" Q
 S FHOR=FHDIET F ZZZ=1:1:4 I $L(FHOR,"^")<5 S FHOR=FHOR_"^"
 I FHMEAL'=MEAL Q
 ;  SVC (SERVICE), IS (ISOLATION/PRE), FHD (D/T TICKET LAST PRINTED),
 ;  PD (PRODUCTION DIET), SP (TRAY SERVICE PT), SP1 (CAF SERVICE PT)
 S SVC="T",SX=$E($P($G(^FH(119.6,FHLOC,0)),U,10),1) I "TCD"[SX S SVC=SX
 S SP=$P($G(^FH(119.6,FHLOC,0)),U,5),SP1=$P($G(^FH(119.6,FHLOC,0)),U,6)
 S FHPAR=$P($G(^FH(119.6,FHLOC,0)),U,24)
 S IS=$P($G(^FHPT(FHDFN,0)),U,5)
 I FHPAR'="Y" Q:SVC="C"
 I SVC="C" S:SP'=SP1 SP=SP1 Q:'SP
 I IS S IS=$G(^FH(119.4,+IS,0)) S:IS'="" SVC=SVC_"-"_$P(IS,"^",2)_$P(IS,"^",3)
 I FHOMTYP="R" D
 .S SF=""
 .I $D(^FHPT(FHDFN,"OP",FHRNUM,"SF",0)) S SF=$P(^(0),U,3)
 .I SF,$D(^FHPT(FHDFN,"OP",FHRNUM,"SF",SF,0)),'$P(^(0),U,32) S SVC=SVC_"  "_"SF"_"("_$S($P($G(^FHPT(FHDFN,"OP",FHRNUM,"SF",SF,0)),"^",34)="Y":"M",1:"I")_")"
 K FP,MP,N2,NN,P4,PS
 S DPAT=$O(^FH(111.1,"AB",FHOR,0)) I DPAT="" S FHPDT1=$P(FHDIET,U,1),PD=$P($G(^FH(111,FHPDT1,0)),U,5)  ;set Prod Diet so no INV DIET PATTERN for OP's
 I DPAT S PD=$P($G(^FH(111.1,DPAT,0)),"^",7) I $O(MP(""))="" F X8=0:0 S X8=$O(^FH(111.1,DPAT,MEAL,X8)) Q:X8<1  S Z1=$G(^(X8,0)),MP(+Z1)=$P(Z1,"^",2)
 Q:PD=""  S PD=$P($G(^FH(116.2,PD,0)),"^",2) Q:PD=""  D CHK^FHMTK1B
 I $G(NBR)=3 D PRT^FHMTK1C K MM,PP,S S NBR=0
 S NBR=$G(NBR)+1 ;D PID^FHDPA
 F X6=0:0 S X6=$O(^FHPT(FHDFN,"P","B",X6)) Q:X6<1  F X7=0:0 S X7=$O(^FHPT(FHDFN,"P","B",X6,X7)) Q:X7<1  S PS=$P($G(^FH(115.2,+X6,0)),"^",4) I PS S P4=$G(^FH(114,+PS,0)),P1=$P(P4,"^",7)_"^"_+PS_"^"_$P(P4,"^",1) I +P1 D
 .S CHK="" F  S CHK=$O(^TMP($J,"DEF",MEAL,PD,CHK)) Q:CHK=""  S C1=$G(^(CHK)) I $D(^TMP($J,"FHDEF",MEAL,+C1)),+^TMP($J,"FHDEF",MEAL,+C1)=+P1 D  Q
 ..S C2=$G(^FHPT(FHDFN,"P",+X7,0)) Q:$P(C2,"^",2)'[MEAL
 ..S P2=+CHK,P3=$P(P1,"^",3) S:'$D(N2(P2,+C1,P3)) N2(P2,+C1,P3)=+$P(P1,"^",2)_"^"_P3 Q
 .Q
 S Y0=FHPTNM_" ("_FHBID_")"_"  "_SVC,S(NBR)=0,N1=0
 S N1=N1+1 I $L(Y)<40 S PP(N1,NBR)=Y
 E  S L=$S($L($P(Y,",",1,3))<40:3,1:2) S PP(N1,NBR)=$P(Y,",",1,L),N1=N1+1,PP(N1,NBR)=$E($P(Y,",",L+1,5),2,99)
 S MM(0,NBR)=Y0_"^"_FHLOCNM_"^"_FHRMBNM_"^^^^"_FHMEAL
 D ALG^FHCLN S ALG="ALLGS.: "_$S(ALG="":"NONE ON FILE",1:ALG) S J=0 D BRK^FHMTK1B
 S X8="" F  S X8=$O(^TMP($J,MEAL,PD,X8)) Q:X8=""  S (P4,X1)=^(X8),X1=+X1,P4=$P(P4,"^",3) D
 .S Z1=+$P(X8,"~",2) Q:'$F(P4,"~"_SP_"~")
 .S (MSG,X6)="",CTR=1
 .S QTY="" Q:'$D(MP(Z1))  Q:MP(Z1)=0  S PAD=$E("    ",1,5-$L(MP(Z1))),QTY=MP(Z1)_PAD,CTR=$J(MP(Z1),0,2)
 .S:$G(^TMP($J,"FHPO",$P(X8,"~",3)))="" ^TMP($J,"FHPO",$P(X8,"~",3))=X8 S C2=$G(^TMP($J,"FHPO",$P(X8,"~",3)))
 .I $D(N2(Z1,X1)) D BRD Q
 .I $D(FP(+X1)) D SUB Q
 .S NN(X8)=QTY_$P(X8,"~",3) D CNT
 .I $D(^TMP($J,"DBX",MEAL,PD,+X1)) F LL=0:0 S LL=$O(^TMP($J,"DBX",MEAL,PD,+X1,LL)) Q:LL<1  S NN(X8_" "_LL)=$G(^(LL))
 .Q
 S X8="" F  S X8=$O(NN(X8)) Q:X8=""  D
 .S S(NBR)=S(NBR)+1,MM(S(NBR),NBR)=$G(NN(X8)) Q
 S S(NBR)=S(NBR)+1,MM(S(NBR),NBR)=""
 S ADM="" I $G(FHRNUM)'="" S ADM=FHRNUM D SOUT^FHMTK1B ; get op stnd ords
 D NOW^%DTC S (DTP,TIM)=% D DTP^FH S HD=DTP
 S DTP=D1 D DTP^FH S MDT=DTP
 I FHOMTYP="G" Q   ;if not GM set D/T ticket last printed
 I FHOMTYP="R" D NOW^%DTC S $P(^FHPT(FHDFN,"OP",FHRNUM,0),U,13)=%
 I FHOMTYP="S" D NOW^%DTC S $P(^FHPT(FHDFN,"SM",FHOMDT,0),U,10)=%
 Q
SUB ; Get Substitutes
 D ALT^FHMTK1B S:MSG'="" NN(X8)=MSG Q:'X6
 S X1=+X6,XX=Z,Z1=$P(XX,"~",2) I $D(N2(Z1,X1)) D BRD Q
 S:$D(^TMP($J,"FHPO",$P(XX,"~",3))) XX=$G(^TMP($J,"FHPO",$P(XX,"~",3)))
 S NN(XX)=QTY_$P(XX,"~",3)
 S CT=$G(^TMP($J,"CTR",MEAL,XX,SP))
 S CT=CT+CTR,^TMP($J,"CTR",MEAL,XX,SP)=CT D C1
 I SUM S TOT=$G(^TMP($J,"TOT",XX,SP)),TOT=TOT+CTR,^TMP($J,"TOT",XX,SP)=TOT
 I $D(^TMP($J,"DBX",MEAL,PD,+X1)) F LL=0:0 S LL=$O(^TMP($J,"DBX",MEAL,PD,+X1,LL)) Q:LL<1  S NN(XX_" "_LL)=$G(^(LL))
 Q
BRD ; Get Bread/Beverage
 S (X7,XX)="" F  S X7=$O(N2(Z1,X1,X7)) Q:X7=""  D
 .S L1=+N2(Z1,X1,X7),XX=$P(X8,"~",1,2)_"~"_X7
 .I '$D(NN(XX)) S NN(XX)=QTY_X7 S CT=$G(^TMP($J,"CTR",MEAL,XX,SP)),CT=CT+CTR,^TMP($J,"CTR",MEAL,XX,SP)=CT D C1 I SUM S TOT=$G(^TMP($J,"TOT",XX,SP)),TOT=TOT+CTR,^TMP($J,"TOT",XX,SP)=TOT
 .Q
 Q
CNT ; Count Recipe items for Service Points
 S CT=$G(^TMP($J,"CTR",MEAL,C2,SP)),CT=CT+CTR,^TMP($J,"CTR",MEAL,C2,SP)=CT
 I SUM S TOT=$G(^TMP($J,"TOT",C2,SP)),TOT=TOT+CTR,^TMP($J,"TOT",C2,SP)=TOT
C1 ; Setup Service Points Array
 S M1=$G(^TMP($J,"SRP",SP)),M2=$P(M1,"^",1),M3=$P(M1,"^",4)
 S:M3="" M3=$E(M2,1,8) I '$D(DP(MEAL,M3,SP)) S DP(MEAL,M3,SP)=$J(M3,10),LS(MEAL)=LS(MEAL)+10,P(MEAL,M3,SP)=""
 I SUM,'$D(TP(M3,SP)) S TP(M3,SP)=$J(M3,10),SL=SL+10,T1(M3,SP)=""
 Q
GETOPV ; Get outpatient variables
 I FHOMTYP="R" D
 .S FHDIET=$P(FHZN,U,2),FHRMBD=$P(FHZN,U,18)
 .I $P($G(^FH(119.6,FHLOC,1)),U,4)="Y" S FHDIET=$P(FHZN,U,7,11)
 .S FHLOC=$P(FHZN,U,3),FHMEAL=$P(FHZN,U,4),FHD=$P(FHZN,U,13)
 I FHOMTYP="S" D
 .S FHDIET=$P(FHZN,U,4),FHRMBD=$P(FHZN,U,13)
 .S FHLOC=$P(FHZN,U,3),FHMEAL=$P(FHZN,U,9),FHD=$P(FHZN,U,10)
 I FHOMTYP="G" D
 .S FHDIET=$P(FHZN,U,6),FHRMBD=$P(FHZN,U,11)
 .S FHLOC=$P(FHZN,U,5),FHMEAL=$P(FHZN,U,3),FHD=$P(FHZN,U,7)
 I FHDIET=""!(FHLOC="") Q
 S FHLD="" ;no WITHHOLD for outpatients
 S Y="" F A1=1:1:5 S D3=$P(FHDIET,"^",A1) I D3 S:Y'="" Y=Y_", " S Y=Y_$P(^FH(111,D3,0),"^",7) ;set Y = diet text
 D PATNAME^FHOMUTL
 S FHLOCNM=$P($G(^FH(119.6,FHLOC,0)),U,1) ;set location name
 S FHRMBNM=""
 I FHRMBD'="" S FHRMBNM=$P($G(^DG(405.4,FHRMBD,0)),U,1) ;set room-bed nm
 Q
