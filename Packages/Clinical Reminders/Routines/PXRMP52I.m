PXRMP52I ;SLC/PKR - Inits for PXRM*2.0*52. ;03/11/2015
 ;;2.0;CLINICAL REMINDERS;**52**;Feb 04, 2005;Build 218
 ;==========================================
LENDIAG(DEF,DIALOG) ;Link and enable a dialog.
 N DIEN,RIEN,TEXT
 S RIEN=$O(^PXD(811.9,"B",DEF,""))
 I RIEN="" D
 . S TEXT="Reminder definition "_DEF_" was not installed!"
 . D MES^XPDUTL(TEXT)
 S DIEN=$O(^PXRMD(801.41,"B",DIALOG,""))
 I DIEN="" D
 . S TEXT="Reminder dialog "_DIALOG_" was not installed!"
 . D MES^XPDUTL(TEXT)
 I (+RIEN>0),(+DIEN>0) D
 . K TEXT
 . S TEXT(1)="Linking and enabling reminder dialog "_DIALOG
 . S TEXT(2)="to reminder definition "_DEF_"."
 . S TEXT(3)=""
 . D MES^XPDUTL(.TEXT)
 . S ^PXD(811.9,RIEN,51)=DIEN
 . S $P(^PXRMD(801.41,DIEN,0),U,3)=0
 Q
 ;
 ;==========================================
LENDIAGA ;Make sure the dialogs are linked and enabled.
 N IND,DEFL,DLGL
 S DEFL(1)="VA-HEPATITIS C RISK ASSESSMENT"
 S DLGL(1)="VA-HEPATITIS C RISK ASSESSMENT"
 S DEFL(2)="VA-HEPATITIS C TESTING"
 S DLGL(2)="VA-HEPATITIS C TESTING"
 D BMES^XPDUTL("Linking and enabling dialogs")
 F IND=1:1:2 D LENDIAG^PXRMP52I(DEFL(IND),DLGL(IND))
 Q
 ;
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP52E")
 D RENAME^PXRMUTIL(811.9,"VA-HEP C RISK ASSESSMENT","VA-HEPATITIS C RISK ASSESSMENT")
 Q
 ;
 ;==========================================
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SETPVER^PXRMUTIL("2.0P52")
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP52E")
 D LENDIAGA^PXRMP52I
 D SENDIM^PXRMP52I
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*52"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*52 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@DOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*52"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*52 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
