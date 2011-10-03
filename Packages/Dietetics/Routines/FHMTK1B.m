FHMTK1B ; HISC/NCA - Tray Ticket Utilities ;2/23/00  09:53
 ;;5.5;DIETETICS;**5,8**;Jan 28, 2005;Build 28
 ;patch #5 - added outpatient SO.
Q1 ; Store Service Point, Bread/Beverage default, Food Preference,
 ; and Recipes of meal
 S LN=$S(IOST?1"C".E:IOSL-2,1:IOSL-6),SL=40 F SP=0:0 S SP=$O(^FH(119.72,SP)) Q:SP<1  S Z=$G(^(SP,0)),^TMP($J,"SRP",SP)=$P(Z,"^",1,4)
 I MEAL'="A" S M1=MEAL D GET Q
 F M1="B","N","E" S FHX1=$P(FHDA,"^",$F("BNE",M1)) D GET
 Q
GET S LS(M1)=40 F LL=0:0 S LL=$O(^FH(115.2,LL)) Q:LL<1  S L2=$G(^(LL,0)) D
 .I $P(L2,"^",2)="D" D  Q
 ..F KK=0:0 S KK=$O(^FH(115.2,LL,"X",KK)) Q:KK<1  S REC=$P($G(^(KK,0)),"^",1),^TMP($J,"X",M1,LL,KK)=+REC,KKNUM=KK D
 ...I $P($G(^FH(115.2,LL,0)),U,7)'="Y" Q  ;must be set to excl emb recps
 ...I REC'="" F FHKK=0:0 S FHKK=$O(^FH(114,"AB",REC,FHKK)) Q:FHKK'>0  S FHEMB(FHKK)=FHKK
 ..F FHKK=0:0 S FHKK=$O(FHEMB(FHKK)) Q:FHKK'>0  S KKNUM=KKNUM+1,^TMP($J,"X",M1,LL,KKNUM)=FHKK  ;exclude EMBEDDED RECIPES
 ..K FHEMB Q
 .S REC=$P(L2,"^",4) Q:'REC  S Y=$G(^FH(114,+REC,0)),NAM=$P(Y,"^",1),K3=$P(Y,"^",7) I $P(L2,"^",5),$P(L2,"^",6)[M1 D
 ..S:'$D(^TMP($J,"FHDEF",M1,+REC)) ^TMP($J,"FHDEF",M1,+REC)=K3_"^"_+REC_"^"_NAM
 ..Q
 .Q
 F LL=0:0 S LL=$O(^TMP($J,"X",M1,LL)) Q:LL<1  F KK=0:0 S KK=$O(^TMP($J,"X",M1,LL,KK)) Q:KK<1  S X1=+$G(^(KK)),X2=$O(^FH(116.1,FHX1,"RE","B",X1,0)) I X2<1 K ^TMP($J,"X",M1,LL,KK)
 F P1=0:0 S P1=$O(^FH(116.1,FHX1,"RE",P1)) Q:P1<1  S L1=$G(^(P1,0)),Y=$G(^FH(114,+L1,0)),NAM=$P(Y,"^",1) D
 .F CAT=0:0 S CAT=$O(^FH(116.1,FHX1,"RE",P1,"R",CAT)) Q:CAT<1  S MCA=$G(^(CAT,0)) D
 ..S FHPD=$P(MCA,"^",2),K3=+MCA S:'K3 K3=$P(Y,"^",7)
 ..S CODE=$P($G(^FH(114.1,+K3,0)),"^",2),ZZ1=CODE
 ..I $E(CODE,$L(CODE))="X" S K3=$O(^FH(114.1,"C",$E(CODE,1,$L(CODE)-1),0)) S:'K3 K3=$P(Y,"^",7)
 ..S K4=$P($G(^FH(114.1,+K3,0)),"^",3),K4=$S('K4:99,K4<10:"0"_K4,1:K4)
 ..F P2=1:1 S FHX2=$P(FHPD," ",P2) Q:FHX2=""  S PD=$P(FHX2,";",1),P4="~" I PD'="" D
 ...F SP=0:0 S SP=$O(^TMP($J,"SRP",SP)) Q:SP<1  S SRP=$G(^TMP($J,"SRP",SP)),Z1=$G(^FH(116.1,FHX1,"RE",P1,"D",SP,0)),Z1=$P(Z1,"^",2),Z1=$S(Z1="":1,1:Z1) D SRP^FHDCR1B
 ...D STOR Q
 ..Q
 .Q
 Q
STOR ; Store Alternate recipes and default recipes
 N CODE S DBX="",CODE=ZZ1 I $E(CODE,$L(CODE))?1"X" D
 .S CODE=$E(CODE,1,$L(CODE)-1),DBX="*** Omit ",LC=0
 .F NX=0:0 S NX=$O(^FH(114,+L1,"DBX",NX)) Q:NX<1  S Z3=^(NX,0),QTY=$S($P(Z3,"^",2):$P(Z3,"^",2),1:1),ZZ=QTY_" "_$P($G(^FH(114.1,+Z3,0)),"^",1)_", " D:$L(DBX)+$L(ZZ)>28 SET S DBX=DBX_ZZ
 .D SET Q
 I $E(CODE,$L(CODE))?1N,$E(CODE,$L(CODE))>1 S ^TMP($J,"ALT",M1,PD,CODE,+L1)=K4_"~"_K3_"~"_NAM_P4
 S ^TMP($J,M1,PD,K4_"~"_K3_"~"_NAM)=+L1_"^"_CODE_"^"_P4
 S:'$D(^TMP($J,"FHPO",NAM)) ^TMP($J,"FHPO",NAM)=K4_"~"_K3_"~"_NAM
 I $D(^TMP($J,"FHDEF",M1,+L1)) S ^TMP($J,"DEF",M1,PD,K3_"~"_NAM)=+L1_"~"_K3_"~"_NAM Q
 Q
SET I $L(DBX)>9 S LC=LC+1,^TMP($J,"DBX",M1,PD,+L1,LC)=$E(DBX,1,$L(DBX)-2),DBX="*** Omit "
 Q
ALT ; Exchange dislike recipe with an alternate recipe
 S R1=$P($G(^TMP($J,MEAL,PD,X8)),"^",2),R2=R1 Q:R1=""
 F  S R2=$O(^TMP($J,"ALT",MEAL,PD,R2)) Q:R2=""!($E(R1,1,$L(R1)-1)'=$E(R2,1,$L(R2)-1))  D A1 Q:X6
 I 'X6 D
 .I $E(R1,1,$L(R1)-1)="E" S MSG="  ** NO ENTREE **",EVT="M^O^^No Entree" D ^FHORX Q
 .S MSG="  ** NO "_$P($G(^FH(114.1,Z1,0)),"^",1)_" - FP" Q
 Q
A1 S R3=0
A2 S R3=$O(^TMP($J,"ALT",MEAL,PD,R2,R3)) Q:R3<1
 S Z=$G(^TMP($J,"ALT",MEAL,PD,R2,R3)),P4="~"_$P(Z,"~",4,$L(Z,"~")) I $F(P4,"~"_SP_"~"),'$D(FP(R3)) S X6=R3 Q
 G A2
DECOD ; Decode code string
 S M1=$S(MEAL="B":1,MEAL="N":2,1:3),STR=$P(STR,";",M1)
 F X4=1:1 Q:$P(STR," ",X4,99)=""  D
 .S X1=$P(STR," ",X4),NAM=$P($G(^FH(114.1,+X1,0)),"^",1),$P(X1,",",2)=$S($P(X1,",",2)'="":$P(X1,",",2),1:1)
 .S MP(+X1)=$P(X1,",",2) Q
 Q
CHK ; Check for Patient dislike on meal
 F LL=0:0 S LL=$O(^TMP($J,"X",MEAL,LL)) Q:LL<1  F KK=0:0 S KK=$O(^TMP($J,"X",MEAL,LL,KK)) Q:KK<1  S X1=+$G(^TMP($J,"X",MEAL,LL,KK)) D
 .S X6=$O(^FHPT(FHDFN,"P","B",LL,0)) Q:X6<1
 .S X2=$G(^FHPT(FHDFN,"P",X6,0)) Q:$P(X2,"^",2)'[MEAL
 .S FP(X1)=""
 .Q
 Q
SO ; Store Standing Orders
 K ALPHA,SONAME S INDX=1 F K=0:0 S K=$O(^FHPT("ASP",FHDFN,ADM,K)) Q:K<1  D
 .S X=$G(^FHPT(FHDFN,"A",ADM,"SP",K,0)),Z=$P(X,"^",2)
 .S SONAME=$P($G(^FH(118.3,+Z,0)),U,1) I SONAME="" Q
 .I $D(ALPHA(SONAME)) S SONAME=SONAME_INDX,INDX=INDX+1
 .S ALPHA(SONAME)=K_"^"_Z
 .Q
 S SONAME="" F  S SONAME=$O(ALPHA(SONAME)) Q:SONAME=""  D
 .S K=$P(ALPHA(SONAME),U,1)
 .S X=$G(^FHPT(FHDFN,"A",ADM,"SP",K,0)),Z=$P(X,U,2),M=$P(X,U,3) Q:'Z
 .I M[MEAL S S(NBR)=S(NBR)+1,MM(S(NBR),NBR)=$S($P(X,"^",8):$P(X,"^",8),1:1)_"    "_$P(^FH(118.3,+Z,0),"^",1) Q
 Q
 ;
SOUT ; Store Outpatient Standing Orders.
 Q:'$G(ADM)
 S FHOPDAT0=$G(^FHPT(FHDFN,"OP",ADM,0)) Q:$P(FHOPDAT0,U,15)="C"
 K ALPHA,SONAME S INDX=1 F K=0:0 S K=$O(^FHPT("ASPO",FHDFN,ADM,K)) Q:K<1  D
 .S X=$G(^FHPT(FHDFN,"OP",ADM,"SP",K,0)),Z=$P(X,"^",2)
 .S SONAME=$P($G(^FH(118.3,+Z,0)),U,1) I SONAME="" Q
 .I $D(ALPHA(SONAME)) S SONAME=SONAME_INDX,INDX=INDX+1
 .S ALPHA(SONAME)=K_"^"_Z
 .Q
 S SONAME="" F  S SONAME=$O(ALPHA(SONAME)) Q:SONAME=""  D
 .S K=$P(ALPHA(SONAME),U,1)
 .S X=$G(^FHPT(FHDFN,"OP",ADM,"SP",K,0)),Z=$P(X,U,2),M=$P(X,U,3) Q:'Z
 .I M[MEAL S S(NBR)=S(NBR)+1,MM(S(NBR),NBR)=$S($P(X,"^",8):$P(X,"^",8),1:1)_"    "_$P(^FH(118.3,+Z,0),"^",1) Q
 Q
 ;
BRK ; Break the line if allergies' length > 35 chars
 I J>2 S S(NBR)=S(NBR)+1,MM(S(NBR),NBR)=$S($L(ALG)<36:ALG,1:$J("",8)_"OTHERS") Q
 I $L(ALG)<36 S S(NBR)=S(NBR)+1,J=J+1,MM(S(NBR),NBR)=ALG Q
 F L=37:-1:8 Q:$E(ALG,L-1,L)=", "
 I L=8 S L=35 S S(NBR)=S(NBR)+1,J=J+1,MM(S(NBR),NBR)=$E(ALG,1,35)
 E  S S(NBR)=S(NBR)+1,J=J+1,MM(S(NBR),NBR)=$E(ALG,1,L-1)
 S ALG=$J("",8)_$E(ALG,L+1,999)
 G BRK
