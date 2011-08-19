FHNO4 ; HISC/REL - Bulk Nourishments ;4/25/93  19:01
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter/Edit Bulk Nourishments
 D WRD G:'WRD KIL S DA=WRD,DR="20" D ^DIE G EN1
EN2 ; List Bulk Nourishments
 D WRD G:'WRD KIL S CT=0 W !
 F K=0:0 S K=$O(^FH(119.6,WRD,"BN",K)) Q:K<1  S X=^(K,0),X1=$P(X,"^",1),X2=$P(X,"^",2) I X1,$D(^FH(118,X1,0)) W !,$J(X2,6),"  ",$P(^(0),"^",1) S CT=CT+1
 I 'CT W !,"No Bulk Nourishment Order entered for this Ward."
 G EN2
WRD K DIC S (DIC,DIE)="^FH(119.6,",DIC(0)="AEQM",WRD=0
 S DIC("DR")=".01" W ! D ^DIC Q:U[X!$D(DTOUT)  G:Y<1 WRD S WRD=+Y Q
KIL G KILL^XUSCLEAN
