LRCKFLA ;SLC/RWF - CHECK LOAD LIST & AUTO INSTRUMENT FILES ;2/5/91  12:32 ;
 ;;5.2;LAB SERVICE;**272,293**;Sep 27, 1994
 S ZTRTN="ENT^LRCKFLA" D LOG^LRCKF Q:LREND  D ENT W !! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC Q
ENT ;from LRCKF
 U IO S LRDA=0
 W !!,"CHECKING AUTO INSTRUMENT FILE"
 F DA=0:0 S DA=$O(^LAB(62.4,DA)) Q:DA<1!(DA>98)  D CHKAUTO
 W !!,"CHECKING LOAD/WORK LIST FILE"
 F DA=0:0 S DA=$O(^LRO(68.2,DA)) Q:DA<1  D CHKLL
END K LRCP W !! W:$E(IOST,1,2)="P-" @IOF Q
 Q
NAME I LRDA'=DA W !!,$P(LA,U) S LRDA=DA
 Q
CHKAUTO I $D(^LAB(62.4,DA,0))[0 W !!,"F-MISSING ZERO NODE" Q
 S LA=^LAB(62.4,DA,0),LRPGM=$P(LA,U,3)
 I LRPGM="" D NAME W !?5,"F- Has no program name. This will prevent data processing."
 I $L(LRPGM),$O(^LAB(62.4,"C",LRPGM,0))'=DA D NAME W !?5,"F- Has duplicate routine entry."
 I DA#10=1,$L($P(LA,U,2))<1 D NAME W !?5,"F- SYSTEM must have a device to get the data from."
 Q:DA#10=1
 I $D(^LRO(68.2,+$P(LA,U,4),0))[0 D NAME W !?5,"W- Should have a LOAD/WORK LIST entry."
 S I=0 F  S I=$O(^LAB(62.4,DA,3,I)) Q:I<1  I $D(^(I,0))#2 S X=^(0) I $D(^LAB(60,+X,0))[0 D NAME W !?5,"F- Entry # ",I," has a BAD test pointer."
 Q
CHKLL I $D(^LRO(68.2,DA,0))[0 W !!,"F- MISSING ZERO NODE ON ENTRY: ",DA Q
 S LA=^LRO(68.2,DA,0),LRTYPE=+$P(LA,U,3),LRNM=$P(LA,U)
 I LRCKW,LRTYPE=0,$P(LA,U,4) D NAME W !?5,"W- A sequence/batch should have 0 for cups/tray."
 I $P(LA,U,2),$D(^LAB(62.07,+$P(LA,U,2),0))[0 D NAME W !?5,"F- BAD pointer in the LOAD transform field."
 ;I LRTYPE=0,$S($D(^LAB(62.07,+$P(LA,U,2),.1)):^(.1),1:"")["TRAY=" D NAME W !?5,"F - Load transform must NOT change the TRAY number."
 I $P(LA,U,7),$D(^LAB(62.07,+$P(LA,U,7),0))[0 D NAME W !?5,"F- BAD pointer in the INITIAL setup field."
 I $D(^LRO(68.2,DA,10,0))[0 D NAME W !?5,"W- Does not have a PROFILE definded." Q
 F LRIX=0:0 S LRIX=$O(^LRO(68.2,DA,10,LRIX)) Q:LRIX<1  D CHKPRO S LRDA=0
 Q
CHKPRO I $D(^LRO(68.2,DA,10,LRIX,0))[0 D NAME W !?5,"F- MISSING PROFILE ZERO NODE." Q
 S LA=LRNM_" profile: "_^LRO(68.2,DA,10,LRIX,0)
 S B=1 F I=0:0 S I=$O(^LRO(68.2,DA,10,LRIX,1,I)) Q:I<1  I $D(^(I,0))#2 S X=^(0),B=(B&$P(X,U,3)) I $D(^LAB(60,+X,0))[0 D NAME W !?5,"F- has a BAD test pointer."
 I B D NAME W !?5,"F- At least one test of the panel must NOT be build name only."
 I $D(^LRO(68,+$P(LA,U,2),0))[0 D NAME W !?5,"F- BAD accession area pointer."
 I LRCKW,'LRTYPE S C1=$O(^LRO(68.2,DA,10,LRIX,2,1)) I C1>0 D NAME W !?5,"W- A sequence/batch should NOT have a control TRAY ",C1," defined."
 F T=0:0 S T=$O(^LRO(68.2,DA,10,LRIX,1,T)) Q:T'>0  F C=0:0 S C=$O(^LRO(68.2,DA,10,LRIX,1,T,1,C)) Q:C'>0  I $D(^(C,0))#2 S LRCP=+^(0) D CHKTC I A8 W " (TRAY/CUP)"
 F C=0:0 S C=$O(^LRO(68.2,DA,10,LRIX,4,C)) Q:C'>0  I $D(^(C,0))#2 S LRCP=+^(0) D CHKCTR I A8 W " (BEGIN LIST)"
 F C=0:0 S C=$O(^LRO(68.2,DA,10,LRIX,5,C)) Q:C'>0  I $D(^(C,0))#2 S LRCP=+^(0) D CHKCTR I A8 W " (LREND LIST)"
 Q
CHKTC I T#1!(C#1) D NAME W !?5,"F- TRAY AND/OR CUP must be integers."
 Q
CHKCTR S A8=0 I $D(^LAB(62.3,LRCP,0))[0 S A8=1 D NAME W !?5,"F- BAD control pointer." Q
 S B=0 F J=0:0 S J=$O(^LAB(62.3,LRCP,2,J)) Q:J<1  I $D(^(J,0))#2 S T=+^(0) I $D(^LRO(68.2,DA,10,LRIX,1,"B",T)) S B=1
 I 'B S A8=1 D NAME W !?5,"F- CONTROL: ",$P(^LAB(62.3,LRCP,0),U)," has no tests to accession for this profile."
 Q
