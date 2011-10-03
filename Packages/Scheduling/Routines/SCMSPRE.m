SCMSPRE ;ALB/JRP - AMB CARE PRE INIT DRIVER;28-MAY-1996
 ;;5.3;Scheduling;**44**;AUG 13, 1993
CHKPTS ;Create check points for pre-init
 ;Input  : All variables set by KIDS
 ;Output : None
 ;
 ;Declare variables
 N TMP
 ;Create check points
 ;Create Z00 HL7 Event Code
 S TMP=$$NEWCP^XPDUTL("SCMS01","HL7EVNT^SCMSP0")
 ;Create HL7 Applications
 S TMP=$$NEWCP^XPDUTL("SCMS02","HL7APPS^SCMSP0")
 ;Create Mail Group for HL7 Logical Link
 S TMP=$$NEWCP^XPDUTL("SCMS03","MAILGRP^SCMSP0")
 ;Create HL7 Lower Level Protocol Parameters
 S TMP=$$NEWCP^XPDUTL("SCMS04","HL7LLPP^SCMSP0")
 ;Create HL7 Logical Link
 S TMP=$$NEWCP^XPDUTL("SCMS05","HL7LINK^SCMSP0")
 ;Done
 Q
