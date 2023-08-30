SDESGETSTOPCD ;ALB/ANU - VISTA SCHEDULING RPCS - SDES GET CLINIC STOPCD ;JAN 24, 2023
 ;;5.3;Scheduling;**836**;Aug 13, 1993;Build 20
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to $$GET1^DIQ in ICR #2056
 ;
 Q
 ;
GETSTOPCD(JSONRETURN,SDP) ;return entries from the SDEC CLINIC STOP FILE (#40.7)
 ;INPUT:
 ;  SDP - (Optional) Partial Text
 ;RETURN:
 ;  List of entries from the CLINIC STOP file (#40.7)
 ;  - IEN
 ;  - Code
 ;  - Name 
 ;
 N RETURN,ERRORS,HASFIELDS,RETURN,ELGFIELDSARRARY
 ;
 S HASFIELDS=$$CLINSTOP(.ELGFIELDSARRAY,$G(SDP))
 I HASFIELDS M RETURN=ELGFIELDSARRAY
 I '$D(RETURN("ClinicStopCodes")) S RETURN("ClinicStopCodes",1)=""
 ;
 D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.RETURN)
 D CLEANUP
 Q
 ;
CLINSTOP(ELGARRAY,SDP) ;SDES GET CLINIC STOPCD remote procedure
 ;return entries from the CLINIC STOP file (#40.7)
 N SDESC,SDESI,SDIEN,SDINACTDT,SDESN,HASDATA
 ;
 S SDESI=0
 S SDP=$G(SDP)
 S SDESN=$S(SDP'="":$$GETSUB^SDECU(SDP),1:"") ;set SDESN to partial name
 F  S SDESN=$O(^DIC(40.7,"B",SDESN)) Q:SDESN=""  Q:(SDP'="")&(SDESN'[SDP)  D   ;check if within partial name bounds
 .S SDESC="" F  S SDESC=$O(^DIC(40.7,"B",SDESN,SDESC)) Q:SDESC=""  D
 ..S SDINACTDT=$$GET1^DIQ(40.7,SDESC_",",2,"I")
 ..I SDINACTDT'="",$P(SDINACTDT,".",1)'>$P($$NOW^XLFDT,".",1) Q
 ..S SDESI=SDESI+1
 ..S ELGARRAY("ClinicStopCodes",SDESI,"IEN")=SDESC
 ..S ELGARRAY("ClinicStopCodes",SDESI,"Code")=$$GET1^DIQ(40.7,SDESC_",",1,"E")
 ..S ELGARRAY("ClinicStopCodes",SDESI,"Name")=$$GET1^DIQ(40.7,SDESC_",",.01,"E")
 S HASDATA=($D(ELGARRAY)>1)
 Q HASDATA
 ;
CLEANUP ;
 K RETURN,HASFIELDS,ELGFIELDSARRAY
 Q
 ;
