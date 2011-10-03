HLUCM009 ;CIOFO-O/LJA - HL7/Capacity Mgt API-II ;2/25/03-08:50
 ;;1.6;HEALTH LEVEL SEVEN;**103**;Oct 13, 1995
 ;
IEN870(IEN772) ; Given 772 find 870...
 N DATA,I773,I870,IEN
 S DATA=$G(^HL(772,+IEN772,0))
 ;
 ; Logical Link field...
 S IEN=$P(DATA,U,11) I IEN QUIT IEN ;->
 ;
 ; Related Event Protocol...
 S IEN=$P(DATA,U,10),IEN=$P($G(^ORD(101,+IEN,770)),U,7) I IEN QUIT IEN ;->
 ;
 S I773=0
 F  S I773=$O(^HLMA("B",IEN772,I773)) Q:I773'>0  D  QUIT:I870
 .  S I870=$P($G(^HLMA(+I773,0)),U,7)
 I $G(I870) QUIT +I870 ;->
 ;
 QUIT ""
 ;
MSGTYPE(IEN772) ; MSG or MSA's type...
 N DEL,IN
 S IN=$G(^HL(772,+IEN772,"IN",1,0)) QUIT:IN']"" "MSG" ;->
 S DEL=$E(IN,4) QUIT:DEL']"" "MSG" ;->
 S IN=$P(IN,DEL,2) QUIT:IN']"" "MSG" ;->
 I $L(IN)=2,$E(IN)="C"!($E(IN)="A") QUIT IN ;->
 QUIT "MSG"
 ;
KILLS(WHEN) ; Kills of ^TMP data WHEN (START or END or ALL)
 N DATA
 ;
 ; If ALL, set WHEN to include START and END...
 S:WHEN="ALL" WHEN="STARTandEND"
 ;
 ; Always KILLs...
 F DATA="ACTUAL","HLCHILD",$G(TOTALS)_"ERRTIME","HLOAD772","N","HLNMSP94","HLNMSPXRF","HLPARENT","HLRECNM","U","X" D
 .  KILL ^TMP(DATA,$J),^TMP($J,DATA)
 ;
 ; START-only KILLs...
 I WHEN["START" D
 .  F DATA="HLUCMSTORE","RFAC",$G(TOTALS) D
 .  .  QUIT:DATA']""  ;-> Sometimes TOTALS might not be defined
 .  .  KILL ^TMP(DATA,$J),^TMP($J,DATA)
 ;
 ; END-only KILLs...
 I WHEN["END" D
 .  KILL HLAPI
 .  ; Don't store any debug global data...
 .  I $G(^TMP($J,"HLUCM"))'="DEBUG GLOBAL" KILL ^TMP($J)
 .  F DATA="HL4","HLUCM","HLUCMDT" D
 .  .  KILL ^TMP($J,DATA),^TMP(DATA,$J)
 ;
 QUIT
 ;
SITESMSH(TXT) ; Return location pieces, slightly modified...
 N DIV,P4,P6
 S DIV=$E(TXT,4),P4=$P(TXT,DIV,4),P6=$P(TXT,DIV,6)
 S P4=$S(P4?1.N1"~"!(P4?1.N):+P4,1:"")
 S P6=$S(P6?1.N1"~"!(P6?1.N):+P6,1:"")
 QUIT P4_U_P6
 ;
MAILTYPE(MIEN) ; Is MSH in Mailman message local or remote...
 N IEN,RECNO,TO,TOID,TYPE
 S TYPE="L"
 KILL ^TMP($J,"HLMAILTYPE")
 D QD^XMXUTIL3(+MIEN,,,,,"^TMP($J,""HLMAILTYPE"")")
 S RECNO=0
 F  S RECNO=$O(^TMP($J,"HLMAILTYPE","XMLIST",RECNO)) Q:RECNO'>0!(TYPE'="L")  D
 .  S TO=$G(^TMP($J,"HLMAILTYPE","XMLIST",+RECNO,"TO"))
 .  S TOID=$G(^TMP($J,"HLMAILTYPE","XMLIST",+RECNO,"TO ID"))
 .  I TO["@"!(TOID="R") S TYPE="R"
 KILL ^TMP($J,"HLMAILTYPE")
 QUIT TYPE
 ;
NMSPXRF ; Xref of namespaces that can be inferred. (If start with DG change to DG)
 N I,T KILL ^TMP($J,"HLNMSPXRF") F I=2:1 S T=$T(NMSPXRF+I) Q:T'[";;"  S T=$P(T,";;",2,99),^TMP($J,"HLNMSPXRF",$P(T,U))=$P(T,U,2)
 ;;DG^DG
 ;;GM^GM
 ;;HEC^HEC
 ;;IB^IB
 ;;IVM^IVM
 ;;LA^LA
 ;;MPI^MPI
 ;;OR^OR
 ;;PR^PR
 ;;PS^PS
 ;;RG^RG
 ;;ROR^ROR
 ;;SC^SC
 ;;VEI^VEIB
 ;;XM^XMB
 ;;XU^XU
 ;;XW^XWB
 Q
 ;
ACCUMLAT(CATEGORY,TYPE,SORT,SUB1,SUB2,SUB3,SUB4) ; Generic accumulator
 ;
 I $G(SUB4)]"" D
 .  S TOTCURR=$G(^TMP(TOTALS,$J,CATEGORY,TYPE,SORT,SUB1,SUB2,SUB3,SUB4))
 .  D INCR^HLUCM001
 .  S ^TMP(TOTALS,$J,CATEGORY,TYPE,SORT,SUB1,SUB2,SUB3,SUB4)=TOTCURR
 ;
 S TOTCURR=$G(^TMP(TOTALS,$J,CATEGORY,TYPE,SORT,SUB1,SUB2,SUB3))
 D INCR^HLUCM001
 S ^TMP(TOTALS,$J,CATEGORY,TYPE,SORT,SUB1,SUB2,SUB3)=TOTCURR
 ;
 ; Totals level 2 for SUB...
 S TOTCURR=$G(^TMP(TOTALS,$J,CATEGORY,TYPE,SORT,SUB1,SUB2))
 D INCR^HLUCM001
 S ^TMP(TOTALS,$J,CATEGORY,TYPE,SORT,SUB1,SUB2)=TOTCURR
 ;
 ; Totals level 1 for SUB...
 S TOTCURR=$G(^TMP(TOTALS,$J,CATEGORY,TYPE,SORT,SUB1))
 D INCR^HLUCM001
 S ^TMP(TOTALS,$J,CATEGORY,TYPE,SORT,SUB1)=TOTCURR
 ;
 ; Total level TYPE/SORT...
 S TOTCURR=$G(^TMP(TOTALS,$J,CATEGORY,TYPE,SORT))
 D INCR^HLUCM001
 S ^TMP(TOTALS,$J,CATEGORY,TYPE,SORT)=TOTCURR
 ;
 ; Total level TYPE
 S TOTCURR=$G(^TMP(TOTALS,$J,CATEGORY,TYPE))
 D INCR^HLUCM001
 S ^TMP(TOTALS,$J,CATEGORY,TYPE)=TOTCURR
 ;
 ; Total level CATEGORY
 ; [Don't subtotal here, for NMSP holds two different TYPEs, and
 ; if totalled here, it would double count.]
 ;
 QUIT
 ;
LOAD772S(IEN772,HLNMSP) ; Load list of related 772s... [HL*1.6*91]
 ;
 ; Warning!!!  This call point will never load more than 20 entries...
 ;             Any more than that, and probably an error condition
 ;             exists.
 ;
 N ACKTO,CHILD,DATA,FAC,HL772,HLI,HLJ,HLK,HLN,HLPCKG,HLZZI,HOLDNMSP,I
 N I772,I773,MSGID,NUM,PARENT,PCKG,PIEN,PROT,TOTNUM,VAL,X
 ;
 KILL HLNMSP
 QUIT:$G(^HL(772,+$G(IEN772),0))']"" "" ;->
 ;
 S DATA=$G(^HL(772,+$G(IEN772),0)) QUIT:DATA']"" "" ;->
 ;
 ; Loop until no new entries found or more than 20 entries...
 S NUM=$$LOADEM^HLUCM050(+IEN772,.HLNMSP)
 ;
 QUIT NUM
 ;
HOLDTOT(IEN) ; Accumulate...
 QUIT:$D(HOLDNMSP(IEN))!(TOTNUM>19)  ;->
 S HOLDNMSP(IEN)="",TOTNUM=TOTNUM+1
 QUIT
 ;
SETUP() ; Perform checks, which can return error conditions, and
 ; set up variables for $$LOOP.  This extrinsic function returns
 ; "" if no errors, or the # errors found.  (Note that error
 ; details placed in ERRINFO(ERROR-REASON)="")
 N NOERR
 S NOERR=""
 D SETDEF ; Set defaults for parameters, if not passed
 D FINDWAY ; Find way NMSP and PROT parameters passed
 D SETMORE^HLUCM003 ; Additional var sets based on parameters & "way"...
 D ERRCHK^HLUCM003 ; Check for errors...
 KILL ^TMP(TOTALS,$J) ; Clear out storage location...
 QUIT NOERR
 ;
SETDEF ; Set various defaults...
 I '$D(PNMSP) S PNMSP=1
 I '$D(IEN101) S IEN101=1
 I $G(TOTALS)']"" S TOTALS="HLTOTALS"
 S COND=$$UP^XLFSTR(COND)
 S COND=$S($G(COND)="BOTH":COND,1:"EITHER") ; Default to EITHER matches, count it...
 QUIT
 ;
FINDWAY ; How were NMSP and PROT passed?  By reference?  (If so, return 1)
 ; Passed by reference?
 S NMSPTYPE=$S($G(PNMSP)']""&($O(PNMSP(""))]""):1,1:0) ; 1=YES
 S PROTYPE=$S($G(IEN101)']""&($O(IEN101(""))]""):1,1:0) ; 1=YES
 QUIT
 ;
MSGID(MSGID) ; Search forward for MSA's to this MSGID...
 N BIEN,CT,D,HOLD,I772,I773,MSA,X
 ;
 S X=$O(^HL(772,"C",MSGID,0)) I X S HOLD(X)=""
 S X=$O(^HLMA("C",MSGID,0)) I X S X=+$G(^HLMA(+X,0)) I X S HOLD(X)=""
 ;
 Q
 ;
ERRMOVE(IEN772) ; Move all associated data out of ^TMP's totaling arrays
 N IEN772C,IEN772P
 ;
 ; Find parent message (because have to move ALL associated messages out)
 QUIT:$G(^TMP($J,"HLUCM"))'="DEBUG GLOBAL"  ;->
 S IEN772P=$O(^TMP($J,"HLUCMSTORE","X",+IEN772,0))
 I IEN772P'>0 S IEN772P=IEN772
 ;
 ; Loop thru all associated messages in unit...
 S IEN772C=0
 F  S IEN772C=$O(^TMP($J,"HLUCMSTORE","U",IEN772P,IEN772C)) Q:'IEN772C  D
 .  F SUB="C","E","O","X" D
 .  .  MERGE ^TMP($J,"HLUCMSTORE","ERR",SUB,IEN772C)=^TMP($J,"HLUCMSTORE",SUB,IEN772C)
 .  .  KILL ^TMP($J,"HLUCMSTORE",SUB,IEN772C)
 ;
 ; Maybe there is no X xref...
 MERGE ^TMP($J,"HLUCMSTORE","ERR","E",+IEN772P)=^TMP($J,"HLUCMSTORE","E",+IEN772P)
 KILL ^TMP($J,"HLUCMSTORE","E",+IEN772P)
 ;
 ; Finally, move the unit's data...
 MERGE ^TMP($J,"HLUCMSTORE","ERR","U",IEN772P)=^TMP($J,"HLUCMSTORE","U",IEN772P)
 KILL ^TMP($J,"HLUCMSTORE","U",IEN772P)
 ;
 Q
 ;
EOR ;HLUCM009 - HL7/Capacity Mgt API-II ;2/25/03-08:50
