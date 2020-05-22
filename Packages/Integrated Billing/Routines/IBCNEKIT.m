IBCNEKIT ;DAOU/ESG - PURGE eIV DATA FILES ;11-JUL-2002
 ;;2.0;INTEGRATED BILLING;**184,271,316,416,549,595,621,602,659**;21-MAR-94;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine handles the purging of the eIV data stored in the
 ; eIV Transmission Queue file (#365.1), the eIV Response file (#365) and
 ; the EIV EICD TRACKING file (#365.18) IB*2.0*621/DM
 ; User can pick a date range for the purge.  Data created within 6 months
 ; cannot be purged.  The actual global kills are done by a background
 ; task after hours (8:00pm).
 ;
EN ;
 NEW STOP,BEGDT,ENDDT,STATLIST,IBVER
 S IBVER=1
 D INIT I STOP G EXIT       ; initialize/calculate default dates
 D DEFLT I STOP G EXIT      ; allow user to change default end date if test system ;IB*2.0*621
 D BEGDT I STOP G EXIT      ; user interface for beginning date
 D ENDDT I STOP G EXIT      ; user interface for ending date
 D CONFIRM I STOP G EXIT    ; confirmation message/final check
 D QUEUE                    ; queuing process
EXIT ;
 Q
 ;
EN1 ; Automated Monthly Purge *IB*2*595
 NEW STOP,BEGDT,ENDDT,STATLIST,IBVER
 S IBVER=2
 D INIT I STOP G EXIT1       ; initialize/calculate default dates
 D QUEUE                    ; queuing process
EXIT1 ;
 Q
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
 N CNT,DA,DATE,DIK,HLIEN,PFLAG,TQIEN,TQS   ;IB*2.0*549 added PFLAG
 N IBWEXT,IBIORV
 S DATE=$O(^IBCN(365.1,"AE",BEGDT),-1),CNT=0
 F  S DATE=$O(^IBCN(365.1,"AE",DATE)) Q:'DATE!($P(DATE,".",1)>ENDDT)!$G(ZTSTOP)  S TQIEN=0 F  S TQIEN=$O(^IBCN(365.1,"AE",DATE,TQIEN)) Q:'TQIEN  D  Q:$G(ZTSTOP)
 . S CNT=CNT+1
 . I $D(ZTQUEUED),CNT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . S TQS=$P($G(^IBCN(365.1,TQIEN,0)),U,4)     ; trans queue status
 . S IBWEXT=$P($G(^IBCN(365.1,TQIEN,0)),U,10) ; IB*2.0*621/DM WHICH EXTRACT
 . S IBIORV=$P($G(^IBCN(365.1,TQIEN,0)),U,11) ; IB*2.0*621/DM QUERY FLAG
 . I IBWEXT=4,IBIORV="V" Q                    ; skip EICD Verification entries as they 
 . ;                                            will be addressed with EICD Identifications
 . I '$F(STATLIST,","_TQS_",") Q              ; must be in the list
 . I IBWEXT=4,IBIORV="I" D CHKTRK(TQIEN) Q    ; check EIV EICD TRACKING for purge
 . ; loop through the HL7 messages multiple and kill any response
 . ; records that are found for this transmission queue entry
 . ; IB*2.0*621/DM Preserve any TQ and response that has DO NOT PURGE set to 1 (YES)
 . S PFLAG=0,HLIEN=0,DIK="^IBCN(365,"
 . F  S HLIEN=$O(^IBCN(365.1,TQIEN,2,HLIEN)) Q:'HLIEN  D
 .. S DA=$P($G(^IBCN(365.1,TQIEN,2,HLIEN,0)),U,3) Q:'DA
 .. I +$$GET1^DIQ(365,DA_",",.11,"I") S PFLAG=1 Q  ;"DO NOT PURGE"
 .. D ^DIK
 .. Q
 . ;
 . ; now we can kill the transmission queue entry itself
 . ; as long as there was no DO NOT PURGE responses IB*2.0*621/DM 
 . I 'PFLAG S DA=TQIEN,DIK="^IBCN(365.1," D ^DIK K DA,DIK
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
 . ; IB*2.0*602/TAZ never drop a DO NOT PURGE response
 . Q:+$$GET1^DIQ(365,DA_",",.11,"I")
 . ; If there is a pointer to the transmission queue file,
 . ; make sure the transmission queue record actually exists.
 . ; If the TQ exists, quit this loop, if not, remove this response.
 . ;
 . S TQIEN=+$$GET1^DIQ(365,DA_",",.05,"I")
 . D ^DIK
 . Q
 ;
 K DA,DIK
PURGEX ;
 ; Tell TaskManager to delete the task's record
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
INIT ; This procedure calculates the default beginning and ending dates
 ; and displays screen messages about this option to the user.
 ;
 NEW DATE,FOUND,TQIEN,TQS,RPIEN,RPS,IBHL7,IBDNP
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 S STOP=0
 ;
 ; This is the list of statuses that are OK to purge
 ;   3=Response Received
 ;   5=Communication Failure
 ;   7=Cancelled
 S STATLIST=","_$$FIND1^DIC(365.14,,"B","Response Received")
 S STATLIST=STATLIST_","_$$FIND1^DIC(365.14,,"B","Communication Failure")
 S STATLIST=STATLIST_","_$$FIND1^DIC(365.14,,"B","Cancelled")_","
 ;
 ; Try to find a beginning date in the eIV Transmission Queue file
 S DATE="",FOUND=0,BEGDT=DT
 F  S DATE=$O(^IBCN(365.1,"AE",DATE)) Q:'DATE!FOUND  S TQIEN=0 F  S TQIEN=$O(^IBCN(365.1,"AE",DATE,TQIEN)) Q:'TQIEN  D  Q:FOUND
 . S TQS=$P($G(^IBCN(365.1,TQIEN,0)),U,4)    ; status
 . I '$F(STATLIST,","_TQS_",") Q
 . ;IB*2.0*602/DM make sure the default earliest date is not a DO NOT PURGE entry 
 . ;check the HL7 messages multiple to see if DO NOT PURGE is set on any response
 . S (IBDNP,IBHL7)=0
 . F  S IBHL7=$O(^IBCN(365.1,TQIEN,2,IBHL7)) Q:'IBHL7!IBDNP  D
 .. S RPIEN=$P($G(^IBCN(365.1,TQIEN,2,IBHL7,0)),U,3) Q:'RPIEN
 .. I +$$GET1^DIQ(365,RPIEN_",","DO NOT PURGE","I") S IBDNP=1
 .. Q
 . ;
 . I IBDNP,IBVER=2 Q 
 . I IBDNP W !,"Please wait, checking for the earliest purge date ...",! Q
 . ;
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
 .. ;IB*2.0*602/DM do not choose a DO NOT PURGE response 
 .. I +$$GET1^DIQ(365,RPIEN_",","DO NOT PURGE","I") Q
 .. S FOUND=1
 .. S BEGDT=$P(DATE,".",1)
 .. Q
 . Q
 ;
 ; default end date, Today minus 182 days (approx 6 months)
 S ENDDT=$$FMADD^XLFDT(DT,-182)
 ;
 ;I IBVER=1,'FOUND!(BEGDT>ENDDT) D  S STOP=1 G INITX ; IB*2.0*621
 I IBVER=1,'FOUND,'$$PROD^XUPROD(1)!(BEGDT>ENDDT) D  S STOP=1 G INITX
 . W !!?5,"Purging of eIV data is not possible at this time."
 . I 'FOUND W !?5,"There are no entries in the file that are eligible to be",!?5,"purged or there is no data in the file."
 . E  W !?5,"The oldest date in the file is ",$$FMTE^XLFDT(BEGDT,"5Z"),".",!?5,"Data cannot be purged unless it is at least 6 months old."
 . W ! S DIR(0)="E" D ^DIR K DIR
 . Q
 I IBVER=2,'FOUND!(BEGDT>ENDDT) D  S STOP=1 G INITX
 .; Send a MailMan message with Eligible Purge counts ; IB*2.0*621 - Updated Message
 .N MGRP,MSG,IBXMY
 .S MSG(1)="Purge Electronic Insurance Verification (eIV) Data Files did not find records"
 .S MSG(2)="for station "_+$$SITE^VASITE()_"."
 .S MSG(3)=""
 .S MSG(4)="The option runs automatically on a monthly basis and purges data from the"
 .S MSG(5)="IIV RESPONSE file (#365), the IIV TRANSMISSION QUEUE file (#365.1), and the"
 .S MSG(6)="EIV EICD TRACKING file (#365.18).  The data must be at least six months old"
 .S MSG(7)="before it can be purged.  Only insurance transactions that have a transmission"
 .S MSG(8)="status of ""Response Received"", ""Communication Failure"", or ""Cancelled"""
 .S MSG(9)="may be purged."
 .; Set to IB site parameter MAILGROUP - IBCNE EIV MESSAGE
 .S MGRP=$$MGRP^IBCNEUT5()
 .; IB*659/DW  Added production check & changed eInsurance mail group to be more self documenting
 .I $$PROD^XUPROD(1) S IBXMY("VHAeInsuranceRapidResponse@domain.ext")=""
 .D MSG^IBCNEUT5(MGRP,"eIV Purge No Data Found for Station "_+$$SITE^VASITE(),"MSG(",,.IBXMY) ; emails postmaster if IBXMY is null
 .Q
 ;
 ; At this point, we know that there are some entries eligible for
 ; purging.  Display a message to the user about this option.
 I IBVER=2 G INITX
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
DEFLT ;  IB*621/DW Added to assist with testing
 I IBVER=1,('$$PROD^XUPROD(1)) D
 . W ?5,"*** For Test Purposes Only:"
 . W !!?5,"In test systems one may override the DEFAULT end date."
 . W !!?5,"Current default end date is TODAY - 182 DAYS: "_$$FMTE^XLFDT(ENDDT,"5Z"),!!
 . NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 . S DIR(0)="DOA^"_BEGDT_":"_DT_":AEX"
 . S DIR("A")="Enter the purge default date: "
 . S DIR("B")=$$FMTE^XLFDT(ENDDT,"5Z")
 . S DIR("?")="This response must be a date between "_$$FMTE^XLFDT(BEGDT,"5Z")_" and "_$$FMTE^XLFDT(DT,"5Z")_"."
 . D ^DIR K DIR
 . I $D(DIRUT)!'Y S STOP=1 G DEFLTX
 . S ENDDT=Y
 W !!!
DEFLTX ;
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
 ;
 ; IB*621/DW Added loop below to assist with testing
 I IBVER=1,('$$PROD^XUPROD(1)) D  I Y D PURGE^IBCNEKIT G QUEUEX
 . W !!!!,"*** TEST System only - you may run this immediately",!
 . S DIR("A")="Do you want to run this now instead of tasking it for 8:00pm"
 . S DIR(0)="Y",DIR("B")="YES"
 . D ^DIR
 . I Y="^" S STOP=1
 ;
 I STOP G QUEUEX              ; IB*2.0*621
 S ZTRTN="PURGE^IBCNEKIT"     ; TaskMan task entry point
 S ZTDESC="Purge eIV Data"    ; Task description
 S ZTDTH=DT_".20"             ; start it at 8:00 PM tonight
 S ZTIO=""
 S ZTSAVE("BEGDT")=""
 S ZTSAVE("ENDDT")=""
 S ZTSAVE("STATLIST")=""
 D ^%ZTLOAD
 I IBVER=2 G QUEUEX
 I $G(ZTSK) W !!," Task# ",ZTSK," has been scheduled to purge the eIV data tonight at 8:00 PM."
 E  W !!," TaskManager could not schedule this task.",!," Contact IRM for technical assistance."
 W ! S DIR(0)="E" D ^DIR K DIR
QUEUEX ;
 Q
 ;
CHKTRK(IBTQ1) ; IB*621, Evaluate associated records for one EICD transaction
 ; IBTQ1 = EICD Identification TQ IEN
 ;
 N FILE,HLIEN,IBTQIEN1,IBTQIEN2,IBFIELDS,IBPURGE,IBSKIP,IBTQIEN,IBTQS
 N IBTRKIEN,PFLAG
 ;
 S (IBSKIP,PFLAG)=0
 K IBPURGE
 S IBTQIEN1=+$$FIND1^DIC(365.18,,"QX",IBTQ1,"B")
 Q:'IBTQIEN1  ; the passed TQ IEN is not in the tracking file
 S IBPURGE("EICD",365.1,IBTQ1)=""               ;EICD TQ for identifications
 S IBTQIEN=+$$GET1^DIQ(365.18,IBTQIEN1,.06,"I") ;EICD RESPONSE for identifications
 I IBTQIEN S IBPURGE("EICD",365,IBTQIEN)=""
 ; 
 ; loop through the EICD verification entries looking for exclusions  
 S IBTRKIEN=0 F  S IBTRKIEN=$O(^IBCN(365.18,IBTQIEN1,"INS-FND",IBTRKIEN)) Q:'IBTRKIEN  D  Q:IBSKIP
 . ;
 . ; check the 1 node data for associated TQs & their responses
 . S IBTQIEN2=IBTRKIEN_","_IBTQIEN1_","
 . K IBFIELDS D GETS^DIQ(365.185,IBTQIEN2,"1.01:1.04","I","IBFIELDS")
 . ;
 . I IBFIELDS(365.185,IBTQIEN2,1.02,"I")="" Q                ; No TQ was created
 . I IBFIELDS(365.185,IBTQIEN2,1.02,"I")>ENDDT S IBSKIP=1 Q  ; TQ not old enough 
 . S IBTQIEN=+IBFIELDS(365.185,IBTQIEN2,1.01,"I")            ; EICD VER INQ TQ
 . S IBTQS=+$$GET1^DIQ(365.1,IBTQIEN_",",.04,"I")            ; TQ Transmission Status 
 . I IBTQS,('$F(STATLIST,","_IBTQS_",")) S IBSKIP=1 Q        ; must be in the list
 . ;
 . ; Loop thru all EICD Verifications if any are DO NOT PURGE then kill
 . ; nothing associated with it
 . S HLIEN=0
 . F  S HLIEN=$O(^IBCN(365.1,IBTQIEN,2,HLIEN)) Q:'HLIEN!PFLAG  D
 .. S DA=$P($G(^IBCN(365.1,IBTQIEN,2,HLIEN,0)),U,3) Q:'DA
 .. I +$$GET1^DIQ(365,DA_",",.11,"I") S PFLAG=1 Q  ;"DO NOT PURGE"
 .. S IBPURGE("EICD",365,DA)=""  ; array of Verifications to purge (responses)
 . I PFLAG Q
 . S IBPURGE("EICD",365.1,IBTQIEN)="" ; array of Verifications to purge (inquiries)
 ;
 I PFLAG!IBSKIP K IBPURGE  ; DO NOT PURGE is set or Not all records are old enough
 ;
 I '$D(IBPURGE) Q  ; No records associated with this entry to purge
 S IBPURGE("EICD",365.18,IBTQ1)=""
 S FILE="" F  S FILE=$O(IBPURGE("EICD",FILE)) Q:'FILE  D
 . S DIK="^IBCN("_FILE_","
 . S DA="" F  S DA=$O(IBPURGE("EICD",FILE,DA)) Q:'DA  D
 .. D ^DIK
 K IBPURGE,DA,DIK
 Q
 ;
