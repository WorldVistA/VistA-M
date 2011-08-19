%ZISC ;SFISC/GFT,AC,MUS - CLOSE LOGIC FOR DEVICES  ;1/24/08  16:09
 ;;8.0;KERNEL;**24,36,49,69,199,216,275,409,440**;JUL 10, 1995;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified
C0 ;
 N %,%E,%H,%ZISI,%ZISOS,%ZISX,%ZISV
 ;Clear IO var we will use for reporting
 K IO("ERROR"),IO("LASTERR"),IO("CLOSE")
 ;Protect ourself from calls with incomplete setup.
 S:$D(IO)[0 IO=$I S:'$D(IO(0)) IO(0)=$P
 S U="^",%ZISOS=$G(^%ZOSF("OS")),%ZISV=$G(^("VOL"))
 ;S %=$S(+$G(IOS):IOS,$L($G(ION)):ION,1:IO)
 S %=$S($L($G(ION)):ION,1:IO) ;p409
 I (%="")!(IO="") G SETIO:IO(0)]"",END
 I $G(IOT)="RES" D RES G SETIO ;Handle a resource device
 ;
 ;Define subtype info if not already defined.
 D SUBTYPE
 ;
 ;perform close execute
 I $G(IOST(0))>0 D
 . I $G(^%ZIS(2,+IOST(0),3))]"",$D(IO(1,IO)) D
 . . U IO S:$X $X=1 D X3^ZISX:'$D(IO("T"))
 ;
 ;Incase the Close execute changed IO, Open IO("HOME") or NULL.
 I '$L($G(IO)) D  Q
 . S IOP=$S($L($G(IO("HOME"))):"`"_(+IO("HOME")),1:"NULL") D ^%ZIS
 . Q
 ;
 ;Perform the following if the device is open.
 I $D(IO(1,IO)) D
 . I $G(IO("P"))["B" D  ;Return to normal intensity
 . . S %=$P($G(^%ZIS(2,+IOST(0),7)),"^",3) I %]"" W @%
 . I $G(IO("P"))["P" D  ;Return to default pitch
 . . S %=$G(^%ZIS(2,+IOST(0),12.11)) I %]"" W @%
 . ;
 . W:$$FF @IOF ;Issue form feed at close
 . I $$CLOSPP D X11^ZISX:'$D(IO("T")) K IO("S") ;Close printer port
 . Q
 ;
 ;Don't use IOCPU as we now use IO(1,IO)
 I (IO'=IO(0)!$D(IO("C"))),$D(IO(1,IO)) D
 . U:$S($D(ZTQUEUED):0,'$L($G(IO(0))):0,$D(IO(1,IO(0)))#2:1,1:0) IO(0)
 . C IO K IO(1,IO) S IO("CLOSE")=IO ;close device
 ;Unlock global used to control access.
 S %=$G(^XUTL("XQ",$J,"lock",+$G(IOS))) I $L(%) L -@% K ^XUTL("XQ",$J,"lock",IOS)
 ;
 I $D(IO("SPOOL")) D CLOSE^%ZIS4 ;Special close for spool device
 ;
SETIO ;
 ;See if old device has PCX code
 I $G(IOS),$G(^%ZIS(1,+IOS,"PCX"))]"" S %ZISPCX=^("PCX")
 ;Setup the IO(0) device, should be the home device
 S IO=IO(0),(IOPAR,IOUPAR)="" K IO("T") D CIOS(IO(0))
 I 'IOS S IOT="TRM" G END
 S ION=$P(^%ZIS(1,IOS,0),"^",1),IOT=$G(^("TYPE")),IOST(0)=$S(IOT["TRM"&($D(^XUTL("XQ",$J,"IOST(0)"))):^("IOST(0)"),1:$G(^%ZIS(1,IOS,"SUBTYPE")))
 I IOT["TRM",$D(^XUTL("XQ",$J,"IO")) D HOME^%ZIS G END
 S %="Y"
 I IOST(0),$D(^%ZIS(2,IOST(0),1)) S %=^(1),IOM=+%,IOF=$P(%,"^",2),IOSL=$P(%,"^",3),IOBS=$P(%,"^",4)
 I $D(^%ZIS(1,IOS,91)) S %=^%ZIS(1,IOS,91) S:+% IOM=+% S:$P(%,"^",3) IOSL=$P(%,"^",3)
 ;Don't know the subtype so set some defaults
 I %="Y" S IOM=80,IOSL=24,IOF="#",IOST="C-OTHER",IOBS="$C(8)"
S1 S:IOST(0) IOST=$P($G(^%ZIS(2,+IOST(0),0)),"^"),IOXY=$G(^("XY"))
 I '$D(ZTQUEUED),'$D(IO("C")),IOT["TRM" D RM:$D(IO(1,IO))
 ;With home device set, Do Post-close execute code of Device closed.
END I '$D(IO("T")),$G(%ZISPCX)]"" S %Y=%ZISPCX D %Y^ZISX
 ;See that any extra IO variables are cleaned up
 K IO("P"),IO("DOC"),IO("HFSIO"),IO("SPOOL"),IOC,IONOFF
 ;IOCPU should not be changed.
 Q
 ;
SUBTYPE ;Find a subtype
 N %S
 S IOST=$G(IOST),IOST(0)=+$G(IOST(0))
 I $L(IOST)&$L(IOST(0)) Q  ;Have a subtype
 S %S=$G(^%ZIS(2,+IOST(0),0)) I $L(%S) S IOST=$P(%S,U) Q
 I $L(IOST) S %S=$O(^%ZIS(2,"B",$G(IOST,"X"),0)) I %S>0 S IOST(0)=+%S Q
 S IOST="",IOST(0)=0 D CIOS($I) Q:IOS'>0
 S IOST(0)=$G(^%ZIS(1,+IOS,"SUBTYPE")),IOST=$P($G(^%ZIS(2,+IOST(0),0)),"^")
 Q
 ;
CIOS(%I) ;Find a value for IOS (IEN into device file)
 N %ZISVT
 I $D(^XUTL("XQ",$J,"IOS")) S IOS=+^("IOS") Q
 I $D(%ZISV) S %ZISVT=%I D VTLKUP^%ZIS S IOS=+%E
 E  S IOS=+$O(^%ZIS(1,"C",%I,0))
 Q:$G(IOS)>0
 S %ZISVT=%I D VIRTUAL^%ZIS
 I $D(%ZISVT) S %H=%E I %ZISVT]"",%H>0,$D(^%ZIS(1,%H,0)),$D(^("TYPE")),^("TYPE")="VTRM" S IOS=%H
 Q
 ;
RM N X S X=+IOM X ^%ZOSF("RM")
 Q
 ;
RES ;Close resource device.
 Q:'$D(IO(1,IO))&'$D(^%ZISL(3.54,"AJ",$J))
 N %ZISJOB,%X,%Y,%ZISD0,%ZISD1,%ZISRES,%ZISRL,%ZISY0,%ZTRTN,ZTSAVE,ZTIO
 S %ZISJOB=$J
 ;
RES1 G RQ:'$D(IOS),RQ:'$D(^%ZIS(1,+IOS,1)) S %ZISRL=+$P(^(1),"^",10),%ZISRL=$S(%ZISRL:%ZISRL,1:1)
 S %X=$O(^%ZISL(3.54,"B",IO,0)) G RQ:'%X
 G RQ:'$D(^%ZISL(3.54,+%X,0)) S %ZISD0=+%X,%ZISY0=^(0)
 S %X=$O(^%ZISL(3.54,"AJ",%ZISJOB,%ZISD0,0)) S %ZISD1=%X G RQ:'%X
 S %Y=$G(^%ZISL(3.54,%ZISD0,1,+%ZISD1,0)) G RQ:$P(%Y,"^",3)'=%ZISJOB
 D KILLRES(+%ZISD0,+%ZISD1)
RQ K IO(1,IO)
 Q
 ;
KILLRES(D0,D1) ;Kill one resource use
 Q:(D0'>0)!(D1'>0)
 N %X,%Y,%J,%ZISRL
 L +^%ZISL(3.54,D0,0)
 S %Y=$G(^%ZISL(3.54,D0,0)) G KRX:%Y=""
 S %X=$G(^%ZISL(3.54,D0,1,D1,0)),%J=$P(%X,"^",3) S:%J="" %J=" "
 K ^%ZISL(3.54,D0,1,D1,0),^%ZISL(3.54,D0,1,"B",D1,D1),^%ZISL(3.54,"AJ",%J,D0,D1)
 S %X=$P(%Y,"^",2)+1,$P(^%ZISL(3.54,D0,0),"^",2)=%X
 ;I '$D(^%ZISL(3.54,%ZISD0,1,0)) S ^(0)="^3.542A^^" G RQ
 S %Y=$G(^%ZISL(3.54,D0,1,0)),%X=$P(%Y,"^",4),$P(^%ZISL(3.54,D0,1,0),"^",3,4)="^"_$S(%X>0:(%X-1),1:0)
KRX L -^%ZISL(3.54,D0,0)
 Q
 ;
DQCRES ;Tasked entry point to close resource device.
 S IO=%ZISRES G RES1
 ;
FF() ;Issue form feed
 I $E(IOST,1,2)'["C-",$D(IO(1,IO)),$G(IOT)="TRM"!($G(IOT)="SPL"),'$D(IO("T"))&$Y&'$D(IONOFF)&'$D(IO(1,IO,"NOFF")) Q 1
 Q 0
 ;
CLOSPP() ;Close printer port
 I $D(IO("S")),$D(^%ZIS(2,+IO("S"),11))&$D(IO(1,IO)) Q 1
 Q 0
