VAFHLZEL ;ALB/ESD,KCL,SCK,JRP - Creation of ZEL segment ; 11/23/99
 ;;5.3;Registration;**122,160,195,243,342**;Aug 13, 1993
 ;
 ;
EN(DFN,VAFSTR,VAFNUM) ; This function call has been left for backwards
 ; compatability and is superceeded by EN1^VAFHLZEL.  This function
 ; call is designed to build the HL7 ZEL segment.  This segment contains
 ; VA-specific patient eligibility  data.  Because a patient can have
 ; more than eligibility, the ZEL segment for the patient's primary
 ; eligibility will be the output of the function call and all other
 ; eligibilities will be returned in the array VAFZEL.  Because this
 ; call was not designed to accomodate a segment length greater than
 ; 245, sequence numbers 1 to 24 are the only fields supported.  
 ;
 ;Input: DFN - Pointer to PATIENT file (#2)
 ;       VAFSTR - String of fields requested separated by commas
 ;       VAFNUM - Eligibility number to determine type of data
 ;                returned
 ;                   1 = primary eligibility only
 ;                   2 = all eligibilities
 ;       VAFMSTDT - Date to use when getting MST status (optional)
 ;       Assumes existance of the HL7 enconding characters
 ;       (HLFS,HLENC,HLQ)
 ;
 ;Output: The ZEL segment for the patient's primary eligibility
 ;
 ;        VAFZEL(1..N) - If all eligibilities are chosen, an array of
 ;             string(s) forming the ZEL segments for the patient's
 ;             other entitled eligibilities.
 ;
 ;Notes: All fields will be returned with the primary eligibility
 ;     : Eligibility Code, Long ID, and Short ID will be the only
 ;       fields returned for other eligibilities
 ;     : VAFZEL is initialized (KILLed) on entry
 ;
 N VAFPRIM,X,MAXSEQ
 ;Build segment using newer call
 D EN1($G(DFN),$G(VAFSTR),$G(VAFNUM),.VAFZEL)
 ;Make output backward compatible
 S MAXSEQ=25
 S VAFPRIM=$P(VAFZEL(1),HLFS,1,MAXSEQ+1)
 K VAFZEL(1)
 S X=1
 F  S X=+$O(VAFZEL(X)) Q:'X  D
 .S VAFZEL(X-1)=$P(VAFZEL(X),HLFS,1,MAXSEQ+1)
 .K VAFZEL(X)
 Q VAFPRIM
 ;
EN1(DFN,VAFSTR,VAFNUM,VAFZEL) ; This procedure call is designed to build the
 ; HL7 ZEL segment.  This segment contains VA-specific patient
 ; eligibility data.  Because a patient can have more than eligibility,
 ; the ZEL segment(s) will be returned in the array VAFZEL.  This call
 ; superceeds $$EN^VAFHLZEL because it accomodates a segment length
 ; greater than 245.
 ;
 ;Input: DFN - Pointer to PATIENT file (#2)
 ;       VAFSTR - String of fields requested separated by commas
 ;       VAFNUM - Eligibility number to determine type of data
 ;                returned
 ;                   1 = primary eligibility only (default)
 ;                   2 = all eligibilities
 ;       .VAFZEL - Array to return segment(s) in
 ;       VAFMSTDT - Date to use when getting MST status (optional)
 ;       Existance of HL7 enconding characters (HLFS,HLENC,HLQ) assumed
 ;
 ;Output: VAFZEL(X) = ZEL segment (first 245 characters)
 ;        VAFZEL(X,Y) = Remaining portion of ZEL segment in 245 chunks
 ;
 ;Notes: VAFZEL(1) will be the primary eligibility
 ;     : VAFZEL(2..n) will be other eligibilities
 ;     : All fields will be returned with the primary eligibility
 ;     : Eligibility Code, Long ID, and Short ID will be the only
 ;       fields returned for other eligibilities
 ;     : Fields will not be split across nodes in VAFZEL()
 ;     : VAFZEL is initialized (KILLed) on entry
 ;
 N VAFPELIG,VAFNODE,VAFPRIM,VAFHLZEL,VAFSETID,VAFELPTR,VAFMAXL,X
 K VAFZEL
 S VAFMAXL=245
 I '$G(DFN)!($G(VAFSTR)="") S VAFZEL(1)="ZEL"_HLFS Q
 S VAFNUM=$S('$D(VAFNUM):1,VAFNUM'<2:2,1:1)
 S VAFSTR=","_VAFSTR_","
 ;Build ZEL segment for primary eligibility
 S VAFPELIG=$G(^DPT(DFN,.36))
 S VAFNODE=$G(^DPT(DFN,"E",+VAFPELIG,0))
 S VAFSETID=1 D GETDATA^VAFHLZE1,MAKESEG
 ;Only build for primary elig.
 Q:VAFNUM=1
 ;Build ZEL segments for other eligibilities
 S VAFELPTR=0
 F  S VAFELPTR=$O(^DPT(DFN,"E",VAFELPTR)) Q:'VAFELPTR  I VAFELPTR'=+VAFPELIG D
 .S VAFNODE=$G(^DPT(DFN,"E",VAFELPTR,0))
 .S VAFSETID=VAFSETID+1 D GETDATA^VAFHLZE1,MAKESEG
 ;Done
 Q
 ;
MAKESEG ;Make segment using obtained data
 ;Input: Existance of the following variables is assumed
 ;   VAFSETID = Number denoting Xth repetition of the ZEL segment
 ;   VAFMAXL = Maximum length of each node (defaults to 245)
 ;   VAFHLZEL(SeqNum) = Value
 ;   HL7 encoding characters (HLFS, HLENC, HLQ)
 ;
 ;Output: VAFZEL(VAFSETID) = ZEL segment (first VAFMAXL characters)
 ;        VAFZEL(VAFSETID,x) = Remaining portion of ZEL segment in
 ;                             VAFMAXL character chunks (if needed)
 ;                             beginning with a field seperator
 ;
 ;Notes: VAFZEL(VAFSETID) is initialized (KILLed) on input
 ;     : Fields will not be split across nodes in VAFZEL()
 ;
 N SEQ,SPILL,SPILLON,SPOT,LASTSEQ,VAFY
 K VAFZEL(VAFSETID)
 S VAFZEL(VAFSETID)="ZEL"
 S VAFMAXL=+$G(VAFMAXL) S:'VAFMAXL VAFMAXL=245
 S VAFY=$NA(VAFZEL(VAFSETID))
 S (SPILL,SPILLON)=0
 S LASTSEQ=+$O(VAFHLZEL(""),-1)
 F SEQ=1:1:LASTSEQ D
 .;Make sure maximum length won't be exceeded
 .I ($L(@VAFY)+$L($G(VAFHLZEL(SEQ)))+1)>VAFMAXL D
 ..;Max length exceeded - start putting data on next node
 ..S SPILL=SPILL+1
 ..S SPILLON=SEQ-1
 ..S VAFY=$NA(VAFZEL(VAFSETID,SPILL))
 .;Add to string
 .S SPOT=(SEQ+1)-SPILLON
 .S $P(@VAFY,HLFS,SPOT)=$G(VAFHLZEL(SEQ))
 ;Done
 Q
