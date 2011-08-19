ECTFCPB ;B'ham ISC/PTD-Display Control Point Official's Balance ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^PRCS(410)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'Control Point Activity' File - #410 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^PRCS(410,0)) W *7,!!,"'Control Point Activity' File - #410 has not been populated on your system.",!! S XQUIT="" Q
 ;CHECK VERSION OF IFCAP ON SYSTEM
 S VER="",PKGDA=$O(^DIC(9.4,"C","PRC",0)) S:'PKGDA XQUIT="" G:'PKGDA EXIT S:$D(^DIC(9.4,PKGDA,"VERSION")) VER=$P(^("VERSION"),"^") S RTN=$S(VER<3:"^PRCFBRBR",1:"^PRCBRBR")
 S X=$P(RTN,"^",2) X ^%ZOSF("TEST") I $T=0 W *7,!!,RTN," routine does not exist on your system!" G EXIT
 K %ZIS S IOP="HOME" D ^%ZIS K %ZIS,IOP W @IOF,!!
 ;DIRECT CALL TO EXTERNAL ROUTINE
 D @RTN
EXIT K C,DA,DATETIME,J,LINE,PAGE,PKGDA,POP,PRC,RTN,VER,X,ZZ
 Q
 ;
