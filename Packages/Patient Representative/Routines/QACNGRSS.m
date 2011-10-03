QACNGRSS ;HISC/CEW - Enter/edit a congressional contact ;1/17/95  13:00
 ;;2.0;Patient Representative;;07/25/1995
ENTER W ! K DIC S DIC="^QA(745.4,",DLAYGO=745,DIC(0)="AELMQZ"
 S DIC("A")="Enter office or name: "
 D ^DIC K DIC G:Y'>0 QUIT
 S QACNM=+Y
 G QUIT:$D(DTOUT)!($D(DUOUT))
 L +^QA(745.4,QACNM):0 I '$T W "Try again later." G ENTER
 K DIE,DA,DR S DIE="^QA(745.4,",DR=".01;1",DA=QACNM
 D ^DIE K DIE L -^QA(745.4,QACNM) G ENTER
QUIT K QACNM,DIC,Y,DIE,DA,DR,DLAYGO,DTOUT,DUOUT
 Q
