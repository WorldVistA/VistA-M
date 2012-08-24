VAFHLZE2 ;ALB/TDM - Create HL7 ZE2 segment ; 5/17/12 11:22am
 ;;5.3;Registration;**842**;Aug 13, 1993;Build 33
 ;
 ;
 ; This generic extrinsic function is designed to return the
 ; HL7 ZE2 segment. This segment is a continuation of the ZEL
 ; segment.
 ;
EN(DFN,VAFSTR,VAFHLQ,VAFHLFS) ; --
 ; Entry point for creating HL7 ZE2 segment.
 ;
 ;Variables Required to use this routine:
 ;    HL - array that contains the necessary HL variables (init^hlsub)
 ;
 ;  Input(s):
 ;        DFN - internal entry number of Patient (#2) file
 ;     VAFSTR - (optional) string of fields requested, separated by
 ;              commas.  If not passed, return all data fields.
 ;     VAFHLQ - (optional) HL7 null variable.
 ;    VAFHLFS - (optional) HL7 field separator.
 ;
 ; Output(s):
 ;    String containing the desired components of the HL7 ZE2 segment
 ;
 N VAFY,VAF385,VAL,VAFHLSC
 ;
 ; if VAFHLQ or VAFHLFS not passed, use default HL7 variables
 S VAFHLFS=$G(VAFHLS) I VAFHLFS="" S VAFHLFS="^"
 S:($L(VAFHLFS)'=1) VAFHLFS="^"
 S VAFHLC=$G(VAFHLC) I VAFHLC="" S VAFHLC="~|\&"
 S:($L(VAFHLC)'=4) VAFHLC="~|\&"
 S:('$D(VAFHLQ)) VAFHLQ=$C(34,34)
 S VAFHLSC=$E(VAFHLC,1)
 ;
 ; if DFN not passed, exit
 I '$G(DFN) S VAFY=1 G ENQ
 ;
 ; if VAFSTR not passed, return all data fields
 I $G(VAFSTR)']"" S VAFSTR="1,2"
 ;
 ; initialize output string and requested data fields
 S $P(VAFY,VAFHLFS,2)="",VAFSTR=","_VAFSTR_","
 ;
 ; get pension data node of Patient (#2) file
 S VAF385=$G(^DPT(DFN,.385))
 ;
 I VAFSTR[",1," S $P(VAFY,VAFHLFS,1)=$S($P(VAF385,"^",1)]"":$$HLDATE^HLFNC($P(VAF385,"^",1)),1:VAFHLQ)  ; Pension Award Effective Date (#.3851)
 I VAFSTR[",2," D  ; Pension Award Reason Code (#.3852)
 .I $P(VAF385,"^",2)']"" S $P(VAFY,VAFHLFS,2)=VAFHLQ Q
 .S VAL=$P(VAF385,"^",2)_","
 .S $P(VAFY,VAFHLFS,2)=$$GET1^DIQ(27.18,VAL,1)
 .S $P(VAFY,VAFHLFS,2)=$P(VAFY,VAFHLFS,2)_VAFHLSC_VAFHLSC_"VistA27.18"
 ;
ENQ Q "ZE2"_VAFHLFS_$G(VAFY)
