WIILM02 ;VISN20/WDE/WHN -  WII List Manager Actions continued ; 23-JUN-2008
 ;;1.0;Wounded Injured and Ill Warriors;**1**;06/26/2008;Build 28
 ;
EX ; expand eligibility for line
 ; FM DIR API called to select entry from current LM list, WIIENT set to movement
 ; IEN stored in LM "IDX" list x-ref.  Patient DFN defined using FM $$GET1^DIQ()
 ; API to retrieve internal value of pointed to file.
 Q:VALMCNT<1
 K DIR S DIR(0)="NO^"_VALMBG_":"_VALMLST_":0" D ^DIR K DIR
 Q:$D(DIRUT)
 S WIIENT=$O(@VALMAR@("IDX",+Y,"")),DFN=$$GET1^DIQ(405,WIIENT,.03,"I") Q:'DFN
 I $G(DFN)>0 D EN^VALM("WII ELIG REVIEW")
 Q
ADD ; add entry to file
 ; FM DIR API called to select entry from Patien Movement file, selection screened
 ; to look at only admission(1) or discharge(3) transactions. WIIEN set to movement
 ; IEN.  Patient DFN defined using FM $$GET1^DIQ()API to retrieve internal value
 ; of pointed to file.
 D FULL^VALM1
 W @IOF
 ; set up DIR and screen for admission (1) or discharge (3) transactions
 K DIR S DIR(0)="PO^405:AEMQ",DIR("A")="Select Admission/Discharge Date",DIR("S")="I ""13""[$P(^(0),U,2)" D ^DIR K DIR
 Q:$D(DIRUT)
 S WIIENT=+Y,DFN=$$GET1^DIQ(405,WIIENT,.03,"I")
 D FORCE^WIIACT4(DFN,WIIENT)
 Q
ZAP ;
 K DIE,DIRUT,DA,Y,X,DR,STATUS,WIILN,VALMAR,VALMBG,VALMCNT,VALMLST,WIIEN,WIILN,WIINODE,WIIX,WIIY,WIIZ,Y,DFN,WIIENT
