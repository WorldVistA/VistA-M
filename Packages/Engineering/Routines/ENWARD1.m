ENWARD1 ;(WASH ISC)/DH-Incomplete Work Orders for End Users ;2.17.97
 ;;7.0;ENGINEERING;**35**;Aug 17, 1993
 ;  Check for incomplete work orders
 ;
EN S DIR(0)="S^E:Entered By;L:Locations (multiple);R:Room (specific);S:Service/Section",DIR("B")="Room (specific)",DIR("A")="List incomplete work orders by"
 D ^DIR K DIR G:$D(DIRUT) EXIT G @$E(Y)
 ;
E ;By user (ENTERED BY)
 S DIC="^VA(200,",DIC(0)="AEQMN" D ^DIC G:Y'>0 EXIT S ENEB=+Y,ENBY="E"
 G DEV
 ;
L ;By location
 S DIR(0)="Y",DIR("A")="Should all LOCATIONS be included",DIR("B")="YES"
 S DIR("?",1)="Enter 'NO' if you want to screen your list by DIVISION, BUILDING, WING,"
 S DIR("?",2)="and/or ROOM. If you enter 'YES' then all locations will be included and the"
 S DIR("?")="sort order will be DIVISION, BUILDING, WING, and finally ROOM."
 D ^DIR K DIR Q:$D(DIRUT)
 S ENSRT("LOC","ALL")=Y S:Y ENSRT("BY")="DBWR"
 D:'Y GEN^ENSPSRT
 I '$D(ENSRT("BY")) G EXIT
 S ENBY="L" G DEV
 ;
R ;  One specific room
 S DIC="^ENG(""SP"",",DIC(0)="AEQM" D ^DIC G:Y'>0 EXIT S ENROOM=+Y,ENBY="R" G DEV
 ;
S ;By service
 S DIC="^DIC(49,",DIC(0)="AEQM" D ^DIC G:Y'>0 EXIT S ENSRVC=+Y,ENBY="S"
DEV K IOP("P") S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) K IO("Q") S ZTIO=ION,ZTRTN="EN^ENWARD2",ZTSAVE("EN*")="",ZTSAVE("D*")="",ZTDESC="Incomp Work Orders (Elect WO Module)" D ^%ZTLOAD K ZTSK D ^%ZISC G EXIT
 G EN^ENWARD2
 ;
EXIT K A,B,C,I,J,K,DIC,DIE,DA,DN,DNX,L,R,X,ENBY,ENEB,ENRLOC,ENSRT,ENROOM
 Q
 ;ENWARD1
