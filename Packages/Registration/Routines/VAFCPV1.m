VAFCPV1 ;ALB/PKE PV1 segment for message builder;
 ;;5.3;Registration;**91,298**;Jun 06, 1996
 ;
 ;07/07/00 ACS - Added sequence 21 (physical treating specialty - ward
 ;location) and sequence 39 (facility+suffix) to the inpatient string
 ;of fields.  Added sequence 39 to the outpatient string of fields.
 ;
 ;set the v2.3 PV1
 ;called from VAFCMSG3
EN(DFN) ;if not a scheduling event and an inpatient
 I $G(@EVNTINFO@("SERVER PROTOCOL"))'="VAFC ADT-A08-SDAM SERVER"
 IF  I $G(^DPT(DFN,.1))]"" DO
 .;get inpatient pv1
 . S VAFSTR="2,3,6,7,10,18,21,39,44,45,50"
 . S PV1=$$EN^VAFHAPV1(DFN,EVNTDATE,VAFSTR)
 E  DO
 .;get outpatient pv1
 . S VAFSTR="2,3,7,18,39,44,50"
 . N EVENT,VPTR
 . S EVENT=$G(@EVNTINFO@("EVENT-NUM"))
 .  S VPTR=$G(@EVNTINFO@("VAR-PTR"))
 . S PV1=$$OPV1^VAFHCPV(DFN,EVENT,EVNTDATE,VPTR,VAFSTR,1)
 ;
 Q PV1
