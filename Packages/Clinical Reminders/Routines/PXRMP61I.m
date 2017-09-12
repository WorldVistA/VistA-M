PXRMP61I ;SLC/PKR - Inits for PXRM*2.0*61. ;08/10/2015
 ;;2.0;CLINICAL REMINDERS;**61**;Feb 04, 2005;Build 221
 ;==========================================
INACT ;Rename and inactivate obsolete national taxonomies.
 N IEN,NAME,TAXLIST,ZZNAME
 D BMES^XPDUTL("Checking for obsolete national taxonomies to be inactivated.")
 D TAXLIST(.TAXLIST)
 S NAME=""
 F  S NAME=$O(TAXLIST(NAME)) Q:NAME=""  D
 . S IEN=+$O(^PXD(811.2,"B",NAME,""))
 . I IEN=0 Q
 . D MES^XPDUTL(" Inactivating taxonomy "_NAME)
 . S $P(^PXD(811.2,IEN,0),U,6)=1
 . S ZZNAME="ZZ"_NAME
 . D RENAME^PXRMUTIL(811.2,NAME,ZZNAME)
 Q
 ;
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 D INACT^PXRMP61I
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP61E")
 Q
 ;
 ;==========================================
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SETPVER^PXRMUTIL("2.0P61")
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP61E")
 D SENDIM^PXRMP61I
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*61"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*61 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@DOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*61"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*61 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
 ;==========================================
TAXLIST(LIST) ;Populate the list of taxonomies to inactivate.
 S LIST("VA-IM FLU H1N1 (1 DOSE)")=""
 Q
 ;
