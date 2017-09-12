PXRMP26I ;SLC/PKR - Inits for PXRM*2.0*26. ;05/07/2014
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 Q
 ;==========================================
CFINC(Y) ;List of computed findings to include in the build.
 N CFLIST,CFNAME
 S CFLIST("VA-ALLERGY")=""
 S CFLIST("VA-FILEMAN DATE")=""
 S CFLIST("VA-PROGRESS NOTE")=""
 S CFLIST("VA-REMINDER DEFINITION")=""
 ;S CFLIST("")=""
 S CFNAME=$P($G(^PXRMD(811.4,Y,0)),U)
 Q $S($D(CFLIST(CFNAME)):1,1:0)
 ;
 ;==========================================
CHECK(GLOB,DLGPTR) ; check for duplicates
 N INDEX,RETURN S INDEX=0,RESULT=1
 ;RESULT=1 ok to add, RESULT=-1 not ok to add
 F  S INDEX=$O(@GLOB@(INDEX)) Q:INDEX=""!(RESULT=-1)  D
 .S:DLGPTR=$P(@GLOB@(INDEX),U) RESULT=-1 ;if the pointer matches one of the prompts already stored, it's a duplicate, don't store it again.
 Q RESULT
 ;
 ;==================================================
CTAXBDES ;Copy taxonomy brief descriptions to the description field.
 N BDES,IEN,NAME
 D BMES^XPDUTL("Copying all taxonomy Brief Descriptions to Description.")
 S NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^PXD(811.2,"B",NAME,""))
 . S BDES=$P(^PXD(811.2,IEN,0),U,2)
 . D BMES^XPDUTL("Working on taxonomy "_NAME)
 . I BDES="" D MES^XPDUTL(" Brief description does not exist.") Q
 . I $D(^PXD(811.2,IEN,1)) D MES^XPDUTL(" Already copied.") Q
 . D MES^XPDUTL(" Brief description: "_BDES)
 . S ^PXD(811.2,IEN,1,0)="^^1^1^"_DT_"^^"
 . S ^PXD(811.2,IEN,1,1,0)=BDES
 Q
 ;
 ;==========================================
DELDD ;Delete the old data dictionaries.
 N DIU,TEXT
 D EN^DDIOL("Removing old data dictionaries.")
 S DIU(0)=""
 F DIU=811.2,801.41 D
 . S TEXT=" Deleting data dictionary for file # "_DIU
 . D EN^DDIOL(TEXT)
 . D EN^DIU2
 Q
 ;
 ;==========================================
DELOPT ;AGP ICD10: added code to remove options from menu.
 N RESULT
 ;Remove PXRM TAXONOMY DIALOG from PXRM DIALOG PARAMETERS also set the 
 ;PXRM TAXONOMY DIALOG to delete in the build file.
 S RESULT=$$DELETE^XPDMENU("PXRM DIALOG PARAMETERS","PXRM TAXONOMY DIALOG")
 Q
 ;
 ;===============================================
DEXXREFS ;Delete unused Exchange Installation History 'B' indexes.
 N MSG
 ;Component List
 D DELIX^DDMOD(811.8031,.01,1,"K","","MSG")
 ;Additional Details
 D DELIX^DDMOD(811.80315,.01,1,"K","","MSG")
 Q
 ;
 ;===============================================
INILT ;Initialize list templates
 ;THIS MAY NO LONGER BE NECESSARY, THIS NEEDS TO BE CONFIRMED
 ;N IEN,IND,LIST,TEMP0
 ;D LTL^PXRMP26I(.LIST)
 ;S IND=0
 ;IA #4123
 ;F  S IND=$O(LIST(IND)) Q:IND=""  D
 ;. S IEN=$O(^SD(409.61,"B",LIST(IND),"")) Q:IEN=""
 ;. S TEMP0=$G(^SD(409.61,IEN,0))
 ;. K ^SD(409.61,IEN)
 ;. S ^SD(409.61,IEN,0)=TEMP0
 Q
 ;
 ;==========================================
LTL(LIST) ;This is the list of list templates that being distributed
 ;in the patch.
 ;S LIST(1)="PXRM EX LIST COMPONENTS"
 ;S LIST(2)="PXRM EX REMINDER EXCHANGE"
 Q
 ;
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 D BUILDD^PXRMDIEV("PXRM*2.0*26")
 D DELOPT
 D TMGRRO^PXRMP26I
 D PRE^PXRMP26D
 D DELDD^PXRMP26I
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP26E")
 Q
 ;
 ;==========================================
POST ;Post-init
 D TMGRN^PXRMP26I
 D CTAXBDES^PXRMP26I
 D CPALL^PXRMTXCR
 D SETPVER^PXRMUTIL("2.0P26")
 D POST^PXRMP26D
 D DEXXREFS^PXRMP26I
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP26E")
 D RBLD20I^PXRMTAXD
 D RBPDS^PXRMP26I
 ;Check the Selected Codes Multiple and repair any that are corrupted.
 D CHECKALL^PXRMTXIC
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D BUILDE^PXRMDIEV("PXRM*2.0*26")
 ;If the indexes for files #45 and #9000011 are still rebuilding,
 ;disable reminder evaluation.
 I '$D(^PXRMINDX(45,"DATE BUILT")) D INDEXD^PXRMDIEV(45)
 I '$D(^PXRMINDX(9000011,"DATE BUILT")) D INDEXD^PXRMDIEV(9000011)
 ;Put the old taxonomy management and edit options out of order.
 D OUT^XPDMENU("PXRM TAXONOMY MANAGEMENT (OLD)","This option is obsolete.")
 D OUT^XPDMENU("PXRM TAXONOMY EDIT","This option is obsolete.")
 D OUT^XPDMENU("PXRMCS INACTIVE DIALOG CODES","This option is obsolete.")
 D SENDIM^PXRMP26I
 Q
 ;
 ;==========================================
RBPDS ;Rebuild the Patient Data Source index.
 N IEN,NAME,PDS
 D BMES^XPDUTL("Rebuilding Patient Data Source Index.")
 S NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^PXD(811.2,"B",NAME,""))
 . S PDS=$P(^PXD(811.2,IEN,0),U,4)
 . D MES^XPDUTL(" Taxonomy: "_NAME_"; IEN="_IEN_"; PDS="_PDS)
 . D SPDS^PXRMPDS(IEN,PDS)
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*26"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*26 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@DOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*26"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*26 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
 ;===============================================
TMGRN ;Replace the old taxonomy mangement option with the new one on the
 ;PXRM MANAGERS MENU.
 N RESULT
 S RESULT=$$DELETE^XPDMENU("PXRM MANAGERS MENU","PXRM TAXONOMY MANAGEMENT (OLD)")
 S RESULT=$$ADD^XPDMENU("PXRM MANAGERS MENU","PXRM TAXONOMY MANAGEMENT","TXM",20)
 Q
 ;
 ;===============================================
TMGRRO ;Handle the old PXRM TAXONOMY MANAGEMENT option. Do not delete it until
 ;the cleanup patch, rename it for now. If the rename has already been
 ;done, don't do it again.
 I +$$LKOPT^XPDMENU("PXRM TAXONOMY MANAGEMENT (OLD)")>0 Q
 D BMES^XPDUTL("Setting up taxonomy management option.")
 D RENAME^XPDMENU("PXRM TAXONOMY MANAGEMENT","PXRM TAXONOMY MANAGEMENT (OLD)")
 Q
 ;
