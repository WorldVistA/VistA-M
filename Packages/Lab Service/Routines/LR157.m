LR157 ;DALISC/SED - LR*5.2*157 PATCH ENVIRNMENT CHECK ROUTINE
 ;;5.2;LAB SERVICE;**157**;Oct 20, 1996
EN ; Does not prevent loading of the transport global.
 ;Environment check is done only during the install.
 Q:'$G(XPDENV)
 D CHECK
EXIT I $G(XPDQUIT) W !!,$$CJ^XLFSTR("Install Environment Check FAILED",80)
 I '$G(XPDQUIT) W !!,$$CJ^XLFSTR("Environment Check is Ok ---",80)
 K VER,RN,LN2
 Q
CHECK I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) W !,$$CJ^XLFSTR("Terminal Device is not defined",80),!! S XPDQUIT=2 Q
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) W !!,$$CJ^XLFSTR("Please Log in to set local DUZ... variables",80),! S XPDQUIT=2 Q
 I '$D(^VA(200,$G(DUZ),0))#2 W !,$$CJ^XLFSTR("You are not a valid user on this system",80),! S XPDQUIT=2 Q
lab S VER=$$VERSION^XPDUTL("LR")
 I VER'>5.1 W !,$$CJ^XLFSTR("You must have LAB V5.2 Installed",80),! S XPDQUIT=2 Q
 Q
POST ;START THE POST INIT HERE
 ;REMOVE THE ALPHA/BETA ENTRY OF LAB
REM S X="LR",IEN=""
 S IEN=$O(^DIC(9.4,"C",X,0)) S:IEN'>0 IEN=$O(^DIC(9.4,"B",X,0))
 Q:+IEN'>0
 Q:'$D(^XTV(8989.3,1,"ABPKG",0))
 S IAB=0 F  S IAB=$O(^XTV(8989.3,1,"ABPKG",IAB)) Q:+IAB'>0  D
 .Q:'$D(^XTV(8989.3,1,"ABPKG",IAB,0))
 .Q:$P(^XTV(8989.3,1,"ABPKG",IAB,0),U,1)'=IEN
 .S DIK="^XTV(8989.3,1,"_"""ABPKG"""_",",DA(1)=1,DA=IAB D ^DIK
 K DA,X,IEN,IAB
 Q
