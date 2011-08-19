LRBLJA ;AVAMC/REG/CYM - BB INVENTORY DATA ENTRY ;10/24/96  19:20 ;
 ;;5.2;LAB SERVICE;**72,90,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
SET K DR,DA,LR("CK") D:'$D(LRAA) Z W ! S (DIC,DIE)="^LRD(65,",DIC(0)="AEFQMZ",DIC("S")="I $P(^(0),U,16)=DUZ(2)" D ^DIC K DIC Q:Y<1  S DA=+Y Q
S Q  W ! S DIC=66,X="TYPING CHARGE",DIC(0)="X" D ^DIC I Y<1 W !," 'TYPING CHARGE' entry not in BLOOD PRODUCT File",!!,"Inform Blood Bank Supervisor",! Q
 S W=$S($D(^LAB(66,+Y,"SU",1,0)):$P(^(0),"^",2),1:"")
 D SET G:Y<1 END D CK^LRU G:$D(LR("CK")) S S DR=".12//"_W D ^DIE D FRE^LRU K DIC,DIE,DR G S
A Q  D Z G:Y=-1 END S LRF=0
 I LRCAPA W !!,"Enter 'YES' to record results and workload or 'NO' to record only results:",!,"Was testing performed at this facility " S %="" D YN^LRU G:%<1 END S:%=1 LRF=1 S X="UNIT PHENOTYPING",X("NOCODES")=1 D X^LRUWK G:'$D(X) END
B S LR("SLAM")=0 D L^LRU,SET G:Y<1 END D CK^LRU G:$D(LR("CK")) B D P^LRBLJA1 S (LR,LRD)=0,DR="[LRBLIAG]" W ! D ^DIE D FRE^LRU D:LRF ^LRBLJA1 I $D(^LRD(65,LR,0)),$P(^(0),"^",2)="SELF" S LRB=$P(^(0),"^"),LRD=$O(^LRE("C",LRB,0))
F Q:LR("SLAM")=1  F LRW=0:0 S LRW=$O(LRW(LRW)) Q:'LRW  F M=0:0 S M=$O(LRW(LRW,M)) Q:'M  D ST,CLNP
 I LR("SLAM")=1 Q
 F LRW=60,70,80,90 D
 . S M=0 F  S M=$O(^LRD(65,LR,LRW,M)) Q:'M  D ST,CK
 D:LRD CMV K A,B,C,M,LR,LRD,LRW,O,LR,LRS G B
CLNP I '$D(^LRD(65,LR,LRW,M)) D K Q:LR("SLAM")=1  S O=M,X="deleted",Z=LRW(LRW,M)_",.01" D EN^LRUD Q
 Q
CK Q:LRD'>0  Q:LR("SLAM")=1  Q:$D(^LRE(LRD,LRS,M,0))
 I $D(^LRE(LRD,LRO,M,0)) W $C(7),!!,$P(^LAB(61.3,M,0),U)," entered for ",$P(^LRE(LRD,0),U),!,"in donor file as ",$P(^DD(+$P(^LRE(LRD,LRO,0),U,2),.01,0),U),!,"Recheck donor and inventory phenotyping.",!! Q
 I '$D(^LRE(LRD,LRS,0)) S ^(0)="^"_65.5_$S(LRS=1.1:6,LRS=1.2:7,LRS=1.3:8,1:9)_"PA^^"
 L +^LRE(LRD,LRS):5 I '$T W $C(7),!,"I can't ADD the Antigen typings to the Donor File.  Someone else is editing this record.",!!,"Use the Donor-Donor phenotyping option to enter typing results to the appropriate donor",!! S LR("SLAM")=1 Q
 S V=^LRE(LRD,LRS,0),^(0)=$P(V,"^",1,2)_"^"_M_"^"_($P(V,"^",4)+1)
 S ^LRE(LRD,LRS,M,0)=M L -^LRE(LRD,LRS) Q
 ;
K Q:LRD'>0  Q:'$D(^LRE(LRD,LRS,M))
 L +^LRE(LRD,LRS):5 I '$T W $C(7),!,"I can't DELETE the Antigen Typing FOR the Donor. Someone else is editing the record",!!,"Use the Donor-Donor phenotyping option to update the donor's phenotype",! S LR("SLAM")=1 Q
 K ^LRE(LRD,LRS,M,0)
 S V(1)=$O(^LRE(LRD,LRS,0)),V=^(0),Z=+$P(V,"^",2),^(0)=$P(V,"^",1,2)_"^"_V(1)_"^"_$S(V(1)="":"",1:($P(V,"^",4)-1)) L -^LRE(LRD,LRS)
 S LRC=DA,LRC(1)=DA(1),DA(1)=LRD,(O,DA)=M,X="deleted",Z=Z_",.01" D EN^LRUD S DA=LRC,DA(1)=LRC(1) Q
 ;
Z S LR("M")=1,X="BLOOD BANK" D ^LRUTL W:Y'=-1 !?20,LRAA(4) Q
ST S LRS=$S(LRW=60:"1.1;1.2",LRW=70:"1.2;1.1",LRW=80:"1.3;1.4",1:"1.4;1.3"),LRO=$P(LRS,";",2),LRS=$P(LRS,";") Q
CMV S M=$P(^LRD(65,LR,0),"^",15) Q:M=""  F M(2)=0:0 S M(2)=$O(^LRD(65,"B",LRB,M(2))) Q:'M(2)  I M(2)'=LR S $P(^LRD(65,M(2),0),"^",15)=M
 S M(1)=$P(^LRE(LRD,0),"^",15) Q:M(1)=M  I M(1)="" S $P(^(0),"^",15)=M Q
 W $C(7),!!,"Inventory unit:",$P(^LRD(65,LR,0),"^"),?38,"CMV ANTIBODY ",$S(M:"PRESENT",1:"ABSENT"),!,"Donor ",$P(^LRE(LRD,0),"^"),?38,"CMV ANTIBODY ",$S(M(1):"PRESENT",1:"ABSENT")
 W !!,"Recheck donor and inventory unit CMV ANTIBODY testing." Q
T ;transfer unit to another division
 Q  D SET G:Y<1 END D CK^LRU G:$D(LR("CK")) T S LRO=$P(^LRD(65,DA,0),U,16),DR=".16" D ^DIE,FRE^LRU K DIC,DIE,DR S LRN=$P(^LRD(65,DA,0),U,16) D:LRO'=LRN AD G T
AD S LRO=$P($G(^DIC(4,+LRO,0)),U),LRN=$P($G(^DIC(4,LRN,0)),U),LRW=$P($G(^VA(200,+DUZ,0)),U)
 S %DT="ETX",X="N" D ^%DT K %DT S A=$P($H,",")_$P($H,",",2)
 S:'$D(^LRD(65,DA,999,0)) ^(0)="^65.099DA^^" S X=^(0),^(0)=$P(X,"^",1,2)_"^"_A_"^"_($P(X,"^",4)+1),^(A,0)=Y_"^"_LRW_"^DIVISION^"_LRO_"^"_LRN Q
 Q
END D V^LRU Q
