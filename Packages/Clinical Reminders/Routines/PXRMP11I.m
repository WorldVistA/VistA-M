PXRMP11I ; SLC/PKR - Inits for PXRM*2.0*11 ;09/15/2008
 ;;2.0;CLINICAL REMINDERS;**11**;Feb 04, 2005;Build 39
 Q
 ;====================================================
CFINC(Y) ;List of computed findings to include in the build.
 N CFLIST,CFNAME
 S CFLIST("VA-AGENT ORANGE EXPOSURE")=""
 S CFLIST("VA-COMBAT SERVICE")=""
 S CFLIST("VA-COMBAT VET ELIGIBILITY")=""
 S CFLIST("VA-OEF SERVICE")=""
 S CFLIST("VA-OIF SERVICE")=""
 S CFLIST("VA-LAST SERVICE SEPARATION DATE")=""
 S CFLIST("VA-POW")=""
 S CFLIST("VA-PURPLE HEART")=""
 S CFLIST("VA-SERVICE BRANCH")=""
 S CFLIST("VA-UNKNOWN OEF/OIF SERVICE")=""
 S CFLIST("VA-VETERAN")=""
 S CFNAME=$P(^PXRMD(811.4,Y,0),U,1)
 Q $S($D(CFLIST(CFNAME)):1,1:0)
 ;
 ;====================================================
DELDD ;Delete the old data dictionaries.
 N DIU,TEXT
 D EN^DDIOL("Removing old data dictionaries.")
 S DIU(0)=""
 F DIU=810.9 D
 . S TEXT=" Deleting data dictionary for file # "_DIU
 . D EN^DDIOL(TEXT)
 . D EN^DIU2
 Q
 ;
 ;====================================================
DRADCF ;Delete the radiation exposure computed finding entry from
 ;test sites.
 N DA,DIK
 S DA=+$O(PXD(811.4,"B","VA-RADIATION EXPOSURE",""))
 I DA=0 Q
 S DIK="^PXD(811.4,"
 D ^DIK
 Q
 ;
 ;====================================================
DTOITEMS ;Delete the transport only items.
 N IEN,TEXT
 S IEN=+$O(^PXD(811.9,"B","PATCH 11 ITEMS",""))
 I IEN>0 D
 . S TEXT="Removing PATCH 11 ITEMS transport reminder."
 . D MES^XPDUTL(.TEXT)
 . D DELETE^PXRMEXFI(811.9,IEN)
 S IEN=+$O(^PXRMD(801.41,"B","PATCH 11 DIALOG",""))
 I IEN>0 D
 . S TEXT="Removing PATCH 11 DIALOG transport dialog."
 . D MES^XPDUTL(.TEXT)
 . D DELETE^PXRMEXFI(801.41,IEN)
 Q
 ;
 ;====================================================
FFFIX ;Rebuild all function finding internal data structures to correct
 ;possible pointer errors.
 N DA,IEN,X
 D BMES^XPDUTL("Rebuilding Function Finding internal data structures.")
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . I '$D(^PXD(811.9,IEN,25)) Q
 . S DA(1)=IEN,DA=0
 . F  S DA=+$O(^PXD(811.9,IEN,25,DA)) Q:DA=0  D
 .. S X=$G(^PXD(811.9,IEN,25,DA,3))
 .. D FFKILL^PXRMFFDB(X,.DA)
 .. D FFBUILD^PXRMFFDB(X,.DA)
 Q
 ;
 ;====================================================
INILOCS ;Initialize the new field EXCL LOCS WITH NO CREDIT STOP.
 N IND,JND
 S IND=0
 F  S IND=+$O(^PXRMD(810.9,IND)) Q:IND=0  D
 . S JND=0
 . F  S JND=+$O(^PXRMD(810.9,IND,40.7,JND)) Q:JND=0  S ^PXRMD(810.9,IND,40.7,JND,3)=""
 Q
 ;
 ;====================================================
PRE ;These are the pre-installation actions
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 ;Delete existing exchange file entries.
 D DELEXI^PXRMP11E
 ;Delete the old DDs.
 D DELDD
 Q
 ;
 ;====================================================
POST ;These are the post-installation actions
 D FFFIX^PXRMP11I
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SMEXINS^PXRMP11E
 D DTOITEMS
 D DRADCF
 D INILOCS
 D UPDDIAL
 Q
 ;
 ;====================================================
UPDDIAL ;Update Element VA-MH PCLM with the correct dialog text
 N DIEN
 S DIEN=$O(^PXRMD(801.41,"B","VA-MH PCLM","")) Q:DIEN'>0
 S ^PXRMD(801.41,DIEN,25,1,0)="PCL-M"
 Q
 ;
