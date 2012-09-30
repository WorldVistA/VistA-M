VDEFP11 ;ALB/CJM - VDEF Patch Post Install ;01/26/2012
 ;;1.0;VDEF;**11**;Dec 28, 2004;Build 9
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
POST ;
 N QUEUE,TIME
 S QUEUE=0
 S TIME=60*60*24*30 ;archive time in seconds = 30 days
 F  S QUEUE=$O(^VDEFHL7(579.3,QUEUE)) Q:'QUEUE  S:$P($G(^VDEFHL7(579.3,QUEUE,0)),"^",4)<TIME $P(^VDEFHL7(579.3,QUEUE,0),"^",4)=TIME
 Q
 ;
 ;
 ;
 ;
 ;
 ;
