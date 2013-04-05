MDPOST04 ; HOIFO/DP - Post Init ; 2/18/04  11:39
 ;;1.0;CLINICAL PROCEDURES;**4**;Apr 01, 2004;Build 3
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
 S MDCLIENT="1.0.4.0" D
 .D SETPAR("MD VERSION CHK","CPUSER.EXE:"_MDCLIENT,1)
 .D SETPAR("MD VERSION CHK","CPMANAGER.EXE:"_MDCLIENT,1)
 .D SETPAR("MD CRC VALUES","CPUSER.EXE:"_MDCLIENT,"9823D716")
 .D SETPAR("MD CRC VALUES","CPMANAGER.EXE:"_MDCLIENT,"E3117AF8")
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
 ;
