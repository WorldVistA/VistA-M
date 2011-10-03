LRLNCLK ;DALOI/RSH/FHS - LOOK UP LOINC CODE AND DISPLAY;31 -AUG-2001
 ;;5.2;LAB SERVICE;**232,278**;Sep 27,1994
START ;
 D ENTERLNC
 I $G(LREND) D EXIT
 E  G START
 Q
ENTERLNC ;Enter LOINC code for lookup
 W !! K DIR S LREND=0,DIR(0)="PO^95.3:AQEMZ",DIR("A")="Enter LOINC Code/Name "
 S DIR("?")="You can see possible LOINC CODES/Specimen by entering the"
 S DIR("?",1)="LOINC Test Name..Specimen   example( GLUCOSE..UR )"
 S DIR("?",2)=" "
 D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT))!(Y=-1) K DTOUT,DUOUT S LREND=1 Q
 S LRCODE=+Y
SP D DISPL
 Q
DISPL ;Show LOINC entry selected in file 95.3
 ;display header-system and class
 ;display LOINC code, component, property, time aspect, scale type and method type
 S DA=LRCODE
 S LRLNC0=^LAB(95.3,DA,0)
 F I=2,6,7,8,9,10,11,14,15 S LRLNC0(I)=$P(LRLNC0,U,I)
 S LRLNCNAM=$P($G(^LAB(95.3,DA,80)),U)
 W @IOF
 W !,"LOINC CODE: ",LRCODE_"-"_LRLNC0(15),"   ",LRLNCNAM
 W !,"SYSTEM: ",$P($G(^LAB(64.061,+LRLNC0(8),0)),U),?40,"CLASS: ",$P($G(^LAB(64.061,+LRLNC0(11),0)),U)
 W:LRLNC0(2) !,"COMPONENT: ",$P($G(^LAB(95.31,+LRLNC0(2),0)),U)
 W:LRLNC0(6) !,"PROPERTY: ",$P($G(^LAB(64.061,+LRLNC0(6),0)),U)
 W:LRLNC0(7) !,"TIME ASPECT: ",$P($G(^LAB(64.061,+LRLNC0(7),0)),U)
 W:LRLNC0(9) !,"SCALE TYPE: ",$P($G(^LAB(64.061,+LRLNC0(9),0)),U)
 W:LRLNC0(10) !,"METHOD TYPE: ",$P($G(^LAB(64.2,+LRLNC0(10),0)),U)
 W:LRLNC0(14) !,"UNITS: ",$P($G(^LAB(64.061,+LRLNC0(14),0)),U)
 Q
EXIT K DA,DIR,DIRUT,DTOUT,LRCODE,LREND,LRLNCNAM,LRLNC0,X,Y
 Q
