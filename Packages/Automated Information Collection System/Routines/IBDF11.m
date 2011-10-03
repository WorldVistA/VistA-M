IBDF11 ;ALB/CJM - ENCOUNTER FORM - (print manager setup) ;April 20,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
CLNCSUP ;edit clinic setup for print manager
 N CLINIC
 K DIR S DIR(0)="409.95,.01",DIR("A")="EDIT REPORTS TO PRINT FOR WHICH CLINIC?"
 D ^DIR K DIR
 Q:$D(DIRUT)!(+Y<0)
 S CLINIC=+Y
 K DA S DA=$O(^SD(409.95,"B",CLINIC,"")) I 'DA D
 .K DIC,DO,DD,DINUM S DIC="^SD(409.95,",DIC(0)="",X=CLINIC
 .D FILE^DICN K DIC
 .S DA=$S(+Y<1:0,1:+Y)
 Q:'DA
 K DIE,DR S DIE=409.95
 S DR="[IBDF PRINT MANAGER]" D ^DIE K DIE,DR,DA
 Q
DIVSUP ;edit division setup for print manager
 N DIVISION
 W !!,"You can now select reports that should be printed for the entire division",!
 K DIR S DIR(0)="409.96,.01",DIR("A")="EDIT REPORTS TO PRINT FOR WHICH DIVISION?"
 D ^DIR K DIR
 Q:$D(DIRUT)!(+Y<0)
 S DIVISION=+Y
 K DA S DA=$O(^SD(409.96,"B",DIVISION,"")) I 'DA D
 .K DIC,DO,DD,DINUM S DIC="^SD(409.96,",DIC(0)="",X=DIVISION
 .D FILE^DICN K DIC
 .S DA=$S(+Y<1:0,1:+Y)
 Q:'DA
 K DIE,DR S DIE=409.96
 S DR="[IBDF PRINT MANAGER]" D ^DIE K DIE,DR,DA
 Q
EDITRPRT(HLTHSMRY) ;edit package interface,type=report
 ;HLTHSMRY=1 if report type is health summary, 0 otherwise
 N REPORT,IBDELETE,IBNEW,DLAYGO
 S HLTHSMRY=+$G(HLTHSMRY)
 W !!,"You can now edit the "_$S(HLTHSMRY:"Health Summaries",1:"reports")_" available through the print manager.",!
 D:'HLTHSMRY INFO^IBDF11A
 K DIC S DIC=357.6,DIC(0)="AELMQ",DIC("S")="I $P($G(^(0)),U,6)=4,"_$S(HLTHSMRY:"$P($G(^(0)),U,10)",1:"'$P($G(^(0)),U,10)"),DLAYGO=357.6
 S DIC("A")="Select a "_$S(HLTHSMRY:"Health Summary",1:"report")_" defined to the print manager: "
 S:HLTHSMRY DLAYGO=357.6
 D ^DIC K DIC
 Q:+Y<0
 S REPORT=+Y,IBNEW=$P(Y,"^",3)
 S IBDELETE=$S(IBNEW:1,1:0)
 S DA=REPORT
 K DIE,DR S DIE=357.6,DR=$S(HLTHSMRY:"[IBDF EDIT AVAILABLE HLTH SMRY]",1:"[IBDF EDIT AVAILABLE REPORT]"),DIE("NO^")="BACKOUTOK"
 D ^DIE K DIE,DR,DA
 I IBDELETE K DA S DIK="^IBE(357.6,",DA=REPORT D ^DIK K DIK,DA
 Q
CLNCSUP2 ;entry point to be called by an action protocol
 D FULL^VALM1
 D CLNCSUP
 S VALMBCK="R"
 Q
DIVSUP2 ;entry point to be called by an action protocol
 D FULL^VALM1
 D DIVSUP
 S VALMBCK="R"
 Q
