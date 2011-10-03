MDPOST ; HOIFO/DP - Post Init ;2/18/04  11:39
 ;;1.0;CLINICAL PROCEDURES;;Apr 01, 2004
 ; Integration Agreements:
 ; IA# 2263 [Supported] XPAR Utilities
 ; IA# 3006 [Supported] Calls to XMXAPIG
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
 D XPARDEL("MD VERSION CHK",1)
 D XPARDEL("MD CRC VALUES",1)
 S MDCLIENT="1.0.0.0" D
 .D SETPAR("MD VERSION CHK","CPUSER.EXE:"_MDCLIENT,1)
 .D SETPAR("MD VERSION CHK","CPMANAGER.EXE:"_MDCLIENT,1)
 .D SETPAR("MD VERSION CHK","CPGATEWAY.EXE:"_MDCLIENT,1)
 .D SETPAR("MD CRC VALUES","CPUSER.EXE:"_MDCLIENT,"9FCFC891")
 .D SETPAR("MD CRC VALUES","CPMANAGER.EXE:"_MDCLIENT,"85F451A6")
 .D SETPAR("MD CRC VALUES","CPGATEWAY.EXE:"_MDCLIENT,"411D7A05")
 ;
 W $$MSG("Applying latest set of valid file types")
 D GETLST^XPAR(.MDRET,"SYS","MD FILE EXTENSIONS")
 F MDX=0:0 S MDX=$O(MDRET(MDX)) Q:'MDX  D
 .D DEL^XPAR("SYS","MD FILE EXTENSIONS",$P(MDRET(MDX),"^",1))
 F MDX=1:1 S MDFILE=$P($T(FILEDAT+MDX),";;",2) Q:MDFILE="**END**"  D
 .D SETPAR("MD FILE EXTENSIONS",$P(MDFILE,U,1),$P(MDFILE,U,2))
 ;
 W $$MSG("Setting CP web link")
 D SETPAR("MD WEBLINK",1,$$URL())
 ;
 W $$MSG("Validating Mail Group 'MD DEVICE ERRORS' membership")
 D:'$$GOTLOCAL^XMXAPIG("MD DEVICE ERRORS")
 .D MES^XPDUTL("There are no local users in the mail group.")
 .D MES^XPDUTL("Adding '"_$$GET1^DIQ(200,DUZ_",",.01)_"'...")
 .D ADDMBRS^XMXAPIG(DUZ,"MD DEVICE ERRORS",DUZ)
 Q
 ;
INIT ; [Procedure] Build Procedure File
 D INITPF^MDPOST1
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
XPARDEL(MDPAR,VALUES) ; [Procedure] Remove a parameter for XPAR
 ; VALUES determines the mode of deletion.
 ; 0: Will delete *BOTH* the values and the parameter definition (DEFAULT)
 ; 1: Will only delete the values of the parameter
 ;
 ; Input parameters
 ;  1. MDPAR [Literal/Required] Name of the parameter definition
 ;  2. VALUES [Literal/] Values Only 0/1
 ;
 ; Variables:
 ;  DA: [Private] Fileman variable
 ;  DIK: [Private] Fileman variable
 ;  MDENT: [Private] Parameter entity
 ;
 ; New private variables
 NEW DA,DIK,MDENT
 S VALUES=$G(VALUES,0)
 K ^TMP("MDPOST",$J)
 D ENVAL^XPAR($NA(^TMP("MDPOST",$J)),MDPAR,"","",1)
 S MDENT=""  F  S MDENT=$O(^TMP("MDPOST",$J,MDENT)) Q:MDENT=""  D
 .D NDEL^XPAR(MDENT,MDPAR)
 K ^TMP("MDPOST",$J)
 Q:VALUES
 S DA=$$FIND1^DIC(8989.51,"","",MDPAR,"B") D:DA>0
 .S DIK="^XTV(8989.51," D ^DIK
 Q
 ;
URL() ; [Function] Return Clinical Procedures Homepage URL
 Q "vista.med.va.gov/ClinicalSpecialties/clinproc/"
 ;
FILEDAT ; [Data Module] Allowable file types
 ;;.txt^Text files
 ;;.rtf^Rich text files
 ;;.jpg^JPEG Images
 ;;.jpeg^JPEG Images
 ;;.bmp^Bitmap Images
 ;;.tiff^TIFF Graphics
 ;;.pdf^Portable Document Format
 ;;.html^Hypertext Markup Language files
 ;;**END**
