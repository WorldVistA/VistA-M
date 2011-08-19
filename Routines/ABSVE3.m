ABSVE3 ;VAMC ALTOONA/CTB/CLH  EDIT VOLUNTARY SERVICE DATA ;8/28/95  2:42 PM
V ;;4.0;VOLUNTARY TIMEKEEPING;**6**;JULY 6, 1994
AWARD ;ENTER AWARD/HOUR INFORMATION
 N %W,%Y,C,D,D0,ABSVX,DI,DIC,Y,%,DA,DIE,DR,DQ,I,N,X,TRANS
 D ^ABSVSITE G OUT:'%
A1 S DIC=503330,DIC(0)="AEMQ",DIC("A")="Select VOLUNTEER NAME: "
 D MDIV^ABSVSITE,^DIC K DIC G OUT:Y<0
 S DA=+Y,ABSVX("NAME")=$P(Y,"^",2),ABSVX("VOLDA")=DA
 G A1:'$$ACTIVE^ABSVU2(DA,ABSV("INST"))
 S DA(1)=ABSVX("VOLDA"),DIE="^ABS(503330,"_DA(1)_",4,",DR="14///@;15///@;16///@;17///@;Q;14;15;16;17",DA=ABSV("INST") D ^DIE S DA=DA(1) K DA(1)
 S ABSVXA="Should this change in AWARD/HOUR information be transmitted to Austin",ABSVXB="",%=1
 D ^ABSVYN
 I %<1 S X="OPTION TERMINATED, NO ACTION TAKEN*" D MSG^ABSVQ G OUT
 S TRANS=1
 I %=2 S TRANS=0
 S DA(1)=ABSVX("VOLDA"),DIE="^ABS(503330,"_DA(1)_",4,",DR="12////"_TRANS,DA=ABSV("INST") D ^DIE S DA=DA(1) K DA(1)
 S X="HOURS/AWARD information has "_$S(TRANS:"",1:"NOT ")_"been marked for transmission" D MSG^ABSVQ W !!
 G A1
 ;
COMB ;EDIT COMBINATIONS
 ;N %,%W,%Y,ABSVX,C,D,D0,D1,DA,DI,DIC,DICR,DIE,DIH,DIR,DIU,DIV,DIW,DQ,DR,FPASS,I,N,X,Y
 D ^ABSVSITE G OUT:'%
 S DIC("A")="Select VOLUNTEER: "
C2 S FPASS="",DIC=503330,DIC(0)="AEMQ" D MDIV^ABSVSITE,^DIC
 K DIC G OUT:Y<0 S DA=+Y,ABSVX("NAME")=$P(Y,"^",2),ABSVX("VOLDA")=DA
 D:$$ACTIVE^ABSVU2(DA,ABSV("INST")) C1 S DIC("A")="Select Next VOLUNTEER: " G C2
C1 D PCOMB^ABSVE2
 S DIR(0)="NOA^1:6:0",DIR("A")="Select Combination Number: "
 S DIR("?")="Enter a combination number (1-6), or an '^' to Quit."
 S DIR("?",1)="Enter the number assigned to the Combination you wish to select, OR"
 S DIR("?",2)="  you may enter a new Combination by selecting a number from 1 to 6,",DIR("?",3)="  which does not exist on the above list." D ^DIR K DIR
 I $$DIR^ABSVU2 D  QUIT
 . S X=$S($D(FPASS):"   <No Selection Made.>*",1:"   <Updating Completed>*")
 . D MSG^ABSVQ,OUT
 . QUIT
 I '$D(ABSVX("LIST",+Y)) D  G:Y<0 C1
 . S DA(1)=ABSVX("VOLDA"),X=ABSV("SITE")_"-"_X
 . S:$P($G(^ABS(503330,DA(1),1,0)),"^",2)="" $P(^(0),"^",2)="503330.03I"
 . S DIC="^ABS(503330,"_DA(1)_",1,",DIC(0)="EMQL",DLAYGO=503330
 . D ^DIC K DIC S DA=ABSVX("VOLDA") K DA(1) Q:Y<0  S Y=+$P(Y,"-",2)
 . QUIT
 S $P(Y,"^",2)=$O(^ABS(503330,DA,1,"AD",ABSV("SITE"),Y,0))
 S DA(1)=ABSVX("VOLDA"),DA=$P(Y,"^",2)
 I DA="" S X="I'm sorry but I'm a little confused, let's try that again." D MSG^ABSVQ S DA=DA(1) G C1
 S DIE="^ABS(503330,"_DA(1)_",1,",DR="1;2;3" D ^DIE
 S X=$P($G(^ABS(503330,DA(1),1,DA,0)),"^",5)
 I X]"" W !!,"Edited Combination: ",X,!!
 S DA=ABSVX("VOLDA") K DA(1) S EDIT=1 K FPASS
 G C1
 ;
TT88 I $D(EDIT) K EDIT D
 . S ABSVXA="Do you need to transmit this record to Austin",ABSVXB="",%=1 D ^ABSVYN
 . I %'=1 S X="<  No Action Taken>*" D MSG^ABSVQ Q
 . I %=1 S DA(1)=ABSVX("VOLDA"),DA=ABSV("INST"),DR="11////1;13Is this volunteer currently on the Austin system?",DIE="^ABS(503330,"_DA(1)_",4," D ^DIE W "   RECORD MARKED"
 . QUIT
 I $D(EDIT1) K EDIT1 S ABSVXA="Do you wish to send the station hours and awards information to Austin",ABSVXB="",%=1 D ^ABSVYN
 I %=1 S DA(1)=ABSVX("VOLDA"),DA=ABSV("INST"),DR="12////1",DIE="^ABS(503330,"_DA(1)_",4," D ^DIE W "   RECORD MARKED"
 QUIT
 ;
OUT I $D(EDIT)!($D(EDIT1)) D TT88
 I $D(ABSVX("EDIT")) K ABSVX("EDIT"),ABSVOUT,C,COMB,DAY,DIC,DI,D0,DDH,DQ,DR,DUOUT,DIE,DATE,ORG,SER,VOL,I,N,X,Y Q
 K ABSVOUT,ABSVX,C,COMB,DDH,DAY,DIC,DI,D0,DQ,DR,DUOUT,DIE,DATE,ORG,DA,SER,VOL,I,N,X,Y Q
