QAPPART ;557/THM-COUNT NUMBER OF SURVEY PARTICIPANTS [ 02/16/95   8:26 AM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL
EN W @IOF,! S QAPHDR="Count Survey Participants" X QAPBAR
 K DIC S DIC("S")="I $P(^(0),U,5)=DUZ!($D(^XUSEC(""QAP MANAGER"",DUZ)))!($D(^QA(748,""AB"",DUZ,+Y)))"
 S DIC="^QA(748,",DIC(0)="AEQMZ",DIC("A")="Select survey: " W ! D ^DIC G:X=""!(X[U) EXIT S SURVEY=+Y,SUBJ=Y(0,0) K DIC("S")
 S (ICNT,SCNT,CCNT)=0
 F X=0:0 S X=$O(^QA(748.3,"B",SURVEY,X)) Q:X=""  DO
 .I $P(^QA(748.3,X,0),U,3)="c" S CCNT=CCNT+1
 .I $P(^QA(748.3,X,0),U,3)="s" S SCNT=SCNT+1
 .I $P(^QA(748.3,X,0),U,3)="i" S ICNT=ICNT+1
 S QLINE=3 X CLEOP1 W !!,"Survey: ",SUBJ,!
 I CCNT=0 S CCNT="no"
 I SCNT=0 S SCNT="no"
 I ICNT=0 S ICNT="no"
 W !!,"Currently, there ",$S(CCNT=1:"is",1:"are")," ",CCNT," completed ",$S(CCNT=1:"response",1:"responses"),".",!
 W ?17,$S(SCNT=1:"is ",1:"are "),SCNT," suspended ",$S(SCNT=1:"response",1:"responses"),".",!
 W ?17,$S(ICNT=1:"is ",1:"are "),ICNT," ",$S(ICNT=1:"response",1:"responses")," in progress.",!
 W !!,"Press RETURN to continue  " R ANS:DTIME I $T G EN
 ;
EXIT G EXIT^QAPUTIL
