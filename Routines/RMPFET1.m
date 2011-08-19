RMPFET1 ;DDC/KAW-ENTER/EDIT PATIENT ORDER [ 05/24/99  9:24 AM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**15,17**;06/06/01
 I $D(RMPFX) D EXIST G ORDER
 E  D ADD
ORDER I $D(RMPFX),'$D(RMPFOUT) D END1,^RMPFET5
END K RMPFHAT,RMPFST,RMPFTYP,RMPFTE
END1 K %,%DT,%Y,D,D0,DA,DI,DIC,DIE,DQ,DR,X,DISYS,S0,S2 Q
ADD ;;Add a new order
 ;;input:  RMPFTP,RMPFTE,DFN(opt.)
 ;;output: RMPFTYP,RMPFHAT,RMPFST,RMPFX
 W !!,"Do you wish to add an order? NO// " D READ
 G ADDE:$D(RMPFOUT)
ADD1 I $D(RMPFQUT) W !!,"Enter a <Y> to add an order, <N> or <RETURN> to exit." G ADD
 S:Y="" Y="N" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G ADD1
 I "Nn"[Y K RMPFX G ADDE
ADD2 S RMPFST=1 I RMPFTP="P"
TYP S DIC=791810.1,DIC(0)="AEQM",DIC("A")="Select Type of Order: "
 S DIC("S")="I $P(^(0),U,3)=RMPFTP,'$P(^(0),U,7),$D(^RMPF(791810.1,Y,102,""B"",RMPFMENU))"
 W ! D ^DIC K DIC G ADDE:Y=-1 S RMPFTYP=+Y
AUTO S RMPFHAT=$P(^RMPF(791810.1,RMPFTYP,0),U,2)
 I $P($G(^RMPF(791810.1,RMPFTYP,0)),U,2)="X" D
 .W @IOF,!!,"EXTRA COMPONENT ORDERS"
 .W !!?32,"*** REMINDER ***"
 .W !!,"This module is used to place extra component orders for hearing aids orginally"
 .W !!,"ordered through the DDC.  The purchase order number for the orginal hearing aid"
 .W !!,"order is required to place an extra component order.  If the hearing aid order"
 .W !!,"was placed after 07/01/01 the extra component order will only be accepted after"
 .W !!,"the trial period, which is 180 days from the date of shipment."
 .D CONT^RMPFET G END:$D(RMPFOUT)
 E  D
 .S X=$P(^RMPF(791810.1,RMPFTYP,0),U,5)
 .I $L(X) S X="*** "_X_" ***" W $C(7),!!,?80-$L(X)\2,X
 S X="NOW",%DT="T" D ^%DT S X=Y
 F J=1:1 Q:'$D(^RMPF(791810,"B",X))  S X=X+.00001
 S DIC="^RMPF(791810,",DIC(0)="L",DIC("DR")=".15///"_RMPFMENU
 S DLAYGO=791810 K DD,DO D FILE^DICN K DIC G ADDE:Y=-1 S RMPFX=+Y
 I RMPFTP="P" D ADD^RMPFETL I $D(RMPFOUT)!(RMPFTE=""&('$P($G(^RMPF(791810,RMPFX,2)),U,6))) D KILL G ADDE
 I RMPFTP="P" S XX=$P(RMPFTE,U,1) I XX'="" S XX=$O(^RMPF(791810.4,"B",XX,0))
 S DIE="^RMPF(791810,",DA=RMPFX,X="NOW",%DT="T" D ^%DT
 S DR=".02////"_RMPFTYP_";.03////"_RMPFST_";.05////"_DUZ_";.06////"_Y_";901////"_RMPFSTAP_";10.05////R"
 I RMPFTP="P" S DR=DR_";.04////"_DFN I RMPFTE'="" S DR=DR_";2.02///"_$P(RMPFTE,U,1)_";2.03////"_DUZ_";2.04////"_$P(RMPFTE,U,2)_";2.05////"_DT
 D ^DIE
 I RMPFTP="P" S RMSEN=$O(^DGSL(38.1,"B",DFN,0)) I RMSEN,$P($G(^DGSL(38.1,RMSEN,0)),U,2) S $P(^RMPF(791810,RMPFX,2),U,13)=1
ADDE K %,%DT,%Y,D,D0,DA,DI,DIC,DIE,DISYS,DQ,DR,J,X,XX,RMSEN Q
EXIST ;;Access and existing order
 ;; input: RMPFX,RMPFST,RMPFTYP,RMPFTP,RMPFHAT
 ;;(RMPFNAM,RMPFDOB,RMPFSSN,RMPFDOD) (if patient order)
 ;;output: None
 I '$D(^RMPF(791810,RMPFX,0)) W $C(7),!!,"THIS ORDER DOES NOT EXIST - FILE ERROR" G EXISTE
 S S2=$G(^RMPF(791810,RMPFX,2)) G EDIT:RMPFTP="S" S X=$P(S2,U,2)
 I X,$D(^RMPF(791810.4,X,0)) G EDIT
 D ADD^RMPFETL G EXISTE:$D(RMPFOUT)
 I RMPFTE=""&('$P($G(^RMPF(791810,RMPFX,2)),U,6)) W !!,"*** MUST ENTER AN ELIGIBILITY ***" G EXIST
 G EXISTE
EDIT I RMPFTP="P" S RMPFTE=$P(^RMPF(791810.4,$P(S2,U,2),0),U,1)_U_$P(S2,U,4) D EDIT^RMPFETL
EXISTE K S0,S1,S2,I,X Q
DELETE W !!,"Are you sure you want to delete this order? NO// " D READ
 G DELETEE:$D(RMPFOUT)
DEL1 I $D(RMPFQUT) W !!,"If you enter a <Y> the order will be permanently deleted from this order.",!,"If you enter a <N> or <RETURN> the order will be retained on the order." G DELETE
 S:Y="" Y="N" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G DEL1
 G DELETEE:"Nn"[Y
KILL S DA=RMPFX,DIK="^RMPF(791810," D ^DIK,REMOV^RMPFET10 S RMPFTE=""
 W !!,"*** ORDER DELETED ***" H 2
DELETEE K Y,DA,DIK,RMPFX,RMPFSEL Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
