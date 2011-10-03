ENPLV ;WISC/SAB-PROJECT VALIDATION, VALIDATE LIST ;7/10/95
 ;;7.0;ENGINEERING;**23**;Aug 17, 1993
EN(ENTY,ENXMIT) ; Validate Projects (entry point with list)
 ; input variables
 ;   ENTY   - type of validation
 ;   ENXMIT - (optional) flag, true for additional transmission checks
 ;   ^TMP($J,"L")=number of projects^current year of FYFP when ENTY="F"
 ;   ^TMP($J,"L",project number)=ien
 ; output variables
 ;   ^TMP($J,"L")=
 ;        number of projects^current year of FYFP when ENTY="F"^
 ;        number invalid^number valid with warn^number valid (no warn)
 ;   ^TMP($J,"L",project number)=ien^validation code for project
 ;     where validation code = 1 (invalid), 2 (valid w/ warn), 3 (valid)
 ;
 N ENC,ENDA,ENFY,ENPN,ENV
 S ENXMIT=$G(ENXMIT)
 S (ENC(0),ENC(1),ENC(2),ENC(3))=0
 S:ENTY="F" ENFY=$P(^TMP($J,"L"),U,2)
 ; validate projects
 W !,"Validating Projects"
 S ENPN=""
 F  S ENPN=$O(^TMP($J,"L",ENPN)) Q:ENPN=""  S ENDA=$P(^(ENPN),U) D ^ENPLV2 S ENC(0)=ENC(0)+1,ENC(ENV)=ENC(ENV)+1,$P(^TMP($J,"L",ENPN),U,2)=ENV W "."
 S $P(^TMP($J,"L"),U,3,5)=ENC(1)_U_ENC(2)_U_ENC(3)
 ; report results
 I ENC(3)=ENC(0) W !,"No validation problems found" G EX
 I ENC(0)=1 W !,"This project ",$S(ENC(1):"failed",1:"passed")," the validation checks",$S(ENC(1):"",1:" with warnings"),"."
 I ENC(0)>1,ENC(1) W !,ENC(1)," out of ",ENC(0)," selected projects failed the validation checks."
 I ENC(0)>1,ENC(2) W !,ENC(2)," out of ",ENC(0)," selected projects passed the validation checks with warnings."
 S DIR(0)="Y",DIR("A")="Do you want a detailed report",DIR("B")="YES"
 D ^DIR K DIR G:$D(DIRUT) EX
 I Y D ^ENPLV1
 ;
EX ; Exit
 W !
 K ^TMP($J,"V")
 K DIC,DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y
 Q
 ;ENPLV
