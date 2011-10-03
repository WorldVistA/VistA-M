SCMSVZCL ;ALB/ESD HL7 ZCL Segment Validation ; 11/9/99 2:28pm
 ;;5.3;Scheduling;**44,66,180,239**;Aug 13, 1993
 ;
 ;
EN(ZCLARRY,HLQ,HLFS,VALERR,DFN) ;
 ; Entry point to return the HL7 ZCL (Outpatient Classification) validation segment
 ;
 ;  Input:  ZCLARRY - Array of ZCL Segments
 ;              HLQ - HL7 null variable
 ;             HLFS - HL7 field separator
 ;           VALERR - Array to put the errors in
 ;              DFN - The patient's DFN
 ;         
 ;
 ; Output:  1 if ZCL passed validity check
 ;          Error message if ZCL failed validity check in form of:
 ;          -1^"xxx failed validity check" (xxx=element in ZCL segment)
 ;
 ;
 N I,J,MSG,VALID,X,Z,ZCLSEG,SEG,CNT,DATA,SCSETID,VAR,SCCLASS,VALUE,TYPE
 S VALID=1,MSG="-1^Element in ZCL segment failed validity check"
 S I=0,J="",ZCLARRY=$G(ZCLARRY),SEG="ZCL",(SCSETID,CNT)=1
 S:(ZCLARRY="") ZCLARRY="^TMP(""VAFHL"",$J,""CLASS"")"
 ;
 ;- Validate classification fields
 F  S I=+$O(@ZCLARRY@(I)) Q:'I  F  S J=$O(@ZCLARRY@(I,J)) Q:J=""  D
 . S VALID=1
 . S ZCLSEG=$G(@ZCLARRY@(I,J))
 . S ZCLSEG=$$CONVERT^SCMSVUT0(ZCLSEG,HLFS,HLQ)
 . D VALIDATE^SCMSVUT0(SEG,ZCLSEG,"0012",VALERR,.CNT)
 . I $G(@VALERR@(SEG,CNT-1))="0012" Q
 . S TYPE=$P(ZCLSEG,HLFS,3)
 . F Z=1,2,3,32,4,41 DO
 .. S DATA=$P(ZCLSEG,HLFS,$E(Z,1,1))
 .. ;
 .. ;MST check for type 5 encounter 1
 .. I (Z=32),DATA'=5 Q
 .. I (Z=32),DATA=5 S VALUE=$P(ZCLSEG,HLFS,4) Q:VALUE'=1
 .. ;
 .. D VALIDATE^SCMSVUT0(SEG,DATA,$P($T(@(Z)),";",3),VALERR,.CNT)
 .. K VALUE
 .. Q
 . Q
 ;
 I '$D(VALID) D VALIDATE^SCMSVUT0(SEG,"","0012",VALERR,.CNT)
 ;
ENQ Q $S($D(@VALERR@(SEG)):MSG,1:1)
 ;
 ;
 ;- ZCL data elements validated
 ;
1 ;;0035;HL7 SEGMENT NAME 
2 ;;9150;HL7 SEQUENTIAL NUMBER (SET ID) 
3 ;;9000;CLASSIFICATION TYPE 
32 ;;9030;MST status inconsistent with classification type
4 ;;9050;Answer to classification questions missing
41 ;;9020;Veteran status inconsistent with classification type
