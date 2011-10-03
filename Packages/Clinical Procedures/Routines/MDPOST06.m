MDPOST06 ; HOIFO/DP - Post Init ;2/7/07  16:15
 ;;1.0;CLINICAL PROCEDURES;**6**;Apr 01, 2004;Build 102
 ; Integration Agreements:
 ; IA# 2263 [Supported] XPAR Utilities
 ; IA# 10141 [Supported] Calls to XPDUTL
 ;
EN ; [Procedure] Setup preliminary parameters
 ; This submodule is called during the KIDS installation
 ; process.
 ;
 ; Variables:
 ;  DIK: [Private] Fileman delete variable
 ;  MDCLIENT: [Private] Current client version (#.#.#.#)
 ;  MDFILE: [Private] Scratch
 ;  MDRET: [Private] Scratch
 ;  MDX: [Private] Scratch
 ;
 ; New private variables
 NEW DIK,MDCLIENT,MDFILE,MDRET,MDX
 W $$MSG("Setting compatible client versions")
 S MDCLIENT="1.0.6.4" D
 .D SETPAR("MD VERSION CHK","CPGATEWAY.EXE:"_MDCLIENT,1)
 .D SETPAR("MD VERSION CHK","CPMANAGER.EXE:"_MDCLIENT,1)
 .D SETPAR("MD CRC VALUES","CPGATEWAY.EXE:"_MDCLIENT,"E0E1BB26")
 .D SETPAR("MD CRC VALUES","CPMANAGER.EXE:"_MDCLIENT,"9ABFE692")
 D ^MDPOST6A
 N MDK,MDKGUI,MDKLST
 ; Set current client version
 S MDKGUI="1.0.6.319"
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.MDKLST,"SYS","MDK GUI VERSION")
 F MDK=0:0 S MDK=$O(MDKLST(MDK)) Q:'MDK  D
 .D EN^XPAR("SYS","MDK GUI VERSION",$P(MDKLST(MDK),"^",1),0)
 ; Add and/or activate current client versions
 D EN^XPAR("SYS","MDK GUI VERSION","HEMODIALYSIS.EXE:"_MDKGUI,1)
 Q
 ;
MSG(TEXT) ; [Procedure] Display message to user
 ; Input parameters
 ;  1. TEXT [Literal/Required] Text to display to the user
 ;
 D MES^XPDUTL(" MDPOST-"_TEXT_"...")
 D MES^XPDUTL("")
 Q ""
 ;
SETPAR(PAR,INS,VAL) ; [Procedure] Set value into XPAR parameter
 ; Input parameters
 ;  1. PAR [Literal/Required] Parameter
 ;  2. INS [Literal/Required] Instance
 ;  3. VAL [Literal/Required] New value
 ;
 D EN^XPAR("SYS",PAR,INS,VAL)
 Q
