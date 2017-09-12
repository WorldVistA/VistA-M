PXRMP36I ;SLC/PKR - Inits for PXRM*2.0*36. ;11/19/2013
 ;;2.0;CLINICAL REMINDERS;**36**;Feb 04, 2005;Build 207
 ;==========================================
ENVCHK ;Environment check.
 N IEN,IMM,TEXT
 S IMM="PNEUMOVAX POLYSACCHARIDE PPSV23"
 S IEN=+$$FIND1^DIC(9999999.14,,"BX",IMM,,,"MSG")
 I IEN<100000 D  Q
 . S TEXT(1)="The environment check was successful, this build can be installed."
 . D BMES^XPDUTL(.TEXT)
 S TEXT(1)="Your site has a locally defined immunization named:"
 S TEXT(2)=" "_IMM
 S TEXT(3)="This name is reserved for a national immunization, therefore this build"
 S TEXT(4)="cannot be installed until the local entry it is renamed."
 D BMES^XPDUTL(.TEXT)
 S XPDABORT=1
 Q
 ;
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 D RENAME^PXRMP36I
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP36E")
 Q
 ;
 ;==========================================
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SETPVER^PXRMUTIL("2.0P36")
 ;Install Exchange File entries.
 ;Make sure immunizations are installed as national.
 N PXRMIHSC
 S $P(^AUTTIMM(0),U,3)=0,PXRMIHSC=1
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP36E")
 D SENDIM^PXRMP36I
 Q
 ;
 ;=========================================
RENAME ;Rename some entries.
 N IEN,FILENUM,MSG,NEWNAME,OLDNAME
 D BMES^XPDUTL("Checking for entries that need renamed.")
 S FILENUM=9999999.14
 S NEWNAME="PNEUMOVAX POLYSACCHARIDE PPSV23"
 S OLDNAME="PNEUMOVAX"
 S IEN=+$$FIND1^DIC(FILENUM,"","BX",OLDNAME,"","","MSG")
 I IEN>0 D
 . D BMES^XPDUTL("Renaming immunization "_OLDNAME_" to "_NEWNAME)
 . D RENAME^PXRMUTIL(FILENUM,OLDNAME,NEWNAME)
 S FILENUM=811.2
 S NEWNAME="VA-PNEUMOC DZ RISK - HIGH"
 S OLDNAME="VA-HIGH RISK FOR PNEUMOCOCCAL DZ"
 S IEN=+$$FIND1^DIC(FILENUM,"","BX",OLDNAME,"","","MSG")
 I IEN>0 D
 . D BMES^XPDUTL("Renaming taxonomy "_OLDNAME_" to "_NEWNAME)
 . D RENAME^PXRMUTIL(FILENUM,OLDNAME,NEWNAME)
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*36"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*36 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@DOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*36"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*36 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
