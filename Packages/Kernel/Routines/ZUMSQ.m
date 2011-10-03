ZU ;SF/GFT - For M/SQL, TIE ALL TERMINALS EXCEPT CONSOLE TO THIS ROUTINE!! ;10/31/95  09:53
 ;;8.0;KERNEL;**13**;Jul 10, 1995
 ;FOR M/SQL
EN S $ZS=96
 S $ZT="ERR^ZU"
 S ZUGUI=$G(ZUGUI1)&$G(ZUGUI2) K ZUGUI1,ZUGUI2
 G ^XUSG:ZUGUI,^XUS
 ;
G ;Entry point for GUI device.
 S ZUGUI1=1 G EN
 ;
ERR X ^%ZOSF("NBRK") S $ZT="HALT^ZU" L  ;Come here on a error
 I $G(IO)]"",$D(IO(1,IO)),$E($G(IOST))="P" U IO W @$S($D(IOF):IOF,1:"#")
 I $G(IO(0))]"" U IO(0) W !!,"RECORDING THAT AN ERROR OCCURRED ---",!!?15,"Sorry 'bout that",!,*7,!?10,"$ZERROR=",$ZERROR
 S %ZTERLGR="" D ^%ZTER
 I $ZE'["<INTERRUPT>" G ^XUSCLEAN
CTRLC W !,"--Interupt Acknowledged",!
 S Y=^XUTL("XQ",$J,^XUTL("XQ",$J,"T")-1),Y(0)=$P(Y,"^",2,99),Y=$P("^",1)
 S $ZT="ERR^ZU" G M1^XQ
 ;
HALT S $ZT="" I $D(^XUTL("XQ",$J)) D BYE^XUSCLEAN
 HALT
