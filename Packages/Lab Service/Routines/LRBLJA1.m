LRBLJA1 ;AVAMC/REG - BB INVENTORY WORKLOAD ;11/5/93  07:35
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D S^LRBLW
 S:'$D(^LRD(65,LR,99,0)) ^(0)="^65.3PA^^" I '$D(^(LRT,0)) S ^(0)=LRT,X=^LRD(65,LR,99,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1)
 K LRG D DT^LRBLU
 S:'$D(^LRD(65,LR,99,LRT,1,0)) ^(0)="^65.31DA^^" I '$D(^LRD(65,LR,99,LRT,1,LRK,0)) S ^(0)=LRK_U_DUZ_U_DUZ(2)_U_LRCAPA(2)_U_LRCAPA(3),X=^LRD(65,LR,99,LRT,1,0),^(0)=$P(X,U,1,2)_U_LRK_U_($P(X,U,4)+1)
 F A=60,70,80,90 F B=0:0 S B=$O(^LRD(65,LR,A,B)) Q:'B  I '$D(LRW(A,B)) F C=0:0 S C=$O(^LAB(61.3,B,9,C)) Q:'C  D STF
 S:$D(LRG) ^LRD(65,"AA",LR,LRT,LRK)=$P(^LRD(65,LR,0),"^") I '$D(^LRD(65,LR,99,LRT,1,LRK,1,0)) K ^LRD(65,LR,99,LRT,1,LRK) S X=^LRD(65,LR,99,LRT,1,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1)
 Q
STF S LRG=1 I $D(^LRD(65,LR,99,LRT,1,LRK,1,C,0)) S X=$P(^(0),"^",2) S:'X X=1 S X=X+1,$P(^(0),"^",2,3)=X_"^"_0 Q
 S:'$D(^LRD(65,LR,99,LRT,1,LRK,1,0)) ^(0)="^65.311PA^^" S X=^(0),^(0)=$P(X,"^",1,2)_"^"_C_"^"_($P(X,"^",4)+1),^(C,0)=C Q
 ;
P I '$O(^LRD(65,DA,60,0)),'$O(^LRD(65,DA,70,0)) Q
 W !?40,"Antigen(s) present",?60,"| Antigen(s) absent",!,LR("%"),!,"Unit's Phenotype Record:"
 S E=1,(F(1),G)="" F B=0:0 S B=$O(^LRD(65,DA,60,B)) Q:'B  S I=$P(^LAB(61.3,B,0),"^"),F(E)=F(E)_I_" ",G=G+1 I $L(F(E))>19 S F(E)=$P(F(E)," ",1,G-1),E=E+1,F(E)=I_" ",G=""
 S K=E,E=1,(J(1),G)="" F B=0:0 S B=$O(^LRD(65,DA,70,B)) Q:'B  S I=$P(^LAB(61.3,B,0),"^"),J(E)=J(E)_I_" ",G=G+1 I $L(J(E))>18 S J(E)=$P(J(E)," ",1,G-1),E=E+1,J(E)=I_" ",G=""
 S:E>K K=E F E=1:1:K W:E>1 ! W:$D(F(E)) ?40,$J(F(E),19) W:$D(J(E)) ?60,"|",$J(J(E),18)
 Q
