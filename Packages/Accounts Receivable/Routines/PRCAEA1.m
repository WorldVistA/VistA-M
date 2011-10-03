PRCAEA1 ;SF-ISC/LJP-IN/REACTIVATE VENDOR ;3/17/93  1:42 PM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN0 ;REACTIVATE VENDOR
 S PRCHREAV="I $D(^(10)),$P(^(10),U,5)",DIC="^PRC(440,",DIE=DIC,DIC(0)="AEMQZ" D ^DIC G Q:Y<0 S DA=+Y D LCK^PRCAEA G Q:'$D(DA)
 S PRCHY=$P(Y(0),U,1) I $E(PRCHY,1,2)="**" S PRCHY=$E(PRCHY,3,99)
 W !,"Sure you want to RE-activate Vendor number ",DA S %=2 D YN^DICN I %=1 S DR=".01////^S X=PRCHY;15////@;31.5////@" D ^DIE
 D Q G EN0
EN1 ;INACTIVATE VENDOR
 K PRCHREAV I '$D(DT) D NOW^%DTC S DT=$P(%,".",1)
 S DIC="^PRC(440,",DIE=DIC,DIC(0)="AEMQZ" D ^DIC G Q:Y<0 S DA=+Y D LCK^PRCAEA G Q:'$D(DA)
 W !,"Enter the Vendor you want to substitute for the incorrect vendor " S PRCHX="",PRCHY="**"_$E($P(Y(0),U,1),1,34) D ^DIC S:Y>0 PRCHX=+Y
 W !,"Sure you want to inactivate Vendor number ",DA W:PRCHX " and use vendor number ",PRCHX S %=2 D YN^DICN I %=1 S DR=".01////^S X=PRCHY;15////^S X=PRCHX;31.5////^S X=1" D ^DIE
 D Q G EN1
Q L -^PRC(440,+$G(DA)) K %,%Y,DIC,DIE,DR,DA,PRCHREAV,PRCHX,PRCHY,PRCHZ W ! Q
