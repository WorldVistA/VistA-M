SDEC13 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
AVDELDT(SDECY,SDECRESD,SDECSTART,SDECEND) ;Cancel availability in a date range
 ;AVDELDT(SDECY,SDECRESD,SDECSTART,SDECEND)  external parameter tag is in SDEC
 ;SDECRESD is SDEC RESOURCE ien
 ;SDECSTART and SDECEND are external dates
 ;
 N BMXIEN,SDECI,%DT,X,Y
 N SDBEG,SDCL,SDEND,SDECNOD
 S SDECI=0
 S SDECY="^TMP(""SDEC"","_$J_")"
 K ^TMP("SDEC",$J)
 S ^TMP("SDEC",$J,SDECI)="I00020ERRORID^T00030ERRORTEXT"_$C(30)
 S X=SDECSTART
 S %DT="X" D ^%DT
 I Y=-1 D ERR(0,"AVDELDT-SDEC13: Invalid Start Date") Q
 S SDECSTART=$P(Y,".")
 S X=SDECEND
 S %DT="X" D ^%DT
 I Y=-1 D ERR(0,"AVDELDT-SDEC13: Invalid End Date") Q
 S SDECEND=$P(Y,".")_".2359"
 I '+SDECRESD D ERR(0,"AVDELDT-SDEC13: Invalid Resource ID") Q
 I $P($P($G(^SDEC(409.831,+SDECRESD,0)),U,11),";",2)'="SC(" D ERR(0,"AVDELDT-SDEC13: Resource is not a Clinic type") Q  ;only add to clinics
 ;get resource, start, end times
 S SDCL=$$GET1^DIQ(409.831,SDECRESD_",",.04,"I")
 ;
 F  S SDECSTART=$O(^SDEC(409.821,"ARSCT",SDECRESD,SDECSTART)) Q:'+SDECSTART  Q:SDECSTART>SDECEND  D
 . S BMXIEN=0
 . F  S BMXIEN=$O(^SDEC(409.821,"ARSCT",SDECRESD,SDECSTART,BMXIEN)) Q:'+BMXIEN  D
 . . ;get resource, start, end times
 . . S SDECNOD=$G(^SDEC(409.821,BMXIEN,0))
 . . S SDBEG=$P(SDECNOD,U,2)
 . . S SDEND=$P(SDECNOD,U,3)
 . . D CALLDIK(BMXIEN)
 . . ;delete AVAILABILITY from file 44
 . . D DEL^SDEC12(SDCL,SDBEG,SDEND)
 ;
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)="-1^"_$C(30)_$C(31)
 Q
ERROR ;
 D ^%ZTER
 I '+$G(SDECI) N SDECI S SDECI=999999
 S SDECI=SDECI+1
 D ERR(0,"SDEC13 Error")
 Q
 ;
ERR(SDECERID,ERRTXT) ;Error processing
 S:'+$G(SDECI) SDECI=999999
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECERID_"^"_$G(ERRTXT)_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
AVDEL(SDECY,SDECAVID) ;Cancel Availability - Deletes Access Block
 ;AVDEL(SDECY,SDECAVID)  external parameter tag is in SDEC
 ;Deletes Access block
 ;SDECAVID is entry number in SDEC ACCESS BLOCK file
 ;Returns error code in recordset field ERRORID
 ;
 N SDECNOD,SDECSTART,DIK,DA,SDECID,SDECI,SDECEND,SDECRSID
 N SDBEG,SDCL,SDEND,SDRES
 ;
 S SDECI=0
 S SDECY="^TMP(""SDEC"","_$J_")"
 K ^TMP("SDEC",$J)
 S ^TMP("SDEC",$J,0)="I00020ERRORID^T00030ERRORTEXT"_$C(30)
 I '+SDECAVID D ERR(70) Q
 I '$D(^SDEC(409.821,SDECAVID,0)) D ERR(70) Q
 ;get resource, start, end times
 S SDECNOD=$G(^SDEC(409.821,SDECAVID,0))
 S SDRES=$P(SDECNOD,U,1)
 S SDCL=$$GET1^DIQ(409.831,SDRES_",",.04,"I")
 S SDBEG=$P(SDECNOD,U,2)
 S SDEND=$P(SDECNOD,U,3)
 ;
 ;Delete AVAILABILITY entries
 D CALLDIK(SDECAVID)
 ;
 ;rebuild AVAILABILITY in file 44
 D AV44^SDEC12($P(SDBEG,".",1),SDCL,SDRES)
 ;
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)="-1^"_$C(30)_$C(31)
 Q
 ;
CALLDIK(SDECAVID) ;
 ;Delete AVAILABILITY entries
 ;
 S DIK="^SDEC(409.821,"
 S DA=SDECAVID
 D ^DIK
 ;
 Q
 ;
APTINBLK(SDECAVID) ;
 ;
 ;NOTE: This Subroutine Not called in current version.  Keep code for later use.
 ;
 ;N SDECS,SDECID,SDECHIT,SDECNOD,SDECE,SDECSTART,SDECEND,SDECRSID
 ;S SDECNOD=^SDEC(409.821,SDECAVID,0)
 ;S SDECSTART=$P(SDECNOD,U,3)
 ;S SDECEND=$P(SDECNOD,U,4)
 ;S SDECRSID=$P(SDECNOD,U,1)
 ;I '$D(^SDECDAPRS("ARSRC",SDECRSID)) Q 0
 ;;If any appointments start at the AV block start time:
 ;I $D(^SDECDAPRS("ARSRC",SDECRSID,SDECSTART)) Q 1
 ;;Find the first appt time SDECS on the same day as the av block
 ;S SDECS=$O(^SDECDAPRS("ARSRC",SDECRSID,$P(SDECSTART,".")))
 ;I SDECS>SDECEND Q 0
 ;;For all the appts that day with start times less
 ;;than the av block's end time, find any whose end time is
 ;;greater than the av block's start time
 ;S SDECHIT=0
 ;S SDECS=SDECS-.0001
 ;F  S SDECS=$O(^SDECDAPRS("ARSRC",SDECRSID,SDECS)) Q:'+SDECS  Q:SDECS'<SDECEND  D  Q:SDECHIT
 ;. S SDECID=0 F  S SDECID=$O(^SDECDAPRS("ARSRC",SDECRSID,SDECS,SDECID)) Q:'+SDECID  D  Q:SDECHIT
 ;. . Q:'$D(^SDECDAPT(SDECID,0))
 ;. . S SDECNOD=^SDECDAPT(SDECID,0)
 ;. . S SDECE=$P(SDECNOD,U,2)
 ;. . I SDECE>SDECSTART S SDECHIT=1 Q
 ;;
 ;I SDECHIT Q 1
 Q 0
