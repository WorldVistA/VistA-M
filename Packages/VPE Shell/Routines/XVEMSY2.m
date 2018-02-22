XVEMSY2 ;DJB/VSHL**Init cont.. [01/11/94];2017-08-16  10:46 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
RVCHK ;Check reverse video
 NEW NODE5,RVOFF,RVON,X
 Q:$G(IOST(0))'>0  Q:'$D(^%ZIS(2,IOST(0),0))  S NODE5=$G(^(5))
 S RVON=$P(NODE5,"^",4),RVOFF=$P(NODE5,"^",5)
 I RVON']""!(RVOFF']"") D RVMSG1 Q
 W @RVON,@RVOFF D RVMSG2
 Q
RVMSG1 ;
 W $C(7),!!!!?1,"TERMINAL TYPE: " W $P(^%ZIS(2,IOST(0),0),"^",1)
 W !?1,"The REVERSE VIDEO ON and REVERSE VIDEO OFF fields in the TERMINAL TYPE"
 W !?1,"file are not filled in for your terminal type.",!
 Q
RVMSG2 ;
 W !!!!?1,"TERMINAL TYPE: " W $P(^%ZIS(2,IOST(0),0),"^",1)
 W !?1,"If your screen is now in Reverse Video, the REVERSE VIDEO OFF field in the"
 W !?1,"TERMINAL TYPE file may not be correct for your terminal type. This will"
 W !?1,"adversely effect some VSHELL screens and should be corrected."
 W !?1,"Type 'W $C(27,91,109)' if you need to return your screen to normal.",!
 Q
