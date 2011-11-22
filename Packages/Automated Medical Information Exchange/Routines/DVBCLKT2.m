DVBCLKT2 ;ALB/GTS-AMIE C&P APPT LINK MNGT ROUTINE 2 ; 10/20/94  11:45 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;** NOTICE: This routine is part of an implementation of a Nationally
 ;**         Controlled Procedure.  Local modifications to this routine
 ;**         are prohibited per VHA Directive 10-93-142
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 ;
LNKQS ;** Question user to see if selected appt is rebook of existing link
 S DIR(0)="Y^A^"
 S DIR("A")="Was "_$P(DVBAAPT,U,1)_" scheduled to rebook a previous appointment"
 S DIR("?",1)="Enter NO to indicate this appointment is the first time the exam is scheduled."
 S DIR("?",2)="Enter YES to indicate this appointment is a rebook of an existing appointment"
 S DIR("?",3)="  for the exam."
 S DIR("?")="(If YES, you will be asked to select the appointment being rebooked.)"
 D ^DIR K DIR,X
 Q
 ;
ERRMESS ;** Error: Appointment link not selected
 S DIR("A",1)=" "
 S DIR("A",2)="You have not selected an appointment link which to modify with the selected"
 S DIR("A",3)=" appointment.  If the desired appointment was not displayed for selection,"
 S DIR("A",4)=" it must first be added as a new link to the 2507 request.  You may then "
 S DIR("A",5)=" modify the link as you have attempted here."
 S DIR("A",6)=" "
 S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 Q
 ;
APPTERR ;** Error if appt was not selected
 S DIR("A",1)=" "
 S DIR("A",2)="You have not selected a C&P appointment to link the request to."
 S DIR("A",3)="This is required before further processing with the AMIE link"
 S DIR("A",4)=" management option."
 S DIR("A",5)=" "
 S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue or '^' to STOP."
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S DVBAOUT=""
 K DIR,X,Y,DTOUT,DUOUT
 Q
 ;
NOAPTERR ;** Veteran does not have C&P appointments
 S DIR("A",1)=" "
 S DIR("A",2)="You have selected a veteran that does not have C&P appointments"
 S DIR("A",3)=" to link to this request.  This is required before further processing with "
 S DIR("A",4)=" the AMIE link management option."
 S DIR("A",5)=" "
 S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 S DVBAOUT=""
 Q
 ;
DELERR ;** Error if link exists and user is not a supervisor
 S DIR("A",1)=" "
 S DIR("A",2)="You have selected a C&P appointment that is Currently Linked to the request."
 S DIR("A",3)="(NOTE: *CL) If you want to remove this link, see your supervisor."
 S DIR("A",4)=" "
 S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 Q
 ;
DELCK ;** Question supervisor to delete link
 D LINKINF^DVBCUTL6(DVBADA,$P(DVBAAPT,U,4))
 S DIR(0)="Y^A^"
 S DIR("A",1)=" "
 S DIR("A")="Do you want to REMOVE this link"
 S DIR("?",1)="Enter YES to remove this appointment from the 2507."
 S DIR("?",2)="Enter NO leave this appointment associated with the 2507."
 S DIR("?",3)="If you enter YES incorrectly, you will need to use this tool to relink the"
 S DIR("?")=" appointment to the request."
 D ^DIR
 I +Y>0 S DVBADEL=""
 K DIR,X,Y
 Q
 ;
DODEL ;** Delete existing link
 S DA="" S DA=$O(^DVB(396.95,"AB",DVBADA,$P(DVBAAPT,U,4),DA))
 S DIK="^DVB(396.95," D ^DIK K DIK,DA
 Q
 ;
NOLNK ;** Error that no links exist
 S DIR("A",1)=" "
 S DIR("A",2)="No appointments are currently linked to this 2507 request."
 S DIR("A",3)="You will need to create a link to the cancelled appointment"
 S DIR("A",4)=" before proceding with the link to this appointment."
 S DIR("A",5)=" "
 S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 Q
