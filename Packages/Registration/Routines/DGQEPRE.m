DGQEPRE ;ALB/JFP - VIC PRE INIT DRIVER; 09/01/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
CHKPTS ; -- Create check points for pre-init
 ;Input  : All variables set by KIDS
 ;Output : None
 ;
 ;Declare variables
 N TMP
 ; -- Create check points
 ;Create Terminal Type file entry
 S TMP=$$NEWCP^XPDUTL("DGQE01","TYPE^DGQEP0")
 ; -- Create Device file entry
 S TMP=$$NEWCP^XPDUTL("DGQE02","DEVICE^DGQEP0")
 ; -- Done
 Q
