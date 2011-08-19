PRCPUFCP ;WISC/RFJ/DGL-select fund control point utility ; 10.19.99
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SELECT(TYPE)      ;  select fund control point
 ;  if type (of inventory point set) use screen for lookup
 N %,C,DA,DIC,DISYS,X,Y
 I '$D(^PRC(420,+$G(PRC("SITE")),0)) Q 0
 I '$D(^PRC(420,PRC("SITE"),1,0)) S ^(0)="^420.01^^"
 S DIC="^PRC(420,"_PRC("SITE")_",1,",DA(1)=PRC("SITE"),DIC(0)="QEAMZ"
 S DIC("W")="D DISPIP^PRCPUTIL(Y)"
 S DIC("S")="I $O(^PRC(420,PRC(""SITE""),1,+Y,1,0))"
 I TYPE'="" S DIC("S")=DIC("S")_","_$S(TYPE="W":"$P(^PRC(420,PRC(""SITE""),1,+Y,0),U,12)=2",1:"$P(^PRC(420,PRC(""SITE""),1,+Y,0),U,12)'=2")
 W ! D ^DIC
 Q +Y
 ;
 ;
SET(FCPDA,INVPT)         ;  set invpt to fund control point
 I '$D(^PRC(420,$G(PRC("SITE")),1,+FCPDA,0)) Q
 I $D(^PRC(420,"AE",$G(PRC("SITE")),INVPT,+FCPDA)) Q
 N %,D,D0,DA,DI,DIC,DIE,DO,DQ,DR,X,Y,PRCPPRIV
 S PRCPPRIV=1
 S DIC="^PRC(420,"_PRC("SITE")_",1,"_+FCPDA_",7,",X=INVPT
 S DIC("P")=$P(^DD(420.01,17.5,0),U,2)
 S DA(1)=+FCPDA,DA(2)=PRC("SITE"),DIC(0)="L",DLAYGO=420
 D FILE^DICN
 Q
 ;
 ;
DEL(FCPDA,INVPT) ; delete invpt from control point
 I '$D(^PRC(420,"AE",$G(PRC("SITE")),INVPT,+FCPDA)) Q
 N %,DA,DIC,DIK,X,Y
 S DA=0
 S DA=$O(^PRC(420,PRC("SITE"),1,+FCPDA,7,"B",INVPT,DA)) Q:'DA
 S DIK="^PRC(420,"_PRC("SITE")_",1,"_FCPDA_",7,"
 S DA(1)=+FCPDA,DA(2)=PRC("SITE"),X=INVPT
 D ^DIK
 Q
 ;
 ;
 ; PRCPUFCP
