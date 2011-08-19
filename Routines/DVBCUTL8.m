DVBCUTL8 ;ALB/GTS-AMIE C&P APPT LINK FILE MNT RTNS 2 ; 10/20/94  3:30 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;** NOTICE: This routine is part of an implementation of a Nationally
 ;**         Controlled Procedure.  Local modifications to this routine
 ;**         are prohibited per VHA Directive 10-93-142
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 ;
FIXLK ;** Re-attach unlinked appt to new appt
 ;
 ;** ^TMP("DVBC",$J,) must have nodes:
 ;**    ORIGINAL APPT DATE, CURRENT APPT DATE, VETERAN CANCELLATION,
 ;**    VETERAN REQ APPT DATE, APPOINTMENT STATUS = appt to be linked
 ;
 N REQDT,SAVY
 S:$D(Y) SAVY=Y
 S REQDT=$$GETDTE^DVBCMKLK(DVBADA) ;**Set REQDT
 S:$D(SAVY) Y=SAVY
 S DIR("A",1)="Adjusting C&P appointment link for 2507 request dated "_REQDT_"."
 S DIR("A",2)=" "
 S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 N ORIGAPPT,CURRAPPT,VETCANC,APPTSTAT,APPTNODE,VETDTE,INITAPPT
 S VETDTE=""
 S ORIGAPPT=^TMP("DVBC",$J,"ORIGINAL APPT DATE")
 S CURRAPPT=^TMP("DVBC",$J,"CURRENT APPT DATE")
 S VETCANC=^TMP("DVBC",$J,"VETERAN CANCELLATION")
 S:$D(^TMP("DVBC",$J,"VETERAN REQ APPT DATE")) VETDTE=^TMP("DVBC",$J,"VETERAN REQ APPT DATE")
 S APPTSTAT=^TMP("DVBC",$J,"APPOINTMENT STATUS")
 K DA,DIE,DR
 ;
 ;** Only one current appt date/time for vet can exist in 396.95
 S DA="" S DA=DVBAOLDA
 S APPTNODE=^DVB(396.95,DA,0) ;**APPTNODE 396.95 rec before mods
 S DIE="^DVB(396.95,",DR=""
 ;
 ;** If 396.95 initial appt lost, set to original appt
 I $P(APPTNODE,U,1)="",($P(APPTNODE,U,2)'="") S INITAPPT=$P(APPTNODE,U,2)
 I $P(APPTNODE,U,1)="" S DR=".01////^S X=INITAPPT;"
 I $P(APPTNODE,U,4)'=1 S DR=DR_".02////^S X=ORIGAPPT;"
 S DR=DR_".03////^S X=CURRAPPT;"
 I $P(APPTNODE,U,4)'=1 S DR=DR_".04////^S X=VETCANC;"
 I VETCANC=1 S DR=DR_".05////^S X=VETDTE;" ;**Update last vet req date
 S DR=DR_".07////^S X=APPTSTAT"
 D ^DIE K DIE,DA,DR
 Q
 ;
ADDLK ;** Add link from 2507 to appt
 ;
 ;** ^TMP("DVBC",$J,) nodes:
 ;**    ORIGINAL APPT DATE, CURRENT APPT DATE, VETERAN CANCELLATION,
 ;**    VETERAN REQ APPT DATE, APPOINTMENT STATUS = appt to be linked
 ;
 N REQDT,SAVY
 S:$D(Y) SAVY=Y
 S REQDT=$$GETDTE^DVBCMKLK(DVBADA) ;**Set REQDT
 S:$D(SAVY) Y=SAVY
 S DIR("A",1)="Adding new C&P appointment link for 2507 request dated "_REQDT_"."
 S DIR("A",2)=" "
 S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 N ORIGAPPT,CURRAPPT,VETCANC,APPTSTAT,APPTNODE,VETDTE
 S VETDTE=""
 S ORIGAPPT=^TMP("DVBC",$J,"ORIGINAL APPT DATE")
 S CURRAPPT=^TMP("DVBC",$J,"CURRENT APPT DATE")
 S VETCANC=^TMP("DVBC",$J,"VETERAN CANCELLATION")
 S:$D(^TMP("DVBC",$J,"VETERAN REQ APPT DATE")) VETDTE=^TMP("DVBC",$J,"VETERAN REQ APPT DATE")
 S APPTSTAT=^TMP("DVBC",$J,"APPOINTMENT STATUS")
 K DA,DIC,X,DD,DO
 S X=^TMP("DVBC",$J,"INITIAL APPT DATE")
 S DIC="^DVB(396.95,",DIC(0)="L",DIC("DR")=""
 S DIC("DR")=DIC("DR")_".02////^S X=ORIGAPPT;.03////^S X=CURRAPPT;"
 S DIC("DR")=DIC("DR")_".04////^S X=VETCANC;.05////^S X=VETDTE;"
 S DIC("DR")=DIC("DR")_".06////^S X=DVBADA;.07////^S X=APPTSTAT"
 D FILE^DICN
 I +Y'>0 DO
 .S DIR("A",1)="The C&P appointment link was not properly added.  Please investigate the"
 .S DIR("A",2)="appointment scheduled for "_ORIGAPPT_" for "_$P(^DPT(DVBADFN,0),U,1)
 .S DIR("A",3)=" "
 .S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 K DIC,DA,X,Y
 Q
 ;
STYLE(REQDA) ;** Return indication of 2507 status matching integ report type
 N STATIND,REQSTAT,STYLEIND,PARAMDA
 S STATIND=0 ;**Leave set to zero if STYLEIND=4
 S REQSTAT=$P(^DVB(396.3,REQDA,0),U,18)
 S PARAMDA=0
 S PARAMDA=$O(^DVB(396.1,PARAMDA))
 S STYLEIND=$P(^DVB(396.1,PARAMDA,0),U,15)
 I STYLEIND="1" S:"P^S"[REQSTAT STATIND=1
 I STYLEIND="2" S:"R^C"[REQSTAT STATIND=1
 I STYLEIND="3" S STATIND=1
 Q +STATIND
 ;
SELLNK(REQDA) ;** Return IEN from 396.95 for link to modify
 N SELDA
 D LNKARY^DVBCUTA3(REQDA,DVBADFN) ;**Set up link array
 I '$D(TMP("DVBC LINK")) DO
 .S SELDA=0,DVBANOLK=""
 .D NOLNK^DVBCLKT2
 I $D(TMP("DVBC LINK")) DO
 .I '$D(DVBAAPT) DO
 ..S Y=$P(SDATA,U,3)
 ..X ^DD("DD")
 ..S DVBAAPT=Y
 ..S DVBAAPST=""
 .D LINKDISP^DVBCUTA1
 .I $D(DVBAAPST) K DVBAAPT,DVBAAPST
 K Y
 Q +SELDA
