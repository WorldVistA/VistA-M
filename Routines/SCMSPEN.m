SCMSPEN ;ALB/JRP - AMB CARE ENVIRONMENT CHECKER;04-JUN-96
 ;;5.3;Scheduling;**44**;AUG 13, 1993
CHKENV ;Main entry point for environment checker
 ;Input  : All variables set by KIDS
 ;Output : Variables required by KIDS to denote success or failure
 ;         of environment check (XPDQUIT and XPDABORT)
 ;
 ;Declare variables
 N VERSION,PATCHED,NODE,PTR,NAME
 W !!,">>> Beginning environment check",!!
 ;Check for installation of PCE version 1.0 - required for install
 W !!,"  Checking for installation of PCE version 1.0 ..."
 S VERSION=$$VERSION^XPDUTL("PX")
 I ((+VERSION)<1) D
 .W !!,"    *** Required element missing ***",!
 .W !,"    Installation of Ambulatory Care requires that PCE version"
 .W !,"    1.0 be installed - you have version ",VERSION," installed."
 .W !,"    Installation will be aborted at end of environment check."
 .W !
 .S XPDABORT=2
 ;Check for installation of HL7 version 1.6 - required for install
 W !!,"  Checking for installation of HL7 version 1.6 ..."
 S VERSION=+$$VERSION^XPDUTL("HL")
 I (VERSION<1.6) D
 .W !!,"    *** Required element missing ***",!
 .W !,"    Installation of Ambulatory Care requires that HL7 version"
 .W !,"    1.6 be installed - you have version ",VERSION," installed."
 .W !,"    Installation will be aborted at end of environment check."
 .W !
 .S XPDABORT=2
 ;Check for installation of XU*8.0*27 - required for install
 W !!,"  Checking for installation of patch XU*8.0*27 ..."
 S PATCHED=$$PATCH^XPDUTL("XU*8.0*27")
 I ('PATCHED) D
 .W !!,"    *** Required element missing ***",!
 .W !,"    Installation of Ambulatory Care requires that Kernel patch"
 .W !,"    XU*8.0*27 be installed.  Install will be aborted at end of"
 .W !,"    environment check."
 .W !
 .S XPDABORT=2
 ;Check for installation of HL*1.6*8 - required for install
 W !!,"  Checking for installation of patch HL*1.6*8 ..."
 S PATCHED=$$PATCH^XPDUTL("HL*1.6*8")
 I ('PATCHED) D
 .W !!,"    *** Required element missing ***",!
 .W !,"    Installation of Ambulatory Care requires that HL7 patch"
 .W !,"    HL*1.6*8 be installed.  Install will be aborted at end of"
 .W !,"    environment check."
 .W !
 .S XPDABORT=2
 ;Check for installation of IB*2.0*60 - required for install
 W !!,"  Checking for installation of patch IB*2.0*60 ..."
 S PATCHED=$$PATCH^XPDUTL("IB*2.0*60")
 I ('PATCHED) D
 .W !!,"    *** Required element missing ***",!
 .W !,"    Installation of Ambulatory Care requires that Integrated"
 .W !,"    Billing patch IB*2.O*60 be installed.  Install will be aborted"
 .W !,"    at end of environment check."
 .W !
 .S XPDABORT=2
 ;Check for existance of Q-ACS.MED.VA.GOV domain - required for install
 W !!,"  Checking for existance of Q-ACS.MED.VA.GOV domain ..."
 I ('$O(^DIC(4.2,"B","Q-ACS.MED.VA.GOV",0))) D
 .W !!,"    *** Required element missing ***",!
 .W !,"    Installation of Ambulatory Care requires that the domain"
 .W !,"    Q-ACS.MED.VA.GOV be defined.  Install will be aborted at end"
 .W !,"    of environment check."
 .W !
 .S XPDABORT=2
 ;Check for installation of PCMM - not required for install but
 ; causes a problem if installed after Amb Care
 W !!,"  Checking for installation of patch SD*5.3*41 (PCMM) ..."
 S PATCHED=$$PATCH^XPDUTL("SD*5.3*41")
 I ('PATCHED) D
 .W !!,"    *** Warning ***",!
 .W !,"    Primary Care Management Module (SD*5.3*41) has not been"
 .W !,"    installed.  After installing PCMM, call the routine SCMSP"
 .W !,"    at the line tag SDM (i.e. D SDM^SCMSP) in order to install"
 .W !,"    a version of routine SDM with the ACRP & PCMM changes"
 .W !,"    applied to it."
 .W !
 ;Check for installation of RA*4.5*4 - not required for install but
 ; loose workload credit if not installed
 W !!,"  Checking for installation of patch RA*4.5*4 ..."
 S PATCHED=$$PATCH^XPDUTL("RA*4.5*4")
 I ('PATCHED) D
 .W !!,"    *** Warning ***",!
 .W !,"    Radiology patch RA*4.5*4 has not been installed.  This patch"
 .W !,"    must be installed in order for all workload credit to be"
 .W !,"    reported."
 .W !
 ;Check for installation of LR*5.2*127 - not required for install but
 ; loose workload credit if not installed
 W !!,"  Checking for installation of patch LR*5.2*127 ..."
 S PATCHED=$$PATCH^XPDUTL("LR*5.2*127")
 I ('PATCHED) D
 .W !!,"    *** Warning ***",!
 .W !,"    Lab patch LR*5.2*127 has not been installed.  This patch must"
 .W !,"    be installed in order for all workload credit to be reported."
 .W !
 ;Check for installation of SOW*3*42 - not required for install but
 ; loose ability to correctly transmit homeless indicator
 W !!,"  Checking for installation of patch SOW*3*42 ..."
 S PATCHED=$$PATCH^XPDUTL("SOW*3*42")
 I ('PATCHED) D
 .;Don't have it listed in patch history (pre KIDS patch) - check for
 .; existance of line tag used by VAFHLZPD
 .Q:($T(HOMELESS^SOWKHIRM)'="")
 .W !!,"    *** Warning ***",!
 .W !,"    Social Work patch SOW*3*42 has not been installed.  This"
 .W !,"    patch must be installed in order to correctly report whether"
 .W !,"    a patient is homeless or not."
 .W !
 ;Check for entry in OPC GENERATE MAIL GROUP field (#216) of the
 ; MAS PARAMETERS file (#43) - not required for install but is used
 ; during pre/post-init
 W !!,"  Checking MAS PARAMETER file for OPC mail group ..."
 ;Get node value is stored on
 S NODE=$G(^DG(43,1,"SCLR"))
 ;Get pointer
 S PTR=+$P(NODE,"^",16)
 ;Get name of Mail Group
 S NODE=$G(^XMB(3.8,PTR,0))
 S NAME=$P(NODE,"^",1)
 I (NAME="") D
 .W !!,"    *** Warning ***",!
 .W !,"    The OPC GENERATE MAIL GROUP field (#216) of the MAS PARAMETERS"
 .W !,"    file (#43) does not contain a valid mail group.  The mail group"
 .W !,"    stored in this field is attached to entries that will be created"
 .W !,"    in the HL APPLICATION file (#771) and BULLETIN file (#3.8)."
 .W !
 ;End of environment check
 W !!!,">>> Environment check completed"
 ;Write abort message (if appropriate)
 I (+$G(XPDABORT)) D
 .W !!,"*** Element(s) critical to installation of Ambulatory Care are missing"
 .W !,"*** Installation will be aborted"
 .W !
 ;Write A-OK message (if appropriate)
 W:('$G(XPDABORT)) !!,"Installation will proceed as planned",!!
 ;Done
 Q
