SCMSVUT4 ;BPFO/JRP - IEMM Utilities (cont);6/18/2002
 ;;5.3;Scheduling;**245**;Aug 13, 1993
 ;
 Q
 ;
CNVRTHLQ(STRING,HLQ)    ;Convert HL7 null designation to null
 ;Input  : STRING - String to perform conversion on
 ;         HLQ - HL7 null designation (defaults to "")
 ;Output : STRING with HLQ converted to null
 ;
 ;Declare variables
 N X,L
 S STRING=$G(STRING)
 I (STRING="") Q ""
 S:('$D(HLQ)) HLQ=$C(34,34)
 S:HLQ="" HLQ=$C(34,34)
 S L=$L(HLQ)
 ;Convert by removing all instances of HLQ
 F  S X=$F(STRING,HLQ) Q:'X  D
 .S STRING=$E(STRING,1,(X-L-1))_$E(STRING,X,$L(STRING))
 Q STRING
 ;
PARFLD(FLD,OUTARR,HL,SUBS)     ;Parse HL7 field by component
 ;Input  : FLD - Field to parse
 ;         OUTARR - Array to put parsed field into (pass by value)
 ;         HL - Array containing HL7 variables (pass by reference)
 ;                Using HL("FS"), HL("ECH"), HL("Q")
 ;              This is output by $$INIT^HLFNC2()
 ;         SUBS - Flag indicating if sub-components should also
 ;                be broken out
 ;                  0 = No (default)
 ;                  1 = Yes
 ;Output : None
 ;         OUTARR = Value  (if field not broken into components)
 ;         OUTARR(Cmp#) = Value
 ;         OUTARR(Cmp#,Sub#) = Value (if sub-component requested)
 ;Notes  : Existance and validity of input is assumed
 ;       : OUTARR initialized (KILLed) on entry
 ;       : FLD can not be a repeating field
 ;Declare variables
 N CS,COMP,SS,VALUE,SUB
 S FLD=$G(FLD)
 Q:FLD=""
 Q:'$D(HL)
 S CNVRT=+$G(CNVRT)
 K @OUTARR
 ;Get component & sub-component separators
 S CS=$E(HL("ECH"),1)
 S SS=$E(HL("ECH"),4)
 ;No components - set field at main level
 I FLD'[CS S @OUTARR=FLD Q
 ;Parse out components
 F COMP=1:1:$L(FLD,CS) D
 .S VALUE=$P(FLD,CS,COMP)
 .I 'SUBS S @OUTARR@(COMP)=VALUE Q
 .;Parse out sub-components
 .I VALUE'[SS S @OUTARR@(COMP)=VALUE Q
 .F SUB=1:1:$L(VALUE,SS) D
 ..S @OUTARR@(COMP,SUB)=$P(VALUE,SS,SUB)
 Q
 ;
PARSEG(SEGARR,OUTARR,HL,PARCOMP,CNVRT)        ;Parse HL7 segment by field
 ;Input  : SEGARR - Array containing segment (pass by value)
 ;                  SEGARR = First 245 characters of segment
 ;                  SEGARR(1..n) = Continuation nodes
 ;                    OR
 ;                  SEGARR(0) = First 245 characters of segment
 ;                  SEGARR(1..n) = Continuation nodes
 ;         OUTARR - Array to put parsed segment into (pass by value)
 ;         HL - Array containing HL7 variables (pass by reference)
 ;                Using HL("FS"), HL("ECH"), HL("Q")
 ;              This is output by $$INIT^HLFNC2()
 ;         PARCOMP - Flag indicating if fields should be parsed into
 ;                   their components
 ;                     0 = No (default)
 ;                    10 = Yes - components only
 ;                    11 = Yes - component and sub-components
 ;         CNVRT - Flag indicating if HL7 null designation should be
 ;                 converted to MUMPS null (optional)
 ;                   0 = No (default)
 ;                   1 = Yes
 ;Output : None
 ;         OUTARR will be in the following format:
 ;           OUTARR(0) = Segment name
 ;           OUTARR(Seq#,Rpt#) = Value
 ;           OUTARR(Seq#,Rpt#,Cmp#) = Value
 ;           OUTARR(Seq#,Rpt#,Cmp#,Sub#) = Value
 ;
 ;Notes  : Existance and validity of input is assumed
 ;       : OUTARR initialized (KILLed) on entry
 ;       : Assumes no field in segment greater than 245 characters
 ;       : Data stored with the least number of subscripts in OUTARR.
 ;         If field not broken into components then the component
 ;         subscript will not be used.  Same is true of the
 ;         sub-component subscript.
 ;
 ;Declare variables
 N SEQ,CURNODE,CURDATA,NXTNODE,NXTDATA,VALUE,RS,REP,STOP,SEG
 Q:'$D(SEGARR)
 Q:'$D(@SEGARR)
 Q:'$D(OUTARR)
 Q:'$D(HL)
 S PARCOMP=+$G(PARCOMP)
 S CNVRT=+$G(CNVRT)
 K @OUTARR
 ;Get repetition separator
 S RS=$E(HL("ECH"),2)
 ;Get initial and next nodes
 S CURNODE=$S($D(@SEGARR)#2:"",1:$O(@SEGARR@("")))
 S CURDATA=$S(CURNODE="":@SEGARR,1:@SEGARR@(CURNODE))
 S NXTNODE=$O(@SEGARR@(CURNODE))
 S NXTDATA=$S(NXTNODE="":"",1:$G(@SEGARR@(NXTNODE)))
 ;Get/strip segment name
 S SEG=$P(CURDATA,HL("FS"),1)
 Q:($L(SEG)'=3)
 S CURDATA=$P(CURDATA,HL("FS"),2,99999)
 S @OUTARR@(0)=SEG
 ;Parse out fields
 S STOP=0
 S SEQ=1
 F  D  Q:STOP
 .S VALUE=$P(CURDATA,HL("FS"),1)
 .;Account for continuation of data on next node
 .I CURDATA'[HL("FS") D
 ..S VALUE=VALUE_$P(NXTDATA,HL("FS"),1)
 ..S NXTDATA=$P(NXTDATA,HL("FS"),2,99999)
 .;Convert HL7 null to MUMPS null
 .I CNVRT S VALUE=$$CNVRTHLQ(VALUE,HL("Q"))
 .;Parse out repetitions
 .F REP=1:1:$L(VALUE,RS) D
 ..;Parse out components
 ..I PARCOMP D  Q
 ...D PARFLD($P(VALUE,RS,REP),$NA(@OUTARR@(SEQ,REP)),.HL,(PARCOMP#2))
 ..;Don't parse out components
 ..S @OUTARR@(SEQ,REP)=$P(VALUE,RS,REP)
 .;Increment sequence number
 .S SEQ=SEQ+1
 .;No more fields on current node - move to next node
 .I CURDATA'[HL("FS") D  Q
 ..;No more fields - stop parsing
 ..I NXTDATA="" S STOP=1 Q
 ..;Update current node and get next node
 ..S CURDATA=NXTDATA
 ..S CURNODE=NXTNODE
 ..S NXTNODE=$O(@SEGARR@(CURNODE))
 ..S NXTDATA=$S(NXTNODE="":"",1:$G(@SEGARR@(NXTNODE)))
 .;Remove current field from node
 .S CURDATA=$P(CURDATA,HL("FS"),2,99999)
 Q
 ;
PARMSG(MSGARR,OUTARR,HL,PARCOMP,CNVRT)        ;Parse HL7 message by segment
 ;  and field
 ;Input  : MSGARR - Array containing message (pass by value)
 ;                  MSGARR(x) = First 245 characters of Xth segment
 ;                  MSGARR(x,1..n) = Continuation nodes for Xth segment
 ;         OUTARR - Array to put parsed message into (pass by value)
 ;         HL - Array containing HL7 variables (pass by reference)
 ;                Using HL("FS"), HL("ECH"), HL("Q")
 ;              This is output by $$INIT^HLFNC2()
 ;         PARCOMP - Flag indicating if fields should be parsed into
 ;                   their components
 ;                     0 = No (default)
 ;                     1 = Yes
 ;         CNVRT - Flag indicating if HL7 null designation should be
 ;                 converted to MUMPS null (optional)
 ;                     0 = No (default)
 ;                    10 = Yes - components only
 ;                    11 = Yes - component and sub-components
 ;Output : None
 ;         OUTARR will be in the following format:
 ;           OUTARR(0) = Segment name
 ;           OUTARR(SegName,Rpt#)=Seg#
 ;           OUTARR(Seg#,Seq#,Rpt#) = Value
 ;           OUTARR(Seg#,Seq#,Rpt#,Cmp#) = Value
 ;           OUTARR(Seg#,Seq#,Rpt#,Cmp#,Sub#) = Value
 ;
 ;Notes  : Existance and validity of input is assumed
 ;       : OUTARR initialized (KILLed) on entry
 ;       : Assumes no field in segment greater than 245 characters
 ;       : Data stored with the least number of subscripts in OUTARR.
 ;         If field not broken into components then the component
 ;         subscript will not be used.  Same is true of the
 ;         sub-component subscript.
 ;
 ;Declare variables
 N SEG,SEGNAME,REP
 Q:'$D(MSGARR)
 Q:'$D(@MSGARR)
 Q:'$D(OUTARR)
 Q:'$D(HL)
 S PARCOMP=+$G(PARCOMP)
 S CNVRT=+$G(CNVRT)
 K @OUTARR
 ;Parse message by segment
 S SEG=""
 F  S SEG=$O(@MSGARR@(SEG)) Q:SEG=""  D
 .;Parse segment
 .D PARSEG($NA(@MSGARR@(SEG)),$NA(@OUTARR@(SEG)),.HL,PARCOMP,CNVRT)
 .;Set up segment index
 .S SEGNAME=$G(@OUTARR@(SEG,0))
 .Q:SEGNAME=""
 .S REP=$O(@OUTARR@(SEGNAME,""),-1)+1
 .S @OUTARR@(SEGNAME,REP)=SEG
 Q
