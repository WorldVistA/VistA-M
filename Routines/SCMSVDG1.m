SCMSVDG1 ;ALB/ESD HL7 DG1 Segment Validation ;05/08/95
 ;;5.3;Scheduling;**44,57,68,77,85,95,66**;Aug 13, 1993
 ;
 ;
EN(DG1ARRY,HLQ,HLFS,ENCPTR,VALERR,ENCDT) ;
 ; Entry point to return the HL7 DG1 (Outpatient Diagnosis) validation segment
 ;
 ;  Input:  DG1ARRY - Array of DG1 Segments
 ;              HLQ - HL7 null variable
 ;             HLFS - HL7 field separator
 ;           ENCPTR - Outpatient Encounter IEN (file #409.68)
 ;           VALERR - The array name to put error messages in
 ;            ENCDT - The date of the encounter
 ;
 ; Output:  1 if DG1 passed validity check
 ;          Error message if DG1 failed validity check in form of:
 ;          -1^"xxx failed validity check" (xxx=element in DG1 segment)
 ;
 ; NOTE:  This validity check will pass if at least ONE DG1 segment in 
 ;        the DG1 array passes the validity checks.
 ;
 ;        A check for occasion of service (procedure which does not 
 ;        require a diagnosis) is contained in this routine.
 ;
 ;
 N DG1SEG,I,J,MSG,PROCARRY,VALID,X,Z,DATA,CNT,SCSETID,SEG,PRIOR
 S MSG="-1^Element in DG1 segment failed validity check"
 S (I,PRIOR)=0,X="",PROCARRY="PROCS",DG1ARRY=$G(DG1ARRY),SEG="DG1",(CNT,SCSETID)=1
 S:(DG1ARRY="") DG1ARRY="^TMP(""VAFHL"",$J,""DIAGNOSIS"")"
 ;
 ;- Check for occasion of service and number od DX's found greater then zero.
 ;  If 00s and NO DX's, kill DG1 array.  If 00S and there are DX's, continue
 ;  processing DG1 segment.
 N SDCNT,SDDXY,QUIT
 I ($$CHKOCC(ENCPTR)) D SET^SDCO4(ENCPTR) I 'SDCNT D  G ENQ
 . K @DG1ARRY
 . Q
 ;
 F  S I=+$O(@DG1ARRY@(I)) Q:'I  D  Q:$D(QUIT)
 . S J="",VALID=1
 . F  S J=$O(@DG1ARRY@(I,J)) Q:J=""  D  Q:$D(QUIT)
 .. S DG1SEG=$G(@DG1ARRY@(I,J)),DG1SEG=$$CONVERT^SCMSVUT0(DG1SEG,HLFS,HLQ)
 .. D VALIDATE^SCMSVUT0(SEG,DG1SEG,"0036",VALERR,.CNT)
 .. I $G(@VALERR@(SEG,CNT-1))="0036" S QUIT=1 Q
 .. F Z=1,2,3,4,16 DO  ;;;*** SWITCHED THIS FROM 6 TO 16 NEED TO TEST
 ... S DATA=$P(DG1SEG,HLFS,Z)
 ... I Z=16,DATA=1 S PRIOR=PRIOR+1
 ... D VALIDATE^SCMSVUT0(SEG,DATA,$P($T(@(Z)),";",3),VALERR,.CNT)
 ... Q
 .. Q
 . Q
 ;
 I $D(QUIT) G ENQ
 D VALIDATE^SCMSVUT0(SEG,PRIOR,"5100",VALERR,.CNT)
 I '$D(VALID) D VALIDATE^SCMSVUT0(SEG,"","0036",VALERR,.CNT)
 ;
ENQ Q $S($D(@VALERR@(SEG)):MSG,1:1)
 ;
 ;
CHKOCC(ENCPTR) ; Occasion of Service Check
 ;
 ;         Input:  ENCPTR - Ptr to outpatient encounter file
 ;
 ;        Output:  0 if location is not an occasion of service clinic
 ;                 1 if location is an occasion of service clinic
 ;
 ;
 N ENC,LOC,STOP
 S ENC=$G(^SCE(+ENCPTR,0))
 S LOC=$P(ENC,"^",4),STOP=$P($G(^SC(+LOC,0)),"^",7)
 Q $$EX^SDCOU2(STOP,+ENC)
 ;
 ;
 ;- DG1 data elements validated
 ;
1 ;;0035;HL7 SEGMENT NAME 
2 ;;5150;HL7 SEQUENTIAL NUMBER (SET ID) 
3 ;;5030;DIAGNOSIS CODING METHOD 
4 ;;5000;DIAGNOSIS CODE (ICD 9) 
16 ;;5100;DIAGNOSIS PRIORITY 
