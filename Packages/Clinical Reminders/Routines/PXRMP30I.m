PXRMP30I ;SLC/PKR - Inits for PXRM*2.0*30. ;04/18/2013
 ;;2.0;CLINICAL REMINDERS;**30**;Feb 04, 2005;Build 206
 Q
 ;==========================================
DELDIE ;Delete Dialog file entries.
 N IEN,IND,JND,LIST,LUVALUE,NAME,NUM
 S NAME(1)="VA-URL UPDATE CARRIER ELEMENT"
 S NAME(2)="VA-URL UPDATE CARRIER ELEMENT 2"
 D BMES^XPDUTL("Deleting unneeded Dialog entries.")
 F IND=1:1:2 D
 . S IEN=+$O(^PXRMD(801.41,"B",NAME(IND),""))
 . I IEN=0 Q
 . D MES^XPDUTL("Deleting "_NAME(IND))
 . D DELETE^PXRMEXFI(801.41,IEN)
 Q
 ;
 ;==========================================
DELEXE ;Delete Exchange file entries.
 N IND,LIST,NAME,NUM
 S NAME="VA-URL UPDATE CARRIER ELEMENT"
 D BMES^XPDUTL("Deleting unneeded Exchange entries.")
 D FIND^DIC(811.8,"","","U",NAME,"","","","","LIST")
 I '$D(LIST) Q
 S NUM=+$P(LIST("DILIST",0),U,1)
 I NUM=0 Q
 F IND=1:1:NUM D
 . D MES^XPDUTL(" Deleting "_LIST("DILIST",1,IND))
 . N DA,DIK
 . S DIK="^PXD(811.8,"
 . S DA=LIST("DILIST",2,IND)
 . D ^DIK
 Q
 ;
 ;==========================================
LENDIAG ;There is a bug in the pre patch 24 version of PXRMEXSI that
 ;causes the VA-ECOE INITIAL NOTE dialog to be erroneously linked
 ;to the reminder VA-ALCOHOL USE SCREEN (AUDIT-C), fix that.
 N DIEN,RIEN,TEXT
 S RIEN=$O(^PXD(811.9,"B","VA-ALCOHOL USE SCREEN (AUDIT-C)",""))
 I RIEN="" D
 . S TEXT="Reminder definition VA-ALCOHOL USE SCREEN (AUDIT-C) does not exist!"
 . D MES^XPDUTL(TEXT)
 S DIEN=$O(^PXRMD(801.41,"B","VA-ALCOHOL USE SCREENING (AUDIT-C)",""))
 I DIEN="" D
 . S TEXT="Reminder dialog VA-ALCOHOL USE SCREENING (AUDIT-C) does not exist!"
 . D MES^XPDUTL(TEXT)
 I (+RIEN>0),(+DIEN>0) D
 . S ^PXD(811.9,RIEN,51)=DIEN
 . S $P(^PXRMD(801.41,DIEN,0),U,3)=0
 Q
 ;
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP30E")
 Q
 ;
 ;==========================================
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SETPVER^PXRMUTIL("2.0P30")
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP30E")
 D LENDIAG^PXRMP30I
 D DELDIE^PXRMP30I
 D DELEXE^PXRMP30I
 D SENDIM^PXRMP30I
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*30"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*30 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@DOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*30"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*30 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
