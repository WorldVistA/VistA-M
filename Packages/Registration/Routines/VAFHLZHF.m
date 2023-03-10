VAFHLZHF ;ALB/KUM - Create generic HL7 Enrollment (ZHF) segment ;Sept 04, 2022@15:28:52
 ;;5.3;Registration;**1082**;Aug 13, 1993;Build 29
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This generic extrinsic function is designed to return the
 ; HL7 Enrollment (ZHF) segment. This segment contains VA-specific
 ; health factor information for a patient.
 ;
 ;ICRs
 ; Reference to GET1^DIQ in ICR #10004
 ; Reference to $$NOW^XLFDT in ICR #10103
 ; Reference to $$HLDATE^HLFNC in ICR #10106
 ;
EN(DFN,VAFSTR,VAFHLQ,VAFHLFS) ; --
 ; Entry point for creating HL7 Health Factor (ZHF) segment.
 ;
 ;  Input(s):
 ;        DFN - internal entry number of Patient (#2) file
 ;     VAFSTR - (optional) string of fields requested, separated by
 ;              commas.  If not passed, return all data fields.
 ;     VAFHLQ - (optional) HL7 null variable.
 ;    VAFHLFS - (optional) HL7 field separator.
 ;
 ; Output(s):
 ;    String containing the desired components of the HL7 ZHF segment
 ;
 N VAFPSY,VAFPREF,VAFY,SEQ,DGDATE,DGDT
 ;
 ; if VAFHLQ or VAFHLFS not passed, use default HL7 variables
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS))
 ;
 ; if DFN not passed, exit
 I '$G(DFN) S VAFY=1 G ENQ
 ;
 ; if VAFSTR not passed, return all data fields (SEQ's)
 I $G(VAFSTR)']"" F SEQ=1:1:5 S $P(VAFSTR,",",SEQ)=SEQ
 ;
 ; get data from Presumptive Psychosis Category Changes (#33.1) file
 D GETDATA331^DGPPSYCH(DFN,.VAFPSY)
 ;
 ; initialize output string and requested data fields
 S VAFSTR=","_VAFSTR_","
 ;
 ; set-up segment data fields
 I VAFSTR[",1," S $P(VAFY,VAFHLFS,1)=$S($G(VAFPSY("PPCAT"))]"":VAFPSY("PPCAT"),1:VAFHLQ)  ; Psychosis Category
 I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=$S($G(VAFPSY("PPCATDT")):$$HLDATE^HLFNC(VAFPSY("PPCATDT"),"DT"),1:VAFHLQ)  ; Psychosis Category Change Date
 I VAFSTR[",3," S $P(VAFY,VAFHLFS,3)=VAFHLQ
 I VAFSTR[",4," S $P(VAFY,VAFHLFS,4)=VAFHLQ
 I VAFSTR[",5," S $P(VAFY,VAFHLFS,5)=VAFHLQ
 ;
ENQ Q "ZHF"_VAFHLFS_$G(VAFY)
 ;
