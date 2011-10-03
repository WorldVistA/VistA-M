VAFHLRO1 ;BP/JRP - UTILITIES FOR BUILDING HL7 ROLE SEGMENT;11/18/1997
 ;;5.3;Registration;**160**;Aug 13, 1993
 ;
 ;
FIXLEN(INARR,OUTARR,MAXLEN,WORKSUB) ;Fixed length copy/collapse
 ;
 ;Input  : INARR - Input array (full global reference)
 ;         OUTARR - Output array (full global reference)
 ;         MAXLEN - Maximum length (defaults to 245)
 ;         WORKSUB - Subscript [in OUTARR] to begin from (defaults to 0)
 ;Output : None
 ;         INARR() will be collapsed into OUTARR()
 ;Notes  : Validity and existance of input is assumed
 ;       : OUTARR() is not initialized (i.e. KILLed) on input
 ;       : Sample input & output with maximum length of 4
 ;           INARR(1)=12345      OUTARR(0)=1234
 ;           INARR(1,2)=ABCD     OUTARR(1)=5ABC
 ;           INARR(2)=567        OUTARR(2)=D567
 ;
 ;
 S MAXLEN=$G(MAXLEN)
 S:(MAXLEN<1) MAXLEN=245
 S WORKSUB=$G(WORKSUB)
 S:(WORKSUB<1) WORKSUB=0
 ;Declare variables
 N ROOT,VALUE,RESULT
 ;Declare variables for recursive portion of call
 N LENVAL,LENRES,LEN,LENOVR
 ;Remember root of INARR
 S ROOT=$$OREF^DILF(INARR)
 ;Work down INARR
 S RESULT=""
 F  S INARR=$Q(@INARR) Q:((INARR="")!(INARR'[ROOT))  D
 .;Grab value to append
 .S VALUE=$G(@INARR)
 .;Recusively do fix length copy/collapse
 .D FIXLEN1
 ;If anything still left in RESULT, put into OUTARR()
 S:(RESULT'="") @OUTARR@(WORKSUB)=RESULT
 ;Done
 Q
 ;
FIXLEN1 ;Recursive portion of FIXLEN
 ;
 ;Input  : VALUE - Value to append to RESULT
 ;         RESULT - Working & resulting value
 ;         OUTARR - Array to place max length results into (full global)
 ;         WORKSUB - Working subscript in OUTARR (where to put results)
 ;         MAXLEN - Maximum length for RESULT
 ;Output : None
 ;         If max length was exceeded, then OUTARR(WORKSUB) will contain
 ;         the leading portion of appending, WORKSUB will be incremented
 ;         by 1, and RESULT will contain what was left.  If max length
 ;         was not exceeded, then VALUE will be appended to RESULT and
 ;         OUTARR(WORKSUB) will be left unchanged.
 ;Notes  : Validity and existance of input is assumed
 ;       : Declarations done in FIXLEN
 ;       : VALUE may be modified by this call
 ;
 ;VALUE is null - done
 Q:(VALUE="")
 ;Get lengths of VAL & RES
 S LENVAL=$L(VALUE)
 S LENRES=$L(RESULT)
 ;Determine what resulting length will be
 S LEN=LENRES+LENVAL
 ;Max length will not be exceeded - append and quit
 I (LEN<MAXLEN) S RESULT=RESULT_VALUE Q
 I (LEN=MAXLEN) S RESULT=RESULT_VALUE Q
 ;Determine exceeding length
 S LENOVR=LEN-MAXLEN
 ;Put non-exceeding portion into output array
 S @OUTARR@(WORKSUB)=RESULT_$E(VALUE,1,(LENVAL-LENOVR))
 ;Increment working subscript
 S WORKSUB=WORKSUB+1
 ;Put exceeding portion into RESULT
 ; Use recursion to account for further exceeding
 S RESULT=""
 S VALUE=$E(VALUE,((LENVAL-LENOVR)+1),LENVAL)
 D FIXLEN1
 ;Done
 Q
 ;
GETATT(SEQ) ;Get element attributes
 ;
 ;Input  : SEQ - Sequence number
 ;Output : Role segment attributes (as defined by HL7 standard)
 ;           SEQ^LEN^DT^OPT^RP/#^TBL#^ITEM#^ELEMENT NAME
 ;Notes  : Null is returned on bad input
 ;
 ;Get/return attributes
 S SEQ="S"_$G(SEQ)
 Q $P($T(@SEQ),";;",2,999)
 ;
SEQREQ(SEQ) ;Required element ?
 ;
 ;Input  : SEQ - Sequence number
 ;Output : 1 = Yes     0 = No
 ;Notes  : 0 (no) is returned on bad input
 ;
 ;Declare variables
 N TMP
 ;Get attributes
 S TMP=$$GETATT($G(SEQ))
 ;Required/optional attribute lists required
 Q:($P(TMP,"^",4)="R") 1
 ;Optional
 Q 0
 ;
ERROR(SEQ,OUTARR,ERROR) ;Add error node to output array
 ;
 ;Input  : SEQ - Sequence number
 ;         OUTARR - Output array
 ;         ERROR - Error text to include
 ;Output : None
 ;         Required Element
 ;           OUTARR("ERROR",SEQ,x) = Error text
 ;         Optional Element
 ;           OUTARR("WARNING",SEQ,x) = Error text
 ;Notes  : Input error text (ERROR) will be appended to text stating
 ;         whether element is required/optional and the element name
 ;
 N ATTRIB,REQUIRED,ELEMENT,TEXT
 ;Get attributes
 S ATTRIB=$$GETATT($G(SEQ))
 ;Required/Optional
 S REQUIRED=0
 S:($P(ATTRIB,"^",4)="R") REQUIRED=1
 ;Element name
 S ELEMENT=$P(ATTRIB,"^",8)
 S:(ELEMENT="") ELEMENT="Unknown (seq #"_SEQ_")"
 ;Build blanket error text
 S TEXT=$S(REQUIRED:"Required",1:"Optional")
 S TEXT=TEXT_" data element '"_ELEMENT_"'"
 ;Append input error text (if present)
 S:($G(ERROR)'="") TEXT=TEXT_" "_ERROR
 ;Use WARNING node for optional element & ERROR node for required
 S:('REQUIRED) OUTARR=$NA(@OUTARR@("WARNING"))
 S:(REQUIRED) OUTARR=$NA(@OUTARR@("ERROR"))
 ;Get next subscript in ouput array
 S ATTRIB=1+$O(@OUTARR@(SEQ,""),-1)
 ;Place error text into output array
 S @OUTARR@(SEQ,ATTRIB)=TEXT
 ;Done
 Q
 ;
 ;
 ;Role segment attributes (as defined by HL7 standard)
ATTRIB ;;SEQ^LEN^DT^OPT^RP/#^TBL#^ITEM#^ELEMENT NAME
S1 ;;1^60^EI^R^^^01206^Role Instance ID
S2 ;;2^2^ID^R^^0287^00816^Action Code
S3 ;;3^80^CE^R^^^01197^Role
S4 ;;4^80^XCN^R^^^01198^Role Person
S5 ;;5^26^TS^O^^^01199^Role Begin Date/Time
S6 ;;6^26^TS^O^^^01200^Role End Date/Time
S7 ;;7^80^CE^O^^^01201^Role Duration
S8 ;;8^80^CE^O^^^01205^Role Action Reason
