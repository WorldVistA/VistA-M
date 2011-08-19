FHMTK11 ; HISC/REL/NCA - Build Tray Tickets (Cont.) ;2/23/00  09:53
 ;;5.5;DIETETICS;;Jan 28, 2005
BLD ; Build Tray Ticket list for a patient
 S X1=$G(^FHPT(+FHDFN,"A",+ADM,0)),FHORD=$P(X1,"^",2),SVC=$P(X1,"^",5),SF=$P(X1,"^",7),IS=$P(X1,"^",10),FHD=$P(X1,"^",15),(FHOR,X)=""
 I FHPAR'="Y" Q:SVC="C"
 I SVC="C" S:SP'=SP1 SP=SP1 Q:'SP
 Q:'FHORD  S X=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0))
 S PD=$P(X,"^",13),FHOR=$P(X,"^",2,6) Q:"^^^^"[FHOR
 I IS S IS=$G(^FH(119.4,+IS,0)) S:IS'="" SVC=SVC_"-"_$P(IS,"^",2)_$P(IS,"^",3)
 S:SF SVC=SVC_"  "_"SF"_"("_$S($P($G(^FHPT(FHDFN,"A",ADM,"SF",+SF,0)),"^",34)="Y":"M",1:"I")_")"
 I UPD D OLD I OLD=FHOR S FLG2=0 D EVT^FHDCR2 Q:'FLG2
 S STR=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,2)) K FP,MP,N2,NN,P4,PS D:STR'="" DECOD^FHMTK1B
 S DPAT=$O(^FH(111.1,"AB",FHOR,0))
 I DPAT S PD=$P($G(^FH(111.1,DPAT,0)),"^",7) I STR="",$O(MP(""))="" F X8=0:0 S X8=$O(^FH(111.1,DPAT,MEAL,X8)) Q:X8<1  S Z1=$G(^(X8,0)),MP(+Z1)=$P(Z1,"^",2)
 Q:PD=""  S PD=$P($G(^FH(116.2,PD,0)),"^",2) Q:PD=""  D CHK^FHMTK1B
 I NBR=3 D PRT^FHMTK1C K MM,PP,S S NBR=0
 S NBR=NBR+1 D PID^FHDPA
 F X6=0:0 S X6=$O(^FHPT(FHDFN,"P","B",X6)) Q:X6<1  F X7=0:0 S X7=$O(^FHPT(FHDFN,"P","B",X6,X7)) Q:X7<1  S PS=$P($G(^FH(115.2,+X6,0)),"^",4) I PS S P4=$G(^FH(114,+PS,0)),P1=$P(P4,"^",7)_"^"_+PS_"^"_$P(P4,"^",1) I +P1 D
 .S CHK="" F  S CHK=$O(^TMP($J,"DEF",MEAL,PD,CHK)) Q:CHK=""  S C1=$G(^(CHK)) I $D(^TMP($J,"FHDEF",MEAL,+C1)),+^TMP($J,"FHDEF",MEAL,+C1)=+P1 D  Q
 ..S C2=$G(^FHPT(FHDFN,"P",+X7,0)) Q:$P(C2,"^",2)'[MEAL
 ..S P2=+CHK,P3=$P(P1,"^",3) S:'$D(N2(P2,+C1,P3)) N2(P2,+C1,P3)=+$P(P1,"^",2)_"^"_P3 Q
 .Q
 S Y0=$P($G(^DPT(DFN,0)),"^",1)_" ("_BID_")"_"  "_SVC,S(NBR)=0,N1=0
 D CUR^FHORD7 S N1=N1+1 I $L(Y)<40 S PP(N1,NBR)=Y
 E  S L=$S($L($P(Y,",",1,3))<40:3,1:2) S PP(N1,NBR)=$P(Y,",",1,L),N1=N1+1,PP(N1,NBR)=$E($P(Y,",",L+1,5),2,99)
 S MM(0,NBR)=Y0_"^"_WRDN_"^"_RM
 I $G(DFN) D ALG^FHCLN S ALG="ALLGS.: "_$S(ALG="":"NONE ON FILE",1:ALG) S J=0 D BRK^FHMTK1B
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
 D SO^FHMTK1B
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
OLD ; Get Previous Diet Order
 S:'FHD FHD=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",1)
 S E1="" F NXT=0:0 S NXT=$O(^FHPT(FHDFN,"A",ADM,"AC",NXT)) Q:NXT<1!(NXT>FHD)  S E1=NXT
 I 'E1 S OLD="^^^^" Q
 S KK=$P($G(^FHPT(FHDFN,"A",ADM,"AC",E1,0)),"^",2) I 'KK S OLD="^^^^" Q
 S NNXX="" I NXT'="" S NNXX=$P($G(^FHPT(FHDFN,"A",ADM,"AC",NXT,0)),"^",2)
 I NNXX'="",$P($G(^FHPT(FHDFN,"A",ADM,"DI",NNXX,0)),U,10)=$P($G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)),U,9),$P($G(^FHPT(FHDFN,"A",ADM,"DI",NNXX,0)),U,7)="N" S OLD="^^^^" Q
 S OLD=$P($G(^FHPT(FHDFN,"A",ADM,"DI",KK,0)),"^",2,6) Q
