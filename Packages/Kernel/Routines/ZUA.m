ZUA ;SF/LJP - AUDIT ACCESS ;11/17/94  15:07
 ;;8.0;KERNEL;;Jul 10, 1995
FAA ;Return failed access attempts
 K X S X(0)=0 F I=1:1 S X(I)=$O(^%ZUA(3.05,"U",XUF,X(I-1))) Q:X(I)'>0  S %H=$P($H,",",2),$P(^%ZUA(3.05,X(I),0),U,7)=DT_(%H\60#60/100+(%H\3600)+(%H#60/10000)/100)
 Q
FAAL ;Record failed access attempts
 S Z1=XUNOW
F1 L +^%ZUA(3.05,0) I $D(^%ZUA(3.05,Z1,0)) S Z1=Z1+.000001 G F1
 S $P(^(0),"^",3,4)=Z1_"^"_($P(^%ZUA(3.05,0),"^",4)+1)
 S ^%ZUA(3.05,Z1,0)=IOS_U_$P(XUVOL,U,1)_U_XUF(.1)_U_XUT_U_$P(XUCI,",",1)_U_XUF(.3)_U_$S($D(IO("ZIO")):IO("ZIO"),1:"") L -^%ZUA(3.05,0)
 I XUF=2 F I=1:1:XUF(.2) S ^%ZUA(3.05,Z1,1,I,0)=XUF(I)
 ;I XUF(.3) S ^%ZUA(3.05,"U",$P(XUVOL,U,1)_","_$P(XUCI,",",1)_","_XUF(.3),Z1)=""
 K Z1 Q
PRGM ;Programmer mode log.
 S %H=$P($H,",",2),Z1=DT_(%H\60#60/100+(%H\3600)+(%H#60/10000)/100)
P1 L +^%ZUA(3.07,0) I $D(^%ZUA(3.07,Z1,0)) S Z1=Z1+.000001 G P1
 S $P(^(0),"^",3,4)=Z1_"^"_($P(^%ZUA(3.07,0),"^",4)+1)
 S ^%ZUA(3.07,Z1,0)=DUZ_U_$P(XUCI,",",1)_U_$P(XUVOL,U,1) L -^%ZUA(3.07,0)
 K Z1 Q
PURG ;Purge both failed access and programmer mode logs to 30 days.
 S X="T-30",%DT="" D ^%DT Q:Y'>0  S BD=2000000,ED=Y
 F ZUI=3.05,3.07 S BDATE=BD,EDATE=ED D PRG
 K BD,ED
EXIT S:$D(ZTSK) ZTREQ="@" K BDATE,EDATE,REC Q
PMPURG ;Purge programmer mode log.
 S ZUI=3.07 D PRG G EXIT
PURGE ;Purge failed access log.
 S ZUI=3.05 D PRG G EXIT
PRG S C=0 F REC=BDATE-.000001:0 S REC=$O(^%ZUA(ZUI,REC)) Q:REC'>0!(REC>EDATE)  K ^(REC) S C=C+1
 L +^%ZUA(ZUI,0) S $P(^(0),"^",4)=$P(^%ZUA(ZUI,0),"^",4)-C L -^%ZUA(ZUI,0) Q
 ;
