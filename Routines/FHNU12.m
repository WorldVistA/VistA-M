FHNU12 ; HISC/REL - Recipe Analysis Output ;2/23/00  12:36
 ;;5.5;DIETETICS;;Jan 28, 2005
 K A,B F K=1:1:66 S A(K)=0,B(K)=0
 S NX=0,SUM=0
D1 S NX=$O(FHM(NX)) I NX="" G D2
 S AMT=+FHM(NX) I TYP="C" S WT=$P(FHM(NX),",",3),AMT=AMT*WT
 S SUM=SUM+AMT
 S AMT=AMT/100,Y=$G(^FHNU(NX,1)) F K=1:1:20 S Z1=$P(Y,"^",K) I Z1'="" S A(K)=Z1*AMT+A(K),B(K)=B(K)+1
 S Y=$G(^FHNU(NX,2)) F K=21:1:38 S Z1=$P(Y,"^",K-20) I Z1'="" S A(K)=Z1*AMT+A(K),B(K)=B(K)+1
 S Y=$G(^FHNU(NX,3)) F K=39:1:56 S Z1=$P(Y,"^",K-38) I Z1'="" S A(K)=Z1*AMT+A(K),B(K)=B(K)+1
 S Y=$G(^FHNU(NX,4)) F K=57:1:66 S Z1=$P(Y,"^",K-56) I Z1'="" S A(K)=Z1*AMT+A(K),B(K)=B(K)+1
 G D1
D2 Q:'SUM  S PW=+$J(SUM/POR,0,2),SUM=SUM/100,ANS="" F K=1:1:66 S:B(K) A(K)=A(K)/SUM,A(K)=+$J(A(K),0,3)
 W @IOF,!?23,"--- Analysis of Recipe Portion ---",!!?(80-$L(TIT)\2),TIT,!
 S SUM=PW/100 F K=1:1:34 S Y=$T(COM+K^FHNU6),Z1=$P(Y,";",3) D LST
 D PSE Q:ANS="^"  F K=35:1:70 S Y=$T(COM+K^FHNU6),Z1=$P(Y,";",3) D LST
 W !!,"Grams/Portion: ",PW
D3 R !!,"Do you wish to STORE this recipe in FOOD NUTRIENT File? ",YN:DTIME G FIN:'$T!("^"[YN) S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7,"  Answer YES or NO" G D3
 G FIN:YN?1"N".E
 K DIC,DD,DO,DINUM S (DIC,DIE)="^FHNU(",DIC(0)="L",DLAYGO=112,X=TIT D FILE^DICN K DIC,DLAYGO G:Y<1 FIN
 S DA=+Y,DR=".01;2//^S X=""svg."";3//^S X=PW;4;4.2;S:X="""" Y=98;4.4;98;99" W ! S:$D(^XUSEC("FHMGR",DUZ)) DIDEL=112 D ^DIE K DIE,DIDEL,DR G:'$D(DA) FIN
 S (Z1,Z2,Z3,Z4)="" F K=1:1:20 S:B(K) $P(Z1,"^",K)=A(K)
 F K=21:1:38 S:B(K) $P(Z2,"^",K-20)=A(K)
 F K=39:1:56 S:B(K) $P(Z3,"^",K-38)=A(K)
 F K=57:1:66 S:B(K) $P(Z4,"^",K-56)=A(K)
 S ^FHNU(DA,1)=Z1,^(2)=Z2 S:Z3'="" ^FHNU(DA,3)=Z3 S:Z4'="" ^FHNU(DA,4)=Z4
FIN W ! K DA,A,B,T1,Z1,Z2,Z3,Z4 Q
LST W:K#2 ! Q:'Z1  S T1=$S(K#2:0,1:42)
 W ?T1,$P(Y,";",4)," (",B(Z1),")" I B(Z1) W ?(T1+21),$J(A(Z1)*SUM,7,$P(Y,";",6))," ",$P(Y,";",5)
 Q
PSE I IOST?1"C-".E R !!,"Press RETURN to Continue ",X:DTIME W ! S:'$T!(X["^") ANS="^" Q:ANS="^"  I "^"'[X W !,"Enter a RETURN to Continue." G PSE
 Q
