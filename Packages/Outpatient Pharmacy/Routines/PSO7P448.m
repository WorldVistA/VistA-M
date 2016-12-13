PSO7P448 ;ALB/MRD - Post Install for PSO patch 448 ;5/28/2015
 ;;7.0;OUTPATIENT PHARMACY;**448**;DEC 1997;Build 25
 ;
 D CLSDAT1(1,2)
 D MENU(2,2)
 ;
 Q
 ;
CLSDAT1(PSOSTEP,PSOTOTAL) ; Job the process to build the new CLSDAT cross-reference.
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 ;
 D BMES^XPDUTL(" Step "_PSOSTEP_" of "_PSOTOTAL)
 D MES^XPDUTL(" -----------")
 D MES^XPDUTL("   Queuing background job to build index of all closed/resolved rejects by")
 D MES^XPDUTL("   date closed/resolved.  A Mailman message will be sent when it finishes.")
 ;
 ; Setup required variables
 S ZTRTN="CLSDAT2^PSO7P448",ZTIO="",ZTDTH=$H
 S ZTDESC="Background job to build CLSDAT index for PSO*7*448"
 ;
 ; Task the job
 D ^%ZTLOAD
 ;
 ; Check if task was created
 I $D(ZTSK) D MES^XPDUTL("   Task #"_ZTSK_" queued.")
 I '$D(ZTSK) D MES^XPDUTL("   Task not queued.  Please create a support ticket.")
 Q
 ;
CLSDAT2 ; Populate the new CLSDAT cross-reference on
 ; file #52, Prescription.
 ;
 N PSOCLSDAT,PSOCNTR,PSOREJ,PSORX
 ;
 ; Kill off the entire cross-reference.
 ;
 K ^PSRX("CLSDAT")
 ;
 ; Loop through all closed/resolved rejects
 ;
 ; ^PSRX("REJSTS",1,Rx IEN, reject IEN)
 ;
 S PSORX=0,PSOCNTR=0
 F  S PSORX=$O(^PSRX("REJSTS",1,PSORX)) Q:'PSORX  D
 . S PSOREJ=0
 . F  S PSOREJ=$O(^PSRX("REJSTS",1,PSORX,PSOREJ)) Q:'PSOREJ  D
 . . ;
 . . S PSOCLSDAT=$P($G(^PSRX(PSORX,"REJ",PSOREJ,0)),"^",6)
 . . I PSOCLSDAT'="" S ^PSRX("CLSDAT",PSOCLSDAT,PSORX,PSOREJ)="",PSOCNTR=PSOCNTR+1
 . . ;
 . . Q
 . Q
 ;
 ; Send mail message when complete.
 ;
 D MAIL(PSOCNTR)
 ;
 Q
 ;
MAIL(PSOCNTR) ;
 ;
 N CNT,MSG,XMY,XMDUZ,DIFROM,XMSUB,XMTEXT
 ;
 S XMY(DUZ)=""
 S XMSUB="PSO*7.0*448 Post install is complete",XMDUZ="Patch PSO*7.0*448"
 S XMTEXT="MSG("
 ;
 S CNT=1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="Patch PSO*7.0*448 post install routine has completed."
 S CNT=CNT+1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="Added "_PSOCNTR_" entries to the new CLSDAT index in the PRESCRIPTION file."
 S CNT=CNT+1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="For more information about this post install, review the patch description."
 ;
 D ^XMD
 ;
 Q
 ;
MENU(PSOSTEP,PSOTOTAL)     ; Remove the cached hidden menu pointers
 N PSORDHM,PSORHA1,XQORM
 D BMES^XPDUTL(" Step "_PSOSTEP_" of "_PSOTOTAL)
 D MES^XPDUTL(" -----------")
 D MES^XPDUTL("   Removing cached hidden menus")
 S PSORDHM=$O(^ORD(101,"B","PSO REJECTS HIDDEN ACTIONS #1",0))
 S XQORM=PSORDHM_";ORD(101,"
 D MES^XPDUTL("    - Removing cached hidden menu for "_$P(^ORD(101,PSORDHM,0),U))
 K ^XUTL("XQORM",XQORM)
 ;
 S PSORDHM=$O(^ORD(101,"B","PSO HIDDEN ACTIONS",0))
 S XQORM=PSORDHM_";ORD(101,"
 D MES^XPDUTL("    - Removing cached hidden menu for "_$P(^ORD(101,PSORDHM,0),U))
 K ^XUTL("XQORM",XQORM)
 Q
 ;
