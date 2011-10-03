ENPLV2 ;(WIRMFO)/SAB-PROJECT VALIDATION, VALIDATE ONE ENTRY ;1/27/98
 ;;7.0;ENGINEERING;**23,28,49**;Aug 17, 1993
IN ; entry point to validate file 6925 entry
 ; input variables
 ;   ENDA - ien
 ;   ENTY - type of validation
 ;          F - Five Year Facility Plan
 ;          A - Application
 ;          R - Progress Report
 ;   ENFY   - current year of FYFP (only applies if ENTY="F")
 ;   ENXMIT - true if transmission checks should be done
 ; output variables
 ;   ENV  - result
 ;          1 - invalid
 ;          2 - valid with warnings
 ;          3 - valid
 ;   ^TMP($J,"V",ENDA,1,ENL(ENS),0) = invalid detail text (if any)
 ;   ^TMP($J,"V",ENDA,2,ENL(ENS),0) = warning detail text (if any)
 ;
 N ENBCI,ENFT,ENI,ENL,ENMCI,ENMSG,ENPCI,ENPN,ENPR,ENS,ENSTATI,ENX
 N ENY,ENY0,ENY1,ENY19,ENY52
 ;
 K ^TMP($J,"V",ENDA)
 S (ENL(1),ENL(2))=0
 S ENV=3 ; assume valid
 ;
 S ENY0=$G(^ENG("PROJ",ENDA,0)),ENY1=$G(^ENG("PROJ",ENDA,1))
 S ENY19=$G(^ENG("PROJ",ENDA,19)),ENY52=$G(^ENG("PROJ",ENDA,52))
 S ENPN=$P(ENY0,U) ; project number
 S ENMCI=$P(ENY0,U,4) ; medical center
 S ENPR=$P(ENY0,U,6) ; program
 S ENSTATI=$P(ENY1,U,3) ; status
 S ENPCI=$P(ENY52,U) ; project category
 S ENBCI=$P(ENY52,U,2) ; budget category
 S ENFT=$P(ENY52,U,6) ; facility type
 ;
 ; check required fields
 I $P(ENY0,U)="" S ENS=1,ENMSG="PROJECT NUMBER is required." D MSG
 I $P(ENY0,U,3)="" S ENS=1,ENMSG="PROJECT TITLE is required." D MSG
 I $P(ENY0,U,4)="" S ENS=1,ENMSG="MEDICAL CENTER is required." D MSG
 I $P(ENY1,U,3)="" S ENS=1,ENMSG="STATUS is required." D MSG
 I $P(ENY0,U,6)="" S ENS=1,ENMSG="PROGRAM is required." D MSG
 I $P(ENY52,U,6)="" S ENS=1,ENMSG="FACILITY TYPE is required." D MSG
 I $P(ENY52,U,1)="" S ENS=1,ENMSG="PROJECT CATEGORY is required." D MSG
 I $P(ENY52,U,2)="" S ENS=1,ENMSG="BUDGET CATEGORY is required." D MSG
 ;
 I ENPN]"" D  ; project number checks
 . I ENMCI]"" D
 . . S ENX=$E($$GET1^DIQ(4,ENMCI_",",99),1,3)
 . . I $P(ENPN,"-")'=ENX S ENS=2,ENMSG="MEDICAL CENTER's STATION NUMBER ("_ENX_") inconsistent with PROJECT NUMBER ("_ENPN_")." D MSG
 . I ENPR]"" D
 . . I "^NR^SL^LE^"[(U_ENPR_U),$L(ENPN,"-")'=3 S ENS=1,ENMSG="PROGRAM ("_ENPR_") inconsistent with format of PROJECT NUMBER ("_ENPN_")." D MSG
 . . I "^MA^MI^MM^"[(U_ENPR_U),$L(ENPN,"-")'=2 S ENS=1,ENMSG="PROGRAM ("_ENPR_") inconsistent with format of PROJECT NUMBER ("_ENPN_")." D MSG
 . I ENFT]"" D
 . . I "89"[$E(ENPN),ENFT'="NCS" S ENS=1,ENMSG="FACILITY TYPE is not NCS but PROJECT NUMBER begins with "_$E(ENPN)_"." D MSG
 . . I "89"'[$E(ENPN),ENFT="NCS" S ENS=1,ENMSG="FACILITY TYPE is NCS but PROJECT NUMBER begins with "_$E(ENPN)_"." D MSG
 ;
 I ENFT]"" D  ; facility type checks
 . I ENPR]"" D
 . . I ENFT="NCS","^MA^MI^SL^LE^"'[(U_ENPR_U) S ENS=1,ENMSG="PROGRAM ("_ENPR_") inconsistent with FACILITY TYPE ("_ENFT_")." D MSG
 . . I ENFT="VHA","^MA^MI^MM^NR^SL^LE^"'[(U_ENPR_U) S ENS=1,ENMSG="PROGRAM ("_ENPR_") inconsistent with FACILITY TYPE ("_ENFT_")." D MSG
 . . I ENFT="VBA","^MI^MM^NR^LE^"'[(U_ENPR_U) S ENS=1,ENMSG="PROGRAM ("_ENPR_") inconsistent with FACILITY TYPE ("_ENFT_")." D MSG
 . I ENPCI]"" D
 . . S ENX=$G(^OFM(7336.8,ENPCI,0)) I $P(ENX,U,6)'[ENFT S ENS=1,ENMSG="PROJECT CATEGORY ("_$P(ENX,U)_") inconsistent with FACILITY TYPE ("_ENFT_")." D MSG
 . I ENBCI]"" D
 . . S ENX=$G(^OFM(7336.9,ENBCI,0)) I $P(ENX,U,3)'[ENFT S ENS=1,ENMSG="BUDGET CATEGORY ("_$P(ENX,U)_") inconsistent with FACILITY TYPE ("_ENFT_")." D MSG
 ;
 D ^ENPLV3
 D:ENTY="F" ^ENPLV4
 D:ENTY="A" ^ENPLV5
 D:ENTY="R" ^ENPLV7
 ;
EX ;
 S:ENL(1) ^TMP($J,"V",ENDA,1,0)=U_U_ENL(1)_U_ENL(1)_U_DT
 S:ENL(2) ^TMP($J,"V",ENDA,2,0)=U_U_ENL(2)_U_ENL(2)_U_DT
 Q
MSG ; save message
 ; ENL(ENS) - last line used in array
 ; ENMSG    - messsage
 ; ENS      - severity (1,2) 1 invalid, 2 warning
 I ENV>ENS S ENV=ENS
 S ENL(ENS)=ENL(ENS)+1,^TMP($J,"V",ENDA,ENS,ENL(ENS),0)=ENMSG
 Q
 ;ENPLV2
