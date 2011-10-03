QAPRELS ;557/THM-CHANGE A SURVEY STATUS [ 05/25/95  9:02 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL
EN W @IOF,! S QAPHDR="Release/Disable a Survey for Participation" X QAPBAR W !?49,BLDON,"Type RETURN or '^' to exit",BLDOFF,!!
 K DIC,DIE,DR S DIC="^QA(748,",DIC(0)="AEQMZ",DIC("A")="Select a survey: " D ^DIC G:X=""!(X[U) EXIT S DA=+Y
 S LASTDATE=$P(Y(0),U,3)
 I LASTDATE]"",DT>LASTDATE W !!,*7,"The LAST DATE FOR USAGE is earlier than today's date.",!,"You must change it to a future date before you may release",!,"this survey.",!!,"Press RETURN  " R ANS:DTIME G:'$T EXIT G EN
 S X=$P(^QA(748,DA,0),U,4),CURSTAT=$S(X="r":"READY FOR USE",X="e":"ACTIVE LIFE EXPIRED",1:"UNDER DEVELOPMENT/MAINTENANCE")
 W !!,"Current status is ",CURSTAT,!! S QLINE=$Y
 K DIR S DIR(0)="S^r:Ready for use;d:Under development/maintenance;e:Active life expired" D ^DIR G:$D(DTOUT) EXIT I $D(DIRUT) G EN
 I Y="r" D ^QAPCHKST I '$D(X)#2 G EN
 S X=Y,DIE=DIC,DIC(0)="M",DR=".05///"_X
 D ^DIE
 G EN
 ;
EXIT G EXIT^QAPUTIL
