YTQRCAT ;SLC/KCM - Calls to manage CAT instruments ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**182,199,202,218**;Dec 30, 1994;Build 9
 ;
SPLTADM(ADMIN) ; split CAT interview into multiple admins
 N X0 S X0=$G(^YTT(601.84,ADMIN,0))
 Q:$P(X0,U,9)'="Y"        ; quit if admin not complete
 N NM S NM=$P(^YTT(601.71,+$P(X0,U,3),0),U)
 Q:$E(NM,1,7)'="CAT-CAD"  ; quit if admin not CAT/CAD
 ;
 N TREE,ITEST,TTYP,CNT
 D LOADTREE(ADMIN,.TREE)  ; turn JSON in answer into TREE
 S ITEST=0,CNT=0
 F  S ITEST=$O(TREE("report","tests",ITEST)) Q:'ITEST  S CNT=CNT+1
 I CNT=1 D  QUIT          ; just re-point if only one test
 . S TTYP=$G(TREE("report","tests",1,"type"))
 . D REPOINT(ADMIN,$$NMINST(TTYP))
 . D SETSCORE(ADMIN)
 ;
 ; continue here if multiple tests in interview
 ; reverse $O on ITEST so we change the original last
 S ITEST="" F  S ITEST=$O(TREE("report","tests",ITEST),-1) Q:'ITEST  D
 . N NEWTREE,NEWADM,JSON,CATANS
 . S TTYP=TREE("report","tests",ITEST,"type")
 . M NEWTREE("report","tests",1)=TREE("report","tests",ITEST)
 . M NEWTREE("answers")=TREE("answers")
 . M NEWTREE("status")=TREE("status")
 . D ENCODE^XLFJSON("NEWTREE","JSON") K NEWTREE
 . D BLDANS(.JSON,.CATANS) K JSON
 . I ITEST>1 D
 . . S NEWADM=$$NEWADM(ADMIN,$$NMINST(TTYP))  ; create new admin
 . . S CATANS("AD")=NEWADM
 . E  S CATANS("AD")=ADMIN
 . S CATANS(1)=8650    ; question id of CAT interview
 . D SAVEANS(.CATANS)  ; adminId already in CATANS("AD")
 . I ITEST=1 D REPOINT(ADMIN,$$NMINST(TTYP))  ; use original admin
 . D SETSCORE(CATANS("AD"))
 Q
LOADTREE(ADMIN,TREE) ; load interview document into TREE
 N YSDATA,YS
 S YS("AD")=ADMIN
 D LOADANSW^YTSCORE(.YSDATA,.YS)
 D WP2JSON^YTSCAT(.YSDATA,.TREE)
 Q
BLDANS(JSON,CATANS) ; split JSON into FM WP chunks
 N I,X,LN
 S I=0,LN=0 F  S I=$O(JSON(I)) Q:'I  D
 . F  S X=$E(JSON(I),1,200) D  Q:'$L(JSON(I))
 . . S LN=LN+1,CATANS(1,LN)="|"_X
 . . S JSON(I)=$E(JSON(I),201,$L(JSON(I)))
 Q
SETSCORE(ADMIN) ; score the admin
 N YSDATA,YS
 S YS("AD")=ADMIN
 D SCORSAVE^YTQAPI11(.YSDATA,.YS)
 K ^TMP($J,"YSCOR"),^TMP($J,"YSG")
 Q
 ;
NEWADM(SRCADM,NAME) ; return a new admin for instrument NAME based on another
 N YSDATA,YS,X0,IEN71
 S X0=$G(^YTT(601.84,SRCADM,0)) I '$L(X0) Q 0
 S IEN71=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN71
 S YS("FILEN")=601.84
 S YS(1)=".01^NEW^1"
 S YS(2)="1^`"_$P(X0,U,2)
 S YS(3)="2^`"_IEN71
 S YS(4)="3^"_$P(X0,U,4)
 S YS(5)="4^"_$P(X0,U,5)
 S YS(6)="5^`"_$P(X0,U,6)
 S YS(7)="6^`"_$P(X0,U,7)
 S YS(8)="7^"_$P(X0,U,8)
 S YS(9)="8^"_$P(X0,U,9)
 S YS(10)="9^"_$P(X0,U,10)
 S YS(11)="13^`"_$P(X0,U,11)
 S YS(12)="15^`"_$P(X0,U,13)
 I $P(X0,U,15) S YS(13)="17^"_$P(X0,U,15)
 D EDAD^YTQAPI1(.YSDATA,.YS)
 Q $P(YSDATA(2),U,2)
 ;
REPOINT(ADMIN,NAME) ; re-point the instrument in ADMIN to NAME
 N REC,IEN71
 S IEN71=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN71
 S REC(2)=IEN71
 D FMUPD^YTXCHGU(601.84,.REC,ADMIN)
 Q
SAVEANS(CATANS) ; save/update CAT interview answer
 N YSDATA,YSAD,IEN85
 S YSAD=CATANS("AD")
 I $D(^YTT(601.85,"AC",YSAD,8650)) D
 . S IEN85=$O(^YTT(601.85,"AC",YSAD,8650,0))
 . I IEN85 K ^YTT(601.85,IEN85,1) ; clear WP value
 D SAVEALL^YTQAPI17(.YSDATA,.CATANS)
 Q
NMINST(TTYP) ; return name of instrument
 S TTYP=$$LOW^XLFSTR(TTYP)
 I TTYP="mdd" Q "CAD-MDD"
 I TTYP="dep" Q "CAT-DEP"
 I TTYP="anx" Q "CAT-ANX"
 I TTYP="m/hm" Q "CAT-MANIA-HYPOMANIA"
 I TTYP="sud" Q "CAT-SUD"
 I TTYP="sa" Q "CAT-SUD"
 I TTYP="ptsd" Q "CAT-PTSD"
 I TTYP="a/adhd" Q "CAT-ADHD"
 I TTYP="sdoh" Q "CAT-SDOH"
 I TTYP="ss" Q "CAT-SS"
 I TTYP="ptsd-dx" Q "CAD-PTSD-DX"
 I TTYP="ptsd-e" Q "CAT-PTSD-E"
 I TTYP="psy-c" Q "CAT-PSYCHOSIS"
 I TTYP="psy-s" Q "CAT-PSYCHOSIS"
 Q ""
 ;
QSPLT(YTADMIN) ; queue the splitting if this is a CAT interview
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 S ZTIO=""
 S ZTRTN="DQSPLT^YTQRCAT"
 S ZTDESC="Create individual CAT administrations"
 S ZTDTH=$H
 S ZTSAVE("YTADMIN")=""
 D ^%ZTLOAD
 Q
DQSPLT ; de-queue the admin and split into separate admins
 S ZTREQ="@"
 D SPLTADM(YTADMIN)
 Q
GCATINFO(ARGS,RESULTS) ; return catInfo object by assignmentId
 N ASMT,ASMTID
 S ASMTID=$G(ARGS("assignmentId"))
 S ASMT="YTQASMT-SET-"_ASMTID
 I 'ASMTID D SETERROR^YTQRUTL(404,"Not Found: "_ARGS("assignmentId")) QUIT
 I '$D(^XTMP(ASMT)) D SETERROR^YTQRUTL(404,"Not Found: "_ARGS("assignmentId")) QUIT
 I $D(^XTMP(ASMT,1,"catInfo"))>1 M RESULTS("catInfo")=^XTMP(ASMT,1,"catInfo") I 1
 E  S RESULTS("catInfo")="null"
 ; also get the answers
 I $D(^XTMP("YTQCATSV-"_ASMTID,"answers"))>1 D
 . M RESULTS("answers")=^XTMP("YTQCATSV-"_ASMTID,"answers")
 I $D(^XTMP("YTQCATSV-"_ASMTID,"report"))>1 D
 . M RESULTS("report")=^XTMP("YTQCATSV-"_ASMTID,"report")
 S RESULTS("status")=$G(^XTMP("YTQCATSV-"_ASMTID,"status"))
 Q
PCATINFO(ARGS,DATA) ; save updated catInfo into assignment
 N ASMT
 S ASMT="YTQASMT-SET-"_$G(ARGS("assignmentId"))
 I '$D(^XTMP(ASMT)) D SETERROR^YTQRUTL(404,"Not Found: "_ARGS("assignmentId")) QUIT
 I $D(DATA("catInfo"))>1 D
 . K ^XTMP(ASMT,1,"catInfo")
 . M ^XTMP(ASMT,1,"catInfo")=DATA("catInfo")
 N ASMTID S ASMTID=ARGS("assignmentId")
 N EXPIRE S EXPIRE=$$FMADD^XLFDT(DT,7)
 S ^XTMP("YTQCATSV-"_ASMTID,0)=EXPIRE_U_DT_U_"MH CAT Interview Autosave"
 I $D(DATA("answers"))>1 D
 . K ^XTMP("YTQCATSV-"_ASMTID,"answers")
 . M ^XTMP("YTQCATSV-"_ASMTID,"answers")=DATA("answers")
 I $D(DATA("report"))>1 D
 . K ^XTMP("YTQCATSV-"_ASMTID,"report")
 . M ^XTMP("YTQCATSV-"_ASMTID,"report")=DATA("report")
 I $D(DATA("status")) D
 . S ^XTMP("YTQCATSV-"_ASMTID,"status")=$G(DATA("status"))
 Q "/api/mha/assignment/cat/"_ARGS("assignmentId")
 ;
GETCATI(ARGS,RESULTS) ; return saved CAT object (by interviewID)
 N CATID S CATID=ARGS("interviewId")
 I '$D(^XTMP("YTQCAT-"_CATID,"data")) D  Q
 . D SETERROR^YTQRUTL(404,"Not Found: "_ARGS("interviewId"))
 M RESULTS=^XTMP("YTQCAT-"_CATID,"data")
 Q
SETCATI(ARGS,DATA) ; save CAT object (by interviewID)
 N CATID S CATID=ARGS("interviewId")
 N EXPIRE S EXPIRE=$$FMADD^XLFDT(DT,7)
 K ^XTMP("YTQCAT-"_CATID,"data")
 S ^XTMP("YTQCAT-"_CATID,0)=EXPIRE_U_DT_U_"MH CAT Interview Cookies"
 M ^XTMP("YTQCAT-"_CATID,"data")=DATA
 Q "/api/mha/cat/interview/"_CATID
 ;
CHKPROG(ADMIN) ; if CAT return progress, otherwise -1
 Q:'$G(ADMIN) -1
 N CATPROG S CATPROG=-1
 N TESTNM S TESTNM=$P(^YTT(601.71,$P(^YTT(601.84,ADMIN,0),U,3),0),U)
 I $E(TESTNM,1,4)="CAT-"!($E(TESTNM,1,4)="CAD-") D
 . S CATPROG=10
 . I $P(^YTT(601.84,ADMIN,0),U,9)="Y" S CATPROG=100
 Q CATPROG
 ;
MVAUTOSV(OLDSET,SETID) ; move the auto-save cache when assignmetn changes
 I +$G(OLDSET),$D(^XTMP("YTQCATSV-"_OLDSET)) D
 . K ^XTMP("YTQCATSV-"_SETID)
 . M ^XTMP("YTQCATSV-"_SETID)=^XTMP("YTQCATSV-"_OLDSET)
 . K ^XTMP("YTQCATSV-"_OLDSET)
 Q
ANYCAT(ASMT) ; return 1 if any CAT/CAD interviews in assignment
 N I,FND,NODE
 S FND=0,NODE="YTQASMT-SET-"_ASMT
 S I=0 F  S I=$O(^XTMP(NODE,1,"instruments",I)) Q:'I  D
 . I $E($G(^XTMP(NODE,1,"instruments",I,"name")),1,7)="CAT-CAD" S FND=1
 Q FND
 ;
