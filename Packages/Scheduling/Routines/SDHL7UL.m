SDHL7UL ;MS/TG - TMP HL7 Routine;JULY 23, 2018
 ;;5.3;Scheduling;**704**;May 29, 2018;Build 64
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
RESET ; Initialize or clear session pointer into log
 K ^TMP("SDHL7LOG",$J)
 Q
LOGPRG(RESULT,DTM) ;Purge SDHL7 application log
 ;
 ;  Input:
 ;    DTM - Purge Date/Time - optional
 ;          Fileman date/time
 ;          Default to older than a week
 ;
 ;  Output:
 ;    RESULT - success flag ^ purge date/time
 ;
 N %DT,X,Y
 S X=$G(DTM),%DT="TX" D ^%DT S DTM=Y
 I DTM<0 S DTM=$$HTFM^XLFDT($H-7,1)
 S RESULT=DTM
 S DTM=-DTM
 F  S DTM=$O(^XTMP("SDHL7LOG",2,DTM)) Q:DTM=""  K ^XTMP("SDHL7LOG",2,DTM)
 S RESULT="1^"_RESULT
 Q
 ; 
AUTOPRG ;
 Q:'$G(^XTMP("SDHL7LOG",1,"AUTOPURGE"))
 N DT,DAYS,RESULT
 ; Purge only once per day
 S DT=$$DT^XLFDT
 Q:$G(^XTMP("SDHL7LOG",1,"AUTOPURGE","PURGE DATE"))=DT
 ;
 S DAYS=$G(^XTMP("SDHL7LOG",1,"AUTOPURGE","DAYS"))
 I DAYS<1 S DAYS=7
 ;
 D LOGPRG(.RESULT,$$HTFM^XLFDT($H-DAYS,1))
 S ^XTMP("SDHL7LOG",1,"AUTOPURGE","PURGE DATE")=DT
 Q
 ; 
LOG(NAME,DATA,TYPE,LEVEL) ;Log to SDHL7 application log
 ;
 ;  Input:
 ;    NAME - Name to identify log entry
 ;    DATA - Value,Tree, or Name of structure to put in log
 ;    TYPE - Type of log entry
 ;              S:Set Single Value
 ;              M:Merge Tree 
 ;              I:Indirect Merge @
 ;   LEVEL - Level of log entry - ERROR,TRACE,NAMED,DEBUG
 ;
 ;  Output:
 ;    Adds entry to log
 ;
 ; ^XTMP("SDHL7LOG",0) - Head of log file
 ; ^XTMP("SDHL7LOG",1) - if set indicates that logging is on
 ; ^XTMP("SDHL7LOG",1,"LEVEL") - logging level
 ; ^XTMP("SDHL7LOG",1,"LEVEL",LEVEL) = rank
 ; ^XTMP("SDHL7LOG",1,"NAMES",) - names to log caret delimited string
 ; ^XTMP("SDHL7LOG",1,"NAMES",NAME) - name to log
 ; ^XTMP("SDHL7LOG",2) - contains the log
 ; ^XTMP("SDHL7LOG",2,negated FM timestamp,$J,counter,NAME) - log entry
 ;
 ; ^TMP("SDHL7LOG",$J) - Session current log entry (DTM)
 ;
 ;Quit if logging is not turned on
 Q:'$G(^XTMP("SDHL7LOG",1))
 N DTM,CNT,LOGLEVEL
 ;
 Q:'$D(DATA)
 Q:$G(TYPE)=""
 Q:$G(NAME)=""
 S NAME=$TR(NAME,"^","-")
 ;
 ;If LEVEL is null or unknown default to DEBUG
 I $G(LEVEL)="" S LEVEL="DEBUG"
 I '$D(^XTMP("SDHL7LOG",1,"LEVEL",LEVEL)) S LEVEL="DEBUG"
 ;
 ;Log entries at or lower than the current logging level set
 ;Levels are ranked as follows:
 ;  ^XTMP("SDHL7LOG",1,"LEVEL","ERROR")=1
 ;  ^XTMP("SDHL7LOG",1,"LEVEL","TRACE")=2
 ;  ^XTMP("SDHL7LOG",1,"LEVEL","NAMED")=3
 ;  ^XTMP("SDHL7LOG",1,"LEVEL","DEBUG")=4
 ;Named is like a filtered version of debug.
 ;Additional levels may be added, and ranks changed without affecting
 ;the LOG api.  Inserting a level between Named and Debug will require
 ;a change to the conditional below.
 S LOGLEVEL=$G(^XTMP("SDHL7LOG",1,"LEVEL"))
 I LOGLEVEL="" S LOGLEVEL="TRACE"
 I $G(^XTMP("SDHL7LOG",1,"LEVEL",LEVEL))>$G(^XTMP("SDHL7LOG",1,"LEVEL",LOGLEVEL)) Q:LOGLEVEL'="NAMED"  Q:'$D(^XTMP("SDHL7LOG",1,"NAMES",NAME))
 ;
 ; Check ^TMP("SDHL7LOG",$J) If no current log node start a new node
 I '$G(^TMP("SDHL7LOG",$J)) D
 . S DTM=-$$NOW^XLFDT()
 . K ^XTMP("SDHL7LOG",2,DTM,$J)
 . S ^TMP("SDHL7LOG",$J)=DTM
 . S CNT=1
 . S ^XTMP("SDHL7LOG",2,DTM,$J)=CNT
 . D AUTOPRG
 . Q
 E  D
 . S DTM=^TMP("SDHL7LOG",$J)
 . S CNT=$G(^XTMP("SDHL7LOG",2,DTM,$J))+1
 . S ^XTMP("SDHL7LOG",2,DTM,$J)=CNT
 . Q
 ;
 I TYPE="S" S ^XTMP("SDHL7LOG",2,DTM,$J,CNT,NAME)=DATA Q
 I TYPE="M" M ^XTMP("SDHL7LOG",2,DTM,$J,CNT,NAME)=DATA Q
 I TYPE="I" M ^XTMP("SDHL7LOG",2,DTM,$J,CNT,NAME)=@DATA Q
 ;
 Q
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
