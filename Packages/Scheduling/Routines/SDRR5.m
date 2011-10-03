SDRR5 ;10N20/MAH; RECALL REMINDER Remove and Replace Providers and Clinics; 01/22/2008
 ;;5.3;Scheduling;**536**;Aug 13, 1993;Build 53
 ;This routine was written per requests from VISN20 sites
 ;^SD(403.5 -- RECALL REMINDERS FILE
 ;403.54 -- RECALL REMINDERS PROVIDERS FILE
 ;44 -- HOSPITAL LOCATION FILE
 ;Used in option [SDRR CONVERT ENTRIES]
STRT S (NIEN,OIEN,SDT,EDT,OHIEN,NHIEN,FLAG,OLDC,NEWC)=""
 S DIC="^SD(403.54,",DIC(0)="AEQMZ",DIC("A")="Select Retiring Provider: " D ^DIC G:Y<0 QUIT S OIEN=+Y,OPROV=$P(^SD(403.54,OIEN,0),"^",1),SDRROLD=$$NAME^XUSER(OPROV,"F")
 S DIC="^SD(403.54,",DIC(0)="AEQMZ",DIC("A")="Select New Provider: " D ^DIC G:Y<0 QUIT S NIEN=+Y,OPROV=$P(^SD(403.54,NIEN,0),"^",1),SDRRNEW=$$NAME^XUSER(OPROV,"F")
 W !,?1,"Do you want to change Clinic names that the recall is pointed to: " S %=2 D YN^DICN I %=2 G SELDT
 K %
CLINC S DIC="^SC(",DIC(0)="AEQMZ",DIC("A")="Select Retiring Clinic: " D ^DIC G:Y<0 CLEAN S OHIEN=+Y,OLDC=$$GET1^DIQ(44,OHIEN_",",.01)
 S DIC="^SC(",DIC(0)="AEQMZ",DIC("A")="Select New Clinic: " D ^DIC G:Y<0 CLEAN S NHIEN=+Y,FLAG="C",NEWC=$$GET1^DIQ(44,NHIEN_",",.01)
CLEAN ;CLINIC NOT SELECTED BUT CHECK
 I FLAG'["C" W !,?1,"You have selected not to move clinic recall applications to a different clinic is this correct: " S %=2 D YN^DICN I %=2 G CLINC
SELDT S %DT="AEX",%DT("A")="Start with RECALL DATE: " D ^%DT Q:Y<0  S SDT=Y,%DT("A")="End with RECALL DATE: " D ^%DT I Y<SDT W $C(7),"  ??" G SELDT
 S EDT=Y S EDT=EDT_".9999"
 W !!,?5,"****You will be converting all Clinic Recalls for****"
 W !!,?3,SDRROLD_" -They will be converted to- "_SDRRNEW
 I NEWC'="" W !,?3,OLDC_" Clinic will be converted to "_NEWC_" Clinic"
 I FLAG["C" S D0=0 F  S D0=$O(^SD(403.5,"C",OIEN,D0)) Q:D0'>0  D
 .S RD=$P($G(^SD(403.5,D0,0)),"^",6) Q:RD<SDT!(RD>EDT)  S DIE="^SD(403.5," S DA=D0,DR="4///^S X=""`""_NIEN;4.5///^S X=""`""_NHIEN" D ^DIE K DIE,DR,DA
 I FLAG="" S D0=0 F  S D0=$O(^SD(403.5,"C",OIEN,D0)) Q:D0'>0  D
 .S RD=$P($G(^SD(403.5,D0,0)),"^",6) Q:RD<SDT!(RD>EDT)  S DIE="^SD(403.5," S DA=D0,DR="4///^S X=""`""_NIEN" D ^DIE K DIE,DR,DA
QUIT K Y,OIEN,NIEN,FLAG,OPROV,SDT,RD,EDT,SDRRNEW,SDRROLD,D0,NEWC,NHIEN,OHIEN,OLDC,X,DIC,FLAG,%DT
