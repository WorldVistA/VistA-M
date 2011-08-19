LRBLDPH ;AVAMC/REG - DONOR PHENOTYPING ;3/9/94  12:51
 ;;5.2;LAB SERVICE;**247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END S IOP="HOME" D ^%ZIS,L^LRU I LRCAPA S X="DONOR PHENOTYPING",X("NOCODES")=1 D X^LRUWK G:'$D(X) END
D S (DIC,DIE)="^LRE(",DIC(0)="AEQM",D="B^C^"_$S("NAFARMY"[DUZ("AG")&(DUZ("AG")]""):"G4^G",1:"D") W ! D MIX^DIC1 K DIC G:Y<1 END D REST K LR("CK") G D
REST S (DA,LRQ)=+Y D CK^LRU Q:$D(LR("CK"))  S Y=$O(^LRE(DA,5,0)) I 'Y W $C(7),!,"Must have donation date to enter phenotyping." Q
 W ! S DIC="^LRE(LRQ,5,",DIC(0)="AEQM",DIC("A")="Select donation date phenotyping specimen taken: ",DIC("B")=+^LRE(DA,5,Y,0) D ^DIC K DIC Q:Y<1  S LRI=+Y
 D P S DA=LRQ,DIE="^LRE(",DR="[LRBLDAG]" D ^DIE D FRE^LRU D:LRCAPA WK
 S DA(1)=LRQ F LRM=0:0 S LRM=$O(LRM(LRM)) Q:'LRM  F M=0:0 S M=$O(LRM(LRM,M)) Q:'M  I '$D(^LRE(LRQ,LRM,M)) S O=M,X="deleted",Z=LRM(LRM,M)_",.01" D EN^LRUD
 K M,LRM,O Q
 ;
P I '$O(^LRE(LRQ,1.1,0)),'$O(^LRE(LRQ,1.2,0)) Q
 W !!?40,"Antigen(s) present",?60,"| Antigen(s) absent",!,LR("%"),!,"Donor Phenotype Record:"
 S E=1,(F(1),G)="" F B=0:0 S B=$O(^LRE(LRQ,1.1,B)) Q:'B  S I=$P(^LAB(61.3,B,0),"^"),F(E)=F(E)_I_" ",G=G+1 I $L(F(E))>19 S F(E)=$P(F(E)," ",1,G-1),E=E+1,F(E)=I_" ",G=""
 S K=E,E=1,(J(1),G)="" F B=0:0 S B=$O(^LRE(LRQ,1.2,B)) Q:'B  S I=$P(^LAB(61.3,B,0),"^"),J(E)=J(E)_I_" ",G=G+1 I $L(J(E))>18 S J(E)=$P(J(E)," ",1,G-1),E=E+1,J(E)=I_" ",G=""
 S:E>K K=E F E=1:1:K W:E>1 ! W:$D(F(E)) ?40,$J(F(E),19) W:$D(J(E)) ?60,"|",$J(J(E),18)
 W ! Q
 ;
WK D DT^LRBLU K LRG ;enter workload
 S:'$D(^LRE(LRQ,5,LRI,99,0)) ^(0)="^65.599PA^^" I '$D(^(LRT,0)) S ^(0)=LRT,X=^LRE(LRQ,5,LRI,99,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1)
 S:'$D(^LRE(LRQ,5,LRI,99,LRT,1,0)) ^(0)="^65.5991DA^^" I '$D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,0)) S ^(0)=LRK_"^"_DUZ,X=^LRE(LRQ,5,LRI,99,LRT,1,0),^(0)=$P(X,"^",1,2)_"^"_LRK_"^"_($P(X,"^",4)+1)
 F A=1.1,1.2,1.3,1.4 F B=0:0 S B=$O(^LRE(LRQ,A,B)) Q:'B  I '$D(LRM(A,B)) F C=0:0 S C=$O(^LAB(61.3,B,9,C)) Q:'C  D STF
 S:$D(LRG) ^LRE("AA",LRQ,LRI,LRT,LRK)=$P(^LRE(LRQ,5,LRI,0),"^",4) I '$D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,1,0)) K ^LRE(LRQ,5,LRI,99,LRT,1,LRK) S X=^LRE(LRQ,5,LRI,99,LRT,1,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1)
 Q
STF S LRG=1 I $D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,1,C,0)) S X=$P(^(0),"^",2) S:'X X=1 S X=X+1,$P(^(0),"^",2,3)=X_"^"_0 Q
 S:'$D(^LRE(LRQ,5,LRI,99,LRT,1,LRK,1,0)) ^(0)="^65.59911PA^^" S X=^(0),^(0)=$P(X,"^",1,2)_"^"_C_"^"_($P(X,"^",4)+1),^(C,0)=C_"^"_1 Q
 ;
END D V^LRU Q
