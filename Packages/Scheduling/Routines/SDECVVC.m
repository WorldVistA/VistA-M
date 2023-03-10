SDECVVC ;ALB/WTC - VISTA SCHEDULING RPCS ;JUN 12, 2020@10:15
 ;;5.3;Scheduling;**756**;Aug 13, 1993;Build 43
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q  ;
 ;
VVCAPPT(SDECY,SDECAPPT) ;
 ;
 ;  SDEC VVC_APPT RPC
 ;
 ;  Returns VVC Web app URL if appointment is for VVC clinic or null if not.
 ;
 ;  SDECAPPT = Appointment (pointer to #409.84)
 ;
 S SDECY="^TMP(""SDECSTNG"","_$J_",""VVC_APPT"")" ;
 K @SDECY ;
 ;
 S @SDECY@(0)="T01000URL"_$C(30) ;
 ;
 I +$G(SDECAPPT)=0 S @SDECY@(1)=$C(30)_$C(31) Q  ;
 I '$D(^SDEC(409.84,SDECAPPT)) S @SDECY@(1)=$C(30)_$C(31) Q  ;
 ;
 N SDECRES,SDEC44,SDECSTOP,SDECREDT ;
 ;
 ;  Appointment's resource
 ;
 S SDECRES=$P($G(^SDEC(409.84,SDECAPPT,0)),U,7) I 'SDECRES S @SDECY@(1)=$C(30)_$C(31) Q  ;
 ;
 ;  Resource's clinic
 ;
 S SDEC44=$P($G(^SDEC(409.831,SDECRES,0)),U,4) I 'SDEC44 S @SDECY@(1)=$C(30)_$C(31) Q  ;
 ;
 ;  Clinic's stop code and credit stop code.
 ;
 S SDECSTOP=$P($G(^SC(SDEC44,0)),U,7),SDECREDT=$P(^(0),U,18) ;
 I SDECSTOP S SDECSTOP=$P($G(^DIC(40.7,SDECSTOP,0)),U,2) ;
 I SDECREDT S SDECREDT=$P($G(^DIC(40.7,SDECREDT,0)),U,2) ;
 ;
 I 'SDECSTOP,'SDECREDT S @SDECY@(1)=$C(30)_$C(31) Q  ;  No stop codes so no URL.
 ;
 ;  If clinic's stop code or credit stop code is for VVC, return URL for VVC Web app
 ;
 I SDECSTOP'="",$O(^SDEC(409.98,1,3,"B",SDECSTOP,0))>0 S @SDECY@(1)=$G(^SDEC(409.98,1,2))_$C(30)_$C(31) Q  ;
 I SDECREDT'="",$O(^SDEC(409.98,1,3,"B",SDECREDT,0))>0 S @SDECY@(1)=$G(^SDEC(409.98,1,2))_$C(30)_$C(31) Q  ;
 ;
 ;  Not a VVC clinic.
 ;
 S @SDECY@(1)=$C(30)_$C(31) Q  ;
 ;
 Q  ;
 ;
