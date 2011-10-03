ABSVTED4 ;VAMC ALTOONA/CTB - AWARD CODE LOOPING PROGRAM ;4/13/94  11:34 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;;JULY 6, 1994
LOOP ;LOOPS THROUGH TIME CARDS FOR 1 MONTH AND ONE STATION NUMBER TO
 ;ALLOW EDITING OF AWARD CODES.  ALLOWS EDITING OF ONLY FIRST CARD
 ;FOR A PARTICULAR VOLUNTEER IN A MONTH.
 NEW %,%DT,%W,%Y,ABSVX,C,D,D0,DA,DATE,DI,DIC,DIE,DIR,DQ,DR,DTOUT,DUOUT,DIRUT,DIROUT,I,MONTH,N,NAME,POP,REC,SSN,START,VOLDA,X,Y
 D ^ABSVSITE Q:'%
 S %DT="AEQ",%DT("A")="Select Month: " D ^%DT Q:Y<0
 S DATE=+Y,MONTH=$E(DATE,1,5)_"00"
 I '$D(^ABS(503335,"AK",MONTH)) S X="There are no time cards on file for "_$$FULLDAT^ABSVU2(MONTH)_".  Are you sure you have run the ROLL UP Option?  NO further action taken." D MSG^ABSVQ QUIT
 W !!
 S X="This option will select only the FIRST card for each volunteer for the month you select.  Cards 2 thru 6, if they exist are skipped intentionally to prevent rejects in Austin." D MSG^ABSVQ
 W !! S X="You may enter an '^' at any point to stop." D MSG^ABSVQ W !!
DIR S DIR(0)="FAO^1:30^K:X'?.A X",DIR("A")="BEGIN LOOPING WITH VOLUNTEER: FIRST// ",DIR("?")="Enter from 1 to 30 letters, numeric and punctuation prohibited."
 D ^DIR K DIRUT
 I +($D(DTOUT)_$D(DUOUT)_$D(DIRUT)_$D(DIROUT)) QUIT
 I Y="" S Y="A"
 S START=$$UPPER^ABSVU2(Y)
 K ^TMP("ABSVAWARD",$J),^TMP("ABSVLIST",$J)
 D WAIT^ABSVYN
 S DA=0 F  S DA=$O(^ABS(503335,"AK",MONTH,DA)) Q:'DA  S REC=^ABS(503335,DA,0) I $P(REC,"^",12)=ABSV("SITE"),+$P(REC,"^",6)=1 D
 . S VOLDA=+REC,X=$G(^ABS(503330,VOLDA,0)),NAME=$P(X,"^"),SSN=$P(X,"^",2) Q:NAME=""
 . I '$D(^TMP("ABSVLIST",$J,VOLDA)) S ^TMP("ABSVAWARD",$J,NAME,DA)=SSN,^TMP("ABSVLIST",$J,VOLDA)=""
 . QUIT
 I $D(^TMP("ABSVAWARD",$J))<10 S X="There are no time cards on file for "_$$FULLDAT^ABSVU2(MONTH)_" for Station "_ABSV("SITE")_".  Are you sure you have run the ROLL UP Option?  No further action taken." D MSG^ABSVQ G OUT
 D WAIT^ABSVYN
 W !!
 S DA=0,NAME=START,DR="37AWARD CODE~d",DIE="^ABS(503335,"
 F  S NAME=$O(^TMP("ABSVAWARD",$J,NAME)) Q:NAME=""  D  I $D(DTOUT) G OUT
 . S DA=0 F  S DA=$O(^TMP("ABSVAWARD",$J,NAME,DA)) Q:'DA  D  Q:$D(DTOUT)
 . . W !!,NAME,"   ",$$EXTSSN^ABSVU2(^TMP("ABSVAWARD",$J,NAME,DA)) D ^DIE
 . . Q:$D(DTOUT)
 . . I $D(Y)>9!($D(DUOUT)) S DTOUT="" K DUOUT Q
 . . QUIT
 . QUIT
 QUIT
 ;
OUT K ^TMP("ABSVAWARD",$J),^TMP("ABSVLIST",$J)
