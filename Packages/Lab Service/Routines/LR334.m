LR334 ;DALOI/FHS - LR*5.2*334 PATCH ENVIRONMENT CHECK ROUTINE;31-AUG-2001
 ;;5.2;LAB SERVICE;**334**;Sep 27, 1994;Build 12
 ;; IA# 4640 Set file/field implementation statusSet file/field implementation status
ENV ; Does not prevent loading of the transport global.
 ; Environment check is done only during the install.
 ;
 N XQA,XQAMSG
 ;
CHKNM ; Make sure the patch name exist
 S XUMF=1
 I '$D(XPDNM) D  G EXIT
 . D BMES("No valid patch name exist")
 . S XPDQUIT=2
 ;
 D CHECK
 D EXIT
 Q
 ;
CHECK ; Perform environment check
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D
 . D BMES("Terminal Device is not defined")
 . S XPDQUIT=2
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D
 . D BMES("Please log in to set local DUZ... variables")
 . S XPDQUIT=2
 I $P($$ACTIVE^XUSER(DUZ),"^")'=1 D
 . D BMES("You are not a valid user on this system")
 . S XPDQUIT=2
 S XPDIQ("XPZ1","B")="NO" Q
EXIT ;
 N XQA
 I $G(XPDQUIT) D BMES("--- Install Environment Check FAILED ---") Q
 D BMES("--- Environment Check is Ok ---")
 S XQAMSG="Loading of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)
 D BMES("Sending install loaded alert to mail group G.LMI")
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 H 5
 Q
 ;
PRE ;Pre-install entry point
 Q:'$D(XPDNM)
 ;Remove old data
 D
 . N DIK,DA,DIU
 . S DIK="^DD(60,",DA(1)=60,DA=64 D ^DIK K DIK
 . S DIK="^DD(64,",DA(1)=64,DA=25 D ^DIK K DIK
 . S DIU="^LAB(64.81,",DIU(0)="DS" D EN^DIU2
 . K DIU
 . S DIU="^LAB(95.3,",DIU(0)="DS" D EN^DIU2
 . K DIU
 . S DIU="^LAB(95.31,",DIU(0)="DS" D EN^DIU2
 . K DIU
 . S DIU="^LAB(64.061,",DIU(0)="DS" D EN^DIU2
 . K DIU
 . S DIU="^LAB(64.2,",DIU(0)="DS" D EN^DIU2
 . K DIU
 . S DIU="^LAB(64.3,",DIU(0)="DS" D EN^DIU2
 . K DIU
 . S DIU="^LAB(64.062",DIU(0)="DS" D EN^DIU2
 . K DIU
 D BMES("*** Preinstall completed ***")
 Q
POST ;Post install
 D POST^LR334PO
DD ;Purge .001 from installed files
 I '$G(LRDBUG) D
 . F LRDA=64.2,64.3,64.061,64.062,95.3,95.31 D
 . . N DA,DIK
 . . S DA(1)=LRDA,DA=.001,DIK="^DD("_LRDA_","
 . . D ^DIK
 . N DIK
 . S DIK="^LAM(" D IXALL^DIK
 D
 . S $P(^LAM(0),U,3)=99999,LRVR="2.14"_$T(+2)
 . S ^LAM("VR")=LRVR
 . N LRI
 . F LRI=64.061,64.2,64.21,64.22,64.3,95.3,95.31 I $D(^LAB(LRI,0))#2 S ^LAB(LRI,"VR")=LRVR
 I $T(SETSTAT^HDISVF01)'="" D
 . D SETSTAT^HDISVF01(95.3,"",6,"")
 D
 . D BMES("Sending install completion alert to mail group G.LMI")
 . S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)
 . S XQA("G.LMI")=""
 . D SETUP^XQALERT
 K LRDA,LRPRT,LRVR
 Q
BMES(STR) ;Write BMES^XPDUTL statements
 D BMES^XPDUTL($$CJ^XLFSTR(STR,IOM))
 Q
MAIL ;Send message to G.LMI local mail group of added 64 codes
 N DIFROM,XMSUB,XMDUZ,XMTEXT,XMY,LRIEN,LRN
NEWLST ;Build list of added WKLD CODES
 ;D BMES("Building List Of Added NLT CODEs")
 K LRLAST64
 I '$O(^XTMP("LRNLT","LR334",1,3)) D
 . I '$G(LRPRT) D
 . . D SCR^LR334PO("No WKLD CODES Added to Database")
 D BMES("Sending message to LMI Mail Group.")
 D
 . NEW XMSUB,XMY,XMTEST,XMDUZ
 . S XMSUB="ADDED WKLD CODE REPORT "_$$FMTE^XLFDT($$NOW^XLFDT,"1S")
 . S XMY("G.LMI")="",XMTEXT="^XTMP(""LRNLT"",""LR334"",1,",XMDUZ=.5
 . D ^XMD
 . D BMES("List Of Added WKLD CODEs Complete")
 Q
