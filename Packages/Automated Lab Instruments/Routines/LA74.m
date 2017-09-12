LA74 ;DALOI/JMC - LA*5.2*74 KIDS ROUTINE ;12/27/11  09:32
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
EN ; Does not prevent loading of the transport global.
 N STR,BAD,POS,X
 S XPDNOQUE=1 ;no queuing
 S POS=$G(IOM,80) S:POS<1 POS=80
 I '$G(XPDENV) D  ;
 . S STR="Transport global for patch "_$G(XPDNM,"Unknown patch")_" loaded on "_$$HTE^XLFDT($H)
 . D ALERT(STR)
 . W !,$$CJ^XLFSTR("Sending transport global loaded alert to mail group G.LMI",POS)
 ;
 I $G(XPDENV) D  ;
 . W !,$$CJ^XLFSTR("Sending install started alert to mail group G.LMI",POS)
 . S STR="Installation of patch "_$G(XPDNM,"Unknown patch")_" started on "_$$HTE^XLFDT($H)
 . D ALERT(STR)
 ;
 S BAD=0
 I '$G(IOM) S BAD=1
 I '$G(IOSL) S BAD=1
 I $G(U)'="^" S BAD=1
 I BAD D  ;
 . W !,$$CJ^XLFSTR("Terminal Device is not defined.",POS)
 . S XPDABORT=2
 ;
 S BAD=0
 I '$G(DUZ) S BAD=1
 I $D(DUZ)[0 S BAD=1
 I $D(DUZ(0))[0 S BAD=1
 I BAD D  ;
 . W !,$$CJ^XLFSTR("Please login to set DUZ variables.",POS)
 . S XPDABORT=2
 ;
 I $G(DUZ) I '$$ACTIVE^XUSER(DUZ) D  ;
 . W !,$$CJ^XLFSTR("Not a valid user on this system.",POS)
 . S XPDABORT=2
 ;
 S BAD=0
 I $G(XPDABORT)!$G(XPDQUIT) S BAD=1
 S X="LR350"
 X ^%ZOSF("TEST")
 I '$T D  ;
 . S BAD=1
 . S BAD(1)="Routine LR350 is missing."
 . S XPDABORT=2
 ;
 I BAD!($G(XPDABORT)) D  ;
 . S XPDABORT=2
 . W !!,$C(7),$$CJ^XLFSTR("* * *  Environment Check FAILED  * * *",POS)
 . I $G(BAD(1))'="" W !,$$CJ^XLFSTR(BAD(1),POS)
 . I XPDENV=1 W !!,$C(7),$$CJ^XLFSTR("Installation aborted.",POS),!
 ;
 I 'BAD&'$G(XPDABORT) D  ;
 . W !,$$CJ^XLFSTR("--- Environment okay ---",POS)
 ;
 ; Disable options, protocols, scheduled options
 I XPDENV=1 S XPDDIQ("XPZ1","B")="YES"
 Q
 ;
 ;
PRE ;
 ; KIDS Pre install for LA*5.2*74
 N LADATA,LAMSG,LAACTN,LAX,X
 D BMES("*** Pre install started ***")
 ; System ready from LR350?
 S X=$G(^TMP("LR350",$J,1))
 I 'X D  Q  ;
 . S XPDABORT=1
 . W $C(7)
 . D BMES(" ")
 . D BMES("Install aborted -- System not ready.")
 . D MES("Refer to the Install Guide for more information.")
 . D BMES(" ")
 . H 5
 . D RESTORE^LR350
 ;
 ; Save off any local entries in File #62.47
 K ^TMP("LA74-LOCAL",$J)
 ; Is this the LDSI development acount?
 ;S LAACTN(2)=($G(^%ZOSF("VOL"))="MHCVSS")
 ;I LAACTN(2)=0  D  ;
 I 1 D  ;
 . D BMES("Checking for local codes in #62.47")
 . D GETLOCAL
 . S LAX=+$G(^TMP("LA74-LOCAL",$J,"6247",0))
 . D BMES(LAX_" local code"_$S(LAX=1:"",1:"s")_" found in #62.47")
 K LAACTN(2)
 ;
 ; delete #62.47 data and DD
 D BMES("Deleting File #62.47 data and DD")
 D  ;
 . N DIU
 . S LADATA=$$VFILE^DILFD(62.47)
 . ; handle remnant #62.47 (sub-file of 62.4) VFILE=0 for this
 . I 'LADATA D  ;
 . . S DIU(0)="S"
 . . S DIU=62.47
 . ;
 . I LADATA D  ;
 . . S DIU(0)="DS"
 . . S DIU="^LAB(62.47,"
 . D EN^DIU2
 ; take care of orphaned DD if not deleted from above
 ; This happened in San Antonio initial install
 I $D(^DD(62.47)) D  ;
 . D BMES("#62.47 DD still exists.  KILLing the DD now")
 . I $D(^LAB(62.47)) D  ;
 . . N DIERR,LAMSG,LAFDA
 . . S R6247=0
 . . F  S R6247=$O(^LAB(62.47,R6247)) Q:'R6247  D  ;
 . . . K LRFDA,LAMSG
 . . . S LAFDA(1,62.47,R6247_",",.01)="@"
 . . . D FILE^DIE("E","LAFDA(1)","LAMSG")
 . . ;
 . K ^DD(62.47) ;(okay by Skip Ormsby)
 ;
 ; Delete DD for file #62.49
 I $$VFILE^DILFD(62.49) D
 . N DIU
 . D BMES("Purging DD for file #62.49")
 . S DIU="^LAHM(62.49,",DIU(0)="" D EN^DIU2
 ;
 ;I '$D(LAACTN) D BMES("--- No action required for pre-install ---")
 D BMES("*** Pre install completed ***")
 ;
 Q
 ;
 ;
POST ;
 ; KIDS Post install for LA*5.2*74
 N X
 D POST^LA74A
 ; Delete extra routines here
 I '$$GET^XUPARAM("XPD NO_EPP_DELETE") D  ;
 . S X="LA74A" X ^%ZOSF("TEST") Q:'$T  X ^%ZOSF("DEL")
 D RESTORE^LR350
 Q
 ;
 ;
ALERT(MSG,RECIPS) ;
 N DA,DIK,XQA,XQAMSG
 S XQAMSG=$G(MSG)
 I '$$GOTLOCAL^XMXAPIG("LMI") S XQA("G.LMI")=""
 E  S XQA(DUZ)=""
 I $D(RECIPS) M XQA=RECIPS
 D SETUP^XQALERT
 Q
 ;
 ;
BMES(STR) ;
 ; Write string
 D BMES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
 ;
PROGRESS(LAST) ;
 ; Prints a "." when NOW > LAST + INT
 ; Input
 ;   LAST : <byref> The last $H when "." was shown
 N INT
 S INT=1 ;interval in seconds
 I $P($H,",",2)>(+$P(LAST,",",2)+INT) S LAST=$H W "."
 Q
 ;
 ;
PTG ;
 ; Pre-Transport Global routine
 ; Populate pre-transport global with #62.47 data
 ; Only files the 0 nodes (2 node is for local data)
 N R6247,R624701,DATA,X,MSG,IENS2,P2FILE,SUB,CNT,DIERR
 S (R6247,CNT)=0
 F  S R6247=$O(^LAB(62.47,R6247)) Q:'R6247  D  ;
 . S DATA=$G(^LAB(62.47,R6247,0))
 . D SETTG(R6247,0,0,DATA)
 . S R624701=0
 . F  S R624701=$O(^LAB(62.47,R6247,1,R624701)) Q:'R624701  D  ;
 . . S DATA=$G(^LAB(62.47,R6247,1,R624701,0))
 . . I $P(DATA,"^",5)'=1 Q  ; only send national standard
 . . I $P(DATA,"^",2)="L" Q  ; don't send local codes
 . . S CNT=CNT+1
 . . D SETTG(0,0,0,CNT)
 . . D SETTG(R6247,R624701,0,DATA)
 Q
 ;
SETTG(R1,R2,SUB,VAL) ;
 ; Adds the Pre-Transport data node
 ; ^XTMP("XPDI",DA,"TEMP","LA6247",R6247,0)=0 node data
 ;                                ,R6247,1,R624701,0)=0 node data
 N NMSPC,CNT,NODE
 S SUB=+$G(SUB,0)
 S NMSPC="LA6247"
 Q:'$D(XPDGREF)
 S NODE=XPDGREF
 S NODE=$$TRIM^XLFSTR(NODE,"R",")")
 S NODE=NODE_","""_NMSPC_""","_R1
 I 'R1 S NODE=NODE_")"
 I R1 I 'R2 S NODE=NODE_",0)"
 I R2 S NODE=NODE_",1,"_R2_","_SUB_")"
 S @NODE=VAL
 Q
 ;
 ;
GETLOCAL ;
 ; Called from Pre-Install
 ; Gets all Local and non-National codes from File #62.47 and saves them to TMP for restore in Post
 ; Also saves site's mapping of national entries to local files for antibiotics (#62.06)
 N CNT,DATA,DIERR,FDA,FLDIENS,LA72,MSG,R6247,R624701,X,X2
 ;
 K ^TMP("LA74-LOCAL",$J),^TMP("LA74-LOCAL-MAPPING",$J)
 ;
 S (CNT,CNT(1),R6247)=0
 F  S R6247=$O(^LAB(62.47,R6247)) Q:'R6247  D  ;
 . S R624701=0
 . F  S R624701=$O(^LAB(62.47,R6247,1,R624701)) Q:'R624701  D  ;
 . . S DATA=$G(^LAB(62.47,R6247,1,R624701,0))
 . . S LA72=$G(^LAB(62.47,R6247,1,R624701,2))
 . . ; don't process if a Local or non-national code, just save field 2.1 mapping
 . . I +$P(DATA,"^",5)=1 D  Q
 . . . I $P(LA72,"^")'=""  S ^TMP("LA74-LOCAL-MAPPING",$J,"6247",R6247,1,R624701,2.1)=$P(LA72,"^"),CNT(1)=CNT(1)+1
 . . S ^TMP("LA74-LOCAL",$J,"6247",R6247,0)=$G(^LAB(62.47,R6247,0))
 . . K DATA,DIERR
 . . S IENS=R624701_","_R6247_","
 . . D GETS^DIQ(62.4701,IENS,"*","I","DATA","MSG")
 . . I '$D(DATA) Q
 . . S FLD=.001,CNT=CNT+1
 . . F  S FLD=$O(DATA(62.4701,IENS,FLD)) Q:FLD=""  D  ;
 . . . S X=$G(DATA(62.4701,IENS,FLD,"I"))
 . . . I X'="" S ^TMP("LA74-LOCAL",$J,"6247",R6247,1,R624701,FLD)=X
 ;
 S ^TMP("LA74-LOCAL",$J,"6247",0)=CNT
 S ^TMP("LA74-LOCAL-MAPPING",$J,"6247",0)=CNT(1)
 ;
 Q
 ;
 ;
MES(STR,CJ,LM) ;
 ; Display a string using MES^XPDUTL
 ;  Inputs
 ;  STR: String to display
 ;   CJ: Center text?  1=yes 0=1 <dflt=1>
 ;   LM: Left Margin (padding)
 N X
 S STR=$G(STR)
 S CJ=$G(CJ,1)
 S LM=$G(LM)
 I CJ S STR=$$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," ")
 I 'CJ I LM S X="" S $P(X," ",LM)=" " S STR=X_STR
 D MES^XPDUTL(STR)
 Q
