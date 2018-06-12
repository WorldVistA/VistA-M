RAHLRS ;HIRMFO/CRT/PDW - Resend HL7 messages for selected cases ;16 Jan 2018 9:32 AM
 ;;5.0;Radiology/Nuclear Medicine;**25,54,60,71,82,95,137**;Mar 16, 1998;Build 4
 ;
 ; Utility to RESEND HL7 messages
 ;
 ;Integration Agreements
 ;----------------------
 ;SENDA08^MAGDHLE (6761 - Private)
 ;^MAG(2006.1, IHE flag (6860 - Private)
 ;$$PATCH^XPDUTL(10141 - Supported)
 ;
 ;;02/14/2006 BAY/KAM RA*5*71 Add ability to update exam data to V/R
 N RACNI,RADFN,RADTI,RARPT,X
 ;
 D SETVARS Q:$G(RAIMGTY)=""
 ;
 F  S X=$$RACNLU(.RADFN,.RADTI,.RACNI) Q:+X'>0  D  Q:QUIT<0
 .D RESEND(RADFN,RADTI,RACNI,.QUIT)
 Q
 ;
RACNLU(RADFN,RADTI,RACNI) ; Select Case Number
 ;
 N RANOSCRN S RANOSCRN="" ; Don't limit cases to current Imaging Type
 S (RADFN,RADTI,RADFN)=""
 D ^RACNLU
 Q X
 ;
RESEND(RADFN,RADTI,RACNI,QUIT) ; re-send exam message(s) to HL7 subscribers
 ;
 N RAED,RASSSX,RARPST ;added RASSSX,RARPST, RA*5*95
 ;
 S QUIT=0
 I '$D(DT) D ^%DT S DT=Y
 ;
 S RAED=$$RAED(RADFN,RADTI,RACNI)
 S QUIT=$$OK(RADFN,RADTI,RACNI)
 I QUIT>0 D
 .I RAED[",REG," D
 ..D EN^DDIOL("Re-sending 'EXAM REGISTERD' HL7 message...",,"!!,?6")
 ..D REG^RAHLRPC
 .I RAED[",CANCEL," D
 ..D EN^DDIOL("Re-sending 'EXAM CANCELLED' HL7 message...",,"!,?6")
 ..D CANCEL^RAHLRPC
 .I RAED[",EXAM," D
 ..S $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",30)="" ;Reset sent flag
 ..D EN^DDIOL("Re-sending 'EXAMINED' HL7 message...",,"!,?6")
 ..N RAEXMDUN D 1^RAHLRPC ;*60 Newed RAEXMDUN to prevent variable leak
 .I RAED[",RPT," D
 ..D EN^DDIOL("Re-sending 'REPORT VERIFIED' HL7 message...",,"!,?6")
 ..;If EF report, set up RASSSX() to exclude VR subscribers, RA*5*95
 ..I $G(RARPST)="EF" D HLXMSG^RARTE5
 ..D RPT^RAHLRPC
 Q
 ;
RAED(RADFN,RADTI,RACNI) ; identify correct ^RAHLRPC entry point(s)
 ;
 ; removed RARPTST from new, RA*5*95
 N RASTAT,RAIMTYP,RAORD,RETURN
 S (RARPST,RASTAT)=""
 ;
 S RETURN=",REG,"
 ;
 S RASTAT=$$GET1^DIQ(70.03,RACNI_","_RADTI_","_RADFN,3,"I")
 ;
 S RAIMTYP=$$GET1^DIQ(72,+RASTAT,7)
 S RAORD=$$GET1^DIQ(72,+RASTAT,3)
 ;
 S:RAORD=0 RETURN=RETURN_"CANCEL,"
 ;
 I $$GET1^DIQ(72,+RASTAT,8)="YES" D  ; Generate Examined HL7 Message
 .S RETURN=RETURN_"EXAM,"
 ;
 I RETURN'[",EXAM," D
 .; also check previous statuses for 'Generate Examined HL7 Message'
 .F  S RAORD=$O(^RA(72,"AA",RAIMTYP,RAORD),-1) Q:+RAORD<1  D  Q:RETURN[",EXAM,"
 ..S RASTAT=$O(^RA(72,"AA",RAIMTYP,RAORD,0))
 ..I $$GET1^DIQ(72,+RASTAT,8)="YES" S RETURN=RETURN_"EXAM,"
 ;
 I RARPT]"" D  ; Check if Verified or Elect. Filed report exists
 .S RARPST=$$GET1^DIQ(74,RARPT,5,"I")
 .I "^V^EF^"[("^"_RARPST_"^") S RETURN=RETURN_"RPT," ;RA*5*95
 ;
 Q RETURN
 ;
OK(RADFN,RADTI,RACNI) ; Get User to confirm continue
 ;
 N X,RAEXST
 ;
 S RAEXST=$$GET1^DIQ(70.03,RACNI_","_RADTI_","_RADFN,3)
 ;
 S X="",$P(X,"=",70)=""
 D EN^DDIOL(X,"","!?5")
 S DIR("A")="Re-send all HL7 messages for this '"_RAEXST_"' case?"
 S DIR(0)="Y",DIR("B")="YES" D ^DIR
 I Y="^" Q -1
 Q Y
 ;
SETVARS ; Setup key Rad/Nuc Med variables
 ;
 I $O(RACCESS(DUZ,""))="" D SETVARS^RAPSET1(0)
 Q:'($D(RACCESS(DUZ))\10)  ; user does not have location access
 I $G(RAIMGTY)="" D SETVARS^RAPSET1(1) K:$G(RAIMGTY)="" XQUIT
 Q
 ;
RAADT ;Send patient demographic update (A47/A08) to PACS - P137/KLM
 ;check if MAG*3*183 is installed
 I '$$PATCH^XPDUTL("MAG*3.0*183") W !,"You need imaging patch MAG*3.0*183 installed to use this option!" Q
 ;check if the IHE switch is on
 I $$GET1^DIQ(2006.1,1,3.01,"I")'="Y" W !!,"IHE is not enabled!",!,"See MAG*3.0*183 patch instructions to setup/enable ADT messages to PACS." Q
 W !!,"This option will send patient demographic updates for selected patients.",!
 W !,"It is recommended that you task this if you select 'ALL' patients.",!!
 N RADFN,DIR,Y
 S RADIC="^RADPT(",RADIC(0)="QEAMZ",RAUTIL="RA PATA08"
 S RADIC("A")="Select Patient(s): "
 W !! D EN1^RASELCT(.RADIC,RAUTIL)
 K DIC,RADIC,RAUTIL
 I $O(^TMP($J,"RA PATA08",""))="" W !!?3,$C(7),"No Patient selected." G EXIT
 S %=1 W !,"Would you like to task this Job" D YN^DICN G:%<1 EXIT
 I %=1 D  G EXIT
 .S ZTIO="",ZTSAVE("^TMP($J,""RA PATA08"",")=""
 .S ZTDESC="Rad/Nuc Med Patient Demographic Update to PACS",ZTRTN="TADT^RAHLRS"
 .D ^%ZTLOAD
 .I $D(ZTSK) W !,"Task# "_ZTSK,!!
 .Q
TADT ;task entry or fall through
 S RACT=0
 S RAPN="" F  S RAPN=$O(^TMP($J,"RA PATA08",RAPN)) Q:RAPN=""  D
 .S RADFN=0 F  S RADFN=$O(^TMP($J,"RA PATA08",RAPN,RADFN)) Q:RADFN=""  D
 ..D SENDA08^MAGDHLE(RADFN)
 ..S RACT=RACT+1
 ..Q
 .Q
 I '$D(ZTQUEUED) W !!,"Demographic updates sent for "_RACT_" patients"
EXIT K ^TMP($J,"RA PATA08"),RAPN,RADFN,ZTDESC,ZTRTN,RACT,ZTSAVE,ZTIO,ZTSK,ZTQUEUED,%
 Q
