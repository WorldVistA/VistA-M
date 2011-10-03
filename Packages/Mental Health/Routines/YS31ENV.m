YS31ENV ;DALCIOFO/MJD-YS*5.01*31 PATCH ENVIRONMENT CHECK ROUTINE ;10/30/97
 ;;5.01;MENTAL HEALTH;**31**;Dec 30, 1994
EN ; Does not prevent loading of the transport global.
 ;Environment check is done only during the install.
 QUIT:'$G(XPDENV)
 D CHECK
 ;
EXIT I $G(XPDQUIT) W !!,$$CJ^XLFSTR("Install Environment Check FAILED",80)
 I '$G(XPDQUIT) W !!,$$CJ^XLFSTR("Environment Check is Done...",80)
 K VER,RN,LN2
 QUIT
 ;
CHECK ;
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) W !,$$CJ^XLFSTR("Terminal Device is not defined",80),!! S XPDQUIT=2 Q
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) W !!,$$CJ^XLFSTR("Please Log in to set local DUZ... variables",80),! S XPDQUIT=2 Q
 I '$D(^VA(200,$G(DUZ),0))#2 W !,$$CJ^XLFSTR("You are not a valid user on this system",80),! S XPDQUIT=2 Q
 S VER=$$VERSION^XPDUTL("MENTAL HEALTH")
 I VER'=5.01 W !,$$CJ^XLFSTR("You must have Mental Health V 5.01 Installed",80),! S XPDQUIT=2 Q
 QUIT
 ;
EOR ;;YS*5.01*31 PATCH ENVIRONMENT CHECK ROUTINE;;
