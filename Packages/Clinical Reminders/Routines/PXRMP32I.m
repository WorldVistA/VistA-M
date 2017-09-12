PXRMP32I ;SLC/PKR - Inits for PXRM*2.0*32. ;06/02/2014
 ;;2.0;CLINICAL REMINDERS;**32**;Feb 04, 2005;Build 194
 Q
 ;==========================================
HFINACT ;Inactivate all health factors that start with "SST SESSION NUMBER".
 N DONE,IEN,NAME
 S DONE=0
 S NAME="SST SESSION NUMBER"
 D BMES^XPDUTL("Inactivating health factors that start with "_NAME)
 F  S NAME=$O(^AUTTHF("B",NAME)) Q:DONE  D
 . I $E(NAME,1,18)'="SST SESSION NUMBER" S DONE=1 Q
 . S IEN=$O(^AUTTHF("B",NAME,""))
 . D BMES^XPDUTL("Inactivating "_NAME)
 . S $P(^AUTTHF(IEN,0),U,11)=1
 Q
 ;
 ;==========================================
HFRENAME ;Rename some health factors.
 N DONE,IND,NEWNAME,OLDNAME,TEXT,TOTAL
 D BMES^XPDUTL("Checking for health factors that need to be renamed.")
 S (DONE,TOTAL)=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(HFLIST+IND^PXRMP32H),";",3)
 . I TEXT="" S DONE=1 Q
 . S TOTAL=TOTAL+1
 . S OLDNAME=$P(TEXT,U,1)
 . S NEWNAME=$P(TEXT,U,2)
 . D BMES^XPDUTL("Renaming "_OLDNAME_" to "_NEWNAME)
 . D RENAME^PXRMUTIL(9999999.64,OLDNAME,NEWNAME)
 ;
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(HFLIST+IND^PXRMP32F),";",3)
 . I TEXT="" S DONE=1 Q
 . S TOTAL=TOTAL+1
 . S OLDNAME=$P(TEXT,U,1)
 . S NEWNAME=$P(TEXT,U,2)
 . D BMES^XPDUTL("Renaming "_OLDNAME_" to "_NEWNAME)
 . D RENAME^PXRMUTIL(9999999.64,OLDNAME,NEWNAME)
 D BMES^XPDUTL(TOTAL_" entries were processed.")
 Q
 ;
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP32E")
 D HFRENAME^PXRMP32I
 Q
 ;
 ;==========================================
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SETPVER^PXRMUTIL("2.0P32")
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP32E")
 D HFINACT^PXRMP32I
 D SENDIM^PXRMP32I
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*32"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*32 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@DOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*32"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*32 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
