PSJ0171 ;BPOIFO/BI - Correct zero node in File 55 Activity Multiple ;01-FEB-06
 ;;5.0; INPATIENT MEDICATIONS ;**171**;16 DEC 97
 ;
 ;Reference to ^PS(55 is supported by DBIA# 2191.
 ;
 Q
 ;
EN ; Check user and Queue Job.
 N ZTSAVE,ZTSK,ZTRTN,ZTDESC,ZTIO,ZTDTH,PIMSG
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 S ZTRTN="ENQ^PSJ0171",ZTDESC="Inpatient Meds Activity Multiple Cleanup",ZTIO="",ZTDTH=$H D ^%ZTLOAD
 D:$D(ZTSK)
 .K PIMSG
 .S PIMSG(1)="The cleanup of existing Activity Multiple Nodes is"
 .S PIMSG(2)="queued to start NOW."
 .S PIMSG(3)=" "
 .S PIMSG(4)="YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 .D MES^XPDUTL(.PIMSG)
 D:'$D(ZTSK)
 .K PIMSG
 .S PIMSG(1)="The cleanup of existing Activity Multiple Nodes was"
 .S PIMSG(2)="NOT queued."
 .D MES^XPDUTL(.PIMSG)
 S ZTREQ="@"
 Q
 ;
ENQ ; Scan through file ^PS(55 and correct the Activity Multiple Node.
 N ZS2,ZS4,ZD6,ZD62
 S ZS2=0 F  S ZS2=$O(^PS(55,ZS2)) Q:+ZS2=0  D
 .S ZS4=0 F  S ZS4=$O(^PS(55,ZS2,5,ZS4)) Q:+ZS4=0  D
 ..S ZD6=$G(^PS(55,ZS2,5,ZS4,9,0))
 ..S ZD62=$P(ZD6,"^",2)
 ..I ZD62="55,09D" D
 ...S $P(^PS(55,ZS2,5,ZS4,9,0),"^",2)="55.09D"
 D SENDMSG
 Q
 ;
SENDMSG  ;Send mail message when check is complete.
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,PSG
 S XMDUZ="MEDICATIONS,INPATIENT"
 S XMSUB="PSJ*5*171 INPATIENT MEDS ACTIVITY MULTIPLE CLEANUP COMPLETED"
 S XMTEXT="PSG("
 S XMY(DUZ)=""
 S PSG(1,0)="The cleanup of the Inpatient Medication Activity Multiple has completed."
 D ^XMD
 Q
