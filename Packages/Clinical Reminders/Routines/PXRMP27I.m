PXRMP27I ;SLC/PKR - Inits for PXRM*2.0*27. ;09/20/2012
 ;;2.0;CLINICAL REMINDERS;**27**;Feb 04, 2005;Build 188
 Q
 ;==========================================
LENDIAG ;Make sure the dialogs are linked and enabled.
 N DIEN,RIEN,TEXT
 S RIEN=$O(^PXD(811.9,"B","VA-LIPID STATIN RX CVD/DM (VER1.0)",""))
 I RIEN="" D
 . S TEXT="Reminder definition VA-LIPID STATIN RX CVD/DM (VER1.0) was not installed!"
 . D MES^XPDUTL(TEXT)
 S DIEN=$O(^PXRMD(801.41,"B","VA-LIPID STATIN RX CVD/DM",""))
 I DIEN="" D
 . S TEXT="Reminder dialog VA-LIPID STATIN RX CVD/DM was not installed!"
 . D MES^XPDUTL(TEXT)
 I (+RIEN>0),(+DIEN>0) D
 . S ^PXD(811.9,RIEN,51)=DIEN
 . S $P(^PXRMD(801.41,DIEN,0),U,3)=0
 ;
 S RIEN=$O(^PXD(811.9,"B","VA-HOMELESSNESS SCREENING",""))
 I RIEN="" D  Q 
 . S TEXT="Reminder definition VA-HOMELESSNESS SCREENING was not installed!"
 . D MES^XPDUTL(TEXT)
 S DIEN=$O(^PXRMD(801.41,"B","VA-HOMELESSNESS SCREENING",""))
 I DIEN="" D
 . S TEXT="Reminder dialog VA-HOMELESSNESS SCREENING was not installed!"
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
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP27E")
 D RENAME^PXRMUTIL(811.9,"VA-LIPID STATIN RX CVD/DM (V1)","VA-LIPID STATIN RX CVD/DM (VER1.0)")
 Q
 ;
 ;==========================================
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SETPVER^PXRMUTIL("2.0P27")
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP27E")
 D LENDIAG^PXRMP27I
 D SENDIM^PXRMP27I
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*27"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*27 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@FORUM.domain.ext")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*27"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*27 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
