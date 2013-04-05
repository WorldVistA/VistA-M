DGQEPST ;ALB/JFP - VIC POST INIT DRIVER; 09/01/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
CHKPTS ; -- Create check points for post-init
 ;Input  : All variables set by KIDS
 ;Output : None
 ;
 ; -- Declare variables
 N TMP
 ; -- Update HL7 application DGQE VIC EVENTS with site #
 S TMP=$$NEWCP^XPDUTL("DGQE1","APPUPD^DGQEPST1")
 ; -- Update Logical Link with device
 S TMP=$$NEWCP^XPDUTL("DGQE2","UPDLL^DGQEPST1")
 ; -- Update Bulletin with mail group
 S TMP=$$NEWCP^XPDUTL("DGQE3","UPDBULL^DGQEPST1")
 ; -- Message to add members to VIC mail group
 S TMP=$$NEWCP^XPDUTL("DGQE4","MAILMEM^DGQEPST1")
 ; -- Check for version 2.2
 S TMP=$$NEWCP^XPDUTL("DGQE5","CHKVER^DGQEPST1")
 ; -- Check A08 message for version 2.2
 S TMP=$$NEWCP^XPDUTL("DGQE6","CHKA08^DGQEPST1")
 ; -- Check ACK message for version 2.2
 S TMP=$$NEWCP^XPDUTL("DGQE7","CHKACK^DGQEPST1")
 ; -- Re-index file 870 to set ALLP cross reference
 S TMP=$$NEWCP^XPDUTL("DGQE8","ALLP^DGQEPST1")
 ;Done
 Q
