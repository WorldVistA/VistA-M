PXRMP62I ;SLC/KCM - Inits for PXRM*2.0*62. ;01/13/2016
 ;;2.0;CLINICAL REMINDERS;**62**;Feb 04, 2005;Build 23
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP62E")
 Q
 ;
 ;==========================================
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SETPVER^PXRMUTIL("2.0P62")
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP62E")
 D SENDIM^PXRMP62I
 D UPDSPONS
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*62"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*62 Install@"_^XMB("NETNAME")
 ;DBIA #2571
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@DOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*62"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*62 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
 ; =========================================
UPDSPONS ;update sponsor names
 N OLD,NEW
 S OLD="Office of Mental Health Services"
 S NEW="Mental Health Services"
 I $$FIND1^DIC(811.6,"","BXU",OLD)>0 D RENAME^PXRMUTIL(811.6,OLD,NEW)
 S OLD="Office of Mental Health Services and Women Veterans Health Program"
 S NEW="Mental Health Services and Women Veterans Health Program"
 I $$FIND1^DIC(811.6,"","BXU",OLD)>0 D RENAME^PXRMUTIL(811.6,OLD,NEW)
 Q
