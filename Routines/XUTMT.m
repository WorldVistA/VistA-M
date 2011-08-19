XUTMT ;SEA/RDS - TaskMan: ToolKit, Entry ;9/14/94  10:09
 ;;8.0;KERNEL;;Jul 10, 1995
BRANCH ;
 ;Select Module Based On XUTMT(0)
 K ZTSK S ZTSK=""
 I XUTMT(0)="P" D EN^XUTMTP(XUTMT) Q
 I XUTMT(0)="PD" G ^XUTMTPD
 I XUTMT(0)="PU" G ^XUTMTPU
 I XUTMT(0)="AL" G ^XUTMTAL
 I XUTMT(0)["A" G ^XUTMTA
 I XUTMT(0)="D" G ^XUTMTD
 I XUTMT(0)="DL" G ^XUTMTDL
 I XUTMT(0)="L" G ^XUTMTL
B1 ;
 I XUTMT(0)="LD" G ^XUTMTLD
 I XUTMT(0)="LU" G ^XUTMTLU
 I XUTMT(0)="R1" D EN^XUTMTP(XUTMT,"",1)
 I XUTMT(0)="R2" G ^XUTMTR2
 I XUTMT(0)="R3" G ^XUTMTR3
 I XUTMT(0)="R4" G ^XUTMTR4
 I XUTMT(0)="S" G ^XUTMTS
 I XUTMT(0)="U" G ^XUTMTU
 I XUTMT(0)="UL" G ^XUTMTUL
B2 ;
 W !!,$C(7),$C(7),"Tool ",XUTMT(0)," is not supported by the tool kit.",!!
 Q
 ;
XQ ;
 ;MenuMan Entry Point For Unscheduling Server Requests
 S XUTMT=ZTSK,ZTNAME="MenuMan" X ^%ZOSF("UCI") S XUTMUCI=Y G ^XUTMTU Q
 ;
