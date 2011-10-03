RMPFER ;DDC/KAW-REMOVE ORDER FROM A BATCH; [ 04/04/97  8:35 AM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**4**;MAY 30, 1995
RMPFSET I '$D(RMPFMENU) D MENU^RMPFUTL I '$D(RMPFMENU) W !!,$C(7),"*** A MENU SELECTION MUST BE MADE ***" Q  ;;RMPFMENU must be defined
 I '$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS) D ^RMPFUTL Q:'$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS)
 W @IOF,!,"REMOVE ORDER FROM A BATCH"
 I '$D(^RMPF(791812,"C",1)) W $C(7),!!,"*** NO BATCHES CURRENTLY OPEN ***" G END
 W !!,"Currently Open Batch:",! F I=1:1:21 W "-"
A0 S (RMPFBT,CT)=0,RM=$O(^RMPF(791810.5,"C",RMPFMENU,0))
A1 S RMPFBT=$O(^RMPF(791812,"C",1,RMPFBT))
 G A2:'RMPFBT,A1:'$D(^RMPF(791812,RMPFBT,0)) S S0=^(0)
 G A1:$P(S0,U,2)'=1 S Y=$P(S0,U,1) D DD^%DT
 G A1:$P(S0,U,8)'=RMPFSTAP,A1:$P(S0,U,9)'=RM
 S D=Y,N=$P(S0,U,4) W !!,"Date/Time Opened: ",D
 W !?1,"Number in Batch: ",N S CT=CT+1,RMPFBTH=RMPFBT G A1
A2 I CT=0 W !!,"*** NO OPEN BATCH ***" G END
 I CT=1 S RMPFBT=RMPFBTH G END:'RMPFBT,END:'$D(^RMPF(791812,RMPFBT,0)),A4
 S %DT("A")="Select Date/Time of Batch to Edit: " W !
 S %DT="AET" D ^%DT G END:Y=-1 S X=$O(^RMPF(791812,"B",Y,0))
 I X,$D(^RMPF(791812,X,0)),$P(^(0),U,2)=1 G A3
 W $C(7) G A0
A3 S RMPFBT=X K RMPFBJ
A4 W !!,"Display batch entries? YES// " D READ G END:$D(RMPFOUT)
A41 I $D(RMPFQUT) W !!,"Type <Y> or <RETURN> to display entries in the batch or <N> to continue." G A4
 S:Y="" Y="Y" I "YyNn"'[Y S RMPFQUT="" G A41
 G END:"Nn"[Y
A42 D ^RMPFDB1
 D DELETE G END:$D(RMPFOUT)!'$D(RMPFBJ),RMPFSET
END K RMPFB,RMPFBJ,N,D,RMPFBT,POP,I,CT,X,Y,%,%DT,RM Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
DELETE ;;input:  RMPFB
 ;;output: None
 K RMPFBJ
 W !!,"Enter Order Numbers Separated by Commas: "
 D READ G DELETEE:$D(RMPFOUT)
DELE I $D(RMPFQUT) W !!,"Select the number(s) to the left of the orders you wish to delete.",!,"Separate numbers with commas." G DELETE
 G DELETEE:Y=""
 F I=1:1 S X=$P(Y,",",I) Q:X=""  I '$D(RMPFB(X)) S RMPFQUT="" Q
 G DELE:$D(RMPFQUT) S SG=Y W !!
 F I=1:1 S RX=$P(SG,",",I) Q:RX=""  I $D(RMPFB(RX)) S RMPFBJ=RMPFB(RX) I $D(^RMPF(791812,RMPFBT,101,RMPFBJ,0)) S RMPFX=$P(^(0),U,1) D DEL
 K X,Y,I,SG,RX Q
DEL I $D(RMPFX),RMPFX,$D(^RMPF(791810,RMPFX,0)) G DEL0
 W !!?25,$C(7),"*** ORDER DOES NOT EXIST *** " G DELETEE
DEL0 W !!,"Order: " S Y=$P(^RMPF(791810,RMPFX,0),U,1) D DD^%DT W Y S X=$P(^RMPF(791810,RMPFX,0),U,2) I X,$D(^RMPF(791810.1,X,0)) W ?$X+5,$P(^(0),U,1)
 W !!,"Are you sure you want to delete this order from the batch? NO// " D READ
 G DELETEE:$D(RMPFOUT)
DEL1 I $D(RMPFQUT) W !!,"Enter <N> or <RETURN> to continue or <Y> to delete the order." G DEL0
 S:Y="" Y="N" S Y=$E(Y,1) I "yYnN"'[Y S RMPFQUT="" G DEL1
 G DELETEE:"Nn"[Y
DEL2 W !!,"Enter reason for deletion: " D READ
 G DELETEE:$D(RMPFOUT)
DEL3 I $D(RMPFQUT) W !!,"You must enter a reason for the deletion (3 to 30 characters)." G DEL2
 I $L(Y)<3!$L(Y)>30 S RMPFQUT="" G DEL3
 S RMPFDLR=Y
 S X="NOW",%DT="TR" D ^%DT S RMPFDTD=Y
 S DIE="^RMPF(791812,"_RMPFBT_",101,",DA(1)=RMPFBT,DA=RMPFBJ
 S DR=".02////"_DUZ_";.03////"_RMPFDTD_";.04////"_RMPFDLR D ^DIE
 L ^RMPF(791812,RMPFBT,0) S X=$P(^RMPF(791812,RMPFBT,0),U,4) S:X X=X-1 S $P(^(0),U,4)=X
 I X=0 S Y=$P(^RMPF(791812,RMPFBT,0),U,2) K:Y ^RMPF(791812,"C",Y,RMPFBT) S Y=$P(^RMPF(791812,RMPFBT,0),U,1) K ^RMPF(791812,RMPFBT),^RMPF(791812,"B",Y,RMPFBT)
 L
 S DIE="^RMPF(791810,",DA=RMPFX,DR=".03///DISAPPROVED;.06////"_RMPFDTD_";.1////"_DUZ_";.11////"_RMPFDTD_";10.02////"_RMPFDLR D ^DIE
 S DIE="^RMPF(791810,"_RMPFX_",101,",DA(1)=RMPFX
 S DR=".17////"_RMPFDTD_";.18///DISAPPROVED;.2////1",DA=0
 D ARRAY^RMPFDT2 F  S DA=$O(RMPFO(DA)) Q:'DA  D ^DIE
 W !!?20,"*** ORDER DELETED FROM BATCH ***" H 2
DELETEE K RMPFX,RMPFDLR,RMPFDTD,DI,D0,DQ,%DT,DA,DC,DIE,DIC,DA,DR,D,X,Y Q
