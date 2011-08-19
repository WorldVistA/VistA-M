VAQXRF3 ;ALB/JRP - X-REF CODES FOR PDX;17-FEB-92
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
AF(IFN,SET,FNUM,OLDX) ;AF* X-REF FOR DATA FILE (#394.62)
 ;INPUT  : IFN - Internal file number of record
 ;         SET - If 1, set cross reference
 ;               If 0, kill cross reference (DEFAULT)
 ;         FNUM - Only valid for KILLS
 ;                The field number that was changed
 ;         OLDX - Only valid for KILLS
 ;                The previous value
 ;OUTPUT : 0 - Cross reference was set/killed
 ;        -1 - Cross reference not set/killed
 ;        -2 - Bad input
 ;
 ;NOTE: This x-ref is only SET if data was stored in display
 ;      ready format.  KILLing of x-ref is always allowed.
 ;
 ;CHECK INPUT & RECORD EXISTANCE
 Q:($G(IFN)="") -2
 S SET=+$G(SET)
 Q:('$D(^VAT(394.62,IFN))) -2
 Q:(('SET)&('$D(FNUM))&('$D(OLDX))) -2
 ;DECLARE VARIABLES
 N ZERO,TRANS,SEGMENT,DISPLAY
 ;GET INFO FOR X-REF & QUIT IF ANY PART IS NULL
 S ZERO=$G(^VAT(394.62,IFN,0))
 Q:(ZERO="") -1
 S DISPLAY=$P(ZERO,"^",5)
 Q:(('DISPLAY)&SET) -1
 S SEGMENT=$P(ZERO,"^",2)
 I ('SET) S:(FNUM=.02) SEGMENT=OLDX
 Q:(SEGMENT="") -1
 S TRANS=$P($G(^VAT(394.62,IFN,"TRNS")),"^",1)
 I ('SET) S:(FNUM=40) TRANS=OLDX
 Q:(TRANS="") -1
 ;SET X-REF
 S:(SET) ^VAT(394.62,"A-DISPLAY",TRANS,SEGMENT,IFN)=""
 ;KILL X-REF
 K:('SET) ^VAT(394.62,"A-DISPLAY",TRANS,SEGMENT,IFN)
 Q 0
 ;
AG(IFN) ;AG X-REF FOR DATA FILE (#394.62)
 ;INPUT  : IFN - Internal file number of record
 ;
 ;OUTPUT : If now display ready, result of killing AF x-ref
 ;         If now info only, result of setting AF x-ref
 ;
 ;NOTE: This x-ref is used to clean-up the node set by the AF*
 ;      x-refs.  It will only be executed when field .05 is changed
 ;      (only used in KILL logic).
 ;
 ;CHECK INPUT & RECORD EXISTANCE
 Q:($G(IFN)="") -2
 Q:('$D(^VAT(394.62,IFN))) -2
 ;DECLARE VARIABLES
 N TEMP,DISPLAY,RESULT
 S DISPLAY=$P($G(^VAT(394.62,IFN,0)),"^",5)
 Q:(DISPLAY="") -1
 ;NEW FORMAT IS DISPLAY READY
 I (DISPLAY) D
 .;SET AF* X-REF
 .S RESULT=$$AF^VAQXRF3(IFN,1)
 ;NEW FORMAT IS NOT DISPLAY READY
 I ('DISPLAY) D
 .;KILL AF* X-REF
 .S RESULT=$$AF^VAQXRF3(IFN,0,"","")
 Q RESULT
ONEPAR(FACPTR) ;SCREEN TO ONLY ALLOW ONE ENTRY IN PARAMTER FILE
 ;INPUT  : FACPTR - Pointer to INSTITUTION File (what user has entered)
 ;OUTPUT : 1 - Institution entered may be used
 ;             (there is no entry or it is the existing entry)
 ;         0 - Institution entered may not be used
 ;             (it is not the existing entry)
 ;NOTES  : Used in screening of field .01
 ;
 ;CHECK INPUT
 Q:('FACPTR) 0
 ;DECLARE VARIABLES
 N IFN,CURPTR
 ;CURRENTLY NO ENTRY
 S IFN=$O(^VAT(394.81,0))
 Q:('IFN) 1
 ;CURRENT ENTRY IS ENTERED INSTITUTION
 S CURPTR=+$G(^VAT(394.81,IFN,0))
 Q:(FACPTR=CURPTR) 1
 ;DON'T ALLOW SELECTION
 Q 0
