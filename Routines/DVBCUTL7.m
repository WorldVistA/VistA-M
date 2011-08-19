DVBCUTL7 ;ALB/GTS-AMIE C&P APPT LINK FILE MAINT RTNS ; 10/20/94  2:30 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;** NOTICE: This routine is part of an implementation of a Nationally
 ;**         Controlled Procedure.  Local modifications to this routine
 ;**         are prohibited per VHA Directive 10-93-142
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 13)
 ;
ATRBCK ;** Trace Auto-rbkd appt, result: temporary link record based on trace
 ;
 ;** APPTSTAT,APPTNODE must be defined for appt to link before ATRBCK
 ;** APPTNODE is ^DPT(,'S' node (current appt to be linked)
 ;** ^TMP("DVBC",$J,'field name') created - temp link record
 ;** DVBAAPT set by ARYDISP^DVBCUTL6
 ;**  DVBAAPT = appt dte-ext ^ Clinic-ext ^ Status-ext ^ appt dte-int
 ;
 N DVBANEWA,NODEDT
 S ^TMP("DVBC",$J,"INITIAL APPT DATE")=$P(DVBAAPT,U,4)
 S ^TMP("DVBC",$J,"ORIGINAL APPT DATE")=$P(DVBAAPT,U,4)
 S:'$D(^TMP("DVBC",$J,"VETERAN CANCELLATION")) ^TMP("DVBC",$J,"VETERAN CANCELLATION")=0
 S ^TMP("DVBC",$J,"APPOINTMENT STATUS")=1
 S ^TMP("DVBC",$J,"CURRENT APPT DATE")=$P(APPTNODE,U,10) ;**bullet-proof
 I APPTSTAT'="NT",(APPTSTAT["N"!(APPTSTAT["P")) DO  ;**Vet canceled
 .S ^TMP("DVBC",$J,"VETERAN CANCELLATION")=1
 .S ^TMP("DVBC",$J,"VETERAN REQ APPT DATE")=$P(APPTNODE,U,10)
 ;
 ;** First run auto-rbk, FOR  SET returns DVBANEW'=""
 F  S DVBANEWA=$P(APPTNODE,U,10) Q:DVBANEWA=""  DO
 .I $D(^DPT(DVBADFN,"S",DVBANEWA,0)) DO
 ..D STATCK(DVBANEWA,DVBADFN) ;**Set APPTNODE,APPTSTAT - DVBANEWA node
 ..I ^TMP("DVBC",$J,"VETERAN CANCELLATION")'=1 S ^TMP("DVBC",$J,"ORIGINAL APPT DATE")=DVBANEWA
 ..I APPTSTAT'="NT",(APPTSTAT["N"!(APPTSTAT["P")) DO  ;**Vet canc
 ...S ^TMP("DVBC",$J,"VETERAN CANCELLATION")=1
 ...I APPTSTAT["A" DO  ;**Vet canc,Auto-rbk -O get pce 10
 ....S ^TMP("DVBC",$J,"VETERAN REQ APPT DATE")=$P(APPTNODE,U,10)
 ..I APPTSTAT["A" DO  ;**Current=auto-rbk appt
 ...S ^TMP("DVBC",$J,"CURRENT APPT DATE")=$P(APPTNODE,U,10)
 ..I APPTSTAT["A"!(APPTSTAT="I"!(APPTSTAT=""!(APPTSTAT="NT"))) DO
 ...S ^TMP("DVBC",$J,"APPOINTMENT STATUS")=1
 ..I APPTSTAT'["A"&(APPTSTAT'="I"&(APPTSTAT'=""&(APPTSTAT'="NT"))) DO
 ...S ^TMP("DVBC",$J,"APPOINTMENT STATUS")=0
 Q
 ;
NOAUTO ;** ^TMP("DVBA",$J) prepared for FIXLK/ADDLK, no auto-rbk
 ;
 ;** ^TMP("DVBA",$J) KILLed by calling rtn
 ;** DVBAAPT defined before calling NOAUTO
 ;** ^TMP is temp link record
 ;
 S ^TMP("DVBC",$J,"INITIAL APPT DATE")=$P(DVBAAPT,U,4)
 S ^TMP("DVBC",$J,"ORIGINAL APPT DATE")=$P(DVBAAPT,U,4)
 S ^TMP("DVBC",$J,"CURRENT APPT DATE")=$P(DVBAAPT,U,4)
 S:'$D(^TMP("DVBC",$J,"VETERAN CANCELLATION")) ^TMP("DVBC",$J,"VETERAN CANCELLATION")=0
 S:(APPTSTAT="N"!(APPTSTAT="PC")) ^TMP("DVBC",$J,"VETERAN CANCELLATION")=1
 S:'$D(^TMP("DVBC",$J,"VETERAN REQ APPT DATE")) ^TMP("DVBC",$J,"VETERAN REQ APPT DATE")=""
 S ^TMP("DVBC",$J,"APPOINTMENT STATUS")=0
 S:APPTSTAT="I"!(APPTSTAT="NT"!(APPTSTAT="")) ^TMP("DVBC",$J,"APPOINTMENT STATUS")=1
 Q
 ;
STATCK(APPTDTIN,DVBADFN) ;** Check current appt status
 ;** APPTNODE,APPTSTAT KILLed by calling rtn
 S APPTNODE=^DPT(DVBADFN,"S",APPTDTIN,0)
 S APPTSTAT=$P(APPTNODE,U,2)
 Q
