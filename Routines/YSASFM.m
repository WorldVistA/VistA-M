YSASFM ;ASF/ALB- FILEMAN ASI REPORTS ;4/9/98  13:45
 ;;5.01;MENTAL HEALTH;**24,30,32,37,38,55,76**;Dec 30, 1994
 Q
INTDATE ;interviewer by date
 N DIE,DIC,DR,DA,FLDS,L,TO,FR,BY,DHD,DIPCRIT,X,Y,YSINT
 D TOP("ASI Report by Interviewer")
 S DIC="^YSTX(604,",L=0,FLDS="!.02,.0209,.05,.04",BY="+.09,.05",DIPCRIT=1 D EN1^DIP
 Q
SINGLEI ;single interviewer
 N DIE,DIC,DR,DA,FLDS,L,TO,FR,BY,DHD,DIPCRIT,X,Y,YSINT
 D TOP("ASI Report by Single Interviewer")
 S DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Select ASI Interviewer: " D ^DIC Q:Y'>0  S YSINT=$P(Y,U,2)
 S DIC="^YSTX(604,",L=0,FLDS="!.02,.0209,.05,.04",BY="+.09,.05",DIPCRIT=1
 S FR(1)=YSINT,TO(1)=YSINT,FR(2)="?",TO(2)="?"
 D EN1^DIP
 Q
ALPHADT ; Name by date
 N DIE,DIC,DR,DA,FLDS,L,TO,FR,BY,DHD,DIPCRIT,X,Y,YSINT
 D TOP("ASI Report by Patient Name")
 S DIC="^YSTX(604,",L=0,FLDS="!.02;L30;C1,.0209;L10,.05;L12,.09;L20"
 S BY=".02,.05",DIPCRIT=1 D EN1^DIP
 Q
UNSIGN ;incomplete ASIs
 N DIE,DIC,DR,DA,FLDS,L,TO,FR,BY,DHD,DIPCRIT,X,Y,YSINT
 D TOP("Incomplete ASI Report")
 S DIC="^YSTX(604,",L=0,FLDS="!.02;L30;C1,.0209;L10,.05;L12,.09;L20"
 S BY="@.51,.05",FR="@,?",TO="@,?",DIPCRIT=1,DHD="Incomplete ASI Administrations" D EN1^DIP
 Q
DTORD ;date sort
 N DIE,DIC,DR,DA,FLDS,L,TO,FR,BY,DHD,DIPCRIT,X,Y,YSINT
 D TOP("ASI Report by Interview Date")
 S DIC="^YSTX(604,",L=0,FLDS="!.02;L30;C1,.0209;L10,.05;L12,.09;L20"
 S BY=".05,.02",DIPCRIT=1 D EN1^DIP
 Q
SSNORD ;order by SSN
 N DIE,DIC,DR,DA,FLDS,L,TO,FR,BY,DHD,DIPCRIT,X,Y,YSINT
 D TOP("ASI Report by Social Security Number")
 S DIC="^YSTX(604,",L=0,FLDS="!.0209;L10;C1,.02;L30,.05;L12,.04;L5,.51;L3"
 S BY=".0209,.05",FR=",?",TO=FR,DIPCRIT=1 D EN1^DIP
 Q
TOP(X) ;HEADING
 W @IOF,!?15,"***** ",X," *****",!,"please queue all reports",!
 Q
PARAM ;edit ASI Parameters file
 W @IOF,!,"***** Edit ASI Site Parameters *****",!
 S DIE="^YSTX(604.8,",DA=1,DR=".02:2"
 L +^YSTX(604.8,DA):9999 Q:'$T
 D ^DIE
 L -^YSTX(604.8,DA)
 Q
PROGRAM ;activate/inactivate programs
 N DIC,DIE,DR,DA,X,Y
 S DIC="^YSTX(604.26,",DIC(0)="AEQ" D ^DIC Q:Y'>0
 S DA=+Y,DIE=DIC,DR=3
 L +^YSTX(604.26,DA):9999 Q:'$T
 D ^DIE
 L -^YSTX(604.26,DA)
 G PROGRAM
 ;
CLEAR ; delete UNSIGNED ASI
 K ^TMP($J,"YSASI")
 D PT^YSASSEL
 Q:YSASPIEN<1
 W @IOF,?25,"***** ASI Deletion Utility ****"
 D TLD^YSASSEL,TLP^YSASSEL
 W !
 S DIR("A")="Select ASI number: " D ^DIR K DIR
 Q:Y'?1N.N
 S YSASSIEN=+^TMP($J,"YSASI",Y),YSASIG=$P(^TMP($J,"YSASI",Y),U,5)
 I YSASIG W !!,"This ASI is signed and deletion is not permitted!",$C(7) Q
 K DIR S DIR(0)="Y",DIR("A")="Are you sure you want to delete this ASI",DIR("B")="N" D ^DIR
 Q:Y'=1
 S DA=YSASSIEN,DIK="^YSTX(604," D ^DIK
 W !,"ASI deleted...."
 Q
DEFED ;default editor
 N YSASIEN,DIC,DIE,DA,YSFIELD,YSFDA
 W @IOF,?10,"*** ASI Default Editor ***",!
DEFED1 S DIC("A")="Select ASI Item: ",DIC="^YSTX(604.66,",DIC(0)="AEQM" D ^DIC
 Q:Y'>0
 S YSASIEN=+Y,YSFIELD=$P(^YSTX(604.66,YSASIEN,0),U,3)
 S YSFDA="^TMP($J,""YSASI"")"
 W !
 D HELP^DIE(604,"",YSFIELD,"A",YSFDA),MSG^DIALOG("WH","","","",YSFDA)
 S DIE="^YSTX(604.66,",DA=YSASIEN,DR=6
 L +^YSTX(604.66,DA):9999 Q:'$T
 D ^DIE
 L -^YSTX(604.66,DA)
 G DEFED1
