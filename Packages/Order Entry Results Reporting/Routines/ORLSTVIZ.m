ORLSTVIZ ; SLC/WAT - Editing Team List Visibility ;9/14/06 14:00
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243**;Dec 17, 1997;Build 242
 ;
 ;PROMPT THE USER FOR A LIST OR LISTS FOR WHICH TO SET VISIBILITY
 ;SHOW THE POSSIBLE OPTIONS FOR VISIBILITY:
 ;       '0' = NOBODY
 ;       '1' = ALLUSERS
 ;DIC,DIR,DIE - FileMan call
 ;                 DA - input variable to ^DIE - internal entry number of the file entry to be edited
 ;                 DR - input variable to ^DIE - as used here it's the field number in file stuffed with user-chosen VISBILITY value
 ;          DTOUT - output from ^DIC-only defined when DIC times out
 ;          DUOUT - output from ^DIC-only defined when user enters carat
 ;          DIRUT - output from ^DIR-defined when user enters carat, presses Return/Enter, or times out
 ;          Y - Returned from FM call-returns "-1" is lookup was unsuccessful
 ;       Y(0) - Returned from ^DIC-hold external value of chosen VISIBILITY by user
 ;        IEN - IEN of list from 100.21
 ;        VIS - VISIBILITY value from 100.21
 ;        CNT - counter/array index position
 ;       LIST - NAME value from 100.21
 ;        VIS - VISIBILITY value from 100.21
 N DIC,DIR,DIE,DA,DR,DTOUT,DUOUT,DIRUT,Y,LIST,VIS,CNT,IEN,VAL
 K ^TMP("ORLST",$J)
 S DIC="^OR(100.21,",DIC(0)="AEQZ",CNT=0
 W !,"You may set the VISIBILITY for one or more lists."
 W !,"Please enter your selection(s) below."
LKUP F  D ^DIC Q:$D(DTOUT)!($D(DUOUT))!(Y=-1)  I Y>0 S ^TMP("ORLST",$J,CNT)=$P(Y,U,1) S ^TMP("ORLST",$J,CNT,CNT+1)=$P(Y,U,2) S ^TMP("ORLST",$J,CNT,CNT+1,CNT+2)=$$GET1^DIQ(100.21,^TMP("ORLST",$J,0),11) S CNT=CNT+1
 Q:$D(DTOUT)!($D(DUOUT))
 Q:'$D(^TMP("ORLST",$J,0))
 ;*********For each selected list(s), display current NAME and VISIBILITY*******
 W !!,"You have chosen to update the following list(s):"
 S (IEN,LIST,VIS)=""
 F  S IEN=$O(^TMP("ORLST",$J,IEN)) Q:IEN=""  D
 . S LIST=$O(^TMP("ORLST",$J,IEN,LIST)) Q:LIST=""  W !?5,^TMP("ORLST",$J,IEN,LIST) D
 . .S VIS=$O(^TMP("ORLST",$J,IEN,LIST,VIS)) Q:VIS=""  W ?37,"Current value: "_^TMP("ORLST",$J,IEN,LIST,VIS)
 W !!,""
 ;
READER S DIR(0)="100.21,11",DIR("B")="ALLUSERS"
 D ^DIR Q:$D(DIRUT)
 ;
 S VAL=Y(0)  ;capture user-selected VISIBILTY value
EDIT S IEN="",DIE=DIC,DR="11///^S X=VAL" ; 11 is VISIBILITY field in 100.21
 F  S IEN=$O(^TMP("ORLST",$J,IEN)) Q:IEN=""  D
 .S DA=^TMP("ORLST",$J,IEN)
 .D ^DIE
 K ^TMP("ORLST",$J)
 W @IOF
 W !!,"Update Complete"
 Q
