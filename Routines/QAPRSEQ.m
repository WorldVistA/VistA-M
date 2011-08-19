QAPRSEQ ;557/THM-RESEQUENCE SURVEY QUESTION ORDER [ 05/18/95  7:42 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 Q  ;enter properly
EN1 X CLEOP1 I $O(^QA(748.25,"E",SURVEY,0))="" W !!,*7,"There are no questions to resequence  " H 2 G EXIT
 W !!,"What increment would you like to use?  1//  " R INCREM:DTIME G:'$T!(INCREM[U) EXIT
 S:INCREM="" INCREM=1 I INCREM<1!(INCREM>10) W !!,*7,"Enter the value to skip between question numbers (1-10).",!! H 2 G EN1
 I INCREM'?1.2N W !!,*7,"The increment must be 1-2 numbers, without decimals.",!! H 2 G EN1 ;force non-decimal numbers for resequencing
 W @IOF,! X QAPBAR W !!,"Selected parameters:",!!!,"Survey name: ",SVYNAME,!?2,"Increment: ",INCREM,!! K DIR S DIR("A")="Is this Ok",DIR("B")="NO",DIR(0)="Y" D ^DIR G:Y'=1 EN1
 ;
RGO K ^TMP($J) S NINCREM=0 W !!
 ;write to ^TMP($J to avoid editing problems when index changes
 F QAPQN=0:0 S QAPQN=$O(^QA(748.25,"E",SURVEY,QAPQN)) Q:QAPQN=""  F DA=0:0 S DA=$O(^QA(748.25,"E",SURVEY,QAPQN,DA)) Q:DA=""   S ^TMP($J,SURVEY,QAPQN,DA)=""
 F QAPQN=0:0 S QAPQN=$O(^TMP($J,SURVEY,QAPQN)) Q:QAPQN=""  F DA=0:0 S DA=$O(^TMP($J,SURVEY,QAPQN,DA)) Q:DA=""  DO 
 .S NINCREM=INCREM+NINCREM
 .S DR=".015////"_NINCREM,DA(1)=SURVEY,(DIC,DIE)="^QA(748.25,DA(1),1," D ^DIE W "."
 ;
EXIT I $D(EDIT) K EDIT Q
 Q
 ;
R1 S EDIT=1 N DIC,DIE,DR,QAPQN,INCREM,DA
 W @IOF,! S QAPHDR="Resequence Survey Question Numbers" X QAPBAR
 S SVYNAME=$P(^QA(748,SURVEY,0),U,1)
 S QLINE=$Y D EN1 K DANS F I=0:0 S I=$O(^QA(748.25,"E",SURVEY,I)) Q:I=""  F J=0:0 S J=$O(^QA(748.25,"E",SURVEY,I,J)) Q:J=""  S DANS(I,J)=I,DANS(I)=I,LSTNUM=I
  K SVYNAME Q  ;kill variables in calling program
