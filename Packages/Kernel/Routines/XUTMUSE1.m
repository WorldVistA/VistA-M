XUTMUSE1 ;SEA/RDS - TM; Option XUTMUSER, Print ;4/20/95  11:34
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
DEVICE ;ACT Subroutine--Allow User To Select Device For Output
 W ! S %ZIS="Q",%ZIS("A")="On what device do you want your task to be printed? " D ^%ZIS Q:POP  G QUEUE:$D(IO("Q")) N %H,ZTD,ZTL,XUTMT,ZTX U IO
 ;
PRINT ;Print User's Task
 D EN^XUTMTP(ZTSK),^%ZISC:'$D(ZTQUEUED) Q
 ;
QUEUE ;Queue Print Job
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE S ZTDESC="TaskMan:  Print Task # "_ZTSK_" For "_ZTNAME,ZTRTN="TASK^XUTMUSE1",ZTSAVE("XUTMU")=ZTSK,ZTSAVE("ZTNAME")=ZTNAME,ZTSAVE("XUTMUCI")=XUTMUCI K ZTIO N ZTSK,XUTMUCI
 D ^%ZTLOAD W !!,$S($D(ZTSK)#2:"Printout queued.",1:"Printout not queued.") Q
 ;
TASK ;Code To Startup Queued Print Job
 S XUTMT=XUTMU,XUTMT(0)="L" D ^XUTMT I ZTSK="" W !!,"Task # ",XUTMU," is no longer defined, and can therefore not be printed." Q
 G PRINT
 ;
