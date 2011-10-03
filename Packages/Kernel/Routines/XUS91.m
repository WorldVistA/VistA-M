XUS91 ;SF/STAFF -  REPORT OF USERS SIGNED ON ; [2/20/03 9:19am]
 ;;8.0;KERNEL;**18,65,273**;Jul 10, 1995
 S U="^",XUSUCI="" I $D(^%ZOSF("UCI")) X ^%ZOSF("UCI") S XUSUCI=Y
 S XQHDR="    USER STATUS REPORT      "_XUSUCI
 S %H=$H D YMD^%DTC S DT=X
 W !,"Lookup pass " K ^TMP($J) S XQJN=0
 F I=0:0 S XQJN=$O(^XUTL("XQ",XQJN)) Q:XQJN'>0  S X=XQJN X ^%ZOSF("JOBPARAM") S XQK=$P(Y,U,1) D:(XUSUCI=XQK)!(XQK="UNKNOWN") PASS1
 S IOP="" D ^%ZIS K IOP S XQPG=0,XQUI=0 D NEWPG
PRINT S XQUN=-1 F I=0:0 S XQUN=$O(^TMP($J,XQUN)) Q:(XQUN="")!XQUI  S XQJN=0 F J=0:0 S XQJN=$O(^TMP($J,XQUN,XQJN)) Q:(XQJN="")!XQUI  S XQV=^(XQJN) D LIST
 G END
PASS1 ;
 W "." S XQUN="UNKNOWN" I $D(^XUTL("XQ",XQJN,"DUZ")) S XQUN=^("DUZ"),XQUN=$S($D(^VA(200,XQUN,0)):$P(^(0),U,1),1:"UNKNOWN")
 S XQV="UNKNOWN" I $D(^XUTL("XQ",XQJN,0)) S XQV=$P(^(0),".",2)_"00",XQV=$E(XQV,1,2)_":"_$E(XQV,3,4)
 S XQV=XQV_U_$S('$D(^XUTL("XQ",XQJN,"IO")):"UNKNOWN",1:^("IO"))
 S XQK="UNKNOWN" I $D(^XUTL("XQ",XQJN,"T")),^("T") S XQK=^("T") I $D(^(XQK)) S XQK=$E($P(^(XQK),U,3),1,29)
 I XQK="UNKNOWN",$D(^XUTL("XQ",XQJN,"ZTSK")) S XQJ=^("ZTSK") S:$D(^("XQM")) XQJ=$P(^DIC(19,^("XQM"),0),U,2) S XQK=$E(XQJ,1,18)_" *Tasked"
 S ^TMP($J,XQUN,XQJN)=XQV_U_XQK
 Q
LIST ;
 D:$Y>19 NEWPG Q:XQUI  S (X,Y)=XQJN,X1=16 S:X>32768 Y=$$CNV^XLFUTL(X,16)
 W !,Y,?12,$E(XQUN,1,19),?33,$P(XQV,U,1),?42,$P(XQV,U,2) W:$X>49 ! W ?50,$P(XQV,U,3,99)
 Q
NEWPG ;
 I XQPG,$E(IOST,1)="C" D CON S XQUI=(X="^") Q:XQUI
 D HDR Q
CON ;
 W !!,"Press return to continue or '^' to escape " R X:DTIME S:'$T X=U
 Q
HDR ;
 W @IOF S XQPG=XQPG+1
 S Y=$P($H,",",2)\60,Y=(Y#60/100+(Y\60)/100+DT) D DT^DIO2
 W ?22,XQHDR,?71,"PAGE ",XQPG
 W !!,"JOB NUMBER  USER NAME            TIME ON  DEVICE  CURRENT MENU OPTION"
 W !,"----------  -------------------  -------  ------  ------------------------------"
 Q
END ;
 K XQI,XQJN,XQUN,XUSUCI,ZJ,XQJ,XQK,XQUI,XQPG,XQHDR,XQV,D,J,X,XQM,XQT,Y,Z,^TMP($J)
 Q
 Q
TESTM ;
 W !!,"This option will allow you to simulate signing on as another user to test their",!,"menus and keys.  You can step through menus, but cannot execute options.",!,"Return to your own identity by entering a '*'.",!
 S DIC=200,DIC(0)="AEQMZ" D ^DIC Q:Y<0
 I $S('$D(^VA(200,+Y,201)):1,($P(^VA(200,+Y,201),U,1)=""):1,1:0) W !!,$C(7),"This user has no primary menu.",!,"NOW..Returning to your own identity." Q
 N XUSKFLG S XUSKFLG=$$CHK(+Y)
 I XUSKFLG=-1 D  Q
 .W !!,"   ==>Sorry, Primary Menu for this user is locked."
 .W !,"   NOW..Returning to your own identity."
 S XQY=+^VA(200,+Y,201),DUZ("SAV")=DUZ_U_DUZ(0),DUZ=+Y,DUZ(0)=$P(Y(0),U,4),%=$P(^VA(200,+Y,0),U,1),DUZ("SAV")=DUZ("SAV")_U_$P(%,",",2)_" "_$P(%,",",1) G ^XQ
 Q
TESTN ;
 S DUZ=+DUZ("SAV"),DUZ(0)=$P(DUZ("SAV"),U,2),XQY=+^VA(200,DUZ,201) K DUZ("SAV"),XQUR,XMDUZ
 W !!,"OK...  Returning to your own identity." L  ;Clear all locks
 G ^XQ
CHK(Y) ;
 N XUSPM,XUSPM1,XUSPM2,I,XUSKFLG
 S XUSKFLG=-1
 S XUSPM=$P($G(^VA(200,+Y,201)),"^")
 ;get Key of Primary Menu
 S XUSPM1=$P($G(^DIC(19,XUSPM,0)),"^",6) Q:(XUSPM1="") 0
 S XUSPM2=0 F I=0:0 S XUSPM2=$O(^VA(200,+Y,51,XUSPM2)) Q:XUSPM2'>0  D
 .I $P($G(^DIC(19.1,XUSPM2,0)),"^")=XUSPM1 S XUSKFLG=0
 Q XUSKFLG
