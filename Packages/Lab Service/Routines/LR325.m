LR325 ;DALOI/JMC - LR*5.2*325 PATCH ENVIRONMENT CHECK ROUTINE ; 4/17/07 3:41am
 ;;5.2;LAB SERVICE;**325**;Sep 27, 1994;Build 34
 ;Reference to $$FIND1^DIC supported by IA #2051
 ;Reference to UPDATE^DIE supported by IA #2053
 ;Reference to $$HTE^XLFDT supported by IA #10103
 ;Reference to $$CJ^XLFSTR supported by IA #10104
 ;Reference to BMES^XPDUTL supported by IA #10141
 ;Reference to SETUP^XQALERT supported by IA #10081
 ;Reference to $$ACTIVE^XUSER supported by IA #2343
EN ; Does not prevent loading of the transport global.
 ; Environment check is done only during the install.
 ;
 N XQA,XQAMSG
 ;
 I '$G(XPDENV) D  Q
 . S XQAMSG="Transport global for patch "_$G(XPDNM,"Unknown patch")_" loaded on "_$$HTE^XLFDT($H)
 . S XQA("G.LMI")=""
 . D SETUP^XQALERT
 . D BMES^XPDUTL($$CJ^XLFSTR("Sending transport global loaded alert to mail group G.LMI",IOM))
 ;
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" started on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 D BMES^XPDUTL($$CJ^XLFSTR("Sending install started alert to mail group G.LMI",IOM))
 ;
 D CHECK
 D EXIT
 Q
 ;
CHECK ; Perform environment check
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("Terminal Device is not defined",80))
 . S XPDQUIT=2
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("Please log in to set local DUZ... variables",80))
 . S XPDQUIT=2
 I $P($$ACTIVE^XUSER(DUZ),"^")'=1 D  Q
 . D BMES^XPDUTL($$CJ^XLFSTR("You are not a valid user on this system",80))
 . S XPDQUIT=2
 S XPDIQ("XPZ1","B")="NO"
 Q
 ;
EXIT ;
 I $G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Install Environment Check FAILED ---",IOM))
 I '$G(XPDQUIT) D BMES^XPDUTL($$CJ^XLFSTR("--- Environment Check is Ok ---",IOM))
 Q
 ;
PRE ; KIDS Pre install
 ;
 Q
 N DA,DIK
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install started ***",IOM))
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("Nothing required",IOM))
 D BMES^XPDUTL($$CJ^XLFSTR("*** Pre install completed ***",IOM))
 Q
 ;
POST ; KIDS Post install
 N ANS,FDA,LROUTINE,LRTST,TST,XQA,XQAMSG
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install started ***",IOM))
 S LROUTINE=$$FIND1^DIC(62.05,,"B","ROUTINE","B",,"ANS")
 I 'LROUTINE S LROUTINE=$O(^LAB(62.05,0))
 S LRTST=$$FIND1^DIC(60,,"B","VBEC QA/QC","B",,"ANS")
 I 'LRTST D
 . K FDA(1)
 . S FDA(1,60,"?+1,",.01)="VBEC QA/QC"
 . S FDA(1,60,"?+1,",3)="N"
 . S FDA(1,60,"?+1,",4)="WK"
 . S FDA(1,60,"?+1,",17)=LROUTINE
 . S FDA(1,60,"?+1,",51)="V QA/QC"
 . D UPDATE^DIE("SE","FDA(1)","TST","ANS")
 . D BMES^XPDUTL($$CJ^XLFSTR("Added test [VBEC QA/QC] to LABORATORY TEST file",IOM))
 S LRTST=$$FIND1^DIC(60,,"B","VBEC UNIT PROCESSING","B",,"ANS")
 I 'LRTST D
 . K FDA(2),TST
 . S FDA(2,60,"?+1,",.01)="VBEC UNIT PROCESSING"
 . S FDA(2,60,"?+1,",3)="N"
 . S FDA(2,60,"?+1,",4)="WK"
 . S FDA(2,60,"?+1,",17)=LROUTINE
 . S FDA(2,60,"?+1,",51)="V UNIT"
 . D UPDATE^DIE("SE","FDA(2)","TST","ANS")
 . D BMES^XPDUTL($$CJ^XLFSTR("Added test [VBEC UNIT PROCESSING] to LABORTORY TEST file",IOM))
 S LRTST=$$FIND1^DIC(60,,"B","VBEC DONOR","B",,"ANS")
 I 'LRTST D
 . K FDA(3),TST
 . S FDA(3,60,"?+1,",.01)="VBEC DONOR"
 . S FDA(3,60,"?+1,",3)="N"
 . S FDA(3,60,"?+1,",4)="WK"
 . S FDA(3,60,"?+1,",17)=LROUTINE
 . S FDA(3,60,"?+1,",51)="V DONOR"
 . D UPDATE^DIE("SE","FDA(3)","TST","ANS")
 . D BMES^XPDUTL($$CJ^XLFSTR("Added Test [VBEC DONOR] to LABORATORY TEST file",IOM))
 D BMES^XPDUTL($$CJ^XLFSTR("Sending install completion alert to LMI mail group ",IOM))
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 S XQAMSG="LIM: Review description for "_$G(XPDNM,"Unknown patch")_" use KIDS:Utilities:Build File Print"
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 Q
