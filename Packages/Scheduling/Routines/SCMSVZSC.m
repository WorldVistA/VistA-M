SCMSVZSC ;ALB/ESD HL7 ZSC Segment Validation ;05/08/95
 ;;5.3;Scheduling;**44,66,143**;Aug 13, 1993
 ;
 ;
EN(ZSCARRY,HLQ,HLFS,VALERR,ENCPTR) ;
 ; Entry point to return the HL7 ZSC (Stop Code) validation segment
 ;
 ;  Input:  ZSCARRY - Array of ZSC Segments
 ;              HLQ - HL7 null variable
 ;             HLFS - HL7 field separator
 ;
 ;
 ; Output:  1 if ZSC passed validity check
 ;          Error message if ZSC failed validity check in form of:
 ;          -1^"xxx failed validity check" (xxx=element in ZSC segment)
 ;
 ;
 N I,J,MSG,VALID,X,Z,ZSCSEG,CNT,SEG,SCSETID,DATA
 S MSG="-1^Element in ZSC segment failed validity check"
 S I=0,X="",ZSCARRY=$G(ZSCARRY),SEG="ZSC",(SCSETID,CNT)=1
 S:(ZSCARRY="") ZSCARRY="^TMP(""VAFHL"",$J,""STOPCODE"")"
 ;
 F  S I=+$O(@ZSCARRY@(I)) Q:'I  D
 . S J="",VALID(1)=1
 . F  S J=$O(@ZSCARRY@(I,J)) Q:J=""  D
 .. S ZSCSEG=$G(@ZSCARRY@(I,J)),ZSCSEG=$$CONVERT^SCMSVUT0(ZSCSEG,HLFS,HLQ)
 .. D VALIDATE^SCMSVUT0(SEG,ZSCSEG,"0013",VALERR,.CNT)
 .. I $G(@VALERR@(SEG,CNT-1))="0013" Q
 .. F Z=1,2,3,31 DO
 ... S DATA=$P(ZSCSEG,HLFS,+$E(Z,1,1))
 ... I Z=31 S DATA=$$STPCOD(DATA,ENCPTR)
 ... D VALIDATE^SCMSVUT0(SEG,DATA,$P($T(@(Z)),";",3),VALERR,.CNT)
 ...Q
 ..Q
 .Q
 ;
 I '$D(VALID) D VALIDATE^SCMSVUT0(SEG,"","0013",VALERR,.CNT)
 ;
ENQ Q $S($D(@VALERR@(SEG)):MSG,1:1)
 ;
 ;
 ;- ZSC data elements validated
 ;
STPCOD(DATA,ENCPTR) ;
 N LP,ANS,STPARY
 D SCODE^SCDXUTL0(ENCPTR,"STPARY")
 I '$G(STPARY(0)) Q 0
 S ANS=0
 F LP=0:0 S LP=$O(STPARY(LP)) Q:'LP  DO  Q:+ANS>0
 .N STPNOD
 .S STPNOD=$G(^DIC(40.7,STPARY(LP),0))
 .Q:STPNOD=""
 .I $P(STPNOD,U,2)=DATA S ANS=+STPARY(LP)
 .Q
 Q ANS
 ;
1 ;;0035;HL7 SEGMENT NAME
2 ;;A050;HL7 SEQUENTIAL NUMBER (SET ID)
3 ;;A000;STOP CODE
31 ;;A020;INACTIVE STOP CODE
