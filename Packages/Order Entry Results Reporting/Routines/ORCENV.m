ORCENV ;SLC/MLI - Environment check routine ; 18 March 97
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;
 ; This is an environment check routine to check for
 ; existence of all packages and patches required by
 ; CPRS.
 ;
EN ; check environment
 N ABORT,Y
 S ABORT=0
 S Y=$$VARIABLE() I Y S ABORT=1 G ENQ
 S Y=$$CMOPCHK() I Y S ABORT=1
 S Y=$$PATCHCHK() I Y S ABORT=1 G ENQ
ENQ I ABORT S XPDABORT=2 ; aborts all transport globals in distribution
 Q
 ;
 ;
VARIABLE() ; check for crucial variables
 N ABORT,I
 D BMES^XPDUTL("Checking for key variables...")
 S ABORT=0
 F I="DUZ","DT","DTIME" I '($D(@I)#10) D
 . S ABORT=1
 . D MES^XPDUTL("   Missing key variable "_I)
 I $G(DUZ(0))'="@" D
 . S ABORT=1
 . D MES^XPDUTL("   DUZ(0) must equal @ to install")
 I ABORT D MES^XPDUTL("   These variables must be set before installing.")
 I 'ABORT D MES^XPDUTL("   Key variables are defined properly.")
 Q ABORT
 ;
 ;
PATCHCHK() ; check for packages and patches
 N ABORT,CURRENT,I,J,NMSP,OPTIONAL,PACKAGE,PATCH,VERSION,VIRGIN,X
 S ABORT=0
 D BMES^XPDUTL("Checking status of packages and patches...")
 F I=1:1 S X=$P($T(LIST+I),";;",2) Q:X="QUIT"  D
 . N PATCHES,OK
 . S OK=1,PACKAGE=$P(X,"^",1),NMSP=$P(X,"^",2)
 . S VERSION=$P($P(X,"^",3),"*",1)
 . S VIRGIN=($P(X,"^",2)["*"),OPTIONAL=(X["OPTIONAL")
 . S PATCHES=$$NUMBERS($P(X,"^",4))
 . D BMES^XPDUTL("   Checking "_PACKAGE_" v"_VERSION_"...")
 . I VIRGIN,(+$$VERSION^XPDUTL(NMSP)=0) D  Q
 . . D MES^XPDUTL("      "_PACKAGE_" will be installed.")
 . S CURRENT=+$$VERSION^XPDUTL(NMSP)
 . I CURRENT<VERSION D  Q
 . . I 'CURRENT,OPTIONAL D  Q
 . . . D MES^XPDUTL("      optional "_PACKAGE_" is not on system...ok")
 . . S ABORT=1
 . . D MES^XPDUTL("      "_PACKAGE_" is not up to version "_VERSION)
 . I CURRENT>VERSION D  Q
 . . D MES^XPDUTL("      "_PACKAGE_" is up to version "_CURRENT_"...OK")
 . I PATCHES D  Q
 . . F J=1:1 S X=$P(PATCHES,",",J) Q:X=""  D
 . . . S PATCH=NMSP_"*"_VERSION_"*"_X
 . . . I $$PATCH^XPDUTL(PATCH) Q
 . . . S ABORT=1,OK=0
 . . . D MES^XPDUTL("      Patch "_PATCH_" has not been installed")
 . . I OK D MES^XPDUTL("      "_PACKAGE_" v"_VERSION_" is up to date")
 . D MES^XPDUTL("      "_PACKAGE_" v"_VERSION_" is up to date")
 Q ABORT
 ;
 ;
LIST ; list of packages and patches to check
 ;;Adverse Reaction Tracking^GMRA^4.0^4,6
 ;;Consult/Request Tracking^GMRC^2.5*^14
 ;;CMOP^PSX^2.0*^3^^^^OPTIONAL
 ;;Dietetics^FH^5.0^
 ;;Vitals^GMRV^3.0^3-5
 ;;Health Level Seven^HL^1.6^8-9,17-18,21
 ;;Health Summary^GMTS^2.7^3,7-9,12-13
 ;;Kernel^XU^8.0^49,59
 ;;Laboratory^LR^5.2^121^
 ;;OE/RR^OR^2.5*^46,49
 ;;Patient Care Encounter^PX^1.0^1-5,7-9,15
 ;;Outpatient Pharmacy^PSO^6*
 ;;Inpatient Pharmacy^PSJ^4.5*^42
 ;;Radiology^RA^4.5^3-6,8-11
 ;;Registration^DG^5.3^57,73,77-80,82,84-85,87-90,92-101,103-105,107,109-112,121,124
 ;;Scheduling (including PCMM)^SD^5.3^27,39,41,42,44-49,53-61,63-65,67-75,78,79,84-88,93
 ;;RPC Broker^XWB^1.1
 ;;Text Integration Utility^TIU^1.0^1,3,4,7
 ;;VA FileMan^DI^21.0^8,12,15,18-20,24-25,27,31,33,36
 ;;Visit Tracking^VSIT^2.0^1
 ;;QUIT
 ;
 ;
NUMBERS(STRING) ; get list of numbers from string by parsing
 N I,J,LIST,X
 S LIST=""
 F I=1:1 S X=$P(STRING,",",I) Q:X=""  D
 . I X["-" F J=$P(X,"-",1):1:$P(X,"-",2) S LIST=LIST_J_","
 . E  S LIST=LIST_X_","
 Q LIST
 ;
 ;
CMOPCHK() ; check to see if CMOP processing is inactivated
 N Y
 S Y=$D(^PSX(550,"C"))
 D BMES^XPDUTL("Checking for active CMOP transmissions...")
 I Y D
 . D MES^XPDUTL("   CMOP Currently Activated!!!")
 . D MES^XPDUTL("   You must inactivate CMOP before installing CPRS!")
 E  D
 . D MES^XPDUTL("   CMOP is inactivated...ok to continue")
 Q Y
