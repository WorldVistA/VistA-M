ENFACTU ;(WCIOFO)/SAB-FAP CAPITALIZATION THRESHOLD UTILITIES ;5/22/2002
 ;;7.0;ENGINEERING;**63,71**;August 17, 1993
TOPSYS(ENDA) ; Topmost System
 ; input ENDA - equipment entry #
 ; returns
 ;   entry # of topmost equipment in system of which ENDA is a part
 ;   OR 0 if ENDA is not part of a system (parent or component)
 ;   OR ?^message if error detected
 ;
 N ENDAC,ENDAP,ENPL,ENRET
 S ENRET=""
 ;
 ; start with ENDA as component and determine top-most item in system
 S ENPL=U ; init list of parents (used for detection of endless loop)
 S ENDAC=ENDA ; start with ENDA as a component
 ; traverse parent chain
 F  S ENDAP=$P($G(^ENG(6914,ENDAC,0)),U,3) Q:ENDAP=""!(ENPL[(U_ENDAP_U))  S ENDAC=ENDAP,ENPL=ENPL_ENDAP_U
 I ENDAP]"" S ENRET="?^ENDLESS LOOP DETECTED"
 ;
 ; use topmost parent if found
 I ENRET="",ENDAC'=ENDA S ENRET=ENDAC
 ; if not component then is item a parent?
 I ENRET="",$O(^ENG(6914,"AE",ENDA,""))]"" S ENRET=ENDA
 ; must not be part of system
 I ENRET="" S ENRET=0
 ;
 Q ENRET
 ;
SYSVAL(ENDAT,ENSW) ; System Value
 ; input ENDAT - entry # parent for system
 ;       ENSW  - optional switch
 ;               contains "C" if only capitalized values should be
 ;               included in return value
 ; returns sum of asset values for parent and all it's components
 ;
 N ENDA,ENMD,ENNODE,ENSUM,ENDA
 S ENSW=$G(ENSW)
 S ENSUM=0
 ;
 ; build list of all items in the system
 K ^TMP("ENSYS",$J)
 S ENMD=1
 D GETC^ENEQRP6(ENDAT,"","^TMP(""ENSYS"",$J,")
 ;
 ; loop thru all equipment on system list and sum asset values
 S ENNODE="^TMP(""ENSYS"",$J,"""")"
 F  S ENNODE=$Q(@ENNODE) Q:$QS(ENNODE,1)_$QS(ENNODE,2)'=("ENSYS"_$J)  D
 . S ENDA=$QS(ENNODE,$QL(ENNODE))
 . I ENSW["C",$$CHKFA^ENFAUTL(ENDA)'>0 Q  ; if only capitalized $
 . S ENSUM=ENSUM+$P($G(^ENG(6914,ENDA,2)),U,3)
 ;
 K ^TMP("ENSYS",$J)
 Q ENSUM
 ;      
CHKEXP(ENDA) ; Check if capitalized equipment item should be expensed
 ; input ENDA - equipment Entry # if check
 ; returns
 ;    1           (true) if it should be expensed
 ;    0^reason    if it should not be expensed due to system criteria
 ;    U^username  if it should not be expensed due to user edit
 ;
 N ENSYS,ENUSER
 ; must be reported to Fixed Assets/FMS to be an issue
 I $$CHKFA^ENFAUTL(ENDA)'>0 Q "0^NOT CURRENTLY REPORTED TO FAP"
 ;
 ; does item meet any of the system criteria to remain capitalized?
 I $$GET1^DIQ(6914,ENDA,38)="1524" Q "0^SGL 1524 (EXCESS)"
 I $$GET1^DIQ(6914,ENDA,62)="4539" Q "0^FUND 4539 (FRANCHISE)"
 I $$GET1^DIQ(6914,ENDA,12)>99999.99 Q "0^ASSET VALUE > 99999.99"
 S ENSYS=$$TOPSYS(ENDA) ; if part of system then check system value
 I ENSYS,$$SYSVAL(ENSYS,"C")>99999.99 Q "0^SYSTEM VALUE > 99999.99"
 ;
 ; did user specify that item should remain capitalized
 S ENUSER=$$GET1^DIQ(6914,ENDA,99,"E")
 I ENUSER]"" Q "U^"_ENUSER
 ;
 ; item did not meet any of criteria to remain capitalized
 Q 1
 ;
 ;ENFACTU
