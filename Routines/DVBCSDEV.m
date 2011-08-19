DVBCSDEV ;ALB/GTS-AMIE C&P APPT EVENT DRIVER ; 10/19/94  3:45 PM
 ;;2.7;AMIE;**1**;Apr 10, 1995
 ;
 ;** NOTICE: This routine is part of an implementation of a Nationally
 ;**         Controlled Procedure.  Local modifications to this routine
 ;**         are prohibited per VHA Directive 10-93-142
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 ;
 ;** Variable Descriptions
 ;** DVBAORG = 1 Appointment event (Originating process variable)
 ;** SDAMEVT = 1 Make appointment event
 ;**           2 Cancel appointment event
 ;**           3 No Show appointment event
 ;** I DVBAAUTO exists, AMIE Make Event is not executed because
 ;**  cancel/no show part of auto-rebook updated 396.95
 ;** DVBAXST=1 - ^TMP("SDEVT",$J) exists
 ;** DVBATYPE=1 - C&P type appointment
 ;
EN ;**AMIE Scheduling event driver main entry point
 K KDFN I '$D(DFN) N DFN S DFN=$P(SDATA,U,2),KDFN=""
 S DVBAORG=$$SDORGST^DVBCUTL5
 I +DVBAORG=1 DO
 .S DVBAXST=$$SDEVTXST^DVBCUTL5
 .I +DVBAXST=1 DO
 ..S DVBATYPE=$$SDEVTSPC^DVBCUTL5(16)
 ..I +DVBATYPE=1 DO
 ...I +SDAMEVT=1,('$D(DVBAAUTO)) D EN^DVBCMKLK ;** Original Make event
 ...I +SDAMEVT=1,($D(DVBAAUTO)) K DVBAAUTO ;** Auto-rebook Make event
 ...I +SDAMEVT=2!(+SDAMEVT=3) D EN^DVBCCNNS ;** Cancel/No show event
 ..K DVBATYPE
 .K DVBAXST
 K DVBAORG
 I $D(KDFN) K KDFN,DFN
 D KVARS^DVBCMKLK
 Q
