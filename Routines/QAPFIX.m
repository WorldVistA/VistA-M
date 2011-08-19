QAPFIX ;557/THM-FIX A HUNG SURVEY RESPONSE [ 03/13/95  7:03 PM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 D DT^DICRW S IOP="HOME" D ^%ZIS
 D SCREEN^QAPUTIL
EN S QAPHDR="Fix a Survey Response" W @IOF,! X QAPBAR
 W !!,"This option fixes a participant's survey response that may still",!,"show as ""in progress"" due to having exited abnormally or the job",!,"having been killed.",!!
 S DIC=748,DIC(0)="QEAM",DIC("A")="Select SURVEY: " D ^DIC G:X=""!($D(DTOUT))!(X[U) EXIT
 K DIC S SURVEY=+Y,SNAME=$P(^QA(748,SURVEY,0),U,1) H 1
 ;
SEL K QLINE S QAPHDR="Fix Response for "_SNAME W @IOF,! X QAPBAR W !!
 S DIC("A")="Select RESPONDANT: ",DIC=200,DIC(0)="QEAM" D ^DIC G:X=""!($D(DTOUT))!(X[U) EXIT
 K DIC S (USER,X)=+Y D HASH^XUSHSHP S QAPUSER=X
 W @IOF,! X QAPBAR W !!,"Survey: ",SNAME,!,"Respondant: ",$P(^VA(200,USER,0),U,1),!! S QLINE=$Y-1
CORR W "Is everything correct" S %=2 D YN^DICN G:$D(DTOUT) EXIT
 I $D(%Y),%Y["?" W !!,"Enter Y if the correct person or N if not.  " H 3 X CLEOP1 G CORR
 I $D(%),%'=1 G EN
 ;read backwards to get last participation record
 S DA=$O(^QA(748.3,"AC",QAPUSER,SURVEY,"zz"),-1) I DA="" W *7,!!,"No response found for this participant.",!! H 3 G SEL
 I $P(^QA(748.3,DA,0),U,3)'="i" W !!,"There is no response on file for this participant which",!,"needs to be fixed.",!!,*7,"Press RETURN  " R ANS:DTIME G:'$T EXIT G SEL
 ;
FIX S (QAPCNT,CQUES)=+$P($G(^QA(748.3,DA,1,0)),U,4) ;read global for count
 S (DIC,DIE)="^QA(748.3,",DR="3////s;4////"_QAPCNT_";5////"_CQUES D ^DIE W !!,"Response fixed." H 1 G EN
 ;
EXIT K USER,QAPUSER,SNAME G EXIT^QAPUTIL
