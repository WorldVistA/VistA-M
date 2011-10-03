ZU ;SF/RWF - For Open M for NT and Cache! ;03/21/2002  13:46
 ;;8.0;KERNEL;**34,94,118,162,170,225**;Jul 10, 1995
 ;TIE ALL TERMINALS EXCEPT CONSOLE TO THIS ROUTINE!
EN N $ES,$ETRAP S $ETRAP="D ERR^ZU Q"
 D:+$G(^%ZTSCH("LOGRSRC")) LOGRSRC^%ZOSV("$LOGIN$")
 ;The next line keeps sign-on users from taking the last slot
 ;It can be commented out if not needed.
JOBCHK I $$AVJ^%ZOSV()<3 W $C(7),!!,"** TROUBLE ** - ** CALL IRM NOW! **" G HALT
 ;Only call ShareLic for Telnet connections.
 I ($I["|TNT|")!($I["TNA") D SHARELIC^%ZOSV(0)
 G ^XUS
 ;
 ;
ERR ;Come here on error
 I $ZE["STACK" S $ET="Q:$ST>"_($ST-8)_"  D ERR2^ZU" Q
ERR2 S $ET="UNWIND^ZU" L  ;Backup trap
 Q:$ECODE["<PROG>"
 D ^%ZTER
 I $G(IO)]"",$D(IO(1,IO)),$E($G(IOST))="P" U IO W @$S($D(IOF):IOF,1:"#")
 I $G(IO(0))]"" U IO(0) W !!,"RECORDING THAT AN ERROR OCCURRED ---",!!?15,"Sorry 'bout that",!,*7,!?10,"$ZERROR=",$ZERROR
 X ^%ZOSF("PROGMODE") Q:Y  S $ZT="HALT^ZU"
 I $ZE'["<INRPT>" S XUERF="" G ^XUSCLEAN
CTRLC I $D(IO)=11 U IO(0) W !,"--Interrupt Acknowledged",!
 D KILL1^XUSCLEAN ;Clean up symbol table
 S $ECODE=",U55,"
 Q
 ;
UNWIND ;Unwind the stack
 Q:$ES>1  G CTRLC2:$EC["U55"
 S $EC=""
 Q
 ;
CTRLC2 S $EC="" G:$G(^XUTL("XQ",$J,"T"))<2 ^XUSCLEAN
 S ^XUTL("XQ",$J,"T")=1,XQY=^(1),XQY0=$P(XQY,"^",2,99)
 G:$P(XQY0,"^",4)'="M" CTRLC2
 S XQPSM=$P(XQY,"^",1),XQY=+XQPSM,XQPSM=$P(XQPSM,XQY,2,3)
 G:'XQY ^XUSCLEAN
 S $ECODE="",$ETRAP="D ERR^ZU" G M1^XQ
 ;
HALT S $EC="" I $D(^XUTL("XQ",$J)) D BYE^XUSCLEAN
 D:+$G(^%ZTSCH("LOGRSRC")) LOGRSRC^%ZOSV("$LOGOUT$")
 HALT
 ;
