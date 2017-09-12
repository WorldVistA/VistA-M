LR215 ;DALCIOFO/CKA - LR*5.2*215 PATCH ENVIRONMENT CHECK ROUTINE
 ;;5.2;LAB SERVICE;**215**;Sep 27,1994
EN ; Does not prevent loading of the transport global.
 ;Environment check is done only during the install.
 Q:'$G(XPDENV) 
 D BMES^XPDUTL($$CJ^XLFSTR("*** Environment check started ***",80))
 D CHECK Q:$G(XPDQUIT)
 N DIR,DIC
 D BMES^XPDUTL($$CJ^XLFSTR("This patch installs two new Laboratory Files.",IOM))
 D BMES^XPDUTL($$CJ^XLFSTR("Prior to installation",IOM))
 D BMES^XPDUTL($$CJ^XLFSTR("these files will be purged to ensure data integrity.",IOM))
 D BMES^XPDUTL($$CJ^XLFSTR(" ^DIC(95.3,0) "_$S($D(^DIC(95.3,0)):"has DATA.",1:"Does not have Data.  "),IOM))
 D BMES^XPDUTL($$CJ^XLFSTR("^DIC(95.31,0) "_$S($D(^DIC(95.31,0)):"has DATA.",1:"Does not have Data. "),IOM))
 D BMES^XPDUTL($$CJ^XLFSTR("If you have ANY data in ^DIC(95.3) or ^DIC(95.31) FILES,",IOM))
 D BMES^XPDUTL($$CJ^XLFSTR("these files will be removed!",IOM))
 W ! S DIR(0)="Y",DIR("A")="Do you want to continue"
 S DIR("B")=$S($D(^DIC(95.3,0)):"NO",$D(^DIC(95.31,0)):"NO",1:"YES")
 D ^DIR K DIR
 I $D(DIRUT)!('Y) D  Q
 .D BMES^XPDUTL($$CJ^XLFSTR("Environment check aborted.",IOM))
 .S XPDQUIT=2
 .Q
 Q
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
PRE ;
 Q:'$G(XPDENV)
 I $D(^LAB(95.3,0))#2 D
 .S DIU="^DIC(95.3,",DIU(0)="DST" D EN^DIU2
 K DIU
 I $D(^LAB(95.31,0))#2 D
 .S DIU="^DIC(95.31,",DIU(0)="DST" D EN^DIU2
 K DIU
 D BMES^XPDUTL($$CJ^XLFSTR("*** Preinstall completed ***",80))
 Q
