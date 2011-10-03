ECTPNUR ;B'ham ISC/PTD-Nursing Personnel Inquiry ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;**1**;
 I '$D(^DIC(210,0,"GL")) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'Nurs Staff' File - #210 is not loaded on your system.",!! S XQUIT="" Q
 S GLRT=^DIC(210,0,"GL") I '$O(@(GLRT_"0)")) W *7,!!,"'Nurs Staff' File - #210 has not been populated on your system.",!! S XQUIT="" G EXIT
 ;S VER="",PKGDA=$O(^DIC(9.4,"C","NURS",0)) S:'PKGDA XQUIT="" G:'PKGDA EXIT S:$D(^DIC(9.4,PKGDA,"VERSION")) VER=$P(^("VERSION"),"^") G:VER<2 DIC
 ;IF RUNNING VERSION 2, MAKE DIRECT CALL TO EXTERNAL ROUTINE
 ;S X="NURSASP" X ^%ZOSF("TEST") G:$T=0 DIC D ^NURSASP G EXIT
 ;
DIC W !! S DIC=GLRT,DIC(0)="QEAM",DIC("A")="Select NURSE name: " D ^DIC G:Y<0 EXIT S DA=+Y
 K %ZIS S IOP="HOME" D ^%ZIS K %ZIS,IOP W @IOF,!!?30,"NURSE EMPLOYEE DATA:",!!
 D EN^DIQ K DIC,Y,DA G DIC
EXIT K %,%W,%Y,A,B,D0,D1,D2,DIC,DA,GLRT,NPWARD,NURSX,NX,P,PKGDA,POP,S,VER,X,Y
 Q
 ;
