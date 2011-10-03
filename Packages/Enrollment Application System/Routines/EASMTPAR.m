EASMTPAR ; ALB/SCK - EAS MT PARAMETER ENTRY/EDIT ; 11/9/01
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,15**;MAR 15,2001
 ;
WR ;  Write current parameters
 N EANODE,U,EASHD,LINE,SPACE,EAX,TAB,TAB2,IOP,EDT,DIRUT
 ;
 S U="^",IOP="HOME",TAB=5,TAB2=43
 D ^%ZIS K IOP
 ;
 S EASHD="EAS MEANS TEST LETTERS PARAMETER ENTRY/EDIT"
 S SPACE=(IOM-$L(EASHD))/2
 S $P(LINE,"=",IOM)=""
 ;
 W @IOF,!?SPACE,EASHD,!,LINE
 ;
 S EANODE=$G(^EAS(713,1,0))
 W !!,"[1]",?TAB,"Parameters"
 W !?TAB,"Primary Print Device:",?TAB2,": "
 I +$P($G(EANODE),U,5) W $$GET1^DIQ(3.5,$P(EANODE,U,5),.01)
 W !?TAB,"Allow Filtering by Location?",?TAB2,": ",$S($P(EANODE,U,8):"YES",1:"NO")
 W !?TAB,"Send Means Test Completion Notice?",?TAB2,": ",$S($P(EANODE,U,7):"YES",1:"NO")
 W !?TAB,"Envelope Offset",?TAB2,": ",+$$GET1^DIQ(713,1,10)
 W !?TAB,"Allow Alternate Return Address?",?TAB2,": ",$S($P(EANODE,U,9):"YES",1:"NO")
 ;
 S DIR(0)="YAO",DIR("A")="Edit Parameters? ",DIR("B")="YES",DIR("A",1)=""
 D ^DIR K DIR
 Q:$D(DIRUT)!('Y)
 I Y D EDT
 G WR
 Q
 ;
EDT ; Edit parameter set 1
 N DIE,DA,DR
 ;
 S DIE="^EAS(713,",DA=1
 S DR="5;8;7;10;9"
 D ^DIE K DIE
 Q
