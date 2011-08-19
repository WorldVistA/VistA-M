ABSVE1 ;VAMC ALTOONA/CTB/CLH - VOL. FILE EDIT ;8/23/01  4:10 PM
V ;;4.0;VOLUNTARY TIMEKEEPING;**10,25**;JULY 6, 1994
OUT K %,%Y,C,D0,DDH,DG,DI,DQ,DIC,DLAYGO,DR,DA,X,Y Q
SAC ;Edit File 503332 - Voluntary Service Assignment Codes
 S (DIC,DLAYGO)=503332,DIC(0)="AEMQL",DIC("A")="Select SERVICE ASSIGNMENT CODE: " D ^DIC K DIC G:+Y<0 OUT S DA=+Y
 S DIE=503332,DR="1;2" D ^DIE K DIE W !! G SAC
SWD ;Edit File 503333 - Volunteer's Scheduled Workdays
 S (DIC,DLAYGO)=503333,DIC(0)="AELMQ",DIC("A")="Select WORK DAY SCHEDULE: " D ^DIC K DIC G:+Y<0 OUT S DA=+Y
 S DIE=503333,DR="1;2" D ^DIE K DIE W !! G SWD
OC ;Edit File 503334 - Volunteer Organization Codes
 S (DIC,DLAYGO)=503334,DIC(0)="AELMQ",DIC("A")="Select ORGANIZATION CODE: " D ^DIC K DIC G:+Y<0 OUT S DA=+Y
 S DIE=503334,DR="1;1.5;3;4" D ^DIE K DIE W !! G OC
AC ;Edit File 503337 - Voluntary Award Codes
 S (DIC,DLAYGO)=503337,DIC(0)="AELMQ",DIC("A")="Select AWARD NAME or CODE: " D ^DIC K DIC G:+Y<0 OUT S DA=+Y
 S DIE=503337,DR=".01;1;2" D ^DIE K DIE W !! G AC
SE ;Edit File 503338 - Voluntary Service Site Parameter
 S (DIC,DLAYGO)=503338,DIC(0)="AEMQL",DIC("A")="Select Voluntary Service Site Name: " D ^DIC K DIC G:+Y<0 OUT S DA=+Y
 S DIE=503338,DR="[ABSV SITE EDIT]" D ^DIE K DIE W !! G SE
SITE D ^ABSVSITE G:'% OUT
 Q
DELCOMB ;DELETE COMBINATIONS
 N %,C,D,D0,D1,DA,DI,DIC,DICR,DIE,DIG,DIH,DIU,DIV,DIW,DQ,DR,FPASS,I,N,X,Y
 D ^ABSVSITE G OUT1:'%
 S X=$E(DT,4,7) I +X<1010!(+X>1106) S X="I'm sorry, but combinations may only be deleted from October 10th through November 6th of each year to prevent loss of hours in Austin.*" D MSG^ABSVQ QUIT
 S DIC("A")="Select VOLUNTEER: "
C2 S FPASS=1,DIC=503330,DIC(0)="AEMQ"
 F  D MDIV^ABSVSITE,^DIC G OUT1:Y<0 Q:$$ACTIVE^ABSVU2(+Y,ABSV("INST"))
 K DIC S DA=+Y,ABSVX("NAME")=$P(Y,"^",2),ABSVX("VOLDA")=DA
C1 D PCOMB^ABSVE2 G OUT1:'$D(ABSVX("LIST"))
 S DIR(0)="NOA^1:6:0",DIR("A")="Select Combination Number: "
 S DIR("?")="Enter the number assigned to the Combination you wish to delete,",DIR("?",1)="Enter a combination number, or an '^' to Quit." D ^DIR K DIR
 I $$DIR^ABSVU2 S X=$S($D(FPASS):"   <No Selection Made.>*",1:"    <Updating Completed>*") D MSG^ABSVQ,OUT1 S DIC("A")="Select Next VOLUNTEER: " G C2
 I '$D(ABSVX("LIST",+Y)) S DA(1)=ABSVX("VOLDA"),X=ABSV("SITE")_"-"_X,DIC="^ABS(503330,"_DA(1)_",1,",DIC(0)="EMQL",DLAYGO=503330 D ^DIC K DIC S DA=ABSVX("VOLDA") K DA(1) G:Y<0 C1 S Y=+$P(Y,"-",2)
 S $P(Y,"^",2)=$O(^ABS(503330,DA,1,"AD",ABSV("SITE"),Y,0))
 S DA(1)=ABSVX("VOLDA"),DA=$P(Y,"^",2)
 I DA="" S X="I'm sorry but I'm a little confused, let's try that again." D MSG^ABSVQ S DA=DA(1) G C1
 S ABSVXA="ARE YOU SURE",ABSVXB="",%=2
 D ^ABSVYN I %=1 S DIK="^ABS(503330,"_DA(1)_",1," D WAIT^ABSVYN D ^DIK S X="  <Combination Deleted>*" D MSG^ABSVQ R X:1 S EDIT=""
 S DA=ABSVX("VOLDA") K DA(1),FPASS G C1
OUT1 I $D(ABSVX("EDIT")) K ABSVX("EDIT"),COMB,DAY,DIC,DI,D0,DQ,DR,DUOUT,DIE,DATE,ORG,SER,VOL,I,N,X,Y
 I $D(EDIT) D TT88^ABSVE3
 K ABSVX("NAME"),ABSVX("VOLDA"),ABSVX("LIST")
 QUIT
