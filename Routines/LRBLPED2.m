LRBLPED2 ;AVAMC/REG - PROCESS PEDIATRIC UNIT ;2/4/93  12:07 ; 12/13/00 1:54pm
 ;;5.2;LAB SERVICE;**247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S:'$D(^LRD(65,DA,16,0)) ^(0)="^65.16^^" L +^LRD(65,DA,16) S X=^LRD(65,DA,16,0),X(3)=$P(X,"^",3)+1,^(0)=$P(X,"^",1,2)_"^"_X(3)_"^"_($P(X,"^",4)+1) L -^LRD(65,DA,16)
 S ^LRD(65,DA,16,X(3),0)=LRI_"^"_LRV(1),X=LRV(2)-LRV(1),$P(^LRD(65,DA,0),"^",11)=X
 I X<1 S DIE=65,DR="4.1///^S X=""D"";4.2///^S X=""N"";4.3////^S X=DUZ" D ^DIE S ^LRD(65,DA,5,0)="^65.06A^1^1",^(1,0)="Pediatric unit prep"
 S (DIC,DIE)=65,DIC(0)="FL",DLAYGO=65,X=""""_LRI_"""" D ^DIC
 S DA=+Y,DR=".02///SELF;.03///00;.04///^S X=LRP;.05///^S X=LRK;.06////^S X=LRE(1);.07///^S X=LRABO;.08///^S X=LRRH;.09////^S X=DUZ;.11///^S X=LRV(1);.16////^S X=DUZ(2)" D ^DIE D:LRCAPA ^LRBLW
 S ^LRD(65,DA,9,0)="^65.091PAI^1^1",^(1,0)=LRC_"^"_$P(LRF,"^",2),A=+LRF
 F B=60,70,80,90 I $D(^LRD(65,A,B,0)),$P(^(0),"^",4) S %X="^LRD(65,A,B,",%Y="^LRD(65,DA,B," D %XY^%RCR
 S $P(^LRD(65,DA,0),"^",15)=$P(^LRD(65,A,0),"^",15)
 S LRX=DA D:LRZ EN^LRBLDRR1 I 'LRZ F X=10,11 I $D(^LRD(65,A,X)) S X(1)=^(X),^LRD(65,N,X)=X(1)
 K DLAYGO
 Q
