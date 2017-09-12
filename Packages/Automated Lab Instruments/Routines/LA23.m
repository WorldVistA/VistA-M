LA23 ;DALISC/JMC - LA*5.2*23 PATCH ENVIRONMENT CHECK ROUTINE
 ;;5.2;LAB SERVICE;**23**;Feb 14, 1996
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
 S VER=$$VERSION^XPDUTL("LA7")
 I VER'>5.1 D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("You must have LAB MESSAGING V5.2 Installed",80))
 . S XPDQUIT=2
 I '$$PATCH^XPDUTL("LA*5.2*25") D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("You must install patch LA*5.2*25",80))
 . S XPDQUIT=2
 ; Set lock if site using autodownload.
 I $D(^LAB(62.4,"AE")) D  Q:$G(XPDQUIT)
 . L +^LA("ADL",0):10 Q:$T
 . S XPDQUIT=2
 . D BMES^XPDUTL("Unable to obtain lock on ^LA(""ADL"",0) node, auto download (LA7ADL) running!")
 . D BMES^XPDUTL("Install aborted!")
 ; Set lock to prevent LA7UIIN processing routine from running.
 L +^LAHM(62.49,"Z"):10
 I '$T D
 . S XPDQUIT=2
 . D BMES^XPDUTL("Unable to obtain lock on ^LAHM(62.49,""Z"") node, UI processing (LA7UIIN) running!")
 . D BMES^XPDUTL("Install aborted!")
 S XPDIQ("XPZ1","B")="NO"
 Q
 ;
EXIT ;
 I $G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Install Environment Check FAILED ---",80))
 I '$G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Environment Check is Ok ---",80))
 Q
 ;
POST ; KIDS Post install for LA*5.2*23
 N X
 S X=$$ADD^XPDMENU("LA INTERFACE","LA7 MAIN MENU")
 D BMES^XPDUTL("Option [LA7 MAIN MENU] was "_$S(X:"added",1:"NOT ADDED")_" to [LA INTERFACE] MENU")
 D BMES^XPDUTL("Moving entries in global ^LA(""ADL"",uid) to ^LA(""ADL"",""Q"",uid)")
POST1 S X=0
 F  S X=$O(^LA("ADL",X)) Q:X=""  D
 . I X="Q"!(X="STOP") Q
 . S ^LA("ADL","Q",X)=""
 . K ^LA("ADL",X)
 D BMES^XPDUTL($$CJ^XLFSTR("Post install completed",80))
 I $D(^LAB(62.4,"AE")) D
 . L -^LA("ADL",0)
 L -^LAHM(62.49,"Z")
 Q
