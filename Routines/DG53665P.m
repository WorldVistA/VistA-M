DG53665P ;ALB/RMM - TRIGGER DT/TM CROSS REFERENCES [PATIENT] ; 05/23/2004
 ;;5.3;Registration;**665**;Aug 13, 1993
 ;
 ;
EN ; This is the post-install routine for patch DG*5.3*665.
 ; Queue job to run in the background.
 N ZTRTN,ZTDESC,ZTSAVE,ZTSK,ZTDTH,ZTQUEUED,ZTIO
 D BMES^XPDUTL("  This post-install process for patch DG*5.3*665 will add")
 D MES^XPDUTL("  seven cross-reference triggers to the PATIENT File #2 to")
 D MES^XPDUTL("  populate the new date/time fields added by this patch.")
 D MES^XPDUTL("      ")
 S ZTRTN="EN1^DG53665P",ZTIO="",ZTDTH=$$NOW^XLFDT()
 S ZTDESC="DG*5.3*665 POST-INSTALL PROCESS"
 D ^%ZTLOAD,HOME^%ZIS
 I '$G(ZTSK) D BMES^XPDUTL("Post-install process was not tasked.") Q
 D BMES^XPDUTL("Post-install process has been tasked as Task #"_ZTSK)
 Q
EN1 ; This routine contains the code to add new style cross-reference record
 ; triggers for the PATIENT File #2.
 ;
 ; The routine ^DIKCBLD was used to build routines to create the
 ; following routines to modify the Data Dictionary:
 ;
TEMP ; PATIENT File #2 Record Index: ADTTM1
 I '$D(^DD("IX","BB",2,"ADTTM1")) D ^DGADTTM1
 ;
CONF ; PATIENT File #2 Record Index: ADTTM2
 I '$D(^DD("IX","BB",2,"ADTTM2")) D ^DGADTTM2
 ;
PNOK ; PATIENT File #2 Record Index: ADTTM3
 I '$D(^DD("IX","BB",2,"ADTTM3")) D ^DGADTTM3
 ;
SNOK ; PATIENT File #2 Record Index: ADTTM4
 I '$D(^DD("IX","BB",2,"ADTTM4")) D ^DGADTTM4
 ;
ECON ; PATIENT File #2 Record Index: ADTTM5
 I '$D(^DD("IX","BB",2,"ADTTM5")) D ^DGADTTM5
 ;
ECON2 ; PATIENT File #2 Record Index: ADTTM6
 I '$D(^DD("IX","BB",2,"ADTTM6")) D ^DGADTTM6
 ;
DESIG ; PATIENT File #2 Record Index: ADTTM7
 I '$D(^DD("IX","BB",2,"ADTTM7")) D ^DGADTTM7
 Q
