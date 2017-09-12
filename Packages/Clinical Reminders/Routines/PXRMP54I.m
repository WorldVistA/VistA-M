PXRMP54I ;SLC/PKR - Inits for PXRM*2.0*54. ;11/04/2014
 ;;2.0;CLINICAL REMINDERS;**54**;Feb 04, 2005;Build 211
 ;==========================================
LU(FILE,NAME) ;
 N ERR,RESULT
 S RESULT=$$FIND1^DIC(FILE,"",,NAME,,,"ERR")
 I $D(ERR) D AWRITE^PXRMUTIL("ERR") Q 0
 Q RESULT
 ;
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 D DELEXE^PXRMEXSI("EXARRAY","PXRMP54E")
 Q
 ;
 ;==========================================
POST ;Post-init
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SETPVER^PXRMUTIL("2.0P54")
 ;Install Exchange File entries.
 D SMEXINS^PXRMEXSI("EXARRAY","PXRMP54E")
 D TIUOBJ
 D SENDIM^PXRMP54I
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*54"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*54 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@DOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*54"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*54 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
 ;==========================================
TIUOBJ ;
 N COWN,IEN,NAME
 S COWN=$$LU(8930,"CLINICAL COORDINATOR")
 F NAME="EBOLA RISK TRIAGE COMPLETED","EBOLA RISK TRIAGE LAST RATING","EBOLA RISK TRIAGE (CUMULATIVE)" D
 .S IEN=$$LU(8925.1,NAME) I IEN'>0 D MES^XPDUTL("Could not find TIU Object: "_NAME_".") Q
 .D TIUOBJU(IEN,NAME,DUZ,COWN)
 Q
 ;==========================================
 ;
TIUOBJU(IEN,NAME,POWN,COWN) ;
 N FDA,MSG
 S FDA(8925.1,"?"_IEN_",",.01)=NAME
 I +$G(COWN)>0 S FDA(8925.1,"?"_IEN_",",.06)=+$G(COWN)
 I +$G(COWN)'>0 S FDA(8925.1,"?"_IEN_",",.05)=POWN
 D UPDATE^DIE("","FDA","","MSG")
 I $D(MSG) D AWRITE^PXRMUTIL("MSG")
 Q
 ;
