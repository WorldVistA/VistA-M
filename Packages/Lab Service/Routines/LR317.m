LR317 ;DALOI/KLL - LR*5.2*317 PATCH ENVIRONMENT CHECK ROUTINE ;09/21/02
 ;;5.2;LAB SERVICE;**317**;Sep 27, 1994
EN ; Does not prevent loading of the transport global.
 ; Environment check is done only during the install.
 ;
 I '$G(XPDENV) D  Q
 .N XQA,XQAMSG
 .S XQAMSG="Transport global for patch "_$G(XPDNM,"Unknown patch")
 .S XQAMSG=XQAMSG_" loaded on "_$$HTE^XLFDT($H)
 .S XQA("G.LMI")=""
 .D SETUP^XQALERT
 .S MSG="Sending transport global loaded alert to mail group G.LMI"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 ;
 D CHECK
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
 I '$D(^VA(200,$G(DUZ),0))#2 D  Q
 .S MSG="You are not a valid user on this system"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 .S XPDQUIT=2
 ;
 S XPDIQ("XPZ1","B")="NO"
 ;
 Q:'$$PROD^XUPROD  ;LINE ADDED FOR TEST SITES
 ;CHECK FOR UNRELEASED SUPPLEMENTARY REPORTS FROM JUNE 7,2004
 S MSG="Unreleased supplemental report(s) from July 23,2003 until present- must be released before install."
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 S LRSS="AU",LRSDT=3030723-.01 D  S LRSS="CY",LRSDT=3030723-.01 D  S LRSS="EM",LRSDT=3030723-.01 D  S LRSS="SP",LRSDT=3030723-.01 D
 .S LRXR="A"_LRSS
 .F  S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT  S LRDFN=0 F  S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  D
 ..S LRI=0 F  S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  D
 ...S LRNUM=0 F  S LRNUM=$O(^LR(LRDFN,LRSS,LRI,1.2,LRNUM)) Q:'LRNUM  D
 ....I LRSS'="AU" S LRX=$G(^LR(LRDFN,LRSS,LRI,1.2,LRNUM,0))
 ....I LRSS="AU" S LRX=$G(^LR(LRDFN,84,LRNUM,0))
 ....S LRRLS2=+$P(LRX,"^",2)
 ....I 'LRRLS2 D
 .....I $G(^LR(LRDFN,0)) S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 .....I LRDPF=2 S PNM=$P(^DPT(DFN,0),U)
 .....I LRDPF'=2 D
 ......S X=$$GET1^DID(1,LRDPF,"","GLOBAL NAME","ANS","ANS1")
 ......S X=X_DFN_",0)",X=$S($D(@X):@X,1:"") S PNM=$P(X,U)
 .....S MSG="Name: "_PNM_"  Accession: "_$P(^LR(LRDFN,LRSS,LRI,0),U,6)
 .....D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 .....S XPDQUIT=2
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
PRE ; KIDS Pre install for LR*5.2*317
 ;
 N XQA,XQAMSG
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")
 S XQAMSG=XQAMSG_" started on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 S MSG="Sending install started alert to mail group G.LMI"
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install started ***",80))
 ;
 S Y=$$OPTDE^XPDUTL("LRAP",2)
 S MSG="Disabling Anatomic Pathology [LRAP] option"
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install completed ***",80))
 ;
 Q
 ;
POST ; KIDS Post install for LR*5.2*317
 ;
 N XQA,XQAMSG
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install started ***",80))
 ;
 S Y=$$OPTDE^XPDUTL("LRAP",1)
 S MSG="Enabling Anatomic Pathology [LRAP] option"
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,80)) K MSG
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
