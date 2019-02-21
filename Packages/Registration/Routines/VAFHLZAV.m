VAFHLZAV ;ALB/KUM - Create HL7 ZAV segment ;11/26/17 3:34PM
 ;;5.3;Registration;**941**;Aug 13, 1993;Build 73
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This generic extrinsic function is designed to return the
 ; HL7 ZAV segment(s).
 ;
EN(DFN,VAFSTR,VAFHLQ,VAFHLFS,IVMZAV,IVMZAVA) ; --
 ; Entry point for creating HL7 ZAV segment.
 ;
 ;Variables Required to use this routine:
 ; HL - array that contains the necessary HL variables (init^hlsub)
 ;
 ; Input(s):
 ; DFN - internal entry number of Patient (#2) file
 ; VAFSTR - (optional) string of fields requested, separated by
 ; commas. If not passed, return all data fields.
 ; VAFHLQ - (optional) HL7 null variable.
 ; VAFHLFS - (optional) HL7 field separator.
 ;
 ; Output(s):
 ; IVMZAV() - array containing the HL7 ZAV segment(s)
 ;
 N VAFY,VAFHLSC,SUB,SUB1,SID,VAFHLC
 ;
 I VAFHLFS="" S VAFHLFS="^"
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
 ; Address Types - Permanent (P), Residential (R), Temporary (C), Confidential (CNF)
 I $G(VAFSTR)']"" S VAFSTR="1,2,3"
 ;
 ; initialize output string and requested data fields
 S $P(VAFY,VAFHLFS,2)="",VAFSTR=","_VAFSTR_","
 ;
 ; get Address Types from Patient (#2) file
 ; .1159 RESIDENTIAL ADDR CASS IND (S), [.115;19]
 ; .12115 TEMPORARY ADDR CASS IND (S), [.121;15]
 ; .123 STREET ADDRESS CASS IND (S), [.11;18]
 ; .14117 CONFIDENTIAL ADDR CASS IND (S), [.141;17]
 K ADT
 S SUB1=""
 F  S SUB1=$O(IVMZAVA(SUB1)) Q:SUB1=""  D
 .I SUB1="R" S ADT("R")=$$GET1^DIQ(2,DFN,".1159","I")
 .I SUB1="C" S ADT("C")=$$GET1^DIQ(2,DFN,".12115","I")
 .I SUB1="P" S ADT("P")=$$GET1^DIQ(2,DFN,".123","I")
 .I SUB1="CNF" S ADT("CNF")=$$GET1^DIQ(2,DFN,".14117","I")
 I $D(ADT) D
 .S SID=0
 .S SUB=""
 .F  S SUB=$O(ADT(SUB)) Q:SUB=""  D
 ..I $D(ADT(SUB)) D
 ...I VAFSTR[",1," S SID=SID+1,$P(VAFY,VAFHLFS)=SID       ;Set ID
 ...I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=SUB ; Address Type
 ...I ADT(SUB)="" S ADT(SUB)="NC"
 ...I VAFSTR[",3," S $P(VAFY,VAFHLFS,3)=ADT(SUB) ;Address Validation Indicator
 ...S IVMZAV("HL7",SID)="ZAV"_VAFHLFS_VAFY
 ;
ENQ Q
