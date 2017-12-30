PSO7P478 ;AITC/PD - Post-install for PSO*7*478 ;6/15/2017
 ;;7.0;OUTPATIENT PHARMACY;**478**;;Build 27
 ; Reference to BPSNCPD3 supported by IA 4560
 ;
 Q
 ;
POST ; Post-install functions are coded here.
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 ;
 D BMES^XPDUTL("  Queuing background job to update REJECT INFO sub-file of the PRESCRIPTION")
 D MES^XPDUTL("  file. A Mailman message will be sent upon completion.")
 ;
 ; Setup required variables
 S ZTRTN="PCN^PSO7P478"
 S ZTIO=""
 S ZTDTH=$H
 S ZTDESC="Background job to update REJECT INFO sub-file for PSO*7*478"
 ;
 ; Task the job
 D ^%ZTLOAD
 ;
 ; Check if task was created
 I $D(ZTSK) D MES^XPDUTL("  Task #"_ZTSK_" queued.")
 I '$D(ZTSK) D MES^XPDUTL("  Task not queued. Please create a support ticket.")
 ;
 Q
 ;
PCN ;Update PCN on PRESCRIPTION reject multiple
 ;
 N CNT,COB,DAT,DUR,RX,RN,RSPIEN,DA,DR,DIE
 S CNT=0
 S DAT=0 F  S DAT=$O(^PSRX("REJDAT",DAT)) Q:'DAT  D
 . S RX="" F  S RX=$O(^PSRX("REJDAT",DAT,RX)) Q:'RX  D
 .. S RN="" F  S RN=$O(^PSRX("REJDAT",DAT,RX,RN)) Q:'RN  D
 ... I $P($G(^PSRX(RX,"REJ",RN,2)),"^",10)'="" Q
 ... S RSPIEN=$P($G(^PSRX(RX,"REJ",RN,0)),"^",11) I 'RSPIEN Q
 ... S COB=$P($G(^PSRX(RX,"REJ",RN,2)),"^",7) I COB="" S COB=1
 ... K DUR D DURRESP^BPSNCPD3(RSPIEN,.DUR,COB)     ; ICR# 4560
 ... I $L(DUR(COB,"PCN"))'=10 Q
 ... S DIE="^PSRX("_RX_",""REJ"",",DA(1)=RX,DA=RN,DR=34_"////"_DUR(COB,"PCN")
 ... D ^DIE K DA,DR,DIE
 ... S CNT=CNT+1
 ;
 D MAIL(CNT)  ; Send mail message
 Q
 ;
MAIL(PCNCNT) ; Send mail message
 N CNT,MSG,XMY,XMDUZ,DIFROM,XMSUB,XMTEXT
 S XMY(DUZ)=""
 S XMSUB="PSO*7.0*478 Post install is complete",XMDUZ="Patch PSO*7.0*478"
 S XMTEXT="MSG("
 S CNT=1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="Patch PSO*7.0*478 post install routine has completed."
 S CNT=CNT+1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="Updated "_PCNCNT_" records in the REJECT INFO sub-file of the PRESCRIPTION file."
 S CNT=CNT+1,MSG(CNT)=""
 S CNT=CNT+1,MSG(CNT)="For more information about this post install, review the patch description."
 D ^XMD
 Q
