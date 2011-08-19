ZU ;SF/JLI,RWF - For DSM, TIE ALL TERMINALS TO THIS ROUTINE!! ;07/09/2001  13:31
 ;;8.0;KERNEL;**13,24,84,94,118,162,225**;Jul 10, 1995
 ;FOR VAX-DSM V5 & V6
EN ;See that escape processing is off, Conflict with Screenman
 S X=$&ZLIB.%DISABLCTRL($C(25)) U $I:(NOCENABLE:NOESCAPE)
 D:+$G(^%ZTSCH("LOGRSRC")) LOGRSRC^%ZOSV("$LOGIN$")
 S (ZUGUI1,ZUGUI2)="" ;$&ZLIB.%TRNLNM("DECW$DISPLAY",,,,,"VALUE")
 N $ESTACK,$ETRAP S $ETRAP="S %ZTER11S=$STACK D ERR^ZU Q:$QUIT 0 Q"
 ;Only call ShareLic for Telnet connections.
 D:$I["_TNA" SHARELIC^%ZOSV(0)
 G ^XUS
 ;
G ;Entry point for GUI device.
 Q  ;S ZUGUI1=1 G EN
ERR ;Come here on error
 I $ZE["STKOVR" S $ET="Q:$ST>"_($ST-8)_"  D ERR2^ZU" Q
ERR2 S $ETRAP="D UNWIND^ZU" L  U $I:NOCENABLE
 Q:$ECODE["<PROG>"
 I $ZE["^XUS1A:2, %DSM-E-WRITERR" G HALT
 I $G(IO)]"",$D(IO(1,IO)),$E($G(IOST))="P" U IO W @$S($D(IOF):IOF,1:"#")
 I $G(IO(0))]"" U IO(0) W !!,"RECORDING THAT AN ERROR OCCURRED ---",!!?15,"Sorry 'bout that",!,*7,!?10,"$STACK=",$STACK,"  $ECODE=",$ECODE,!?10,"$ZERROR=",$ZERROR
 D ^%ZTER K %ZT S XUERF="" ; Capture symbol table first!
 I $D(%ZTERROR),$P(%ZTERROR,"^",2)="F" H  ; Halt immediately for disaster type FATAL errors
 ;U $I:NOCENABLE D PROGMODE^%ZOSV I Y U $I:CENABLE Q
 I $G(DUZ)'>0 HALT
 ;
CTRLC I $D(IO)=11 U IO(0) C:IO'=IO(0) IO S IO=IO(0)
 W:$ZE["-CTLC" !,"--Interrupt Acknowledged",!
 D KILL1^XUSCLEAN ;Clean up symbol table
 S $ECODE=",<<POP>>,"
 Q
 ;
UNWIND ;Unwind the stack
 Q:$ESTACK>1  G CONT:$ECODE["<<HALT>>",CTRLC2:$ECODE["<<POP>>"
 S $ECODE=""
 Q
 ;
CTRLC2 S $ECODE="" G:$G(^XUTL("XQ",$J,"T"))<2 ^XUSCLEAN
 S ^XUTL("XQ",$J,"T")=1,XQY=$G(^(1)),XQY0=$P(XQY,"^",2,99)
 G:$P(XQY0,"^",4)'="M" CTRLC2
 S XQPSM=$P(XQY,"^",1),XQY=+XQPSM,XQPSM=$P(XQPSM,XQY,2,3)
 G:'XQY ^XUSCLEAN
 S $ECODE="",$ETRAP="S %ZTER11S=$STACK D ERR^ZU Q:$QUIT 0 Q"
 U $I:NOESCAPE G M1^XQ
 ;
HALT I $D(^XUTL("XQ",$J)) D:$D(DUZ)#2 BYE^XUSCLEAN
 I '$ESTACK G CONT
 S $ETRAP="D UNWIND^ZU" ;Set new trap
 S $ECODE=",<<HALT>>," ;Cause error to unwind stack
 D:+$G(^%ZTSCH("LOGRSRC")) LOGRSRC^%ZOSV("$LOGOUT$")
 Q
CONT ;
 S $ECODE="",$ETRAP=""
 D:+$G(^%ZTSCH("LOGRSRC")) LOGRSRC^%ZOSV("$LOGOUT$")
 ;Halt If User changed UCI's
 I $&ZLIB.%GETSYM("DHCP$UCI_CHANGE") HALT
 ;Quit up to ZSLOT
 I $L($&ZLIB.%GETSYM("ZSLOT")) QUIT
 ;Halt If a dialup line
 S %=$&ZLIB.%GETDVI($I,"TT_DIALUP") I %!$D(XQXFLG("HALT")) HALT
 ;Halt If a Telnet connection
 I ($P["_TNA")!$D(XQXFLG("HALT")) HALT
 S X="Waiting "_($J#1000000) D SETENV^%ZOSV ;Change VMS name
 ;For sites that want to retain the connection, uncomment the next line
 ;U $I:NOCENABLE R !,"Enter return to continue: ",X:600 S:'$T X="^" G:X'="^" ^ZU
 HALT
SLOT ;Entry point from ZSLOT
 N ZIO,ZTIME
 D LOG G EN
 ;
LOG ;Define some nessary Logical names for ZSLOT
 S %=$&ZLIB.%CRELOG("SYS$INPUT",$I,"SUPERVISOR")
 S %=$&ZLIB.%CRELOG("SYS$OUTPUT",$I,"SUPERVISOR")
 S %=$&ZLIB.%CRELOG("SYS$COMMAND",$I,"SUPERVISOR")
 Q
