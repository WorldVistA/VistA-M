ENWOST ;(WASH ISC)/DLM/JED-Incomp Engineering Work Orders ;2.7.97
 ;;7.0;ENGINEERING;**6,35**;Aug 17, 1993
 ;
V Q  ;Option ENWO-STATUS-(HC) no longer supported
 ;
E ;  By employee
 D SSHOP^ENWO G:ENSHKEY'>0 EXIT
 S DIC="^ENG(""EMP"",",DIC("A")="Select EMPLOYEE NAME (press <ENTER> for unassigned): ",DIC(0)="AEQM" D ^DIC S ENEMP=+Y
 I ENEMP'>0 D
 . R !,"Type 'NOT' to get unassigned work orders: EXIT// ",X:DTIME
 . I "^NOT^Not^not^"[(U_X_U) S ENEMP=""
 G:ENEMP<0 EXIT
 S ENBY="EMP" G COMN
 ;
ROOM ;  By specific room (from Space File #6928)
 D SSHOP^ENWO G:ENSHKEY'>0 EXIT
 S DIC="^ENG(""SP"",",DIC(0)="AEQM" D ^DIC G:Y'>0 EXIT S ENROOM=+Y
 S ENBY="ROOM" G COMN
 ;
L ;By location
 D SSHOP^ENWO G:ENSHKEY'>0 EXIT
 S DIR(0)="Y",DIR("A")="Should all LOCATIONS be included",DIR("B")="YES"
 S DIR("?",1)="Enter 'NO' if you want to screen your list by DIVISION, BUILDING, WING,"
 S DIR("?",2)="and/or ROOM. If you enter 'YES' then all locations will be included and the"
 S DIR("?")="sort order will be DIVISION, BUILDING, WING, and finally ROOM."
 D ^DIR K DIR Q:$D(DIRUT)
 S ENSRT("LOC","ALL")=Y S:Y ENSRT("BY")="DBWR"
 D:'Y GEN^ENSPSRT
 I '$D(ENSRT("BY")) G EXIT
 S ENBY="LOC" G COMN
 ;
O ;By service
 D SSHOP^ENWO G:ENSHKEY'>0 EXIT
 S DIC="^DIC(49,",DIC(0)="AEQM" D ^DIC G:Y'>0 EXIT S ENONR=+Y
 S ENBY="ONR" G COMN
 ;
S ;By shop
 D SSHOP^ENWO G:ENSHKEY'>0 EXIT
 S ENBY="SHOP"
COMN D AGE G:ENDLQ="^" EXIT
 D PM G:ENPMINC'?1N EXIT
 D COUNT G:ENSUM'?1N EXIT
ALL K ENSHKEY("ALL") W !,"For ALL shops (say 'NO' if you only want ",$P(^DIC(6922,ENSHKEY,0),U),")"
 S %=2 D YN^DICN G:%<0 EXIT G:%=0 ALL
 S:%=1 ENSHKEY("ALL")=1
 D DEV^ENLIB G:POP EXIT
 I $D(IO("Q")) S ZTION=ION,ZTRTN="CONT^ENWOST",ZTDESC="Print Incomplete Work Orders",ZTSAVE("EN*")="" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G EXIT
CONT U IO I ENSUM D ^ENWOP2 G EXIT
 D ^ENWOP
 G EXIT
 ;
AGE S DIR(0)="N^0:999:0",DIR("A")="At least how many days old?"
 S DIR("B")=0
 D ^DIR K DIR S ENDLQ=Y
 Q
 ;
PM S DIR(0)="Y",DIR("A")="Include PM Work Orders",DIR("B")="NO"
 S DIR("??")="^D HLPPM^ENWOST"
 D ^DIR K DIR S ENPMINC=Y
 Q
 ;
COUNT S DIR(0)="Y",DIR("A")="Count(s) only",DIR("B")="NO"
 D ^DIR K DIR S ENSUM=Y
 Q
 ;
EXIT K A,B,C,J,DIC,DIE,DA,DN,DNX,L,R,X,EN,ENDLQ,ENEMP,ENONR,ENRLOC,ENBY,ENSHKEY("ALL"),ENPMINC
 K ENSUM,ENSRT,ENROOM
 I $E(IOST,1,2)="P-",'$D(ZTQUEUED) D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
HLPPM W !!,"If you answer 'YES' the Incomplete Work Order list will contain PM work",!,"orders. To get a list of 'regular' work orders only, just say 'NO'.",!!
 Q
 ;ENWOST
