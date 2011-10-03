ABSVE0 ;VAMC ALTOONA/CTB&CLH - MASTER RECORD EDIT ;6/19/98  8:35 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;**6,7,10**;JULY 6, 1994
MASTER ;ADD/EDIT MASTER FILE DATA
 N %,%DT,%X,%Y,D,D1,DDH,DICR,DIG,DIH,DIU,DIV,DIW,DLAYGO,DZ,NEWREC,REACTIVE
 D ^ABSVSITE G OUT^ABSVE3:'%
M2 K EDIT
 S DIC=503330,DIC(0)="AEMLQ",DLAYGO=503330
 S DIC("A")="Select Volunteer Name: "
 D MDIV^ABSVSITE,^DIC K DIC G OUT^ABSVE3:Y<0 S ABSVX("VOLDA")=+Y,DA=+Y,ABSVX("NAME")=$P(Y,"^",2),NEWREC=$P(Y,"^",3)
 I NEWREC D
 . S EDIT=1,^ABS(503330,DA,4,0)="^503330.01P^"_ABSV("INST")_"^1",^(ABSV("INST"),0)=ABSV("INST"),^ABS(503330,DA,4,"B",ABSV("INST"),ABSV("INST"))="",^ABS(503330,DA,1,0)="^503330.03I^"
 . S DIK="^ABS(503330," D IX1^DIK
 . QUIT
 I '$D(^ABS(503330,DA,4,0)) S ^(0)="^503330.01P^"
 I '$D(^ABS(503330,DA,4,ABSV("INST"))),'NEWREC D  I %'=1 S X="<"_$S(%<0:"Option Terminated - ",1:"")_"No Further Action Can Be Taken>*" D MSG^ABSVQ,OUT^ABSVE3 G M1
 . S ABSVXA="This Volunteer is not currently registered as an active",ABSVXA(1)="volunteer for Station "_ABSV("SITE")_".",ABSVXA(2)="Do you wish to Register this person NOW",ABSVXB="",%=1
 . D ^ABSVYN W !
 . I %'=1 QUIT
 . S DA(1)=DA,DIC="^ABS(503330,"_DA(1)_",4,",DIC(0)="MNL",DLAYGO=503330,X=ABSV("SITENAME")
 . D ^DIC K DIC
 . I Y<0 S %=0 QUIT
 . S EDIT=1,%=1 QUIT
 I $D(^ABS(503330,DA,4,ABSV("INST"),0)),$P(^(0),"^",8)]"" D  I %'=1 G REACT:$D(REACTIVE) D OUT^ABSVE3 G M1
 . S ABSVXA="Selected Volunteer has been marked as TERMINATED.  ",ABSVXA(2)="Do you wish to REACTIVATE this volunteer",ABSVXA(1)="NO Editing is allowed until this volunteer has been reactivated."
 . S ABSVXB="",%=1 D ^ABSVYN
 . I %=1 D REACTIVE S %=1,EDIT=1,REACTIVE=1 QUIT
 . S X="  Not Reactivated.  No further editing.*" D MSG^ABSVQ S %=2
 . QUIT
 L +^ABS(503330,ABSVX("VOLDA")):5 I '$T S X="I'm sorry, but this master record is being edited by someone else.  Please try later.*" D MSG^ABSVQ QUIT
 S ABSVXA="Do you wish to Add/Edit Volunteer specific data",ABSVXB="",%=1 D ^ABSVYN W ! I %<0 G REACT:$D(REACTIVE) L -^ABS(503330,ABSVX("VOLDA")) D OUT^ABSVE3 G M1
 I %=1 D MORE^ABSVTED1 S DIE="^ABS(503330,",DR="[ABSV ADD/EDIT MASTER]",DA=ABSVX("VOLDA") D ^DIE S EDIT=1 I $$CHECK G REACT:$D(REACTIVE) L -^ABS(503330,ABSVX("VOLDA")) D OUT^ABSVE3 K EDIT G M1
 S ABSVXA="Do you wish to Add/Edit station specific data",ABSVXB="",%=1 D ^ABSVYN W ! I %<0 G REACT:$D(REACTIVE) L -^ABS(503330,ABSVX("VOLDA")) D OUT^ABSVE3 G M1
 I %=1 D  I $$CHECK G REACT:$D(REACTIVE) L -^ABS(503330,ABSVX("VOLDA")) D OUT^ABSVE3 K EDIT G M1
 . S DA(1)=DA,DIE="^ABS(503330,"_DA(1)_",4,",DR="1;7;2;3;4;5;18;21;20;21;22",DA=ABSV("INST")
 . D ^DIE S DA=DA(1) K DA(1)
 . S EDIT=1
 . QUIT
 S ABSVXA="Do you wish to Add/Edit the Combinations for Station "_ABSV("SITE"),ABSVXB="",%=1 D ^ABSVYN
 I %=1 S ABSVX("EDIT")="",ABSVX("DA")=DA D C1^ABSVE3 I 1
 E  W !! I %<0 G REACT:$D(REACTIVE) L -^ABS(503330,ABSVX("VOLDA")) D OUT^ABSVE3 G M1
REACT S ABSVXA="Do you wish to EDIT AUSTIN'S Station Hours and Award information",ABSVXB="",%=1 D ^ABSVYN W ! I %<0 L -^ABS(503330,ABSVX("VOLDA")) D OUT^ABSVE3 G M1
 I %=1 D  I $$CHECK L -^ABS(503330,ABSVX("VOLDA")) D OUT^ABSVE3 K EDIT G M1
 . ;S DA(1)=ABSVX("VOLDA"),DIE="^ABS(503330,"_DA(1)_",4,",DR="14///@;15///@;16///@;17///@;Q;14;15;16;17",DA=ABSV("INST") D ^DIE K DA(1) S EDIT1=""
 . S DA(1)=ABSVX("VOLDA"),DIE="^ABS(503330,"_DA(1)_",4,",DR="14;15;16;17",DA=ABSV("INST") D ^DIE K DA(1) S EDIT1=""
 . QUIT
 W ! S X="Updating complete for "_ABSVX("NAME")_".*" D MSG^ABSVQ
 L -^ABS(503330,ABSVX("VOLDA")) D OUT^ABSVE3
M1 W !! S ABSVXA="Do you wish to ADD/EDIT another Volunteer for Station "_ABSV("SITE"),ABSVXB="",%=1 D ^ABSVYN I %'=1 K ABSV G OUT^ABSVE3
 D OUT^ABSVE3 W ! G M2
CHECK() ;
 I $D(DTOUT) K DTOUT S X="   <Time out has occurred>*" D MSG^ABSVQ QUIT 1
 I '$D(Y) QUIT 0
 S ABSVXA="Do you wish to continue to the next section",ABSVXB="",%=1
 D ^ABSVYN I %'=1 QUIT 1
 QUIT 0
REACTIVE ;REACTIVATE A VOLUNTEER
 N X
 I $P($G(^ABS(503330,ABSVX("VOLDA"),4,ABSV("INST"),0)),"^",11)]"" D
 . S X="CAUTION: This volunteer has been PURGED IN AUSTIN.  Be sure to answer NO to the 'ACTIVE IN AUSTIN' question.*" D MSG^ABSVQ
 . S X=$P(^ABS(503330,ABSVX("VOLDA"),4,ABSV("INST"),0),"^",4,6),$P(^(0),"^",17,19)=X,$P(^(0),"^",16)=$P(^(0),"^",3),$P(^(0),"^",11)="",$P(^(0),"^",15)=1
 . QUIT
 S $P(^ABS(503330,ABSVX("VOLDA"),4,ABSV("INST"),0),"^",8,9)="^1"
 S X="  Volunteer Reactivated*" D MSG^ABSVQ
 QUIT
