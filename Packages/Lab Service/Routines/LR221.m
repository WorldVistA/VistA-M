LR221 ;DALISC/FHS-LR*5.2*221 PATCH ENVIRONMENT CHECK ROUTINE
 ;;5.2;LAB SERVICE;**221**;Sep 27, 1994
EN ; Does not prevent loading of the transport global.
 ; Environment check is done only during the install.
 Q:'$G(XPDENV)
 D CHECK
 D EXIT
 Q
 ;
CHECK ; Perform environment check
 N VER
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("Terminal Device is not defined",80))
 . S XPDQUIT=2
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("Please log in to set local DUZ... variables",80))
 . S XPDQUIT=2
 I '$D(^VA(200,$G(DUZ),0))#2 D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("You are not a valid user on this system",80))
 . S XPDQUIT=2
 ; I '$$PATCH^XPDUTL("LR*5.2*202") D  Q
 ; . D BMES^XPDUTL($$CJ^XLFSTR("You must install patch LR*5.2*202",80))
 ; . S XPDQUIT=2
 S XPDIQ("XPZ1","B")="NO"
 Q
 ;
EXIT ;
 I $G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Install Environment Check FAILED ---",80))
 I '$G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Environment Check is Ok ---",80))
 Q
 ;
PRE ; KIDS Pre install for LR*5.2*221
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install started ***",80))
 D BMES^XPDUTL($$CJ^XLFSTR("--- No actions required for pre install ---",80))
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install completed ***",80))
 Q
 ;
POST ; KIDS Post install for LR*5.2*221
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install started ***",80))
 K ^LRO(69,"AE") S:$D(^LAM(0))#2 $P(^(0),U,3)=99999
 D BMES^XPDUTL($$CJ^XLFSTR("--- Purged ^LRO(69,""AE"") X-Ref ---",80))
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install completed ***",80))
 Q
