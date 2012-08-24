MDCUTL ;HINES OIFO/DP/BJ/TJ - HL7 Message Utilities;07 June 2007
 ;;1.0;CLINICAL PROCEDURES;**16,12,23**;Apr 01, 2004;Build 281
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;1.0;Create HL7 A04 Message;;Mar 10, 2005 ; Patch IB*2.0*286
 ;
 ; This routine uses the following Integration Agreements (IAs):
 ;  # 2050       - $$EZBLD^DIALOG()             FILEMAN                        (supported)
 ;
 Q
 ;
MOREDLMS ;; maintain HL7 delimiters based on prev. HL7 INIT for the protocol
 S HLMAXLEN=245
 S HLFS=$G(HL("FS")) I HLFS="" S HLFS="^"
 S HLCM=$E(HL("ECH"),1),HLRP=$E(HL("ECH"),2)
 S HLES=$E(HL("ECH"),3),HLSC=$E(HL("ECH"),4)
 S HL7RC=HLES_HLFS_HLCM_HLRP_HLSC,HLECH=HL("ECH"),HLQ=HL("Q")
 Q
 ;
EMPTY(SEG,ERR,HLQFLAG,STFIELD,ENDFIELD) ;
 ;
 ;This function will check an HL7 segment delimited by the HL7 field
 ;separator for a specified field range and determine if the segment
 ;within the specified field range contains data or is empty. If
 ;no specified starting field range, then starting field defaults to the
 ;first field in the segment. If no specified ending field range, then
 ;ending field defaults to the last field in the segment as determined
 ;by $L(SEG,HLFS).
 ;
 ;
 ;INPUT:
 ;       SEG      -- (Required) HL7 segment to be evaluated.
 ;       ERR      -- (Required) Passed by reference and is only defined
 ;                   within this function if an error occurs.
 ;       HLQFLAG  -- (Optional) Flag to indicate if HL7 Null Variable
 ;                   HLQ is considered for evaluation.
 ;                   If sent, then '1' indicates consideration and '0'
 ;                   indicates no consideration.
 ;                   If not sent, then default is not to consider HLQ
 ;                   for evaluation.
 ;       STFIELD  -- (Optional) Segment field to start evaluation from
 ;                   as determined by field separator HLFS.
 ;                   If not sent, then default equals '1'.
 ;       ENDFIELD -- (Optional) Segment field to end evaluation to as
 ;                   determined by field separator HLFS.
 ;                   If not sent, then default equals '$L(SEG,HLFS)'.
 ;
 ;OUTPUT:
 ;       1         -- Segment field range contains data or
 ;       0         -- Segment field range doesn't contain data or
 ;       ""        -- Error has occurred. In this case, error returned
 ;                    in variable ERR.
 ;      ERR        -- Error message text. Is only defined if and error
 ;                    has occurred within this function.
 ;
 Q:$G(SEG)="" 0
 N COMP
 S HLQFLAG=$S($G(HLQFLAG)'="":HLQFLAG,1:0)
 I (HLQFLAG'=1),(HLQFLAG'=0) D EMPTYERR("HLQFLAG") Q ""
 S STFIELD=$S($G(STFIELD)'="":STFIELD,1:1)
 I (STFIELD'?1N.N)!(STFIELD<1)!(STFIELD>$L(SEG,HLFS)) D EMPTYERR("STFIELD") Q ""
 S ENDFIELD=$S($G(ENDFIELD)'="":ENDFIELD,1:$L(SEG,HLFS))
 I (ENDFIELD'?1N.N)!(ENDFIELD<1)!(ENDFIELD>$L(SEG,HLFS)) D EMPTYERR("ENDFIELD") Q ""
 S COMP=$P(SEG,HLFS,STFIELD,ENDFIELD)
 Q:COMP="" 0
 I HLQFLAG,$TR(COMP,HLQ_HL7RC)="" Q 0
 I 'HLQFLAG,$TR(COMP,HL7RC)="" Q 0
 Q 1
 ;
EMPTYERR(NAME) ;Error message module
 ;
 N MDCPARM
 ;
 ;Setup error message parameter for call to Dialog File
 ;for dialog 3750007.
 ;Dialog 3750007 => Message could not be built.  Error occurred in |1|.
 ;
 S MDCPARM(1)="$$EMPTY^IBBVUTL - unacceptable "_NAME_" parameter value of "_@NAME
 ;
 ;Return error message text in variable ERR.
 ;
 S ERR=$$EZBLD^DIALOG(3750007,.MDCPARM)
 Q
ESC(FIELD) ;
 ;
 NEW DEL,HLES,IDEL,REP
 ;
 S HLES=$E(HL("ECH"),3)
 S DEL(1)=HLES,REP(1)="E" ; escape character must be first in list
 S DEL(2)=$E(HL("ECH"),2),REP(2)="R"
 S DEL(3)=$E(HL("ECH")),REP(3)="S"
 S DEL(4)=$E(HL("FS")),REP(4)="F"
 S DEL(5)=$E(HL("ECH"),4),REP(5)="T"
 ;
 F IDEL=1:1:5 D
 . Q:FIELD'[DEL(IDEL)
 . S FIELD=$$REP(FIELD,DEL(IDEL),HLES_REP(IDEL)_HLES)
 . Q
 Q FIELD
 ;
REP(STR,REM,REP) ; remove all occurrences of REM from STR and replace with REP
 ;
 Q:STR'[REM STR
 Q $P(STR,REM,1)_REP_$$REP($P(STR,REM,2,$L(STR,REM)),REM,REP)
 ;
 ;
REMQQ(STR) ; removes two double quotes surrounded by HL7 delimiters from STR
 ;
 NEW POS,DELIMS,BEFORE,AFTER
 S DELIMS=HL("ECH")_HL("FS")
 ;
 S POS=$F(STR,HLQ)
 Q:POS=0 STR
 S BEFORE=$E(STR,POS-3)
 S AFTER=$E(STR,POS)
 ;
 Q:DELIMS'[BEFORE!(DELIMS'[AFTER) $E(STR,1,POS-1)_$$REMQQ($E(STR,POS,$L(STR)))
 ;
 Q $E(STR,1,POS-3)_$$REMQQ($E(STR,POS,$L(STR)))
 ;
 ;
MAKESEG(RAWARAY,SEGARAY,SEGNUM,SEGID) ;Make segment using obtained fields
 ;
 ; - This subroutine takes a one dimensional array of fields and turns it into an
 ;    an HL7 segment (segment string).  The subscript of each element in the field array
 ;    corresponds to the number of a field in a HL7 specification, such as might be found
 ;    in the Message Work Bench (MWB) tool.  Each string within the array is assumed to
 ;    be already formatted in regard to such matters as components and sub-components.
 ;    If the length of the HL7 string exceeds 245 characters, it must be broken up into
 ;    chunks, none of which may exceed 245 characters.  The chunks are returned in an array.
 ;    Fields are not split across chunks.
 ;
 ;Input:
 ;   RAWARAY  = 1 dimensional array of fields, each subscript corresponding to an HL7
 ;               specification field number (!pass by reference!)
 ;   SEGARAY  = array of chunks where the constructed segment goes (!pass by reference!)
 ;   SEGNUM   = if greater than zero, number denoting Xth repetition of the SEGID segment.
 ;              if less than 1, the first (or only) chunk has no subscript
 ;   SEGID    = Segment ID string (defaults to "")
 ;   HLMAXLEN = Maximum length of each segment chunk (defaults to 245) (assumed variable)
 ;   HL7 encoding characters (HLFS, HLENC, HLQ)
 ;
 ;Output: SEGARAY(SEGNUM)   = SEGID segment (first SMAXL characters)
 ;        SEGARAY(SEGNUM,x) = Remaining portion(S) of SEGID segment in
 ;                             SMAXL character chunks (if needed)
 ;                             beginning with a field separator
 ;
 ;Notes: SEGARAY(SEGNUM) is initialized (KILLed) on input
 ;     : Fields will not be split across chunks in SEGARAY()
 ;
 N SEQ,SPILL,SPILLON,SPOT,LASTSEQ,SPTR,SMAXL,PTSS
 ; - first assume segment array number not present (less than 1)
 S SPTR="SEGARAY",PTSS="SEGARAY(SPILL)"
 ; - if array number present, arrange to use it as subscript
 I +$G(SEGNUM)>0 S SPTR="SEGARAY(SEGNUM)",PTSS="SEGARAY(SEGNUM,SPILL)"  ;SEGNUM=$TR(SEGNUM,"_",",")
 ; - initialize segment (output) array
 K @SPTR
 S @SPTR=$G(SEGID)
 ; - if not some value, make max the system max
 S SMAXL=+$G(HLMAXLEN) S:'SMAXL SMAXL=245
 ; - initialize some "pointers"
 S (SPILL,SPILLON)=0
 S LASTSEQ=+$O(RAWARAY(""),-1)
 ; - scan through field array, creating segment array as we go
 F SEQ=1:1:LASTSEQ D
 .; - Make sure maximum length won't be exceeded
 .I ($L(@SPTR)+$L($G(RAWARAY(SEQ)))+1)>SMAXL D
 ..; - Max length exceeded - start putting data on next node
 ..S SPILL=SPILL+1
 ..S SPILLON=SEQ-1
 ..S SPTR=PTSS
 .; - Add to string
 .S SPOT=(SEQ+1)-SPILLON
 .S $P(@SPTR,HLFS,SPOT)=$G(RAWARAY(SEQ))
 ; - Done
 Q
 ;
RETRANS ; Retransmit ADT from file 704.005
 ; Get the entry from file 704.005
 N STYPE,RETRN,DYNAMIC,EVNTDRVR,REQIEN,DYNAMIC,DIC
 S DIC=704.005,DIC(0)="AEQM" D ^DIC Q:+Y<1  S MDIENS=+Y_","
 S MDCPEVNT=$$GET1^DIQ(704.005,MDIENS,.07,"E")
 S MDCPMSG=$$GET1^DIQ(704.005,MDIENS,.06,"E")
 S STYPE=$S(MDCPEVNT="A01":"CPAN",MDCPEVNT="A02":"CPTP",MDCPEVNT="A03":"CPDE",MDCPEVNT="A08":"CPUI",MDCPEVNT="A11":"CPCAN",MDCPEVNT="A12":"CPCT",MDCPEVNT="A13":"CPCDE",1:"")
 S MDCPPAIR="SUBTYPE="_STYPE_"^IEN="_+MDIENS
 K MDCFDA
 F X="MDCPMSG","MDCPEVNT","MDCPPAIR" D
 .W !,X,"=",$G(@X,"<NIL>")
 S MDCFDA(704.005,MDIENS,.09)=$$QUE^MDCPMESQ(MDIENS,MDCPEVNT,.RETRN)
 S:MDCFDA(704.005,MDIENS,.09)=0 MDCFDA(704.005,MDIENS,.1)=$G(RETRN,"No return message.")
 D UPDATE^DIE("","MDCFDA")
 Q
 ;
