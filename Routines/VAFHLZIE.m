VAFHLZIE ;ALB/KCL - Create generic HL7 Ineligible (ZIE) segment ; 12-SEPTEMBER-1997
 ;;5.3;Registration;**122**;Aug 13, 1993
 ;
 ;
 ; This generic extrinsic function is designed to return the
 ; HL7 Ineligible (ZIE) segment. This segment contains VA-specific
 ; ineligible information from the Patient (#2) file for a patient.
 ;
EN(DFN,VAFSTR,VAFNUM,VAFHLQ,VAFHLFS) ; --
 ; Entry point for creating HL7 Ineligible (ZIE) segment. 
 ;     
 ;  Input(s):
 ;        DFN - internal entry number of Patient (#2) file
 ;     VAFSTR - (optional) string of fields requested, separated by
 ;              commas.  If not passed, return all data fields.
 ;     VAFNUM - (optional) sequential number for SET ID (default=1)
 ;     VAFHLQ - (optional) HL7 null variable.
 ;    VAFHLFS - (optional) HL7 field separator.
 ;
 ; Output(s):
 ;    String containing the desired components of the HL7 ZIE segment
 ;
 N VAFY,VAF15,VAF3,VAFINE
 ;
 ; if VAFHLQ or VAFHLFS not passed, use default HL7 variables
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS))
 ;
 ; if set id not passed, use default
 S VAFNUM=$S($G(VAFNUM):VAFNUM,1:1)
 ;
 ; if DFN not passed, exit
 I '$G(DFN) S VAFY=1 G ENQ
 ;
 ; if VAFSTR not passed, return all data fields
 I $G(VAFSTR)']"" S VAFSTR="1,2,3,4"
 ;
 ; initialize output string and requested data fields
 S $P(VAFY,VAFHLFS,5)="",VAFSTR=","_VAFSTR_","
 ;
 ; get ineligible data nodes of Patient (#2) file
 S VAF15=$G(^DPT(DFN,.15)),VAF3=$G(^(.3)),VAFINE=$G(^("INE"))
 ;
 S $P(VAFY,VAFHLFS,1)=$S($G(VAFNUM):VAFNUM,1:1)  ; Set ID
 I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=$S($P(VAF15,"^",2)]"":$$HLDATE^HLFNC($P(VAF15,"^",2)),1:VAFHLQ)  ; Ineligible Date
 I VAFSTR[",3," S $P(VAFY,VAFHLFS,3)=$S($P(VAF3,"^",7)]"":$P(VAF3,"^",7),1:VAFHLQ)  ; Ineligible Reason
 I VAFSTR[",4," S $P(VAFY,VAFHLFS,4)=$S($P(VAFINE,"^",6)]"":$P(VAFINE,"^",6),1:VAFHLQ)  ; Ineligible VARO Decision
 ;
ENQ Q "ZIE"_VAFHLFS_$G(VAFY)
