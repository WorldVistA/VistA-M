PSODIV ;BHAM ISC/SAB - DIVISION LOOKUP AND CHECKS ; 08/20/92 9:11
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
START W ! S PSOCNT=0 F I=0:0 S I=$O(^PS(59,I)) Q:'I  S PSOCNT=PSOCNT+1
 I 'PSOCNT W !,$C(7)," NO SITES HAVE BEEN DEFINED!" Q
 I PSOCNT=1 W !!,$C(7),"  Only one site is defined. 'INTERDIVISIONAL' processing is not applicable." Q
 S PSOSYS=^PS(59.7,1,40.1),DIR("A",1)="Currently 'INTERDIVISIONAL' processing 'is"_$S('+$P(PSOSYS,"^",2):" not",1:"")_"' allowed.",DIR("A")="    Do you want to change this? : ",DIR("B")="N",DIR(0)="SA^1:YES;0:NO"
 S DIR("?")="^D SYN^PSODIV" D ^DIR G:$D(DTOUT)!($D(DUOUT))!($D(DIROUT))!($D(DIRUT)) END
 I +$P(PSOSYS,"^",2),'Y G ANS2
 I '+$P(PSOSYS,"^",2),Y S $P(PSOSYS,"^",2)=1 W !,"'INTERDIVISIONAL PROCESSING' is initialized.",!
 E  S $P(PSOSYS,"^",2)="",$P(PSOSYS,"^",3)="",$P(PSOSYS,"^",4)="",^PS(59.7,1,40.1)=PSOSYS G END
ANS2 K DIR W ! S DIR("A",1)=" This question involves the following prompt:",DIR("A",2)=" ",DIR("A",3)="'RX is from another division.  Continue? (Y/N)'"
 S DIR("A",4)=" ",DIR("A",5)="Do you want this prompt to appear"
 S DIR("A")="whenever an action is attempted on the prescription: ",DIR("B")=$S($P($G(PSOSYS),"^",3):"Y",1:"N"),DIR(0)="SA^1:YES;0:NO"
 S DIR("?")="^D SYN^PSODIV" D ^DIR G:$D(DTOUT)!($D(DUOUT))!($D(DIROUT))!($D(DIRUT)) END
 S $P(PSOSYS,"^",3)=Y,^PS(59.7,1,40.1)=PSOSYS
 W !! K DIR S DIR("A",1)="Do you want all refill request forms to be processed",DIR("A")="at a particular division?: "
 S DIR("B")=$S($P(PSOSYS,"^",4):"Y",1:"N"),DIR(0)="SA^1:YES;0:NO"
 S DIR("?")="^D SYN^PSODIV" D ^DIR G:$D(DTOUT)!($D(DUOUT))!($D(DIROUT))!($D(DIRUT)) END I 'Y S $P(^PS(59.7,1,40.1),"^",4)="" G END
DIV W ! S DIC("B")=$S($P($G(^PS(59.7,1,40.1)),"^",4):$P(^PS(59,$P(^PS(59.7,1,40.1),"^",4),0),"^"),1:""),DIC=59,DIC(0)="AEMQ",DIC("A")="Choose REFILL division: " D ^DIC K DIC G:"^"[X NS I Y<0 W !!,$C(7),"You must choose a division" G DIV
 S $P(PSOSYS,"^",4)=+Y,$P(^PS(59.7,1,40.1),"^",4)=+Y G END
NS W !!,"Default Division not "_$S('$P(PSOSYS,"^",4):"Added",1:"Changed")_".",!
END W !!,$C(7),"Initialization of 'INTERDIVISIONAL PROCESSING' is complete." K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,X,Y,PSOCNT Q
SYN W !,$C(7),"  ...Please answer 'Yes' or 'No'!!",!
 Q
