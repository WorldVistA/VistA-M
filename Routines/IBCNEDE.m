IBCNEDE ;DAOU/DAC - eIV DATA EXTRACTS ;04-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,300,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program is the main driver for all data extracts associated
 ;  with the electronic Insurance Verification interface.
 ;  This program will run each extract in the specified order, which 
 ;  populates the eIV Transmission File (sometimes it creates/updates 
 ;  an entry in the insurance buffer as well).  It then begins to 
 ;  process the inquiries in the eIV Transmission File.
 ;  08-08-2002
 ;  As this program will run in the background the variable ZTSTOP
 ;  can be returned from any of the extracts should a TaskMan stop
 ;  request occur.  Also, clear out the task record before exiting.
 ; 08-09-2002
 ;  Added check for "~NO PAYER", if it does not exist, build it
 ;
 Q
 ;
EN ; Entry Point
 ; Prevent simultaneous runs
 ; Set error trap to ensure that lock is released
 N $ES,$ET
 S $ET="D ER^IBCNEDE"
 ; Check lock
 L +^TMP("IBCNEDE"):1 I '$T D  G ENX
 . I '$D(ZTSK) W !!,"The eIV Nightly Task is already running, please retry later." D PAUSE^VALM1
 ; Reset reg ack flag
 S $P(^IBE(350.9,1,51),U,22)=""
 ; If "~NO PAYER" is not a valid Payer File entry, rebuild it from
 ;  the existing utility
 I '$$FIND1^DIC(365.12,,"X","~NO PAYER") D PAYR^IBCNEUT2
 ;
 ; Confirm that all necessary tables have been loaded
 ; before the extract is run
 I '$$TBLCHK() G EN1
 ;
 D AMCHECK^IBCNEUT6     ; ensure Auto Match entries are valid
 ;
 ; Run All 3 extracts and launch IBCNEDEP(Inquiries)
 D EN^IBCNEDE1 ; Insurance Buffer Extract
 ; Check to see if background process has been stopped, if so quit.
 I $G(ZTSTOP) G ENX
 D EN^IBCNEDE2 ; Pre Reg Extract
 ; Check to see if background process has been stopped, if so quit.
 I $G(ZTSTOP) G ENX
 D EN^IBCNEDE3 ; Non Verified Extract
 ; Check to see if background process has been stopped, if so quit.
EN1 I $G(ZTSTOP) G ENX
 ; Send enrollment message
 D ^IBCNEHLM
 I $G(ZTSTOP) G ENX
 I '$G(QFL) D
 . ; Wait for 'AA' acknowledgement
 . D WAIT  Q:'+QFL
 . KILL QFL
 . ;
 . D ^IBCNEDEP  ; Inquiries Processing
 ;
 ; Check to see if background process has been stopped, if so quit.
 I $G(ZTSTOP) G ENX
 D MMQ         ; Queue the Daily MailMan message
 ; Send MailMan message if first of month to report on records 
 ;  eligible to be purged
 I +$E($P($$NOW^XLFDT(),"."),6,7)=1 D MMPURGE^IBCNEKI2
 ;
ENX ; Purge task record - if queued
 I $D(ZTQUEUED) S ZTREQ="@"
 L -^TMP("IBCNEDE")
 Q
 ;
TBLCHK() ;
 ; Confirm that at least one eIV payer and that all X12 tables
 ; have been loaded
 N PAY,PAYIEN,PAYOK,TBLOK,II
 S (PAY,PAYIEN,PAYOK)="",TBLOK=1
 F  S PAY=$O(^IBE(365.12,"B",PAY)) Q:PAY=""!PAYOK  I PAY'="~NO PAYER" D
 .  F  S PAYIEN=$O(^IBE(365.12,"B",PAY,PAYIEN)) Q:PAYIEN=""!PAYOK  D
 ..    I $$PYRAPP^IBCNEUT5("IIV",PAYIEN) S PAYOK=1 Q
 I PAYOK D
 . F II=11:1:18,21 I $O(^IBE(II*.001+365,"B",""))="" S TBLOK="" Q
 Q PAYOK&TBLOK
 ;
WAIT ;  Wait for acknowledgement comes back from EC
 ;  Hang for 60 seconds and check status again
 ;  Try 360 times for a total of 21600 seconds (6 hours)
 S QFL=0,CT=0
 F  D  Q:QFL'=""!(CT>360)
 . S QFL=$$GET1^DIQ(350.9,"1,",51.22,"I")
 . Q:QFL'=""
 . HANG 60 S CT=CT+1
 KILL CT
 Q
 ;
FRESHDT(EXT,STALEDYS) ;  Calculate Freshness
 ;  Ext - ien of extract for future purposes
 ;  Staledys - # of days in the past in which an insurance verification
 ;  is considered still valid/current
 N STALEDT
 S STALEDT=$$FMADD^XLFDT(DT,-STALEDYS)
 Q STALEDT
 ;
 ; ---------------------------------------------------
MMQ ; This procedure is responsible for scheduling the creation and 
 ; sending of the daily MailMan statistical message if the site has
 ; defined this appropriately in the eIV site parameters.
 ;
 NEW IIV,CURRTIME,MTIME,MSG,Y,MGRP
 NEW ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 ;
 S IIV=$G(^IBE(350.9,1,51))
 I '$P(IIV,U,2) G MMQX          ; site does not want daily messages
 I '$P(IIV,U,3) G MMQX          ; MM message time is not defined
 I '$P(IIV,U,4) G MMQX          ; Mail Group is not defined
 ;
 S CURRTIME=$P($H,",",2)        ; current $H time
 S MTIME=DT_"."_$P(IIV,U,3)     ; build a FileMan date/time
 S MTIME=$$FMTH^XLFDT(MTIME)    ; convert to $H format
 S MTIME=$P(MTIME,",",2)        ; $H time of MM message
 ;
 ; If the current time is after the MailMan message time, then 
 ; schedule the MM message for tomorrow at that time.
 I CURRTIME>MTIME S ZTDTH=($H+1)_","_MTIME
 ;
 ; Otherwise, schedule it for later today
 E  S ZTDTH=+$H_","_MTIME
 ;
 ; Set up the other TaskManager variables
 S ZTRTN="MAILMSG^IBCNERP7"
 S ZTDESC="eIV Daily Statistics E-Mail"
 S ZTIO=""
 D ^%ZTLOAD            ; Call TaskManager
 I $G(ZTSK) G MMQX     ; Task# is OK so get out
 ;
 ; Send a MailMan message if this Task could not get scheduled
 S MSG(1)="TaskManager could not schedule the daily eIV MailMan message"
 S MSG(2)="at the specified time of "_$E($P(IIV,U,3),1,2)_":"_$E($P(IIV,U,3),3,4)_"."
 S MSG(3)="This is defined in the eIV Site Parameters option."
 ; Set to IB site parameter MAILGROUP
 S MGRP=$$MGRP^IBCNEUT5()
 D MSG^IBCNEUT5(MGRP,"eIV Statistical Message Not Sent","MSG(")
 ;
MMQX ;
 Q
 ;
ER ; Unlock the eIV Nightly Task and return to log error
 L -^TMP("IBCNEDE")
 D ^%ZTER
 D UNWIND^%ZTER
 Q
 ;
