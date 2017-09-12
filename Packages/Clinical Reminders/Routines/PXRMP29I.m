PXRMP29I ;SLC/PKR - Inits for PXRM*2.0*29. ;03/05/2014
 ;;2.0;CLINICAL REMINDERS;**29**;Feb 04, 2005;Build 196
 Q
 ;==========================================
HFRENAME ;
 N DONE,IND,NEWNAME,OLDNAME,TEXT,TOTAL
 D BMES^XPDUTL("Checking for health factors that need to be renamed.")
 S (DONE,TOTAL)=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(HFLIST+IND^PXRMP29H),";",3)
 . I TEXT="" S DONE=1 Q
 . S TOTAL=TOTAL+1
 . S OLDNAME=$P(TEXT,U,1)
 . S NEWNAME=$P(TEXT,U,2)
 . D RENAME^PXRMUTIL(9999999.64,OLDNAME,NEWNAME)
 ;
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(HFLIST+IND^PXRMP29F),";",3)
 . I TEXT="" S DONE=1 Q
 . S TOTAL=TOTAL+1
 . S OLDNAME=$P(TEXT,U,1)
 . S NEWNAME=$P(TEXT,U,2)
 . D RENAME^PXRMUTIL(9999999.64,OLDNAME,NEWNAME)
 D BMES^XPDUTL(TOTAL_" entries were processed.")
 Q
 ;
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 D HFRENAME^PXRMP29I
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP29E")
 Q
 ;
 ;==========================================
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SETPVER^PXRMUTIL("2.0P29")
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP29E")
 D SENDIM^PXRMP29I
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*29"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*29 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@DOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*29"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*29 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
