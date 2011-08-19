ZU ;SF/GFT - For DTM, TIE ALL TERMINALS EXCEPT CONSOLE TO THIS ROUTINE!! ;10/31/95  09:51
 ;;8.0;KERNEL;**13**;Jul 10, 1995
 ; *** For DataTree ***
EN S $ZT="ERR^ZU"
 ZITRAP CTRLC^ZU
 S ZUGUI2=($I=1),ZUGUI=$G(ZUGUI1)&$G(ZUGUI2)
 G ^XUS
 ;
G ;Entry Point for GUI devices
 S ZUGUI1=1 G EN
ERR S $ZT="" L  ;Come here on error, save Y and $ZR
 S ZUY=$S($D(Y)#2:Y,1:"undefined"),ZUZR=$ZR 
 B 0 X ^%ZOSF("PROGMODE") Q:Y
 S $ZT="HALT^ZU"
 I $G(IO)]"",$D(IO(1,IO)),$E($G(IOST))="P" U IO W @$S($D(IOF):IOF,1:"#")
 G:$ZE["<INRPT>" CTRLC
 I $ZE["NOPEN>^XUS" I $D(XUEXIT),XUEXIT D C^XUS H  ; Trap <NOPEN> which appears to be due to modem control and breaking micom connection without logging it in ^%ZTER
 I $D(IO)=11 U IO(0) W !!,"RECORDING THAT AN ERROR OCCURED ---",!!?10,$ZE,!!?15,"Sorry 'bout that",!!,*7
 S %ZTERLRG=$ZR,%ZT("^XUTL(""XQ"",$J)")="" D ^%ZTER K %ZT S XUERF="" ; Capture symbol table first!
 I $G(DUZ)'>0 HALT
 ;
CTRLC I $D(IO)=11 U IO(0) C:IO'=IO(0) IO S IO=IO(0)
 W:$ZE["<INRPT>" !,"--Interrupt Acknowledged",!
CTRLC2 G:$G(^XUTL("XQ",$J,"T"))<2 ^XUSCLEAN
 S ^XUTL("XQ",$J,"T")=1,XQY=^(1),XQY0=$P(XQY,"^",2,99)
 G:$P(XQY0,"^",4)'="M" CTRLC2
 S XQPSM=$P(XQY,"^",1),XQY=+XQPSM,XQPSM=$P(XQPSM,XQY,2,3)
 G:'XQY ^XUSCLEAN
 S $ZT="ERR^ZU" G M1^XQ
 ;
HALT S $ZT="" I $D(^XUTL("XQ",$J)) D BYE^XUSCLEAN
 HALT
 ;
