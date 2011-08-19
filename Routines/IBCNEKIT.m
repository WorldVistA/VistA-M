IBCNEKIT ;DAOU/ESG - PURGE eIV DATA FILES ;11-JUL-2002
 ;;2.0;INTEGRATED BILLING;**184,271,316,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine handles the purging of the eIV data stored in the
 ; eIV Transmission Queue file (#365.1) and in the eIV Response file (#365).
 ; User can pick a date range for the purge.  Data created within 6 months
 ; cannot be purged.  The actual global kills are done by a background
 ; task after hours (8:00pm).
 ;
EN ;
 NEW STOP,BEGDT,ENDDT,STATLIST
 D INIT I STOP G EXIT       ; initialize/calculate default dates
 D BEGDT I STOP G EXIT      ; user interface for beginning date
 D ENDDT I STOP G EXIT      ; user interface for ending date
 D CONFIRM I STOP G EXIT    ; confirmation message/final check
 D QUEUE                    ; queuing process
EXIT ;
 Q
 ;
PURGE ; This procedure is queued to run in the background and does the
 ; actual purging.  Variables available from the TaskMan call are:
 ;
 ; STATLIST = list of statuses that are OK to purge
 ;    BEGDT = beginning date for purging
 ;    ENDDT = ending date for purging
 ;
 ; First loop through the eIV Transmission Queue file and delete all
 ; records in the date range whose status is in the list
 ;
 NEW DATE,TQIEN,TQS,HLIEN,DIK,DA,CNT
 S DATE=$O(^IBCN(365.1,"AE",BEGDT),-1),CNT=0
 F  S DATE=$O(^IBCN(365.1,"AE",DATE)) Q:'DATE!($P(DATE,".",1)>ENDDT)!$G(ZTSTOP)  S TQIEN=0 F  S TQIEN=$O(^IBCN(365.1,"AE",DATE,TQIEN)) Q:'TQIEN  D  Q:$G(ZTSTOP)
 . S CNT=CNT+1
 . I $D(ZTQUEUED),CNT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . S TQS=$P($G(^IBCN(365.1,TQIEN,0)),U,4)    ; trans queue status
 . I '$F(STATLIST,","_TQS_",") Q             ; must be in the list
 . ;
 . ; loop through the HL7 messages multiple and kill any response
 . ; records that are found for this transmission queue entry
 . S HLIEN=0,DIK="^IBCN(365,"
 . F  S HLIEN=$O(^IBCN(365.1,TQIEN,2,HLIEN)) Q:'HLIEN  D
 .. S DA=$P($G(^IBCN(365.1,TQIEN,2,HLIEN,0)),U,3) I DA D ^DIK
 .. Q
 . ;
 . ; now we can kill the transmission queue entry itself
 . S DA=TQIEN,DIK="^IBCN(365.1," D ^DIK
 . Q
 ;
 ; Check for a stop request
 I $G(ZTSTOP) G PURGEX
 ;
 ; Now we must loop through the eIV Response file itself to purge any
 ; response records that do not have a corresponding transmission
 ; queue entry.  These are the unsolicited responses.  The status of
 ; these responses is always 'response received' so we don't need to
 ; check the status. For this loop, start from the very beginning of
 ; the file.
 ;
 S DATE="",DIK="^IBCN(365,",CNT=0
 F  S DATE=$O(^IBCN(365,"AE",DATE)) Q:'DATE!($P(DATE,".",1)>ENDDT)!$G(ZTSTOP)  S DA=0 F  S DA=$O(^IBCN(365,"AE",DATE,DA)) Q:'DA  D  Q:$G(ZTSTOP)
 . S CNT=CNT+1
 . I $D(ZTQUEUED),CNT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . ;
 . ; If there is a pointer to the transmission queue file, then we
 . ; should get out of this loop because the purpose of this section
 . ; is to purge those responses with no link to the transmission
 . ; queue file.
 . ;
 . I $P($G(^IBCN(365,DA,0)),U,5) Q
 . D ^DIK
 . Q
 ;
PURGEX ;
 ; Tell TaskManager to delete the task's record
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
INIT ; This procedure calculates the default beginning and ending dates
 ; and displays screen messages about this option to the user.
 ;
 NEW DATE,FOUND,TQIEN,TQS,RPIEN,RPS
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 S STOP=0
 ;
 ; This is the list of statuses that are OK to purge
 ;   3=Response Received
 ;   5=Communication Failure
 ;   7=Cancelled
 S STATLIST=",3,5,7,"
 ;
 ; Try to find a beginning date in the eIV Transmission Queue file
 S DATE="",FOUND=0,BEGDT=DT
 F  S DATE=$O(^IBCN(365.1,"AE",DATE)) Q:'DATE!FOUND  S TQIEN=0 F  S TQIEN=$O(^IBCN(365.1,"AE",DATE,TQIEN)) Q:'TQIEN  D  Q:FOUND
 . S TQS=$P($G(^IBCN(365.1,TQIEN,0)),U,4)    ; status
 . I '$F(STATLIST,","_TQS_",") Q
 . S FOUND=1
 . S BEGDT=$P(DATE,".",1)
 . Q
 ;
 ; If not successful, try to find a beginning date in the eIV Response file.
 I 'FOUND D
 . S DATE=""
 . F  S DATE=$O(^IBCN(365,"AE",DATE)) Q:'DATE!FOUND  S RPIEN=0 F  S RPIEN=$O(^IBCN(365,"AE",DATE,RPIEN)) Q:'RPIEN  D  Q:FOUND
 .. S RPS=$P($G(^IBCN(365,RPIEN,0)),U,6)    ; status
 .. I '$F(STATLIST,","_RPS_",") Q
 .. S FOUND=1
 .. S BEGDT=$P(DATE,".",1)
 .. Q
 . Q
 ;
 ; default end date, Today minus 182 days (approx 6 months)
 S ENDDT=$$FMADD^XLFDT(DT,-182)
 ;
 I 'FOUND!(BEGDT>ENDDT) D  S STOP=1 G INITX
 . W !!?5,"Purging of eIV data is not possible at this time."
 . I 'FOUND W !?5,"There are no entries in the file that are eligible to be",!?5,"purged or there is no data in the file."
 . E  W !?5,"The oldest date in the file is ",$$FMTE^XLFDT(BEGDT,"5Z"),".",!?5,"Data cannot be purged unless it is at least 6 months old."
 . W ! S DIR(0)="E" D ^DIR K DIR
 . Q
 ;
 ; At this point, we know that there are some entries eligible for
 ; purging.  Display a message to the user about this option.
 W @IOF
 W !?8,"Purge Electronic Insurance Verification (eIV) Data Files"
 W !!!," This option will allow you to purge data from the eIV Response File (#365)"
 W !," and the eIV Transmission Queue File (#365.1).  The data must be at least six"
 W !," months old before it can be purged.  Only insurance transactions that have a"
 W !," transmission status of ""Response Received"", ""Communication Failure"", or"
 W !," ""Cancelled"" may be purged.  You will be allowed to select a date range for"
 W !," this purging.  The default beginning date will be the date of the oldest"
 W !," eligible record in the system.  The default ending date will be six months"
 W !," ago from today's date.  You may modify this default date range.  However, you"
 W !," may not select an ending date that is more recent than six months ago."
 W !!
INITX ;
 Q
 ;
BEGDT ; This procedure captures the beginning date from the user.
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="DOA^"_BEGDT_":"_ENDDT_":AEX"
 S DIR("A")="Enter the purge begin date: "
 S DIR("B")=$$FMTE^XLFDT(BEGDT,"5Z")
 S DIR("?")="This response must be a date between "_$$FMTE^XLFDT(BEGDT,"5Z")_" and "_$$FMTE^XLFDT(ENDDT,"5Z")_"."
 D ^DIR K DIR
 I $D(DIRUT)!'Y S STOP=1 G BEGDTX
 S BEGDT=Y
BEGDTX ;
 Q
 ;
ENDDT ; This procedure captures the ending date from the user.
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 W !
 S DIR(0)="DOA^"_BEGDT_":"_ENDDT_":AEX"
 S DIR("A")="  Enter the purge end date: "
 S DIR("B")=$$FMTE^XLFDT(ENDDT,"5Z")
 S DIR("?")="This response must be a date between "_$$FMTE^XLFDT(BEGDT,"5Z")_" and "_$$FMTE^XLFDT(ENDDT,"5Z")_"."
 D ^DIR K DIR
 I $D(DIRUT)!'Y S STOP=1 G ENDDTX
 S ENDDT=Y
ENDDTX ;
 Q
 ;
CONFIRM ; This procedure displays a confirmation message to the user and
 ; asks if it is OK to proceed with the purge.
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 W !!!," You want to purge all eIV data created between "
 W $$FMTE^XLFDT(BEGDT,"5Z")," and ",$$FMTE^XLFDT(ENDDT,"5Z"),"."
 W !
 S DIR(0)="YO",DIR("A")=" OK to continue"
 S DIR("B")="NO"
 D ^DIR K DIR
 I 'Y S STOP=1
CONFX ;
 Q
 ;
QUEUE ; This procedure queues the purge process for later at night.
 ; The concept for queuing the purge came from the insurance buffer
 ; purge routine, IBCNBPG.  That purge process is also hard-coded to
 ; be run at 8:00 PM just like this one is.
 ;
 NEW ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S ZTRTN="PURGE^IBCNEKIT"     ; TaskMan task entry point
 S ZTDESC="Purge eIV Data"    ; Task description
 S ZTDTH=DT_".20"             ; start it at 8:00 PM tonight
 S ZTIO=""
 S ZTSAVE("BEGDT")=""
 S ZTSAVE("ENDDT")=""
 S ZTSAVE("STATLIST")=""
 D ^%ZTLOAD
 I $G(ZTSK) W !!," Task# ",ZTSK," has been scheduled to purge the eIV data tonight at 8:00 PM."
 E  W !!," TaskManager could not schedule this task.",!," Contact IRM for technical assistance."
 W ! S DIR(0)="E" D ^DIR K DIR
QUEUEX ;
 Q
