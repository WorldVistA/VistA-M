ORX3 ; slc/CLA - Support reference (DBIA #868) for notifications ;11/19/96  10:50
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9**;Dec 17, 1997
 Q
NOTE ;called by DGOERNOT - triggered by MAS protocols, options and fields in the patient file
 ;
 ;notifications triggered by DGOERNOT:
 ;18 - ADMISSION
 ;19 - UNSCHEDULED VISIT
 ;20 - DECEASED PATIENT
 ;
 ;possible variables:
 ;ORNOTE     array of Notification file iens (#100.9) [req'd]
 ;ORVP       ien from Patient file (#2) [req'd]
 ;ORBADUZ    array of pkg-defined recipient DUZs [optional]
 ;ORBPMSG    pkg-defined message [optional]
 ;ORBXDATA   pkg-defined data for follow-up action [optinal]
 ;
 Q:'$D(ORNOTE)  Q:'$D(ORVP)
 N ORN,ORBDFN,DA
 S ORBDFN=$P(ORVP,";")
 S:'$L($G(ORBADUZ)) ORBADUZ=""
 S:'$L($G(ORBPMSG)) ORBPMSG=""
 S:'$L($G(ORBXDATA)) ORBXDATA=""
 S ORN=0,ORN=$O(ORNOTE(ORN)) Q:'ORN  I $D(^ORD(100.9,ORN)) D
 .;if not Admission notification (#18), send to OE/RR 3 entry point
 .;(Admission notif is triggered by Patient Admission MLM)
 .I $G(ORN)'=18 D EN^ORB3(ORN,ORBDFN,"",ORBADUZ,ORBPMSG,ORBXDATA)
 K ORBADUZ,ORBPMSG,ORBXDATA,ORNOTE,ORVP
 Q
