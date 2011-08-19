ONCOAS ;Hines OIFO/GWB - [SE Add/Edit/Delete 'Suspense' Case] ;05/30/00
 ;;2.11;ONCOLOGY;**25,26,27,41**;Mar 07, 1995
 ;
PAT ;[SE Add/Edit/Delete 'Suspense' Case]
 W ! S DIC="^ONCO(160,",DIC(0)="AEZML",DLAYGO=160 D ^DIC G:Y<0 EX
 S (D0,ONCOD0)=+Y
 N Y K DIQ,ONC S DIC="^ONCO(160,",DR=".01;16;15;15.2",DA=ONCOD0,DIQ="ONC"
 D EN^DIQ1 W !
 W !?1,"Patient Name.................: ",ONC(160,ONCOD0,.01)
 W !?1,"Date of Last Contact or Death: ",ONC(160,ONCOD0,16)
 W !?1,"Vital Status.................: ",ONC(160,ONCOD0,15)
 W !?1,"Follow-Up Status.............: ",ONC(160,ONCOD0,15.2)
 D SDD^ONCOCOM
 I $D(^ONCO(160,ONCOD0,"SUS","C",DUZ(2))) D  D DEL G PAT
 .S SUSIEN=$O(^ONCO(160,ONCOD0,"SUS","C",DUZ(2),0))
 .S DIE="^ONCO(160,"_ONCOD0_",""SUS"",",DA(1)=ONCOD0,DA=SUSIEN
 .S DR=".01;3" D ^DIE
 S DA(1)=ONCOD0,DIC="^ONCO(160,"_ONCOD0_",""SUS"",",DIC(0)="QEAL"
 S DIC("A")="SUSPENSE DATE: "
 S DIC("S")="I $P(^ONCO(160,DA(1),""SUS"",Y,0),U,4)=DUZ(2)"
 D ^DIC I Y=-1 K DIC,DA D DEL G PAT
 S DIE=DIC K DIC
 S DA=+Y,DR="1///^S X=DT;2///^S X=""SE"";3////^S X=DUZ(2)"
 S ONCOL=0 L +^ONCO(160,DA):0 I $T D ^DIE L -^ONCO(160,DA) S ONCOL=1
 I 'ONCOL W !,"This patient is being edited by another user." G PAT
 K ONCOL,DIE,DR,DA,Y
 D DEL G PAT
 ;
EX ;Exit
 K X,Y,D0,DA,DIC,DIE,DIK,DIQ,DLAYGO,DR
 K ONC,ONCOD0,ONCOL,SUSIEN
 Q
 ;
DEL ;Delete patients who are not on suspense and have no primaries
 I $O(^ONCO(160,ONCOD0,"SUS",0))="",'$D(^ONCO(165.5,"C",ONCOD0)) D
 .N DIK,DA S DIK="^ONCO(160,",DA=ONCOD0 D ^DIK
 .W !!?3,*7,"This patient is not on suspense and has no primaries."
 .W !?3,"This patient's record has been deleted."
 Q
 ;
PURGE ;PSR Purge Suspense Records [ONCO UTIL-PURGE SUSPENSE]
 W !
 W !,"   This option will purge suspense records.  The user may purge ALL suspense"
 W !,"   records or the suspense records for a selected SUSPENSE DATE range."
 W !
 W !,"   NOTE: Only suspense records which belong to your division will be purged."
 W !
 W !,"   If, after the suspense record purge, the patient has no suspense records"
 W !,"   and no primaries (for any division), the tumor registry patient record"
 W !,"   will also be purged."
 W !
 K DIR
 S DIR("A")="   Select purge option"
 S DIR(0)="SO^1:ALL suspense records for your division;2:Range of suspense records by SUSPENSE DATE"
 D ^DIR K DIR Q:$D(DIRUT)
 I Y=1 S ANS="YES" G PSR
 I Y=2 S ANS="NO"
 K DIR
 W !
 S DIR(0)="D"
 S DIR("A")="   Start Suspense Date"
 S DIR("?")=" "
 S DIR("?",1)="   Enter the SUSPENSE DATE of the first suspense record you would like to purge."
 D ^DIR I $D(DIRUT) Q
 S SDT=Y
 S DIR("A")="     End Suspense Date"
 S DIR("?",1)="    Enter the SUSPENSE DATE of the last suspense record you would like to purge."
 D ^DIR I $D(DIRUT) Q
 S EDT=Y
PSR W !
 K DIR,ONC
 S DIR("A")="   Are you sure you want to purge suspense records"
 S DIR("B")="No"
 S DIR(0)="Y" D ^DIR
 I Y=0 Q
 I ANS="YES" S X0=0,EDT=9999999
 I ANS="NO" S X0=SDT-1
 S CNT=0
 F  S X0=$O(^ONCO(160,"ADX",X0)) Q:('X0)!(X0>EDT)  S X1=0 F  S X1=$O(^ONCO(160,"ADX",X0,X1)) Q:'X1  S X2=0 F  S X2=$O(^ONCO(160,"ADX",X0,X1,X2)) Q:'X2  I $$SUSDIV^ONCFUNC(X1,X2)=DUZ(2) D
 .S DA(1)=X1,DA=X2,DIK="^ONCO(160,"_DA(1)_",""SUS""," D ^DIK
 .S CNT=CNT+1
 .S ONC(X1)=""
 .W "."
 S PATCNT=0,SUB=0 F  S SUB=$O(ONC(SUB)) Q:'SUB  D
 .I $O(^ONCO(160,SUB,"SUS",0))="",'$D(^ONCO(165.5,"C",SUB)) D
 ..N DIK,DA S DIK="^ONCO(160,",DA=SUB D ^DIK S PATCNT=PATCNT+1
 W !!,?3,CNT," Suspense ",$S(CNT=1:"record",1:"records")," purged"
 W !,?3,PATCNT," Tumor Registry patient ",$S(CNT=1:"record",1:"records")," purged"
 K ANS,CNT,EDT,ONC,PATCNT,SDT,X0,X1,X2,Y,DA,DIK,DIR
 Q
