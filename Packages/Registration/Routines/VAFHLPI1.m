VAFHLPI1 ;BPFO/JRP - EXTENSION OF PID SEGMENT BUILDER VAFHLPID;5-DEC-2001 ; 21 Nov 2002  3:13 PM
 ;;5.3;Registration;**415**;Aug 13, 1993
 ;
 Q
 ;
SEQ3(DFN,TYPE,HLENC,HLQ)     ;Build specified Patient ID (seq 3)
 ;Input  : DFN - Pointer to Patient file (#2)
 ;         TYPE - Which Patient ID to build
 ;                  NI = ICN (default)
 ;                  SS = SSN [with dashes]
 ;                  PI = DFN
 ;         HLENC - HL7 encoding characters (defaults to ~|\&)
 ;         HLQ - HL7 null designation (defaults to "")
 ;Output : Value for Patient ID (seq 3)
 ;Notes  : HLQ will be returned on bad input
 ;
 ;Check input
 S HLENC=$G(HLENC)
 S:$L(HLENC)'=4 HLENC="~|\&"
 S:'$D(HLQ) HLQ=""""""
 S DFN=+$G(DFN)
 I '$D(^DPT(DFN,0)) Q HLQ
 S TYPE=$G(TYPE,"NI")
 S:(",NI,SS,PI,"'[(","_TYPE_",")) TYPE="NI"
 ;Declare variables
 N COMP,REP,SUB,VALUE,ID,TMP
 ;Break out encoding characters
 S COMP=$E(HLENC,1)
 S REP=$E(HLENC,2)
 S SUB=$E(HLENC,4)
 ;ID (comp 1)
 S ID=""
 ;ICN
 I TYPE="NI" D
 .;Don't transmit local ICNs
 .I $$IFLOCAL^MPIF001(DFN) S ID="" Q
 .S ID=$$GETICN^MPIF001(DFN)
 .I (+ID)=-1 S ID=""
 ;SSN
 I TYPE="SS" D
 .S ID=$P($G(^DPT(DFN,0)),"^",9)
 .I ID'="" S ID=$E(ID,1,3)_"-"_$E(ID,4,5)_"-"_$E(ID,6,10)
 ;DFN
 I TYPE="PI" D
 .S ID=DFN
 S VALUE=$S(ID="":HLQ,1:ID)
 ;Check Digit (comp 2) - not used for SSN
 I TYPE'="SS" D
 .;ICN - pull off check digit
 .I TYPE="NI" S $P(VALUE,COMP,2)=$P(ID,"V",2) Q
 .;DFN - calculate check digit
 .;  Note: output of call includes Check Digit Scheme (comp 3)
 .S TMP=$$M10^HLFNC(DFN,COMP)
 .S $P(VALUE,COMP,2,3)=$P(TMP,COMP,2,3)
 ;Assigning Authority (comp 4)
 S TMP=""
 S $P(TMP,SUB,1)=$S(TYPE="SS":"USSSA",1:"USVHA")
 S $P(TMP,SUB,3)="L"
 S $P(VALUE,COMP,4)=TMP
 ;Identifier Type Code (comp 5)
 S $P(VALUE,COMP,5)=TYPE
 ;Assigning Facility (comp 6) - only used for DFN
 I TYPE="PI" S $P(VALUE,COMP,6)=+$P($$SITE^VASITE(),"^",3)
 ;Effective Date (comp 7) - only used for DFN
 I TYPE="PI" D
 .;DFN
 .S TMP=$P($G(^DPT(DFN,0)),"^",16)
 .S $P(VALUE,COMP,7)=$$HLDATE^HLFNC(TMP,"DT")
 ;Return value
 Q VALUE
 ;
SEQ10(HOW,HLQ)    ;Race
 ;Input  : HOW - Qualifiers denoting how & which race to return
 ;                N = Return new race value (2.02 multiple)
 ;                T = Include text (components 2 & 5)
 ;                B = Include second triplet (components 4 - 6)
 ;               "" = Return historical value (.06 field)
 ;         HLQ - HL7 null designation
 ;Assumed: VADM() - Output of call to DEM^VADPT
 ;Output : None - sets nodes in array VAFY
 ;         VAFY(10,1..X) = Repetion X (if no components)
 ;         VAFY(10,1..X,1..Y) = Component Y of repetiton X
 ;Notes  : Validity and existance of input is assumed
 ;       : Use of T & B qualifiers assume use of N qualifier
 ;       : Assumes no individual component is greater than 245
 ;         characters long
 ;
 ;Declare variables
 N RACENUM,CNT,RACE,X
 K VAFY(10)
 I (HOW="")!((HOW'["N")&(HOW'["B")&(HOW'["T")) D  Q
 .;Send historical value (if blank, send 7 (UNKNOWN))
 .S X=$$PTR2CODE^DGUTL4(+VADM(8),1,1)
 .S VAFY(10,1)=$S(X]"":X,1:7)
 ;No values on file
 I VADM(12)=0 D  Q
 .;First triplet
 .S VAFY(10,1,1)=HLQ
 .S VAFY(10,1,2)=$S(HOW["T":HLQ,1:"")
 .S VAFY(10,1,3)="0005"
 .;Second triplet
 .Q:HOW'["B"
 .S VAFY(10,1,4)=HLQ
 .S VAFY(10,1,5)=$S(HOW["T":HLQ,1:"")
 .S VAFY(10,1,6)="CDC"
 ;Loop through all races (CNT is repetition location)
 S RACENUM=0
 F CNT=1:1 S RACENUM=+$O(VADM(12,RACENUM)) Q:'RACENUM  D
 .;Fabricate race value -> RACE-METHOD
 .S RACE=$$PTR2CODE^DGUTL4(+VADM(12,RACENUM),1,2)
 .S X=$$PTR2CODE^DGUTL4(+$G(VADM(12,RACENUM,1)),3,2)
 .S:X="" X="UNK"
 .S RACE=RACE_"-"_X
 .;First triplet
 .S VAFY(10,CNT,1)=RACE
 .S VAFY(10,CNT,2)=$S(HOW["T":$P(VADM(12,RACENUM),"^",2),1:"")
 .S VAFY(10,CNT,3)="0005"
 .;Second triplet
 .Q:HOW'["B"
 .S X=$$PTR2CODE^DGUTL4(+VADM(12,RACENUM),1,3)
 .S VAFY(10,CNT,4)=$S(X="":HLQ,1:X)
 .S VAFY(10,CNT,5)=$S(HOW["T":$P(VADM(12,RACENUM),"^",2),1:"")
 .S VAFY(10,CNT,6)="CDC"
 Q
 ;
SEQ22(HOW,HLQ)    ;Ethnicity
 ;Input  : HOW - Qualifiers denoting how to return ethnicity
 ;                T = Include text (components 2 & 5)
 ;                B = Include second triplet (components 4 - 6)
 ;               "" = Only return components 1 & 3
 ;         HLQ - HL7 null designation
 ;Assumed: VADM() - Output of call to DEM^VADPT
 ;Output : None - sets nodes in array VAFY
 ;         VAFY(22,1,1..Y) = Component Y
 ;Notes  : Validity and existance of input is assumed
 ;       : Assumes no individual component is greater than 245
 ;         characters long
 ;
 ;Declare variables
 N ETHNIC,X,ETHNUM,CNT
 K VAFY(22)
 ;No value on file
 I +VADM(11)=0 D  Q
 .;First triplet
 .S VAFY(22,1,1)=HLQ
 .S VAFY(22,1,2)=$S(HOW["T":HLQ,1:"")
 .S VAFY(22,1,3)="0189"
 .;Second triplet
 .Q:HOW'["B"
 .S VAFY(22,1,4)=HLQ
 .S VAFY(22,1,5)=$S(HOW["T":HLQ,1:"")
 .S VAFY(22,1,6)="CDC"
 ;Loop through all ethnicities (CNT is repetition location)
 S ETHNUM=0
 F CNT=1:1 S ETHNUM=+$O(VADM(11,ETHNUM)) Q:'ETHNUM  D
 .;Fabricate ethnicity value -> ETHNICITY-METHOD
 .S ETHNIC=$$PTR2CODE^DGUTL4(+VADM(11,ETHNUM),2,2)
 .S X=$$PTR2CODE^DGUTL4(+$G(VADM(11,ETHNUM,1)),3,2)
 .S:X="" X="UNK"
 .S ETHNIC=ETHNIC_"-"_X
 .;First triplet
 .S VAFY(22,CNT,1)=ETHNIC
 .S VAFY(22,CNT,2)=$S(HOW["T":$P(VADM(11,ETHNUM),"^",2),1:"")
 .S VAFY(22,CNT,3)="0189"
 .;Second triplet
 .Q:HOW'["B"
 .S X=$$PTR2CODE^DGUTL4(+VADM(11,ETHNUM),2,3)
 .S VAFY(22,CNT,4)=$S(X="":HLQ,1:X)
 .S VAFY(22,CNT,5)=$S(HOW["T":$P(VADM(11,ETHNUM),"^",2),1:"")
 .S VAFY(22,CNT,6)="CDC"
 Q
