QAPEDINC ;557/THM-EDIT AN INCOMPLETE SURVEY [ 05/31/95  1:32 PM ] ;10/27/95  09:39
 ;;2.0;Survey Generator;**3**;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL
EN W @IOF,! S QAPHDR="Edit an Incomplete Survey" X QAPBAR
 W !!,"This option will allow you to edit the answers you have entered on a survey",!,"so far.  You must use the 'Participate in a Survey' option to finish it.",!!
 S DIC="^QA(748,",DIC(0)="AEQMZ" D ^DIC G:X=""!(X[U) EXIT  S SURVEY=+Y
 K DIR S DIR(0)="Y",DIR("A")="Is this the correct survey" D ^DIR G:X[U!($D(DIRUT)) EXIT I Y=0 G EN
 S SVSTAT=$P(^QA(748,SURVEY,0),U,4) I SVSTAT'="r" W *7,!!,"This survey is not available for selection at this time.  Its current",!,"status is ",$S(SVSTAT="d":"Under Maintenance/Development",1:"Active Life Expired"),".",!! H 3 G EN
 ;read index backwards to get last response to see if suspended
 S X="`"_DUZ D HASH^XUSHSHP S USER=X,FILEDA=$O(^QA(748.3,"AC",USER,SURVEY,"zz"),-1) I FILEDA="" W *7,!!,"You do not have a response on file for this survey.",!! H 3 G EN
 I $P(^QA(748.3,FILEDA,0),U,3)'="s" W *7,!!,"Your response does not have a suspended status.  You may not",!,"edit the answers.",!! H 3 G EXIT
 S QNUMANS=$P($G(^QA(748.3,FILEDA,0)),U,4) ;number of questions answered
 I +QNUMANS=0 S QLINE=4 X CLEOP1 W !!,*7,"You have not answered any questions on this survey.",!!,"Please use the 'Participate in a Survey' option",!,"instead of this one.",!!,"Press RETURN  " R ANS:DTIME G EXIT
 S DMANMSTR=$P(Y(0),U,8) ;are ALL demographics required?
 D ^QAPEDI1
 ;
EXIT G EXIT^QAPUTIL
