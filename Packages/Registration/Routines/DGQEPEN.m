DGQEPEN ;ALB/JFP - VIC ENVIRONMENT CHECKER; 09/01/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
CHKENV ; -- Main entry point for environment checker
 ;Input  : All variables set by KIDS
 ;Output : Variables required by KIDS to denote success or failure
 ;         of environment check (XPDQUIT and XPDABORT)
 ;
 ; -- Declare variables
 N VERSION,PATCHED,NODE,PTR,NAME,CHECKED
 W !!,">>> Beginning environment check",!!
 ; -- Check for installation of PIMS version 5.3 - required for install
 W !!,"  Checking for installation of PIMS version 5.3 ..."
 S VERSION=+$$VERSION^XPDUTL("REGISTRATION")
 I (VERSION<5.3) D
 .W !!,"    *** Required element missing ***",!
 .W !,"    Installation of Veteran ID Card requires that PIMS version"
 .W !,"    5.3 be installed - you have version ",VERSION," installed."
 .W !,"    Installation will be aborted at end of environment check."
 .W !
 .S XPDABORT=2
 ;
 ; -- Check for installation of HL7 version 1.6 - required for install
 W !!,"  Checking for installation of HL7 version 1.6 ..."
 S VERSION=+$$VERSION^XPDUTL("HL")
 I (VERSION<1.6) D
 .W !!,"    *** Required element missing ***",!
 .W !,"    Installation of Veteran ID Card requires that HL7 version"
 .W !,"    1.6 be installed - you have version ",VERSION," installed."
 .W !,"    Installation will be aborted at end of environment check."
 .W !
 .S XPDABORT=2
 ;
 ; -- Check for installation of XU*8.0*44 - required for install
 W !!,"  Checking for installation of patch XU*8.0*44 ..."
 S PATCHED=$$PATCH^XPDUTL("XU*8.0*44")
 I ('PATCHED) D
 .W !!,"    *** Required element missing ***",!
 .W !,"    Installation of Veteran ID Card requires that Kernel patch"
 .W !,"    XU*8.0*44 be installed.  Install will be aborted at end of"
 .W !,"    environment check."
 .W !
 .S XPDABORT=2
 ;
 ; -- Check for installation of HL*1.6*8 - required for install
 W !!,"  Checking for installation of patch HL*1.6*8 ..."
 S PATCHED=$$PATCH^XPDUTL("HL*1.6*8")
 I ('PATCHED) D
 .W !!,"    *** Required element missing ***",!
 .W !,"    Installation of Veteran ID Card requires that HL7 patch"
 .W !,"    HL*1.6*8 be installed.  Install will be aborted at end of"
 .W !,"    environment check."
 .W !
 .S XPDABORT=2
 ;
 ; -- End of environment check
 W !!!,">>> Environment check completed"
 ; -- Write abort message (if appropriate)
 I (+$G(XPDABORT)) D
 .W !!,"*** Element(s) critical to installation of Veteran ID Card are missing"
 .W !,"*** Installation will be aborted"
 .W !
 ; -- Write A-OK message (if appropriate)
 W:('$G(XPDABORT)) !!,"Installation will proceed as planned",!!
 ; -- Done
 Q
