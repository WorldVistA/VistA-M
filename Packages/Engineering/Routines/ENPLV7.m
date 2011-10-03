ENPLV7 ;(WIRMFO)/SAB-PROJECT VALIDATION, VALIDATE ONE ENTRY (cont) ;9/15/97
 ;;7.0;ENGINEERING;**28**;Aug 17, 1993
 ; progress report specific checks
 I "^MA^MI^MM^NR^SL^"'[(U_ENPR_U) S ENS=1,ENMSG="PROGRAM ("_ENPR_") not supported for Progress Reports." D MSG Q
 N ENMS,ENMSCP,ENMSL,ENMSOK,ENMSP
 S ENMSOK=$$MSL^ENPRUTL(ENDA) ; applicable milestone list
 ; obtain current milestones
 D MSD^ENPRUTL(ENDA)
 ; determine last applicable, non-optional entered
 S (ENMSL("A"),ENMSL("P"))=0
 F ENI=22:-1:1 I $P(ENMSOK,U,ENI) D
 . Q:"^1^2^3^13^14^16^17^"[(U_ENI_U)  ; optional milestones
 . I 'ENMSL("A"),ENMS("A",ENI)]"" S ENMSL("A")=ENI
 . I 'ENMSL("P"),ENMS("P",ENI)]""!(ENMS("R",ENI)]"") S ENMSL("P")=ENI
 ; loop through milestones and validate
 S (ENMSP("P"),ENMSP("R"),ENMSP("A"))="" ; init previous milestone
 F ENI=1:1:22 D
 . S ENMS=$$MS^ENPRUTL(ENI)
 . I $P(ENMSOK,U,ENI) D  ; applicable milestone
 . . ; check for incomplete date
 . . I ENMS("P",ENI)]"",$E(ENMS("P",ENI),4,5)="00" S ENS=1,ENMSG=ENMS_" (PLANNED) is missing the month." D MSG
 . . I ENMS("R",ENI)]"",$E(ENMS("R",ENI),4,5)="00" S ENS=1,ENMSG=ENMS_" (REVISED) is missing the month." D MSG
 . . I ENMS("A",ENI)]"",$E(ENMS("A",ENI),4,5)="00" S ENS=1,ENMSG=ENMS_" (ACTUAL) is missing the month." D MSG
 . . ; check for past due
 . . S ENMSCP=$S(ENMS("R",ENI)]"":ENMS("R",ENI),1:ENMS("P",ENI)) ; current planned
 . . I ENMS("A",ENI)="",ENMSCP]"",ENMSCP<DT D
 . . . S ENS=1,ENMSG=ENMS_" past due. Enter actual or update revised date." D MSG
 . . ; check % for appropriate milestones
 . . I "^2^8^10^12^21^"[(U_ENI_U) D
 . . . I ENMS("A",ENI)]"",ENMS("%",ENI)'=100 D
 . . . . S ENS=1,ENMSG=ENMS_" (ACTUAL) entered, but percentage not 100" D MSG
 . . . I ENMS("A",ENI)="" D
 . . . . I ENMS("A",ENI-1)]"",ENMS("%",ENI)="" D
 . . . . . S ENS=2,ENMSG=ENMS_" percentage is blank (expected 0-99 since actual start date exists)." D MSG
 . . . . I ENMS("A",ENI-1)="",ENMS("%",ENI)>0 D
 . . . . . S ENS=1,ENMSG=ENMS_" percentage > 0 but actual start date is blank." D MSG
 . . I "^2^16^17^"[(U_ENI_U) D  ; optional ms: complete date checks
 . . . N ENIP
 . . . S ENIP=$S(ENI=2:1,ENI=16:13,ENI=17:14,1:0) Q:'ENIP  ; start ms
 . . . ; check complete date < start date
 . . . I ENMS("P",ENI)]"",ENMS("P",ENI)<ENMS("P",ENIP)!(ENMS("P",ENIP)="") D
 . . . . S ENS=2,ENMSG=ENMS_" (PLANNED) before planned start date." D MSG
 . . . I ENMS("R",ENI)]"",ENMS("R",ENI)<$S(ENMS("R",ENIP)]"":ENMS("R",ENIP),1:ENMS("P",ENIP))!(ENMS("P",ENIP)=""&(ENMS("R",ENIP)="")) D
 . . . . S ENS=2,ENMSG=ENMS_" (REVISED) before start date." D MSG
 . . . I ENMS("A",ENI)]"",ENMS("A",ENI)<ENMS("A",ENIP)!(ENMS("A",ENIP)="") D
 . . . . S ENS=2,ENMSG=ENMS_" (ACTUAL) before actual start date." D MSG
 . . Q:"^1^2^3^13^14^16^17^"[(U_ENI_U)  ; stop when optional milestones
 . . ; check for chronological dates
 . . I ENMS("P",ENI)="",ENI<ENMSL("P") D
 . . . S ENS=1,ENMSG=ENMS_" (PLANNED) milestone was skipped." D MSG
 . . I ENMS("A",ENI)="",ENI<ENMSL("A") D
 . . . S ENS=2,ENMSG=ENMS_" (ACTUAL) milestone was skipped." D MSG
 . . I ENMS("P",ENI)]"",ENMS("P",ENI)<ENMSP("P") D
 . . . S ENS=2,ENMSG=ENMS_" (PLANNED) before previous milestone" D MSG
 . . I ENMS("R",ENI)]"",ENMS("R",ENI)<ENMSP("R") D
 . . . S ENS=2,ENMSG=ENMS_" (REVISED) before previous milestone" D MSG
 . . I ENMS("A",ENI)]"",ENMS("A",ENI)<ENMSP("A") D
 . . . S ENS=2,ENMSG=ENMS_" (ACTUAL) before previous milestone" D MSG
 . . ; update 'previous' variables
 . . I ENMS("P",ENI)]"" S (ENMSP("R"),ENMSP("P"))=ENMS("P",ENI)
 . . I ENMS("R",ENI)]"" S ENMSP("R")=ENMS("R",ENI)
 . . I ENMS("A",ENI)]"" S ENMSP("A")=ENMS("A",ENI)
 . I '$P(ENMSOK,U,ENI) D  ; inappropriate milestones
 . . I ENMS("P",ENI)]""!(ENMS("R",ENI)]"")!(ENMS("A",ENI)]"") D
 . . . S ENS=2,ENMSG=ENMS_" milestone inappropriate for project." D MSG
 ; compare Status with last actual milestone
 I ENMSL("A"),$$GET1^DIQ(6925,ENDA,"6:3")<$P("4^4^5^5^6^6^7^7^8^8^9^9^9^9^10^9^9^11^12^12^12^13",U,ENMSL("A")) D
 . S ENS=2,ENMSG="Status ("_$$GET1^DIQ(6925,ENDA,6)_") appears inappropriate since milestone "_$$MS^ENPRUTL(ENMSL("A"))_" (ACTUAL) exists." D MSG
 I ENMSL("A")=21,ENMSL("P")'=22,$$GET1^DIQ(6925,ENDA,"6:3")<13 S ENS=2,ENMSG="Project appears to be completed, but has Status ("_$$GET1^DIQ(6925,ENDA,6)_")" D MSG
 ; check funding years vs. award dates for MA, MI, and MM
 I "^MA^MI^MM^"[(U_ENPR_U) D
 . N ENCOFY,ENCOMI
 . ; select milestone for construction method
 . S ENI=0,ENCOMI=$$GET1^DIQ(6925,ENDA,8,"I")
 . I "^1^4^5^"[(U_ENCOMI_U) S ENI=19 ; award
 . I "^2^"[(U_ENCOMI_U) S ENI=20 ; start
 . I ENI D
 . . S ENX=$S(ENMS("A",ENI):ENMS("A",ENI),ENMS("R",ENI):ENMS("R",ENI),ENMS("P",ENI):ENMS("P",ENI),1:"")
 . . Q:ENX=""
 . . S ENCOFY=$$GET1^DIQ(6925,ENDA,3.5)
 . . I $E(ENX+17000000\1,1,4)+$S($E(ENX,4,5)>9:1,1:0)'=ENCOFY S ENS=1,ENMSG=$$MS^ENPRUTL(ENI)_" ("_$$FMTE^XLFDT(ENX,2)_") inconsistant with FUNDING YEAR - CONST ("_ENCOFY_")" D MSG
 ;
 I ENPR="NR" D  ; NRM program checks
 . I $P(ENY52,U,7)="" S ENS=1,ENMSG="EPA REPORTABLE (y/n) required for NRM projects." D MSG
 . I $P(ENY52,U,7)="Y" D
 . . I $P(ENY52,U,8)="" S ENS=1,ENMSG="EPA REPORTING CATEGORY is required for EPA REPORTABLE (YES)." D MSG
 . . I $P(ENY52,U,8)]"",ENPCI]"" D
 . . . D VAL^DIE(6925,ENDA_",",158.7,"","`"_$P(ENY52,U,8),.ENX)
 . . . I ENX="^" S ENS=1,ENMSG="EPA REPORTING CATEGORY ("_$P($G(^ENG(6925.3,$P(ENY52,U,8),0)),U)_") inconsistent with PROJECT CATEGORY ("_$P($G(^OFM(7336.8,ENPCI,0)),U)_")." D MSG
 I "^NR^SL^"[(U_ENPR_U) D  ; NRM,SL program checks
 . I $P(ENY52,U,9)]"" D
 . . S ENX=$P($G(^OFM(7336.8,$P(ENY52,U,9),0)),U)
 . . I ENX["NHCU" D
 . . . I $P($G(^ENG("PROJ",ENDA,53)),U,4)="" S ENS=1,ENMSG="NHCU AUTHORIZED BEDS required for BONUS CATEGORY ("_ENX_")." D MSG
 ;
 I "^MA^MI^MM^"[(U_ENPR_U) D  ; MA,MI,MM program checks
 . I ENPCI]"" D
 . . S ENX=$G(^OFM(7336.8,ENPCI,0))
 . . I $P(ENX,U)["NHCU" D
 . . . I $P($G(^ENG("PROJ",ENDA,53)),U,4)="" S ENS=1,ENMSG="NHCU AUTHORIZED BEDS required for PROJECT CATEGORY ("_$P(ENX,U)_")." D MSG
 ;
 S (ENI,ENX)=0 F  S ENI=$O(^ENG("PROJ",ENDA,57,ENI)) Q:'ENI  D
 . S ENX=ENX+$P($G(^ENG("PROJ",ENDA,57,ENI,0)),U,2)
 I ENX'=+$P(ENY52,U,5) S ENS=1,ENMSG="NHCU BEDS (CONVERTED) ("_$P(ENY52,U,5)_") not equal to sum of NHCU CONVERSION numbers ("_ENX_")." D MSG
 Q
MSG ; save message
 ; ENL(ENS) - last line used in array
 ; ENMSG    - messsage
 ; ENS      - severity (1,2) 1 invalid, 2 warning
 I ENV>ENS S ENV=ENS
 S ENL(ENS)=ENL(ENS)+1,^TMP($J,"V",ENDA,ENS,ENL(ENS),0)=ENMSG
 Q
 ;ENPLV7
