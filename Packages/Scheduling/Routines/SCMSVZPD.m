SCMSVZPD ;ALB/ESD,JLU HL7 ZPD Segment Validation ;05/08/95
 ;;5.3;Scheduling;**44,66,142,459,472**;Aug 13, 1993
 ;
 ;
EN(ZPDSEG,HLQ,HLFS,VALERR,ENCDT,NODE) ;
 ; Entry point to return the HL7 ZPD (Patient Data) validation segment
 ;
 ;  Input:  ZPDSEG - ZPD Segment
 ;             HLQ - HL7 null variable
 ;            HLFS - HL7 field separator
 ;          VALERR - Contains the array in which to put the errors
 ;           ENCDT - The date/time of the encounter being processed
 ;            NODE - The zero node of the entry from the Outpatient
 ;                   Encounter file.
 ;
 ; Output:  1 if ZPD passed validity check
 ;          Error message if ZPD failed validity check in form of:
 ;          -1^"xxx failed validity check" (xxx=element in ZPD segment)
 ;
 ;
 N I,MSG,DATA,X,CNT,SEG,DSS,DFN,SEGLINE,OFFSET,ZPDSEGSV
 S MSG="-1^element in ZPD segment failed validity check",CNT=1,SEG="ZPD"
 S ZPDSEG=$G(ZPDSEG)
 M ZPDSEGSV=ZPDSEG
 D VALIDATE^SCMSVUT0(SEG,ZPDSEG,"0007",VALERR,.CNT)
 I $D(@VALERR@(SEG)) G ENQ
 ;
 ;- Convert HLQ to null
 S ZPDSEG=$$CONVERT^SCMSVUT0(ZPDSEG,HLFS,HLQ)
 S I=0
 F  S I=$O(ZPDSEG(I)) Q:'I  S ZPDSEG(I)=$$CONVERT^SCMSVUT0(ZPDSEG(I),HLFS,HLQ)
 ;
 ;Getting the DSS identifier to check for a LAB
 S DSS=$P(NODE,U,3)
 S DSS=$G(^DIC(40.7,DSS,0))
 I DSS]"" S DSS=$P(DSS,U,2)
 ;
 ;Get pointer to PATIENT file
 S DFN=$P(NODE,U,2)
 ;
 ;- Validate data elements
 N NODE
 S OFFSET=0,NODE=0,SEGLINE=ZPDSEG
 F I=1,1010,1011,1012,17,18,19,21,41 D
 . I $L(SEGLINE,HLFS)<($E(I,1,2)-OFFSET) D
 . . ;Segment wrapped
 . . S OFFSET=OFFSET+$L(SEGLINE,HLFS)-1
 . . S NODE=+$O(ZPDSEG(NODE))
 . . I NODE=0 S SEGLINE="",NODE=+$O(ZPDSEG(NODE),-1) Q
 . . S SEGLINE=$G(ZPDSEG(NODE))
 . S DATA=$P(SEGLINE,HLFS,(+$E(I,1,2)-OFFSET))
 . I I=1011,DSS=108 Q
 . I I=1012,DSS'=108 Q
 . I +$E(I,1,2)=10,+DATA S DATA=$$FMDATE^HLFNC(DATA)
 . D VALIDATE^SCMSVUT0(SEG,DATA,$P($T(@(I)),";",3),VALERR,.CNT)
 .Q
 ;
ENQ M ZPDSEG=ZPDSEGSV
 Q $S($D(@VALERR@(SEG)):MSG,1:1)
 ;
 ;
ERR ;;Invalid or missing patient ID data for encounter (HL7 ZPD data segment)
 ;
 ;
 ;- ZPD data elements validated
 ;
1 ;;0035;HL7 SEGMENT NAME 
1010 ;;3000;DATE OF DEATH INVALID
1011 ;;2370;DATE OF DEATH BEFORE ENCOUNTER DATE 
1012 ;;3030;ENCOUNTER 14 DAYS AFTER THE ENCOUNTER DATE
17 ;;3100;HOMELESS INDICATOR 
18 ;;3150;POW STATUS INDICATED? 
19 ;;3200;TYPE OF INSURANCE 
21 ;;3250;INVALID/INCONSISTENT POW LOCATION
41 ;;3400;INVALID EMERGENCY RESPONSE INDICATOR
