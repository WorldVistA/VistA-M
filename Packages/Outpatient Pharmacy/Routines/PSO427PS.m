PSO427PS ;ALB/DMB - Post-install for PSO*7*427 ;10/21/2014
 ;;7.0;OUTPATIENT PHARMACY;**427**;DEC 1997;Build 21
 ;
 Q
 ;
EN ; Entry Point for post-install
 D BMES^XPDUTL("  Starting post-install for PSO*7*427")
 ;
 ; Removed Cached protocol menus
 D PROT("PSO REJECT DISPLAY HIDDEN MENU")
 D PROT("PSO REJECTS HIDDEN ACTIONS #1")
 ;
 ; Update Insurance Pointer in REJECT INFO subfile
 D INSJOB
 ; 
 ; Completion message
 D BMES^XPDUTL("  Finished post-install for PSO*7*427")
 Q
 ;
PROT(MENU) ;
 ; Remove cached hidden menu
 N PSOIEN,XQORM
 S PSOIEN=$O(^ORD(101,"B",MENU,0))
 S XQORM=PSOIEN_";ORD(101,"
 I $D(^XUTL("XQORM",XQORM)) D
 . D MES^XPDUTL("    Removing cached menu for "_$P(^ORD(101,PSOIEN,0),U))
 . K ^XUTL("XQORM",XQORM)
 Q
 ;
INSJOB ;
 ; Job the process to update the Reject file
 D BMES^XPDUTL("    Queuing background job to update the Reject mult of the Prescription file")
 D MES^XPDUTL("    A Mailman message will be sent when it finishes")
 ;
 ; Setup required variables
 S ZTRTN="INS^PSO427PS",ZTIO="",ZTDTH=$H
 S ZTDESC="Background job to update the Prescription file via PSO*7*427"
 ;
 ; Task the job
 D ^%ZTLOAD
 ;
 ; Check if task was created
 I $D(ZTSK) D MES^XPDUTL("    Task #"_ZTSK_" queued")
 I '$D(ZTSK) D MES^XPDUTL("   Task not queued.  Please create a support ticket.")
 Q
 ;
INS ;
 ; Entry Point to populate the insurance company pointer in the REJECT INFO subfile
 N CNT,DAT,RX,RN,RSPIEN,INS,IEN57,INSNM
 N DIE,DA,DR,DTOUT,DUOUT,DIROUT,DIRUT
 S CNT=0
 ; Loop through index
 S DAT=0 F  S DAT=$O(^PSRX("REJDAT",DAT)) Q:'DAT  D
 . S RX="" F  S RX=$O(^PSRX("REJDAT",DAT,RX)) Q:'RX  D
 .. S RN="" F  S RN=$O(^PSRX("REJDAT",DAT,RX,RN)) Q:'RN  D
 ... ;If already populated, quit
 ... I $P($G(^PSRX(RX,"REJ",RN,2)),"^",9) Q
 ... ; Get Response pointer
 ... S RSPIEN=$P($G(^PSRX(RX,"REJ",RN,0)),"^",11)
 ... ; If the Response pointer exists, get Log of Transaction record and Insurance Pointer from that file
 ... S (IEN57,INS)=""
 ... I RSPIEN D
 .... S IEN57=$O(^BPSTL("AF",RSPIEN,""))
 .... I IEN57 S INS=$$GET1^DIQ(9002313.57902,"1,"_IEN57_",",902.33,"I")
 .... I INS,'$D(^DIC(36,INS,0)) S INS=""
 ... ; If missing from the Transaction, try to match on the insurance name
 ... ; There can only be one insurance company with the same name
 ... I INS="" D
 .... S INSNM=$P($G(^PSRX(RX,"REJ",RN,2)),"^",4)
 .... I INSNM]"" S INS=$O(^DIC(36,"B",INSNM,""))
 .... I INS,$O(^DIC(36,"B",INSNM,INS)) S INS=""
 ... ; Quit if there is no insurance
 ... I INS="" Q
 ... ; Set insurance company into the field
 ... S DIE="^PSRX("_RX_",""REJ"",",DA(1)=RX,DA=RN,DR=33_"////"_INS
 ... D ^DIE
 ... K DA,DR,DIE
 ... S CNT=CNT+1
 ;
 ; Send email with result
 D MAIL(CNT)
 Q
 ;
MAIL(SUCCNT) ;
 N CNT,MSG,XMY,XMDUZ,DIFROM,XMSUB,XMTEXT
 S XMY(DUZ)=""
 S XMSUB="PSO*7.0*427 Post install is complete",XMDUZ="Patch PSO*7.0*427"
 S XMTEXT="MSG("
 S CNT=1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="Patch PSO*7.0*427 post install routine has completed."
 S CNT=CNT+1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="Updated "_SUCCNT_" records in the PRESCRIPTION file."
 S CNT=CNT+1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="For more information about this post install, review the patch description."
 D ^XMD
 Q
