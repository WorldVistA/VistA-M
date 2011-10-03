PXRMP20I ;SLC/PKR - Inits for PXRM*2.0*20. ;04/01/2011
 ;;2.0;CLINICAL REMINDERS;**20**;Feb 04, 2005;Build 117
 Q
 ;==========================================
CFINC(Y) ;List of computed findings to include in the build.
 N CFLIST,CFNAME
 S CFLIST("VA-PROJECT ARCH ELIGIBILITY")=""
 S CFLIST("VA-PROJECT ARCH ELIGIBILITY LIST")=""
 ;S CFLIST("")=""
 S CFNAME=$P($G(^PXRMD(811.4,Y,0)),U)
 Q $S($D(CFLIST(CFNAME)):1,1:0)
 ;
 ;==========================================
ENDIAG ;Make sure the dialog is enabled.
 N IEN
 S IEN=+$O(^PXRMD(801.41,"B","VA-PROJECT ARCH VISN CONTRACT CARE PILOT ELIGIBILITY",""))
 I IEN=0 Q
 S $P(^PXRMD(801.41,IEN,0),U,3)=0
 Q
 ;
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP20E")
 Q
 ;
 ;==========================================
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SETPVER^PXRMUTIL("2.0P20")
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP20E")
 D ENDIAG^PXRMP20I
 D SENDIM^PXRMP20I
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*20"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*20 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@FORUM.VA.GOV")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*20"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*20 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
