DVBCLKTL ;ALB/GTS-AMIE C&P APPT LINK MNGT ROUTINE ; 10/20/94  10:30 PM
 ;;2.7;AMIE;**1**;Apr 10, 1995
 ;
 ;** NOTICE: This routine is part of an implementation of a Nationally
 ;**         Controlled Procedure.  Local modifications to this routine
 ;**         are prohibited per VHA Directive 10-93-142
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 ;
EN ;** Main entry point
 K ^TMP("DVBC",$J)
 D HOME^%ZIS
 K DVBASUPR
 S:$D(^XUSEC("DVBA C SUPERVISOR",DUZ)) DVBASUPR=""
 ;** Select a C&P patient
 F  D HDR S DVBADFN=$$REQPAT^DVBCUTL5 D:+DVBADFN>0 MAINPROC Q:+DVBADFN'>0
 K DVBASUPR,DVBADFN
 Q
 ;
MAINPROC ;
 D CPPATARY^DVBCUTL5(DVBADFN) ;**^TMP - array of 2507's for patient
 I +DVBACNT=1 D AUTO2507 ;**S/W select the 2507 if only one exists
 I +DVBACNT>1 D USEL2507 ;**More than 1 2507 exists, user selects
 S:'$D(DVBADA) DVBADA=""
 I '$D(^DVB(396.3,+DVBADA,0)) D NO2507^DVBCUTL5 ;**No 2507 sel'd, error
 ;
 ;** If 2507 selected, allow link adjustment
 I $D(^DVB(396.3,+DVBADA,0)) DO  ;**Output current appointments
 .D EXMDISP^DVBCUTL6(DVBADA) ;**Display the exams
 .S DIR(0)="FAO^1:1",DIR("A")="Hit Return to continue with appointment display."
 .S DIR("A",1)=" " D ^DIR K DIR,X,Y
 .F  Q:($D(DVBAOUT))  DO
 ..D APPTSEL^DVBCUTL6($P(^DVB(396.3,DVBADA,0),U,1),1,DVBADA,$P(^DVB(396.3,DVBADA,0),U,5))
 ..I '$D(^TMP("DVBC",$J,2)),(DVBAAPT="") DO  ;**No C&P appt's
 ...D:'$D(DVBAOUT) NOAPTERR^DVBCLKT2
 ..I '$D(DVBAAPT),($D(^TMP("DVBC",$J,2))) DO  ;**No appt selected
 ...D:'$D(DVBAOUT) APPTERR^DVBCLKT2
 ..I $D(DVBAAPT),($D(^TMP("DVBC",$J,2))&(DVBAAPT="")) DO
 ...D:'$D(DVBAOUT) APPTERR^DVBCLKT2
 ..I $D(DVBAAPT),(DVBAAPT'="") DO
 ...K DVBADEL
 ...I $D(DVBASUPR),($D(^DVB(396.95,"AB",+DVBADA,$P(DVBAAPT,U,4)))) D DELCK^DVBCLKT2 DO
 ....I $D(DVBADEL) D DODEL^DVBCLKT2
 ...I '$D(DVBASUPR),($D(^DVB(396.95,"AB",+DVBADA,$P(DVBAAPT,U,4)))) DO DELERR^DVBCLKT2
 ...I '$D(^DVB(396.95,"AB",+DVBADA,$P(DVBAAPT,U,4))),('$D(DVBADEL)) D LINKPROC
 ..K DVBAMORE,DVBALP,DVBADT,DVBAORD,DVBASEL,DVBAAPT
 ..K APPTSTAT,APPTNODE,DVBALKDA,DVBCADLK,DVBCOLAP,DVBADEL
 K ^TMP("DVBC",$J),DVBAOUT,DVBADTOT,DVBAPNAM,DVBADA
 Q
 ;
AUTO2507 ;If only 1 2507, select it
 ;**  DVBADA is the IEN of the selected 2507 request
 N DVBADT,DVBAORD
 S (DVBADT,DVBADA,DVBAORD)=""
 S DVBAORD=$O(^TMP("DVBC",$J,DVBAORD))
 S DVBADT=$O(^TMP("DVBC",$J,DVBAORD,DVBADT))
 S DVBADA=$O(^TMP("DVBC",$J,DVBAORD,DVBADT,DVBADA))
 K ^TMP("DVBC",$J)
 Q
 ;
LINKPROC ;Link appt to 2507
 D LNKQS^DVBCLKT2 ;**Add link or modify existing link
 K DVBCADLK S:+Y=0 DVBCADLK="" S DVBAYVAL=Y K Y
 N DVBAOUT S:$D(DTOUT) DVBAOUT=""
 ;
 ;** If Appt, either add to 396.95 or modify an existing link
 ;** APPTNODE and APPTSTAT from 'S' node of appt selected to link
 I $D(DVBCADLK),(DVBAYVAL'="^"),('$D(DVBAOUT)) DO  ;**Add Link
 .D STATCK^DVBCUTL7($P(DVBAAPT,U,4),DVBADFN) ;**Set APPTNODE,APPTSTAT
 .S SAVESTAT=APPTSTAT
 .I SAVESTAT["A" D ATRBCK^DVBCUTL7,ADDLK^DVBCUTL8 ;**Link lost: Auto-rbk
 .I SAVESTAT'["A" D NOAUTO^DVBCUTL7,ADDLK^DVBCUTL8 ;**Link lost: non-auto
 I '$D(DVBCADLK),(DVBAYVAL'="^"),('$D(DVBAOUT)) DO  ;**Rebook Link
 .S DVBAOLDA=$$SELLNK^DVBCUTL8(DVBADA)
 .I +DVBAOLDA'>0,('$D(DVBANOLK)) D ERRMESS^DVBCLKT2
 .I +DVBAOLDA>0 DO
 ..S OLDSTAT=$P(^DPT(DVBADFN,"S",$P(^DVB(396.95,DVBAOLDA,0),U,3),0),U,2)
 ..I OLDSTAT["P"!(OLDSTAT["N"&(OLDSTAT'="NT")) DO
 ...S ^TMP("DVBC",$J,"VETERAN CANCELLATION")=1
 ...S ^TMP("DVBC",$J,"VETERAN REQ APPT DATE")=$P(DVBAAPT,U,4)
 ..D STATCK^DVBCUTL7($P(DVBAAPT,U,4),DVBADFN) ;**Set APPTNODE,APPTSTAT
 ..S SAVESTAT=APPTSTAT ;**APPTNODE,APPTSTAT used in subroutines
 ..I SAVESTAT["A" D ATRBCK^DVBCUTL7,FIXLK^DVBCUTL8 ;**Link lost:Auto-rbk
 ..I SAVESTAT'["A" D NOAUTO^DVBCUTL7,FIXLK^DVBCUTL8 ;**Link lost:non-auto
 K SAVESTAT,OLDSTAT,DVBAYVAL,DVBANOLK
 Q
 ;
USEL2507 ;**User select 2507
 D REQSEL^DVBCUTL5 ;**Select 2507 from ^TMP
 I (+Y'>0)!($D(DVBAOUT)) S DVBADA=""
 S:+Y>0 DVBASEL=+Y ;**Y selected 2507 value returned from ^DIR
 D:+Y>0 FINDDA^DVBCUTL5 ;**Find selected 2507 DA (Return DVBADA)
 K ^TMP("DVBC",$J)
 Q
 ;
HDR ;** Veteran selection header
 W @IOF,!!,?18,"AMIE/C&P Appointment Link Management",!!
 I $D(DVBASUPR) W !,"As a Supervisor, you may remove 2507 appointment links",!!
 Q
