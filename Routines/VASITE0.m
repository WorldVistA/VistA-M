VASITE0 ;ALB/AAS - ENTER/EDIT TIME SENSITIVE STATION NUMBER FILE ;11-FEB-92
 ;;5.3;Registration;;Aug 13, 1993
 ;
% S U="^"
ADD ;  -entry to add new time sensitive entries
 S DIR(0)="DO",DIR("A")="Select EFFECTIVE DATE",DIR("??")="^D HELP^VASITE0"
 ;S:$D(VADT) DIR("B")=$$DATE(VADT)
 D ^DIR K DIR G:Y<1 END S VADT=+Y W "    ",$$DATE(VADT)
 ;
DIV S DIR(0)="PO^40.8:AEMQ",DIR("A")="Select MEDICAL CENTER DIVISION",DIR("??")="^D HELP1^VASITE0"
 S:$D(VADIV) DIR("B")=$P($G(^DG(40.8,+VADIV,0)),"^")
 D ^DIR K DIR G:Y<1 ADD S VADIV=+Y
 ;
 I $D(^VA(389.9,"AIVDT",VADIV,-VADT)) S X=VADIV,DIC(0)="EMQF",DIC="^VA(389.9,",DIC("S")="I $P(^(0),U,3)=VADIV,$P(^(0),U,2)=VADT" D ^DIC K DIC Q:Y<1  S DA=+Y D EDIT G ADDQ
 W !,"Filing New Entry!",! D FILE,EDIT:$D(DA)
ADDQ K VADT,VADIV
 G ADD
END K VADT,VADIV,DIR,Y,X
 Q
 ;
FILE ;  -add new entry
 L +^VA(389.9,0):10 I '$T W !,"Another user Editing, Try Again later" G FILEQ
 S X=$P($G(^VA(389.9,0)),"^",3)+1
 K DD,DO,DIC,DR S DIC="^VA(389.9,",DIC(0)="L",DLAYGO=389.9
 F X=X:1 I X>0,'$D(^VA(389.9,X)) L +^VA(389.9,X):1 I $T,'$D(^VA(389.9,X)) S DINUM=X D FILE^DICN I +Y>0 Q
 S VAN=+Y,DIE="^VA(389.9,",DA=VAN,DR=".02////"_VADT_";.03////"_VADIV D ^DIE
 L -^VA(389.9,0),-^VA(389.9,VAN)
FILEQ K DR,DIC,DIE,X,Y,DO,DD,DINUM
 Q
 ;
EDIT ;  -Edit entry
 ;  input variable DA
 S DIE="^VA(389.9,",DR=".01;.02;.03;.04//"_$P($G(^DIC(4,+$P(^DG(40.8,+VADIV,0),"^",7),99)),"^")_";.05;.06:" D ^DIE
 W ! K DIC,DIE,DR,DA,Y,X
 Q
 ;
HELP ;
 W !!,"You may enter a new EFFECTIVE DATE or select from one of the following:"
 S VAI=0 F  S VAI=$O(^VA(389.9,"E",VAI)) Q:'VAI  S VAJ=0 F  S VAJ=$O(^VA(389.9,"E",VAI,VAJ)) Q:'VAJ  W !?4,$$DATE(VAI),?20,$E($P($G(^DG(40.8,+$P($G(^VA(389.9,VAJ,0)),"^",3),0)),"^"),1,25),?48,$P($G(^VA(389.9,VAJ,0)),"^",4)
 K VAI Q
 ;
HELP1 ;
 W !!,"Select from the following Divisions"
 S VAI=0 F  S VAI=$O(^VA(389.9,"C",VAI)) Q:VAI=""  W !?4,VAI
 K VAI Q
DATE(Y) ;  convert date to external format
 D D^DIQ
 Q Y
