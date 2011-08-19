SCMSVZIR ;ALB/ESD HL7 ZIR Segment Validation ;05/08/95
 ;;5.3;Scheduling;**44,55,66**;Aug 13, 1993
 ;
 ;
EN(ZIRSEG,HLQ,HLFS,VALERR) ;
 ; Entry point to return the HL7 ZIR (Income Relation) validation segment
 ;
 ;  Input:  ZIRSEG - ZIR Segment
 ;             HLQ - HL7 null variable
 ;            HLFS - HL7 field separator
 ;          VALERR - Array to put the errors in
 ;
 ; Output:  1 if ZIR passed validity check
 ;          Error message if ZIR failed validity check in form of:
 ;          -1^"xxx failed validity check" (xxx=element in ZIR segment)
 ;
 ;
 N I,MSG,X,SEG,CNT,DATA
 S MSG="-1^Element in ZIR segment failed validity check",SEG="ZIR",CNT=1
 S ZIRSEG=$G(ZIRSEG)
 D VALIDATE^SCMSVUT0(SEG,ZIRSEG,"0011",VALERR,.CNT)
 I $D(@VALERR@(SEG)) G ENQ
 ;
 ;- Convert HLQ to null
 S ZIRSEG=$$CONVERT^SCMSVUT0(ZIRSEG,HLFS,HLQ)
 ;
 ;- Validate data elements
 N DATA1
 F I=1,12,13,14,90 D  I I=14,$G(@VALERR@(SEG,CNT-1))=8100 Q
 . S DATA=$P(ZIRSEG,HLFS,I)
 . D VALIDATE^SCMSVUT0(SEG,$S(I=90:DATA1,1:DATA),$P($T(@(I)),";",3),VALERR,.CNT)
 . I I=12 S $P(DATA1,U,1)=DATA
 . I I=14 S $P(DATA1,U,2)=DATA
 ;
ENQ Q $S($D(@VALERR@(SEG)):MSG,1:1)
 ;
 ;
ERR ;;Invalid or missing patient income data for encounter (HL7 ZIR segment)
 ;
 ;
 ;- ZIR data elements validated
 ;
1 ;;0035;HL7 SEGMENT NAME 
12 ;;8050;NUMBER OF DEPENDENTS 
13 ;;8150;PATIENT INCOME 
14 ;;8100;MEANS TEST INDICATOR 
90 ;;8070;Number of dependents inconstitentwith means test
