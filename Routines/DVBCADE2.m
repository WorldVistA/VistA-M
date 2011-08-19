DVBCADE2 ;ALB/GTS-557/THM-ADD C&P EXAMS TO REQUESTS, PART 2 ; 4/18/91  7:23 AM
 ;;2.7;AMIE;**1,12**;Apr 10, 1995
 ;
EXMHD W @FF,?(IOM-$L(HD2)\2),HD2,!!,"Please select the exams for ",$P(PNAM,",",2,99)," ",$P(PNAM,",",1),!,"Use ? to see a list exams available for selection.",!!
 ;
EXMSEL I $D(DVBCLCKD) Q
 S DIC("S")="I $P(^(0),U,5)'=""I""",DIC="^DVB(396.6,",DIC(0)="AEQM"
 S DIC("A")="Select EXAM: "
 K OUT D ^DIC S:$D(DTOUT) OUT=1 Q:$D(OUT)
 G:X=""!(X=U) EXMDIS ;Only out of EXMSEL
 I +Y<0 W " ??",*7 G EXMSEL
 S EXMDA=+Y,EXMNM=$P(^DVB(396.6,+Y,0),U,1)
 I $D(^TMP($J,"NEW",EXMNM)) W "    Duplicate - ignored",!,*7 G EXMSEL
 I $D(^DVB(396.4,"APS",DFN,EXMDA,"O")) W *7,"  -- already ON FILE",! G EXMSEL
 I $D(^DVB(396.4,"APS",DFN,EXMDA,"X"))!($D(^DVB(396.4,"APS",DFN,EXMDA,"RX"))) W *7,"  -- Previously cancelled,  addition allowable",!
FMT ;drop into
 S EXCNT=EXCNT+1
 G:EXCNT=1 FMT1 ;Only out of FMT
 K OUT
 S FMT="F"
 ;
 ;** FMT1 drops into from FMT or jumps into from FMT+3
FMT1 S ^TMP($J,"NEW",EXMNM)=+Y_U_$S(EXCNT=1:"F",1:FMT)_U_EXMDA K Y H 1 W @FF,!!! G EXMSEL ;1st exam is 'full'
 ;
EXMDIS K %,%Y,DIE,DIC G:$D(DVBCLCKD) EXMSEL
 I '$D(^TMP($J,"NEW")) W !!,*7,"You have not selected any exams.",!,"Do you want to try again" S %=1 D YN^DICN K OUT S:%=2 OUT=1 Q:$D(OUT)  G:%=1 EXMHD I $D(DTOUT) S OUT=1 Q
 I $D(%Y) I %Y["?" W !!,"Enter Y to select more exams or N to abort adding exams to this request.",!! G EXMDIS
 I $D(%),%'=1 S OUT=1 Q
 W @FF,!!,"You have selected:",!! S EXMNM=""
 F JY=0:1 S EXMNM=$O(^TMP($J,"NEW",EXMNM)) Q:EXMNM=""  W ?5,EXMNM,!
 S DIR(0)="YA"
 S DIR("A")=$S(JY'>1:"Is this exam",1:"Are these exams")_" correct? "
 S DIR("B")="NO"
 D ^DIR
 K DIR
 I Y K Y G EXMLOG
 I $D(DIRUT) K Y,DIROUT S OUT=1 Q
EXMOD ;drop into
 I Y=0 K DIC,DIR,Y S DIC(0)="AEQM",DIC("A")="Enter EXAM to delete: ",DIC="^DVB(396.6,",DIC("S")="I $D(^TMP($J,""NEW"",$P(^(0),U,1)))"
 ;
EXMOD1 W @FF,!!! K OUT D ^DIC
 S:$D(DTOUT) OUT=1 Q:$D(OUT)
 G:X=""!(X=U) EXMASK ;Only out of EXMOD1
 S EXMNM=$P(^DVB(396.6,+Y,0),U,1)
 I +Y>0&($D(^TMP($J,"NEW",EXMNM))) K ^TMP($J,"NEW",EXMNM) W:$X>50!($X<10) ! W "  Ok ..." S EXCNT=EXCNT-1 H 2 G EXMOD
 G EXMOD1
 ;
EXMASK K DIC
 W @FF,!!,"Want to add more exams"
 S %=1 D YN^DICN G:%=1 EXMHD ;add exams
 I $D(DTOUT) S OUT=1 Q
 I $D(%Y),%Y["?" W !!,"Enter Y to add more exams or N to go on and log existing selections." D CONTMES^DVBCUTL4 G EXMASK
 G EXMDIS
 ;
EXMLOG W !! S EXMNM="" K DR,OUT
 N DVBCLCKD
 F DVBCJ=0:0 S EXMNM=$O(^TMP($J,"NEW",EXMNM)) Q:EXMNM=""  S X=$$EXAM^DVBCUTL4 S:X=0 DVBCLCKD=1 Q:$D(DVBCLCKD)  D EXMLOG1^DVBCUTL4 Q:$D(OUT)
 I $D(DTOUT) S OUT=1 D ROLLBCK^DVBCUTL4
 Q:$D(OUT)
 W:$D(DVBCLCKD) !!,"   Another user adding exams now...try again later."
 R:$D(DVBCLCKD) !,"   PRESS [Return] TO CONTINUE...",DVBCCONT:DTIME
 I $D(DVBCLCKD) D ROLLBCK^DVBCUTL4 G EXMDIS
 I $P(^DVB(396.3,REQDA,0),U,2)'[DT S DR="23.3///NOW;23.4////"_DUZ,(DIC,DIE)="^DVB(396.3,",DA=REQDA D ^DIE ;no edit if requested today
 D ^DVBCBUL1 W !
 I '$D(OUT) S DIR("A")="Do you want to print worksheets ",DIR("A",1)="Worksheets should be sent to a printer.",DIR(0)="Y",DIR("?",1)="Enter Y to print worksheets for items just entered or",DIR("?")="N to skip." D ^DIR Q:Y=0!(Y=U)
 D ^DVBCADE1
 Q
