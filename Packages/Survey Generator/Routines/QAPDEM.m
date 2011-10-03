QAPDEM ;557/THM-ADD SURVEY DEMOGRAPHICS [ 06/19/95  1:44 PM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 ;called by QAPEDIT
 Q  ;enter properly
 ;
EN K DIC,DIE,DR,Y,STOP
 W @IOF,! S QAPHDR="Subject: "_SUBJ X QAPBAR
 S QAPHDR="Add/Edit Demographic Questions" X QAPBAR
 ;
DATA I $O(^QA(748.3,"B",SURVEY,0))]"" W *7,!!,"This survey has data associated with it and the demographic content",!,"may not be changed.",!!,"Press RETURN  " R ANS:DTIME S:'$T STOP=1 G EXIT
 W !
 S X=SUBJ,(DIE,DIC)="^QA(748,",DIC(0)="QLM" D ^DIC S DA=+Y G:Y<0!($D(DTOUT)) EXIT
 S DR=".01;1;I X=""s"" S Y=""@1"";I X=""p"" S Y=""@2"";S Y=""@99"";@1;3;S Y=""@99"";@2;2;@99;4",DR(3,748.33)=".01:1"
 ;add to subfile
 W ! S DA(1)=+Y,DIC=DIC_DA(1)_",1,",DIC(0)="QAELM",DIC("P")=$P(^DD(748,3,0),U,2) D ^DIC I Y=-1 K DIC,DA G EXIT
 S DIE=DIC S DA=+Y K DIC W !! D ^DIE G:$D(Y) EN I $D(DTOUT) S STOP=1 G EXIT
 X CLEOP K FIND F DEMQUES=0:0 S DEMQUES=$O(^QA(748,SURVEY,1,DEMQUES)) Q:DEMQUES=""!(+DEMQUES=0)!($D(STOP))  S DEMDTA=^QA(748,SURVEY,1,DEMQUES,0) K STOP DO  Q:$D(STOP)
 .I $P(DEMDTA,U,2)="p",$P(DEMDTA,U,3)="" W !,*7,"You have entered a pointer type in question ",DEMQUES," and",!,"have not specified any file.",! S FIND=1
 .I $P(DEMDTA,U,2)="s",$O(^QA(748,SURVEY,1,DEMQUES,0))="" W !,*7,"You have entered a 'set of codes' type in question ",DEMQUES,!,"and not entered any codes.",! S FIND=1
 I $D(FIND) W !,"Press RETURN  " R ANS:DTIME I '$T S STOP=1 Q
 I '$D(STOP) G EN
 ;
EXIT Q  ;kill variables in calling program
