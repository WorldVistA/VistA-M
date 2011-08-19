RMPFET9 ;DDC/KAW-DUPLICATE AN ORDER [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 ;; input: RMPFX,RMPFHAT
 ;;output: RMPFY1
 Q:'$D(^RMPF(791810,RMPFX,11))  S RMPFTF=$P(^(11),U,1) Q:RMPFTF'="B"
 N RMPFY D ARRAY^RMPFDT2
 S (X,CX)=0 F I=1:1 S X=$O(RMPFO(X)) Q:'X  S CX=CX+1
 G END:CX'=1 K RMPFY1
TWO W !!,"Will the second model be the same as the first? NO// "
 D READ G END:$D(RMPFOUT)
TWO1 I $D(RMPFQUT) W !!,"Enter <Y> to order a second model that is the same as the first,",!,"<N> or <RETURN> to continue." G TWO
 G END:Y="" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G TWO1
 G END:"Nn"[Y S RMPFY=$O(RMPFO(0))
 I '$D(^RMPF(791810,RMPFX,101,RMPFY,0)) W $C(7),!!,"*** BAD ORDER INFORMATION ***" G END
 W !!,"Adding second model ..."
 S S0=^RMPF(791810,RMPFX,101,RMPFY,0)
 S RMPFIT=$P(S0,U,1),RMPFLR=$P(S0,U,4),RMPFCS=$P(S0,U,14)
 S RMPFBAT=$P(S0,U,2),RMPFID=$P(S0,U,8)
 I '$D(^RMPF(791810,RMPFX,101,0)) S ^RMPF(791810,RMPFX,101,0)="^791810.0101P"
 S DIC="^RMPF(791810,RMPFX,101,",DA(1)=RMPFX,DIC(0)="L",DLAYGO=791810
 S X="NOW",%DT="T" D ^%DT S TD=Y W "."
 S X=RMPFIT,DIC("DR")=".04////"_$S(RMPFLR="L":"R",1:"L")_";.14////"_RMPFCS_";.15////O"
 I RMPFHAT="S" S DIC("DR")=DIC("DR")_";.02////"_RMPFBAT_";.08////"_RMPFID_";.05;101"
 K DD,DO D FILE^DICN I Y=-Y W $C(7),!!,"*** MODEL NOT ADDED ***" G END
 S (DA,RMPFY1)=+Y,DIE=DIC,DR=".16////"_+Y_";.17////"_TD_";.18///INCOMPLETE;.19////O;.2////1" D ^DIE W "."
 W !!,"*** MODEL ADDED ***"
 D ARRAY2^RMPFDT2 S CM="",(X,CX)=0 F I=1:1 S X=$O(RMPFC(X)) Q:'X  S CX=CX+1,C=$P(RMPFC(X),U,1) I C,$D(^RMPF(791811.2,C,0)) S CM=$S(I=1:$P(^(0),U,3),1:CM_","_$P(^(0),U,3))
 G END:'CX
COM W !!,"The following components were ordered with the first model: ",CM
 W !!,"Do you wish to order the same components with the second model? NO// "
 D READ G END:$D(RMPFOUT)
COM1 I $D(RMPFQUT) W !!,"Enter <Y> to order the same components for the second model",!,"<N> or <RETURN> to continue." G COM
 G COM3:Y="" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G COM1
 G COM3:"Nn"[Y S (RMPFZ,CT)=0 W !!,"Adding component(s) ..."
COM2 S RMPFZ=$O(^RMPF(791810,RMPFX,101,RMPFY,102,RMPFZ)) G EXIT:'RMPFZ S S0=^(RMPFZ,0)
 S RMPFCOM=$P(S0,U,1),RMPFCX=$P(S0,U,2)
 I '$D(^RMPF(791810,RMPFX,101,RMPFY1,102,0)) S ^RMPF(791810,RMPFX,101,RMPFY1,102,0)="^791810.101102P"
 S DIC="^RMPF(791810,"_RMPFX_",101,"_RMPFY1_",102," W "."
 S DA(2)=RMPFX,DA(1)=RMPFY1,X=RMPFCOM,DIC(0)="L",DLAYGO=791810
 S DIC("DR")=".03////O;.05////"_DUZ_";.06////"_TD W "."
 K DO,DD D FILE^DICN I Y=-1 W $C(7),!!,"*** COMPONENT NOT ADDED ***" G END
 S $P(^RMPF(791810,RMPFX,101,RMPFY1,102,+Y,0),U,4)=+Y W "." S CT=CT+1
 G COM2
COM3 S RMPFY=RMPFY1 D COMPON^RMPFET7 G END
EXIT W !!,"*** COMPONENT" W:CT>1 "S" W " ADDED ***"
END K %,%DT,C,CM,CT,CX,D0,DA,DI,DIC,DIE,DR,I,S0,TD,X,Y,ZZ,DQ,DLAYGO,RMPFC
 K RMPFCOM,RMPFCS,RMPFCX,RMPFIT,RMPFLR,RMPFO,RMPFTF,RMPFZ,RMPFID
 K RMPFOUT,RMPFQUT,RMPFBAT,M,ZY,%Y,RMPFRE,I,RMPFO,RMPFTF,X
 Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
