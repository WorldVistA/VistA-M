YTSCORE ;SLC/KCM - Scoring for complex instruments ;Feb 28, 2024@15:02:07
 ;;5.01;MENTAL HEALTH;**119,123,142,141,217,234,244,240,236**;Dec 30, 1994;Build 25
 ;
 ;
 Q
DLL ; stub entry point for instruments scored by DLL
 Q
 ;
DESGNTR(YSQN,DES) ; Create DESIGNTR variable, used for Reports
 N STR76
 S DES="NO DESIGNATOR"
 Q:'$G(YSQN)
 S STR76=$O(^YTT(601.76,"AE",YSQN,0))
 Q:'$G(STR76)
 S DES=$P($P($G(^YTT(601.76,STR76,0)),U,5),".")
 Q
 ;
LOADANSW(YSDATA,YS) ; patch 123, loads answers, builds YSDATA array
 ;input:AD = ADMINISTRATION #
 ;output: [DATA]
 ; ADMIN ID^DFN^INSTRUMENT^DATE GIVEN^IS COMPLETE
 ; QUESTION #^seq^ANSWER
 ;
 N G,G1,N,YSQN,YSTSTN,YSEQ,YSICON
 S YSAD=$G(YS("AD"))
 I YSAD'?1N.N S YSDATA(1)="[ERROR]",YSDATA(2)="Bad ADMIN num, admin is "_YSAD Q  ;-->out
 I '$D(^YTT(601.85,"AC",YSAD)) S YSDATA(1)="[ERROR]",YSDATA(2)="No entry in MH ANSWERS" Q  ;-->out
 S YSTSTN=$P(^YTT(601.84,YSAD,0),U,3)
 S YSDATA(1)="[DATA]"
 S YSDATA(2)=YSAD_U_$$GET1^DIQ(601.84,YSAD_",",1,"I")_U_$$GET1^DIQ(601.84,YSAD_",",2,"E")_U_$$GET1^DIQ(601.84,YSAD_",",3,"I")_U_$$GET1^DIQ(601.84,YSAD_",",8,"I")
 S YSQN=0,N=2
 F  S YSQN=$O(^YTT(601.85,"AC",YSAD,YSQN)) Q:YSQN'>0  S G=0 D
 .S G=$O(^YTT(601.85,"AC",YSAD,YSQN,G)) Q:G'>0  S G1=0 D
 ..S YSICON=$O(^YTT(601.76,"AF",YSTSTN,YSQN,0))
 ..S YSEQ=1
 ..I YSICON?1N.N S YSEQ=$P(^YTT(601.76,YSICON,0),U,3)
 ..S:$P(^YTT(601.85,G,0),U,4)?1N.N N=N+1,YSDATA(N)=YSQN_U_YSEQ_U_$P(^YTT(601.85,G,0),U,4)
 ..F  S G1=$O(^YTT(601.85,G,1,G1)) Q:G1'>0  D
 ...S N=N+1,YSDATA(N)=YSQN_U_YSEQ_";"_G1_U_$G(^YTT(601.85,G,1,G1,0))
 Q
 ;
SCOREINS(YSDATA,IEN71) ;
 ; patch 123, scores responses (answers) for a given instrument
 ; YSDATA contains Answers for instrument
 N I,G,N,YSAI,YSAN,YSCALEI,YSKEYI,YSRAW,YSRTN,YSTARG,YSQN,YSVAL
 K ^TMP($J,"YSCOR"),^TMP($J,"YSG")
 I '$D(^YTT(601.86,"AD",IEN71)) S ^TMP($J,"YSCOR",1)="[ERROR]",^TMP($J,"YSCOR",2)="Scale grp not found" Q  ;-->out
 S YS("CODE")=$$GET1^DIQ(601.71,IEN71_",",.01) ; get the Instrument Name
 D SCALEG^YTQAPI3(.YSDATA,.YS)
 S YSDATA=$NA(^TMP($J,"YSCOR"))
 S ^TMP($J,"YSCOR",1)="[DATA]",N=1
 ;
 S YSRTN=$$GET1^DIQ(601.71,IEN71_",",92) ;routine for scoring
 I (YSRTN'=""),(YSRTN'="YTSCORE") D  Q
 .S YSRTN="DLLSTR^"_YSRTN_"(.YSDATA,.YS,1)"
 .D @YSRTN
 ; original code, this uses MH SCORING KEY File to calculate ^TMP for "regular instruments"
 F I=2:1 Q:'$D(^TMP($J,"YSG",I))  I ^TMP($J,"YSG",I)?1"Scale".E S YSRAW="0",N=N+1,^TMP($J,"YSCOR",N)=$P(^TMP($J,"YSG",I),U,4)_"=" D  S ^TMP($J,"YSCOR",N)=^TMP($J,"YSCOR",N)_YSRAW
 .S YSCALEI=$P(^TMP($J,"YSG",I),U),YSCALEI=$P(YSCALEI,"=",2)
 .S YSKEYI=0 F  S YSKEYI=$O(^YTT(601.91,"AC",YSCALEI,YSKEYI)) Q:YSKEYI'>0  D
 ..S G=^YTT(601.91,YSKEYI,0)
 ..S YSQN=$P(G,U,3),YSTARG=$P(G,U,4),YSVAL=$P(G,U,5)
 ..S YSAI=$O(^YTT(601.85,"AC",YSAD,YSQN,0))
 ..Q:YSAI'>0
 ..Q:'$D(^YTT(601.85,YSAI,0))  ;ASF 11/15/07
 ..S YSAN=""
 ..I $D(^YTT(601.85,YSAI,1,1,0)) S YSAN=^YTT(601.85,YSAI,1,1,0)
 ..I $P(^YTT(601.85,YSAI,0),U,4)?1N.N S YSAN=$P(^YTT(601.85,YSAI,0),U,4),YSAN=$G(^YTT(601.75,YSAN,1))
 ..I YSAN=YSTARG S YSRAW=YSRAW+YSVAL
 Q
 ;
CHKSCRE() ;
 N REVSCR71,REVSCR84
 S REVSCR71=$$GET1^DIQ(601.71,IEN71_",",93)  ; Instrument scoring version number
 S REVSCR84=$$GET1^DIQ(601.84,YSAD_",",14)  ; Administration scoring version number
 Q (REVSCR71=REVSCR84)
 ;
LDSCORES(YSDATA,YS) ;  new call for patch 123
 ;input:AD = ADMINISTRATION #
 ;output: [DATA] in ^TMP($J,"YSCOR")
 N G,N,IEN71,SCALE,YSAD,YSCODEN,YSCALE
 S YSAD=$G(YS("AD"))
 K ^TMP($J,"YSCOR") S YSDATA=$NA(^TMP($J,"YSCOR"))
 I YSAD'?1N.N S ^TMP($J,"YSCOR",1)="[ERROR]",^TMP($J,"YSCOR",2)="Bad ADMIN # in LDSCORES" Q  ;-->out
 S IEN71=$$GET1^DIQ(601.84,YSAD_",",2,"I") I IEN71'?1N.N D  Q
 .S ^TMP($J,"YSCOR",1)="[ERROR]",^TMP($J,"YSCOR",2)="No Instrument in 601.84"
 ;Check if scoring may have changed before loading scores
 I '$$CHKSCRE D SCORSAVE^YTQAPI11(.YSDATA,.YS)
 I '$D(^YTT(601.92,"AC",YSAD)) S ^TMP($J,"YSCOR",1)="[ERROR]",^TMP($J,"YSCOR",2)="No entry in MH RESULTS" Q  ;-->out
 ;
 S YS("CODE")=$$GET1^DIQ(601.84,YSAD_",",2)
 D SCALEG^YTQAPI3(.YSDATA,.YS)
 ;
 S YSDATA=$NA(^TMP($J,"YSCOR"))
 S ^TMP($J,"YSCOR",1)="[DATA]",N=1
 ;
 S YSCALE=""
 F  S YSCALE=$O(^YTT(601.92,"AC",YSAD,YSCALE))  Q:'YSCALE  D
 .S G=$G(^YTT(601.92,YSCALE,0))
 .S SCALE=$P(G,U,3),N=N+1
 .S ^TMP($J,"YSCOR",N)=SCALE_"="_$P(G,U,4)_$S($P(G,U,5):U_$P(G,U,5),1:"")
 Q
 ;
UPDSCORE(YSDATA,YS) ; files entries in MH RESULTS (601.92)
 ;input:AD = ADMINISTRATION #
 ;output: [DATA]
 N DIFF,IEN71,YSAD,YSCALE,YSC,YSG,Z
 S YSAD=$G(YS("AD"))
 I YSAD'?1N.N S ^TMP($J,"YSCOR",1)="[ERROR]",^TMP($J,"YSCOR",2)="No ADMIN # in UPDSCORE" Q  ;-->out
 S IEN71=$$GET1^DIQ(601.84,YSAD_",",2,"I")
 ; are there existing scores in MH RESULT
 I $D(^YTT(601.92,"AC",YSAD)) D OLDSCRES(.YSCALE,.YSAD)
 ;
 S Z=1 F  S Z=$O(^TMP($J,"YSCOR",Z)) Q:Z'>0  D
 .S YSG=^TMP($J,"YSCOR",Z)
 .S YSC=$P(YSG,"=")
 .S DIFF=0
 .I $D(YSCALE(YSC)) D  Q
 ..S DIFF=$$CHKSCR(.YSC,.YSG)
 ..I DIFF D ADDAUDIT(.YSC,.YSG)
 .D ADDSCRE
 ; set admin.revision = instrument.revision
 D SETREV(.YSAD,.IEN71)
 Q
 ;
CHKSCR(YSC,YSG) ; return 1 if there are different values, 0 if values in scoring are the same
 N I,OLDSC,YSCOR
 S DIFF=0
 S YSCOR=$P(YSG,"=",2,7)
 S OLDSC=$P(YSCALE(YSC),U,4,7)
 F I=1:1:4 I $P($G(OLDSC),U,I)'=$P($G(YSCOR),U,I) S DIFF=1 Q:DIFF
 Q DIFF
 ;
ADDAUDIT(YSC,YSG) ; add entry in AUDIT node, update value in existing MH RESULTS record
 N AUDIEN,AUD,DIERR
 S AUDIEN=$P(YSCALE(YSC),U)
 D NOW^%DTC
 S AUD(1,601.921,"+2,"_AUDIEN_",",.01)=%
 S AUD(1,601.921,"+2,"_AUDIEN_",",2)=$$GET1^DIQ(601.84,YSAD_",",14)
 F I=4:1:7 I $L($P(YSCALE(YSC),U,I)) S AUD(1,601.921,"+2,"_AUDIEN_",",(I-1))=$P(YSCALE(YSC),U,I)
 D UPDATE^DIE("","AUD(1)")
 I $D(DIERR) S ^TMP($J,"YSCOR",1)="[ERROR]",^TMP($J,"YSCOR",2)="Did not set Audit node in MH RESULTS" Q
 D CLEAN^DILF
 ;
 ; update existing node with new ones; use FILE^DIE
 N I,FDA,DIERR,YSGANS
 S YSGANS=$P(YSG,"=",2,5)
 F I=1:1:4 I $L($P(YSGANS,U,I))!$L($P(YSCALE(YSC),U,I+3)) S FDA(601.92,AUDIEN_",",(I+2))=$P(YSGANS,U,I)
 D FILE^DIE("","FDA")
 I $D(DIERR) S ^TMP($J,"YSCOR",1)="[ERROR]",^TMP($J,"YSCOR",2)="Did not update records in MH RESULTS File" Q
 D CLEAN^DILF
 K %,%H,%I,X
 Q
 ;
ADDSCRE ;add score to MH RESULTS
 N FDA,FDAIEN,DIERR,STR,YSRNEW,YSRFND
 S YSRNEW=$P($G(^YTT(601.92,0)),U,3),YSRFND=0
 S:YSRNEW<100000 YSRNEW=100000
 L +^YTT(601.92,0):DILOCKTM+10
 I '$T D  QUIT
 . S ^TMP($J,"YSCOR",1)="[ERROR]"
 . S ^TMP($J,"YSCOR",2)="Could not get lock on MH RESULTS file"
 F  Q:YSRFND  D:'$D(^YTT(601.92,YSRNEW))  S YSRNEW=YSRNEW+1
 . L +^YTT(601.92,YSRNEW):DILOCKTM Q:'$T
 . S STR=$P(YSG,"=",2)
 . S FDAIEN(1)=YSRNEW
 . S FDA(601.92,"+1,",.01)=YSRNEW
 . S FDA(601.92,"+1,",1)=YSAD
 . S FDA(601.92,"+1,",2)=$P(YSG,"=",1)
 . S FDA(601.92,"+1,",3)=$P(STR,U,1)                  ; raw score
 . S:$L($P(STR,U,2)) FDA(601.92,"+1,",4)=$P(STR,U,2)  ; transformed score 1
 . S:$L($P(STR,U,3)) FDA(601.92,"+1,",5)=$P(STR,U,3)  ; transformed score 2
 . S:$L($P(STR,U,4)) FDA(601.92,"+1,",6)=$P(STR,U,4)  ; transformed score 3
 . D UPDATE^DIE("","FDA","FDAIEN")
 . L -^YTT(601.92,YSRNEW)
 . S YSRFND=1
 L -^YTT(601.92,0)
 I $D(DIERR) S ^TMP($J,"YSCOR",1)="[ERROR]",^TMP($J,"YSCOR",2)="Did not add MH RESULTS entry" Q
 Q
 ;
OLDSCRES(YSCALE,YSAD) ; if existing score, build array containing them
 N IEN92,STR
 S IEN92=0
 F  S IEN92=$O(^YTT(601.92,"AC",YSAD,IEN92)) Q:'IEN92  D
 .S STR=$G(^YTT(601.92,IEN92,0))
 .S YSCALE($P(STR,U,3))=STR
 Q
 ;
SETREV(YSAD,IEN71) ; set revision value in MH ADMINISTRATIONS to value in MH TEST AND SURVEYS
 N FDA,DIERR
 S FDA(601.84,YSAD_",",14)=$$GET1^DIQ(601.71,IEN71_",",93)
 D FILE^DIE("","FDA")
 I $D(DIERR) S ^TMP($J,"YSCOR",1)="[ERROR]",^TMP($J,"YSCOR",2)="Did not set Scoring Revision in MH ADMIN"
 D CLEAN^DILF
 D UPRSLT^YTQEVNT(YSAD,"score") ; publish score update event
 Q
 ;
LDTSCOR(TSARR,YSAD) ;
 N CNT,DATA,IEN92,RAW,T1,T2,T3
 S IEN92="",CNT=1
 I YSAD'?1N.N S TSARR("NOADM")="No Administration to get scores" Q
 I '$D(^YTT(601.92,"AC",YSAD)) S TSARR("NOADM")="No scores in MH RESULTS File" Q
 F  S IEN92=$O(^YTT(601.92,"AC",YSAD,IEN92)) Q:'IEN92  D
 .S DATA=$G(^YTT(601.92,IEN92,0))
 .S RAW=$P(DATA,U,4),T1=$P(DATA,U,5),T2=$P(DATA,U,6),T3=$P(DATA,U,7)
 .S RAW=$S($L(RAW)=1:" "_RAW,1:RAW)
 .S T1=$S($L(T1)=1:" "_T1,1:T1),T2=$S($L(T2)=1:" "_T2,1:T2),T3=$S($L(T3)=1:" "_T3,1:T3)
 .S TSARR($P($P(DATA,U,3),":"))=$P(DATA,U,3)_U_RAW_U_T1_U_T2_U_T3
 Q
BYKEY(YSDATA) ; use YSDATA to score by key and put into ^TMP($J,"YSCOR")
 ; expects scales to already be in ^TMP($J,"YSG")
 N I,J,TEST,ANSWERS,SCORES,QID,CID,YS
 K ^TMP($J,"YSCOR")
 S TEST=$P(YSDATA(2),U,3),YS("CODE")=TEST
 I $L(TEST) S TEST=$O(^YTT(601.71,"B",TEST,0))
 I 'TEST S ^TMP($J,"YSCOR",1)="[ERROR]",^(2)="No test found" QUIT
 S I=2,J=0 F  S I=$O(YSDATA(I)) Q:'I  D  ; build ANSWERS array
 . S QID=$P(YSDATA(I),U),CID=$P(YSDATA(I),U,3)
 . S J=J+1,ANSWERS(J,"id")=QID,ANSWERS(J,"value")=CID
 D SUMKEY^YTSCOREX(TEST,.ANSWERS,.SCORES)
 S J=1,^TMP($J,"YSCOR",J)="[DATA]"
 S I=0 F  S I=$O(SCORES(I)) Q:'I  D
 . S J=J+1,^TMP($J,"YSCOR",J)=$G(SCORES(I,"name"))_"="_SCORES(I,"raw")
 Q
