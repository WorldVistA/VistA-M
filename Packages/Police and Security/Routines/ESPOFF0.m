ESPOFF0 ;DALISC/CKA - OFFENSE REPORT INPUT -CONTINUED;7/92
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN Q  ;continued from ESPOFF
1 W !!!,$P($T(SCR+1),";;",2)
 D COMP^ESPSCR1
 G:$D(DTOUT) NOUPD
E1 D A G:$D(ESPOUT) NOUPD G:X="^" SAVE G:X?1"^"1N @$E(X,2)
2 W !!!,$P($T(SCR+2),";;",2)
 D VIC^ESPSCR1
E2 G:$D(DTOUT) NOUPD D A G:$D(ESPOUT) NOUPD G:X="^" SAVE G:X?1"^"1N @$E(X,2)
3 W !!!,$P($T(SCR+3),";;",2) D OFFE^ESPSCR
E3 G:$D(DTOUT) NOUPD D A G:$D(ESPOUT) NOUPD G:X="^" SAVE G:X?1"^"1N @$E(X,2)
4 W !!!,$P($T(SCR+4),";;",2)
 D WIT^ESPSCR1
E4 G:$D(DTOUT) NOUPD D A G:$D(ESPOUT) NOUPD G:X="^" SAVE G:X?1"^"1N @$E(X,2)
5 W !!!,$P($T(SCR+5),";;",2) D VEH^ESPSCR0
E5 G:$D(DTOUT) NOUPD D A G:$D(ESPOUT) NOUPD G:X="^" SAVE G:X?1"^"1N @$E(X,2)
6 W !!!,$P($T(SCR+6),";;",2) D PROP^ESPSCR0
E6 G:$D(DTOUT) NOUPD D A G:$D(ESPOUT) NOUPD G:X="^" SAVE G:X?1"^"1N @$E(X,2)
7 W !!!,$P($T(SCR+7),";;",2) D HELD^ESPSCR1
E7 G:$D(DTOUT) NOUPD D A G:$D(ESPOUT) NOUPD G:X="^" SAVE G:X?1"^"1N @$E(X,2)
8 W !!!,$P($T(SCR+8),";;",2) D NOTIF^ESPSCR1
E8 G:$D(DTOUT) NOUPD D A G:$D(ESPOUT) NOUPD G:X="^" SAVE G:X?1"^"1N @$E(X,2)
9 W !!!,$P($T(SCR+9),";;",2),!,"NARRATIVE:"
 D NARR^ESPSCR1
 G:$D(DTOUT) NOUPD D A G:$D(ESPOUT) NOUPD G:X="^" SAVE G:X?1"^"1N @$E(X,2)
 G ^ESPOFF1
EXIT W:$D(DTOUT)!($D(ESPOUT)) $C(7)
 K DIC,DIR,DIRUT,DUOUT,ESPCL,ESPD,ESPDTR,ESPFN,ESPN,ESPNOT,ESPOUT,ESPS,ESPTEST,ESPVAR,ESPX,ESPY,I,NOUPD,X,Y,^TMP($J)
 QUIT
A R !!!,"Enter:<RET> to continue, ^N for screen N or '^' to abort: ",X:DTIME
 I '$T S ESPOUT=1 Q
 Q:X=""!(X="^")
 G:X["?" HELP
 I $E(X,2)<1!($E(X,2)>9) W !,$C(7),"NUMBER MUST BE 1-9." G A
 QUIT
HELP I X["?" W !!,"Enter '^' to stop or <RET> to continue or enter '^N' to jump to screen # N."
 W !!! F I=1:1:9 W !?10,$P($T(SCR+I),";;",2)
 G A
 QUIT
SAVE S DIR(0)="Y",DIR("A")="Do you want to save and edit later",DIR("B")="YES" D ^DIR K DIR I 'Y G NOUPD
 G ^ESPOFF1
 ;
NOUPD W !!,$C(7),?20,"NO UPDATING HAS OCCURRED!!!",!! K ESPCL,ESPD,ESPDTR,ESPX,ESPY,^TMP($J) G:$D(DTOUT)!($D(ESPOUT)) EXIT G DTR^ESPOFF
SCR ;
 ;;Screen 1 - Complainant
 ;;Screen 2 - Victim
 ;;Screen 3 - Offender
 ;;Screen 4 - Witness
 ;;Screen 5 - Vehicle
 ;;Screen 6 - Property (Lost)
 ;;Screen 7 - Property (Held)
 ;;Screen 8 - Notification
 ;;Screen 9 - Narrative
