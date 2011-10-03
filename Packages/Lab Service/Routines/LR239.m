LR239 ;DALCIOFO/CKA - LR*5.2*239 PATCH ENVIRONMENT CHECK ROUTINE
 ;;5.2;LAB SERVICE;**239**;Sep 27,1994
EN ; Does not prevent loading of the transport global.
 ;Environment check is done only during the install.
 Q:'$G(XPDENV) 
 D BMES^XPDUTL($$CJ^XLFSTR("*** Environment check started ***",80))
 D CHECK Q:$G(XPDQUIT)
EXIT I $G(XPDQUIT) W !!,$$CJ^XLFSTR("Install Environment Check FAILED",IOM)
 I '$G(XPDQUIT) W !!,$$CJ^XLFSTR("Environment Check is Ok ---",IOM)
 K VER,RN,LN2
 Q
CHECK I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) W !,$$CJ^XLFSTR("Terminal Device is not defined",IOM),!! S XPDQUIT=2 Q
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) W !!,$$CJ^XLFSTR("Please Log in to set local DUZ... variables",80),! S XPDQUIT=2 Q
 I '$D(^VA(200,$G(DUZ),0))#2 W !,$$CJ^XLFSTR("You are not a valid user on this system",80),! S XPDQUIT=2 Q
 S VER=$$VERSION^XPDUTL("LR")
 I VER'>5.1 W !,$$CJ^XLFSTR("You must have LAB V5.2 Installed",IOM),! S XPDQUIT=2 Q
 S VER=$$VERSION^XPDUTL("NLT")
 I VER'=5.254 W !,$$CJ^XLFSTR("You must have NLT V5.254 Installed",IOM),! S XPDQUIT=2 Q
 Q
