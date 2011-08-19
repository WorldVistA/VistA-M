DVBCMKL2 ;ALB/GTS-AMIE APPT EVENT DRIVER-LINK RTN 2 ; 10/20/94  9:00 PM
 ;;2.7;AMIE;**17**;Apr 10, 1995
 ;
 ;** NOTICE: This routine is part of an implementation of a Nationally
 ;**         Controlled Procedure.  Local modifications to this routine
 ;**         are prohibited per VHA Directive 10-93-142
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 ;
LINKAPPT ;** Link C&P appt to 2507
 ;** Enhanced mode On - user prompted with checks
 ;** Enhanced mode Off - appointment added as new link
 I $D(^DVB(396.95,"AR",DVBADA)),(+$$ENHNC^DVBCUTA4=1) DO
 .S DIR("A",1)=" "
 .S DIR("A",2)="This 2507 already has appointments."
 .S DIR("A",3)="    Enter '?' for help"
 .S DIR("A")="Is this appointment due to a cancellation? "
 .S DIR("?",1)="Enter NO if the appointment is not a reschedule of another appointment"
 .S DIR("?",2)=" made previously.  Enter YES if the appointment is being scheduled because"
 .S DIR("?")=" an appointment has been or will be canceled."
 .S DIR(0)="YA^^"
 .S DIR("B")="NO"
 .S Y=""
 .F  Q:(Y=1!(Y=0)!($D(DTOUT)))  DO
 ..D ^DIR
 ..W:Y="^" *7,"  '^' NOT ALLOWED"
 .S DVBAYANS=+Y
 .K DIR,Y
 .I +DVBAYANS=1 DO  ;**Appt link selection
 ..S DVBALKRC=$$SELLNK^DVBCUTL8(DVBADA)
 ..I +DVBALKRC'>0 DO  ;**Appt not selected for reschedule
 ...S DIR("A",1)=" "
 ...S DIR("A",2)="You have not selected the linked appointment being rescheduled.  You may"
 ...S DIR("A",3)=" need to adjust the link to the appointment with the AMIE link"
 ...S DIR("A",4)=" management option to ensure proper processing time calculation for this 2507."
 ...S DIR("A",5)=" "
 ...S DIR(0)="FAO^1:1",DIR("A")="Hit any key to continue." D ^DIR K DIR,X,Y
 ..I +DVBALKRC>0 DO  ;**Appt selected for reschedule
 ...I +$P(^DVB(396.95,DVBALKRC,0),U,4)'=1!($P(^DVB(396.95,DVBALKRC,0),U,5)'="") DO
 ....K DIR,X,Y
 ....S DIR("?",1)="Enter Yes if the veteran requested a reschedule or 'No Showed' the appointment"
 ....S DIR("?")="Enter No if the Clinic required a reschedule."
 ....S DIR("A")="Is this appointment due to a veteran requested cancellation or 'No Show'"
 ....S DIR(0)="Y^AO" D ^DIR I $D(DTOUT)!($D(DUOUT)) S DVBAGETO=""
 ....K DIR,DTOUT,DUOUT
 ....I '$D(DVBAGETO) S:+Y=1 DVBAVTRQ="" DO
 .....D UPDTLK ;**Reschedule appt
 ....I $D(DVBAGETO) DO  ;**Time or '^' out
 .....K Y,DIR,DTOUT,DUOUT
 .....S DIR("A",1)=" "
 .....S DIR("A",2)="You have not indicated if the reschedule was due to action by the veteran."
 .....S DIR("A",3)="The new appointment will not be linked.  You will need to adjust"
 .....S DIR("A",4)="the link for this appointment with the AMIE/C&P appointment link management"
 .....S DIR("A",5)="option to ensure proper processing time calculation for this 2507."
 .....S DIR("A",6)=" "
 .....S DIR(0)="FAO^1:1",DIR("A")="Hit any key to continue."
 .....D ^DIR K DIR,X,Y
 ....K DVBAGETO
 ...I +$P(^DVB(396.95,DVBALKRC,0),U,4)=1&($P(^DVB(396.95,DVBALKRC,0),U,5)="") S DVBAVTRQ="" D UPDTLK ;**Vet cancel and no vet req date - reschd appt
 .I +DVBAYANS'=1 DO CRTREC^DVBCMKLK ;**Create new appt tracking record
 ;
 ;**No appointments exist for 2507 or enhanced dialogue Off
 I '$D(^DVB(396.95,"AR",DVBADA))!(+$$ENHNC^DVBCUTA4'=1) DO CRTREC^DVBCMKLK
 Q
 ;
UPDTLK ;** Update selected 396.95 link
 S DVBARSAP=$P(^DVB(396.95,DVBALKRC,0),U,3)
 K Y,DIR D RSCHAPT^DVBCMKLK(DVBALKRC,$P(SDATA,U,3))
 K DVBAVTRQ
 N DVBAAPST
 S DVBAAPST=$P(^DPT(DVBADFN,"S",DVBARSAP,0),U,2)
 I DVBAAPST="NT"!(DVBAAPST="I"!(DVBAAPST="")) DO
 .N DVBAAPIN S DVBAAPIN=DVBARSAP
 .S Y=DVBARSAP X ^DD("DD")
 .S DVBARSAP=Y K Y
 .S DIR("A",1)=" "
 .S DIR("A",2)="Remember to cancel the appointment for "_DVBARSAP
 .S DIR("A",3)=" and do NOT auto-rebook."
 .S DIR("A",4)=" "
 .S DIR("A")="Hit Return to continue"
 .S DIR(0)="FAO^1:1"
 .D:$P(SDATA,U,3)'=DVBAAPIN ^DIR
 .K DIR,Y,DVBARSAP
 Q
 ;
LINKHLP ;** Indentifier info for selected links
 N DVBACLNC,DVBADTE,DVBATIME,DVBADTWK,DVBAX
 S DVBACLNC=$P(^DPT(DVBADFN,"S",$P(^DVB(396.95,+Y,0),U,3),0),U,1)
 S DVBACLNC=$P(^SC(DVBACLNC,0),U,1)
 S DVBADTWK=$P(^DVB(396.95,+Y,0),U,3) ;**Get current date
 S DVBATIME=$P(DVBADTWK,".",2)
 S DVBADTWK=$P(DVBADTWK,".",1)
 S DVBADTE=$$FMTE^XLFDT(DVBADTWK,"5DZ")
 F DVBAX=$L(DVBATIME):1:3 S DVBATIME=DVBATIME_"0"
 S DVBATIME=$E(DVBATIME,1,2)_":"_$E(DVBATIME,3,4)
 S DVBADTE=DVBADTE_" @ "_DVBATIME
 W ?23,"Currently: ",DVBADTE,?59,DVBACLNC
 Q
