ORY277 ;SLCOIFO - Post-init for patch OR*3*277 ;08/01/2007
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**277**;Dec 17, 1997;Build 13
 ;
PRE ; initiate pre-init processes
 ;
 Q
 ;
POST ; initiate post-init processes
 ;
 D VITREG ;register Vitals RPC
 I +$$PATCH^XPDUTL("MAG*3.0*7") D MAGREG1
 I +$$PATCH^XPDUTL("MAG*3.0*37") D MAGREG2
 D MAIL
 Q
 ;
MAIL ; send bulletin of installation time
 N DA,DIE,DR,VERSNUM,NAME,OPTIEN
 S DA=$O(^DIC(19,"B","OR CPRS GUI CHART","")) Q:DA'>0
 ;Change to versnum to store the new version number
 S VERSNUM="CPRSChart version 1.0.26.76"
 S DIE="^DIC(19,",DR="1////^S X=VERSNUM" D ^DIE
 ;
 N COUNT,DIFROM,I,START,TEXT,XMDUZ,XMSUB,XMTEXT,XMY
 S COUNT=0,XMDUZ="CPRS PACKAGE",XMTEXT="TEXT("
 S XMSUB="Version "_$P($T(VERSION),";;",2)_" Installed"
 F I="G.CPRS GUI INSTALL@ISC-SLC.VA.GOV",DUZ S XMY(I)=""
 ;
 S X=$P($T(VERSION),";;",2)
 D LINE("Version "_X_" has been installed.")
 D LINE(" ")
 D LINE("Install complete:  "_$$FMTE^XLFDT($$NOW^XLFDT()))
 ;
 D ^XMD
 Q
 ;
VITREG ; Register Vitals RPC
 D ADDRPCS^GMV3PST ;call tag from vitals patch post init to register
 Q
 ;
MAGREG1 ; Register Imaging RPC if MAG*3.0*7 installed (DBIA 4526)
 D INSERT("OR CPRS GUI CHART","MAG4 REMOTE IMPORT")
 Q
 ;
MAGREG2 ; Register Imaging RPCS if MAG*3.0*37 installed (DBIA 4528/4530)
 D INSERT("OR CPRS GUI CHART","MAG IMPORT CHECK STATUS")
 D INSERT("OR CPRS GUI CHART","MAG IMPORT CLEAR STATUS")
 Q
 ;
LINE(DATA) ; set text into array
 S COUNT=COUNT+1
 S TEXT(COUNT)=DATA
 Q
 ;
INSERT(OPTION,RPC) ; Call FM Updater with each RPC
 ; Input  -- OPTION   Option file (#19) Name field (#.01)
 ;           RPC      RPC sub-file (#19.05) RPC field (#.01)
 ; Output -- None
 N FDA,FDAIEN,ERR,DIERR
 S FDA(19,"?1,",.01)=OPTION
 S FDA(19.05,"?+2,?1,",.01)=RPC
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 Q
 ;
VERSION ;;26.76
