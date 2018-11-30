YSASFM ;ASF/ALB,HIOFO/FT - FILEMAN ASI REPORTS ;2/5/13  1:28pm
 ;;5.01;MENTAL HEALTH;**24,30,32,37,38,55,76,108**;Dec 30, 1994;Build 17
 ;Reference to ^VA(200, supported by DBIA #10060
 Q
INTDATE ;interviewer by date
 ;entry point for YSAS ASI INTERVIEWER REPORT option
 N DIE,DIC,DR,DA,FLDS,L,TO,FR,BY,DHD,DIPCRIT,X,Y,YSINT
 D TOP("ASI Report by Interviewer")
 S DIC="^YSTX(604,",L=0,FLDS="[YS ASI INTERVIEWER BY DATE]",BY="+.09,.05",DIPCRIT=1 D EN1^DIP
 Q
SINGLEI ;single interviewer
 ;entry point for YSAS ASI SINGLE INTERVIEWER option
 N DIE,DIC,DR,DA,FLDS,L,TO,FR,BY,DHD,DIPCRIT,X,Y,YSINT
 D TOP("ASI Report by Single Interviewer")
 S DIC="^VA(200,",DIC(0)="AEMQ",DIC("A")="Select ASI Interviewer: " D ^DIC Q:Y'>0  S YSINT=$P(Y,U,2)
 S DIC="^YSTX(604,",L=0,FLDS="[YS ASI INTERVIEWER BY DATE]",BY="+.09,.05",DIPCRIT=1
 S FR(1)=YSINT,TO(1)=YSINT,FR(2)="?",TO(2)="?"
 D EN1^DIP
 Q
ALPHADT ; Name by date
 ;entry point for YSAS ASI BY PATIENT option
 N DIE,DIC,DR,DA,FLDS,L,TO,FR,BY,DHD,DIPCRIT,X,Y,YSINT
 D TOP("ASI Report by Patient Name")
 S DIC="^YSTX(604,",L=0,FLDS="[YS ASI NAME BY DATE]"
 S BY=".02,.05",DIPCRIT=1 D EN1^DIP
 Q
UNSIGN ;incomplete ASIs
 ;entry point for YSAS ASI INCOMPLETE option
 N DIE,DIC,DR,DA,FLDS,L,TO,FR,BY,DHD,DIPCRIT,X,Y,YSINT
 D TOP("Incomplete ASI Report")
 S DIC="^YSTX(604,",L=0,FLDS="[YS ASI NAME BY DATE]"
 S BY="@.51,.05",FR="@,?",TO="@,?",DIPCRIT=1,DHD="Incomplete ASI Administrations" D EN1^DIP
 Q
DTORD ;date sort
 ;entry point for YSAS ASI DATE ORDER option
 N DIE,DIC,DR,DA,FLDS,L,TO,FR,BY,DHD,DIPCRIT,X,Y,YSINT
 D TOP("ASI Report by Interview Date")
 S DIC="^YSTX(604,",L=0,FLDS="[YS ASI NAME BY DATE]"
 S BY=".05,.02",DIPCRIT=1 D EN1^DIP
 Q
SSNORD ;order by SSN
 ;entry point for YSAS ASI SSN ORDER option 
 N DIE,DIC,DR,DA,FLDS,L,TO,FR,BY,DHD,DIPCRIT,X,Y,YSINT
 D TOP("ASI Report by Social Security Number")
 S DIC="^YSTX(604,",L=0,FLDS="[YS ASI BY SSN]"
 S BY="@.0209,.05",FR=",?",TO=FR,DIPCRIT=1 D EN1^DIP
 Q
TOP(X) ;HEADING
 W @IOF,!?15,"***** ",X," *****",!,"please queue all reports",!
 Q
PARAM ;edit ASI Parameters file
 ;entry point for YSAS ASI PARAMETERS option
 W @IOF,!,"***** Edit ASI Site Parameters *****",!
 S DIE="^YSTX(604.8,",DA=1,DR=".02:2"
 L +^YSTX(604.8,DA):9999 Q:'$T
 D ^DIE
 L -^YSTX(604.8,DA)
 Q
PROGRAM ;activate/inactivate programs
 ;entry point for YSAS ASI PROGRAM ACTIVATION option
 N DIC,DIE,DR,DA,X,Y
 S DIC="^YSTX(604.26,",DIC(0)="AEQ" D ^DIC Q:Y'>0
 S DA=+Y,DIE=DIC,DR=3
 L +^YSTX(604.26,DA):9999 Q:'$T
 D ^DIE
 L -^YSTX(604.26,DA)
 G PROGRAM
 ;
CLEAR ; delete UNSIGNED ASI
 ;entry point for YSAS ASI DATA DELETION option 
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
 ;entry point for YSAS ASI DEFAULT EDITOR option
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
