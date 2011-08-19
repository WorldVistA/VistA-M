IBDF18A2 ;WISC/TN - ENCOUNTER FORM - utilities for PCE ;30-APR-03
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**51,55**;APR 30, 2003
 ;
 QUIT  ;CAll at CHKLST
 ;
CHKLST ;Create a new list to pass to calling packages.
 ;The new array will have CPT or ICD codes which
 ;are valid for the encounter date passed.
 ;
 ;CALLED BY: IBDF18A
 ;
 ;Quit if no date is passed.
 S ENCDATE=$G(ENCDATE) I ENCDATE="" Q
 ;
 NEW AA,CNT,CNT1,CNT2,MOD,TYPE,NODE
 K ^TMP("IBDCSV",$J)
 ;
 S CNT=0,AA=0,TYPE="",NODE="MODIFIER"
 S:PACKAGE="DG SELECT CPT PROCEDURE CODES" TYPE="CPT"
 S:PACKAGE="DG SELECT ICD-9 DIAGNOSIS CODE" TYPE="ICD"
 S:PACKAGE="DG SELECT VISIT TYPE CPT PROCE" TYPE="CPT"
 S:PACKAGE="GMP INPUT CLINIC COMMON PROBLE" TYPE="ICD"
 S:PACKAGE="GMP PATIENT ACTIVE PROBLEMS" TYPE="ICD"
 ;
 I TYPE="" D  Q
 . K @ARY
 . S @ARY@(0)=1
 . S @ARY@(1)="^AICS ERROR - Missing code type for "_PACKAGE
 ;
 ;Make copy of arry and kill the original
 M ^TMP("IBDCSV",$J)=@ARY KILL @ARY
 ;
 S CNT=0,AA=0
 F  S AA=$O(^TMP("IBDCSV",$J,AA)) Q:'AA  D
 . ;
 . I $E(^TMP("IBDCSV",$J,AA))="^" S CNT=CNT+1,@ARY@(CNT)=^TMP("IBDCSV",$J,AA) Q  ;header
 . ;
 . S CODE=$P(^TMP("IBDCSV",$J,AA),U) I CODE="" Q
 . ;
 . ;Validate the CPT code for the date passed
 . I TYPE="CPT" D  Q
 . . I $P($$CPT^ICPTCOD(CODE,ENCDATE),U,7)=1 D
 . . . S CNT=CNT+1,@ARY@(CNT)=^TMP("IBDCSV",$J,AA)
 . . . ;
 . . . ;Check for modifiers.
 . . . I '$G(^TMP("IBDCSV",$J,AA,NODE,0)) Q
 . . . ;
 . . . S CNT1=^TMP("IBDCSV",$J,AA,NODE,0)
 . . . F CNT2=1:1:CNT1 S MOD=^TMP("IBDCSV",$J,AA,NODE,CNT2) D
 . . . . ;
 . . . . ;If the status is 1 for the modifier
 . . . . I $P($$MOD^ICPTMOD(MOD,"E",ENCDATE),U,7)=1 D
 . . . . . S @ARY@(CNT,NODE,CNT2)=^TMP("IBDCSV",$J,AA,NODE,CNT2)
 . . . . . S @ARY@(CNT,NODE,0)=CNT2
 . . . . ;
 . ;Validate the ICD code for the date passed  
 . I $P($$ICDDX^ICDCODE(CODE,ENCDATE),U,10)=1 D
 . . S CNT=CNT+1,@ARY@(CNT)=^TMP("IBDCSV",$J,AA)
 ;
 S @ARY@(0)=CNT
 K ^TMP("IBDCSV",$J)
 Q
