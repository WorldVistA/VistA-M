FHPRR2 ; HISC/REL/RVD - Projected Usage (cont). ;1/23/98  16:11
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;RVD - Outpatient meals.
 S T0=0 F P0=0:0 S P0=$O(M(P0)) Q:P0<1  S T0=T0+M(P0)
 S DTP=SDT D DTP^FH S H1=DTP,DTP=EDT D DTP^FH S H1=H1_" to "_DTP
 S X=SDT D DOW^%DTC S DOW=Y+1
P0 S X1=SDT D E1^FHPRC1 G:FHCY<1 P1 G:'$D(^FH(116,FHCY,"DA",FHDA,0)) P1
 S FHX1=^FH(116,FHCY,"DA",FHDA,0)
 I $D(^FH(116.3,SDT,0)) S X=^(0) F LL=2:1:4 I $P(X,"^",LL) S $P(FHX1,"^",LL)=$P(X,"^",LL)
 F K3=1:1:3 S MENU=$P(FHX1,"^",K3+1) D:MENU P2
P1 S X1=SDT,X2=1 D C^%DTC S SDT=X I SDT>EDT G S0
 S DOW=DOW+1 S:DOW=8 DOW=1 G P0
P2 F L1=0:0 S L1=$O(^FH(116.1,MENU,"RE",L1)) Q:L1<1  S M=^(L1,0) D P3
 K M,Y,Z Q
P3 S N1=0,M=+M,X=$G(^FH(114,M,0))
 F CAT=0:0 S CAT=$O(^FH(116.1,MENU,"RE",L1,"R",CAT)) Q:CAT<1  S FHPD=$P($G(^(CAT,0)),"^",2) D
 .F LL=1:1 S FHX2=$P(FHPD," ",LL) Q:FHX2=""  D P4
 .Q
 Q:'N1  S:'$D(^TMP($J,"T",M)) ^TMP($J,"T",M)=0 S ^(M)=^(M)+N1 Q
P4 S X=$P(FHX2,";",1)
 S X1=$G(^TMP($J,"M",DOW_K3,X,"T")),X2=$G(^TMP($J,"M",DOW_K3,X,"C"))
 S Y=$P(FHX2,";",2) I Y="" G P41:$O(^FH(116.1,MENU,"RE",L1,"D",0))="",P6
 D P5 S Y=$P(FHX2,";",3) D:Y'="" P5
P41 S N1=N1+X1+X2 Q
P5 I $E(Y,1)="C" S X2=$J($E(Y,2,99)*X2/100,0,0) Q
 S X1=$J($E(Y,2,99)*X1/100,0,0) Q
P6 F P0=0:0 S P0=$O(^TMP($J,"P",DOW_K3,P0)) Q:P0<1  D P7
 Q
P7 S SRV=$P($G(^FH(119.72,P0,0)),"^",2)
 I $E(SRV,1)="T" S X1=$G(^TMP($J,"P",DOW_K3,P0,X,"T"))
 I $E(SRV,1)="C" S X1=$G(^TMP($J,"P",DOW_K3,P0,X,"C"))
 S Z1=$G(^FH(116.1,MENU,"RE",L1,"D",P0,0))
 S Y=$P(Z1,"^",2) I Y'="" S X1=$J(Y*X1/100,0,0)
 S N1=N1+X1 Q
S0 F K1=0:0 S K1=$O(^TMP($J,"T",K1)) Q:K1<1  D S1
 G:$O(^TMP($J,"T",""))'="" S0
 G LIS
S1 S X0=$G(^FH(114,K1,0)),P1=^TMP($J,"T",K1),MUL=$P(X0,"^",2) K ^TMP($J,"T",K1) Q:'MUL  S MUL=P1/MUL
 F KK=0:0 S KK=$O(^FH(114,K1,"I",KK)) Q:KK<1  S Y=^(KK,0) D S2
 F KK=0:0 S KK=$O(^FH(114,K1,"R",KK)) Q:KK<1  S Y=^(KK,0) D S3
 Q
S2 S X1=+Y,Q=$P(Y,"^",2)*MUL
 S Y0=$G(^FHING(X1,0))
 S S1=$E($P(Y0,"^",1),1,30) Q:S1=""  I V0 S V1=$P(Y0,"^",4) S:V1 V1=$P($G(^FH(113.2,V1,0)),"^",1) S S1=$E(V1_$J("",30),1,30)_S1
 S:'$D(^TMP($J,"S",S1,X1)) ^TMP($J,"S",S1,X1)=0 S ^(X1)=^(X1)+Q Q
S3 S P1=$P(Y,"^",2)*MUL S:'$D(^TMP($J,"T",+Y)) ^TMP($J,"T",+Y)=0 S ^TMP($J,"T",+Y)=^TMP($J,"T",+Y)+P1 Q
LIS D NOW^%DTC S NOW=%,DTP=NOW D DTP^FH S (PG,TOT)=0 D HDR
 S (S1,V1)="" F K=0:0 S S1=$O(^TMP($J,"S",S1)) Q:S1=""  F L1=0:0 S L1=$O(^TMP($J,"S",S1,L1)) Q:L1<1  S X0=^(L1) D L0
 W !!,"Total Cost",?77,$J(TOT,12,2),! Q
L0 D:$Y>(IOSL-7) HDR S Y0=^FHING(L1,0) G:'V0 L1
 S X1=$P(Y0,"^",4) S:X1 X1=$P($G(^FH(113.2,X1,0)),"^",1) I X1'=V1 S V1=X1 W !!?5,"Vendor: ",X1,!
L1 S I1=$P(Y0,"^",17),X1=$S('I1:"",1:X0/I1)
 S I1=$P(Y0,"^",8),X2=$S('I1:"",1:X1/I1),X3=$P(Y0,"^",9)*(X2+.99\1) S:'X3 X3="" I X3 S X3=$J(X3,0,2),TOT=TOT+X3,%=$L(X3) I %>6 S X3=$E(X3,1,%-6)_","_$E(X3,%-5,%)
 S X=X0 D COM S X0=X,X=X1 D COM S X1=X,X=X2 D COM S X2=X
 W !,$P(Y0,"^",1),?63,$J(X2,8)," ",$P(Y0,"^",5),?80,$J(X3,9),?93,$J(X1,8)," ",$P(Y0,"^",6),?118,$J(X0,8)," ",$P(Y0,"^",16) Q
COM Q:X=""  S X=X+.99\1,%=$L(X) Q:%<4  S X=$E(X,1,%-3)_","_$E(X,%-2,%) Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,DTP,?51,"P R O J E C T E D   U S A G E ",?125,"Page ",PG
 W !!,"Avg. Total Census = ",T0,?(131-$L(H1)\2),H1
 W !!,"Ingredient",?64,"Purchase Qty",?84,"Cost",?97,"Issue Qty",?121,"Recipe Qty"
 W ! F K=1:1:131 W "-"
 Q
