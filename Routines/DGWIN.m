DGWIN ;ALB/JDS - WARD BED STATUS INITIALIZATION ; 13 JAN 84  09:58
 ;;5.3;Registration;**85,161**;Aug 13, 1993
 ;
DGEGL S DGEGL=+^DG(43,1,"G")\1 I DGEGL'?7N W !!,"I cannot run this program until you specify an early date",!,"to run the G&L in the site parameters.",!!,*7,*7 G Q
 S X1=DGEGL,X2=-1 D C^%DTC S DGEGL=X
 W !!,$$FMTE^XLFDT(DGEGL,"5DZ")," is the date to be initialized.",!!
WARD W ! S DIC="^DIC(42,",DIC(0)="AEQMZ" D ^DIC G Q:+Y'>0 S DFN=+Y S DIE=DIC,DA=+Y,DR="[DGWIN]" D ^DIE G WARD
 ;
 ;
Q K DGEGL,DIC,DIE,DA,DFN,DR,DP Q
SCREEN S %=$P(^DIC(42,DA,0),U,3) I %]"",$O(^DG(41.9,DA,"C",0)),%'=X K X W !,"Cannot change service after Census totals exist",!
