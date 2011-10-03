VBECDCSP ;hoifo/gjc-site parameter enter/edit (#6000);Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to ^DIC is supported by IA: 10006
 ;Call to ^DIE is supported by IA: 10018
 ;Call to GET1^DIQ is supported by IA: 2056
 ;Call to KSP^XUPARAM is supported by IA: 2541
 ;
EN ; entry point for site parameter enter/edit
 S (DIC,DIE)="^VBEC(6000,",DIC("A")="Select Facility: ",DIC(0)="QEALMNZ"
 S VBECDFLT=$$KSP^XUPARAM("INST")
 S:VBECDFLT DIC("B")=$$GET1^DIQ(4,VBECDFLT,.01)
 D ^DIC I Y=-1 D XIT Q
 S DA=+Y,DIE("NO^")="BACK",DR=".06R;.07R//VBECS DATA CONVERSION" D ^DIE
XIT ; kill and quit
 K %,D0,DA,DDH,DI,DIC,DIE,DQ,DR,DTOUT,DUOUT,DZ,I,VBECDFLT,X,Y
 Q
