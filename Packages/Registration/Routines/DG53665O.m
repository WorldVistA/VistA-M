DG53665O ;ALB/BRM,LBD;DG*5.3*665 PRE-INSTALL ; 5/23/05 10:22am
 ;;5.3;Registration;**665**;Aug 13,1993
 ;;
 ; This pre-install routine will transmit all Korean DMZ Agent Orange
 ; veterans to the HEC.
 ;
AOQUE ; Que job to run
 N ZTRTN,ZTDESC,ZTSAVE,ZTSK,ZTDTH,ZTQUEUED,ZTIO
 ;
 D BMES^XPDUTL("  This process will find all Agent Orange Veterans who have")
 D MES^XPDUTL("  an Agent Orange Location of Korean DMZ and transmit them to")
 D MES^XPDUTL("  the Health Eligibility Center.")
 D MES^XPDUTL("      ")
 ; 
 S ZTRTN="FIND^DG53665O",ZTIO="",ZTDTH=$$NOW^XLFDT()
 S ZTDESC="DG*5.3*665 PRE-INSTALL PROCESS"
 D ^%ZTLOAD,HOME^%ZIS
 I '$G(ZTSK) D BMES^XPDUTL("Pre-install process was not tasked.") Q
 D BMES^XPDUTL("Pre-install process has been tasked as Task #"_ZTSK)
 Q
 ;
FIND ; entry point
 ;
 N DFN,X1,X2,X
 ;
 K ^XTMP("DG53665O")
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("DG53665O",0)=X_"^"_$$NOW^XLFDT_"^DG*5.3*665 PRE-INSTALL"
 S ^XTMP("DG53665O",0,"TASK")=$G(ZTSK)
 ;
 S DFN=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .S ^XTMP("DG53665O","TCNT")=$G(^XTMP("DG53665O","TCNT"))+1
 .;
 .; quit if patient is deceased
 .Q:$P($G(^DPT(DFN,.35)),"^")
 .; quit - patient does not have the AO Exposure Indicator set to 'YES'
 .Q:$P($G(^DPT(DFN,.321)),"^",2)'="Y"
 .; quit if the patient does not show 'Korean DMZ' as the AO Location
 .Q:$P($G(^DPT(DFN,.321)),"^",13)'="K"
 .; process HL7 transmission
 .D EVENT^IVMPLOG(DFN)
 .S ^XTMP("DG53665O","DATA",DFN)=""
 .S ^XTMP("DG53665O","CNT")=$G(^XTMP("DG53665O","CNT"))+1
 .Q
 ;
 S $P(^XTMP("DG53665O",0),"^",4)=$$NOW^XLFDT
 ;
 ; send message for AO job
 D SNDMSG
 Q
 ;
 ;
SNDMSG ; Send Mailman bulletin when process completes
 N SITE,STATN,SITENM,XMDUZ,XMSUB,XMY,XMTEXT,MSG
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),U,3),SITENM=$P($G(SITE),U,2)
 S:$$GET1^DIQ(869.3,"1,",.03,"I")'="P" STATN=STATN_" [TEST]"
 S XMDUZ="AO-KOREAN DMZ TRANSMISSION JOB",XMSUB=XMDUZ_" - "_STATN
 S XMY(DUZ)=""
 S XMTEXT="MSG("
 S MSG(1)="The Agent Orange Korean DMZ transmission process has completed successfully."
 S MSG(2)="This process searched for patient records with an Agent Orange Exposure"
 S MSG(3)="Location of Korean DMZ, and queued the record for a Z07 transmission to"
 S MSG(4)="the Health Eligibility Center. "
 S MSG(4.5)=""
 S MSG(5)="Task: "_$G(^XTMP("DG53665O",0,"TASK"))
 S MSG(6)="Site Station Number: "_STATN
 S MSG(7)="Site Name: "_SITENM
 S MSG(8)=""
 S MSG(9)="Process started   : "_$$FMTE^XLFDT($P($G(^XTMP("DG53665O",0)),U,2))
 S MSG(10)="Process completed : "_$$FMTE^XLFDT($P($G(^XTMP("DG53665O",0)),"^",4))
 S MSG(10.5)=""
 S MSG(11)="Total Patients processed                   : "_+$G(^XTMP("DG53665O","TCNT"))
 S MSG(12)="AO Korean DMZ rec. queued for transmission : "_+$G(^XTMP("DG53665O","CNT"))
 S MSG(12.5)=""
 S MSG(13)="For identification of the patients for whom the AO Korean DMZ job"
 S MSG(14)=" sent a record to HEC, you can review the following global:"
 S MSG(15)="    ^XTMP(""DG53665O"",""DATA"",DFN)"
 S MSG(16)=" DFN = internal entry number of the Patient file (#2)."
 D ^XMD
 Q
