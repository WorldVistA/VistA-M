FHDCR1B ; HISC/NCA - Diet Card Utilities ;2/23/00  09:51
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
 ;patch#5 - added outpatient SO.
Q1 ; Store Bread/Beverage default, Food Preference, and Recipes of meal
 S LN=$S(IOST?1"C".E:IOSL-2,1:IOSL-6),FHX4=FHX1 F SP=0:0 S SP=$O(^FH(119.72,SP)) Q:SP<1  S Z=$G(^(SP,0)),^TMP($J,"SRP",SP)=$P(Z,"^",1,4)
 I MEAL'="A" S M1=MEAL D GET Q
 F M1="B","N","E" D GET
 Q
GET F LL=0:0 S LL=$O(^FH(115.2,LL)) Q:LL<1  D
 .S L2=$G(^(LL,0))
 .I $P(L2,"^",2)="D" D  Q
 ..I FLG S ^TMP($J,"X",M1,LL,0)=""
 ..F KK=0:0 S KK=$O(^FH(115.2,LL,"X",KK)) Q:KK<1  S REC=$P($G(^(KK,0)),"^",1) S ^TMP($J,"X",M1,LL,KK)=+REC
 ..Q
 .S REC=$P(L2,"^",4) Q:'REC  S Y=$G(^FH(114,+REC,0)),NAM=$P(Y,"^",1),K3=$P(Y,"^",7) Q:'K3  I $P(L2,"^",5) D
 ..I $P(L2,"^",6)[M1 S:'$D(^TMP($J,"FHDEF",M1,K3,+REC)) ^TMP($J,"FHDEF",M1,K3,+REC)=+REC_"^"_NAM
 ..Q
 .Q
 I FLG D  Q
 .S P1="" F  S P1=$O(^FH(116.2,"C",P1)) Q:P1=""  F P2=0:0 S P2=$O(^FH(116.2,"C",P1,P2)) Q:P2<1  S NN(P1)=+P2
 .F LL=0:0 S LL=$O(^TMP($J,"FHDEF",M1,LL)) Q:LL<1  F NX=0:0 S NX=$O(^TMP($J,"FHDEF",M1,LL,NX)) Q:NX<1  S L1=$G(^TMP($J,"FHDEF",M1,LL,NX)) D
 ..S NAM=$P(L1,"^",2)
 ..S PD="" F  S PD=$O(NN(PD)) Q:PD=""  D
 ...S P4="~" F SP=0:0 S SP=$O(^TMP($J,"SRP",SP)) Q:SP<1  S P4=P4_SP_"~"
 ...S ^TMP($J,"DEF",M1,PD,LL_"~"_NAM)=+L1_"~"_LL_"~"_NAM_P4
 ...Q
 ..Q
 .Q
 S FHX1=$P(FHX4,"^",$F("BNE",M1)) Q:'FHX1
 F LL=0:0 S LL=$O(^TMP($J,"X",M1,LL)) Q:LL<1  F KK=0:0 S KK=$O(^TMP($J,"X",M1,LL,KK)) Q:KK<1  S X1=+$G(^(KK)),X2=$O(^FH(116.1,FHX1,"RE","B",X1,0)) I X2<1 K ^TMP($J,"X",M1,LL,KK)
 F P1=0:0 S P1=$O(^FH(116.1,FHX1,"RE",P1)) Q:P1<1  S L1=$G(^(P1,0)),Y=$G(^FH(114,+L1,0)),NAM=$P(Y,"^",1) D
 .F CAT=0:0 S CAT=$O(^FH(116.1,FHX1,"RE",P1,"R",CAT)) Q:CAT<1  S MCA=$G(^(CAT,0)) D
 ..S FHPD=$P(MCA,"^",2),K3=+MCA S:'K3 K3=$P(Y,"^",7) S K4=$P($G(^FH(114.1,+K3,0)),"^",3)
 ..Q:'$D(^TMP($J,"FHDEF",M1,K3))
 ..F P2=1:1 S FHX2=$P(FHPD," ",P2) Q:FHX2=""  S PD=$P(FHX2,";",1),P4="~" I PD'="" D
 ...F SP=0:0 S SP=$O(^TMP($J,"SRP",SP)) Q:SP<1  S SRP=$G(^TMP($J,"SRP",SP)),Z1=$G(^FH(116.1,FHX1,"RE",P1,"D",SP,0)),Z1=$P(Z1,"^",2),Z1=$S(Z1="":1,1:Z1) D SRP
 ...S ^TMP($J,"DEF",M1,PD,K3_"~"_NAM)=+L1_"~"_K3_"~"_NAM_P4 Q
 ..Q
 .Q
 Q
DECOD ; Decode code string
 S M1=$S(MEAL="B":1,MEAL="N":2,1:3),ST=$P(STR,";",M1)
 F X4=1:1 Q:$P(ST," ",X4,99)=""  D
 .S X1=$P(ST," ",X4),ZZ=$G(^FH(114.1,+X1,0)),NAM=$P(ZZ,"^",1)
 .S K4=$P(ZZ,"^",3),K4=$S('K4:99,K4<10:"0"_K4,1:K4)
 .S $P(X1,",",2)=$S($P(X1,",",2)'="":$P(X1,",",2),1:1)
 .S MP(MEAL,K4_"~"_+X1_"~"_NAM)=$P(X1,",",2) Q
 Q
DISL ; Store patient dislikes
 F LL=0:0 S LL=$O(^TMP($J,"X",MEAL,LL)) Q:LL<1  D DL1 F KK=0:0 S KK=$O(^TMP($J,"X",MEAL,LL,KK)) Q:KK<1
 Q
DL1 S X6=$O(^FHPT(FHDFN,"P","B",LL,0)) Q:X6<1
 S X2=$G(^FHPT(FHDFN,"P",X6,0)) Q:$P(X2,"^",2)'[MEAL
 S TT(MEAL)=TT(MEAL)+1
 S SRT(TT(MEAL),MEAL)="    "_$E($P($G(^FH(115.2,+X2,0)),"^",1),1,15)
 Q
CHK ; Check for Patient dislike on meal
 F LL=0:0 S LL=$O(^TMP($J,"X",MEAL,LL)) Q:LL<1  F KK=0:0 S KK=$O(^TMP($J,"X",MEAL,LL,KK)) Q:KK<1  S X1=+$G(^TMP($J,"X",MEAL,LL,KK)) D
 .S X6=$O(^FHPT(FHDFN,"P","B",LL,0)) Q:X6<1
 .S X2=$G(^FHPT(FHDFN,"P",X6,0)) Q:$P(X2,"^",2)'[MEAL
 .S FP(MEAL,X1)=""
 .Q
 Q
SO ; Store Standing Orders
 F K=0:0 S K=$O(^FHPT("ASP",FHDFN,ADM,K)) Q:K<1  D
 .S X=$G(^FHPT(FHDFN,"A",ADM,"SP",K,0)),Z=$P(X,"^",2),M=$P(X,"^",3) Q:'Z
 .I M[MEAL S TT(MEAL)=TT(MEAL)+1,SRT(TT(MEAL),MEAL)=$S($P(X,"^",8):$P(X,"^",8),1:1)_"   "_$E($P($G(^FH(118.3,+Z,0)),"^",1),1,15) Q
 Q
 ;
SOUT ; Store Outpatient Standing Orders.
 Q:'$G(FHKD)
 S FHOPDAT0=$G(^FHPT(FHDFN,"OP",FHKD,0)) Q:$P(FHOPDAT0,U,15)="C"
 F K=0:0 S K=$O(^FHPT("ASPO",FHDFN,FHKD,K)) Q:K<1  D
 .S X=$G(^FHPT(FHDFN,"OP",FHKD,"SP",K,0)),Z=$P(X,"^",2),M=$P(X,"^",3) Q:'Z
 .I M[MEAL S TT(MEAL)=TT(MEAL)+1,SRT(TT(MEAL),MEAL)=$S($P(X,"^",8):$P(X,"^",8),1:1)_"   "_$E($P($G(^FH(118.3,+Z,0)),"^",1),1,15) Q
 Q
 ;
SRP ; Store service point for each Production Diet of recipe
 I Z1 S:'$F(P4,"~"_SP_"~") P4=P4_SP_"~"
 S FHX3=$P(FHX2,";",2),SC=$S(FHX3'="":$E(FHX3,1),1:""),NUM=$S(SC'="":$P(FHX3,SC,2),1:"")
 I SC=$P(SRP,"^",2),NUM S:'$F(P4,"~"_SP_"~") P4=P4_SP_"~"
 S FHX3=$P(FHX2,";",3),SC=$S(FHX3'="":$E(FHX3,1),1:""),NUM=$S(SC'="":$P(FHX3,SC,2),1:"")
 I SC=$P(SRP,"^",2),NUM S:'$F(P4,"~"_SP_"~") P4=P4_SP_"~"
 Q
BRK ; Break the line if allergies' length >50 chars
 I J>2 S S(NBR)=S(NBR)+1,^TMP($J,"MP",S(NBR),NBR)=$S($L(ALG)<51:ALG,1:$J("",8)_"OTHERS") Q
 I $L(ALG)<51 S S(NBR)=S(NBR)+1,J=J+1,^TMP($J,"MP",S(NBR),NBR)=ALG Q
 F L=52:-1:8 Q:$E(ALG,L-1,L)=", "
 I L=8 S L=50 S S(NBR)=S(NBR)+1,J=J+1,^TMP($J,"MP",S(NBR),NBR)=$E(ALG,1,50)
 E  S S(NBR)=S(NBR)+1,J=J+1,^TMP($J,"MP",S(NBR),NBR)=$E(ALG,1,L-1)
 S ALG=$J("",8)_$E(ALG,L+1,999)
 G BRK
