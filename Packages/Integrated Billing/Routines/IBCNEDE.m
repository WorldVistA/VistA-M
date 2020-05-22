IBCNEDE ;DAOU/DAC - eIV DATA EXTRACTS ;07-MAY-2015
 ;;2.0;INTEGRATED BILLING;**184,271,300,416,438,497,549,593,595,621,659**;21-MAR-94;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
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
 ;
 ;/vd-IB*2.0*659 - Quit if VAMC Site is MANILA (#358) & EIV is disabled for MANILA.
 I $P($$SITE^VASITE,U,3)=358,$$GET1^DIQ(350.9,"1,",51.33,"I")="N" Q
 ;
 ; IB*2.0*549 - Quit if Nightly Extract Master switch is off
 Q:$$GET1^DIQ(350.9,"1,",51.28,"I")="N"
 ;
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
 D CHKPER ; IB*2.0*595/DM Check for New Person (#200) EIV entries 
 ; 
 ; Confirm that all necessary tables have been loaded
 ; before the extract is run
 I '$$TBLCHK() G EN1
 ;
 ;IB*2.0*593/TAZ/HAN - Add job to update Covered by Health Insurance flag
 D EN^IBCNERTC($P($$NOW^XLFDT,"."))
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
 D EN^IBCNEDE4 ; IB*2.0*621/DM add the EICD extract (formerly No Insurance)
 ; Check to see if background process has been stopped, if so quit.
EN1 I $G(ZTSTOP) G ENX
 ; Send enrollment message
 ;/vd-IB*2*659 - Replaced the following line with the call to verify that the IIV EC Logical Link was running.
 ;D ^IBCNEHLM
 D CKIIVEC    ;Send registration message, check logical link and send email if down.
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
 D DSTQ        ; queue daily statistical message to FSC
 ; Send MailMan message if first of month to report on records 
 ;  eligible to be purged
 I +$E($P($$NOW^XLFDT(),"."),6,7)=1 D MMPURGE^IBCNEKI2
 ;
ENX ; Purge task record - if queued
 I $D(ZTQUEUED) S ZTREQ="@"
 L -^TMP("IBCNEDE")
 Q
 ;
 ;/vd-IB*2*659 - Beginning of new code to check if the IIV EC Logical Link is running.
CKIIVEC ; Verifying that the IIV EC Logical Link is up and running.
 N IEN,LLIEN,XMSUB,XMTEXT,XMY,XX,YY
 S LLIEN=$O(^HLCS(870,"B","IIV EC",""))   ;Get ien for the IIV EC Logical Link.
 D ^IBCNEHLM          ;Send a registration message
 I $$DOW^XLFDT(DT)="Sunday" Q  ;Don't report stuck queues on Sunday.
 S IEN=$O(^HLMA("AC","O",LLIEN,""))
 H 20                 ;Pause for 20 seconds to give the msg a chance to process.
 I (IEN'=""),($O(^HLMA("AC","O",LLIEN,""))=IEN) D  ; If the counters are equal, the new msg hasn't processed.
 . ; Send a Mailman msg to notify e-Biz that the IIV EC Logical Link seems to be down.
 . S XX=$$SITE^VASITE()
 . S YY=$P(XX,"^",2)_" (#"_$P(XX,"^",3)_")"
 . ; Send a MailMan message if link is not processing records
 . I $$PROD^XUPROD(1) S XMY("VHAeInsuranceRapidResponse@domain.ext")=""  ; Only send to eInsurance Rapid Response if in Production
 . ;
 . D MSG004^IBCNEMS1(.MSG,YY)
 . ;
 . D MSG^IBCNEUT5(,MSG(1),"MSG(",1,.XMY)  ; sends to postmaster if XMY is empty
 . ;
 . Q
 Q
 ;/vd-IB*2*659 - End of code added.
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
DSTQ ; This procedure is responsible for scheduling the creation and 
 ; sending of the daily statistical message to FSC.
 ;
 N IIV,CURRTIME,MTIME,MSG,MGRP
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 ;
 S IIV=$G(^IBE(350.9,1,51))
 I '$P(IIV,U,3) G DSTQX          ; MM message time is not defined
 ;
 S CURRTIME=$P($H,",",2)        ; current $H time
 S MTIME=DT_"."_$P(IIV,U,3)     ; build a FileMan date/time
 S MTIME=$$FMTH^XLFDT(MTIME)    ; convert to $H format
 S MTIME=$P(MTIME,",",2)        ; $H time of MM message
 ;
 ; If the current time is after the MailMan message time, then schedule the message for tomorrow at that time.
 ; Otherwise, schedule it for later today.
 S ZTDTH=$S(CURRTIME>MTIME:$H+1,1:+$H)_","_MTIME
 ;
 ; Set up the other TaskManager variables
 S ZTRTN="EN1^IBCNEHLM"
 S ZTDESC="eIV Daily Statistics HL7 Message"
 S ZTIO=""
 D ^%ZTLOAD            ; Call TaskManager
 I $G(ZTSK) G DSTQX    ; Task# is OK so get out
 ;
 ; Send a MailMan message if this Task could not get scheduled
 S MSG(1)="TaskManager could not schedule the daily eIV Statistics HL7 message"
 S MSG(2)="at the specified time of "_$E($P(IIV,U,3),1,2)_":"_$E($P(IIV,U,3),3,4)_"."
 S MSG(3)="This is defined in the eIV Site Parameters option."
 ; Set to IB site parameter MAILGROUP
 S MGRP=$$MGRP^IBCNEUT5() I MGRP'="" D MSG^IBCNEUT5(MGRP,"eIV Statistical HL7 Message Not Sent","MSG(")
 ;
DSTQX ;
 Q
 ;
CHKPER ; IB*2.0*595/DM
 ; check for the existence of New Person: "INTERFACE,IB EIV" and/or "AUTOUPDATE,IBEIV"
 ; send a mailman message to "VHAeInsuranceRapidResponse@domain.ext" if either/both are missing.
 ;
 N IBA,IBI,WKDT,IBMCT,MSG,MGRP,IBXMY
 ;
 S IBA=+$$FIND1^DIC(200,,"MX","AUTOUPDATE,IBEIV"),IBI=+$$FIND1^DIC(200,,"MX","INTERFACE,IB EIV")
 I IBA,IBI Q
 ;
 S WKDT=$$SITE^VASITE()
 S MSG(1)="Missing EIV New Person entries, for station "_$P(WKDT,U,3)_":"_$P(WKDT,U,2)
 S MSG(2)="-------------------------------------------------------------------------------"
 S IBMCT=2
 I 'IBA S MSG(IBMCT)="Entry for 'AUTOUPDATE,IBEIV' is missing",IBMCT=IBMCT+1
 I 'IBI S MSG(IBMCT)="Entry for 'INTERFACE,IB EIV' is missing",IBMCT=IBMCT+1
 S MSG(IBMCT)="-------------------------------------------------------------------------------"
 S MGRP=$$MGRP^IBCNEUT5()
 ; IB*659/DW Added check for production account and changed eInsurance mailgroup to be more self documenting
 I $$PROD^XUPROD(1) S IBXMY("VHAeInsuranceRapidResponse@domain.ext")=""
 D MSG^IBCNEUT5(MGRP,"Missing EIV New Person entries ("_$P(WKDT,U,3)_")","MSG(",,.IBXMY)  ;sends to postmaster if IBXMY is empty
 Q
