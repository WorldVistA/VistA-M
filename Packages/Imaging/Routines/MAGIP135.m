MAGIP135 ;PRE/Post init routine to queue site activity at install. ; 21 May 2013 11:42 AM
 ;;3.0;IMAGING;**135**;Mar 19, 2002;Build 5238;Jul 17, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
PRE ;
 N FILE,FIELD,CROSSREF
 D BMES^XPDUTL("Removing 'AC' trigger for Field 124: "_$$FMTE^XLFDT($$NOW^XLFDT))
 S FILE="2006.1",FIELD="124",CROSSREF="1"
 D DELIX^DDMOD(FILE,FIELD,CROSSREF,"","","")
 D BMES^XPDUTL("Removing 'AD' trigger for Field 125: "_$$FMTE^XLFDT($$NOW^XLFDT))
 S FILE="2006.1",FIELD="125",CROSSREF="1"
 D DELIX^DDMOD(FILE,FIELD,CROSSREF,"","","")
 ; Remove data dictionary definition so that the new definition installs cleanly
 N DIK,DA,DIU
 ; Output Transform for MAG ->  Tier 1 , WORM -> Tier 2 ; CR 1232
 S DIK="^DD(2005.2,",DA=6,DA(1)=2005.2 D ^DIK
 ; Tier 2 storage reserve CR 1232
 S DIK="^DD(2006.1,",DA=11.5,DA(1)=2006.1 D ^DIK
 ; Image Never Existed Status added to field 113 in 2005
 S DIK="^DD(2006.1,",DA=113,DA(1)=2005 D ^DIK
 ; Image Never Existed Status added to field 113 in 2005.1
 S DIK="^DD(2006.1,",DA=113,DA(1)=2005.1 D ^DIK
 ; Remove options so new ones install cleanly
 D RMOPT("MAG JB OFFLINE")
 ; Remove option(s) so new one(s) install cleanly
 D RMRPC("MAGQ LOGV")
 Q
RMOPT(NAME) ; Removing an OPTION from the OPTION File (#19)
 N OPT
 S OPT=$$FIND1^DIC(19,"","X",NAME,"","","")
 D CLEAN^DILF
 Q:'OPT
 I NAME="MAG JB OFFLINE" D MAGSYS(NAME)
 S DA=OPT,DIK="^DIC(19,"
 D ^DIK
 K DA,DIK
 Q
MAGSYS(NAME) ;
 N MENU,ITEM,DA,DIK
 Q:NAME=""
 S MENU=+$$FIND1^DIC(19,"","X","MAG SYS MENU") Q:'+MENU
 S ITEM=$$FIND1^DIC(19.01,","_MENU_",","B",NAME) Q:'+ITEM
 S DA=ITEM,DA(1)=MENU,DIK="^DIC(19,"_DA(1)_",10," D ^DIK K DA,DIK
 Q
RMRPC(NAME) ; Removing an RPC in order to revise
 N MW,RPC,MWE,DIERR,DA,DIK
 S MW=$$FIND1^DIC(19,"","X","MAG WINDOWS","","","")
 D CLEAN^DILF
 S RPC=$$FIND1^DIC(8994,"","X",NAME,"","","")
 D CLEAN^DILF
 Q:'RPC
 I MW D
 . S MWE=$$FIND1^DIC(19.05,","_MW_",","X",NAME,"","","")
 . D CLEAN^DILF
 . Q:'MWE
 . S DA=MWE,DA(1)=MW,DIK="^DIC(19,"_DA(1)_",""RPC"","
 . D ^DIK
 . K DA,DIK
 . Q
 S DA=RPC,DIK="^XWB(8994,"
 D ^DIK
 K DA,DIK
 Q
POST ;
 D BMES^XPDUTL("Set default Tier 2 Reserve to 5 if not defined."_$$FMTE^XLFDT($$NOW^XLFDT))
 N PL,OPT
 S PL=0
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . Q:$P($G(^MAG(2006.1,PL,1)),U,9)?1N.N  ; Do not re-configure if a number value is set
 . S $P(^MAG(2006.1,PL,1),U,9)=5
 . Q
 D BMES^XPDUTL("Updating the MAG SYS MENU. "_$$FMTE^XLFDT($$NOW^XLFDT))
 S OPT=$$ADD^XPDMENU("MAG SYS MENU","MAG JB OFFLINE")
 D BMES^XPDUTL("Updating MAG WINDOWS. "_$$FMTE^XLFDT($$NOW^XLFDT))
 D ADDRPC^MAGQBUT4("MAGQ LOGV","MAG WINDOWS")
 S OPT=$$ADD^XPDMENU("MAG SYS MENU","MAGQ LOGV")
 D BMES^XPDUTL("Adding 'Image Never Existed' to the MAG REASON File "_$$FMTE^XLFDT($$NOW^XLFDT))
 D ADDREAS  ;Adds an entry to the MAG REASON File
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;+++++ Adds an entry to the MAG REASON File (#2005.88)
ADDREAS ; Add new entry "Image Never Existed"
 ; NAME - value for field (#.01) MAG REASON File (#2005.88)
 N MAGFDA,MAGERR,MAGWP,REASON,MAGCODE
 S REASON="Image Never Existed"
 ; Quit if already exist.
 I $D(^MAG(2005.88,"B",REASON)) Q
 S MAGWP(1)="The Image File Never Existed. Copy to Server Failed." ; 
 S MAGFDA(2005.88,"+1,",.01)=REASON
 S MAGFDA(2005.88,"+1,",.02)="S" ; This is a Status Reason 
 S MAGFDA(2005.88,"+1,",1)="MAGWP"
 S MAGCODE=$P(^MAG(2005.88,0),"^",3)+1
 S MAGFDA(2005.88,"+1,",.04)=MAGCODE
 D UPDATE^DIE("","MAGFDA","","MAGERR")
 I $D(MAGERR) D
 . D BMES^MAGKIDS("Error creating new MAG REASON entry")
 . Q
 Q
