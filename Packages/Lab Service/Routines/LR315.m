LR315 ;DALOI/KLL/CKA - LR*5.2*315 PATCH ENVIRONMENT CHECK ROUTINE ;09/21/07
 ;;5.2;LAB SERVICE;**315**;Sep 27, 1994;Build 25
EN ; Does not prevent loading of the transport global.
 ;
 I '$G(XPDENV) D  Q
 .N XQA,XQAMSG,MSG
 .S XQAMSG="Transport global for patch "_$G(XPDNM,"Unknown patch")
 .S XQAMSG=XQAMSG_" loaded on "_$$HTE^XLFDT($H)
 .S XQA("G.LMI")=""
 .D SETUP^XQALERT
 .S MSG="Sending transport global loaded alert to mail group G.LMI"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 ;
 D CHECK
 I XPDENV S XPDDIQ("XPZ1","B")="YES"
 D EXIT
 Q
 ;
CHECK ; Perform environment check
 ;
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D  Q
 .D BMES^XPDUTL($$CJ^XLFSTR("Terminal Device is not defined",80))
 .S XPDQUIT=2
 ;
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D  Q
 .S MSG="Please log in to set local DUZ... variables"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 .S XPDQUIT=2
 ;
 I '($$ACTIVE^XUSER(DUZ)) D  Q
 .S MSG="You are not a valid user on this system"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 .S XPDQUIT=2
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")
 S XQAMSG=XQAMSG_" started on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 S MSG="Sending install started alert to mail group G.LMI"
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 ;
 ;
 ;
 Q
 ;
EXIT ;
 I $G(XPDQUIT) D
 .S MSG="--- Install Environment Check FAILED ---"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 I '$G(XPDQUIT) D
 .D BMES^XPDUTL($$CJ^XLFSTR("--- Environment Check is Ok ---",80))
 Q
 ;
PRE ; KIDS Pre install for LR*5.2*315
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install started ***",80))
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install completed ***",80))
 ;
 Q
 ;
POST ; KIDS Post install for LR*5.2*315
 ;
 N XQA,XQAMSG,MSG
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install started ***",80))
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install completed ***",80))
 ;
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")
 S XQAMSG=XQAMSG_" completed on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 S MSG="Sending install completion alert to mail group G.LMI"
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 ;
 Q
