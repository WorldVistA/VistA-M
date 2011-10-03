SCMSVZSP ;ALB/ESD HL7 ZSP Segment Validation ;05/08/95
 ;;5.3;Scheduling;**44,66**;Aug 13, 1993
 ;
 ;
EN(ZSPSEG,HLQ,HLFS,VALERR,DFN) ;
 ; Entry point to return the HL7 ZSP (Service Period) validation segment
 ;
 ;  Input:  ZSPSEG - ZSP Segment
 ;             HLQ - HL7 null variable
 ;            HLFS - HL7 field separator
 ;          VALERR - The array to put errors in
 ;             DFN - The paitent file DFN
 ;
 ; Output:  1 if ZSP passed validity check
 ;          Error message if ZSP failed validity check in form of:
 ;          -1^"xxx failed validity check" (xxx=element in ZSP segment)
 ;
 ;
 N I,MSG,X,DATA,CNT,SEG
 S MSG="-1^Element in ZSP segment failed validity check"
 S ZSPSEG=$G(ZSPSEG),CNT=1,SEG="ZSP"
 D VALIDATE^SCMSVUT0(SEG,ZSPSEG,"0014",VALERR,.CNT)
 I $D(@VALERR@(SEG)) G ENQ
 ;
 ;- Convert HLQ to null
 S ZSPSEG=$$CONVERT^SCMSVUT0(ZSPSEG,HLFS,HLQ)
 ;
 ;- Validate data elements
 F I=1,3,4,5,51,6,61 D
 . S DATA=$P(ZSPSEG,HLFS,+$E(I,1,1))
 . D VALIDATE^SCMSVUT0(SEG,DATA,$P($T(@(I)),";",3),VALERR,.CNT)
 . Q
 ;
ENQ Q $S($D(@VALERR@(SEG)):MSG,1:1)
 ;
 ;
ERR ;;Invalid or missing patient service period data for encounter (HL7 ZSP segment)
 ;
 ;- ZSP data elements validated
 ;
1 ;;0035;HL7 SEGMENT NAME
3 ;;B000;Service connected
4 ;;B050;SERVICE CONNECTED PERCENTAGE 
5 ;;B100;PERIOD OF SERVICE CODE 
51 ;;B120;Period of Serivce (active)
6 ;;B150;VIETNAM SERVICE INDICATED?
61 ;;B170;Vietnam serive indicated incon. vet status
