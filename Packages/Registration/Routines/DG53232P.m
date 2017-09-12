DG53232P ;ALB/KCL - DG*5.3*232 Post-Install Driver ; 20-MAY-1999
 ;;5.3;Registration;**232**;Aug 13, 1993
 ;
 ;
EN ; Description: This entry point will be used as a driver for
 ;  post-installation updates.
 ;
 N ERROR
 ;
 ; - Inactivate CATASTROPHICALLY DISABLED Eligibility Code
 S ERROR=$$INACT^DG53232A
 I ERROR'="",ERROR'=0 D BMES^XPDUTL("**** ERROR: "_ERROR_" ****")
 ;
 ; - Load contents of #27.17 CATASTROPHIC DISABILITY REASONS
 S ERROR=$$LOAD2717^DG53232A
 I ERROR'="",ERROR'=0 D BMES^XPDUTL("**** ERROR: "_ERROR_" ****")
 ;
 ; - Send HEC a notification msg that patch was installed
 D NOTIFY^DG53232A
 ;
 Q
