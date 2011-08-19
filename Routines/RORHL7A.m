RORHL7A ;HCIOFO/SG - HL7 UTILITIES ; 4/4/07 1:07pm
 ;;1.5;CLINICAL CASE REGISTRIES;**2**;Feb 17, 2006;Build 6
 ;
 Q
 ;
 ;***** ADDS THE SEGMENT TO THE HL7 MESSAGE BUFFER
 ;
 ; SEG           Complete HL7 segment
 ;
 ; The ADDSEGC^RORHL7A procedure adds the HL7 segment to the HL7
 ; message buffer defined by the ROREXT("HL7BUF") parameter
 ; (the ^TMP("HLS",$J), by default). The <TAB>, <CR> and <LF>
 ; characters are replaced with spaces. Long segments are split
 ; among sub-nodes of the main segment node in the destination
 ; buffer.
 ;
 ; The RORHL array and some nodes of the ROREXT array must be
 ; initialized (either by the $$INIT^RORHL7 or manually) before
 ; calling this procedure.
 ;
ADDSEGC(SEG) ;
 N I1,I2,MAXLEN,NODE,PTR,PTR1,SID,SL
 S NODE=ROREXT("HL7BUF"),PTR=$G(ROREXT("HL7PTR"))+1
 S HLFS=RORHL("FS"),HLECH=RORHL("ECH")
 Q:$P(SEG,HLFS)=""  ; Segment Name
 ;--- Assign the Set ID if necessary
 S SID=$$SETID($P(SEG,HLFS))
 S:SID>0 $P(SEG,HLFS,2)=SID
 ;--- Remove empty trailing fields
 S I2=$L(SEG,HLFS)
 F I1=I2:-1:1  Q:$TR($P(SEG,HLFS,I1),HLECH)'=""
 S:I1<I2 $P(SEG,HLFS,I1+1,I2)=""
 ;--- Store the segment
 S SL=$L(SEG),MAXLEN=245  K @NODE@(PTR)
 S @NODE@(PTR)=$TR($E(SEG,1,MAXLEN),$C(9,10,13),"   ")
 S ROREXT("HL7SIZE")=$G(ROREXT("HL7SIZE"))+SL+1
 ;--- Split the segment into sub-nodes if necessary
 D:SL>MAXLEN
 . S I2=MAXLEN
 . F PTR1=1:1  S I1=I2+1,I2=I1+MAXLEN-1  Q:I1>SL  D
 . . S @NODE@(PTR,PTR1)=$TR($E(SEG,I1,I2),$C(9,10,13),"   ")
 ;--- Save the pointer
 S ROREXT("HL7PTR")=PTR
 Q
 ;
 ;***** ASSEMBLES THE SEGMENT AND ADDS IT TO THE HL7 MESSAGE BUFFER
 ;
 ; .FIELDS       Reference to a local variable where the HL7
 ;               fields are stored
 ;
 ;  FIELDS(
 ;    0)         Segment name
 ;    I,         Field value
 ;      i)       Continuation of the value if it is
 ;    ...        longer than than 245 characters
 ;
 ; The ADDSEGF^RORHL7A procedure assembles the HL7 segment from
 ; provided field values and adds it to the HL7 message buffer
 ; defined by the ROREXT("HL7BUF") node (the ^TMP("HLS",$J), by
 ; default). The <TAB>, <CR> and <LF> characters are replaced with
 ; spaces. Long segments are split among sub-nodes of the main
 ; segment node in the destination buffer.
 ;
 ; The RORHL array and some nodes of the ROREXT array must be
 ; initialized (either by the $$INIT^RORHL7 or manually) before
 ; calling this procedure.
 ;
ADDSEGF(FIELDS) ;
 ; RORBUF        Temporary buffer for the segment construction
 ; RORIS         Current continuation subscript in the HL7 buffer
 ; RORNODE       Closed root of the HL7 message buffer
 ; RORPTR        Current subscript in the HL7 message buffer
 ; RORSL         Number of characters that can be appended to the
 ;               RORBUF before it has to be emptied into the HL7
 ;               message buffer
 ;
 N FLD,I,LASTFLD,RORBUF,RORIS,RORNODE,RORPTR,RORSL
 Q:$G(FIELDS(0))=""  ; Segment Name
 S RORNODE=ROREXT("HL7BUF"),RORPTR=$G(ROREXT("HL7PTR"))+1
 S HLFS=RORHL("FS"),HLECH=RORHL("ECH")
 ;--- Assign the Set ID if necessary
 S I=$$SETID(FIELDS(0))
 S:I>0 FIELDS(1)=I
 ;--- Remove empty trailing fields
 S I=$NA(FIELDS(" "))
 F  S I=$$Q^RORUTL18(I,-1)  Q:I=""  Q:$TR(@I,HLECH)'=""  K @I
 ;--- Initialize construction variables
 S RORBUF=FIELDS(0),I=$L(RORBUF)
 S ROREXT("HL7SIZE")=$G(ROREXT("HL7SIZE"))+I+1
 S RORIS=0,RORSL=245-I
 ;--- Append the fields and store the segment
 S LASTFLD=+$O(FIELDS(" "),-1)
 F FLD=1:1:LASTFLD  D
 . D APPEND(HLFS_$G(FIELDS(FLD)))
 . ;--- Process the field continuation nodes
 . S I=""
 . F  S I=$O(FIELDS(FLD,I))  Q:I=""  D APPEND(FIELDS(FLD,I))
 ;--- Flush the buffer if necessary
 D:RORBUF'=""
 . I 'RORIS  S @RORNODE@(RORPTR)=RORBUF  Q
 . S @RORNODE@(RORPTR,RORIS)=RORBUF
 S ROREXT("HL7PTR")=RORPTR
 Q
 ;
 ;***** APPENDS THE FIELD VALUE TO THE HL7 SEGMENT
 ;
 ; VAL           Value of the field (or its part)
 ;
 ; This is an internal function. Do not call it directly.
 ;
APPEND(VAL) ;
 N BASE,L
 S VAL=$TR(VAL,$C(9,10,13),"   "),L=$L(VAL)
 S ROREXT("HL7SIZE")=$G(ROREXT("HL7SIZE"))+L
 I L'>RORSL  S RORBUF=RORBUF_VAL,RORSL=RORSL-L  Q
 ;---
 S RORBUF=RORBUF_$E(VAL,1,RORSL),L=L-RORSL
 S BASE=1
 F  D  Q:L'>0
 . I 'RORIS  S @RORNODE@(RORPTR)=RORBUF
 . E  S @RORNODE@(RORPTR,RORIS)=RORBUF
 . S BASE=BASE+RORSL,RORIS=RORIS+1,RORSL=245
 . S RORBUF=$E(VAL,BASE,BASE+RORSL-1),L=L-RORSL
 S RORSL=-L
 Q
 ;
 ;***** RETURNS THE BHS SEGMENT
 ;
 ; BID           Batch message ID
 ;
 ; [BDT]         Batch message creation time in internal FileMan
 ;               format (NOW by default)
 ;
 ; [COMMENT]     Optional comment
 ;
 ; The RORHL local variable must be initialized by the $$INIT^RORHL7
 ; function before calling this entry point.
 ;
BHS(BID,BDT,COMMENT) ;
 N CS,SEG,TMP
 D BHS^HLFNC3(.RORHL,BID,.SEG)
 Q:$G(SEG)="" ""
 S HLFS=RORHL("FS"),HLECH=RORHL("ECH"),CS=$E(HLECH,1)
 ;--- Post-processing
 S SEG=SEG_$G(SEG(1))
 S:$G(BDT)'>0 BDT=$$NOW^XLFDT
 S TMP=$E($P($$SITE^VASITE,U,3),1,3)
 S $P(SEG,HLFS,4)=TMP_CS_$G(^XMB("NETNAME"))_CS_"DNS"
 S $P(SEG,HLFS,5)="ROR AAC"
 S $P(SEG,HLFS,7)=$$FMTHL7^XLFDT(BDT)
 S TMP=$P(SEG,HLFS,9)
 S $P(TMP,CS,3)=$P(TMP,CS,3)_$E(HLECH,2)_$G(RORHL("ETN"))
 S $P(SEG,HLFS,9)=TMP
 S $P(SEG,HLFS,10)=$G(COMMENT)
 Q SEG
 ;
 ;***** RETURNS BTS SEGMENT
 ;
 ; MSGCNT        Batch message count
 ; [COMMENT]     Batch comment
 ;
 ; The RORHL variable must be initialized by the INIT^HLFNC2 before
 ; calling this entry point
 ;
BTS(MSGCNT,COMMENT) ;
 Q "BTS"_RORHL("FS")_MSGCNT_RORHL("FS")_$G(COMMENT)
 ;
 ;***** LOADS THE HL7 FIELD (OR ITS PART) TO THE BUFFER
 ;
 ; VAL           Value of the field (or its part)
 ;
 ; FLD           Number of the field in the segment (piece number)
 ;
FIELD(VAL,FLD) ;
 N BASE,L
 S:FLD>RORFLD RORFLD=FLD,RORIS=0,RORSL=245
 S L=$L(VAL),BASE=1
 F RORIS=RORIS:1  D  Q:L'>0
 . I 'RORIS  S RORSEG(RORFLD)=$G(RORSEG(RORFLD))_$E(VAL,BASE,BASE+RORSL-1)
 . E  S RORSEG(RORFLD,RORIS)=$G(RORSEG(RORFLD,RORIS))_$E(VAL,BASE,BASE+RORSL-1)
 . S BASE=BASE+RORSL,L=L-RORSL,RORSL=245
 S RORSL=-L
 Q
 ;
 ;***** LOADS THE HL7 SEGMENT INTO THE RPOVIDED BUFFER
 ;
 ; .RORSEG       Reference to a local variable where the HL7
 ;               fields will be stored. The fields are stored
 ;               in the following format:
 ;
 ;                 RORSEG(FldNum)=FldVal
 ;
 ;               If the value is longer that 245 characters then
 ;               the continuation nodes are created:
 ;
 ;                 RORSEG(FldNum,#)=FldValCont
 ;
 ; ROR8SRC       Closed root of the source buffer containing
 ;               the HL7 segment
 ;
LOADSEG(RORSEG,ROR8SRC) ;
 N BUF,FLD,I,IFL,NFL,RORFLD,RORIS,RORSL
 S HLFS=RORHL("FS")  K RORSEG
 ;--- Process the main segment
 S BUF=$G(@ROR8SRC),NFL=$L(BUF,HLFS)
 F IFL=1:1:NFL  S RORSEG(IFL-1)=$P(BUF,HLFS,IFL)
 Q:$D(@ROR8SRC)<10
 ;--- Process the sub-segments
 S (FLD,RORFLD)=NFL-1,RORIS=0,RORSL=245-$L(RORSEG(FLD))
 S I=""
 F  S I=$O(@ROR8SRC@(I))  Q:I=""  D
 . S BUF=@ROR8SRC@(I),NFL=$L(BUF,HLFS)
 . D FIELD($P(BUF,HLFS),FLD)
 . F IFL=2:1:NFL  S FLD=FLD+1  D FIELD($P(BUF,HLFS,IFL),FLD)
 Q
 ;
 ;***** RETURNS TEXT EXPLANATIONS OF THE HL7 MESSAGE STATUS
 ;
 ; MSGST         Status value returned by the $$MSGSTAT^HLUTIL
 ;
MSGSTXT(MSGST) ;
 N ST  S ST=+MSGST
 Q:'ST "Message does not exist"
 Q:ST=1 "Waiting in queue"
 Q:ST=1.5 "Opening connection"
 Q:ST=1.7 "Awaiting response"
 Q:ST=2 "Awaiting application ack"
 Q:ST=3 "Successfully completed"
 Q:ST=4 "Error"
 Q:ST=8 "Being generated"
 Q:ST=9 "Awaiting processing"
 Q "Unknown"
 ;
 ;***** ASSIGNS THE 'SET ID'
 ;
 ; SEGNAME       Name of the HL7 segment
 ; [DISINC]      Disable increment of the Set ID
 ;
 ; Return Values:
 ;        ""  Not required for this segment
 ;        >0  Value for the Set ID field
 ;
SETID(SEGNAME,DISINC) ;
 N SETID
 Q:$G(SEGNAME)="" ""
 S SETID=+$G(ROREXT("HL7SID",SEGNAME))
 Q:SETID'>0 ""
 S:'$G(DISINC) ROREXT("HL7SID",SEGNAME)=SETID+1
 Q SETID
