DG53672C ;ALB/BRM,LBD,ERC;DG*5.3*672 CLEAN-UP UTILITIES ; 8/16/05 12:12pm
 ;;5.3;Registration;**672**;Aug 13,1993
 ;;
 ; This routine will be used to loop through Patient File (#2) entries
 ; and will call all necessary clean-up routines.
 ;
QUE ; Que job to run
 N ZTRTN,ZTDESC,ZTSAVE,ZTSK,ZTDTH,ZTQUEUED,ZTIO
 ;
 D BMES^XPDUTL("This process will perform the following clean-up activities:")
 D BMES^XPDUTL("   1) Find and delete all Reimbursable Insurance Other Eligibility")
 D MES^XPDUTL("      Codes on patients that are not deceased.  A Mailman message")
 D MES^XPDUTL("      will be sent upon completion of this job containing a summary")
 D MES^XPDUTL("      of the clean-up results.")
 ;
 ;
 D BMES^XPDUTL("   2) Convert data in Patient file field 1010.58, Disability Discharge on 1010EZ")
 D MES^XPDUTL("      to the corresponding value in field .3603, Discharge Due to Disability.")
 D MES^XPDUTL("      Convert data in Patient file field .362, Disability Ret. from Military")
 D MES^XPDUTL("      if the value is 1 or 2 to a 1 (YES) in field .3602, Military Disability")
 D MES^XPDUTL("      Retirement and field .3603, Discharge Due to Disability.")
 ;
 D MES^XPDUTL("      ")
 ; 
 S ZTRTN="FIND^DG53672C",ZTIO="",ZTDTH=$$NOW^XLFDT()
 S ZTDESC="DG*5.3*672 CLEAN-UP PROCESSES"
 D ^%ZTLOAD,HOME^%ZIS
 I '$G(ZTSK) D BMES^XPDUTL("Clean-up was not tasked.") Q
 D BMES^XPDUTL("Clean-up has been tasked as Task #"_ZTSK)
 Q
 ;
FIND ; entry point
 ;
 N DFN,RIELIG,X1,X2,X
 ;
 K ^XTMP("DG53672C")
 S X1=DT,X2=90 D C^%DTC
 S ^XTMP("DG53672C",0)=X_"^"_$$NOW^XLFDT_"^DG*5.3*672 CLEAN-UP JOBS"
 S ^XTMP("DG53672C",0,"TASK")=$G(ZTSK)
 ; Reimbursible Other EC Clean-up Process Setup
 D RSETUP^DG53672R(.RIELIG)
 ;
 S DFN=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .S ^XTMP("DG53672C","TCNT")=$G(^XTMP("DG53672C","TCNT"))+1
 .;
 .; process reimbursable insurance other EC deletions
 .D REIM^DG53672R(DFN,.RIELIG)
 .;
 .;convert Disability Discharge on 1010EZ
 .D EN^DG53672D(DFN)
 ;
 S $P(^XTMP("DG53672C",0),"^",4)=$$NOW^XLFDT
 ;
 ; send message for Reimbursable Insur. Job
 D SNDMSG^DG53672R
 ;send message for disability discharge data conversion
 D SNDMSG^DG53672D
 Q
