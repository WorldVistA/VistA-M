SDESCLINICUTIL ;ALB/MGD - VISTA SCHEDULING CLINIC UTILITIES ;NOV 12, 2021
 ;;5.3;Scheduling;**801**;Aug 13, 1993;Build 13
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
PRIVUSR(CLINIC,USER) ;Does the user have access to the Restricted clinic
 ; It is assumed that all validation has been done prior to calling this utility
 N RETURN,I
 S RETURN=0
 I $G(^SC(CLINIC,"SDPROT"))'="Y" S RETURN=1
 E  D
 .S I=0
 .F  S I=$O(^SC(CLINIC,"SDPRIV",I)) Q:I=""  D  Q:RETURN
 ..I +$G(^SC(CLINIC,"SDPRIV",I,0))=USER S RETURN=1
 Q RETURN
