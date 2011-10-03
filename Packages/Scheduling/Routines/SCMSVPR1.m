SCMSVPR1 ;ALB/ESD HL7 PR1 Segment Validation ;06/24/99
 ;;5.3;Scheduling;**44,66,142,180**;Aug 13, 1993
 ;06/24/99 ACS - Added CPT modifier to the validation process
 ;
EN(PR1ARRY,HLQ,HLFS,HLECH,VALERR,ENCDT) ;
 ; Entry point to return the HL7 PR1 (Procedure) validation segment
 ;
 ;  Input:  PR1ARRY - Array of PR1 Segments
 ;              HLQ - HL7 null variable
 ;             HLFS - HL7 field separator
 ;            HLECH - HL7 encoding characters
 ;           VALERR - Array to put errors in
 ;            ENCDT - Date of encounter
 ;
 ; Output:  1 if PR1 passed validity check
 ;          Error message if PR1 failed validity check in form of:
 ;          -1^"xxx failed validity check" (xxx=element in PR1 segment)
 ;
 ; NOTE:  This validity check will pass if at least ONE PR1 segment in
 ;        the PR1 array passes the validity checks.
 ;
 N I,J,MSG,OUT,PR1SEG,PR1ASEG,PRTYPE,VALID,X,CNT,SCSETID,SEG,OLD
 S X="",(I,OUT)=0,MSG="-1^Element in PR1 segment failed validity check",(SCSETID,CNT)=1,SEG="PR1"
 S PR1ARRY=$G(PR1ARRY)
 S:(PR1ARRY="") PR1ARRY="^TMP(""VAFHL"",$J,""PROCEDURE"")"
 F  S I=+$O(@PR1ARRY@(I)) Q:'I  D
 . S VALID(I)=1
 . S J="",J=$O(@PR1ARRY@(I,J)) Q:J=""
 . ;S PR1SEG=$G(@PR1ARRY@(I,J))
 . ;-----------------------------------------------------------
 . ; After the merge, PR1SEG looks like this:
 . ; PR1SEG=PR1^n^...^cpt^...
 . ; PR1SEG(1)=|mod~desc~meth|mod~desc~meth|...
 . ; PR1SEG(2)=|mod~desc~meth|mod~desc~meth|...
 . ;-----------------------------------------------------------
 . M PR1SEG=@PR1ARRY@(I,J)
 . S OLD=CNT
 . D VALIDATE^SCMSVUT0(SEG,PR1SEG,"0009",VALERR,.CNT)
 . I $G(@VALERR@(SEG,OLD))="0009" Q
 . S PR1SEG=$$CONVERT^SCMSVUT0(PR1SEG,HLFS,HLQ)
 . ;
 . ;- Validate procedure fields
 . ;D PROCVAL(PR1SEG)
 . D PROCVAL(.PR1SEG)
 . Q
 ;
 I '$D(VALID) D VALIDATE^SCMSVUT0(SEG,"","0009",VALERR,.CNT)
ENQ Q $S($D(@VALERR@(SEG)):MSG,1:1)
 ;
PROCVAL(PR1SEG) ; -Validate procedure fields
 ;
 ;N Z,DATA,CMPSEP
 N Z,DATA,CMPSEP,REPSEP
 S CMPSEP=$E(HLECH,1)
 S REPSEP=$E(HLECH,2)
 F Z="0101","0201","0401","0403" D
 . S DATA=$P(PR1SEG,HLFS,+$E(Z,1,2))
 . S DATA=$P(DATA,CMPSEP,+$E(Z,3,4))
 . D VALIDATE^SCMSVUT0(SEG,DATA,$P($T(@(Z)),";",3),VALERR,.CNT)
 ;
 ;--------------------------------------------------------------
 ;          VALIDATE PROCEDURE MODIFIER FIELDS
 ;
 ; The modifier, cpt+modifier, and modifier coding method are
 ; validated
 ;
 ; MODDATA = mod seq, piece 17: mod~desc~code meth|mod~desc~...
 ; CTR = continuation segment counter
 ; PROC = CPT procedure code
 ;--------------------------------------------------------------
 ;
 ;- validate modifier components in the first PR1 array seg
 N MODDATA,PROC
 S PROC=$P($P(PR1SEG,HLFS,4),CMPSEP,1)
 S MODDATA=$P(PR1SEG,HLFS,17)
 Q:'MODDATA
 D SETUP(MODDATA,PROC)
 ;
 ;- validate modifier components in the PR1 continuation segments
 N CTR,MODDATA
 S CTR=1,MODDATA=""
 F  S MODDATA=$E($G(PR1SEG(CTR)),2,245) Q:'MODDATA  D
 . D SETUP(MODDATA,PROC)
 . S CTR=CTR+1
 . Q
 Q
 ;
SETUP(MODDATA,PROC) ;
 ;
 ;---------------------------------------------------------------
 ;       SET UP AND VALIDATE MODIFIER COMPONENTS
 ;
 ; INPUT:  MODDATA = modifier components
 ;                   format: mod~desc~meth|mod~desc~meth|...
 ;            PROC = CPT procedure
 ;
 ; OTHER:
 ;          REPSEP = repetition separator ("|")
 ;             SEG = PR1
 ;             CNT = 1
 ;          VALERR = error message array
 ;        MCOMPNUM = modifier component number to validate
 ;          REPCTR = modifier repetition counter
 ;        MODDATA1 = each repetition of modifier info
 ;                   format: mod~desc~meth
 ;            DATA = modifier data to validate (i.e. mod or meth)
 ;---------------------------------------------------------------
 ;     
 N MCOMPNUM,REPCTR,MODDATA1,DATA
 S REPCTR=1
 ; add repetition separator to end of input data
 S MODDATA=MODDATA_REPSEP
 ;
 ; validate the modifier and coding method for each repetition
 F  S MODDATA1=$P(MODDATA,REPSEP,REPCTR) Q:'MODDATA1  D
 . F Z="1701","1703" D
 .. S MCOMPNUM=$E(Z,3,4)
 .. S DATA=$P(MODDATA1,"~",MCOMPNUM)
 .. ;
 .. ;- pass procedure AND modifier if validating modifier
 .. S:MCOMPNUM="01" DATA=PROC_"~"_DATA
 .. D VALIDATE^SCMSVUT0(SEG,DATA,$P($T(@(Z)),";",3),VALERR,.CNT)
 .. Q
 . S REPCTR=REPCTR+1
 . Q
 Q
 ;
 ;
 ;
 ;- PR1 data elements validated
 ;
 ;
0101 ;;0035;HL7 SEGMENT NAME 
0201 ;;6250;HL7 SEQUENTIAL NUMBER (SET ID) 
0401 ;;6050;PROCEDURE CODE (CPT) 
0403 ;;6000;PROCEDURE CODING METHOD 
1701 ;;6300;PROCEDURE MODIFIER AND PROC+MOD COMBINATION
1703 ;;6370;PROCEDURE MODIFIER CODING METHOD
