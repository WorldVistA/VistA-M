XUMFXHL7 ;BPFO/JRP - IEMM UTILTIES (CONT);7/29/2002
 ;;8.0;KERNEL;**299,407**;Jul 10, 1995;Build 8
 ;
 ;copied from SCMSVUT5
 ;
PARSE(INARR,OUTARR,SEP,SUB,MAX) ;Parse array into individual fields
 ;Input  : INARR - Array containing data to parse (full global ref)
 ;                   INARR = First 245 characters of data
 ;                   INARR(1..n) = Continuation nodes
 ;                        OR
 ;                   INARR(x) = First 245 characters of data
 ;                   INARR(x,1..n) = Continuation nodes
 ;         OUTARR - Array to put parsed data into (full global ref)
 ;         SEP - Field separator (defaults to ^) (1 character)
 ;         SUB - Starting subscript of OUTARR (defaults to 0)
 ;         MAX - Maximum length of output node (defaults to 245)
 ;Output : None
 ;         OUTARR(SUB) = First piece (MAX characters)
 ;         OUTARR(SUB,1..n) = Continuation nodes
 ;         OUTARR(SUB+X) = Xth piece (MAX characters)
 ;         OUTARR(SUB+X,1..n) = Continuation nodes
 ;Notes  : OUTARR is initialized (KILLed) on entry
 ;       : Assumes that INARR and OUTARR are defined and valid
 ;
 ;Declare variables
 N NODE,STOP,DATA,INFO,FLD,SEPCNT,CN,OUT,TMP,ROOT,OUTNODE
 K @OUTARR
 S SEP=$G(SEP) S SEP=$E(SEP,1) S:SEP="" SEP="^"
 S SUB=+$G(SUB)
 S MAX=+$G(MAX) S:'MAX MAX=245
 S NODE=INARR
 S INFO=$G(@NODE)
 S ROOT=$$OREF^DILF(INARR)
 S FLD=1
 S SEPCNT=$L(INFO,SEP)
 S STOP=0
 S OUTNODE=$NA(@OUTARR@(SUB))
 S CN=0
 F  S DATA=$P(INFO,SEP,FLD) D  Q:STOP
 .I FLD=SEPCNT D  Q
 ..D ADDNODE
 ..S NODE=$Q(@NODE)
 ..I (NODE="")!(NODE'[ROOT) S STOP=1 Q
 ..S INFO=$G(@NODE)
 ..S SEPCNT=$L(INFO,SEP)
 ..S FLD=1
 .D ADDNODE
 .S SUB=SUB+1
 .S CN=0
 .S OUTNODE=$NA(@OUTARR@(SUB))
 .S FLD=FLD+1
 Q
ADDNODE ;Used by PARSE to add data to output node (handles continuation nodes)
 S TMP=$G(@OUTNODE)
 I ($L(TMP)+$L(DATA))<(MAX+1) S @OUTNODE=TMP_DATA Q
 S @OUTNODE=TMP_$E(DATA,1,(MAX-$L(TMP)))
 S CN=CN+1
 S DATA=$E(DATA,(MAX-$L(TMP)+1),$L(DATA))
 S OUTNODE=$NA(@OUTARR@(SUB,CN))
 I DATA'="" D ADDNODE
 Q
 ;
 ;
SEGPRSE(SEGMENT,OUTARR,FS,LENGTH)      ;Parse HL7 segment by field separator
 ;Input  : SEGMENT - Array containing HL7 segment to parse
 ;                   (full global ref)
 ;                   SEGMENT = First 245 characters of segment
 ;                   SEGMENT(1..n) = Continuation nodes
 ;                        OR
 ;                   SEGMENT(x) = First 245 characters of segment
 ;                   SEGMENT(x,1..n) = Continuation nodes
 ;         OUTARR - Array to put parsed segment into (full global ref)
 ;         FS - HL7 field separator (defaults to ^) (1 character)
 ;Output : None
 ;         OUTARR(0) = Segment name
 ;         OUTARR(seq#) = Data (first 245 characters)
 ;         OUTARR(seq#,1..n) Continuation nodes
 ;Notes  : OUTARR is initialized (KILLed) on entry
 ;       : Assumes SEGMENT and OUTARR are defined and valid
 ;
 S LENGTH=$S($G(LENGTH):LENGTH,1:245)
 ;
 D PARSE($G(SEGMENT),$G(OUTARR),$G(FS),0,LENGTH)
 Q
 ;
SEQPRSE(SEQDATA,OUTARR,ENCODE)  ;Parse HL7 sequence by component
 ;Input  : SEQDATA - Array containing seq to parse (full global ref)
 ;                   SEQDATA = First 245 characters of sequence
 ;                   SEQDATA(1..n) = Continuation nodes
 ;                        OR
 ;                   SEQDATA(x) = First 245 characters of sequence
 ;                   SEQDATA(x,1..n) = Continuation nodes
 ;         OUTARR - Array to put parsed sequence into (full global ref)
 ;         ENCODE - HL7 encoding characters (defaults to ~|\&) (4 chars)
 ;Output : None
 ;         OUTARR(rep#,comp#) = Data (first 245 characters)
 ;         OUTARR(rep#,comp#,1..n) = Continuation nodes
 ;Notes  : OUTARR is initialized (KILLed) on entry
 ;       : Assumes SEQDATA and OUTARR are defined and valid
 ;
 ;Declare variables
 N RS,CS,INFO,DATA,REP,COMP
 S ENCODE=$G(ENCODE,"~|\&")
 S ENCODE=$E(ENCODE,1,4) S:$L(ENCODE)'=4 ENCODE="~|\&"
 S CS=$E(ENCODE,1)
 S RS=$E(ENCODE,2)
 S INFO=$NA(^TMP("XUMFXHL7",$J,"SEQPRSE"))
 D PARSE($G(SEQDATA),INFO,RS,1,245)
 S REP=0
 F  S REP=+$O(@INFO@(REP)) Q:'REP  D PARSE($NA(@INFO@(REP)),$NA(@OUTARR@(REP)),CS,1,245)
 K @INFO
 Q
        
