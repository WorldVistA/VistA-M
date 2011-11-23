DVBCUTA4 ;ALB/GTS-AMIE C&P UTILITY ROUTINE A-4 ; 2/13/95  11:30 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 ;
REFRSH(TMPDA) ;** Refresh the screen with the current appt's
 W @IOF
 N LPDA
 W !!!,"Select an appointment to link to the 2507 request",!
 W !,?1,"1",?4,"Display Current C&P Appointment Links"
 F LPDA=2:1:TMPDA Q:'$D(^TMP("DVBC",$J,LPDA))  DO
 .W !,?1,LPDA,?4,$P(^TMP("DVBC",$J,LPDA),U,1)
 .W ?23,$E($P(^TMP("DVBC",$J,LPDA),U,2),1,22)
 .W:$D(^DVB(396.95,"AB",REQDA,$P(^TMP("DVBC",$J,LPDA),U,4))) ?47,"*CL"
 .W ?51,$E($P(^TMP("DVBC",$J,LPDA),U,3),1,27)
 Q
 ;
ENHNC() ;**Return event drvr dialogue mode
 N ENHCMODE,PARAMDA
 S PARAMDA=0
 S PARAMDA=$O(^DVB(396.1,PARAMDA))
 S ENHCMODE=$P(^DVB(396.1,PARAMDA,0),U,18)
 Q ENHCMODE
 ;
EXAMLST(EXAMDA,EXAMSTAT) ;** Output exam
 I $Y>(IOSL-5) DO
 .S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue."
 .S DIR("A",1)=" " D ^DIR K DIR,X,Y
 .D:'$D(DTOUT)&('$D(DUOUT)) EXMHD^DVBCUTL6
 I '$D(DTOUT),('$D(DUOUT)) DO
 .S:EXAMSTAT="C" EXAMSTAT="Completed"
 .S:EXAMSTAT="O" EXAMSTAT="Open"
 .S:EXAMSTAT="X" EXAMSTAT="Canceled by MAS"
 .S:EXAMSTAT="RX" EXAMSTAT="Canceled by RO"
 .S:EXAMSTAT="T" EXAMSTAT="Transferred Out"
 .W !,?1,$P(^DVB(396.6,$P(^DVB(396.4,EXAMDA,0),U,3),0),U,2),?41,EXAMSTAT
 Q
 ;
TRANCHK(REQDA) ;**Check for 2507 completly x-fered
 N TRANVAL,XFRD
 S TRANVAL=0
 I $D(^DVB(396.3,REQDA,4)),($P(^DVB(396.3,REQDA,4),U,1)="y") DO
 .S XFRD=""
 .N XMDA
 .F XMDA=0:0 S XMDA=$O(^DVB(396.4,"C",REQDA,XMDA)) Q:(XMDA=""!'$D(XFRD))  DO
 ..I $P(^DVB(396.4,XMDA,0),U,4)'="T" K XFRD
 S:$D(XFRD) TRANVAL=1
 Q TRANVAL
