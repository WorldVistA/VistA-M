ZU ;SFISC/RWF - For MSM-NT and MSM-UNIX, TIE all User terminals to this routine!! ;06/20/2000  11:31
 ;;8.0;KERNEL;**13,42,49,94,107,162**;Jul 10, 1995
 ;FOR MSM-NT and MSM-UNIX v4.3 or greater
EN N $ESTACK S $ECODE="",$ETRAP="D ERR^ZU Q:$QUIT 0 Q" ;,ZUGUI2=$$GUI()
 ;The next line keeps sign-on users from taking the last slot
 ;It can be commented out if not needed.
JOBCHK X ^%ZOSF("AVJ") I Y<3 W $C(7),!!,"** TROUBLE ** - ** CALL IRM NOW! **" G HALT
 D:+$G(^%ZTSCH("LOGRSRC")) LOGRSRC^%ZOSV("$LOGIN$")
 ;Bump up the partition size, Task partition size if file 14.7
 D GETENV^%ZOSV S Y=$P(Y,"^",4),%=$O(^%ZIS(14.7,"B",Y,0)),Y=$G(^%ZIS(14.7,+%,0)),%K=$P(Y,"^",5) I %K>0 D INT^%PARTSIZ
 G ^XUS ;G ^XUSG:$G(ZUGUI1),^XUS
 ;
G ;Entry point for GUI device.
 S ZUGUI1=1 G EN
 ;
ERR ;Come here on error.
 I $ZE["STKOVR" S $ET="Q:$ST>"_($ST-8)_"  D ERR2^ZU" Q
ERR2 S $ETRAP="D UNWIND^ZU" L  B 0 ;Unlock, Turn off break
 Q:$ECODE["<PROG>"
 I $G(IO)]"",$D(IO(1,IO)),$E($G(IOST))="P" U IO W @$S($D(IOF):IOF,1:"#")
 I $G(IO(0))]"" U IO(0) W !!,"RECORDING THAT AN ERROR OCCURRED ---",!!?15,"Sorry 'bout that",!,*7,!?10,"$STACK=",$STACK,", $ECODE=",$ECODE,!?10,"$ZERROR=",$ZERROR
 D ^%ZTER
 I $EC'["<INRPT>" S XUERF="",$EC="" G ^XUSCLEAN
CTRLC I $D(IO)=11 U IO(0) C:IO'=IO(0) IO S IO=IO(0)
 W !,"--Interrupt Acknowledged",!
 D KILL1^XUSCLEAN ;Clean up symbol table
 S $ECODE=",U<<POP>>,"
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
 S $ECODE="",$ETRAP="S %ZTER11S=$STACK D ERR^ZU Q:$QUIT 0 Q" G M1^XQ
 ;
HALT I $D(^XUTL("XQ",$J)) D:$D(DUZ)#2 BYE^XUSCLEAN
 D:+$G(^%ZTSCH("LOGRSRC")) LOGRSRC^%ZOSV("$LOGOUT$")
 I '$ESTACK G CONT
 S $ETRAP="D UNWIND^ZU" ;Set new trap
 S $ECODE=",U<<HALT>>," ;Cause error to unwind stack
 Q
CONT ;
 S $ECODE="",$ETRAP=""
 HALT
 ;
GUI() ;Test if under GUI
 Q "" ;Just say No.
 S $ZT="GUIX",X="" G:$PD'=1 GUIX
 S X=$G(^$DI($PD,"PLATFORM"))
GUIX Q X
