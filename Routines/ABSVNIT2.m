ABSVNIT2 ;VAMC ALTOONA/CTB_CLH - TRANSFER TEMP LOG CON'T ;2/11/98  11:29 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;**3,6,7**;JULY 6, 1994
 ;
LUN(LUN) ;SETS TO MEAL TICKET FILE.
 N X,Y,DA,DIC,DA,DIK,NOW
 S X=$P($G(^ABS(503330,ABSVX("VOLDA"),0)),"^",2)
 I '$D(ABSVX("NAME")) S ABSVX("NAME")=$P($G(^ABS(503330,ABSVX("VOLDA"),0)),"^",1)
 S:X="" X=ABSVX("VOLDA")
 S DIC="^ABS(503330.2,",DIC(0)="MN",DIC("S")="I $P(^(0),U,4)=+DT,$P(^(0),U,2)=ABSV(""SITE""),$P(^(0),U,6)=ABSVX(""NAME"")" D ^DIC K DIC S DA=+Y
 I LUN=0,DA>0 S X=$G(^ABS(503330.2,DA,0)) Q:X=""  D  QUIT
 . I $P(X,"^",5)]"" QUIT
 . I $P(X,"^",3)]"" K ^ABS(503330.2,"AD",$P(X,"^",3),DA)
 . S ^ABS(503330.2,"AD",0,DA)="",$P(^ABS(503330.2,DA,0),"^",3)=0
 . QUIT
 QUIT:'LUN
 I DA<1 S DIC="^ABS(503330.2,",DIC(0)="LMN",X=ABSVX("VOLDA"),DIC("DR")="1////"_ABSV("SITE")_";1.5////"_ABSVX("NAME")_";2////1;3////"_+DT D FILE^DICN K DIC S DA=+Y
 Q:DA<1
 S $P(^ABS(503330.2,DA,0),"^",2)=ABSV("SITE"),$P(^(0),"^",3)=LUN,$P(^(0),"^",4)=+DT,$P(^(0),"^",6)=$G(ABSVX("NAME")),^ABS(503330.2,"AC",+DT,DA)="",^ABS(503330.2,"AD",LUN,DA)="",LUNCH=1
 I $P(ABSV("PARAM"),"^",12)=1 D
  . I $P(^ABS(503330.2,DA,0),"^",5)="" D X^ABSVMT(ABSVX("NAME")) D NOW^ABSVQ S NOW=%,$P(^ABS(503330.2,DA,0),"^",5)=NOW QUIT
  . S X="!"_$$GET^ABSVU1("MEAL TICKET PRINTED ALREADY",$S($D(PLANG):PLANG,1:1))_"*" D MSG^ABSVQ
 Q
EDL ;DELETE MEAL TICKET ENTRY FOR TODAY.
 D ^ABSVSITE G:'% OUT
E1 S DIC="^ABS(503330.2,",DIC(0)="AEMNQ",DIC("S")="I $P(^(0),U,4)=+DT,$P(^(0),U,2)=ABSV(""SITE"")"
 I '$D(DIC("A")) S DIC("A")="Select VOLUNTEER: "
 D MDIV^ABSVSITE,^DIC K DIC G OUT:+Y<0  S DA=+Y
 S ABSVXA="OK to delete meal ticket for "_$$FULLDAT^ABSVU2(DT)_" for "_$P($G(^ABS(503330,+$P(Y,"^",2),0)),"^"),ABSVXB="",%=1 D ^ABSVYN
 S ABSVXA=% I %'=1 S X="  <No action taken>*" D MSG^ABSVQ
 G:ABSVXA<0 OUT
 I ABSVXA=1 D
 . S DIK="^ABS(503330.2," D ^DIK K DIK,DA
 . S X="  <Entry Deleted>*" D MSG^ABSVQ
 . QUIT
 D E2 G E1
E2 S DIC("A")="Select Next Volunteer: " Q
ADD ;ADD A NEW ENTRY
 D ^ABSVSITE G:'% OUT
A1 I '$D(DIC("A")) S DIC("A")="Select VOLUNTEER: "
 S DIC=503330,DIC(0)="AMNQE"
 F  D MDIV^ABSVSITE,^DIC G OUT:+Y<0 Q:$$ACTIVE^ABSVU2(+Y,ABSV("INST"))
 K DIC G:+Y<0 OUT
 I '$D(^ABS(503330,+Y,4,ABSV("INST"),0)) S X="This Volunteer is not currently registered as an active volunteer for Station "_ABSV("SITE")_".  <No Action Taken>*" D MSG^ABSVQ,A2 G A1
 S ABSVX("VOLDA")=+Y,ABSVX("SSN")=$P(^ABS(503330,+Y,0),"^",2),ABSVX("NAME")=$P(^(0),"^",1)
 I ABSVX("NAME")="UNSCHEDULED,VOLUNTEER" D UNSCHED I $G(X)="ABORT" K X QUIT
 S DIC="^ABS(503330.2,",DIC(0)="M",X=$S(ABSVX("SSN")]"":ABSVX("SSN"),1:ABSVX("NAME"))
 S DIC("S")="I $P(^(0),U,2)=ABSV(""SITE""),$P(^(0),U,4)=+DT,$P(^(0),U,6)=ABSVX(""NAME"")"
 D ^DIC S DA=+Y K DIC
 I +Y<0 D LUN(1)
 I $P(ABSV("PARAM"),"^",12)=1,$P($G(^ABS(503330.2,DA,0)),"^",5)]"" D ASK W !
 S X="   ---    Finished   ---*" D MSG^ABSVQ
 D A2 G A1
UNSCHED S DIR("A")="Select Unscheduled Volunteer Name: ",DIR(0)="FAU^3:30^S X=$$UPPER^ABSVU2(X) W ""  "",X K:X'?1.A1"","".A X"
 S DIR("?")="Enter a name in the format LAST,FIRST. " D ^DIR I $$DIR^ABSVU2 S X="ABORT" QUIT
 S ABSVXA="OK to add "_X_" to the list",ABSVXB="",%=1 W ! D ^ABSVYN
 I %<0 S X="ABORT" QUIT
 I %=1 S ABSVX("NAME")=Y K X QUIT
 W !! G UNSCHED
A2 S DIC("A")="Add next VOLUNTEER:" Q
ASK S ABSVXA="A meal ticket has already been printed for this volunteer for today.",ABSVXA(1)="OK TO REPRINT",ABSVXB="" D ^ABSVYN
 I %'=1 S X="  <No action taken>*" D MSG^ABSVQ QUIT
 D X^ABSVMT(ABSVX("NAME"),1)
 QUIT
OUT K %,%W,%X,%Y,%Y1,ABSVX("VOLDA"),ABSVX("NAME"),ABSVX("SSN"),ABSVXA,C,D0,DA,DDH,DI,DIC,DIE,DQ,DR,I,X,Y,DA Q
