SDSCINS ;ALB/JAM/RBS - ASCD Check on Newly Identified Insurance ; 2/15/07 12:57pm ; 4/3/07 11:19am
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 ;**Program Description**
 ;   This program will check the Audit file for any newly identified
 ;   insurance policies
 Q
EN(SDSCINS,SDSCSVC) ;  Entry point
 ;
 ;  Input: SDSCINS and SDSCSVC passed by reference
 ;
 ;  Output:
 ;    SDSCINS - count of records found with late-identified insurance
 ;    SDSCSVC - count of those found records just filed to (#409.48)
 ;
 N SDSCPAR
 K SDSCBDT,SDSCEDT
 ;if audit not turned on quit
 D FIELD^DID(2,.3192,"","AUDIT","SDSCPAR")
 I $G(SDSCPAR("AUDIT"))'["YES" Q
 K SDSCPAR
 D FIELD^DID(2.312,.01,"","AUDIT","SDSCPAR")
 I $G(SDSCPAR("AUDIT"))'["YES" Q
 ; Get encounter date range to check - start with from 24 months back 
 S SDSCBDT=$$FMADD^XLFDT(DT,-731),SDSCEDT=$O(^SDSC(409.48,"AE",""),-1)\1
 ;
 N SDSCADT,SDEADT,SDINS
 S SDSCADT=$$FMADD^XLFDT(DT,-1),SDEADT=$$FMADD^XLFDT(DT,-1)
 F  S SDSCADT=$O(^DIA(2,"C",SDSCADT)) Q:SDSCADT=""!((SDSCADT\1)>SDEADT)  D
 . S SDIEN="" F  S SDIEN=$O(^DIA(2,"C",SDSCADT,SDIEN)) Q:SDIEN=""  D
 .. S SDUFLD=$P(^DIA(2,SDIEN,0),U,3)
 .. I SDUFLD'=.3192,SDUFLD'[.3121 Q
 .. I SDUFLD=.3192 D COV Q:'SDCOV
 .. I SDUFLD=".3121,.01" D NINS Q:'SDIN
 .. S SDFN=$P(^DIA(2,SDIEN,0),U,1) S:SDFN["," SDFN=$P(SDFN,",",1)
 .. ;
 .. ; check if this patient has encounters for the date range
 .. S SDECDT=SDSCBDT
 .. F  S SDECDT=$O(^SCE("ADFN",SDFN,SDECDT)) Q:SDECDT=""!((SDECDT\1)>SDSCEDT)  D
 ... S IEN="" F  S IEN=$O(^SCE("ADFN",SDFN,SDECDT,IEN)) Q:IEN=""  D
 .... S SDINS=SDSCSVC
 .... S SDOE=IEN,SDOEDT=$P(^SCE(SDOE,0),U,1) D OPT1^SDSCOMP
 .... ; count the number of service connected records from late-identified insurance
 .... I SDINS'=SDSCSVC S SDSCINS=SDSCINS+1
 ;
EXIT ;  Exit
 K SDOE,IEN,SDECDT,SDIN,SDCOV
 K SDUFLD,SDFN,SDIEN,SDOEDT
 Q
 ;
AUDIT(SDTEXT,SDCNT) ;  Check if auditing is turned on
 N SDSCPAR,SDARY,SDCT
 S SDCT=0,SDCNT=$G(SDCNT)
 D FIELD^DID(2,.3192,"","AUDIT","SDSCPAR")
 I $G(SDSCPAR("AUDIT"))'["YES" D
 . S SDCT=SDCT+1,SDARY(SDCT)="Auditing is not turned on for field COVERED BY HEALTH INSURANCE?"
 K SDSCPAR
 D FIELD^DID(2.312,.01,"","AUDIT","SDSCPAR")
 I $G(SDSCPAR("AUDIT"))'["YES" D
 . S SDCT=SDCT+1,SDARY(SDCT)="Auditing is not turned on for field INSURANCE TYPE"
 I SDCT D
 . S SDCNT=SDCNT+1,SDTEXT(SDCNT)="",SDCNT=SDCNT+1
 . S SDTEXT(SDCNT)="ASCD Late Insurance Check:"
 . S SDCT=0 F  S SDCT=$O(SDARY(SDCT)) Q:'SDCT  D
 . . S SDCNT=SDCNT+1,SDTEXT(SDCNT)=SDARY(SDCT)
 Q
MMSG ;  Send mail message
 I $G(DUZ)="" S XMZ(.5)=""
 S XMZ(DUZ)="",XMDUZ="ASCD Insurance Check",XMY("G.SDSC NIGHTLY TALLY")=""
 S XMTEXT="SDTEXT(",XMSUB="ASCD Insurance Identified"
 D ^XMD
 K XMY,XMDUZ,XMTEXT,SDTEXT,XMSUB,XMZ
 Q
 ;
COV ;  Covered by insurance
 N SDOLD,SDNEW
 S SDCOV=0
 S SDOLD=$G(^DIA(2,SDIEN,2)),SDNEW=$G(^DIA(2,SDIEN,3))
 I SDOLD="NO",SDNEW="YES" S SDCOV=1 Q
 Q
 ;
NINS ;  New insurance company added
 N SDOLD,SDNEW
 S SDIN=0
 S SDOLD=$G(^DIA(2,SDIEN,2)),SDNEW=$G(^DIA(2,SDIEN,3))
 I SDOLD="",SDNEW'="" S SDIN=1
 Q
