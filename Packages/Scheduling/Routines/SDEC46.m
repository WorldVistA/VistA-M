SDEC46 ;ALB/SAT - VISTA SCHEDULING RPCS ;FEB 04, 2016
 ;;5.3;Scheduling;**627,643**;Aug 13, 1993;Build 14
 ;
 Q
 ;
CURFACG(SDECY,SDECDUZ) ;get current division/facility for given user
 ;CURFACG(SDECY,SDECDUZ)  external parameter tag is in SDEC
 ; SDECDUZ = user IEN from the NEW PERSON file 200
 ; returns the Current Division/Facility for the given user
 N SDECCD,SDECI,SDECSUB
 S SDECI=0
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S ^TMP("SDEC",$J,0)="T00020ERROR_ID"_$C(30)
 ;check if valid user
 I $G(SDECDUZ)="" D ERR("0^SDEC46: User not specified.") Q
 I '$D(^VA(200,SDECDUZ)) D ERR("0^SDEC46: Invalid user specified.") Q
 S ^TMP("SDEC",$J,0)="T00020CURRENT_DIV"_$C(30)
 S SDECSUB="^VA(200,"_SDECDUZ_",""2"","
 S SDECCD=$G(^DISV(SDECDUZ,SDECSUB))
 I SDECCD'="" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDECCD_$C(30)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
GETFAC(SDECY,SDECDUZ) ;Gets all facilities for a user
 ;GETFAC(SDECY,SDECDUZ)  external parameter tag is in SDEC
 ; Input SDECDUZ - (required) user IEN from the NEW PERSON file 200
 ; Returns:
 ;Global Array in which each array entry
 ;contains the following ^ pieces:
 ;    DIV_IEN  = institution Id pointer to the INSTITUTION file 4
 ;               NOTE field in file 200 uses the term DIVISION but the
 ;               field points to the INSTITUTION file.
 ;    DIV_NAME = institution NAME from the INSTITUTION file
 ;    DEFAULT  = Is default division/facility?
 ;               Value can be 'YES' or 'NO'
 ;    TZ_CODE  = CODE from the MAILMAN TIME ZONE file 4.4
 ;    TZ_NAME  = TIME ZONE NAME from the MAILMAN TIME ZONE file
 ;    TZ_DIFF  = DIFFERENTIAL from the MAILMAN TIME ZONE file
 ;  7. DIALOGUE = Allow appointment dialogue
 ;                0=NO  (off)
 ;                1=YES (on) display and ask
 N SDECFN,SDECI,SDECN,SDECNOD,SDIAL,SDTMP,SDTZ,SDTZN
 S SDECI=0
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S ^TMP("SDEC",$J,0)="T00020ERROR_ID"_$C(30)
 ;check if valid user
 I $G(SDECDUZ)="" D ERR("0^SDEC46: User not specified.") Q
 I '$D(^VA(200,+SDECDUZ)) D ERR("0^SDEC46: Invalid user specified.") Q
 S ^TMP("SDEC",$J,0)="T00020DIV_IEN^T00020DIV_NAME^T00020DEFAULT^T00030TZ_CODE^T00030TZ_NAME^T00030TZ_DIFF^T00030DIALOGUE"_$C(30)
 S SDIAL=+$P($G(^DVB(396.1,1,0)),U,18)   ;APPT LINKING ENHANCE DIALOGUE from AMIE SITE PARAMETER file
 S SDTZ=$$GET1^DIQ(4.3,"1,",1,"I")
 S SDTZN=$G(^XMB(4.4,SDTZ,0))
 S SDECFN=0
 F  S SDECFN=$O(^VA(200,+SDECDUZ,2,SDECFN)) Q:SDECFN'>0  D
 . S SDECNOD=$G(^VA(200,+SDECDUZ,2,SDECFN,0))
 . S SDTMP=SDECFN_U_$P(^DIC(4,SDECFN,0),U,1)_U_$S($P(SDECNOD,U,2)=1:"YES",1:"NO")
 . S SDTMP=SDTMP_U_$P(SDTZN,U,1)_U_$P(SDTZN,U,2)_U_$P(SDTZN,U,3)_U_SDIAL
 . S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDTMP_$C(30)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
SETFAC(SDECY,SDECDUZ,SDECFAC) ;SET FACILITY
 ;SETFAC(SDECY,SDECDUZ,SDECFAC)  external parameter tag is in SDEC
 ; SDECDUZ = user IEN - pointer to the NEW PERSON file 200
 ; SDECFAC = facility/division to set - pointer to the INSTITUTE file 4
 ;Returns ERROR_ID^ERROR_TEXT
 ;   where ERROR_ID = 1 if successful; 0 if failed
 ;Fails if SDECFAC is not one of the current user's divisions
 N SDECI,SDECSUB
 S SDECI=0
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S ^TMP("SDEC",$J,0)="T00020ERROR_ID^T00020ERROR_TEXT"_$C(30)
 I '+SDECDUZ S SDECDUZ=DUZ
 I '+SDECFAC S SDECI=SDECI+1 S ^TMP("SDEC",$J,1)=0_U_"Division not specified."_$C(30) S SDECI=SDECI+1 S ^TMP("SDEC",$J,1)=$C(31) Q
 I '$D(^VA(200,SDECDUZ,2,+SDECFAC)) S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=0_U_"Invalid division specified."_$C(30) S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(31) Q
 S SDECSUB="^VA(200,"_SDECDUZ_",""2"","
 S ^DISV(SDECDUZ,SDECSUB)=SDECFAC
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=1_U_""_$C(30)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$C(31) Q
 Q
 ;
ERROR ;
 D ERR("Error")
 Q
 ;
ERR(ERRTXT) ;Error processing
 S:'$D(SDECI) SDECI=999
 S ERRTXT=$G(ERRTXT)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=ERRTXT_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
