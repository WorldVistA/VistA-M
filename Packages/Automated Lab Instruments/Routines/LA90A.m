LA90A ;DSS/FHS - VLE MICRO ENHANCEMENT INSTALL SUPPORT;12/06/16  10:27
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**90**;Sep 27, 1994;Build 17
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
 . D BMES("Terminal Device is not defined")
 . S XPDQUIT=2
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D  Q
 . D BMES("Please log in to set local DUZ... variables")
 . S XPDQUIT=2
 I '$D(^VA(200,+$G(DUZ),0))#2 D  Q
 . D BMES("You are not a valid user on this system")
 . S XPDQUIT=2
 S XPDIQ("XPZ1","B")="NO"
 Q
 ;
EXIT ;
 I $G(XPDQUIT) D BMES("--- Install Environment Check FAILED ---")
 I '$G(XPDQUIT) D BMES("--- Environment Check is Ok ---")
 Q
 ;
PRE ; KIDS Pre install for LA*5.2*90
 N XQA,XQAMSG,MSG,LRCROSS,LRROOT,LRMSG
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")
 S XQAMSG=XQAMSG_" started on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 S MSG="Sending install started alert to mail group G.LMI"
 D BMES(MSG)
 D BMES("*** Pre install started ***")
 S LRCROSS=0
 F  S LRCROSS=+$O(^DD(62.41,.01,1,LRCROSS)) Q:LRCROSS<1  Q:$P(^(LRCROSS,0),U,3)="TRIGGER"
 I LRCROSS<1 D BMES("--- No actions required for pre install ---")
 I LRCROSS D
 . D BMES("Deleting Traditional Cross Reference")
 . D DELIX^DDMOD(62.41,.01,LRCROSS,"K","LRROOT","LRMSG")
 D BMES("*** Pre install completed ***")
 Q
 ;
POST ; KIDS Post install for LA*5.2*90
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")
 S XQAMSG=XQAMSG_" completed on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 D BMES("Installation completed")
 Q
BMES(STR) ;Print string to screen and package install file
 D BMES^XPDUTL($$CJ^XLFSTR(STR,IOM))
