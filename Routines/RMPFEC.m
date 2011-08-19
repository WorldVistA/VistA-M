RMPFEC ;DDC/KAW-CHANGE ORDER OR BATCH STATUS [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**16**;JUN 16, 1995
RMPFSET I '$D(RMPFMENU) D MENU^RMPFUTL I '$D(RMPFMENU) W !!,$C(7),"*** A MENU SELECTION MUST BE MADE ***" Q  ;;RMPFMENU must be defined
 I '$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS) D ^RMPFUTL Q:'$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS)
 W @IOF,!!,"CHANGE ORDER OR BATCH STATUS"
 W !!?23,"*** WARNING ***"
 W !!,"This option should only be used when the status of an order",!,"or a batch cannot be changed through a software option."
A1 W !!,"Edit an <O>rder, a <B>atch or <RETURN> to continue:  "
 D READ G END:$D(RMPFOUT)
A11 I $D(RMPFQUT) W !!,"Enter a <O> to edit the status of an order",!?6,"a <B> to enter the status of a batch or",!?8,"<RETURN> to continue." G A1
 G END:Y="" S Y=$E(Y,1) I "OoBb"'[Y S RMPFQUT="" G A11
 G BATCH:"Bb"[Y
ORD W !! S DIC="^RMPF(791810,",DIC(0)="AEQM" S MN=$O(^RMPF(791810.5,"C",RMPFMENU,0))
 S DIC("S")="I $P($G(^RMPF(791810,+Y,""STA"")),"" - "",1)=$P(RMPFSTAP,"" - "",1),$P(^RMPF(791810,+Y,0),U,15)=MN"
 D ^DIC G RMPFSET:Y=-1
 S RMPFX=+Y,S0=^RMPF(791810,RMPFX,0)
 S RMPFTYP=$P(S0,U,2),RMPFST=$P(S0,U,3),(RMPFHAT,RMPFTP)=""
 I RMPFTYP,$D(^RMPF(791810.1,RMPFTYP,0)) S RMPFHAT=$P(^(0),U,2),RMPFTP=$P(^(0),U,3)
 I RMPFHAT=""!(RMPFTP="") W !!,$C(7),"*** ORDER INCOMPELTE ***" G ORDE
 I RMPFTP="P" S DFN=$P(S0,U,4) I 'DFN W !!,$C(7),"*** PATIENT NOT DEFINED ***" G END
 I RMPFTP="P" D PAT^RMPFUTL
DISP D @("HEAD"_RMPFTP_"^RMPFDT1") S CN=1 W ! D ^RMPFDT2
 W !!,"Order Status:  ",$P(^RMPF(791810.2,RMPFST,0),U,1)
 F  Q:$Y>21  W !
OR1 W !!,"Enter Number(s) of Line Item(s) to change: "
 D READ G END:$D(RMPFOUT)
OR11 I $D(RMPFQUT) W !!,"Enter Line Item Numbers separated by commas or <RETURN> to exit." G OR1
 G END:Y="" F IX=1:1 S X=$P(Y,",",IX) Q:X=""  I '$D(RMPFMD(X)) S RMPFQUT="" G OR11
 S ST=Y,X="NOW",%DT="T" D ^%DT S TD=Y
 S FY=0 F IX=1:1 S FY=$P(ST,",",IX) Q:FY=""  S DA=RMPFMD(FY) D SET
 D ^RMPFET3 G DISP
ORDE D DISPE^RMPFDT1,END^RMPFDT1 K DIC,X,Y,Y2,TD,SC,RMPFX,RMPFTYP,RMPFTP
 K RMPFST,RMPFHAT,IX,I,DFN Q
SET S RMPFY=DA,RMPFTOT=0 W @IOF,"ORDER TO CHANGE:"
 D SHOW^RMPFDT2 W !
 S DIE="^RMPF(791810,"_RMPFX_",101,"
 S DR=".18;I X="" S Y="";.17////"_TD_";.2////1" D ^DIE Q
BATCH W !! S DIC="^RMPF(791812,",DIC(0)="AEQM"
 S DIC("S")="I $P(^RMPF(791812,+Y,0),U,8)=RMPFSTAP,$P(^RMPF(791812,+Y,0),U,9)=$O(^RMPF(791810.5,""C"",RMPFMENU,0))"
 D ^DIC G RMPFSET:Y=-1
 S DIE=DIC,DA=+Y,DR=.02 D ^DIE G BATCH
END K %,%DT,%Y,%T,C,I,D,D0,DA,DI,DIC,DIE,DQ,DR,T,X,Y,DISYS,MN
 Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
