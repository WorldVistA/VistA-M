HLDIEDB1 ;CIOFO-O/LJA - DEBUG Menu ;1/8/04 @ 01:28
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
INIT ;
 N A7UMENU,A7UOK,A7UOPT,NOMENU,I,T,X,Y
 ;
CTRL ;
 D HEADER
 D M
 D ASK I 'A7UOK QUIT  ;->
 D XEC
 D BT QUIT:'A7UOK  ;->
 G CTRL ;->
 ;
BT ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S A7UOK=0
 N DIR
 S DIR(0)="EA",DIR("A")="Press RETURN to continue, or '^' to exit... "
 D ^DIR
 QUIT:+Y'=1  ;->
 S A7UOK=1
 QUIT
 ;
HEADER ;
 N DEBUG,IOINHI,IOINORM,X
 W @IOF,$$CJ^XLFSTR("HLDIE Debug Utility",IOM)
 S DEBUG=$G(^XTMP("HLDIE-DEBUG","STATUS"))
 I DEBUG]"" D  ; Show debug string...
 .  S X="IOINORM;IOINHI" D ENDR^%ZISS
 .  S DEBUG="Pre-call: "_$$CD($P(DEBUG,U))_"  Post-call: "_$$CD($P(DEBUG,U,2))_"  Screen: "_$$CD($P(DEBUG,U,3))
 .  W !,?17,DEBUG
 W !,$$REPEAT^XLFSTR("=",80)
 QUIT
 ;
CD(TXT) ; debug information
 ; IOINORM,IOINHI -- req
 QUIT:TXT']"" "OFF" ;->
 QUIT IOINHI_"ON["_TXT_"]"_IOINORM ;->
 ;
M KILL A7UMENU N I,T F I=1:1 S T=$T(M+I) QUIT:T'[";;"  S T=$P(T,";;",2,99),A7UMENU(I)=$P(T,"~",2,99) W !,$J(I,2),". ",$P(T,"~") S NOMENU=I
 ;;Display debug documentation~D DOC
 ;;Display debug data - API~D API^HLDIEDB0
 ;;Display debug data - FILE,IEN~D FILEIEN^HLDIEDB0
 ;;Display debug data - SEARCH~D SEARCH^HLDIEDB0
 ;;Display debug data - REALTIME~D REALTIME^HLDIEDB1
 ;;Display debug data - JOB~D JOB^HLDIEDB3
 ;;Set debug control string (Turn debugging on/off)~D SETDEBUG^HLDIEDBG
 ;;Kill debug data~D KILLALL^HLDIEDBG
 QUIT
 ;
ASK ;
 ; NOMENU -- req
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S A7UOK=0
 N DIR
 S DIR(0)="NO^1:"_NOMENU,DIR("A")="Select option"
 D ^DIR
 QUIT:'$D(A7UMENU(+Y))  ;->
 S A7UOPT=+Y
 S A7UOK=1
 QUIT
 ;
XEC ;
 S X=A7UMENU(+A7UOPT) X X
 QUIT
 ;
REALTIME ; real-time monitoring...
 N C2,C3,C4,C5,C6,C7,C8,CT,GBL,LAST,STOP,X
 ;
 S GBL="^XTMP(""HLDIE-DEBUGN"",""N"")",LAST=$G(@GBL)
 S C2=7,C3=18,C4=30,C5=40,C6=52,C7=70,C8=75
 ;
 S CT=0
 ;
 D REALHDR
 ;
 F  D  Q:STOP
 .  S STOP=1,CT=CT+1
 .  D REALSHOW
 .  R X:60 QUIT:X]""  ;->
 .  S STOP=0
 ;
 Q
 ;
REALHDR ; Header for real-time display...
 ; Cn -- req
 W !!,"#",?C2,"NOW",?C3,"File [#IEN]",?C4,"DataTM",?C5,"$J"
 W ?C6,"Rtn",?C7,"LOC",?C8,"Edtor"
 W !,$$REPEAT^XLFSTR("=",IOM)
 Q
 ;
REALSHOW ; Show information...
 ;C2,C3,GBL,LAST -- req --> LAST
 N DNO,NOW,NUM
 ;
 S NUM=$G(@GBL),NOW=$$TIME($$NOW^XLFDT)
 ;
 I CT=1 D  QUIT  ;->
 .  W !,?C2,NOW,?C3,"Collecting data..."
 ;
 I NUM=LAST D  QUIT  ;->
 .  W:$X>0 !
 .  W ?C2,NOW,?C3,"[No change]"
 ;
 F DNO=(LAST+1):1:NUM D REALONE(DNO)
 ;
 S LAST=NUM
 ;
 Q
 ;
REALONE(DNO) ; Show one entry...
 ; Cn -- req
 N DATA,DATE,EDITOR,FILE,IEN,JOB,LOC,RTN,SNO,TIME
 ;
 S DATA=$G(@GBL@(DNO))
 S FILE=$P(DATA,U),IEN=$P(DATA,U,2),TIME=$P(DATA,U,3),JOB=$P(DATA,U,4)
 S RTN=$P(DATA,U,5),SNO=$P(DATA,U,6),EDITOR=$P(DATA,U,7)
 ;
 S TIME=$$TIME(TIME)
 ;
 W !,$J(DNO,5),?C2,NOW,?C3,FILE," [#",IEN,"]",?C4,TIME,?C5,JOB
 W ?C6,RTN,?C7,SNO,?C8,$S(EDITOR["HLDIE":"HL",1:"FM")
 ;
 Q
 ;
TIME(FMTIME) ; Return HH:MM:SS
 S FMTIME=$P(FMTIME_"000000",".",2)
 QUIT $E(FMTIME,1,2)_":"_$E(FMTIME,3,4)_":"_$E(FMTIME,5,6)
 ;
 ;
 ;
DOC N C,I,IOINHI,IOINORM,T,X
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 F I=4:1 S T=$T(DOC+I) QUIT:T'[";;"!($G(X)[U)  D
 .  S T=$P(T,";;",2,99) S:$E(T,1,2)="[[" T=IOINHI_$TR(T,"[]","")_IOINORM W !,T
 ;;[[OVERVIEW]]
 ;; HLDIE debug data can be captured for evaluation by setting a "debug string."
 ;; The debug string is stored on the ^XTMP("HLDIE-DEBUG","STATUS") node.
 ;; This debug string should be set using the 'Set debug control string (Turn
 ;; debugging on/off)' menu choice.
 ;;
 ;;
 ;;[[DEBUG STRING DETAILS]]
 ;; The "debug string" had three(3) pieces:
 ;; 
 ;;   * Piece 1 controls data capture prior to FILE^DIE or FILE^HLDIE call.
 ;;     - If set to 1, "select" data (see below) is captures.
 ;;     - If set to 2, all local variables are captures.
 ;;     - If set to "", no data is collected.
 ;;
 ;;   * Piece 2 controls data capture after FILE^DIE or FILE^HLDIE call.
 ;;     - See piece 1 above for setting details.
 ;;
 ;;   * Piece 3 activates data capture screening.
 ;;     - Piece 3 can be set to 1 to activate the data screen held in
 ;;       $$STORESCR^HLDIEDB2.  This API holds no M code, but is a placeholder
 ;;       for M code that can evaluate the environment and on-the-fly turn on
 ;;       or off data storage.  (It can also control whethere "select" or all
 ;;       data is captured.)
 ;;
 ;;
 ;;[[PIECE 3 DATA SCREEN DETAILS]]
 ;; If piece 3 of the debug control string equals 1, the following 
 ;; occurs:  
 ;;
 ;;  * $$STORESCR^HLDIEDB2 is called by debugging process in FILE^HLDIE.
 ;;  * The local variable STORE holds the value null, 1 or 2 (see above),
 ;;    specifying whether data should be captured, and if so, whether "select"
 ;;    or all local variables should be stored.
 ;;  * If M code has been added to $$STORESCR^HLDIEDB2, it may evaluate the
 ;;    environment and optionally reset STORE to null, 1 or 2.
 ;;  * The value of STORE after M code execution is returned to the debugging 
 ;;    process.  (And, if set to null, no data is captured.)
 ;;
 ;; The following variables are defined for use by the M code added to
 ;; $$STORESCR^HLDIEDB2:
 ;;
 ;;  * CT - The number occurences already stored for TODAY/JOB#/API.
 ;;         (When a job calls STATUS^HLTF0, a call is made to FILE^HLDIE which
 ;;         can result in the creation of a debug data capture entry.  Every
 ;;         such call by the job to STATUS^HLTF0 results in the creation of 
 ;;         another data capture.  Twenty such calls can be made, after which
 ;;         the oldest capture is removed by the FIFO method.  The value of CT
 ;;         holds the total number of data capture occurences.)
 ;;  * DEBUGNO - The sequential number to be used during data storage.
 ;;  * DEBUGNOW - The date/time that will be used during data storage.
 ;;  * HLFILE - The file being edited.
 ;;  * HLIEN - The file's IEN being edited.
 ;;  * LOC - 1 (before call) or 2 (after call). 
 ;;  * RTN - RTN~SUBRTN (from the 4th & 5th FILE^HLDIE parameters.)
 ;;  * STORE - "" (don't store), 1 (store "select"), or 2 (store all.)
 ;;
 ;;
 ;;[[DEBUGGING - ALL VARIABLE STORAGE]]
 ;; Unrelated to the above debugging instructions, the 
 ;; LOG^HLDIEDBG(SUBSV,KEEP,STOP) API can be used by VistA HL7 developers to
 ;; store all variables.  (The DOLRO^%ZOSV API is used.)  Data created by this
 ;; call is stored in:
 ;;
 ;;   ^XTMP("HLDIE-"_DT,SUBSV,#,VAR)=VALUE
 ;;
 ;; Entries in this global are sequential at the '#' subscript level.  When a
 ;; call is made to this API, all local variables are stored at the VAR
 ;; subscript level.
 ;;
 ;; The LOG API has the following parameters:
 ;;
 ;;  * SUBSV - The subscript to be used when storing data.  (The value of this
 ;;            parameter is usually RTN~SUBRTN.)
 ;;  * KEEP - The number of entries to store.  (The entry of this parameter is
 ;;           optional, defaulting to 20.)
 ;;  * STOP - If set to 1, after KEEP number of entries are stored, no more
 ;;           data is captured, (and no data is deleted.)  If not set to 1, 
 ;;           KEEP number of entries are stored, the first entry stored is
 ;;           deleted in FIFO manner, to ensure that no more than KEEP entries
 ;;           exist.
 Q
 ;
ERR ; If error occurs during screening...
 ; The SENDUZ(DUZ)="" array *MUST* already be defined...
 N C,DATA,ERRTXT,LP,NO,ST,STORERR,TEXT,TIME,X,XMDUZ,XMSUB,XMTEXT,XMZ
 ;
 ; Before continuing, specify that NOTHING should be stored...
 ; This email message is ALL that will be stored or sent.
 S STORE="" ; This variable is returned to FILE^HLDIE execution
 ;
 ; Also, turn off STORE capture!
 S ^XTMP("HLDIE-DEBUG","STATUS")=""
 ;
 ; Record an error in logger...
 S ERRTXT=$$EC^%ZOSV
 S X=$$LOG^HLEVAPI2("FILE-HLDIE","ERRTXT")
 ;
 ; setup things...
 S XMDUZ=.5,XMSUB="HLDIE $$STORESCR Error"
 S XMTEXT="^TMP("_$J_",""HLMSG"","
 KILL ^TMP($J,"HLMSG"),^TMP($J,"HLVAR")
 S NO=0
 ;
 ; Add text...
 D MAILADD("An error occurred in $$STORESCR^HLDIEDB2 that must be checked.  The")
 D MAILADD("variables that existed at the time of the error are listed below.")
 D MAILADD("")
 D MAILADD("The error was '"_$$EC^%ZOSV_"'.")
 D MAILADD("")
 D MAILADD("IMPORTANT!!  All debugging was turned off.  Please review the problem,")
 D MAILADD("             then turn debugging back on.")
 D MAILADD("")
 D MAILADD("Local Variable List"),MAILADD("--------------------")
 ;
 S X="^TMP("_$J_",""HLVAR""," D DOLRO^%ZOSV
 S LP="^TMP("_$J_",""HLVAR""",ST=LP_",",LP=LP_")",C=","
 F  S LP=$Q(@LP) Q:LP'[ST  D
 .  S DATA=$TR($P($P(LP,ST,2),")"),"""","")
 .  I DATA[C S DATA=$P(DATA,C)_"("_$P(DATA,C,2,99)_")"
 .  D MAILADD(DATA_"="_@LP)
 ;
 MERGE XMY=SENDUZ
 I $O(XMY(0))'>0 S XMY(+$G(DUZ))=""
 ;
 D ^XMD
 ;
 KILL ^TMP($J,"HLMSG"),^TMP($J,"HLVAR")
 ;
 D UNWIND^%ZTER
 ;
 Q
 ;
MAILADD(T) S NO=$G(NO)+1,^TMP($J,"HLMSG",NO)=T
 QUIT
 ;
EOR ;HLDIEDB1 - DEBUG Menu ;1/8/04 @ 01:28
