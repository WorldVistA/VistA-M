MHV7U ;WAS/GPM - HL7 UTILITIES ; [1/7/08 10:21pm]
 ;;1.0;My HealtheVet;**1,2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine contains generic utilities used when building
 ;or processing HL7 messages.
 ;
 Q  ;Direct entry not supported
 ;
LOADMSG(MSGROOT) ; Load HL7 message into temporary global for processing
 ;
 ;This subroutine assumes that all VistA HL7 environment variables are
 ;properly initialized and will produce a fatal error if they aren't.
 ;
 N CNT,SEG
 K @MSGROOT
 F SEG=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S CNT=0
 . S @MSGROOT@(SEG,CNT)=HLNODE
 . F  S CNT=$O(HLNODE(CNT)) Q:'CNT  S @MSGROOT@(SEG,CNT)=HLNODE(CNT)
 Q
 ;
LOADXMT(XMT) ;Set HL dependent XMT values
 ;
 ; The HL array and variables are expected to be defined.  If not,
 ; message processing will fail.  These references should not be
 ; wrapped in $G, as null values will simply postpone the failure to
 ; a point that will be harder to diagnose.  Except HL("APAT") which
 ; is not defined on synchronous calls.
 ; Also assumes MHV RESPONSE MAP file is setup for every protocol 
 ; pair defined by MHV package.
 ;
 ;  Integration Agreements:
 ;         1373 : Reference to PROTOCOL file #101
 ;
 N SUBPROT,RESPIEN,RESP0
 S XMT("MID")=HL("MID")                   ;Message ID
 S XMT("MODE")="A"                        ;Response mode
 I $G(HL("APAT"))="" S XMT("MODE")="S"    ;Synchronous mode
 S XMT("HLMTIENS")=HLMTIENS               ;Message IEN
 S XMT("MESSAGE TYPE")=HL("MTN")          ;Message type
 S XMT("EVENT TYPE")=HL("ETN")            ;Event type
 S XMT("DELIM")=HL("FS")_HL("ECH")        ;HL Delimiters
 S XMT("MAX SIZE")=0                      ;Default size unlimited
 ;
 ; Map response protocol and builder
 S SUBPROT=$P(^ORD(101,HL("EIDS"),0),"^")
 S RESPIEN=$O(^MHV(2275.4,"B",SUBPROT,0))
 S RESP0=$G(^MHV(2275.4,RESPIEN,0))
 S XMT("PROTOCOL")=$P(RESP0,"^",2)             ;Response Protocol
 S XMT("BUILDER")=$TR($P(RESP0,"^",3),"~","^") ;Response Builder
 S XMT("BREAK SEGMENT")=$P(RESP0,"^",4)        ;Boundary Segment
 Q
 ;
DELIM(PROTOCOL) ;Return string of message delimiters based on Protocol
 ;
 ;  Integration Agreements:
 ;         2161 : INIT^HLFNC2
 ;
 N HL
 Q:PROTOCOL="" ""
 D INIT^HLFNC2(PROTOCOL,.HL)
 Q $G(HL("FS"))_$G(HL("ECH"))
 ;
PARSEMSG(MSGROOT,HL) ; Message Parser
 ; Does not handle segments that span nodes
 ; Does not handle extremely long segments (uses a local)
 ; Does not handle long fields (segment parser doesn't)
 ;
 N SEG,CNT,DATA,MSG
 F CNT=1:1 Q:'$D(@MSGROOT@(CNT))  M SEG=@MSGROOT@(CNT) D
 . D PARSESEG(SEG(0),.DATA,.HL)
 . K @MSGROOT@(CNT)
 . I DATA(0)'="" M @MSGROOT@(CNT)=DATA
 . Q:'$D(SEG(1))
 . ;Add handler for segments that span nodes here.
 . Q
 Q
 ;
PARSESEG(SEG,DATA,HL) ;Generic segment parser
 ;This procedure parses a single HL7 segment and builds an array
 ;subscripted by the field number containing the data for that field.
 ; Does not handle segments that span nodes
 ;
 ;  Input:
 ;     SEG - HL7 segment to parse
 ;      HL - HL7 environment array
 ;
 ;  Output:
 ;    Function value - field data array [SUB1:field, SUB2:repetition,
 ;                                SUB3:component, SUB4:sub-component] 
 ;
 N CMP     ;component subscript
 N CMPVAL  ;component value
 N FLD     ;field subscript
 N FLDVAL  ;field value
 N REP     ;repetition subscript
 N REPVAL  ;repetition value
 N SUB     ;sub-component subscript
 N SUBVAL  ;sub-component value
 N FS      ;field separator
 N CS      ;component separator
 N RS      ;repetition separator
 N SS      ;sub-component separator
 ;
 K DATA
 S FS=HL("FS")
 S CS=$E(HL("ECH"))
 S RS=$E(HL("ECH"),2)
 S SS=$E(HL("ECH"),4)
 ;
 S DATA(0)=$P(SEG,FS)
 S SEG=$P(SEG,FS,2,9999)
 F FLD=1:1:$L(SEG,FS) D
 . S FLDVAL=$P(SEG,FS,FLD)
 . F REP=1:1:$L(FLDVAL,RS) D
 . . S REPVAL=$P(FLDVAL,RS,REP)
 . . I REPVAL[CS F CMP=1:1:$L(REPVAL,CS) D
 . . . S CMPVAL=$P(REPVAL,CS,CMP)
 . . . I CMPVAL[SS F SUB=1:1:$L(CMPVAL,SS) D
 . . . . S SUBVAL=$P(CMPVAL,SS,SUB)
 . . . . I SUBVAL'="" S DATA(FLD,REP,CMP,SUB)=SUBVAL
 . . . I '$D(DATA(FLD,REP,CMP)),CMPVAL'="" S DATA(FLD,REP,CMP)=CMPVAL
 . . I '$D(DATA(FLD,REP)),REPVAL'="",FLDVAL[RS S DATA(FLD,REP)=REPVAL
 . I '$D(DATA(FLD)),FLDVAL'="" S DATA(FLD)=FLDVAL
 Q
 ;
BLDSEG(DATA,HL) ;generic segment builder
 ;
 ;  Input:
 ;    DATA - field data array [SUB1:field, SUB2:repetition,
 ;                             SUB3:component, SUB4:sub-component]
 ;     HL - HL7 environment array
 ;
 ;  Output:
 ;   Function Value - Formatted HL7 segment on success, "" on failure
 ;
 N CMP     ;component subscript
 N CMPVAL  ;component value
 N FLD     ;field subscript
 N FLDVAL  ;field value
 N REP     ;repetition subscript
 N REPVAL  ;repetition value
 N SUB     ;sub-component subscript
 N SUBVAL  ;sub-component value
 N FS      ;field separator
 N CS      ;component separator
 N RS      ;repetition separator
 N ES      ;escape character
 N SS      ;sub-component separator
 N SEG,SEP
 ;
 S FS=HL("FS")
 S CS=$E(HL("ECH"))
 S RS=$E(HL("ECH"),2)
 S ES=$E(HL("ECH"),3)
 S SS=$E(HL("ECH"),4)
 ;
 S SEG=$G(DATA(0))
 F FLD=1:1:$O(DATA(""),-1) D
 . S FLDVAL=$G(DATA(FLD)),SEP=FS
 . S SEG=SEG_SEP_FLDVAL
 . F REP=1:1:$O(DATA(FLD,""),-1)  D
 . . S REPVAL=$G(DATA(FLD,REP))
 . . S SEP=$S(REP=1:"",1:RS)
 . . S SEG=SEG_SEP_REPVAL
 . . F CMP=1:1:$O(DATA(FLD,REP,""),-1) D
 . . . S CMPVAL=$G(DATA(FLD,REP,CMP))
 . . . S SEP=$S(CMP=1:"",1:CS)
 . . . S SEG=SEG_SEP_CMPVAL
 . . . F SUB=1:1:$O(DATA(FLD,REP,CMP,""),-1) D
 . . . . S SUBVAL=$G(DATA(FLD,REP,CMP,SUB))
 . . . . S SEP=$S(SUB=1:"",1:SS)
 . . . . S SEG=SEG_SEP_SUBVAL
 Q SEG
 ;
BLDWP(WP,SEG,MAXLEN,FORMAT,FMTLEN,HL) ;
 ;Builds segment nodes to add word processing fields to a segment
 N CNT,LINE,LAST,FS,RS,LENGTH,I
 I MAXLEN<1 S MAXLEN=99999999999999999
 S FS=HL("FS")         ;field separator
 S RS=$E(HL("ECH"),2)  ;repeat separator
 S CNT=$O(SEG(""),-1)+1
 S SEG(CNT)=FS
 S FMTLEN=0
 S LENGTH=0
 ;
 S I=0
 F  S I=$O(WP(I)) Q:'I  D  Q:LENGTH'<MAXLEN
 . I $D(WP(I,0)) S LINE=$G(WP(I,0))  ;conventional WP field
 . E  S LINE=$G(WP(I))
 . S LENGTH=LENGTH+$L(LINE)
 . I LENGTH'<MAXLEN S LINE=$E(LINE,1,$L(LINE)-(LENGTH-MAXLEN))
 . S LINE=$$ESCAPE(LINE,.HL)
 . S LAST=$E(LINE,$L(LINE))
 . ;first line
 . I SEG(CNT)=FS S SEG(CNT)=FS_LINE,FMTLEN=FMTLEN+$L(SEG(CNT)) Q
 . S CNT=CNT+1
 . S SEG(CNT)=RS_LINE,FMTLEN=FMTLEN+$L(SEG(CNT))
 . Q:'FORMAT
 . ;attempt to keep sentences together
 . I $E(LINE)=" "!(LAST=" ") S SEG(CNT)=LINE,FMTLEN=FMTLEN+$L(LINE)
 . Q
 Q
 ;
ESCAPE(VAL,HL) ;Escape any special characters
 ; *** Does not handle long strings of special characters ***
 ;
 ;  Input:
 ;    VAL - value to escape
 ;     HL - HL7 environment array
 ;
 ;  Output:
 ;    VAL - passed by reference
 ;
 N FS      ;field separator
 N CS      ;component separator
 N RS      ;repetition separator
 N ES      ;escape character
 N SS      ;sub-component separator
 N L,STR,I
 ;
 S FS=HL("FS")
 S CS=$E(HL("ECH"))
 S RS=$E(HL("ECH"),2)
 S ES=$E(HL("ECH"),3)
 S SS=$E(HL("ECH"),4)
 ;
 I VAL[ES D
 . S L=$L(VAL,ES),STR=""
 . F I=1:1:L S $P(STR,ES_"E"_ES,I)=$P(VAL,ES,I)
 . S VAL=STR
 I VAL[FS D
 . S L=$L(VAL,FS),STR=""
 . F I=1:1:L S $P(STR,ES_"F"_ES,I)=$P(VAL,FS,I)
 . S VAL=STR
 I VAL[RS D
 . S L=$L(VAL,RS),STR=""
 . F I=1:1:L S $P(STR,ES_"R"_ES,I)=$P(VAL,RS,I)
 . S VAL=STR
 I VAL[CS D
 . S L=$L(VAL,CS),STR=""
 . F I=1:1:L S $P(STR,ES_"S"_ES,I)=$P(VAL,CS,I)
 . S VAL=STR
 I VAL[SS D
 . S L=$L(VAL,SS),STR=""
 . F I=1:1:L S $P(STR,ES_"T"_ES,I)=$P(VAL,SS,I)
 . S VAL=STR
 Q VAL
 ;
UNESC(VAL,HL) ;Reconstitute any escaped characters
 ;
 ;  Input:
 ;    VAL - Value to reconstitute
 ;     HL - HL7 environment array
 ;
 ;  Output:
 ;    VAL - passed by reference
 ;
 N FS      ;field separator
 N CS      ;component separator
 N RS      ;repetition separator
 N ES      ;escape character
 N SS      ;sub-component separator
 N L,STR,I,FESC,CESC,RESC,EESC,SESC
 ;
 S FS=HL("FS")
 S CS=$E(HL("ECH"))
 S RS=$E(HL("ECH"),2)
 S ES=$E(HL("ECH"),3)
 S SS=$E(HL("ECH"),4)
 S FESC=ES_"F"_ES
 S CESC=ES_"S"_ES
 S RESC=ES_"R"_ES
 S EESC=ES_"E"_ES
 S SESC=ES_"T"_ES
 ;
 I VAL'[ES Q VAL
 I VAL[FESC D
 . S L=$L(VAL,FESC),STR=""
 . F I=1:1:L S $P(STR,FS,I)=$P(VAL,FESC,I)
 . S VAL=STR
 I VAL[CESC D
 . S L=$L(VAL,CESC),STR=""
 . F I=1:1:L S $P(STR,CS,I)=$P(VAL,CESC,I)
 . S VAL=STR
 I VAL[RESC D
 . S L=$L(VAL,RESC),STR=""
 . F I=1:1:L S $P(STR,RS,I)=$P(VAL,RESC,I)
 . S VAL=STR
 I VAL[SESC D
 . S L=$L(VAL,SESC),STR=""
 . F I=1:1:L S $P(STR,SS,I)=$P(VAL,SESC,I)
 . S VAL=STR
 I VAL[EESC D
 . S L=$L(VAL,EESC),STR=""
 . F I=1:1:L S $P(STR,ES,I)=$P(VAL,EESC,I)
 . S VAL=STR
 Q VAL
 ;
