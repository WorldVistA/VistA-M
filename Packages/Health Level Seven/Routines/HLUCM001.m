HLUCM001 ;CIOFO-O/LJA - HL7/Capacity Mgt API (continued) ;2/27/01 10:15
 ;;1.6;HEALTH LEVEL SEVEN;**79,88,103**;Oct 13, 1995
 ;
ADDTMP ; Accumulate totals into ^TMP(TOTALS,$J,...)
 ; FAC,ORIGETM,ORIGSTM,TYPEHR,TYPEIO,TYPELR -- req
 ;
 N CHAR,ERRFLAG,FAC,SEC,START,TOTCURR,TYPEHR,TYPEIO,TYPELR
 ;
 S CHAR=$G(DATA("CHAR")),SEC=$G(DATA("DIFF")),FAC=$G(DATA("FAC"))
 S TYPEHR=$G(DATA("HR")),TYPEIO=$G(DATA("IO")),TYPELR=$G(DATA("LR"))
 ;
 S START=$$HR($G(DATA("START")))
 ;I START<ORIGSTM S START=ORIGSTM
 ;I START>ORIGETM S START=ORIGETM
 ;
 ; Back door way to total by day only. (Dropping HR).
 I $D(^TMP($J,"HLUCMDT")) S START=START\1
 ;
 ; Is delta time greater than 30 minutes?
 S ERRFLAG=0
 I SEC>1799 D
 .  S X=TOTALS N TOTALS S TOTALS=X_"ERRTIME",ERRFLAG=1
 .  D ERRMOVE^HLUCM009(+IEN772) ; Move into ^TMP($J,"HLUCMSTORE","ERR")
 ; Store under TOTALS_ERRTIME
 ;
 ; Maybe, this IEN772 has already been ERRd by ERRMOVE^HLUCM009?
 I $D(^TMP($J,"HLUCMSTORE","ERR","X",+IEN772)) D  QUIT  ;->
 .  D ERRMOVE^HLUCM009(+IEN772) ; Just to be sure
 ;
 ; Should this entry even be counted?
 I (HLAPI="CMF"!(HLAPI="CM2F"))&(TYPELR'="R") QUIT  ;->
 ;
 ; Accumulating and totaling here...
 I TYPELR="R" D ACCUMFAC^HLUCM090
 D ACCUMHR
 D ACCUMSP
 D ACCUMPR
 D TOTALING
 ;
 Q
 ;
TOTALING ; Grand totals
 S TOTCURR=$G(^TMP(TOTALS,$J))
 S $P(TOTCURR,U)=$P(TOTCURR,U)+DATA("CHAR")
 I $G(HLUCMADD)'="DON'T ADD.  COLLECT3~HLUCM003" D
 .  S $P(TOTCURR,U,2)=$P(TOTCURR,U,2)+1
 S $P(TOTCURR,U,3)=$P(TOTCURR,U,3)+DATA("DIFF")
 S $P(TOTCURR,U,4)=$P(TOTCURR,U,4)+1
 S ^TMP(TOTALS,$J)=TOTCURR
 Q
 ;
ACCUMHR ; Hour totaling
 ; DATA(),FAC,START,TYPEHR -- req
 ;
 I HLAPI="CM"!(HLAPI="CM2") D ACCUMLAT^HLUCM009("HR","TM",TYPEHR,START,DATA("PCKG"),DATA("PROT"))
 I HLAPI="CMF"!(HLAPI="CM2F") D ACCUMLAT^HLUCM009("HR","TM",TYPEHR,FAC,START,DATA("PCKG"),DATA("PROT"))
 ;
 ; Total level CATEGORY
 S TOTCURR=$G(^TMP(TOTALS,$J,"HR"))
 D INCR
 S ^TMP(TOTALS,$J,"HR")=TOTCURR
 ;
 QUIT
 ;
ACCUMSP ; Namespace totaling
 ; DATA(),FAC,TYPEIO,TYPELR -- req
 ;
 I HLAPI="CM"!(HLAPI="CM2") D
 .  D ACCUMLAT^HLUCM009("NMSP","IO",TYPEIO,DATA("PCKG"),START,DATA("PROT"))
 .  D ACCUMLAT^HLUCM009("NMSP","LR",TYPELR,DATA("PCKG"),START,DATA("PROT"))
 I HLAPI="CMF"!(HLAPI="CM2F") D
 .  D ACCUMLAT^HLUCM009("NMSP","IO",TYPEIO,FAC,DATA("PCKG"),START,DATA("PROT"))
 .  D ACCUMLAT^HLUCM009("NMSP","LR",TYPELR,FAC,DATA("PCKG"),START,DATA("PROT"))
 ;
 ; Total level CATEGORY
 S TOTCURR=$G(^TMP(TOTALS,$J,"NMSP"))
 D INCR
 S ^TMP(TOTALS,$J,"NMSP")=TOTCURR
 ;
 QUIT
 ;
ACCUMPR ; Protocol totaling...
 ; DATA(),FAC,START -- req
 ;
 I HLAPI="CM"!(HLAPI="CM2") D ACCUMLAT^HLUCM009("PROT","PR","P",DATA("PROT"),DATA("PCKG"),START)
 I HLAPI="CMF"!(HLAPI="CM2F") D ACCUMLAT^HLUCM009("PROT","PR","P",FAC,DATA("PROT"),DATA("PCKG"),START)
 ;
 ; Total level CATEGORY
 S TOTCURR=$G(^TMP(TOTALS,$J,"PROT"))
 D INCR
 S ^TMP(TOTALS,$J,"PROT")=TOTCURR
 ;
 QUIT
 ;
INCR ; Increment totals in TOTCURR...
 ; CHAR,SEC -- req
 S $P(TOTCURR,U)=$P(TOTCURR,U)+CHAR ; Number characters
 I $G(HLUCMADD)'="DON'T ADD.  COLLECT3~HLUCM003" D
 .  S $P(TOTCURR,U,2)=$P(TOTCURR,U,2)+1
 S $P(TOTCURR,U,3)=$P(TOTCURR,U,3)+SEC ; Processing seconds
 S $P(TOTCURR,U,4)=$P(TOTCURR,U,4)+1
 QUIT
 ;
HR(FMDT) ; Return FM DATE and HOUR only...
 N HR
 S FMDT=$G(FMDT)
 I FMDT'?7N&(FMDT'?7N1"."1.N) QUIT "" ;->
 S:FMDT'["." FMDT=FMDT_"."
 S FMDT=$E(FMDT_"00",1,10) ; .00 thru .23 now...
 S HR=+$P(FMDT,".",2)+1
 S:HR<10 HR=0_HR S:HR>24 HR=24
 QUIT (FMDT\1)_"."_HR
 ;
OKPAR101(PAR) ; PAR=IEN101...
 N RET,VAL
 ;
 I PAR=1!(PAR=2) QUIT PAR ;->
 I PAR="0^9999999" QUIT PAR ;->
 ;
 ; Passed as 0^IEN or 0^PROTOCOL NAME...
 S VAL=$P(PAR,U,2)
 ;
 ; Was IEN passed?
 I VAL=+VAL D  QUIT RET ;->
 .  S RET=""
 .  I $D(^ORD(101,+VAL,0)) S RET=PAR
 .  I '$D(^ORD(101,+VAL,0)) QUIT  ;-> Leaving RET=""
 ;
 ; Name was passed... (Can be up to 63 characters long...)
 ; Find IEN for name...
 S VAL=$$FIND101(PAR)
 ;
 ; If VAL=IEN, reset IEN101 to 0^IEN format...
 I VAL>0 QUIT "0^"_+VAL  ;->
 ;
 QUIT ""
 ;
TYPELR(IEN772,FACNM) ; Is this Local or Remote or Unknown?
 ; SITENM -- req
 N D772,I773,IEN,IEN870,IO,MIEN,NM,TXT,TYPE,X
 ;
 ; If SITENM=FACNM, then it isn't remote...
 I $G(SITENM)]"",$G(FACNM)]"",SITENM=FACNM QUIT "L" ;->
 ;
 S D772=$G(^HL(772,+IEN772,0))
 ;
 ; Mailman check...
 S MIEN=$P(D772,U,5) ; get Mailman IEN...
 I MIEN S X=$$MAILTYPE^HLUCM009(MIEN) QUIT:X="R" $$SLR(IEN772,"R") ;-> Mailman, and remote...
 ;
 ; Additional mail check...
 I $$MAIL870^HLUCM090(IEN772)="R" QUIT $$SLR(IEN772,"R") ;->
 ;
 ; Institution check...
 I $$INST870^HLUCM090(+IEN772,+$P($$SITE^VASITE,U,3))="R" QUIT $$SLR(IEN772,"R") ;->
 ;
 ; MSH segment in 773 check...
 S TYPE="L",I773=0
 F  S I773=$O(^HLMA("B",IEN772,I773)) Q:'I773!(TYPE'="L")  D
 .  N DIV,P4,P6
 .  S TXT="",MIEN=0
 .  F  S MIEN=$O(^HLMA(+I773,"MSH",MIEN)) Q:MIEN'>0  D
 .  .  S TXT=TXT_$G(^HLMA(+I773,"MSH",+MIEN,0))
 .  QUIT:TXT']""  ;->
 .  S X=$$SITESMSH^HLUCM009(TXT),P4=$P(X,U),P6=$P(X,U,2)
 .  S:P4'=P6 TYPE="R"
 ;
 ; Was anything found?
 QUIT:TYPE'="L" $$SLR(IEN772,TYPE) ;->
 ;
 ; Logical links check...
 S IEN870=$$IEN870^HLUCM009(+IEN772) I IEN870 D
 .  N DATA,MGIEN
 .  S DATA=$G(^HLCS(870,+IEN870,0))
 .  QUIT:$P(DATA,U,3)'=1  ;-> Not MAIL...
 .  S MGIEN=$P($G(^HLCS(870,+IEN870,100)),U) QUIT:MGIEN'>0  ;->
 .  ; If a MAIL type link and there is an associated mail group,
 ;  ; it is almost always REMOTE.  Enough so, that "R" will be assumed.
 .  ; QUIT:$O(^XMB(3.8,+MGIEN,6,0))'>0  ;-> No remote groups
 .  S TYPE="R"
 .  ; Rare to hit this point.
 ;
 QUIT $$SLR(IEN772,TYPE)
 ;
SLR(IEN772,LR) ; Store the L/R type for use for FACILITY sorting
 N FAC,HLDATA,PARENT,TYPE,X
 Q LR
 ;
PREPARE() ; Called by $$CM & $$CM2 and other APIs...
 ;
 S ORIGSTM=$G(START),ORIGETM=$G(END)
 S SITENM=$P($$SITE^VASITE,U,2)
 ;
 ; Summarize by DAY instead of hour?
 I ORIGSTM?7N,ORIGETM']"" D
 .  S ^TMP($J,"HLUCMDT")=""
 .  S ORIGETM=ORIGSTM_".24"
 ;
 D ZEROUP
 ;
 ; Miscellaneous KILLs...
 D KILLS^HLUCM009("START")
 ;
 ; Build namespace xref
 D NMSPXRF^HLUCM009
 ;
 ; This is where results are returned to caller...
 KILL ERRINFO
 ;
 ; Perform all setup chores.  If errors found, they will be placed
 ; in ERRINFO(ERROR-REASON)="" array
 QUIT:$$SETUP^HLUCM009 "" ;-> Some errors occurred...
 ;
 Q 1
 ;
ZEROUP ; If didn't add 0^...
 I $G(IEN101)]"",IEN101'?1N,IEN101'?1"0^".E S IEN101="0^"_IEN101
 I $G(PNMSP)]"",PNMSP'?1N,PNMSP'?1"0^".E S PNMSP="0^"_PNMSP
 Q
 ;
FIND101(VAL) ; No checking for upp/lowercase.  Must be passed right!
 ; VAL = Protocol name...
 N FIEN,IEN,LNM,PNM
 ;
 S VAL=$P(VAL,"0^",2)
 ;
 ; Passed as IEN?
 I VAL=+VAL,$D(^ORD(101,+VAL,0)) QUIT +VAL ;->
 ;
 ; Passed as NAME?
 S FIEN=0
 S LNM=$E(VAL,1,$S($L(VAL)>30:29,1:$L(VAL)-1))
 F  S LNM=$O(^ORD(101,"B",LNM)) Q:LNM]VAL!(LNM']"")!(FIEN)  D
 .  S IEN=0
 .  F  S IEN=$O(^ORD(101,"B",LNM,IEN)) Q:IEN'>0!(FIEN)  D
 .  .  QUIT:$P($G(^ORD(101,+IEN,0)),U)'=VAL  ;->
 .  .  S FIEN=+IEN
 QUIT $S(FIEN:FIEN,1:"")
 ;
REFPROT(PROT) ; If passed by reference, is PROT in array? 0=Don't count, 2=Count
 ; PROTYPE -- req
 N X
 I PROTYPE'=1 QUIT 1 ;-> Not passed by reference...
 S X=$P(PROT,"~") I X]"" I $D(IEN101(X)) QUIT 1 ;-> found by name in array
 S X=$P(PROT,"~",2) I X]"" I $D(IEN101(+X)) QUIT 1 ;-> found by IEN in array
 QUIT ""
 ;
REFPCKG(PCKG) ; If passed by reference, is PCKG in array? 0=Don't count,1=OK to count
 ; NMSPTYPE -- req
 I NMSPTYPE'=1 QUIT 1 ;-> Not passed by reference...
 I PCKG]"" I $D(PNMSP(PCKG)) QUIT 1 ;-> found in array
 QUIT ""
 ;
EOR ; HLUCM001 - HL7/Capacity Mgt API (continued) ;2/27/01 10:15
