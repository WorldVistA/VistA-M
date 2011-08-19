RMPFET8 ;DDC/KAW-ADJUST AN ORDER [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**17**;06/06/01
 ;;input : RMPFX,DFN,RMPFTYP,RMPFHAT,RMPFTP
 ;;output: None
 Q:'$D(RMPFX)  Q:'$D(DFN)  Q:'DFN
 W @IOF,!!,"ORDER ADJUSTMENTS"
 W !!?32,"*** WARNING ***"
 W !!,"This module is used to make adjustments to an order that has already been"
 W !!,"sent to the DDC.  Orders may be adjusted up to 60 working days after aids"
 W !!,"are issued.  If an adjustment is made after issue, the DDC will update the"
 W !!,"the order with the status 'CERTIFICATION PENDING'.  Certification will again"
 W !!,"be required before the vendor will be paid."
 D CONT^RMPFET G END:$D(RMPFOUT)
EN1 S S0=^RMPF(791810,RMPFX,0) K RMPFADJ
 I RMPFTYP,$D(^RMPF(791810.1,RMPFTYP,0)) S RMPFTYPP=$P(^(0),U,1)
 I RMPFTYP=""!(RMPFHAT="") W $C(7),!!,"ERROR IN ORDER TYPE" G END
 K RMPFSEL1
EDIT D PAT^RMPFUTL,HEAD,^RMPFDT2
 S (X,CT)=0 F I=1:1 S X=$O(RMPFO(X)) Q:'X  S CT=CT+1
 D SEL G END:$D(RMPFOUT),EDIT:$D(RMPFQUT),END:RMPFSEL1="",EDIT
END K RMPFTYPP,CT,X,RMPFOUT,RMPFQUT,RMPFSEL1,RMPFADJ,RMPFDOD
 K RMPFDOB,RMPFNAM,RMPFMD,RMPFO,RMPFSSN,CM,CX,DI,DIC,I,Y,RMPFRE Q
SEL ;;Select adjustment action
 ;; input: RMPFX,CT,RMPFMD
 ;;output: RMPFSEL1
 S RMPFODAT=$P(^RMPF(791810,RMPFX,0),"^",9)
 I RMPFODAT>3010630 D
 .W !!!,"Enter <C>hange Model, <H>istory or <RETURN> to continue: " D READ
 I RMPFODAT<3010701 D
 .W !!!,"Enter <C>hange Model, <R>emove Component, <A>dd Component,"
 .W " <H>istory or <RETURN> to continue: " D READ
 G SELE:$D(RMPFOUT)
SEL1 I $D(RMPFQUT) D MSG G SELE:$D(RMPFOUT) S RMPFQUT="" G SELE
 S RMPFSEL1=$E(Y,1) G SELE:RMPFSEL1=""
 I RMPFODAT>3010630 I "CcHh"'[RMPFSEL1 S RMPFQUT="" G SEL1
 I RMPFODAT<3010701 I "CcRrAaHh"'[RMPFSEL1 S RMPFQUT="" G SEL1
 I "Hh"[RMPFSEL1 D ^RMPFDT7 G SELE
 I CT=1,$P(^RMPF(791810,RMPFX,101,RMPFMD(1),0),U,15)'="C" S RMPFY=RMPFMD(1) G DO
NUM S Z=$E(Y,2,99) G ITEM:'Z
 I $D(RMPFMD(Z)),$P(^RMPF(791810,RMPFX,101,RMPFMD(Z),0),U,15)'="C" S RMPFY=RMPFMD(Z) G DO
ITEM W !!,"Select number of item to adjust: " D READ G SELE:$D(RMPFOUT)
ITEM1 I $D(RMPFQUT) W !!,"Enter the number to the left of the item that you wish to adjust." G ITEM
 G SELE:Y="" I '$D(RMPFMD(Y)) S RMPFQUT="" G ITEM1
 S RMPFY=RMPFMD(Y)
 I $P(^RMPF(791810,RMPFX,101,RMPFY,0),U,15)="C" W $C(7),!!,"*** THIS ORDER HAS BEEN CANCELED ***" S RMPFQUT="" G ITEM1
DO S X=$P(^RMPF(791810,RMPFX,101,RMPFY,0),U,18) G SELE:'X,SELE:'$D(^RMPF(791810.2,X,0)) S X=$P(^(0),U,2) G SELE:X="" I "SECF"'[X W !!,$C(7),"*** LINE ITEMS WITH THIS STATUS CANNOT BE ADJUSTED ***" H 2 G SELE
 I "Cc"[RMPFSEL1 D CHANGEM^RMPFET81 G END:$D(RMPFOUT)!'$D(RMPFY) D CERTIFY G END:$D(RMPFOUT),SELE
 I RMPFODAT<3010701 I "Rr"[RMPFSEL1 D REMOVEC^RMPFET81 G END:$D(RMPFOUT)!'$D(RMPFY) D CERTIFY G END:$D(RMPFOUT),SELE
 I RMPFODAT<3010701 I "Aa"[RMPFSEL1 D ADDC^RMPFET81 G END:$D(RMPFOUT)!'$D(RMPFY) D CERTIFY G END:$D(RMPFOUT),SELE
SELE K X,Y,Z,RMPFMD,RMPFY Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
HEAD W @IOF,!?27,"ACTIVE ORDER INFORMATION"
 W !,"Station:  ",RMPFSTAP,?68,RMPFDAT
 W !,"Patient:  ",$E(RMPFNAM,1,25),?40,"SSN:  ",RMPFSSN,?62,"DOB:  ",RMPFDOB
 W ! F I=1:1:80 W "-"
 Q
CERTIFY S S0=^RMPF(791810,RMPFX,101,RMPFY,0)
 Q:'$P(S0,U,20)  Q:$P(S0,U,19)'["A"
 Q:'$D(^RMPF(791810,RMPFX,101,RMPFY,90))  F I=8:1:11 S $P(^(90),U,I)=""
 W !!,"*** THIS LINE ITEM MUST BE CERTIFIED ***"
 S BX=1 D ^RMPFET85
 Q
MSG W !!,"Enter <C> to change a hearing aid model"
 W:RMPFODAT<3010701 !?6,"<R> to remove a component from the order"
 W:RMPFODAT<3010701 !?6,"<A> to add a component to the order"
 W !?6,"<H> to view the history of the order actions"
 W !?6,"<RETURN> to continue."
 W !!,"If the order consists of more than one model, the number of the model needing to",!,"be adjusted may be entered after the letter from the command line (i.g., 'C2')."
 W !!,"Enter <RETURN> to continue." D READ Q
DELETE ;;Delete old model when changing models
 ;; input: RMPFX,RMPFY,RMPFRE,RMPFMSG,RMPFY1
 ;;output: None
 S S0=^RMPF(791810,RMPFX,101,RMPFY1,0),IT=$P(S0,U,1)
 S LR=$P(S0,U,4),CX=$P(S0,U,14),X="NOW",%DT="T" D ^%DT S TD=Y
 S DIC="^RMPF(791810,"_RMPFX_",101,",DA(1)=RMPFX,DLAYGO=791810
 S DIC(0)="L",X=""_IT_""
 S DIC("DR")=".04////"_LR_";.14////"_CX_";.15////DC;.16////"_RMPFY1_";.18///APPROVED;90.01////"_DUZ_";90.02////"_TD_";90.03////"_RMPFRE_";90.04////"_RMPFMESG W "."
 K DD,DO D FILE^DICN S RMPFY3=+Y
 I Y=-1 W $C(7),!!,"*** MODEL NOT DELETED ***" H 2 Q
 S RMPFY=RMPFY1 D ARRAY2^RMPFDT2
 S RMPFZ=0 F IX=1:1 S RMPFZ=$O(RMPFC(RMPFZ)) Q:'RMPFZ  W "." D
 .S IT=$P(RMPFC(RMPFZ),U,1),CX=$P(RMPFC(RMPFZ),U,2)
 .I '$D(^RMPF(791810,RMPFX,101,RMPFY3,102,0)) S ^RMPF(791810,RMPFX,101,RMPFY3,102,0)="^791810.101102P"
 .S DIC="^RMPF(791810,"_RMPFX_",101,"_RMPFY3_",102,",X=""_IT_""
 .S DA(2)=RMPFX,DA(1)=RMPFY3,DLAYGO=791810,DIC(0)="L"
 .S DIC("DR")=".03////D;.05////"_DUZ_";.06////"_TD_";.07////"_RMPFRE
 .K DO,DD D FILE^DICN I Y=-1 W $C(7),!!,"*** COMPONENT NOT DELETED ***" Q
 .S $P(^RMPF(791810,RMPFX,101,RMPFY3,102,+Y,0),U,4)=+Y,$P(^(0),U,2)=CX Q
 K X,Y,RMPFOUT,RMPFQUT,DIC,RMPFZ,RMPFC,IT,CX,DA,ZZ,ZY,RMPFRE,RMPFY3,TD
 K LR,IX,%,%DT,D0,DI,DIE,DLAYGO,DQ,DR Q
