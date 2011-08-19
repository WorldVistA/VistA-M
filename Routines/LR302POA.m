LR302POA ;DALOI/FHS - LR*5.2*302 PATCH POST INSTALL ROUTINE CONTINUED;31-AUG-2001
 ;;5.2;LAB SERVICE;**302**;Sep 27,1994
 Q
ALERT ;
 D BMES^LR302("Sending installation message to G.LMI mail group")
 N XQA,XQAMSG
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown Patch")_" complete "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 L -^LAM
 Q
MAIL ;Send message to G.LMI local mail group of added 64 codes
 N DIFROM,XMSUB,XMDUZ,XMTEXT,XMY,LRIEN,LRN
NEWLST ;Build list of added WKLD CODES
 D BMES^LR302("Building List Of Added NLT CODEs")
 K LRLAST64
 I '$O(^XTMP("LRNLT","LR302",1,3)) D
 . I '$G(LRPRT) D
 . . D SCR^LR302PO("No WKLD CODES Added to Database")
 D BMES^LR302("Sending message to LMI Mail Group.")
 D
 . NEW XMSUB,XMY,XMTEST,XMDUZ
 . S XMSUB="ADDED WKLD CODE REPORT "_$$FMTE^XLFDT($$NOW^XLFDT,"1S")
 . S XMY("G.LMI")="",XMTEXT="^XTMP(""LRNLT"",""LR302"",1,",XMDUZ=.5
 . D ^XMD
 . D BMES^LR302("List Of Added WKLD CODEs Complete")
CHK642 ;Looking for locally added suffix
 K DIFROM,XMSUB,XMDUZ,XMTEXT,XMY
 N LRSC,LRCNT,LRNX,LRI
 S LRSC="",LRCNT=0
 M ^XTMP("LRNLT642SAVE")=^XTMP("LRNLT642") ;Backup copy of 64.2
 F  S LRCNT=$O(^XTMP("LRNLT642",1,LRCNT)) Q:LRCNT<1  K ^XTMP("LRNLT642",1,LRCNT,1)
 S LRNX="^XTMP(""LRNLT642"",1,""C"")"
 F  S LRNX=$Q(@LRNX) Q:$QS(LRNX,3)'="C"  D
 . I $D(^LAB(64.2,"C",$QS(LRNX,4))) D  Q
 . . K ^XTMP("LRNLT642",1,$QS(LRNX,5))
 . W:$G(LRDBUG) !,LRNX
 F LRI="AC","B","C","D","E","F" K ^XTMP("LRNLT642",1,LRI)
MES642 ;
 I $O(^XTMP("LRNLT642",1,0)) D
 . N XMSUB,XMY,XMTEXT,XMDUZ
 . S XMSUB=$TR($P($$SITE^VASITE,U,1,2),U,"|")_" LR 302 - 64 2 "_DT
 . S XMY("STALLING.FRANK@FS.ISC-ALBANY.MED.VA.GOV")=""
 . S XMY("G.LMI")=""
 . S XMTEXT="^XTMP(""LRNLT642"",1,",XMDUZ=.5
 . D ^XMD
MESLMI ; Notify LIM patch is installed.
 D
 . NEW XQA,XQAMSG
 . S XQAMSG="LIM: Review description for "_$G(XPDNM,"Unknown patch")_" use KIDS:Utilities:Build File Print"
 . S XQA("G.LMI")=""
 . D SETUP^XQALERT
 Q
