PSO7M529 ;WILM/BDB - DEA DELETE ;05/15/2018
 ;;7.0;OUTPATIENT PHARMACY;**529**;DEC 1997;Build 94
 ;External reference to sub-file NEW DEA #S (#200.5321) is supported by DBIA 7000
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 Q
 ;
START ;
 N DEA,NPIEN,DA,DEAIEN,RSLT
 S RSLT=$$ALERT()
 I '+$G(RSLT) W !!,"Nothing deleted.",! Q
 S DEA="A"
 F  S DEA=$O(^VA(200,"PS4",DEA)) Q:DEA=""  D 
 .S NPIEN=0 S NPIEN=$O(^VA(200,"PS4",DEA,NPIEN)) Q:NPIEN=""  D
 ..S DA=$O(^VA(200,"PS4",DEA,NPIEN,0)) Q:DA=""
 ..S DA(1)=NPIEN,DIK="^VA(200,"_DA(1)_",""PS4""," D ^DIK K DIK
 S DEAIEN=0 F  S DEAIEN=$O(^XTV(8991.9,DEAIEN)) Q:DEAIEN=""  D
 .S DA=DEAIEN,DIK="^XTV(8991.9," D ^DIK K DIK,DA
 W !!,"The DEA profile data has been deleted from the DEA multiple fields"
 W !,"in the New Person file (#200) and in the DEA Numbers file (#8991.9)."
 Q
 ;
ALERT() ;
 N Y,DIR
 S DIR("A",1)=""
 S DIR("A",2)="   ************************************************************"
 S DIR("A",3)="   **  You are about to delete all DEA profile data for the  **"
 S DIR("A",4)="   **  new DEA multiple fields in the New Person file (#200) **"
 S DIR("A",5)="   **  and in the DEA Numbers file (#8991.9).  At the prompt **"
 S DIR("A",6)="   **  enter ""YES"" to delete the data, or enter ""NO"" or ""^""  **"
 S DIR("A",7)="   **  to exit without deleting.                             **"
 S DIR("A",8)="   ************************************************************"
 S DIR("A",9)=""
 S DIR(0)="Y",DIR("A")="Delete the new multiple DEA profile data? "
 S DIR("?")="Enter ""YES"" to delete the new multiple DEA profile data"
 S DIR("??")=DIR("?")
 S DIR("B")="NO" D ^DIR
 Q $G(Y)
 ;
