PSODACT ;BHAM ISC/JrR - CREATE DUE ANSWER SHEET FROM ACTION PROFILE ; 11/18/92 18:58
 ;;7.0;OUTPATIENT PHARMACY;**2,326**;DEC 1997;Build 11
 Q
ENSAVE ;Enter here from PSOSD0 to store info about each DUE RX
 ;as Action Profile is printing. Needs RXNODE=NODE '0' OF RXN,RXN
 S PSOQDRG=$P(RXNODE,"^",6),PSOQDFN=$P(RXNODE,"^",2)
 I $D(^PS(50.073,"AD",PSOQDRG)),('$P(RXNODE,"^",15)!($P(RXNODE,"^",15)=5)) F PSOQ=0:0 S PSOQ=$O(^PS(50.073,"AD",PSOQDRG,PSOQ)) Q:'PSOQ  D
 .I $P(^PS(50.073,PSOQ,0),"^",2),$P(^(0),"^",3) F DIV=0:0 S DIV=$O(^PS(50.073,PSOQ,3,DIV)) Q:'DIV  I $P(^PS(50.073,PSOQ,3,DIV,0),"^")=$G(PSOSITE) D STORE
 K PSOQ,PSOQDRG,PSOQDFN,DIV
 QUIT
 ;return to ^PSOSD0
 ;
STORE S ^TMP("PSOD",$J,RXN,PSOQDRG,PSOQ,5)=$P(RXNODE,"^",4)
 S ^TMP("PSOD",$J,RXN,PSOQDRG,PSOQ,8)=PSOQDFN
 Q
 ;
ENSTUFF ;Enter here from PSOSD Action Profile
 ;Print an Answer sheet for DUE RXs stored at ENSAVE above
 NEW I,RXN
 Q:'$D(^TMP("PSOD",$J))
 F RXN=0:0 S RXN=$O(^TMP("PSOD",$J,RXN)) Q:'RXN  F PSOQDRG=0:0 S PSOQDRG=$O(^TMP("PSOD",$J,RXN,PSOQDRG)) Q:'PSOQDRG  F PSOQ=0:0 S PSOQ=$O(^TMP("PSOD",$J,RXN,PSOQDRG,PSOQ)) Q:'PSOQ  D PRINT
 K ^TMP("PSOD",$J) W:'$D(PSONOPG) @IOF
 K PSOQDRG,PSOQ,PSA,PIECE,FLAG,I,PSOQPHYS,DFN,SSN,PSIGN,PSOQL
 K PSOQDFN,PSOQM,PSOQSSN,PSQNUM,PSOQN,PSOQNUM,PSQ,PSTXT,PSWRAP,PSMARG
 QUIT
 ;return to ^PSOSD
 ;
SET ;This code is not being executed at this time.
 D NEW S PSA=+Y
 S $P(^PS(50.0731,PSA,0),"^",2,4)=PSOQ_"^"_PSOQDRG_"^"_RXN
 F PIECE=5,8 S $P(^PS(50.0731,PSA,0),"^",PIECE)=^TMP("PSOD",$J,RXN,PSOQDRG,PSOQ,PIECE)
MOVE S FLAG=0
 F I=0:0 S I=$O(^PS(50.073,PSOQ,2,I)) Q:'I  S:$D(^PS(50.0732,$P(^(I,0),"^",2),0)) ^PS(50.0731,PSA,1,I,0)=^PS(50.073,PSOQ,2,I,0),$P(^PS(50.0732,$P(^(0),"^",2),0),"^",7)=1,FLAG=1
 S:FLAG $P(^PS(50.073,PSOQ,0),"^",4)=1,^PS(50.0731,PSA,1,0)="^50.07311IA^"_$P(^PS(50.073,PSOQ,2,0),"^",3,4)
 S DIK="^PS(50.0731,",DA=PSA D IX^DIK K DIK,DA
 Q
 ;
NEW ;laygo into the DUE Answer file
 L +^PS(50.0731,0):20
 S X=$P(^PS(50.0731,0),"^",3)
LOOP S X=X+1 G:$D(^PS(50.0731,X)) LOOP L
 K DIC,DD,DO S DIC="^PS(50.0731,",DIC(0)="XL",DIC("DR")="6///NOW",DLAYGO=50.0731,DINUM=X D FILE^DICN
 K DIC,DLAYGO,DINUM
 L -^PS(50.0731,0)
 Q:$P(Y,"^",3)
 G NEW
 ;
PRINT ;prints DUE Questionnaire
 W @IOF,!!,@$S($G(PSORM)=0:"?25",1:"?52"),"***** Due Answer Sheet *****"
 W !!,"SEQ. Number: _______________",?($X+3),"Questionnaire: "_$P(^PS(50.073,PSOQ,0),"^"),@$S($G(PSORM)=0:"!",1:"?$X+3"),"Drug: "_$P(^PSDRUG(PSOQDRG,0),"^"),@$S($G(PSORM)=0:"?45",1:"?109"),"Rx #: "_$P(^PSRX(RXN,0),"^")
 S PSOQPHYS=$P($G(^VA(200,+$P(^PSRX(RXN,0),"^",4),0)),"^")
 W !!,"Rx Provider: ",$E(PSOQPHYS,1,20)
 S PSOQDFN=^TMP("PSOD",$J,RXN,PSOQDRG,PSOQ,8)
 W ?($X+3),"Patient: ",$P(^DPT(PSOQDFN,0),"^"),@$S($G(PSORM)=0:"!",1:"?$X+3"),?($X+3),"Section: ______________"
 W @$S($G(PSORM)=0:"?$X+3",1:"?109"),"Date: "
 S Y=DT D DT^DIQ
QOUT ;Enter here from ^PSODUE to print questions for Questionaire
 K PSOQL S $P(PSOQL,"-",$S($G(PSORM)=0:80,1:IOM))="" W !,PSOQL
 I $O(^PS(50.073,PSOQ,"N",0)) D NARATV,^DIWW K DIWF,DIWL,DIWR
 S PSIGN=0
 I $O(^PS(50.073,PSOQ,2,0)) F PSOQN=0:0 S PSOQN=$O(^PS(50.073,PSOQ,2,PSOQN)) Q:'PSOQN  S PSIGN=1,PSOQM=^(PSOQN,0) D:$P(PSOQM,"^",2)
 .S PSQNUM=+PSOQM,PSQ=$P(^PS(50.0732,$P(PSOQM,"^",2),0),"^") D WRAP^PSODEDT W !?($L(PSQNUM)+2),"Answer: ",! I $Y>(IOSL-7) W @IOF
 W:PSIGN ?(IOM-40),"Signature: __________________________",!
 Q
NARATV K ^UTILITY($J,"W") S DIWL=4,DIWR=$S($G(PSORM)=0:80,1:IOM),DIWF="WN" F PSOQN=0:0 S PSOQN=$O(^PS(50.073,PSOQ,"N",PSOQN)) Q:'PSOQN  S X=^(PSOQN,0) D ^DIWP
 Q
