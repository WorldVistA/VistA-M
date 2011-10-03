ENPLV3 ;(WIRMFO)/SAB-PROJECT VALIDATION, VALIDATE ONE ENTRY (cont) ;2/2/1998
 ;;7.0;ENGINEERING;**23,28,49**;Aug 17, 1993
 ;
 I ENPR]"" D  ; program checks
 . I ENPCI]"" D
 . . S ENX=$G(^OFM(7336.8,ENPCI,0))
 . . I $P(ENX,U,2)'[ENPR S ENS=1,ENMSG="PROJECT CATEGORY ("_$P(ENX,U)_") inconsistent with PROGRAM ("_ENPR_")." D MSG
 . I ENBCI]"" D
 . . S ENX=$G(^OFM(7336.9,ENBCI,0)) I $P(ENX,U,2)'[ENPR S ENS=1,ENMSG="BUDGET CATEGORY ("_$P(ENX,U)_") inconsistent with PROGRAM ("_ENPR_")." D MSG
 . I ENSTATI]"" D
 . . S ENX=$G(^ENG(6925.2,ENSTATI,0)) I $P(ENX,U,5)'[ENPR S ENS=1,ENMSG="STATUS ("_$P(ENX,U)_") inconsistent with PROGRAM ("_ENPR_")." D MSG
 ;
 I "^NR^"[(U_ENPR_U) D  ; NRM program checks
 . I $P(ENY0,U,7)="",ENPCI]"" S ENX=$P($G(^OFM(7336.8,ENPCI,0)),U) I ENX'="CONSULTANT STUDY" S ENS=1,ENMSG="FUNDING YEAR - CONST required for PROGRAM ("_ENPR_") and PROJECT CATEGORY ("_ENX_")." D MSG
 ;
 I "^NR^SL^"[(U_ENPR_U) D  ; NRM, STATION LEVEL program checks
 . I $P(ENY52,U,9)="",ENFT'="NCS" S ENS=1,ENMSG="BONUS CATEGORY is required for PROGRAM ("_ENPR_")" D MSG
 . I $P(ENY52,U,9)]"" D
 . . S ENX=$P($G(^OFM(7336.8,$P(ENY52,U,9),0)),U)
 . . I ENX["NHCU" D
 . . . I $P(ENY52,U,3)="" S ENS=1,ENMSG="NHCU BEDS (NEW) required for BONUS CATEGORY ("_ENX_")." D MSG
 . . . I $P(ENY52,U,4)="" S ENS=1,ENMSG="NHCU BEDS (RENOVATED) required for BONUS CATEGORY ("_ENX_")." D MSG
 . . . I $P(ENY52,U,5)="" S ENS=1,ENMSG="NHCU BEDS (CONVERTED) required for BONUS CATEGORY ("_ENX_")." D MSG
 ;
 I "^MA^MI^MM^"[(U_ENPR_U) D  ; MA,MI,MM program checks
 . I ENPCI]"" D
 . . S ENX=$G(^OFM(7336.8,ENPCI,0))
 . . I $P(ENX,U)["NHCU" D
 . . . I $P(ENY52,U,3)="" S ENS=1,ENMSG="NHCU BEDS (NEW) required for PROJECT CATEGORY ("_$P(ENX,U)_")." D MSG
 . . . I $P(ENY52,U,4)="" S ENS=1,ENMSG="NHCU BEDS (RENOVATED) required for PROJECT CATEGORY ("_$P(ENX,U)_")." D MSG
 . . . I $P(ENY52,U,5)="" S ENS=1,ENMSG="NHCU BEDS (CONVERTED) required for PROJECT CATEGORY ("_$P(ENX,U)_")." D MSG
 . I $P(ENY0,U,7)="" S ENS=1,ENMSG="FUNDING YEAR - CONST required for PROGRAM ("_ENPR_")." D MSG
 ;
 Q
MSG ; save message
 ; ENL(ENS) - last line used in array
 ; ENMSG    - messsage
 ; ENS      - severity (1,2) 1 invalid, 2 warning
 I ENV>ENS S ENV=ENS
 S ENL(ENS)=ENL(ENS)+1,^TMP($J,"V",ENDA,ENS,ENL(ENS),0)=ENMSG
 Q
 ;ENPLV3
