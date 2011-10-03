DGYRCOV ;ALB/CAW - Convert MT pointer from 408.21 to 408.22;10/27/94
 ;;5.3;Registration;**45**;Aug 13, 1993
 ;
GETREL ; Get all active relations for that year
 N CNT,DEP,DGDATE,DGERR,DGMT,DGINC,DGINI,DGIRI,DGMTI,DGREL,DFN,DATE,INC,INR,FLAG,FLAG1
 S (DGMT,CNT)=0
 F  S DGMT=$O(^DGMT(408.31,DGMT)) Q:'DGMT  S DGMTI=^(DGMT,0) D
 .S CNT=CNT+1
 .K FLAG
 .I '$P(DGMTI,U)!'$P(DGMTI,U,2) S ^TMP("DGMTERR",$J,DGMT)="" Q
 .S DFN=$P(DGMTI,U,2)
 .S DATE=$P(DGMTI,U)
 .D GETREL^DGMTU11(DFN,"VSC",DATE) Q:'$G(DGREL("V"))
 .D GETIENS^DGMTU2(DFN,+DGREL("V"),DATE) I $G(DGINI),$G(DGIRI) D DIE
 .I $G(DGREL("S")) D GETIENS^DGMTU2(DFN,+DGREL("S"),DATE) I $G(DGINI),$G(DGIRI) D DIE
 .S DEP=0 F  S DEP=$O(DGREL("C",DEP)) Q:'DEP  D
 ..D GETIENS^DGMTU2(DFN,+DGREL("C",DEP),DATE) I $G(DGINI),$G(DGIRI) D DIE
 .I '(CNT#100) W "."
 ;
 ; Fix any remaining pointers
 N DGMT,DGINC
 S DGMT=0 F  S DGMT=$O(^DGMT(408.21,"AM",DGMT)) Q:'DGMT  D
 .S DGINC=0 F  S DGINC=$O(^DGMT(408.21,"AM",DGMT,DGINC)) Q:'DGINC  D
 ..S DA=DGINC,DIE="^DGMT(408.21,",DR="31////@" D ^DIE K DA,DIE,DR
 K ^DGMT(408.21,"AM")
 ; Report any errors
 G:'$D(^TMP("DGMTERR",$J)) GETRELQ
 W !!,"The following are errors noted in the ANNUAL MEANS TEST file."
 W !,"The patient is missing from the file (field .02)"
 N ERR S ERR=0
 F  S ERR=$O(^TMP("DGMTERR",$J,ERR)) Q:'ERR  W !,"Means Test Internal File Number: "_ERR
 K ^TMP("DGMTERR",$J)
GETRELQ Q
 ;
DIE ;Set MT pointer in 408.22
 ;Delete MT pointer from 408.21
 S DA=DGIRI,DIE="^DGMT(408.22,",DR="31////"_DGMT D ^DIE K DA,DIE,DR
 S DA=DGINI,DIE="^DGMT(408.21,",DR="31////@" D ^DIE K DA,DIE,DR
 Q
