SDWLCU3 ;IOFO BAY PINES/DMR - EWL FILE 409.3 CLEANUP ;2/4/03
 ;;5.3;scheduling;**280,491**;AUG 13 1993;Build 53
 ;
 ;modify update of 409.32 and related 409.3 with a proper institution set up in file 44
 ;through the division path
 ;
3 ;service specialty edit
 S SDWLSS="",SDWLINS="",SDWLERR=""
 F  S SDWLINS=$O(^TMP($J,"SDWLCU1",SDWLTY,SDWLINS)) Q:SDWLINS=""  D  Q:SDWLERR=1
 .F  S SDWLSS=$O(^TMP($J,"SDWLCU1",SDWLTY,SDWLINS,SDWLSS)) Q:SDWLSS=""  D  Q:SDWLERR=1
 ..I '$D(SDWLSSV) S SDWLSSV=SDWLSS
 ..S NAME=$$GET1^DIQ(4,SDWLINS_",",.01)
 ..S SDWLSSN=$P(^SDWL(409.31,SDWLSS,0),U,1)
 ..W !,"SERVICE SPECIALTY: ",$$GET1^DIQ(40.7,SDWLSSN_",",.01),"   INSTITUTION: ",NAME
 ..S SDWLSSX=$O(^SDWL(409.31,SDWLSS,"I","B",SDWLINS,0)) D:SDWLSSX'="" SEL
 S WLTC3=""
 Q
SEL ;select new Insitition
 N DIR
 S DIR("A")="Select Institution: "
 S DIR(0)="PAO^4:EMZ",DIR("S")="I $P(^DIC(4,+Y,0),U,11)=""N"",$$TF^XUAF4(+Y)" D ^DIR
 I X["^" S SDWLERR=1 Q
 I Y<1 W *7,"Invalid Entry" G SEL
 S SDWLINSN=+Y
 D C3,C31 K DIC,D0,D1
 Q
C3 ;
 ;check entry to see if it already exist
 S DA=SDWLSSX,DA(1)=SDWLSS
 I $O(^SDWL(409.31,SDWLSS,"I","B",SDWLINSN,0)) D
 . W !,"Institution already exists for this Specialty...deleting."
 . S DIK="^SDWL(409.31,"_DA(1)_","_"""I"""_"," D ^DIK
 E  D
 . W ! S DR=".01////^S X=SDWLINSN",DIE="^SDWL(409.31,"_DA(1)_","_"""I"""_"," D ^DIE
 K DA,DA(1),DR,DIE,DIK
 Q
C31 ;update SD WAIT LIST PATIENT file 409.3
 S SDWLDA="" F  S SDWLDA=$O(^TMP($J,"SDWLCU1",SDWLTY,SDWLINS,SDWLSSV,SDWLDA)) Q:SDWLDA=""  D
 .S DR="2////^S X=SDWLINSN",DIE="^SDWL(409.3,",DA=SDWLDA D ^DIE
 .K DR,DIE,DA
 .K ^TMP($J,"SDWLCU1",SDWLTY,SDWLINS,SDWLSSV,SDWLDA),^TMP($J,"EWL",$J,SDWLDA)
 Q
4 ;specific clinic edit
 N SDWLERR,SDWLSC,SDWLINS S SDWLSC="",SDWLINS="",SDWLERR=""
 F  S SDWLINS=$O(^TMP($J,"SDWLCU1",SDWLTY,SDWLINS)) Q:SDWLINS=""  D
 .F  S SDWLSC=$O(^TMP($J,"SDWLCU1",SDWLTY,SDWLINS,SDWLSC)) Q:SDWLSC=""  D UPDINS^SDWLCU5(SDWLSC,.SDWLERR)
 Q:SDWLERR
 S WLTC4=""
 K ^SDWL(409.32,"ACT") S DIK="^SDWL(409.32," D IXALL^DIK
 Q
C41 ;update wait list file
 S SDWLDA="" F  S SDWLDA=$O(^TMP($J,"SDWLCU1",SDWLTY,SDWLINS,SDWLSC,SDWLDA)) Q:SDWLDA=""  D 
 .S SDWLIN(409.3,SDWLDA_",",2)=SDWLINSN D UPDATE^DIE("","SDWLIN","SDWLMSG")
 .K ^TMP($J,"SDWLCU1",SDWLTY,SDWLINS,SDWLSC,SDWLDA),^TMP($J,"EWL",$J,SDWLDA),SDWLIN
 Q
SEL1 ;select valid institution
 N DIR
 W !!,"Invalid Institution. Please select a National Institution.",!
 W "CLINIC: ",CLNAM,"   INSTITUTION:",$$GET1^DIQ(4,SDWLINS_",",.01)
 S DIR("A")="Select Institution: "
 S DIR(0)="PAO^4:EMZ",DIR("S")="I $P(^DIC(4,+Y,0),U,11)=""N"",$$TF^XUAF4(+Y)" D ^DIR
 I X["^" S SDWLERR=1 Q
 I Y<1 W *7,"Invalid Entry" G SEL1
 S SDWLINSN=+Y
 Q
