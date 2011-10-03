VAFHLEVN ;ALB/CM/ESD HL7 EVN SEGMENT BUILDING ;05/01/95
 ;;5.3;Registration;**94,220,190**;Aug 13, 1993
 ;
 ;This routine will build an HL7 EVN segment
 ;
EVN(TYPE,FLAG,VAEVDT) ;
 ;
 ;Input:
 ;TYPE - the HL7 Event Type
 ;FLAG - HL7 Event Reason Code
 ;       The codes will be 04 for update to "old" event
 ;       or 05 for "new"/"current" event
 ;VAEVDT - Event Date/Time [Optional] 
 ;
 N ET,EVN
 D NOW^%DTC S ET=$$HLDATE^HLFNC(%,"TS") K %,X,%H,%I
 S EVN="EVN"_HLFS_TYPE_HLFS_ET_HLFS_HLFS_FLAG
 S VAEVDT=$G(VAEVDT) I +VAEVDT'>0 S VAEVDT=$G(VAFHDT)
 I +VAEVDT>0 S EVN=EVN_HLFS_HLFS_$$HLDATE^HLFNC(VAEVDT,"TS")
 Q EVN
 ;
 ;
EN(VAFEVTYP,VAFEVDT,VAFSTR,VAFHLQ,VAFHLFS) ;
 ; Entry point for Ambulatory Care Database Project
 ;
 ; Entry point to return the HL7 EVN (Event Type) segment
 ;
 ;  Input:  VAFEVTYP - Event Type Code
 ;          VAFEVDT  - Event Date/Time
 ;            Date/Time Event Occurred (same as Encounter Date/Time)
 ;
 ;          VAFSTR   - String of fields requested separated by commas.
 ;
 ;          VAFHLQ   - Optional HL7 null variable. If not there, use 
 ;                     default HL7 variable.
 ;
 ;          VAFHLFS  - Optional HL7 field separator. If not there, use 
 ;                     default HL7 variable.
 ;
 ; Output:  String containing desired components of the EVN segment.
 ;
 ;
 N VAFY,X
 ;I ($G(VAFEVTYP)="")!($G(VAFSTR)="") G ENQ
 S:$G(VAFSTR)="" VAFSTR="1,2"
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS)) ; If VAFHLQ or VAFHLFS aren't passed in, use default HL7 variables
 S $P(VAFY,VAFHLFS,2)="",VAFSTR=","_VAFSTR_","
 I VAFSTR[",1," S $P(VAFY,VAFHLFS,1)=$G(VAFEVTYP) ; Event Type Code
 I VAFSTR[",2," S X=$$HLDATE^HLFNC($G(VAFEVDT)),$P(VAFY,VAFHLFS,2)=$S(X]"":X,1:VAFHLQ) ; Event Date/Time
 ;
ENQ ; Return segment
 Q "EVN"_VAFHLFS_$G(VAFY)
