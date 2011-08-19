ENPLV6 ;(WASH ISC)/SAB-PROJECT VALIDATION, VALIDATE ONE ENTRY (cont) ;11/27/95
 ;;7.0;ENGINEERING;**23,28**;Aug 17, 1993
 ; Project Planning (FYFP, APPL) specific checks
 ; check required fields
 I '$P($G(^ENG("PROJ",ENDA,17,0)),U,4) S ENS=1,ENMSG="PROJECT DESCRIPTION (SHORT) is required." D MSG
 I '$P($G(^ENG("PROJ",ENDA,26,0)),U,4) S ENS=1,ENMSG="JUSTIFICATION (SHORT) is required." D MSG
 ;
 I "^NR^"[(U_ENPR_U) D  ; NRM program checks
 . I $P(ENY52,U,9)]"" D
 . . S ENX=$P($G(^OFM(7336.8,$P(ENY52,U,9),0)),U)
 . . I ENX="AMBULATORY CARE",$P(ENY52,U,10)<50 S ENS=1,ENMSG="AMBULATORY CARE PERCENTAGE ("_$P(ENY52,U,10)_") inconsistent with BONUS CATEGORY ("_ENX_")." D MSG
 ;
 I "^MA^MI^MM^NR^SL^"[(U_ENPR_U) D  ; construction checks
 . S ENX=$P($G(^ENG("PROJ",ENDA,24)),U)
 . I ENX]"",$P(ENY0,U,7)]"",ENX<$P(ENY0,U,7) S ENS=1,ENMSG="ACTIVATION YEAR ("_ENX_") is before FUNDING YEAR - CONST ("_$P(ENY0,U,7)_")." D MSG
 ;
 I "^LE^"[(U_ENPR_U) D  ; lease checks
 . I $P(ENY55,U)="" S ENS=1,ENMSG="LEASE TYPE is required." D MSG
 . I $P(ENY55,U,5)="" S ENS=1,ENMSG="ESTIMATED ANNUAL RENT COST is required." D MSG
 . I $P(ENY55,U,6)="" S ENS=1,ENMSG="PROPOSED LEASE TERM is required." D MSG
 . I $P(ENY55,U,7)="" S ENS=1,ENMSG="RENTABLE SQ FT is required." D MSG
 . I "^NE^SU^"[(U_$P(ENY55,U)_U) D
 . . I $P(ENY55,U,8)="" S ENS=1,ENMSG="EXISTING SPACE ANNUAL RENT is required for LEASE TYPE ("_$$EXTERNAL^DILFD(6925,285,"",$P(ENY55,U))_")." D MSG
 . . I $P(ENY55,U,9)="" S ENS=1,ENMSG="EXISTING SPACE RENTABLE SQ FT is required for LEASE TYPE ("_$$EXTERNAL^DILFD(6925,285,"",$P(ENY55,U))_")." D MSG
 . I ENBCI]"" D
 . . S ENX=$P($G(^OFM(7336.9,ENBCI,0)),U)
 . . I $P(ENY55,U)="EU"!(ENX="ENHANCED USE"),$P(ENY55,U)'="EU"!(ENX'="ENHANCED USE") S ENS=1,ENMSG="LEASE TYPE ("_$$EXTERNAL^DILFD(6925,285,"",$P(ENY55,U))_") inconsistent with BUDGET CATEGORY ("_ENX_")." D MSG
 . S ENX=$P($G(^ENG("PROJ",ENDA,24)),U)
 . I ENX]"",$P(ENY55,U,3)]"",ENX<$P(ENY55,U,3) S ENS=1,ENMSG="ACTIVATION YEAR ("_ENX_") is before FY - RENT STARTS ("_$P(ENY55,U,3)_")." D MSG
 Q
MSG ; save message
 ; ENL(ENS) - last line used in array
 ; ENMSG    - messsage
 ; ENS      - severity (1,2) 1 invalid, 2 warning
 I ENV>ENS S ENV=ENS
 S ENL(ENS)=ENL(ENS)+1,^TMP($J,"V",ENDA,ENS,ENL(ENS),0)=ENMSG
 Q
 ;ENPLV6
