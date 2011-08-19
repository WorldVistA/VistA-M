SCMSVEVN ;ALB/ESD HL7 EVN Segment Validation ;05/08/95
 ;;5.3;Scheduling;**44,66**;Aug 13, 1993
 ;
 ;
EN(EVNSEG,HLQ,HLFS,VALERR) ;
 ; Entry point to return the HL7 EVN (Event Type) validation segment
 ;
 ;  Input:  EVNSEG - EVN Segment
 ;             HLQ - HL7 null variable
 ;            HLFS - HL7 field separator
 ;          VALERR - The array to place the errors in.
 ;
 ; Output:  1 if EVN passed validity check
 ;          Error message if EVN failed validity check in form of:
 ;          -1^"xxx failed validity check" (xxx=element in EVN segment)
 ;
 ;          The array contained in VALERR will have the errors if any
 ;          are found.  They will be subscripted by "EVN",# from this
 ;          validation subroutine.
 ;          Ex.  ^TMP("TEST",$J,"EVN",1)=ERROR CODE
 ;               ^TMP("TEST",$J,"EVN",2)=ERROR CODE
 ;
 ;
 N I,MSG,VALID,X,CNT,SEG
 S CNT=1,MSG="-1^Element in EVN segment failed validity check"
 S SEG="EVN"
 ;
 S EVNSEG=$G(EVNSEG)
 D VALIDATE^SCMSVUT0(SEG,EVNSEG,"0005",VALERR,.CNT)
 I $D(@VALERR@(SEG)) G ENQ
 ;
 S EVNSEG=$$CONVERT^SCMSVUT0(EVNSEG,HLFS,HLQ)
 ;
 F I=1:1:3 D VALIDATE^SCMSVUT0(SEG,$S(I'=3:$P(EVNSEG,HLFS,I),1:$$FMDATE^HLFNC($P(EVNSEG,HLFS,I))),$P($T(@I),";",3),VALERR,.CNT)
 ;
ENQ Q $S($D(@VALERR@("EVN",1)):MSG,1:1)
 ;
 ;
1 ;;0035;HL7 SEGMENT NAME
2 ;;1000;HL7 EVENT TYPE
3 ;;1050;HL7 EVENT DATE/TIME
