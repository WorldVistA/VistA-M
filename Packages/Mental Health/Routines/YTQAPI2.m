YTQAPI2 ;ASF/ALB - MHAX REMOTE PROCEDURES cont ;10/17/16  13:37
 ;;5.01;MENTAL HEALTH;**85,96,119,121,123,130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; ^DPT                 10035
 ; DIC                   2051
 ; DILFD                 2055
 ; DIQ                   2056
 ;
 Q
LISTER(YSDATA,YS) ;list entries
 ;entry point for YTQ GENERIC LISTER rpc
 ;input: CODE as test name
 ;output: Field^Value
 N YSFIELD,YSFILEN,N,C,YSNUMBER,YSFLAG,YSFROM,YSINDEX,YTTLKUP
 S YTTLKUP=1  ; suppress filter on 601.71
 S YSFILEN=$G(YS("FILEN"),0) S X=$$VFILE^DILFD(YSFILEN) I X=0 S YSDATA(1)="[ERROR]",YSDATA(2)="BAD FILE N" Q  ;--->out
 S YSFIELD=$G(YS("FIELD"),0) S X=$$VFIELD^DILFD(YSFILEN,YSFIELD) I X=0 S YSDATA(1)="[ERROR]",YSDATA(2)="BAD FIELD N" Q  ;--->out
 S YSFLAG=$G(YS("FLAG"))
 S YSNUMBER=$G(YS("NUMBER"),500)
 S YSFROM("IEN")=$G(YS("FROM"))
 S YSINDEX=$G(YS("INDEX"))
 D LIST^DIC(YSFILEN,,YSFIELD,YSFLAG,YSNUMBER,.YSFROM,,YSINDEX)
 I $D(^TMP("DIERR",$J)) S YSDATA(1)="[ERROR]",YSDATA(2)=$G(^TMP("DIERR",$J,1,"TEXT",1)) Q  ;--> out
 S YSDATA(1)="[DATA]"
 S YSDATA(2)=^TMP("DILIST",$J,0)
 S C=2,N=0
 F  S N=$O(^TMP("DILIST",$J,2,N)) Q:N'>0  D
 . S C=C+1
 . S YSDATA(C)=^TMP("DILIST",$J,2,N)_U_$G(^TMP("DILIST",$J,"ID",N,YSFIELD))
 K ^TMP("DILIST",$J)
 Q
ALLANS(YSDATA,YS) ;get all answers
 ;entry point for YTQ ALL ANSWERS rpc
 ;input:AD = ADMINISTRATION #
 ;output: [DATA]
 ; ADMIN ID^DFN^INSTRUMENT^DATE GIVEN^IS COMPLETE
 ;QUESTION #^seq^ANSWER
 N G,G1,N,YSAD,YSQN,YSTSTN,YSEQ,YSICON
 N IEN71,YSRTN,YSRTN71 ; llh patch 123
 S YSAD=$G(YS("AD"))
 I YSAD'?1N.N S YSDATA(1)="[ERROR]",YSDATA(2)="bad ad num" Q  ;-->out
 I '$D(^YTT(601.85,"AC",YSAD)) S YSDATA(1)="[ERROR]",YSDATA(2)="no such reference" Q  ;-->out
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
 ..F  S G1=$O(^YTT(601.85,G,1,G1)) Q:G1'>0  S N=N+1,YSDATA(N)=YSQN_U_YSEQ_";"_G1_U_$G(^YTT(601.85,G,1,G1,0))
 I $P(^YTT(601.84,YSAD,0),U,9)'="Y" QUIT  ; chk special proc only if complete
 ;llh patch 123, check for special processing of complex instruments
 S IEN71=$O(^YTT(601.71,"B",$P(YSDATA(2),U,3),0))
 S YSRTN71=$$GET1^DIQ(601.71,IEN71_",",92)
 I (YSRTN71'=""),(YSRTN71'="YTSCORE") D
 .N RPRIV S RPRIV=$P($G(^YTT(601.71,IEN71,2)),U) ; wrap for note
 .S YSRTN="DLLSTR^"_YSRTN71_"(.YSDATA,.YS,2)"
 .I $L($T(@("DLLSTR^"_YSRTN71))) D @YSRTN D:'$L(RPRIV) WRAP(80)
 D SPECIAL^YTQAPI2A(.YSDATA,N,YSAD,YSTSTN)
 Q
SETANS(YSDATA,YS) ;save an answer
 ;entry point for YTQ SET ANSWER rpc
 ;input: AD = ADMINISTRATION #
 ;input: QN= QUESTION #
 ;input: CHOICE= Choice ID [optional]
 ;input: YS(1) thru YS(N) WP entries
 ;output: [DATA] vs [ERROR]
 N N,N1,YSIENS,YSAD,YSQN,YSCI,YSCODE,YSOP
 S YSDATA(1)="[ERROR]"
 S YSAD=$G(YS("AD"))
 S YSQN=$G(YS("QN"))
 S YSCI=$G(YS("CHOICE"))
 I YSAD'?1N.N S YSDATA(2)="bad ad num" Q  ;-->out
 I YSQN'?1N.N S YSDATA(2)="bad quest num" Q  ;-->out
 I $D(^YTT(601.85,"AC",YSAD,YSQN)) S YSIENS=$O(^YTT(601.85,"AC",YSAD,YSQN,0))
 I '$D(^YTT(601.85,"AC",YSAD,YSQN)) D  ; set new entry
 . S YSIENS=""
 . S YSIENS=$$NEW^YTQLIB(601.85)
 . Q:YSIENS'?1N.N
 . L +^YTT(601.85,YSIENS):DILOCKTM
 . I '$T S YSDATA(2)="time out" Q
 . S ^YTT(601.85,YSIENS,0)=YSIENS_U_YSAD_U_YSQN
 . L -^YTT(601.85,YSIENS)
 . S ^YTT(601.85,0)="MH ANSWERS^601.85^"_YSIENS_U_($P(^YTT(601.85,0),U,4)+1)
 . S ^YTT(601.85,"B",YSIENS,YSIENS)=""
 . S ^YTT(601.85,"AC",YSAD,YSQN,YSIENS)=""
 . S ^YTT(601.85,"AD",YSAD,YSIENS)=""
 Q:$D(YSDATA(2))
 ;enter or delete Answers
 S $P(^YTT(601.85,YSIENS,0),U,4)=YSCI
 K ^YTT(601.85,YSIENS,1)
 S N=0,N1=0
 F  S N=$O(YS(N)) Q:N'>0  S N1=N1+1,^YTT(601.85,YSIENS,1,N1,0)=YS(N)
 S:N1 ^YTT(601.85,YSIENS,1,0)=U_U_N1_U_N1_U_DT_U
 S YSDATA(1)="[DATA]",YSDATA(2)="OK"
 ;set has been operational
 S YSCODE=$P(^YTT(601.84,YSAD,0),U,3)
 S YSOP=$P($G(^YTT(601.71,YSCODE,2)),U,2)
 S:YSOP="Y" $P(^YTT(601.71,YSCODE,2),U,5)="Y"
 Q
ADMINS(YSDATA,YS) ;administration retrieval
 ;entry point for YTQ GET ADMINISTRATIONS rpc
 ;input : DFN
 ;output:AdministrationID=InstrumentName^DateGiven^DateSaved^OrderedBy^AdministeredBy^Signed^IsComplete^NumberOfQuestionsAnswered
 N N,G,DFN,YSIENS
 S DFN=$G(YS("DFN"))
 I DFN'?1N.NP S YSDATA(1)="[ERROR]",YSDATA(2)="bad DFN" Q  ;-->out asf 2/22/08
 I '$D(^DPT(DFN,0)) S YSDATA(1)="[ERROR]",YSDATA(2)="no pt" Q  ;-->out
 S YSIENS=0,N=2
 S YSDATA(1)="[DATA]"
 F  S YSIENS=$O(^YTT(601.84,"C",DFN,YSIENS)) Q:YSIENS'>0  D
 . S N=N+1
 . S G=$G(^YTT(601.84,YSIENS,0))
 . I G="" S YSDATA(1)="[ERROR]",YSDATA(2)=YSIENS_" bad ien in 84" Q  ;-->out
 . S YSDATA(N)=YSIENS_"="_$$GET1^DIQ(601.84,YSIENS_",",2)_U_$P(G,U,4)_U_$P(G,U,5)
 . S YSDATA(N)=YSDATA(N)_U_$$GET1^DIQ(601.84,YSIENS_",",5,"I")_U_$$GET1^DIQ(601.84,YSIENS_",",6,"I")
 . S YSDATA(N)=YSDATA(N)_U_$$GET1^DIQ(601.84,YSIENS_",",7)_U_$$GET1^DIQ(601.84,YSIENS_",",8)_U_$$GET1^DIQ(601.84,YSIENS_",",9)
 S:YSDATA(1)="[DATA]" YSDATA(2)=(N-2)_" administrations"
 Q
CCALL(YSDATA) ;all choices returned
 ;entry point for YTQ ALL CHOICES rpc
 ;output: 601.75(1) CHOICETYPE ID^SEQUENCE^CHOICE IFN^CHOICE TEXT
 N N,YSCDA,YSN,YSN1
 S YSN=0,N=1
 S YSDATA(1)="[DATA]"
 F  S YSN=$O(^YTT(601.751,YSN)) Q:YSN'>0  D
 . S YSN1=0 F  S YSN1=$O(^YTT(601.751,"AC",YSN,YSN1)) Q:YSN1'>0  D
 .. S YSCDA=0 F  S YSCDA=$O(^YTT(601.751,"AC",YSN,YSN1,YSCDA)) Q:YSCDA'>0  D
 ... S N=N+1
 ... S YSDATA(N)=YSN_U_YSN1_U_YSCDA_U_$G(^YTT(601.75,YSCDA,1))
 Q
WRAP(MAX) ; Make sure DLLStr is wrapped by adding | chars
 ; expects YSDATA
 N LN,TX,OUT,I,J,X,Y,YNEW
 S LN=$O(YSDATA(9999999999),-1)
 S TX=$P(YSDATA(LN),U,3,99)
 F I=1:1:$L(TX,"|") S X=$P(TX,"|",I) D
 . I $L(X)'>MAX D ADDOUT(X) QUIT
 . S Y=""
 . F J=1:1:$L(X," ") D
 . . S YNEW=Y_$S(J=1:"",1:" ")_$P(X," ",J)
 . . I $L(YNEW)>MAX D ADDOUT(Y) S Y=$P(X," ",J) I 1
 . . E  S Y=YNEW
 . D ADDOUT(Y) ; add any remaining
 S X="",I=0 F  S I=$O(OUT(I)) Q:'I  S X=X_$S(I=1:"",1:"|")_OUT(I)
 S $P(YSDATA(LN),U,3)=X
 Q
ADDOUT(S) ; add string to out array (expects OUT)
 S OUT=+$G(OUT)+1,OUT(OUT)=S
 Q
