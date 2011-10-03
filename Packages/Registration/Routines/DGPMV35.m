DGPMV35 ;ALB/MIR - CHECK-OUT LODGERS ; MAR 12 1990
 ;;5.3;Registration;**111**;Aug 13, 1993
 ;
 I '$P(DGPMA,"^",4) W !,"Incomplete Check-Out Movement" S DIK="^DGPM(",DA=DGPMDA D ^DIK W "   deleted" S DGPMA="" G Q
 ;D ADM^DGPMV33
Q Q
ONLY ;determine if this is the only CHECK-OUT movement type
 N C,I S C=0
 F I=0:0 S I=$O(^DG(405.1,"AT",5,I)) Q:'I  I $D(^DG(405.1,I,0)),$P(^(0),"^",4) S C=C+1,DGPMCO=I I C>1 K DGPMCO Q
 Q
REAS ;called from enter/edit reasons for lodging option
 S (DIC,DIE)="^DG(406.41,",DIC(0)="AELQMZ",DLAYGO=406.41 D ^DIC G REASQ:Y<0,REAS:'Y!$P(Y,"^",3)
 I '$P(Y,"^",3) S DR=.01,DA=+Y D ^DIE I '$D(Y) G REAS
REASQ K DA,DIC,DIE,DLAYGO,DR,X,Y Q
 Q
DICS S DGX=$P(DGPMAN,"^",4) I $S('$D(^DG(405.1,+DGX,0)):0,'$D(^DG(405.1,+Y,"F",+DGX)):1,1:0) S DGER=1 Q
 S DGER=0
 Q
