VAFHLOBX ;ALB/SCK-Create generic OBX segment ; 22 Jan 2002 10:27 AM
 ;;5.3;Registration;**189,149,494**;Aug 13, 1993
 ;
 ; This routine returns the HL7 defined OBX segment
 ;
EN(VAFARRY,VAFNUM,VAFSTR) ; Returns OBX segment
 ;
 ; Input  -  VAFARRY Array of data fields from calling application for building into OBX segment fields
 ;           Data to be included is expected to be in the following format:
 ;              VAFARRY(Field Number) = Field Value
 ;
 ;              - Dates to be in internal FM format
 ;              - Provider name to be in external format 
 ;           VAFNUM (optional) as sequential number for SET ID (default=1)
 ;           VAFSTR (Optional) as string of fields requested separated by commas. Build all if not passed in.
 ;
 ;   **** Assumes all HL7 variables are defined ****
 ;
 ; Output - String of data forming the OBX segment
 ;
 N VAFY,X1
 ;
 ;; Check initial values, set defaults as needed
 ;; Quit on empty array
 I ($O(VAFARRY(""))="") S VAFY=1 G QUIT
 S VAFNUM=$S($G(VAFNUM):VAFNUM,1:1)
 I $G(VAFSTR)']"" S VAFSTR="2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17"
 ;
 ;; Initialize the output string
 S $P(VAFY,HLFS,17)="",VAFSTR=","_VAFSTR_","
 S $P(VAFY,HLFS,1)=VAFNUM ; Required field
 ;
 ;;Check required OBX fields
 I $G(VAFARRY(11))=""!($L($G(VAFARRY(11)))>1) S VAFY=1 G QUIT ; obs result status
 I $G(VAFARRY(3))="" S VAFY=1 G QUIT ; obs ID
 I $G(VAFARRY(11))'="X",$G(VAFARRY(2))']"" S VAFY=1 G QUIT ; Value Type
 ;
 ;;Build segment fields
 I VAFSTR[",2," S $P(VAFY,HLFS,2)=$S($G(VAFARRY(2))]"":VAFARRY(2),1:HLQ) ; Value Type
 I VAFSTR[",3," S $P(VAFY,HLFS,3)=$G(VAFARRY(3)) ; Observation Identifier
 I VAFSTR[",4," S $P(VAFY,HLFS,4)=$S($G(VAFARRY(4))]"":VAFARRY(4),1:HLQ) ; Observation Sub ID
 I VAFSTR[",5," S $P(VAFY,HLFS,5)=$S($G(VAFARRY(5))]"":VAFARRY(5),1:HLQ) ; Observation Value
 I VAFSTR[",6," S $P(VAFY,HLFS,6)=$S($G(VAFARRY(6))]"":VAFARRY(6),1:HLQ) ; Units
 I VAFSTR[",7," S $P(VAFY,HLFS,7)=$S($G(VAFARRY(7))]"":VAFARRY(7),1:HLQ) ; Reference Range
 I VAFSTR[",8," S $P(VAFY,HLFS,8)=$S($G(VAFARRY(8))]"":VAFARRY(8),1:HLQ) ; Abnormal flags
 I VAFSTR[",9," S $P(VAFY,HLFS,9)=$S($G(VAFARRY(9))]"":VAFARRY(9),1:HLQ) ; Probability
 I VAFSTR[",10," S $P(VAFY,HLFS,10)=$S($G(VAFARRY(10))]"":VAFARRY(10),1:HLQ) ; Nature of Abnormal Test
 I VAFSTR[",11," S $P(VAFY,HLFS,11)=$G(VAFARRY(11)) ; Observation Result Status
 I VAFSTR[",12," S X1=$$HLDATE^HLFNC($G(VAFARRY(12))),$P(VAFY,HLFS,12)=$S(X1]"":X1,1:HLQ) ; Date of last OBS Normal Values
 I VAFSTR[",13," S $P(VAFY,HLFS,13)=$S($G(VAFARRY(13))]"":VAFARRY(13),1:HLQ) ; User Defined Access Checks
 I VAFSTR[",14," S X1=$$HLDATE^HLFNC($G(VAFARRY(14))),$P(VAFY,HLFS,14)=$S(X1]"":X1,1:HLQ) ; DT of Observation
 I VAFSTR[",15," S $P(VAFY,HLFS,15)=$S($G(VAFARRY(15))]"":VAFARRY(15),1:HLQ) ; Producer's ID
 I VAFSTR[",16," D  S $P(VAFY,HLFS,16)=$S(X1]"":X1,1:HLQ)
 . S DIC="^VA(200,",DIC(0)="MZO",X="`"_$G(VAFARRY(16)) D ^DIC
 . I VAFARRY(16)]"",Y>0 D
 .. N DGNAME S DGNAME("FILE")=200,DGNAME("IENS")=VAFARRY(16),DGNAME("FIELD")=.01
 .. S X1=$$HLNAME^XLFNAME(.DGNAME,"S",$E($G(HLECH))),X1=$G(VAFARRY(16))_$E(HLECH,1)_X1
 . E  D
 .. S X1=""
 ;
 I VAFSTR[",17," S $P(VAFY,HLFS,17)=$S($G(VAFARRY(17))]"":VAFARRY(17),1:HLQ) ; OBS. Method
 ;
 ;
QUIT Q "OBX"_HLFS_$G(VAFY)
