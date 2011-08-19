LRBLPT ;AVAMC/REG - TRANSFUSION RESULTS ;9/7/95  08:59 ;
 ;;5.2;LAB SERVICE;**72,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W !!?28,"Enter transfusion results"
ASK W ! K ^TMP($J),LRZ,LRA,DIC,DIE,DR D ^LRDPA G:LRDFN=-1 END D R G ASK
 ;
R I '$D(^LRD(65,"AP",LRDFN)) W $C(7),!!,"No units currently assigned/xmatched.",! Q
 W ! S DIC("B")=LRMD,DIC="^VA(200,",DIC(0)="AEQ",D="AK.PROVIDER",DIC("A")="Select PROVIDER: " D IX^DIC Q:Y<1  S X=+Y,LRMD=$P(Y,U,2),LRMD(1)=+Y K DIC
T W !!,"Select TREATING SPECIALTY: ",LRS,$S(LRS]"":"// ",1:"") R X:DTIME Q:X[U!'$T  I X="",LRS="" Q
 S:X="" X=LRS I X["?" S DIC=45.7,DIC(0)="EM" D ^DIC K DIC W !,"You may select a specialty not in the treating specialty file." G T
 X $P(^DD(65,6.3,0),"^",5,99) I '$D(X) W $C(7),! W:$D(^(3)) ^(3) X:$D(^(4)) ^(4) G T
 S DIC="^DIC(45.7,",DIC(0)="EM" D ^DIC K DIC
 I Y<1 W $C(7),!,"Not an entry in the TREATING SPECIALTY file.",!,"Still want to accept it " S %=2 D YN^LRU I %'=1 S LRS="" G T
 S LRS=$S(Y>0:$P(Y,"^",2),1:X),LRS(1)=$S(Y>0:+Y,1:"")
 W ! S (LRA,LRZ)=0,LRG=1 F LRB=1:1 S LRA=$O(^LRD(65,"AP",LRDFN,LRA)) Q:'LRA  D:LRB#20=0 M D N
 K LRG I LRZ=1 S LRV=1 G ^LRBLPT1
SEL W !!,"Select units (1-",LRZ,") to enter TRANSFUSION results: " R X:DTIME Q:X=""!(X[U)  I X["?" W !,"Enter numbers from 1 to ",LRZ,!,"For 2 or more selections separate each with a ',' (ex. 1,3,4)",!,"Enter 'ALL' for all units." G SEL
 G:X="ALL" ALL
 I X?.E1CA.E!($L(X)>200) W $C(7),!,"No CONTROL CHARACTERS, LETTERS or more than 200 characters allowed." G SEL
 I '+X W $C(7),!,"START with a NUMBER !!",! G SEL
 S LRQ=X F LRB=0:0 S LRV=+LRQ,LRQ=$E(LRQ,$L(LRV)+2,$L(LRQ)) D:$D(^TMP($J,LRV)) ^LRBLPT1 Q:'$L(LRQ)
 Q
 ;
N W:LRB=1 !?6,"Unit assigned/xmatched:",?48,"Exp date",?64,"Loc"
 I '$D(^LRD(65,LRA,0)) K ^LRD(65,"AP",LRDFN,LRA) Q
 Q:$P(^LRD(65,LRA,0),"^",16)'=DUZ(2)  I '$P(^LRD(65,LRA,2,LRDFN,0),"^",3) S X=$O(^LRD(65,LRA,2,LRDFN,1,0)) S:X X=+^(X,0) S:X $P(^LRD(65,LRA,2,LRDFN,0),"^",3)=X
 S X=^LRD(65,LRA,0),F=$O(^(3,0)) S:F F=$P(^(F,0),"^",4) S:F="" F="Blood Bank"
 S M=$P(^LAB(66,$P(X,"^",4),0),"^"),LRZ=LRZ+1,^TMP($J,LRZ)=LRA_"^"_$P(X,"^",4)_"^"_$P(X,"^")_"^"_$P(X,"^",7)_"^"_$P(X,"^",8)_"^"_$P(^LRD(65,LRA,2,LRDFN,0),"^",3)_"^"_F W ! W:$D(LRG) $J(LRZ,2),") "
 W $P(X,"^"),?17,$E(M,1,22),?40,$J($P(X,"^",7),2),?43,$P(X,"^",8),?48 S Y=$P(X,"^",6) D DT^LRU W Y,?64,F Q
 ;
ALL F LRV=0:0 S LRV=$O(^TMP($J,LRV)) Q:'LRV  D ^LRBLPT1
 Q
M R !,"Press RETURN",X:DTIME W $C(13),$J("",15),$C(13) Q
END D V^LRU Q
