PXRMP28I ;SLC/PKR - Inits for PXRM*2.0*28. ;01/14/2013
 ;;2.0;CLINICAL REMINDERS;**28**;Feb 04, 2005;Build 206
 Q
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
 S DEFL(1)="VA-WH DISCUSS BREAST CA SCREEN WOMAN 40-49"
 S DLGL(1)="VA-WH DISCUSS BREAST CA WOMAN 40-49"
 S DEFL(2)="VA-WH MAMMOGRAM SCREENING"
 S DLGL(2)="VA-WH MAMMOGRAM SCREENING"
 S DEFL(3)="VA-WH PAP SMEAR REVIEW RESULTS"
 S DLGL(3)="VA-WH PAP SMEAR REVIEW RESULTS"
 S DEFL(4)="VA-WH PAP SMEAR SCREENING"
 S DLGL(4)="VA-WH PAP SMEAR SCREENING"
 S DEFL(5)="VA-WH MAMMOGRAM REVIEW RESULTS"
 S DLGL(5)="VA-WH MAMMOGRAM REVIEW RESULTS"
 D BMES^XPDUTL("Linking and enabling dialogs")
 F IND=1:1:5 D LENDIAG^PXRMP28I(DEFL(IND),DLGL(IND))
 Q
 ;
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP28E")
 D RENAME^PXRMP28I
 Q
 ;
 ;==========================================
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SETPVER^PXRMUTIL("2.0P28")
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP28E")
 D LENDIAGA^PXRMP28I
 D SENDIM^PXRMP28I
 Q
 ;
 ;==========================================
RENAME ;
 D BMES^XPDUTL("Renaming health factors.")
 D RENAME^PXRMUTIL(9999999.64,"WH BR CA SCREEN N/A 5 YRS","WH BR CA SCREEN N/A 5 YRS-LE<5YRS")
 D RENAME^PXRMUTIL(9999999.64,"CERVICAL CA SCRN N/A 5 YRS","WH CERV CA SCRN N/A 5 YRS-LE<5YRS")
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*28"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*28 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@DOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*28"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*28 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
