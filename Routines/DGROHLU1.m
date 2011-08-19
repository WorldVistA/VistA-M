DGROHLU1 ;DJH/AMA - ROM HL7 BUILD FDA SEGMENT ; 24 Jun 2003  3:53 PM
 ;;5.3;Registration;**533,572**;Aug 13, 1993
 ;
 Q
 ;
FDA(DGROFDA,DGSEGSTR)    ; FDA SEGMENT API
 ;Called from BLDORF^DGROHLQ
 ;
 ;   INPUT:
 ;     DGROFDA - POINTER TO THE GLOBAL DATA ARRAY, ^TMP("DGROFDA",$J)
 ;
 ;   OUTPUT:
 ;     DGSEGSTR - ARRAY OF SEGMENTS
 ;
 N DGVAL
 ;
 Q:'$D(@DGROFDA)
 I $$FDAVAL(.DGVAL) D
 . D BLDFDA("FDA",.DGVAL,.DGSEGSTR,.DGHL)
 Q
 ;
FDAVAL(DGVAL)   ; FORMAT THE DATA ARRAY FOR THE FDA SEGMENT
 ;   Input:
 ;     DGVAL - array of data
 ;
 N DGRSLT,DGX,DGF,DGIEN,DGFLD,DGEI,DGCHAR
 ;
 S (DGRSLT,DGX)=0
 S DGF=0 F  S DGF=$O(@DGROFDA@(DGF)) Q:'DGF  D
 . S DGIEN="" F  S DGIEN=$O(@DGROFDA@(DGF,DGIEN)) Q:DGIEN=""  D
 . . S DGFLD=0 F  S DGFLD=$O(@DGROFDA@(DGF,DGIEN,DGFLD)) Q:'DGFLD  D
 . . . S DGX=DGX+1
 . . . S DGVAL(DGX,1,1)=DGF
 . . . S DGVAL(DGX,1,2)=DGIEN
 . . . S DGVAL(DGX,1,3)=DGFLD
 . . . ;*Get all External values (DG*5.3*572)
 . . . S DGVAL(DGX,2,1)=$G(@DGROFDA@(DGF,DGIEN,DGFLD,"E"))
 . S DGRSLT=1
 ;
 Q DGRSLT
 ;
BLDFDA(DGTYP,DGVAL,DGSEGSTR,DGHL)       ;FDA SEGMENT BUILDER
 ;BUILDS THE FDA SEGMENT IN THE FOLLOWING FORMAT:
 ;  FDA ^ FILE | IEN | FIELD ~ EXTERNAL VALUE
 ;  ADD ^ FILE | IEN | FIELD ~ EXTERNAL VALUE
 ;  ADD ^ FILE | IEN | FIELD ~ EXTERNAL VALUE
 ;   etc., etc.
 ;
 ;   INPUT:
 ;     DGTYP    - SEGMENT TYPE
 ;     DGVAL    - FIELD DATA ARRAY  [SUB1:field, SUB2:repetition
 ;                                   SUB3:component, SUB4:sub-component]
 ;     DGSEGSTR - ARRAY OF SEGMENTS, EACH NO GREATER THAN 245 CHARACTERS
 ;     DGHL     - HL7 ENVIRONMENT ARRAY
 ;
 ;   OUTPUT:
 ;     FUNCTION VALUE - FORMATTED ARRAY OF HL7 SEGMENTS ON SUCCESS, "" ON FAILURE
 ;
 N DGCNT     ;array counter
 N DGFS      ;field separator
 N DGCS      ;component separator
 N DGRS      ;repetition separator
 N DGSS      ;sub-component separator
 N DGFLD     ;field subscript
 N DGFLDVAL  ;field value
 N DGSEP     ;HL7 separator
 N DGREP     ;repetition subscript
 N DGREPVAL  ;repetition value
 N DGCMP     ;component subscript
 N DGCMPVAL  ;component value
 N DGSUB     ;sub-component subscript
 N DGSUBVAL  ;sub-component value
 ;
 Q:($G(DGTYP)']"")
 ;
 S DGCNT=1
 S DGSEGSTR(DGCNT)=DGTYP
 S DGFS=DGHL("FS")
 S DGCS=$E(DGHL("ECH"))
 S DGRS=$E(DGHL("ECH"),2)
 S DGSS=$E(DGHL("ECH"),4)
 ;
 F DGFLD=1:1:$O(DGVAL(""),-1) D
 . I DGTYP="ADD" S DGCNT=DGCNT+1,DGSEGSTR(DGCNT)=DGTYP
 . S DGFLDVAL=$G(DGVAL(DGFLD)),DGSEP=DGFS
 . D ADD(DGFLDVAL,DGSEP,.DGSEGSTR,.DGCNT)
 . F DGREP=1:1:$O(DGVAL(DGFLD,""),-1)  D
 . . S DGREPVAL=$G(DGVAL(DGFLD,DGREP))
 . . S DGSEP=$S(DGREP=1:"",1:DGRS)
 . . D ADD(DGREPVAL,DGSEP,.DGSEGSTR,.DGCNT)
 . . F DGCMP=1:1:$O(DGVAL(DGFLD,DGREP,""),-1) D
 . . . S DGCMPVAL=$G(DGVAL(DGFLD,DGREP,DGCMP))
 . . . S DGSEP=$S(DGCMP=1:"",1:DGCS)
 . . . D ADD(DGCMPVAL,DGSEP,.DGSEGSTR,.DGCNT)
 . . . F DGSUB=1:1:$O(DGVAL(DGFLD,DGREP,DGCMP,""),-1) D
 . . . . S DGSUBVAL=$G(DGVAL(DGFLD,DGREP,DGCMP,DGSUB))
 . . . . S DGSEP=$S(DGSUB=1:"",1:DGSS)
 . . . . D ADD(DGSUBVAL,DGSEP,.DGSEGSTR,.DGCNT)
 . S DGTYP="ADD"
 Q
 ;
ADD(DGVAL,DGSEP,DGSEGSTR,DGCNT) ;append a value onto segment
 ;
 ;  Input:
 ;    DGVAL - value to append
 ;    DGSEP - HL7 separator
 ;
 ;  Output:
 ;    DGSEGSTR(DGCNT) - segment passed by reference
 ;
 S DGSEP=$G(DGSEP)
 S DGVAL=$G(DGVAL)
 S DGSEGSTR(DGCNT)=DGSEGSTR(DGCNT)_DGSEP_DGVAL
 Q
