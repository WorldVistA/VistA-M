ZU ;SF/RWF - For Cache and Open M! ;06/13/2006
 ;;8.0;KERNEL;**34,94,118,162,170,225,419**;Jul 10, 1995;Build 5
 ;TIE ALL TERMINALS EXCEPT CONSOLE TO THIS ROUTINE!
EN N $ES,$ETRAP S $ETRAP="D ERR^ZU Q:$QUIT -9 Q"
 D:+$G(^%ZTSCH("LOGRSRC")) LOGRSRC^%ZOSV("$LOGIN$")
 ;The next line keeps sign-on users from taking the last slot
 ;It can be commented out if not needed.
 ;I $$AVJ^%ZOSV()<3 W $C(7),!!,"** TROUBLE ** - NO AVALIABLE JOBS ** CALL IRM NOW! **" G HALT
 ;Only call ShareLic for Telnet connections.
 I ($I["|TNT|")!($I["TNA") D SHARELIC^%ZOSV(0)
 G ^XUS
 ;
 ;
ERR ;Come here on error
 ; Try and handle stack overflow errors specifically
 I $ZE["STACK" S $ET="Q:$ST>"_($ST-8)_"  D ERR2^ZU" Q
ERR2 ;
 S $ET="D UNWIND^ZU" L  ;Backup trap (419)
 Q:$ECODE["<PROG>"
 ;
 D ^%ZTER K %ZT ; Capture symbol table first!
 ;
 I $G(IO)]"",$D(IO(1,IO)),$E($G(IOST))="P" D
 . U IO
 . W @$S($D(IOF):IOF,1:"#")
 I $G(IO(0))]"" D
 . U IO(0)
 . W !!,"RECORDING THAT AN ERROR OCCURRED ---"
 . W !!?15,"Sorry 'bout that"
 . W !,*7
 . W !?10,"$STACK=",$STACK,"  $ECODE=",$ECODE
 . W !?10,"$ZERROR=",$ZERROR
 ;
 I $G(DUZ)'>0 G HALT
 X ^%ZOSF("PROGMODE") Q:Y
 S $ET="D HALT^ZU" ;419
 I $ZE'["<INTERRUPT>" S XUERF="" G ^XUSCLEAN ;419
CTRLC I $D(IO)=11 U IO(0) W !,"--Interrupt Acknowledged",!
 D KILL1^XUSCLEAN ;Clean up symbol table
 S $ECODE=",U55,"
 Q
 ;
UNWIND ;Unwind the stack
 Q:$ESTACK>1  G CTRLC2:$ECODE["U55"
 S $ECODE=""
 Q
 ;
CTRLC2 S $ECODE="" G:$G(^XUTL("XQ",$J,"T"))<2 ^XUSCLEAN
 S ^XUTL("XQ",$J,"T")=1,XQY=^(1),XQY0=$P(XQY,"^",2,99)
 G:$P(XQY0,"^",4)'="M" HALT
 S XQPSM=$P(XQY,"^",1),XQY=+XQPSM,XQPSM=$P(XQPSM,XQY,2,3)
 G:'XQY ^XUSCLEAN
 S $ECODE="",$ETRAP="D ERR^ZU"
 G M1^XQ
 ;
HALT S $ECODE="" I $D(^XUTL("XQ",$J)) D BYE^XUSCLEAN
 D:+$G(^%ZTSCH("LOGRSRC")) LOGRSRC^%ZOSV("$LOGOUT$")
 HALT
 ;
