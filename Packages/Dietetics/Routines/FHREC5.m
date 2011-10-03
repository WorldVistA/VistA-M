FHREC5 ; HISC/REL - Recipe Analysis ;5/10/93  10:53
 ;;5.5;DIETETICS;;Jan 28, 2005
ALL ; Analyze all Recipes
 D ^FHIPST6 F REC=0:0 S REC=$O(^FH(114,REC)) Q:REC<1  D ANAL
 G KIL
ANAL ; Analyze
 K A S SUM=0 F KK=1:1:66 S A(KK)=0
 S POR=$P($G(^FH(114,REC,0)),"^",2) Q:'POR
 F KK=0:0 S KK=$O(^FH(114,REC,"R",KK)) Q:KK<1  S Y0=$G(^(KK,0)) D R1
 S MUL=1 F KK=0:0 S KK=$O(^FH(114,REC,"I",KK)) Q:KK<1  S Y0=$G(^(KK,0)) D I1
 I 'SUM Q
 F K=1:1:66 S A(K)=A(K)/SUM,A(K)=+$J(A(K),0,3)
 ; File Recipe
 S NAM=$E("*"_$P($G(^FH(114,REC,0)),"^",1),1,30),DA=$P($G(^FH(114,REC,0)),"^",14) G:DA A1
 K DIC,DD,DO,DINUM S (DIC,DIE)="^FHNU(",DIC(0)="L",DLAYGO=112,X=NAM D FILE^DICN K DIC,DLAYGO Q:Y<1  S DA=+Y
 S $P(^FH(114,REC,0),"^",14)=DA
 S $P(^FHNU(DA,0),"^",3)="svg.",$P(^(0),"^",7)="X"
A1 S (Z1,Z2,Z3,Z4)="" F K=1:1:20 S $P(Z1,"^",K)=A(K)
 F K=21:1:38 S $P(Z2,"^",K-20)=A(K)
 F K=39:1:56 S $P(Z3,"^",K-38)=A(K)
 F K=57:1:66 S $P(Z4,"^",K-56)=A(K)
 S $P(^FHNU(DA,0),"^",4)=$J(SUM/POR*100,0,0)
 S ^FHNU(DA,1)=Z1,^(2)=Z2 S:Z3'="" ^FHNU(DA,3)=Z3 S:Z4'="" ^FHNU(DA,4)=Z4
 Q
R1 ; Analyze embedded recipes
 S R1=+Y0 Q:'R1  S P1=$P(Y0,"^",2) Q:'P1  S MUL=$P($G(^FH(114,R1,0)),"^",2) Q:'MUL  S MUL=P1/MUL
 F LL=0:0 S LL=$O(^FH(114,R1,"I",LL)) Q:LL<1  S Y0=$G(^(LL,0)) D I1
 Q
I1 S K1=$P(Y0,"^",3) Q:'K1
 S AMT=$P(Y0,"^",4)*4.536*MUL Q:'AMT  S SUM=SUM+AMT
 S Y=$G(^FHNU(K1,1)) F K=1:1:20 S Z1=$P(Y,"^",K) I Z1'="" S A(K)=Z1*AMT+A(K)
 S Y=$G(^FHNU(K1,2)) F K=21:1:38 S Z1=$P(Y,"^",K-20) I Z1'="" S A(K)=Z1*AMT+A(K)
 S Y=$G(^FHNU(K1,3)) F K=39:1:56 S Z1=$P(Y,"^",K-38) I Z1'="" S A(K)=Z1*AMT+A(K)
 S Y=$G(^FHNU(K1,4)) F K=57:1:66 S Z1=$P(Y,"^",K-56) I Z1'="" S A(K)=Z1*AMT+A(K)
 Q
KIL G KILL^XUSCLEAN
