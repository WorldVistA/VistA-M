RAHLRS ;HIRMFO/CRT/PDW - Resend HL7 messages for selected cases ;01/19/08 12:40
 ;;5.0;Radiology/Nuclear Medicine;**25,54,60,71,82,95**;Mar 16, 1998;Build 7
 ;
 ; Utility to RESEND HL7 messages
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
