SCDXRT01 ;ALB/JRP - AMB CARE RETRANSMISSION;09-MAY-1996
 ;;5.3;Scheduling;**44**;AUG 13, 1993
 ;
RTRNRNG ;Mark all [Deleted] Outpatient Encounters for a user specified
 ; date range for retransmission to the National Ambulatory Care
 ; Database
 ;
 ;Input  : None
 ;Output : None
 ;Note   : User is prompted for the date range to retransmit
 ;       : Encounters that are not contained in the Transmitted
 ;         Outpatient Encounter file (#409.73) can not be
 ;         retransmitted
 ;       : [Deleted] Encounters that occurred before switching to new
 ;         transmission format can not be retransmitted
 ;       : [Deleted] Encounters that occurred within the last two days
 ;         can not be retransmitted
 ;
 ;Declare variables
 N MINDT,MAXDT,SCDXSTRT,SCDXEND,HELPTXT,X,%H,%,%I
 N ZTSK,ZTDESC,ZTRTN,ZTIO,ZTDTH
 W !!
 ;Cut-off date for old transmission format is earliest date
 ; allowed for retransmission (default to 10/1/96)
 S MINDT=+$P($G(^SD(404.91,1,"AMB")),"^",2)
 S:('MINDT) MINDT=2961001
 ;Today is the latest date allowed for retransmission
 D NOW^%DTC
 S MAXDT=X
 ;Set up help text for getting beginning and ending dates
 S HELPTXT("BGN")="Enter the beginning date for retransmitting encounters"
 S HELPTXT("END")="Enter the ending date for retransmitting encounters"
 ;Get beginning and ending dates
 S X=$$GETDTRNG^SCDXUTL1(MINDT,MAXDT,"HELPTXT(""BGN"")","HELPTXT(""END"")")
 ;User abort / time out
 Q:(X<0)
 W !!
 ;Verify that user wants to do this
 S SCDXSTRT=$P(X,"^",1)
 S SCDXEND=$P(X,"^",2)
 S DIR("A",1)=" "
 S DIR("A",2)=" "
 S X=(+$E(SCDXSTRT,4,5))_"/"_(+$E(SCDXSTRT,6,7))_"/"_(1700+$E(SCDXSTRT,1,3))
 S DIR("A",3)="All outpatient encounters that occurred between "_X
 S X=(+$E(SCDXEND,4,5))_"/"_(+$E(SCDXEND,6,7))_"/"_(1700+$E(SCDXEND,1,3))
 S DIR("A",4)="and "_X_" will be marked for retransmission to the"
 S DIR("A",5)="National Patient Care Database."
 S DIR("A",6)=" "
 S DIR("A",7)=" "
 S DIR("A")="Are you sure you want to do this ? "
 S DIR(0)="YA"
 D ^DIR
 ;Not verified / user abort / time out
 Q:('Y)
 ;Queue marking for retransmission
 S ZTRTN="TASKRX^SCDXRT01"
 S ZTDESC="Mark [Deleted] Outpatient Encounters for retransmission"
 S ZTDTH=$H
 S ZTIO=""
 S ZTSAVE("SCDXSTRT")=SCDXSTRT
 S ZTSAVE("SCDXEND")=SCDXEND
 K ZTSK D ^%ZTLOAD
 W:('$G(ZTSK)) !!,"** UNABLE TO QUEUE MARKING OF ENCOUNTERS FOR RETRANSMISSION **",!!
 W:($G(ZTSK)) !!,"Marking of encounters for retransmission queued as task number ",ZTSK
 W !!
 Q
 ;
TASKRX ;Mark all [Deleted] Outpatient Encounters in a given date range
 ; for retransmission
 ;
 ;Input  : SCDXSTRT - Date to begin marking encounters from 
 ;                    (FileMan format) (Required)
 ;         SCDXEND - Date to end marking encounters at
 ;                   (FileMan format) (Required)
 ;Output : None
 ;Notes  : Encounters that are not contained in the Transmitted
 ;         Outpatient Encounter file (#409.73) can not be
 ;         retransmitted
 ;       : This entry point should be used when marking for
 ;         retransmission is being queued.  If queued, ZTSTOP will
 ;         be set accordingly.
 ;
 ;Check input
 Q:('$G(SCDXSTRT))
 Q:('$G(SCDXEND))
 ;Declare variables
 N JUNK
 ;Call module to mark entries for retransmission
 S JUNK=$$REXMIT(SCDXSTRT,SCDXEND)
 ;Set ZTSTOP accordingly
 S:($P(JUNK,"^",4)) ZTSTOP=1
 ;Done
 Q
 ;
REXMIT(STARTDT,ENDDT) ;Mark all [Deleted] Outpatient Encounters in a
 ; given date range for retransmission
 ;
 ;Input  : STARTDT - Date to begin marking encounters from 
 ;                   (FileMan format) (Required)
 ;         ENDDT - Date to end marking encounters at (FileMan format)
 ;                 (Required)
 ;Output : Tot^Enc^Del^Stop - Number of [deleted] encounters marked for
 ;                            retransmission
 ;           Tot - Total number of encounters marked
 ;           Enc - Number of existing encounters marked
 ;           Del - Number of deleted encounters marked
 ;           Stop - Flag indicating if task was asked to stop
 ;             1 = Task was asked to stop
 ;             0 = Task was not asked to stop
 ;         0 - No encounters marked / bad input
 ;Notes  : Encounters that are not contained in the Transmitted
 ;         Outpatient Encounter file (#409.73) can not be
 ;         retransmitted
 ;
 ;Check input
 S STARTDT=+$G(STARTDT)
 Q:('STARTDT)
 S ENDDT=+$G(ENDDT)
 Q:('ENDDT)
 ;Declare variables
 N XMITPTR,ENCPTR,DELPTR,ENCDATE,EVNTDATE,DELCNT,ENCCNT,STOP,LOOP
 S STOP=0
 ;Add one second before midnight to ending date
 S ENDDT=ENDDT+.235959
 ;Find all deleted encounters that fall in date range
 S ENCDATE=STARTDT-.000001
 S DELCNT=0
 F LOOP=1:1 S ENCDATE=+$O(^SD(409.74,"B",ENCDATE)) Q:(('ENCDATE)!(ENCDATE>ENDDT))  D  Q:(STOP)
 .;Check for request to stop
 .I ('(LOOP#10)) S STOP=$$S^%ZTLOAD(DELCNT_" encounters have been marked for retransmission") Q:(STOP)
 .S DELPTR=0
 .F  S DELPTR=+$O(^SD(409.74,"B",ENCDATE,DELPTR)) Q:('DELPTR)  D
 ..;Find entry in Transmitted Outpatient Encounter file
 ..S XMITPTR=+$O(^SD(409.73,"ADEL",DELPTR,0))
 ..;Entry not found - don't retransmit
 ..Q:('XMITPTR)
 ..;Mark entry for retransmission
 ..D STREEVNT^SCDXFU01(XMITPTR,0)
 ..;Turn on transmission flag
 ..D XMITFLAG^SCDXFU01(XMITPTR)
 ..;Increment count of deleted encounters marked
 ..S DELCNT=DELCNT+1
 ;Task was asked to stop - abort
 Q:(STOP) DELCNT_"^^"_DELCNT_"^1"
 ;Find all encounters that fall in date range
 S ENCCNT=0
 S ENCDATE=STARTDT-.000001
 F LOOP=1:1 S ENCDATE=+$O(^SCE("B",ENCDATE)) Q:(('ENCDATE)!(ENCDATE>ENDDT))  D  Q:(STOP)
 .;Check for request to stop
 .I ('(LOOP#10)) S STOP=$$S^%ZTLOAD((ENCCNT+DELCNT)_" encounters have been marked for retransmission") Q:(STOP)
 .S ENCPTR=0
 .F  S ENCPTR=+$O(^SCE("B",ENCDATE,ENCPTR)) Q:('ENCPTR)  D
 ..;Find entry in Transmitted Outpatient Encounter file
 ..S XMITPTR=+$O(^SD(409.73,"AENC",ENCPTR,0))
 ..;Entry not found - don't retransmit
 ..Q:('XMITPTR)
 ..;Mark entry for retransmission
 ..D STREEVNT^SCDXFU01(XMITPTR,0)
 ..;Turn on transmission flag
 ..D XMITFLAG^SCDXFU01(XMITPTR)
 ..;Increment count of encounters marked
 ..S ENCCNT=ENCCNT+1
 ;Done
 Q (DELCNT+ENCCNT)_"^"_ENCCNT_"^"_DELCNT_"^"_STOP
