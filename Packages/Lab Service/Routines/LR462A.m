LR462A ;DALOI/FHS - LR*5.2*462 PATCH ENVIRONMENT CHECK ROUTINE;15-DEC-2015 ;09/01/16  15:52
 ;;5.2;LAB SERVICE;**462**;Sep 27, 1994;Build 44
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
 ;
 D BMES("*** Preinstall completed ***")
 Q
POST ;Post install
 ;Set up CPRS AP ORDER MESSAGE LOG -
 ;CPRS AP ORDER MESSAGE IS STORE HERE FOR PROCESSING BY "TASKAP1^LR7OAPKM"
 I '$G(^XTMP("LRAP1",0)) D
 . S ^XTMP("LRAP1",0)=$$FMADD^XLFDT(DT+365)_U_DT_U_"CPRS AP ORDER MESSAGE LOG"
 . S ^XTMP("LRAP1",1,0)=10
 S $P(^XTMP("LRAP1",0),U,3)="CPRS AP ORDER MESSAGE LOG"
 D
 . D BMES("Sending install completion alert to mail group G.LMI")
 . S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" Installed on "_$$HTE^XLFDT($H)
 . S XQA("G.LMI")=""
 . D SETUP^XQALERT
 K LRDA,LRPRT,LRVR
 Q
BMES(STR) ;Write BMES^XPDUTL statements
 D BMES^XPDUTL($$CJ^XLFSTR(STR,IOM))
 Q
MAIL ;Send message to G.LMI local mail group of added 64 codes
 N DIFROM,XMSUB,XMDUZ,XMTEXT,XMY,LRIEN,LRN
 Q
