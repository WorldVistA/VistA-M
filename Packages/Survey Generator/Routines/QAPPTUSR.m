QAPPTUSR ;557/THM-PRINT HARD COPY FOR USERS [ 06/13/96  3:34 PM ]
 ;;2.0;Survey Generator;**5**;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL
EN K USERPRT W @IOF,! S QAPHDR="Print a Survey Hardcopy" X QAPBAR S QAPHDR="Survey Selection" X QAPBAR
 W !!,"This program allows you to print a hardcopy of a survey for your",!,"review ",BLDON,"before",BLDOFF," you actually participate in it.",!!,"It will not print answers you have previously made to this or",!,"other surveys.",!!
 K DIC S DIC="^QA(748,",DIC(0)="AEQMZ",DIC("A")="Select a survey: " D ^DIC K DIC G:X=""!(X[U) EXIT^QAPPT1
 S SURVEY=+Y,STATUS=$P(^QA(748,SURVEY,0),U,4),TITLE=$P(^(0),U,6),ACTION="F"
 I STATUS'="r" W !!,*7,"This survey cannot be printed now.  Its status is ",BLDON,$S(STATUS="d":"Under development",1:"Active life expired"),BLDOFF,".",!!,"Press RETURN  " R ANS:DTIME G:'$T EXIT^QAPPT1 G EN
 W @IOF,! S QAPHDR="Printing Survey Title: "_TITLE X QAPBAR
 S %ZIS="AEQ",%ZIS("A")="Output device: " D ^%ZIS G:POP EXIT^QAPPT1
 I $D(IO("Q")) S ZTREQ="@",ZTIO=ION,ZTRTN="PRINT^QAPPT1",ZTDESC="Print "_TITLE_" Survey" F X="SURVEY","TITLE","ACTION" S ZTSAVE(X)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Queued as task #",ZTSK,!! H 2 K ZTSK G EXIT^QAPPT1
 G ^QAPPT1
