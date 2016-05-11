SDEC58 ;ALB/SAT - VISTA SCHEDULING RPCS ;APR 08, 2016
 ;;5.3;Scheduling;**627,642**;Aug 13, 1993;Build 23
 ;
 Q
 ;
 ;Compensation & Pension Appointments RPC
 ;SDECY    = global variable return
 ;DFN      = patient IEN (required)
 ;SDAMEVT  = event type (1=make appt,2=cancel,3=no show) (required)
 ;SDT      = original appt date/time (required)
 ;SDAUTORB = set to 1 if auto rebook (optional)
 ;SDCANVET = set to 1 if appt cancelled by VET (optional)
CAP(SDECY,DFN,SDAMEVT,SDT,SDAUTORB,SDCANVET) ;
 ;** Variable Descriptions
 ;** SDAMEVT = 1 Make appointment event
 ;**           2 Cancel appointment event
 ;**           3 No Show appointment event
 ;** I DVBAAUTO exists, AMIE Make Event is not executed because
 ;**  cancel/no show part of auto-rebook updated 396.95
 ;** SDT   = Time In
EN ;**AMIE Scheduling event driver main entry point
 N SDECI,DVBADFN,SDERR
 S SDECY="^TMP(""SDEC58"","_$J_",""CAP"")"
 K @SDECY
 S SDECI=0,SDERR=0
 S @SDECY@(SDECI)="T00020RETURNCODE^T00100TEXT"_$C(30)
 I $G(DFN)']"" S SDECI=SDECI+1,@SDECY@(SDECI)="-1^Invalid Patient DFN"_$C(30) S SDERR=1 G XIT
 I $G(SDT)']"" S SDECI=SDECI+1,@SDECY@(SDECI)="-1^Invalid Original Appt Date and Time"_$C(30) S SDERR=1 G XIT
 ;auto rebook variable
 S:+$G(SDAUTORB) DVBAAUTO=""
 ;appt cancelled by VET variable
 S:+$G(SDCANVET) DVBAVTRQ=""
 S DVBATYPE=$P($G(^DPT(DFN,"S",SDT,0)),U,16)
 ;appt type must be COMPENSATION & PENSION
 I +DVBATYPE=1 D
 .I +SDAMEVT=1,('$D(DVBAAUTO)) D EN1 ;** Original Make event (SDAMEVT=1)
 .I +SDAMEVT=1,($D(DVBAAUTO)) K DVBAAUTO ;** Auto-rebook Make event (SDAMEVT=1)
 .I +SDAMEVT=2!(+SDAMEVT=3) D EN2 ;** Cancel/No show event (SDAMEVT=2 or 3)
 K DVBATYPE
 S:SDERR=0 SDECI=SDECI+1,@SDECY@(SDECI)="0^No Error"_$C(30)
XIT ;
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 D KVARS
 Q
EN1 ;
 S DVBADFN=DFN,DVBASTAT="P" ;DVBASTAT used in REQARY^DVBCUTL5
 D GETIEN
 Q:SDERR=1
 D LINKAPPT
 D KVARS
 Q
LINKAPPT ;
 ;**No appointments exist for 2507
 I '$D(^DVB(396.95,"AR",DVBADA)) D CRTREC
 Q
CRTREC ;
 S DVBAADT=SDT
 S DIC="^DVB(396.95,",X=DVBAADT,DIC(0)="LX",DLAYGO="396.95"
 S DIC("DR")=".02////^S X=DVBAADT;.03////^S X=DVBAADT;"
 S DIC("DR")=DIC("DR")_".04////^S X=0;.06////^S X=DVBADA;"
 S DIC("DR")=DIC("DR")_".07////^S X=1"
 D FILE^DICN
 K DIC,X,DLAYGO,DVBAADT
 Q
KVARS ;** Kill variables used by scheduling protocol
 K DVBADA,DVBASTAT,SDAUTORB,SDCANVET,Y
 Q
EN2 ;
 ;**Find the respective AMIE appointment record
 S DVBASTAT=$P($G(^DPT(DFN,"S",SDT,0)),U,2)
 ;**Get the date being canceled
 S DVBACURA=SDT
 S (DVBAAPDA,DVBALKDA)=""
 S DVBAUPDT=0
 K DVBAFND
 S LNKCNT=0
 F  S DVBAAPDA=$O(^DVB(396.95,"CD",DVBACURA,DVBAAPDA)) Q:(DVBAAPDA="")  D
 .S DVBARQDA=$P(^DVB(396.95,DVBAAPDA,0),U,6)
 .I $P(^DVB(396.3,DVBARQDA,0),U,1)=DFN D
 ..S LNKCNT=LNKCNT+1
 ..S:(+$P(^DVB(396.95,DVBAAPDA,0),U,7)=1) DVBAFND="",DVBALKDA=DVBAAPDA
 ..I '$D(DVBAFND),($P(^DVB(396.95,DVBAAPDA,0),U,8)>DVBAUPDT) D
 ...S DVBAUPDT=$P(^DVB(396.95,DVBAAPDA,0),U,8) ;**Keep latest cancel dte
 ...S DVBALKDA=DVBAAPDA ;**Keep DA of rec last cancelled
 I (DVBASTAT="PCA")!((DVBASTAT="NA")!(DVBASTAT="CA")) S DVBAAUTO=""
 ;
 ;auto-rbk
 I $D(DVBAAUTO),($D(DVBAFND)!('$D(DVBAFND)&(+LNKCNT>0))) D
 .S DVBAAPDT=$P($G(^DPT(DFN,"S",SDT,0)),U,10)
 .K DVBAVTRQ ;**Set if appointment canceled by vet
 .S:(DVBASTAT["P"!(DVBASTAT["N"&(DVBASTAT'="NT"))) DVBAVTRQ=""
 .;Update Appt record with reschedule data
 .D RSCHAPT(DVBALKDA,DVBAAPDT)
 I '$D(DVBAAUTO),$D(DVBAFND) D  ;**Appt linked, not Auto
 .D CANCEL
 I +LNKCNT>1 D
 .S SDECI=SDECI+1,@SDECY@(SDECI)="-1^This C&P appointment has multiple links with the same Current Appt Date."_$C(30)
 .S SDERR=1
 D KVARS2
 Q
KVARS2 ;
 K DVBAAPDA,DVBAFND,DVBASTAT,DVBAAPDT,DVBARQDA
 K DVBAVTRQ,DVBALKDA,LNKCNT,DVBAUPDT,DVBACURA
 Q
CANCEL ;** Cancel C&P Appt
 N DVBCUPDT
 D NOW^%DTC
 S DVBCUPDT=%
 K %,X
 S DA=+DVBALKDA,DIE="^DVB(396.95,",DR=""
 I DVBASTAT["PC"!(DVBASTAT["N"&(DVBASTAT'="NT")) D
 .S DR=".04////^S X=1;" ;** Set .04 if vet cancel
 S DR=DR_".07////^S X=0;.08////^S X=DVBCUPDT"
 D ^DIE K DA,DIE,DR
 Q
 ;
RSCHAPT(LKDA,RSCHDT) ;** Update Appt record with reschedule data
 S DA=+LKDA,DIE="^DVB(396.95,",DR=".03////^S X=RSCHDT;.07////1"
 S:(+$P(^DVB(396.95,DA,0),U,4)=0&('$D(DVBAVTRQ))) DR=".02////^S X=RSCHDT;"_DR
 S:($D(DVBAVTRQ)) DR=".04////^S X=1;.05////^S X=RSCHDT;"_DR
 D ^DIE K DA,DIE,DR
 Q
 ;
GETIEN ;Get IEN for 2507 REQUEST file
 N DVBACNT,DVBADT,DVBAORD,DVBASDPR
 K ^TMP("DVBC",$J)
 S (DVBADA,DVBASDPR)=""
 D REQARY^DVBCUTL5 ;**Set up ^TMP of AMIE 2507's
 I +DVBACNT>0 D
 .I +DVBACNT=1 D  ;**Auto select 2507 if only one exists
 ..S (DVBADT,DVBADA,DVBAORD)=""
 ..S DVBAORD=$O(^TMP("DVBC",$J,DVBAORD))
 ..S DVBADT=$O(^TMP("DVBC",$J,DVBAORD,DVBADT))
 ..S DVBADA=$O(^TMP("DVBC",$J,DVBAORD,DVBADT,DVBADA))
 .I +DVBACNT>1 D  ;**If more than one 2507 exists
 ..S SDECI=SDECI+1,@SDECY@(SDECI)="-1^More than one 2507 request exisits for this patient!"_$C(30)
 ..S SDERR=1
 .K ^TMP("DVBC",$J)
 .Q:SDERR=1
 .I '$D(^DVB(396.3,+DVBADA,0)),(+$$ENHNC^DVBCUTA4=1) D  Q  ;**Write warning
 ..S SDECI=SDECI+1,@SDECY@(SDECI)="-1^You have not selected a 2507 request to link the C&P appointment to."_$C(30)
 ..S SDECI=SDECI+1,@SDECY@(SDECI)="-1^ The appointment should be linked with the AMIE/C&P Appointment Link"_$C(30)
 ..S SDECI=SDECI+1,@SDECY@(SDECI)="-1^ Management Option to ensure proper processing time calculation for this 2507"_$C(30)
 ..S SDECI=SDECI+1,@SDECY@(SDECI)="-1^ in the event of a veteran cancellation."_$C(30)
 ..S SDERR=1
 .I $D(^DVB(396.3,+DVBADA,0)) D LINKAPPT ;**If 2507, link appt
 I +DVBACNT'>0,(+$$ENHNC^DVBCUTA4=1) D  ;**Write Warning
 .S SDECI=SDECI+1,@SDECY@(SDECI)="-1^You have made a C&P appointment for a patient who has no pending 2507 request!"_$C(30)
 .S SDERR=1
 Q
 ;
