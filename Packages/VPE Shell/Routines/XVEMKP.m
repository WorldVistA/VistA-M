XVEMKP ;DJB/VRR**Printing ;2019-08-20  5:31 PM
 ;;15.2;VICTORY PROG ENVIRONMENT;;Aug 27, 2019
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
TASK(DEFAULT) ;Get device. FLAGQ indicates job has been queued.
 ;DEFAULT=Default Device. Return FLAGQ=1 if taskman is used.
 Q:'$D(^%ZIS)
 N %ZIS S %ZIS="MQ" I $G(DEFAULT)]"" S %ZIS("B")=DEFAULT
 W ! D ^%ZIS Q:POP  Q:'$D(IO("Q"))  S FLAGQ=1
 N ZTSK D ^%ZTLOAD,HOME^%ZIS KILL IO("Q")
 I $G(ZTSK)'>0 W !!?1,"Request cancelled.." S FLAGQ=1 Q
 W !!?1,"This task has been queued...Task #",ZTSK,!
 Q
 ;====================================================================
CAPTURE() ;Screen capture
 ;Returns: YES or NO
 NEW ANS
 W @IOF,!?1,"***SCREEN CAPTURE***"
 W !?1,"(Your terminal emulation software should be set to 'Line Wrap=OFF')"
 W !!?1,"Follow these steps:"
 W !?4,"1. TURN ON your screen capture software."
 W !?4,"2. Press <RETURN> to initiate capture."
 W !?4,"3. When the listing stops, TURN OFF your screen capture software."
 W !?4,"4. Press <RETURN> to end capture."
CAPTURE1 W !!?1,"Ready..... Press <RETURN> to begin, or '^' to abort:"
 R !,ANS:300 S:'$T ANS="^"
 I "^"'[ANS D  G CAPTURE1
 . W !?1,"This option allows you to use your communication software"
 . W !?1,"to do an ASCII download via screen capture."
 I ANS="^" Q "NO"
 Q "YES"
