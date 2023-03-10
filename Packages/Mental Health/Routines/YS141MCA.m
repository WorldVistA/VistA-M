YS141MCA ;SLC/KCM - Patch 141 MoCA Task ; 1/27/2020
 ;;5.01;MENTAL HEALTH;**141**;Dec 30, 1994;Build 85
 ;
SETMOCA ; Set up MoCA attestation to be displayed starting Dec 1,2020
 D EN^XPAR("SYS","YSMOCA ATTESTATION DATE",1,3201201)
 Q
 N ENABLE
 S ENABLE=0 I $$NOW^XLFDT>3200831.2359 S ENABLE=1
 D EN^XPAR("SYS","YSMOCA ATTESTATION ENABLED",1,ENABLE)
 Q
QMOCA ; queue job to enable MoCA attestation
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 S ZTIO=""
 S ZTRTN="DQMOCA^YS141MCA"
 S ZTDESC="Enable MoCA Attestation Dialog on Sep 1, 2020"
 S ZTDTH="65623,120"  ; September 1, 2020 just after midnight
 D ^%ZTLOAD
 I '$G(ZTSK) D MES^XPDUTL("Unable to schedule MoCA update.")
 Q
DQMOCA ; set MoCA attestation enabled
 D EN^XPAR("SYS","YSMOCA ATTESTATION ENABLED",1,1)
 Q
