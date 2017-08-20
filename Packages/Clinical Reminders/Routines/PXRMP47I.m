PXRMP47I ;SLC/PKR - Inits for PXRM*2.0*47. ;05/18/2016
 ;;2.0;CLINICAL REMINDERS;**47**;Feb 04, 2005;Build 289
 Q
 ;==========================================
CFINC(Y) ;List of computed findings to include in the build.
 N CFLIST,CFNAME
 S CFLIST("VA-AGE BIRTH SEX LIST")=""
 S CFLIST("VA-BIRTH DATE BIRTH SEX LIST")=""
 S CFLIST("VA-FILEMAN DATE")=""
 S CFNAME=$P($G(^PXRMD(811.4,Y,0)),U,1)
 Q $S($D(CFLIST(CFNAME)):1,1:0)
 ;
 ;==========================================
DELDEFAD ;Delete file #811.9 field #.01 "AD" cross-reference.
 N MSG
 D DELIX^DDMOD(811.9,.01,2,"","","MSG")
 Q
 ;
 ;==========================================
DELTAXDD ;Delete the taxonomy data dictionary.
 N DIU
 S DIU=811.2,DIU(0)="ET"
 D EN^DIU2
 Q
 ;
 ;==========================================
DELETAX ;Delete the expanded taxonomy file.
 N DIU
 S DIU=811.3,DIU(0)="DT"
 D EN^DIU2
 Q
 ;
 ;==========================================
DELVSDD ;Delete the value set files.
 N DIU,FILENUM
 F FILENUM=802.1,802.2,802.3 D
 . S DIU=FILENUM,DIU(0)="DT"
 . D EN^DIU2
 Q
 ;
 ;==========================================
DELETEP() ;
 N DA,DIK
 S DIK="^PXRMD(801.45,",DA=$O(^PXRMD(801.45,"B","SNOMED","")) I +$G(DA)'>0 Q
 D ^DIK
 Q
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTIONS^PXRMUTIL("DISABLE","Install of PXRM*2.0*47")
 D PROTCOLS^PXRMUTIL("DISABLE","Install of PXRM*2.0*47")
 D DELTAXDD^PXRMP47I
 D DELVSDD^PXRMP47I
 Q
 ;
 ;==========================================
POST ;Post-init
 D DELETEP
 D RMOBSFD^PXRMP47I
 D RBLD20IA^PXRMTAXD
 D VSINS^PXRMP47I
 D UCDIA^PXRMP47I
 D UCFREQ^PXRMP47I
 D DELDEFAD^PXRMP47I
 D DELETAX^PXRMP47I
 ;Enable options and protocols
 D OPTIONS^PXRMUTIL("ENABLE","Install of PXRM*2.0*47")
 D PROTCOLS^PXRMUTIL("ENABLE","Install of PXRM*2.0*47")
 D SENDIM^PXRMMSG("PXRM*2.0*47")
 Q
 ;
 ;==========================================
RMOBSFD ;Remove obsolete field data.
 N IEN,NAME
 D BMES^XPDUTL("Removing obsolete field data")
 S NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:NAME=""  D
 . D MES^XPDUTL(" Working on taxonomy "_NAME)
 . S IEN=""
 . F  S IEN=$O(^PXD(811.2,"B",NAME,IEN)) Q:IEN=""  D
 ..;Brief Description
 .. S $P(^PXD(811.2,IEN,0),U,2)=""
 ..;Dialog Header Text
 .. S $P(^PXD(811.2,IEN,0),U,3)=""
 ..;ICD9 Range of Codes
 .. K ^PXD(811.2,IEN,80)
 ..;ICD0 Range of Codes
 .. K ^PXD(811.2,IEN,80.1)
 ..;CPT Range of Codes
 .. K ^PXD(811.2,IEN,81)
 ..;Selectable Codes
 .. K ^PXD(811.2,IEN,"SDX")
 ..;Selectable Procedures
 .. K ^PXD(811.2,IEN,"SPR")
 ..;Dialog Parameters:
 ..;(#3106) GENERATE DIALOG DX PARAMETER [1S] ^ (#3107) CURRENT VISIT
 ..;DX DIALOG HDR [2F] ^ (#3108) HISTORICAL VISIT DX DIALOG HDR [3F] ^
 .. K ^PXD(811.2,IEN,"SDZ")
 ..;(#3110) GENERATE DIALOG PR PARAMETER [1S] ^
 ..;(#3111) CURRENT VISIT PR DIALOG HDR [2F] ^ (#3112) HISTORICAL 
 ..;VISIT PR DIALOG HDR [3F]
 .. K ^PXD(811.2,IEN,"SPZ")
 Q
 ;
 ;==========================================
UCDIA ;Change the DO IN ADVANCE TIME FRAME input transform so it will always
 ;be stored as upper case and make sure all existing entries are
 ;upper case.
 N DIA,FDA,FREQ,IEN,IENS,IND,MSG,TEXT
 D BMES^XPDUTL("Making sure all DO IN ADVANCE TIME FRAMEs are uppercase.")
 S $P(^DD(811.9,1.3,0),U,6)="PXRMINTR(.X) X"
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . S DIA=$P(^PXD(811.9,IEN,0),U,4)
 . I DIA="" Q
 . I DIA?1.N1L D
 .. S TEXT(1)=""
 .. S TEXT(2)="Found lower case DO IN ADVANCE TIME FRAME:"
 .. S TEXT(3)=" IEN="_IEN_" DO IN ADVANCE="_DIA
 .. S TEXT(4)=" Changing it to upper case."
 .. D MES^XPDUTL(.TEXT)
 .. S DIA=$$UP^XLFSTR(DIA)
 .. S $P(^PXD(811.9,IEN,0),U,4)=DIA
 Q
 ;
 ;==========================================
UCFREQ ;Change the reminder frequency input transform so they will always
 ;be stored as upper case and make sure all existing frequencies are
 ;upper case.
 N FDA,FREQ,IEN,IENS,IND,MSG,TEXT
 D BMES^XPDUTL("Making sure all reminder frequencies are uppercase.")
 ;Baseline
 S $P(^DD(811.97,.01,0),U,6)="PXRMINTR(.X) X"
 ;Finding modifier
 S $P(^DD(811.902,3,0),U,6)="PXRMINTR(.X) X"
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 .;Baseline
 . S IND=0
 . F  S IND=+$O(^PXD(811.9,IEN,7,IND)) Q:IND=0  D
 .. S FREQ=$P(^PXD(811.9,IEN,7,IND,0),U,1)
 .. I FREQ?1.N1L D
 ... S TEXT(1)=""
 ... S TEXT(2)="Found lower case baseline frequency:"
 ... S TEXT(3)=" IEN="_IEN_" IND="_IND_" Frequency="_FREQ
 ... S TEXT(4)=" Changing it to upper case."
 ... D MES^XPDUTL(.TEXT)
 ... S FREQ=$$UP^XLFSTR(FREQ)
 ... S IENS=IND_","_IEN_","
 ... S FDA(811.97,IENS,.01)=FREQ
 ... D FILE^DIE("ET","FDA","MSG")
 .;Findings
 . S IND=0
 . F  S IND=+$O(^PXD(811.9,IEN,20,IND)) Q:IND=0  D
 .. S FREQ=$P(^PXD(811.9,IEN,20,IND,0),U,4)
 .. I FREQ?1.N1L D
 ... S TEXT(1)=""
 ... S TEXT(2)="Found lower case finding frequency:"
 ... S TEXT(3)=" IEN="_IEN_" Finding="_IND_" Frequency="_FREQ
 ... S TEXT(4)=" Changing it to upper case."
 ... D MES^XPDUTL(.TEXT)
 ... S FREQ=$$UP^XLFSTR(FREQ)
 ... S $P(^PXD(811.9,IEN,20,IND,0),U,4)=FREQ
 Q
 ;
 ;==========================================
VSINS ;Install the value set file data.
 N FILENUM
 D BMES^XPDUTL("Installing Value Set data.")
 F FILENUM=802.1,802.2,802.3 M ^PXRM(FILENUM)=@XPDGREF@(FILENUM)
 Q
 ;
 ;==========================================
VSSAVE ;Pre-Transportation routine; save the value set file data in the
 ;transport global.
 N FILENUM
 F FILENUM=802.1,802.2,802.3 M @XPDGREF@(FILENUM)=^PXRM(FILENUM)
 Q
 ;
