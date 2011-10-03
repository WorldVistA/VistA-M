LR274POA ;DALOI/FHS - LR*5.2*274 PATCH POST INSTALL ROUTINE CONTINUED
 ;;5.2;LAB SERVICE;**274**;Sep 27,1994
 Q
ALERT ;
 D BMES^XPDUTL($$CJ^XLFSTR("Sending installation message to G.LMI mail group",80))
 N XQA,XQAMSG
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown Patch")_" complete "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 L -^LAM
 Q
MAIL ;Send message to G.LMI local mail group of added 64 codes
 N DIFROM,XMSUB,XMDUZ,XMTEXT,XMY,LRIEN,LRN
NEWLST ;Build list of added WKLD CODES
 D
 . D BMES^XPDUTL($$CJ^XLFSTR("Building List Of Added WKLD CODEs",80))
 . N LRN,LRIEN,LRSTR,LRCNT
 . S LRCNT=0
 . S LRN="^LAM(""B"")" S:'$G(LRLAST64) LRLAST64=3203
 . F  S LRN=$Q(@LRN) Q:$QS(LRN,1)'="B"  I '@LRN D
 . . S LRIEN=$QS(LRN,3)
 . . I LRIEN>LRLAST64,LRIEN<99999,$D(^LAM(LRIEN,0))#2 S LRSTR=$P(^(0),U,1,2) D
 . . . S LRCNT=$G(LRCNT)+1
 . . . S LRSTR=LRCNT_"|"_$TR(LRSTR,"^","|")_"|IEN= "_LRIEN
 . . . D SCR^LR274PO(LRSTR)
 . D BMES^XPDUTL($$CJ^XLFSTR("List Of Added WKLD CODEs Complete",80))
 K LRLAST64
 I '$O(^XTMP("LRNLT",$J,1,3)) D
 . I '$G(LRPRT) D
 . . D SCR^LR274PO("No WKLD CODES Added to Database")
 D BMES^XPDUTL($$CJ^XLFSTR("Sending message to LMI Mail Group.",80))
 S XMSUB="ADDED WKLD CODE REPORT "_$$FMTE^XLFDT($$NOW^XLFDT,"1S")
 S XMY("G.LMI")="",XMTEXT="^XTMP(""LRNLT"","_$J_",1,",XMDUZ=.5
 D ^XMD
CHK642 ;Looking for locally added suffix
 K DIFROM,XMSUB,XMDUZ,XMTEXT,XMY
 N LRSC,LRCNT,LRNX,LRI
 S LRSC="",LRCNT=0
 F  S LRCNT=$O(^XTMP("LRNLT642",1,LRCNT)) Q:LRCNT<1  K ^XTMP("LRNLT642",1,LRCNT,1)
 S LRNX="^XTMP(""LRNLT642"",1,""C"")"
 F  S LRNX=$Q(@LRNX) Q:$QS(LRNX,3)'="C"  D
 . I $D(^LAB(64.2,"C",$QS(LRNX,4))) D  Q
 . . K ^XTMP("LRNLT642",1,$QS(LRNX,5))
 . W:$G(LRDBUG) !,LRNX
 F LRI="AC","B","C","D","E","F" K ^XTMP("LRNLT642",1,LRI)
MES642 ;
 I $O(^XTMP("LRNLT642",1,0)) D
 . S XMSUB=$TR($P($$SITE^VASITE,U,1,2),U,"|")_" LR 274 - 64 2 "_DT
 . S XMY("G.LMI@ISC-DALLAS")=""
 . S XMTEXT="^XTMP(""LRNLT642"",1,",XMDUZ=.5
 . D ^XMD
 K ^XTMP("LRNLT642")
MESLMI ; Notify LIM patch is installed.
 D BMES^XPDUTL($$CJ^XLFSTR("Sending install completion alert to mail group G.LMI",80))
 ;
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 ;
 S XQAMSG="LIM: Review description for "_$G(XPDNM,"Unknown patch")_" use KIDS:Utilities:Build File Print"
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 Q
