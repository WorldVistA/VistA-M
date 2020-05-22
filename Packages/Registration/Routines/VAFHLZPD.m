VAFHLZPD ;ALB/KCL/PHH,TDM - Create generic HL7 ZPD segment ; 8/15/08 11:42am
 ;;5.3;Registration;**94,122,160,220,247,545,564,568,677,653,688,1002**;Aug 13, 1993;Build 10
 ;
 ;
EN(DFN,VAFSTR) ; This generic extrinsic function was designed to return
 ;  sequences 1 throught 21 of the HL7 ZPD segment.  This segment
 ;  contains VA-specific patient information that is not contained in
 ;  the HL7 PID segment.  This call does not accomodate a segment
 ;  length greater than 245 and has been superceeded by EN1^VAFHLZPD.
 ;  This line tag has been left for backwards compatability.
 ;
 ;Input - DFN as internal entry number of the PATIENT file
 ;      - VAFSTR as the string of fields requested seperated by commas
 ;        (Defaults to all fields)
 ;
 ;     *****Also assumes all HL7 variables returned from*****
 ;          INIT^HLTRANS are defined.
 ;
 ;Output - String of data forming the ZPD segment.
 ;
 ;
 N VAFY,VAFZPD,REMARKS
 S VAFY=$$EN1($G(DFN),$G(VAFSTR))
 ;Segment less than 245 characters
 I ('$D(VAFZPD(1))) D
 . ;Remove sequences 22 and higher
 . S VAFY=$P(VAFY,HLFS,1,22)
 ;Segment greater than 245 characters
 I ($D(VAFZPD(1))) D
 . ;Strip out REMARKS (seq 2)
 . S REMARKS=$P(VAFY,HLFS,3)
 . S $P(VAFY,HLFS,3)=""
 . ;Append up to sequence 21 (PRIMARY CARE TEAM)
 . S VAFY=VAFY_$P(VAFZPD(1),HLFS,1,((21-$L(VAFY,HLFS))+2))
 . ;Place REMARKS back into segment, truncating if needed
 . S $P(VAFY,HLFS,3)=$E(REMARKS,1,(245-$L(VAFY)))
 ;Done
 Q VAFY
 ;
EN1(DFN,VAFSTR) ; This generic extrinsic function was designed to return the
 ;  HL7 ZPD segment.  This segment contains VA-specific patient
 ;  information that is not contained in the HL7 PID segment.  This
 ;  call superceeds EN^VAFHLZPD because it accomodates a segment
 ;  length greater than 245.
 ; 
 ;
 ;Input  : DFN - Pointer to PATIENT file (#2)
 ;         VAFSTR - List of data elements to retrieve seperated
 ;                  by commas (ex: 1,2,3)
 ;                - Defaults to all data elements
 ;         Existance of HL7 encoding variables is assumed
 ;         (HLFS, HLENC, HLQ)
 ;Output : ZPD segment
 ;       : If the ZPD segment becomes longer than 245 characters,
 ;         remaining fields will be placed in VAFZPD(1)
 ;Notes  : Sequence 1 (Set ID) will always have a value of '1'
 ;       : A ZPD segment with sequence one set to '1' will be returned
 ;         if DFN is not valid
 ;       : Variable VAFZPD is initialized on entry
 ;
 ;Declare variables
 N VAFHLZPD,VAFY,SEQ,SPILL,SPILLON,SPOT,LASTSEQ,MAXLEN
 K VAFZPD
 S MAXLEN=245
 ;Get data
 D GETDATA($G(DFN),$G(VAFSTR),"VAFHLZPD")
 ;Build segment
 S VAFY="VAFHLZPD"
 S SPILL=0
 S SPILLON=0
 S @VAFY="ZPD"
 S LASTSEQ=+$O(VAFHLZPD(""),-1)
 F SEQ=1:1:LASTSEQ D
 . ;Make sure maximum length won't be exceeded
 . I ($L(@VAFY)+$L($G(VAFHLZPD(SEQ)))+1)>MAXLEN D
 . . ;Max length exceeded - start putting data on next node
 . . S SPILL=SPILL+1
 . . S SPILLON=SEQ-1
 . . S VAFY=$NA(VAFZPD(SPILL))
 . ;Add to string
 . S SPOT=(SEQ+1)-SPILLON
 . S $P(@VAFY,HLFS,SPOT)=$G(VAFHLZPD(SEQ))
 ;Return segment
 Q VAFHLZPD
 ;
GETDATA(DFN,VAFSTR,ARRAY) ;Get info needed to build segment
 ;Input  : DFN - Pointer to PATIENT file (#2)
 ;         VAFSTR - List of data elements to retrieve seperated
 ;                  by commas (ex: 1,2,3)
 ;                - Defaults to all data elements
 ;         ARRAY - Array to return data in (full global reference)
 ;                 Defaults to ^TMP($J,"VAFHLZPD")
 ;         Existance of HL7 encoding variables is assumed
 ;         (HLFS, HLENC, HLQ)
 ;Output : Nothing
 ;           ARRAY(SeqNum) = Value
 ;Notes  : ARRAY is initialized (KILLed) on entry
 ;       : Sequence 1 (Set ID) will always have a value of '1'
 ;
 ;Check input
 S ARRAY=$G(ARRAY)
 S:(ARRAY="") ARRAY=$NA(^TMP($J,"VAFHLZPD"))
 K @ARRAY
 ;Sequence 1 - Set ID
 ;  value is always '1'
 S @ARRAY@(1)=1
 S DFN=+$G(DFN)
 S VAFSTR=$G(VAFSTR)
 S:(VAFSTR="") VAFSTR=$$COMMANUM(1,40)
 S VAFSTR=","_VAFSTR_","
 ;Declare variables
 N VAFNODE,VAPD,X1,X
 ;Get zero node
 S VAFNODE=$G(^DPT(DFN,0))
 ;Get other patient data from VADPT
 D OPD^VADPT
 ;Sequence 2 - Remarks (truncate to 60 characters)
 I VAFSTR[",2," S X=$P(VAFNODE,"^",10),@ARRAY@(2)=$S(X="":HLQ,1:$E(X,1,60))
 ;Sequence 3 - Place of birth (city)
 I VAFSTR[",3," S @ARRAY@(3)=$S(VAPD(1)]"":VAPD(1),1:HLQ)
 ;Sequence 4 - Place of birth (State abbrv.)
 I VAFSTR[",4," S X1=$P($G(^DIC(5,$P(+VAPD(2),"^",1),0)),"^",2),@ARRAY@(4)=$S(X1]"":X1,1:HLQ)
 ;Sequence 5 - Current means test status
 I VAFSTR[",5," S X=$P(VAFNODE,"^",14),X1=$P($G(^DG(408.32,+X,0)),"^",2),@ARRAY@(5)=$S(X1]"":X1,1:HLQ)
 ;Sequence 6 - Fathers name
 I VAFSTR[",6," S @ARRAY@(6)=$S(VAPD(3)]"":VAPD(3),1:HLQ)
 ;Sequence 7 - Mothers name
 I VAFSTR[",7," S @ARRAY@(7)=$S(VAPD(4)]"":VAPD(4),1:HLQ)
 ;Sequence 8 - Rated incompetent
 I VAFSTR[",8," S X1=$$YN^VAFHLFNC($P($G(^DPT(DFN,.29)),"^",12)),@ARRAY@(8)=$S(X1]"":X1,1:HLQ)
 ;Sequence 9 - Date of Death
 I VAFSTR[",9," S X=$P($G(^DPT(DFN,.35)),"^",1),X1=$$HLDATE^HLFNC(X),@ARRAY@(9)=$S(X1]"":X1,1:HLQ)
 ;Sequence 10 - Collateral sponser name
 I VAFSTR[10 D
 . S X=$P($G(^DPT(DFN,.36)),"^",11)
 . S X1=$P($G(^DPT(+X,0)),"^",1)
 . S @ARRAY@(10)=$S(X1]"":X1,1:HLQ)
 ;Sequence 11 - Active Health Insurance?
 I VAFSTR[11 S X=$$INS^VAFHLFNC(DFN),X1=$$YN^VAFHLFNC(X),@ARRAY@(11)=$S(X1]"":X1,1:HLQ)
 ;Sequences 12 & 13
 I VAFSTR[12!(VAFSTR[13) D
 . S X=$G(^DPT(DFN,.38))
 . ;Sequence 12 - Eligible for Medicaid
 . I VAFSTR[12 S X1=$$YN^VAFHLFNC($P(X,"^",1)),@ARRAY@(12)=$S(X1]"":X1,1:HLQ)
 . ;Sequence 13 - Date Medicaid last asked
 . I VAFSTR[13 S X1=$$HLDATE^HLFNC($P(X,"^",2)),@ARRAY@(13)=$S(X1]"":X1,1:HLQ)
 ;Sequence 14 - Race
 I VAFSTR[14 S X=$P(VAFNODE,"^",6) S X1=$P($G(^DIC(10,+X,0)),"^",2),@ARRAY@(14)=$S(X1]"":X1,1:HLQ)
 ;Sequence 15 - Religious Preference
 I VAFSTR[15 S X=$P(VAFNODE,"^",8) S X1=$P($G(^DIC(13,+X,0)),"^",4),@ARRAY@(15)=$S(X1]"":X1,1:HLQ)
 ;Sequence 16 - Homeless Indicator
 ;I VAFSTR[16 S X=$T(HOMELESS^SOWKHIRM) S @ARRAY@(16)=$S(X]"":$$HOMELESS^SOWKHIRM(DFN),1:HLQ)   ;Social Work being decommissioned, API call will no longer be active
 I VAFSTR[16 S @ARRAY@(16)=$S($$BADADR^DGUTL3(DFN)=2:1,1:0)    ;DG 1002 uses different API call for Homeless Indicator
 ;Sequences 17 & 20
 I ((VAFSTR[17)!(VAFSTR[20)) D
 . ;POW Status & Location
 . N VAF52,POW,LOC
 . S VAF52=$G(^DPT(DFN,.52))
 . ;POW Status Indicated?
 . S POW=$P(VAF52,"^",5)
 . S:(POW="") POW=HLQ
 . ;POW Confinement Location (translates pointer to coded value)
 . S LOC=$P(VAF52,"^",6)
 . S:(LOC="") LOC=HLQ
 . I (LOC'=HLQ) S LOC=$S(LOC>0&(LOC<7):LOC+3,LOC>6&(LOC<9):$C(LOC+58),1:"")
 . ;Add to output array
 . ;Sequence 17 - POW Status
 . S:(VAFSTR[17) @ARRAY@(17)=POW
 . ;Sequence 20 - POW Confinement Location
 . S:(VAFSTR[20) @ARRAY@(20)=LOC
 ;Sequence 18 - Insurance Type
 I VAFSTR[18 S X=+$$INSTYP^IBCNS1(DFN),@ARRAY@(18)=$S(X]"":X,1:HLQ)
 ;Sequence 19 - RX Copay Exemption Status
 I VAFSTR[19 S X=+$$RXST^IBARXEU(DFN),@ARRAY@(19)=$S(X'<0:X,1:HLQ)
 ;Sequence 21 - Primary Care Team
 I (VAFSTR[21) D
 . ;Get Primary Care Team  (as defined in PCMM)
 . S X=$$PCTEAM^DGSDUTL(DFN)
 . S X=$P(X,"^",2)
 . S:(X="") X=HLQ
 . ;Put into output array
 . S @ARRAY@(21)=X
 ; 
 ; Sequences 22 thru 30 added by DG*5.3*264 (Smart Card)
 ;
 ; Sequences 22 & 23
 I VAFSTR[22!(VAFSTR[23) D
 . ; GI Insurance
 . S X=$G(^DPT(DFN,.362))
 . I VAFSTR[22 S X1=$P(X,U,17),@ARRAY@(22)=$S(X1="U":"N",X1]"":X1,1:HLQ)
 . I VAFSTR[23 S X1=$P(X,U,6),@ARRAY@(23)=$S(X1:$E(X1,1,6),1:HLQ)
 ; Sequences 24 through 27
 I VAFSTR[24!(VAFSTR[25)!(VAFSTR[26)!(VAFSTR[27) D
 . ; Most recent care dates & locations
 . S X=$G(^DPT(DFN,1010.15))
 . I VAFSTR[24 S X1=$$HLDATE^HLFNC($P(X,U)),@ARRAY@(24)=$S(X1]"":X1,1:HLQ)
 . I VAFSTR[25 S X1=$P(X,U,2),X1=$P($G(^DIC(4,+X1,0)),U),@ARRAY@(25)=$S(X1]"":X1,1:HLQ)
 . I VAFSTR[26 S X1=$$HLDATE^HLFNC($P(X,U,3)),@ARRAY@(26)=$S(X1]"":X1,1:HLQ)
 . I VAFSTR[27 S X1=$P(X,U,4),X1=$P($G(^DIC(4,+X1,0)),U),@ARRAY@(27)=$S(X1]"":X1,1:HLQ)
 ; Sequences 28 & 29
 I VAFSTR[28!(VAFSTR[29) D
 . ; dates ruled incompetent (civil and VA)
 . S X=$G(^DPT(DFN,.29))
 . I VAFSTR[28 S X1=$$HLDATE^HLFNC($P(X,U,2)),@ARRAY@(28)=$S(X1]"":X1,1:HLQ)
 . I VAFSTR[29 S X1=$$HLDATE^HLFNC($P(X,U)),@ARRAY@(29)=$S(X1]"":X1,1:HLQ)
 ; Sequence 30 - Spinal cord injury
 I VAFSTR[30 S X=$P($G(^DPT(DFN,57)),U,4),@ARRAY@(30)=$S(X]"":X,1:HLQ)
 ; Sequence 31 - Source of Notification
 I VAFSTR[9&(VAFSTR[31) S X=$P($G(^DPT(DFN,.35)),U,3),@ARRAY@(31)=$S(X]"":X,1:HLQ)
 ; Sequence 32 - Date/Time Last Updated
 I VAFSTR[9&(VAFSTR[32) S X=$P($G(^DPT(DFN,.35)),U,4),X1=$$HLDATE^HLFNC(X),@ARRAY@(32)=$S(X1]"":X1,1:HLQ)
 ; Sequence 33 - Filipino Veteran Proof
 I VAFSTR[33 S X=$P($G(^DPT(DFN,.321)),U,14),@ARRAY@(33)=$S(X]"":X,1:HLQ)
 ; Sequence 34 - Pseudo SSN Reason - Veteran
 I VAFSTR[34 S X=$P($G(^DPT(DFN,"SSN")),U),@ARRAY@(34)=$S(X]"":X,1:HLQ)
 ; Sequence 35 - Agency/Allied Country
 I VAFSTR[35 S X=$P($G(^DPT(DFN,.3)),U,9),X1=$P($G(^DIC(35,+X,0)),U,2),@ARRAY@(35)=$S(X1]"":X1,1:HLQ)
 ; Sequence 40 - Emergency Response Indicator
 I VAFSTR[40 S X=$P($G(^DPT(DFN,.18)),U),@ARRAY@(40)=$S(X]"":X,1:HLQ)
 ;Done - cleanup & quit
 D KVA^VADPT
 Q
 ;
COMMANUM(FROM,TO) ;Build comma seperated list of numbers
 ;Input  : FROM - Starting number (default = 1)
 ;         TO - Ending number (default = FROM)
 ;Output : Comma seperated list of numbers between FROM and TO
 ;         (Ex: 1,2,3)
 ;Notes  : Call assumes FROM <= TO
 ;
 S FROM=$G(FROM) S:(FROM="") FROM=1
 S TO=$G(TO) S:(TO="") TO=FROM
 N OUTPUT,X
 S OUTPUT=FROM
 F X=(FROM+1):1:TO S OUTPUT=(OUTPUT_","_X)
 Q OUTPUT
