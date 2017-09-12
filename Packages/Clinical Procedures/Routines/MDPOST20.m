MDPOST20 ; HOIFO/NCA - Post Init ;7/1/10  10:45
 ;;1.0;CLINICAL PROCEDURES;**20**;Apr 01, 2004;Build 9
 ; Integration Agreements:
 ; IA# 2263 [Supported] XPAR parameter calls.
 ; IA# 10141 [Supported] Calls to XPDUTL
 ;
EN ; [Procedure] Setup MD DEVICE SURVEY TRANSMISSION parameter
 ; This submodule is called during the KIDS Post installation
 ; process.
 ;
 ; New private variables
 N MDOPT,MDAPU
 S MDAPU=$G(XPDQUES("POS1"))
 D EN^XPAR("SYS","MD DEVICE SURVEY TRANSMISSION",1,MDAPU)
 I +MDAPU D COL^MDDEVCL D BMES^XPDUTL("Collecting device information for initial transmission...")
 ;
EN1 ; [Procedure] Setup preliminary parameters
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
 N DIK,MDCLIENT,MDFILE,MDRET,MDX
 W $$MSG("Setting compatible client versions")
 S MDCLIENT="1.0.20.4" D
 .D SETPAR("MD VERSION CHK","CPGATEWAY.EXE:"_MDCLIENT,1)
 .D SETPAR("MD CRC VALUES","CPGATEWAY.EXE:"_MDCLIENT,"7C3BE136")
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
