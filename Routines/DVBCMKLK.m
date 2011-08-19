DVBCMKLK ;ALB/GTS-AMIE C&P APPT EVENT DRIVER-LINK RTN ; 10/20/94  4:00 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;** NOTICE: This routine is part of an implementation of a Nationally
 ;**         Controlled Procedure.  Local modifications to this routine
 ;**         are prohibited per VHA Directive 10-93-142
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 ;
EN ;** Link C&P appointment to 2507
 S DVBADFN=DFN,DVBASTAT="P" ;**DVBASTAT used in REQARY^DVBCUTL5
 ;
 ;**If user entered from AMIE Scheduling, only prompted if enhanced
 ;** dialogue turned on and is needed
 ;** QUIT on next line if from DVBCSCHD
 I $D(DVBASDRT) S DVBADA=REQDA D LINKAPPT^DVBCMKL2,KVARS QUIT  ;*DVBCSCHD
 S (DVBADA,DVBASDPR)=""
 D REQARY^DVBCUTL5 ;**Set up ^TMP of AMIE 2507's
 I +DVBACNT>0 DO
 .I +DVBACNT=1 DO  ;**Auto select 2507 if only one exists
 ..S (DVBADT,DVBADA,DVBAORD)=""
 ..S DVBAORD=$O(^TMP("DVBC",$J,DVBAORD))
 ..S DVBADT=$O(^TMP("DVBC",$J,DVBAORD,DVBADT))
 ..S DVBADA=$O(^TMP("DVBC",$J,DVBAORD,DVBADT,DVBADA))
 .I +DVBACNT>1 DO  ;**If more than one 2507 exists, user select
 ..D REQSEL^DVBCUTL5 ;**Select a 2507 from ^TMP
 ..I (+Y'>0)!($D(DVBAOUT)) S DVBADA=""
 ..S:+Y>0 DVBASEL=+Y ;**Y is selected 2507 val returned from ^DIR
 ..D:+Y>0 FINDDA^DVBCUTL5 ;**Find selected 2507 DA (Returned in DVBADA)
 .K ^TMP("DVBC",$J)
 .I '$D(^DVB(396.3,+DVBADA,0)),(+$$ENHNC^DVBCUTA4=1) DO  ;**Write warning
 ..S DIR("A",1)="You have not selected a 2507 request to link the C&P appointment to."
 ..S DIR("A",2)="The appointment should be linked with the AMIE/C&P Appointment Link"
 ..S DIR("A",3)=" Management Option to ensure proper processing time calculation for this 2507"
 ..S DIR("A",4)=" in the event of a veteran cancellation."
 ..S DIR("A",5)=" "
 ..S DIR(0)="FAO^1:1",DIR("A")="Hit any key to continue." D ^DIR K DIR,X,Y
 .I $D(^DVB(396.3,+DVBADA,0)) D LINKAPPT^DVBCMKL2 ;**If 2507, link appt
 I +DVBACNT'>0,(+$$ENHNC^DVBCUTA4=1) DO  ;**Write Warning
 .S DIR("A",1)="You have made a C&P appointment for a patient who has no pending 2507 request!"
 .S DIR("A",2)=" "
 .S DIR(0)="FAO^1:1",DIR("A")="Hit any key to continue." D ^DIR K DIR,X,Y
 Q
 ;
KVARS ;** Kill variables used by scheduling protocol
 K DVBAMORE,DVBALP,DVBAOUT,DVBADTOT,DVBASDPR,DVBASEL
 K DVBAPNAM,DVBADA,DVBADFN,DVBASTAT,DVBADT,DVBAORD,DVBACNT
 K ^TMP("DVBC",$J),Y,DVBAYANS,DVBALKRC,DVBARSAP
 Q
 ;
CRTREC ;** Add a record to file 396.95 (Appt Tracking)
 K DD,DO
 S DVBAADT=$P(SDATA,U,3)
 S DIC="^DVB(396.95,",X=DVBAADT,DIC(0)="LX",DLAYGO="396.95"
 S DIC("DR")=".02////^S X=DVBAADT;.03////^S X=DVBAADT;"
 S DIC("DR")=DIC("DR")_".04////^S X=0;.06////^S X=DVBADA;"
 S DIC("DR")=DIC("DR")_".07////^S X=1"
 D FILE^DICN K DIC,X,DLAYGO,DVBAADT
 I +$$ENHNC^DVBCUTA4=1 DO
 .N REQDT,SAVY
 .S:$D(Y) SAVY=Y
 .S REQDT=$$GETDTE(DVBADA) ;**Set REQDT
 .S:$D(SAVY) Y=SAVY
 .S DIR("A",1)=" "
 .S DIR("A",2)="Adding new C&P appointment link for 2507 request dated "_REQDT_"."
 .S DIR("A",3)=" "
 .S DIR(0)="FAO^1:1",DIR("A")="Hit any key to continue." D ^DIR K DIR,X,Y
 Q
 ;
GETDTE(REQDA) ;** Get the request dte
 N REQDT
 K Y S Y=$P(^DVB(396.3,REQDA,0),U,2) X ^DD("DD")
 S REQDT=Y
 K Y
 Q REQDT
 ;
RSCHAPT(LKDA,RSCHDT) ;** Update Appt record with reschedule data
 S DA=+LKDA,DIE="^DVB(396.95,",DR=".03////^S X=RSCHDT;.07////1"
 S:(+$P(^DVB(396.95,DA,0),U,4)=0&('$D(DVBAVTRQ))) DR=".02////^S X=RSCHDT;"_DR
 S:($D(DVBAVTRQ)) DR=".04////^S X=1;.05////^S X=RSCHDT;"_DR
 D ^DIE K DA,DIE,DR
 I +$$ENHNC^DVBCUTA4=1 DO
 .N REQDT,SAVY
 .S:$D(Y) SAVY=Y
 .S REQDT=$$GETDTE($P(^DVB(396.95,LKDA,0),U,6)) ;**Set REQDT
 .S:$D(SAVY) Y=SAVY
 .S DIR("A",1)=" "
 .S DIR("A",2)="Adjusting C&P appointment link for 2507 request dated "_REQDT_"."
 .S DIR("A",3)=" "
 .S DIR(0)="FAO^1:1",DIR("A")="Hit any key to continue." D ^DIR K DIR,X,Y
 Q
