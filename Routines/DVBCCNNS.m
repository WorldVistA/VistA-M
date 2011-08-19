DVBCCNNS ;ALB/GTS-AMIE C&P APPT EVENT DRIVER ; 10/20/94  9:30 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;** NOTICE: This routine is part of an implementation of a Nationally
 ;**         Controlled Procedure.  Local modifications to this routine
 ;**         are prohibited per VHA Directive 10-93-142
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 ;
 ;** Variable Descriptions
 ;**    DVBAAUTO - prevents AMIE Make Event on an Auto-rebook
 ;**                NOTE: DVBAAUTO killed by ^DVBCSDEV
 ;**    DVBASTAT - Status of appointment being canceled/no showed
 ;**    DVBACURA - Appointment date/time being canceled/no showed
 ;**    DVBAAPDA - IEN of record in file 396.95
 ;**    DVBAFND  - Defined if appt canceled/no showed found in 396.95
 ;**    DVBAAPDT - New appt date on auto-rebook
 ;**    DVBAVTRQ - Defined if appt canceled by vet
 ;**    DVBACROT - External value of DVBACURA
 ;**    LNKCNT   - # of link records with current date = canceled date
 ;**    DVBAUPDT - Last dte cncl'd - cncled 396.95 recs, Cur Dte=cncl dt
 ;
EN ;**Find the respective AMIE appointment record
 S DVBASTAT=$$SDEVTSPC^DVBCUTL5(2)
 S DVBACURA=$P(SDATA,U,3) ;**Get the date being canceled
 S (DVBAAPDA,DVBALKDA)=""
 S DVBAUPDT=0
 K DVBAFND
 S LNKCNT=0
 F  S DVBAAPDA=$O(^DVB(396.95,"CD",DVBACURA,DVBAAPDA)) Q:(DVBAAPDA="")  DO
 .S DVBARQDA=$P(^DVB(396.95,DVBAAPDA,0),U,6)
 .I ($P(^DVB(396.3,DVBARQDA,0),U,1)=DFN) DO
 ..S LNKCNT=LNKCNT+1
 ..S:(+$P(^DVB(396.95,DVBAAPDA,0),U,7)=1) DVBAFND="",DVBALKDA=DVBAAPDA
 ..I '$D(DVBAFND),($P(^DVB(396.95,DVBAAPDA,0),U,8)>DVBAUPDT) DO
 ...S DVBAUPDT=$P(^DVB(396.95,DVBAAPDA,0),U,8) ;**Keep latest cancel dte
 ...S DVBALKDA=DVBAAPDA ;**Keep DA of rec last cancelled
 I (DVBASTAT="PCA")!((DVBASTAT="NA")!(DVBASTAT="CA")) S DVBAAUTO=""
 ;
 ;** Appt not linked, enhnc dilog on, not processing in background
 I (LNKCNT=0)&((+$$ENHNC^DVBCUTA4=1)&('$D(ZTQUEUED))) DO
 .N DVBACROT S Y=DVBACURA X ^DD("DD") S DVBACROT=Y K Y
 .S DIR("A",1)=" "
 .S DIR("A",2)="Appointment "_DVBACROT_" was not linked to a 2507 request or was"
 .S DIR("A",3)=" manually rebooked and linked to another appointment."
 .S DIR("A",4)=" (If the appointment was manually rebooked, you do not want to auto-rebook.)"
 .S DIR("A",5)=" "
 .S DIR("A",6)="If the appointment was not properly linked, it will need to be linked with the"
 .S DIR("A",7)=" AMIE/C&P appointment link management option."
 .S DIR("A",8)=" "
 .S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue." D ^DIR K DIR,X,Y
 I $D(DVBAAUTO),($D(DVBAFND)!('$D(DVBAFND)&(+LNKCNT>0))) DO  ;**Auto-rbk
 .S:(+$$SDEVTXST^DVBCUTL5=1) DVBAAPDT=$$SDEVTSPC^DVBCUTL5(10)
 .K DVBAVTRQ ;**Set if appointment canceled by vet
 .S:(DVBASTAT["P"!(DVBASTAT["N"&(DVBASTAT'="NT"))) DVBAVTRQ=""
 .D RSCHAPT^DVBCMKLK(DVBALKDA,DVBAAPDT)
 .D:((+$$ENHNC^DVBCUTA4=1)&('$D(ZTQUEUED))) CNCMSG
 I '$D(DVBAAUTO),($D(DVBAFND)) DO  ;**Appt linked, not Auto
 .D CANCEL
 .D:((+$$ENHNC^DVBCUTA4=1)&('$D(ZTQUEUED))) CNCMSG
 I +LNKCNT>1 DO
 .S DIR("A",1)=" "
 .S DIR("A",2)="This C&P appointment has multiple links with the same Current Appt Date."
 .S DIR("A",3)="Use the AMIE/C&P Appointment Link Management option to review and delete"
 .S DIR("A",4)=" any duplicate links."
 .S DIR("A",5)=" "
 .S DIR(0)="FAO^1:1",DIR("A")="Hit any key to continue." D ^DIR K DIR,X,Y
 D KVARS
 Q
 ;
CNCMSG ;** Write message indicating link updated
 N DVBAINIT,DVBACROT,DVBARBDT
 K Y S Y=$P(^DVB(396.95,+DVBALKDA,0),U,1)
 X ^DD("DD") S DVBAINIT=Y
 K Y S Y=DVBACURA
 X ^DD("DD") S DVBACROT=Y K Y
 I $D(DVBAAUTO) DO
 .S Y=DVBAAPDT
 .X ^DD("DD") S DVBARBDT=Y K Y
 S DIR("A",1)=" "
 S DIR("A",2)="AMIE C&P Appt Link update"
 S DIR("A",3)="Initial Appt Date: "_DVBAINIT
 S DIR("A",4)="Current Appt Date: "_DVBACROT
 S:'$D(DVBAAUTO) DIR("A",5)="has been cancelled!"
 S:$D(DVBAAUTO) DIR("A",5)="has been cancelled and rebooked for "_DVBARBDT_"!"
 S DIR("A",6)=" "
 S DIR(0)="FAO^1:1",DIR("A")="Hit any key to continue." D ^DIR K DIR,X,Y
 Q
 ;
CANCEL ;** Cancel C&P Appt
 N DVBCUPDT
 D NOW^%DTC
 S DVBCUPDT=%
 K %,X
 S DA=+DVBALKDA,DIE="^DVB(396.95,",DR=""
 I DVBASTAT["PC"!(DVBASTAT["N"&(DVBASTAT'="NT")) DO
 .S DR=".04////^S X=1;" ;** Set .04 if vet cancel
 S DR=DR_".07////^S X=0;.08////^S X=DVBCUPDT"
 D ^DIE K DA,DIE,DR
 Q
 ;
KVARS ;
 K DVBAAPDA,DVBAFND,DVBCCURA,DVBASTAT,DVBAAPDT,DVBARQDA
 K DVBAVTRQ,DVBALKDA,LNKCNT,DVBAUPDT
 Q
