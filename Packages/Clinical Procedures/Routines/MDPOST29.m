MDPOST29 ;HOIFO/NCA - Post Init ;2/7/07  16:15
 ;;1.0;CLINICAL PROCEDURES;**29**;Apr 01, 2004;Build 22
 ; Integration Agreements:
 ; IA# 2263 [Supported] XPAR Utilities
 ;
EN       ; [Procedure] Setup preliminary parameters
 ; This submodule is called during the KIDS installation
 ; process.
 ;
 ; New private variables
 N MDK,MDKGUI,MDKLST
 ; Set current client version
 S MDKGUI="1.0.29.22"
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.MDKLST,"SYS","MDK GUI VERSION")
 F MDK=0:0 S MDK=$O(MDKLST(MDK)) Q:'MDK  D
 .D EN^XPAR("SYS","MDK GUI VERSION",$P(MDKLST(MDK),"^",1),0)
 ; Add and/or activate current client versions
 D EN^XPAR("SYS","MDK GUI VERSION","HEMODIALYSIS.EXE:"_MDKGUI,1)
 Q
