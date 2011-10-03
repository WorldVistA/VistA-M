DGPMV321 ;ALB/MIR - ASIH TRANSFER ; 8/6/08 11:45am
 ;;5.3;Registration;**40,208,713,784**;Aug 13, 1993;Build 16
ECA ;Edit corresponding admission for ASIH transfers
 S DGPMTN=DGPMA,DGPMNI=DGPMCA D FINDLAST^DGPMV32
 S DGPMNA=0,DGPMAA=$P(DGPMA,"^",15) I '$D(^DGPM(+DGPMAA,0)) D  S DGPMNA=1,DIE("NO^")=""
 .;get admit eligibility for PTF record 784
 .N DGPMELG
 .S DGPMELG=$$GET1^DIQ(45,$$IENS^DILF($$GET1^DIQ(405,DGPMCA,.16)),20.1)
 .D NEW
 W !,"Editing Corresponding Hospital Admission",!
 I 'DGPMNA,$D(^DGPM(+DGPMAA,0)) S DA=$P(^(0),"^",16) I $D(^DGPT(+DA,0)) S DIE="^DGPT(",DR="2////"_+DGPMA_";20;" K DQ,DG D ^DIE W ! ;update admission d/t in PTF
 ;update pseudo discharge
 S X1=+DGPMAB,X2=30 D C^%DTC
 I 'DGPMNA,(+DGPMA'=+DGPMP) S DA=$P(DGPMAN,"^",17) I $D(^DGPM(+DA,0)) S ^UTILITY("DGPM",$J,3,DA,"P")=$S($D(^UTILITY("DGPM",$J,3,DA,"P")):^("P"),1:^DGPM(DA,0)),DIE="^DGPM(",DR=".01///"_X K DQ,DG D ^DIE S ^UTILITY("DGPM",$J,3,DA,"A")=^DGPM(DA,0)
 S DA=DGPMAA,DR="[DGPM ASIH ADMIT]",DIE="^DGPM(" I $D(^DGPM(+DA,0)) S ^UTILITY("DGPM",$J,1,DA,"P")=$S($D(^UTILITY("DGPM",$J,1,DA,"P")):^("P"),1:^DGPM(DA,0)) S:DGPMN DIE("NO^")="" K DQ,DG D ^DIE S ^UTILITY("DGPM",$J,1,DA,"A")=^DGPM(DA,0)
 I '$P(^DGPM(DGPMDA,0),"^",6) D UNDO^DGPMV322 Q
 S:$D(Y) DGPMOUT=1 S Y=DGPMAA_"^1" D:'DGPMOUT SPEC^DGPMV36
 I '$D(^DGPM("APHY",DGPMAA)) D UNDO^DGPMV322 Q
 ; DG*713 - send admission bulletin
 D ^DGPMVBUR
 K DGPMAA,DGPMAB,DGPMNA,DGPMPTF Q
UHD ;Update hospital discharge and PTF record
 S X=("^"_$P(DGPM0,"^",18)_"^") G:"^43^45^"[X DEL Q:"^13^44^"'[X
 ;Update hospital discharge
 G DEL:(+DGPMA=+DGPMP)
 S DA=$S($D(^DGPM(+$P(DGPM0,"^",15),0)):$P(^(0),"^",17),1:0)
 I $D(^DGPM(+DA,0)) S ^UTILITY("DGPM",$J,3,DA,"P")=$S($D(^UTILITY("DGPM",$J,3,DA,"P")):^("P"),1:^DGPM(DA,0)),DR=".01///"_+DGPMA_";102////"_DUZ_";103///NOW",DIE="^DGPM(" K DQ,DG D ^DIE S ^UTILITY("DGPM",$J,3,DA,"A")=^DGPM(DA,0)
 I +DGPMP'=+DGPMA S DA=$P(^DGPM(+$P(DGPM0,"^",15),0),"^",16) I $D(^DGPT(+DA,0)) S DIE="^DGPT(",DR="70////"_+DGPMA K DQ,DG D ^DIE ;update discharge date for hospital PTF
DEL ;conditionally delete WHILE ASIH or DISCHARGE FROM NHCU/DOM WHILE ASIH discharge if no longer ASIH
 I DGPMTYP="^14^",$P(DGPMAN,U,17) D
 . N X
 . S X=$G(^DGPM(+$P(DGPMAN,U,17),0)) ; discharge node
 . I $P(X,"^",18)'=42,($P(X,"^",18)'=47) Q  ; not WHILE ASIH or DISCHARGE FROM NHCU/DOM WHILE ASIH
 . S X=9999999.9999999-+X ; inverse date of discharge movement
 . S X=$O(^DGPM("APMV",DFN,DGPMCA,X)),X=$O(^(+X,0)) ; last movement ien
 . S X=$P($G(^DGPM(+X,0)),"^",18) I "^13^43^44^45^"[("^"_X_"^") Q  ; still actively ASIH
 . S DGPMAA=DGPMAN,DGPMAI=DGPMCA
 . D DEL^DGPMV331
 Q
NEW ;Add new corresponding admission to file
 W !!,"Creating new hospital admission"
 S DGMAS=40 D FAMT^DGPMV30 ; get active mvt type for TO ASIH admission
 S X=+DGPMA,DGPM0ND=+DGPMA_"^"_1_"^"_DFN_"^"_DGFAC_"^^^^^^^^^^"_DA_"^^^^^^^"_+DGPMDA_"^"_2 D NEW^DGPMV3 S DGPMAA=+Y K DGFAC
 S ^UTILITY("DGPM",$J,1,+Y,"P")="",^UTILITY("DGPM",$J,1,+Y,"A")=$G(^DGPM(+Y,0))
 ;
 ;now update transfer movement with ASIH ADMISSION and ASIH SEQUENCE
 S DIE="^DGPM(",DA=DGPMDA,DR=".15////"_DGPMAA_";.22////"_1 K DQ,DG D ^DIE
 ;
 ;create new PTF entry
 W !,"Creating PTF record for new hospital admission",!
 S Y=+DGPMA D CREATE^DGPTFCR S DGPMPTF=+Y
 ;
 ;update new PTF entry with admit eligibility 784
 I $D(DGPMELG) D
 .N DA,DIE,DR
 .S DA=DGPMPTF,DIE="^DGPT("
 .S DR="20.1////^S X=+$$ELIG^DGUTL3($$GET1^DIQ(45,$$IENS^DILF(DGPMPTF),.01,""I""),3,DGPMELG)"
 .D ^DIE
 .K DA,DIE,DIR
 ;update hospital admission with PTF NUMBER 
 S DIE="^DGPM(",DA=DGPMAA,DR=".16////"_DGPMPTF K DQ,DG I $D(^DGPM(+DA,0)) S ^UTILITY("DGPM",$J,1,DA,"P")=$S($D(^UTILITY("DGPM",$J,1,DA,"P")):^("P"),1:^DGPM(DA,0)) D ^DIE S ^UTILITY("DGPM",$J,1,DA,"A")=^DGPM(DA,0)
 Q:DGPMTYP="^44^"  ;if RESUME ASIH, already have 30 day discharge
 ;
ASIHOF ;entry when transferring TO ASIH (OTHER FACILITY) to create 30 day discharge
 ;create pseudo discharge for NHCU/DOM admission - 30 days from first transfer of TO ASIH or TO ASIH (OTHER FACILITY)
 W !,"Creating 30 day pseudo discharge for NHCU/DOM admission"
 S DGMAS=42 D FAMT^DGPMV30 ; get active mvt type for WHILE ASIH discharge
 S X1=+DGPMAB,X2=30 D C^%DTC S DGPMPD=X,DGPM0ND=X_"^"_3_"^"_DFN_"^"_DGFAC_"^^^^^^^^^^"_+DGPMCA,Y=+$P($G(^DGPM(+DGPMCA,0)),U,17)
 I $P($G(^DGPM(+Y,0)),U,4)=DGFAC D
 .N DIE,DA S DIE="^DGPM(",DA=+Y N Y S DR=".01////^S X="_X D ^DIE
 D:'Y NEW^DGPMV3 S DGPMAD=+Y K DGFAC
 S ^UTILITY("DGPM",$J,3,+Y,"P")="",^UTILITY("DGPM",$J,3,+Y,"A")=$G(^DGPM(+Y,0))
 ;
 ;update NHCU/DOM PTF entry with DISCHARGE DATE, TYPE OF DISPOSITION
 S DIE="^DGPT(",DA=$P(DGPMAN,"^",16),DR="70////"_DGPMPD_";72////"_1 K DQ,DG I $D(^DGPT(+DA,0)) D ^DIE
 ;
 ;update NHCU admission with DISCHARGE MOVEMENT
 K DGPMAD,DGPMPD,DGPMPTF Q
