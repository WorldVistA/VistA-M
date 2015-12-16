DGENA5 ;ISA/Zoltan,ALB/CKN,TEJ - Enrollment API - CD Processing ;8/15/08 11:10am
 ;;5.3;Registration;**232,688,850,894**;Aug 13, 1993;Build 48
 ;Phase II API's Related to Catastrophic Disability.
 ;
 ; The following variable names are used consistently in this routine:
 ; DFN    = IEN in PATIENT file (#2).
 ; REASON = IEN in CATASTROPHIC DISABILITY REASONS file (#2).
 ; COND   = Sub-ien PATIENT(#2) CD STATUS CONDITIONS field (#.398).
 ; SCORE  = Score achieved by veteran on a test (#2, #.398, #1).
 ; PERM   = Permanent Indicator (#2, #.398, #2).
 ; D2     = Secondary delimiter (optional.)
 ; 
 ; Processing related to a patient (#2).
VCD(DFN) ; Veteran Catastrophically Disabled? (#.39)
 Q $P($G(^DPT(DFN,.39)),"^",6)
CONDHELP(DFN,COND) ; Display help text for a condition.
 ; Applies to the PATIENT file (#2) CD STATUS CONDITIONS field (#.398)
 ; Note - Help text stored in 27.17 CD REASONS.
 N REASON
 S REASON=$$REASON(DFN,COND)
 D HELP(REASON)
 Q
CONDINP(DFN,COND,SCORE) ; Validate a score entered by the user for a PATIENT.
 N REASON
 S REASON=$$REASON(DFN,COND)
 Q $$VALID(REASON,SCORE)
CONDMET(DFN,COND) ; Determine whether a condition meets the criteria.
 N SCORE,PERM
 S REASON=$$REASON(DFN,COND)
 S SCORE=$$PATSCORE(DFN,COND)
 S PERM=$$PATPERM(DFN,COND)
 Q $$RANGEMET(REASON,SCORE,PERM)
 ; Patient Field Lookup.
REASON(DFN,COND) ; Get the CD REASON for this patient, for this condition.
 N REASON
 I DFN=""!(COND="") D
 . S REASON=$G(DGCDREAS)
 . I REASON="",$G(ITEM)'="" S REASON=$G(DGCDIS("COND",ITEM))
 E  S REASON=$P($G(^DPT(DFN,.398,COND,0)),"^",1)
 Q REASON
PATSCORE(DFN,COND) ; Get the TEST SCORE for this patient, for this condition.
 N REASON
 I DFN=""!(COND="") Q ""
 S REASON=$P($G(^DPT(DFN,.398,COND,0)),"^",2)
 Q REASON
PATPERM(DFN,COND) ; Get the PERMANENT INDICATOR for this patient+condition.
 N REASON
 I DFN=""!(COND="") Q ""
 S REASON=$P($G(^DPT(DFN,.398,COND,0)),"^",3)
 Q REASON
 ; Processing related to catastrophic disability reasons (#27.17)
HELP(REASON) ; Display help text from 27.17 CD REASONS.
 N LINE
 Q:$$TYPE(REASON)'="C"
 S LINE=0
 W !,"HELP TEXT FOR ",$$NAME(REASON),!
 F  S LINE=$O(^DGEN(27.17,REASON,3,LINE)) Q:'LINE  D
 . W ?3,^DGEN(27.17,REASON,3,LINE,0),!
 Q
VALID(REASON,SCORE) ; Validate a proposed score for a test.
 N TEST,X
 S TEST=$$VALSCORE(REASON)
 S X=SCORE
 I @TEST Q 1
 Q 0
RANGEMET(REASON,SCORE,PERM) ; Determine whether this reason is satisfied.
 N TEST
 S TEST=$$RANGE(REASON)
 I @TEST Q 1
 Q 0
 ; APIs to access CD REASONS file.
NAME(REASON) ; Return NAME (.01) for this CD REASON.
 Q:'REASON ""
 Q $P($G(^DGEN(27.17,REASON,0)),"^",1)
TYPE(REASON) ; Return TYPE (#1) for this CD REASON.
 Q:'REASON ""
 Q $P($G(^DGEN(27.17,REASON,0)),"^",2)
VALSCORE(REASON) ; Return VALIDATION (#7) for this CD REASON.
 ; This determines whether a score is valid at all.
 Q $G(^DGEN(27.17,REASON,4))
RANGE(REASON) ; Return TEST SCORE RANGE (#5) for this CD REASON.
 ; This determines whether the score qualifies for CD.
 Q $G(^DGEN(27.17,REASON,2))
FILENAME(REASON) ; Return the file name to which this CD Reason points.
 N CODEPTR,DIC,DO
 S U=$G(U,"^")
 S CODEPTR=$$CODEPTR(REASON)
 I CODEPTR="" Q ""
 S DIC="^"_$P(CODEPTR,";",2)
 S DIC(0)=""
 D DO^DIC1
 Q $P(DO,"^",1)
CODE(REASON) ; Return the HL7 Transmission Code for this CD Reason.
 Q:'REASON ""
 Q $P($G(^DGEN(27.17,REASON,0)),"^",4)
CODENAME(REASON) ; Return name of code associated with this CD Reason.
 N CODEPTR,CODEIEN,CODEGLO,CODEPC,CODENAME,CODE
 S CODEPTR=$$CODEPTR(REASON)
 I CODEPTR="" Q ""
 S CODEIEN=$P(CODEPTR,";",1)
 S CODEGLO=$P(CODEPTR,";",2)
 S CODEPC=$S(CODEGLO="ICD9(":3,CODEGLO="ICD0(":4,CODEGLO="ICPT(":2)
 S CODEGLO="^"_CODEGLO_CODEIEN_",0)"
 S CODE=$P(@CODEGLO,"^",1)
 S CODENAME=$P(@CODEGLO,"^",CODEPC)
 Q CODENAME
CODEPTR(REASON) ; Internal label--get pointer to CODE.
 Q $P($G(^DGEN(27.17,REASON,0)),"^",3)
LSCREEN(LIMBCODE) ; Used to validate LIMB in screen.
 N REASON
 S REASON=""
 I $G(D0)=""!($G(D1)="") D
 . S REASON=$G(DGCDREAS)
 . I REASON="",$G(ITEM)'="" S REASON=$G(DGCDIS("PROC",ITEM))
 E  S REASON=$P($G(^DPT(D0,.397,D1,0)),"^",1)
 I REASON="" Q ".RUE.LUE.RLE.LLE.BLE.BLU."[("."_LIMBCODE_".")
 Q $$LIMBOK(REASON,LIMBCODE)
LIMBOK(REASON,LIMBCODE) ; Return 1/0 Affected Extremity OK for this REASON.
 N LIMBIEN,VALID
 S VALID=0
 S LIMBIEN=0
 F  S LIMBIEN=$$NEXTLIMB(REASON,LIMBIEN) Q:'LIMBIEN  D  Q:VALID
 . I $$LIMBCODE(REASON,LIMBIEN)=LIMBCODE S VALID=1
 Q VALID
NEXTLIMB(REASON,LIMBIEN) ; Get next possible limb for this REASON.
 I 'LIMBIEN S LIMBIEN=0
 S LIMBIEN=$O(^DGEN(27.17,REASON,1,LIMBIEN))
 I 'LIMBIEN S LIMBIEN=""
 Q LIMBIEN
LIMBCODE(REASON,LIMBIEN) ; Return limb code for an affected limb.
 Q $P($G(^DGEN(27.17,REASON,1,LIMBIEN,0)),"^",1)
 ; HL7-related changes.
HL7TORSN(HL7VAL,D2) ; Return REASON IEN for a HL7 Transmission Value.
 ; This function returns the IEN or 0 if there is none.
 S D2=$S(11[$D(D2):D2,11[$D(HLECH):$E(HLECH),1:"~")
 I $P("KATZ^FOLS^RUG3^FIM^GAF","^",$P(HL7VAL,D2,1))=$P(HL7VAL,D2,2) D
 . S HL7VAL=$P("KATZ^FOLS^RUG3^FIM^GAF","^",+HL7VAL)
 E  S HL7VAL=$P(HL7VAL,D2)
 Q:HL7VAL="" 0
 Q +$O(^DGEN(27.17,"C",HL7VAL,""))
 ; * check the new DESCRIPTOR seq  -  DG*5.3*894
HL7TODSC(HL7VAL,D2) ; Return DESCRIPTOR IEN for a HL7 Transmission Value.
 ; This function returns the IEN or 0 if there is none.
 Q:HL7VAL="" 0
 Q +$O(^DGEN(27.17,"C",HL7VAL,""))
RSNTOHL7(REASON,D2) ; Return HL7 Segment Value for this Reason.
 Q:REASON="" 0
 S D2=$S(11[$D(D2):D2,11[$D(HLECH):$E(HLECH),1:"~")
 N NAME,NUMBER,TABLE,FILE,CODE,HL7VAL
 I $$TYPE(REASON)="C" D
 . S CODE=$$CODE(REASON)
 . Q:CODE=""
 . S NUMBER=$L($P("KATZ^FOLS^RUG3^FIM^GAF^",CODE),"^")
 . Q:NUMBER>5
 . S TABLE="VA0043"
 . S HL7VAL=NUMBER_D2_CODE_D2_TABLE
 E  D
 . S NAME=$$NAME(REASON)
 . Q:NAME=""
 . S CODE=$$CODE(REASON)
 . Q:CODE=""
 . S FILE=$$FILENAME(REASON)
 . Q:FILE=""
 . S HL7VAL=CODE_D2_NAME_D2_FILE
 ; NOTE:  an undefined variable error on the following line may
 ;        result, if someone has tampered with the CATASTROPHIC
 ;        DISABILITY REASONS file (#27.17).  
 Q HL7VAL
 ; * check the new DESCRIPTOR seq  -  DG*5.3*894
DSCR2HL7(DGDFN,D2) ; Return HL7 Sequence Value for all Descriptors.
 S DG2=DGDFN
 S DGHLENCD="~|\&"
 K DGTMP,DSCRTOHL7
 M DGTMP=^DPT(DG2,.401)
 I $D(DGTMP) S (I1,I2)=0 F  S I1=$O(DGTMP(I1)),I2=I2+1 Q:+I1=0  S DG2717=+DGTMP(I1,0),$P(DSCRTOHL7,$E(DGHLENCD,2),I2)=$$TOHL7()
 Q $G(DSCRTOHL7,0)
TOHL7() ;
 I $P(^DGEN(27.17,DG2717,0),U,2)="DE" Q $P(^DGEN(27.17,DG2717,0),U,4)
 Q -1
 ;
HLTOLIMB(HLVAL,D2) ; Convert HL7 transmission value to Limb code.
 ; HLVAL = HL7 text of "Affected Extremity" code.
 ; D2    = Secondary delimiter (for future expansion.)
 ; NOTE:  D2 Parameter is ignored at present, but may be
 ;        required in future if the sequence structure changes.
 Q $P("RUE-RLE-LUE-LLE-BLE-BLU","-",+HLVAL)
LIMBTOHL(LIMB,D2) ; Convert Limb code to HL7 transmission value.
 ; LIMB = Affected Extremity code: RUE = Right Upper Extremity;
 ;        LLE = Left Lower Extremity; also RLE and LUE.
 ; D2   = Secondary Delimiter to use in this HL7 sequence.
 S D2=$S(11[$D(D2):D2,11[$D(HLECH):$E(HLECH),1:"~")
 N NUMBER,HLVAL
 I "-RUE-RLE-LUE-LLE-BLE-BLU-"'[("-"_LIMB_"-")!(LIMB["-") Q ""
 S NUMBER=$L($P("-RUE-RLE-LUE-LLE-BLE-BLU","-"_LIMB_"-"),"-")
 S HLVAL=NUMBER_D2_LIMB_D2_"VA0042"
 Q HLVAL
PERMTOHL(NUMBER,D2) ; Convert Permanent Status Indicator to HL7 sequence.
 ; NUMBER = 1 for Permanent, 2 for Not Permanent, 3 for Unknown.
 ; D2     = Secondary Delimiter to use in this HL7 sequence.
 S D2=$S(11[$D(D2):D2,11[$D(HLECH):$E(HLECH),1:"~")
 N PERM,HLVAL
 S PERM=$P("PERMANENT-NOT PERMANENT-UNKNOWN","-",NUMBER)
 I PERM="" Q ""
 S HLVAL=NUMBER_D2_PERM_D2_"VA0045"
 Q HLVAL
METH2HL7(METHOD,D2) ; Convert Method of Determination to HL7 Transmission Value.
 S D2=$S(11[$D(D2):D2,11[$D(HLECH):$E(HLECH),1:"~")
 N METHS
 S METHS="AUTOMATED RECORD REVIEW^MEDICAL RECORD REVIEW^PHYSICAL EXAMINATION"
 I ".1.2.3."'[("."_METHOD_".") Q ""
 Q METHOD_D2_$P(METHS,"^",METHOD)_D2_"VA0041"
 ;
ICDVER(CODESYS) ; DG*5.3*850
 ; determine if ICD-9 or ICD-10 CD should be used
 ; To be used in DIC(S) call from input transforms from 2.396;.01 
 ; and 2.397;.01
 ; Requires DA(1) be defined
 ; output - the correct value in ICDIEN 9
 ;  ^ICDS("C","10D",30)=""
 ;  ^ICDS("C","ICD",1)=""
 ;
 ;  ^ICDS("C","10P",31)=""
 ;  ^ICDS("C","ICP",2)=""
 ; -- DDATE := date of decision
 ;    DGar
 ;    DDCDIS(DATE) := date of decision from Listman Screen, not saved yet
 ;
 N DFN1,ICDIEN,DDATE,IMPDATE
 S CODESYS=$S($G(CODESYS)="D":"10D",$G(CODESYS)="P":"10P",1:"10D")
 S DFN1=$S($G(DA(1))'="":DA(1),$G(DFN)'="":DFN,1:"")
 S DDATE=$P($G(^DPT(DFN1,.39)),"^",2) ;Date of decision
 I $G(DGCDIS("DATE")) S DDATE=DGCDIS("DATE") ;called from code, date not stored yet
 I DDATE="" S DDATE=DT
 S IMPDATE=$P($$IMPDATE^DGPTIC10($G(CODESYS)),"^",1)
 I CODESYS="10D" D
 . I DDATE<IMPDATE S ICDIEN=1
 . I DDATE'<IMPDATE S ICDIEN=30
 I CODESYS="10P" D
 . I DDATE<IMPDATE S ICDIEN=2
 . I DDATE'<IMPDATE S ICDIEN=31
 Q ICDIEN
