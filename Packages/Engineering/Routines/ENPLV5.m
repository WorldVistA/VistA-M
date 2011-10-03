ENPLV5 ;(WASH ISC)/SAB-PROJECT VALIDATION, VALIDATE ONE ENTRY (cont) ;4/28/97
 ;;7.0;ENGINEERING;**23,28**;Aug 17, 1993
 ; project application specific checks
 I "^MA^MI^NR^"'[(U_ENPR_U) S ENS=1,ENMSG="PROGRAM ("_ENPR_") not supported for Project Applications." D MSG Q
 N ENY33,ENY55
 S ENY33=$G(^ENG("PROJ",ENDA,33)),ENY55=$G(^ENG("PROJ",ENDA,55))
 D ^ENPLV6
 ;
 I $P($G(^ENG("PROJ",ENDA,19)),U,7)>0,'$O(^ENG("PROJ",ENDA,54,0)) S ENS=1,ENMSG="IMPACT JUSTIFICATION required when IMPACT COST > 0." D MSG
 ; H089 Chapters
 S ENI=0 F  S ENI=$O(^ENG("PROJ",ENDA,22,ENI)) Q:'ENI  D
 . S ENY=$G(^ENG("PROJ",ENDA,22,ENI,0)) Q:ENY=""
 . S ENX=$$GET1^DIQ(7336.6,$P(ENY,U)_",",1) Q:ENX="999"
 . I $P(ENY,U,3)+$P(ENY,U,5)'>0 S ENS=1,ENMSG="No gross sq ft listed for H089 CHAPTER ("_ENX_")." D MSG
 I ENPR="NR" D
 . I $P(ENY52,U,7)="" S ENS=1,ENMSG="EPA REPORTABLE (y/n) required for NRM applications." D MSG
 . I $P(ENY52,U,7)="Y" D
 . . I $P(ENY52,U,8)="" S ENS=1,ENMSG="EPA REPORTING CATEGORY is required for EPA REPORTABLE (YES)." D MSG
 . . I $P(ENY52,U,8)]"",ENPCI]"" D
 . . . D VAL^DIE(6925,ENDA_",",158.7,"","`"_$P(ENY52,U,8),.ENX)
 . . . I ENX="^" S ENS=1,ENMSG="EPA REPORTING CATEGORY ("_$P($G(^ENG(6925.3,$P(ENY52,U,8),0)),U)_") inconsistent with PROJECT CATEGORY ("_$P($G(^OFM(7336.8,ENPCI,0)),U)_")." D MSG
 I ENXMIT D
 . I "^MA^MI^MM^NR^"[(U_ENPR_U) D
 . . I ";5;6;8;9;10;11;12;13;14;15"'[(";"_ENSTATI_";") S ENS=1,ENMSG="STATUS ("_$$EXTERNAL^DILFD(6925,6,"",ENSTATI)_") inappropriate for project application." D MSG
 . I "^LE^"[(U_ENPR_U),";5;"'[(";"_ENSTATI_";") S ENS=1,ENMSG="STATUS ("_$$EXTERNAL^DILFD(6925,6,"",ENSTATI)_") inappropriate for project application." D MSG
 . I $P(ENY33,U)'="Y" S ENS=1,ENMSG="Project Application must be approved by Chief Engineer." D MSG
 . I $P(ENY33,U)="Y",$$FMDIFF^XLFDT(DT,$P(ENY33,U,3),1)>182 S ENS=1,ENMSG="Chief Engineer approval date ("_$$FMTE^XLFDT($P(ENY33,U,3),"D")_") is over 6 months old." D MSG
 . I $P(ENY33,U,4)'="Y" S ENS=1,ENMSG="Project Application must be approved by VAMC Director." D MSG
 . I $P(ENY33,U,4)="Y",$$FMDIFF^XLFDT(DT,$P(ENY33,U,6),1)>182 S ENS=1,ENMSG="VAMC Director approval date ("_$$FMTE^XLFDT($P(ENY33,U,6),"D")_") is over 6 months old." D MSG
 Q
MSG ; save message
 ; ENL(ENS) - last line used in array
 ; ENMSG    - messsage
 ; ENS      - severity (1,2) 1 invalid, 2 warning
 I ENV>ENS S ENV=ENS
 S ENL(ENS)=ENL(ENS)+1,^TMP($J,"V",ENDA,ENS,ENL(ENS),0)=ENMSG
 Q
 ;ENPL5
