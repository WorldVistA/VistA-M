LA36 ;DALISC/DRH - LAB LA PATCH ENVIRNMENT CHECK ROUTINE  ;8/8/97  09:30 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**36**;Sep 27, 1994
EN ;--> Does not prevent loading of the transport global.
 ;--> Environment check is done only during the install.
 Q:'$G(XPDENV)
 ;
 D CHECK
 ;
EXIT I $G(XPDQUIT) W !!,$$CJ^XLFSTR("Install Environment Check FAILED",80)
 I '$G(XPDQUIT) W !!,$$CJ^XLFSTR("Environment Check is Ok ---",80)
 K VER,RN,LN2
 Q
CHECK I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) W !,$$CJ^XLFSTR("Terminal Device is not defined",80),!! S XPDQUIT=2 QUIT
 ;
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) W !!,$$CJ^XLFSTR("Please Log in to set local DUZ... variables",80),! S XPDQUIT=2 QUIT
 ;
 I '$D(^VA(200,$G(DUZ),0))#2 W !,$$CJ^XLFSTR("You are not a valid user on this system",80),! S XPDQUIT=2 QUIT
 ;
 S VER=$$VERSION^XPDUTL("LR") ;---->Serves for all 5.2 lab
 ;
 I VER'>5.1 W !,$$CJ^XLFSTR("You must have AUTOMATED LAB INSTRUMENTS V5.2 Installed",80),! S XPDQUIT=2 QUIT
 Q
