ONCOAIS ;Hines OIFO/GWB - POST FOLLOW-UP UPDATE PRIMARY CANCER STATUS ;07/12/00
 ;;2.11;ONCOLOGY;**25,26,44,45**;Mar 07, 1995
 ;
PRI ;TUMOR STATUS - from template [ONCO FOLLOWUP]
 I $D(^ONCO(165.5,"C",DA(1))) D
 .N XDA1,XY,K S XDA1=DA(1)
 .D FINDEM,EDITEM
 .S DA(1)=XDA1
 E  W !,"Patient has no primary registered",!!
 Q
 ;
FINDEM ;Setup/fetch the tumor status subentries from the primary file
 N FOLDAT,PRIMIEN
 S K=0,PRIMIEN=0,FOLDAT=$P($G(^ONCO(160,DA(1),"F",DA,0)),U,1)
 F  S PRIMIEN=$O(^ONCO(165.5,"C",DA(1),PRIMIEN)) Q:PRIMIEN=""  D
 .N DATEDX,TOPOG,TSIEN
 .S TOPOG=$P($G(^ONCO(165.5,PRIMIEN,0)),U)
 .S DATEDX=$P($G(^ONCO(165.5,PRIMIEN,0)),U,16)
 .I TOPOG,DATEDX,DATEDX'>FOLDAT D FINDSET
 Q
 ;
FINDSET ;Find/setup tumor status corresponding to this follow-up
 N TSIEN S TSIEN=$O(^ONCO(165.5,PRIMIEN,"TS","B",FOLDAT,0))
 I TSIEN,$D(^ONCO(165.5,PRIMIEN,"TS",TSIEN,0))
 E  S TSIEN=$$SETTS^ONCOU55(PRIMIEN,FOLDAT)
 S K=K+1,XY(K)=PRIMIEN_U_TSIEN
 Q
 ;
EDITEM ;Edit Tumor Status for each primary during a follow-up
 N Q,XD0,DIE,DR,KK
 S Q=0,XD0=DA(1)
 S DIE("NO^")=1
 S DR=.02
 F KK=1:1:K D EDITONE
 Q
 ;
EDITONE ;CANCER STATUS (165.573,.02)
 S DR=.02
 N DA
 S DA(1)=$P(XY(KK),U),DA=$P(XY(KK),U,2)
 I DUZ(2)'=$P($G(^ONCO(165.5,DA(1),"DIV")),U,1) Q
 S DIE="^ONCO(165.5,"_DA(1)_",""TS"","
 W !!,"Updating CANCER STATUS for "_$P($G(^ONCO(164,+$P($G(^ONCO(165.5,DA(1),2)),U),0)),U)_"..."
 N DG,DIC,DI,%,DP,DM,DK,DH,DQ,DIEL,DL,DC,X,Y
 L +^ONCO(165.5,DA(1)):0 I $T D ^DIE L -^ONCO(165.5,DA(1))  D  Q
 .S TOFRE=$$GET1^DIQ(165.5,DA(1),71,"E")
 .S TOFR=$$GET1^DIQ(165.5,DA(1),71,"I")
 .I TOFR'="" S TOFR=$P($G(^ONCO(160.12,TOFR,0)),U,1)
 .S LTS=$$GET1^DIQ(165.5,DA(1),95,"I")
 .I TOFR="00",LTS'=1 D  W ! D ERRMSG^ONCEDIT
 ..S MSG(1)="TYPE OF FIRST RECURRENCE = 00 ("_TOFRE_")"
 ..S MSG(2)="CANCER STATUS must be 1 (No evidence of this tumor)"
 .I TOFR=70,LTS'=2 D  W ! D ERRMSG^ONCEDIT
 ..S MSG(1)="TYPE OF FIRST RECURRENCE = 70 ("_TOFRE_")"
 ..S MSG(2)="CANCER STATUS must be 2 (Evidence of this tumor)"
 .I TOFR=99,LTS'=9 D  W ! D ERRMSG^ONCEDIT
 ..S MSG(1)="TYPE OF FIRST RECURRENCE = 99 ("_TOFRE_")"
 ..S MSG(2)="CANCER STATUS must be 9 (Unknown if recurred or disease-free"
 W !,"This primary is being edited by another user."
 Q
 ;
TEMP451 ;Point of entry from input template [ONCO FOLLOWUP]
 S (ONCOVS,VS)=X
 D PRI
 S Y="@1001"
 Q
