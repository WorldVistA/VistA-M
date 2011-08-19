ENNEWPKG ;(WASH ISC)/DH-PreInitialization Routine ;8-20-93
 ;;7.0;ENGINEERING;;Aug 17, 1993
EN ;Entry point
 I $D(^ENG) L +^ENG:1 I '$T W !!,"Engineering users are active.  Cannot proceed.",*7 G ABORT
 S U="^",ENSTA=$S($D(^DIC(6910,1,0)):$P(^(0),U,2),1:"")
 S:'$D(DTIME) DTIME=600
 I $D(^ENG("VERSION"))#10,ENSTA="" W *7,!!,"DON'T SEE YOUR STATION NUMBER. Please check Eng Init Parameters File." G ABORT
 I $D(^ENG("VERSION")),^ENG("VERSION")<6.5 W !,"Must upgrade to Version 6.5 before proceeding.",*7 G ABORT
 S ENABORT=0
 I $D(^ENG("VERSION"))#10,$E(^ENG("VERSION"))'=7 F DA=0:0 S DA=$O(^ENG("ACT",DA)) Q:ENABORT!(DA'>0)  I $P(^ENG("ACT",DA,0),U,2)'>0 S ENABORT=1 W !!,*7,"One or more WORK ACTIONS don't have pointers to NEW WORK ACTIONS."
 W:ENABORT !!,"Patch EN*6.5*5 must be fully installed prior to installation",!,"of Engineering 7.0.",*7
 G:'ENABORT EXIT
ABORT ;Abort install (no op)
 K DIFQ
 W !!,*7,"Installation aborted. Database unchanged." R X:DTIME
EXIT K DA,ENSTA,ENABORT
 Q
 ;ENNEWPKG
