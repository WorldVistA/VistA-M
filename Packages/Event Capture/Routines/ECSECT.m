ECSECT ;BIR/MAM,JPW-Create DSS Units for Event Capture ;1 May 96
 ;;2.0; EVENT CAPTURE ;**4,5**;8 May 96
 ;
SECT ;entry
 S (MSG1,MSG2)=0
 W @IOF,!,"Enter/Edit DSS Units for Event Capture"
 W !!,?5,"If you elect to send data to PCE for DSS Unit, you must answer the",!,?5,"""Send to PCE"" prompt."
 W !! K DA,DIC S (ECOUT,ECJLP)=0,DIC=724,DLAYGO=724
 S DIC("S")="I $P(^(0),""^"",8)=1",DIC(0)="QEAMZL",DIC("DR")="1T;3T;2T",DIC("A")="Select DSS Unit: " D ^DIC S DIE=DIC K DIC,DLAYGO I Y<0 G END
 S ECDA=+Y D CHK I ECFLG W !!,"Cateories are "_$S($P($G(^ECD(+ECDA,0)),"^",11):"used",1:"not used")_" to group procedures. You have event codes screens defined",!,"and cannot change the use of categories.",!
 I $P(Y,"^",3) K DR,DA S DA=ECDA,DR=$S(ECFLG:"4T;7///1;11T;12T;13T",1:"4T;7///1;10T;11T;12T;13T") D ^DIE K DIE,DA,DR D SCCHK(ECDA) G:$D(Y) END G:$D(DTOUT) END D MSG G SECT
 D DIE G SECT
END ;D ^ECKILL W @IOF
 Q
REACT ; reactivate DSS Unit
 W !!,"This DSS Unit has been inactivated.",!!,"Would you like to reactivate it ?  YES//  " R ECYN:DTIME I '$T!(ECYN="^") S ECOUT=1 Q
 S ECYN=$E(ECYN) S:ECYN="" ECYN="Y" I "YyNn"'[ECYN W !!,"Enter <RET> to make this DSS Unit valid for use in the Event Capture",!,"software, or NO if this DSS Unit should remain inactive." G REACT
 I "Nn"[ECYN S ECOUT=1 Q
 K DIE,DR,DA S DIE=724,DR="5///0",DA=ECDA D ^DIE K DIE,DR,DA
 Q
DIE ; enter DSS Unit info
 S MSG1=1
 I $P($G(^ECD(ECDA,0)),"^",13)']"" S MSG2=1
 I $P(^ECD(ECDA,0),"^",6) D REACT I ECOUT Q
 K DIE,DR,DA
 S DA=ECDA,DIE=724,DLAYGO=724,DR=$S(ECFLG:".01T;1T;3T;2T;4T;7///1;11T;13T",1:".01T;1T;3T;2T;4T;7///1;10T;11T;13T")
 D ^DIE
 K DR,DIE,DLAYGO,DA
 ;
 D SCCHK(ECDA) ;* Check to prompt for Associated Stop Code
 ;
 ;* If sending to PCE, remove Associated Stop Code
 I $P(^ECD(ECDA,0),"^",14)'="",($P(^ECD(ECDA,0),"^",14)'="N") DO
 .S DA=ECDA,DIE=724,DR="9////@"
 .D ^DIE
 K ECDA,DA,DR,DIE
MSG W !!,"Press <RET> to continue " R X:DTIME
 Q
CHK ;loop thru screens
 S ECFLG=0
 S JJ=0 F  S JJ=$O(^ECJ("AP",JJ)) Q:'JJ!(ECFLG)  I $D(^ECJ("AP",JJ,ECDA)) S ECFLG=1
 Q
 ;
SCCHK(ECDA) ;** Check to see if sending to PCE
 I $P(^ECD(ECDA,0),"^",14)=""!($P(^ECD(ECDA,0),"^",14)="N") DO
 .S DA=ECDA,DIE=724,DR="9T"
 .D ^DIE
 Q
