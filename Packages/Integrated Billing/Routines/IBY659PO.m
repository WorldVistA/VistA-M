IBY659PO ;AITC/VD - Post-Installation for IB patch 659; 22-MAY-2018
 ;;2.0;INTEGRATED BILLING;**659**;21-MAR-94;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
DOC ; 
 ; REGMSG send site registration message to FSC for version change from 10 to 11.
 ;     Don't send if site is MANILA (#358)
 ; SITEFIL set the initial values for:
 ;     MEDICARE FRESHNESS DAYS in [#350.9,51.32] to "365".
 ;     MANILA EIV ENABLED in [#350.9,51.33] to "N" for all VAMC sites.
 ; TSKCLN clean-up the corrupted records in the Insurance Verification Processor file (#355.33).
 ;      ICR # 10063 for ^%ZTLOAD
 ;      ICR # 10103 for ^XLFDT
 ;
EN ; Entry Point for Post-Install routine
 N IBXPD,SITESYS,XPDIDTOT
 S XPDIDTOT=4
 ;
 S SITESYS=$P($$SITE^VASITE,U,3)    ; Get the current site number (piece 3 is the ACTUAL site #).
 D MES^XPDUTL("")
 D SITEFIL(1)   ; Set initial value for the new field [#350.9,51.32]
 D SITEFIL(2)   ; Set initial value for the new field [#350.9,51.33]
 D TSKCLN(3)   ; Clean-up the corrupted records in the Insurance Verification Processor File (#355.33).
 D REGMSG(4)    ; Send site registration message to FSC
 ;
 ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("")
 D MES^XPDUTL("POST-Install Completed.")
 Q
 ;
REGMSG(IBXPD) ; send site registration message to FSC
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Sending site registration message to FSC ... ")
 ;
 I SITESYS=358 D MES^XPDUTL("Current Site is MANILA - NO Site Registration Message sent") G REGMSGQ   ; Don't send if Manila (#358)
 I '$$PROD^XUPROD(1) D MES^XPDUTL(" N/A - Not a production account - No site registration message sent") G REGMSGQ
 D ^IBCNEHLM
 ;
REGMSGQ ;
 Q
 ;
SITEFIL(IBXPD) ; Set initial value of [#350.9,51.32] and [#350.9,51.33]
 N DA,DIE,DR
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 ;
 I IBXPD=1 D  Q
 .D MES^XPDUTL("Initialize value of MEDICARE FRESHNESS DAYS to 365 in IB SITE PARAMETERS file...")
 .S DIE=350.9,DA=1,DR="51.32///365" D ^DIE
 .K DA,DIE,DR
 ;
 I IBXPD=2 D  Q
 .D MES^XPDUTL("Setting MANILA EIV ENABLED field to 'N' for No in IB SITE PARAMETERS file...")
 .S DA=1,DIE=350.9,DR="51.33///"_"N" D ^DIE
 .K DA,DIE,DR
 ;
 Q
 ;
TSKCLN(IBXPD) ; Clean-up corrupted records in the Insurance Verification Processor file #355.33
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Tasking the Clean-up of corrupted records in the Insurance Verification")
 D MES^XPDUTL("    Processor file #355.33 ...")
 N MSG,ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTRTN
 S ZTDESC="CLEAN-UP OF CORRUPTED RECORDS IN #355.33"
 S ZTDTH=$P($$NOW^XLFDT(),"."),ZTDTH=$$FMADD^XLFDT(ZTDTH,,20)   ; ZTDTH = TODAY AT 8:00 PM  ;ICR# 10103 for XLFDT
 S ZTIO=""
 S ZTQUEUED=1
 S ZTRTN="BADRECS^IBY659PO"
 ;
 S MSG=$$TASK(ZTDTH,ZTDESC,ZTRTN,ZTIO)     ;To be run at 8:00 PM
 D MES^XPDUTL(MSG)
TSKCLNQ Q
 ;
TASK(ZTDTH,ZTDESC,ZTRTN,ZTIO) ;bypass for queued task
 N %DT,GTASKS,IDT,MSG,TSK,XDT,Y,ZTSK
 S (IDT,Y)=ZTDTH D DD^%DT S XDT=Y    ; XDT is TODAY@2000 reformatted to a readable date.
 ;
 ;Check if task already scheduled for date/time
 K GTASKS
 D DESC^%ZTLOAD(ZTDESC,"GTASKS")
 S TSK=""
 S TSK=$O(GTASKS(TSK))
 I TSK'=""  D  Q MSG
 . S ZTSK=TSK D ISQED^%ZTLOAD
 . S MSG="Task (#"_+ZTSK_") already scheduled to run on "_$$HTE^XLFDT(ZTSK("D"),1)
 ;
 ;Schedule the task
 S TSK=$$SCHED(IDT,ZTIO)
 ;
 ;Check for scheduling problem
 I '$G(TSK) S MSG=" Task Could Not Be Scheduled" Q MSG
 ;
 ;Send successful schedule message
 S MSG=" Clean-up of corrupted records in file #355.33 scheduled for "_XDT
 Q MSG
 ;
SCHED(ZTDTH,ZTIO) ;
 N ZTSK
 D ^%ZTLOAD
 Q ZTSK
 ;
BADRECS(IBXPD) ; Clean-up corrupted records in File #355.33.
 N CNT0,CNTAR,DA,DIC,DIE,DR,IBBUFDA,IBXMY,MSG,SITESYS,SITENAME
 S (CNT0,CNTAR,IBBUFDA)=0
 ; recalculate SITESYS here as this tag is called from TaskMan
 S SITESYS=$$SITE^VASITE    ; Get the site name & #
 S SITENAME=$P(SITESYS,U,2),SITESYS=$P(SITESYS,U,3)    ; piece 3 is the site #
 ;
 ;Search for corrupted records.
 F  S IBBUFDA=$O(^IBA(355.33,IBBUFDA)) Q:('+IBBUFDA)  D
 . I '$D(^IBA(355.33,IBBUFDA,0)) D DELDATA S CNT0=CNT0+1 Q   ;Delete the current buffer because there is no ZERO node.
 . I (("^A^R^")[("^"_$$GET1^DIQ(355.33,IBBUFDA_",",.04,"I")_"^")),($O(^IBA(355.33,IBBUFDA,0))'="") D DELDATA S CNTAR=CNTAR+1 Q  ;Check only Accepted or Rejected buffers to see if there is data to delete.
 ;
 ;Send mailman message at completion.
 S MSG(1)="Patch IB*2.0*659 Post Install - Clean-up of corrupted #355.33 records has completed."
 S MSG(2)="------------------------------------------------------------------------"
 S MSG(3)="  Total number of corrupted buffer entries removed (no ZERO node): "_+CNT0
 S MSG(4)="  Total number of Accepted/Rejected GHOST buffer entries removed:  "_+CNTAR
 ;
 I $$PROD^XUPROD(1) S IBXMY("VHAeInsuranceRapidResponse@domain.ext")=""  ; Only send to eInsurance Rapid Response if in Production
 D MSG^IBCNEUT5(,"IB*2.0*659 Post Install ("_SITESYS_"-"_SITENAME_")","MSG(",,.IBXMY)
 ;
 ; Tell TaskManager to delete the task's record
 I $D(ZTQUEUED) S ZTREQ="@"
BADRECQ Q   ; Exit from Cleaning up Buffers.
 ;
DELDATA ; Delete data from corrupted records.
 N DA,DIC,DIE,DR,IBCNT,IBFLD,IBFLDS,IBI,IBIFN,IBX,X,Y
 S X=$O(^IBA(355.33,IBBUFDA,0)) Q:X=""   ; No data found after ZERO node - get next.
 ;
 ; The current buffer is either ACCEPTED or REJECTED & has data to be deleted.
 S IBIFN=IBBUFDA_",",DR="",IBCNT=1
 D GETS^DIQ(355.33,IBIFN,"1:999","IN","IBFLDS") ; This returns a non-blank fields.
 ;
 S IBFLD=0
 F  S IBFLD=$O(IBFLDS(355.33,IBIFN,IBFLD)) Q:'IBFLD  D    ; Set up the DR string.
 . I $L(DR)>200 S DR(1,355.33,IBCNT)=DR,DR="",IBCNT=IBCNT+1
 . S DR=DR_IBFLD_"///@;"
 ;
 I DR'="" D   ; Delete data then nodes.
 . S DIE="^IBA(355.33,",DA=IBBUFDA D ^DIE K DA,DIC,DIE,DR
 ;
 ; Kill blank nodes since DIE doesn't
 S IBI=0
 F  S IBI=$O(^IBA(355.33,IBBUFDA,IBI)) Q:'IBI  D
 . S IBX=$G(^IBA(355.33,IBBUFDA,IBI))
 . I IBX?."^" K ^IBA(355.33,IBBUFDA,IBI)
 Q
 ;
