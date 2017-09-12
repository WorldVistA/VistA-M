PXRMP40I ;SLC/PKR - Inits for PXRM*2.0*40. ;01/14/2014
 ;;2.0;CLINICAL REMINDERS;**40**;Feb 04, 2005;Build 202
 Q
 ;==========================================
CHKAB ;Check all entries in the file #100.21 Member multiple and make sure
 ;they are in the "AB" index.
 D BMES^XPDUTL("Checking ^OR(100.21,""AB"") index.")
 N IEN,IND,MLIST,TNAME,VPTR
 S IEN=0
 F  S IEN=$O(^OR(100.21,IEN)) Q:+IEN=0  D
 . S IND=0
 . F  S IND=+$O(^OR(100.21,IEN,10,IND)) Q:IND=0  D
 .. S VPTR=$P(^OR(100.21,IEN,10,IND,0),U,1)
 .. I VPTR="" Q
 .. I $D(^OR(100.21,"AB",VPTR,IEN,IND)) Q
 .. S TNAME=$P(^OR(100.21,IEN,0),U,1)
 .. S MLIST(TNAME)=IEN
 .. S ^OR(100.21,"AB",VPTR,IEN,IND)=""
 I '$D(MLIST) D MES^XPDUTL("No patients were missing from the ""AB"" index.") Q
 D BMES^XPDUTL("Added entries to the ""AB"" index for the following teams:")
 S TNAME=""
 F  S TNAME=$O(MLIST(TNAME)) Q:TNAME=""  D
 . D MES^XPDUTL("  "_TNAME)
 Q
 ;
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTION^PXRMUTIL("DISABLE")
 D PROTOCOL^PXRMUTIL("DISABLE")
 Q
 ;
 ;==========================================
POST ;Post-init
 D SETPVER^PXRMUTIL("2.0P40")
 D CHKAB
 ;Enable options and protocols
 D OPTION^PXRMUTIL("ENABLE")
 D PROTOCOL^PXRMUTIL("ENABLE")
 D SENDIM^PXRMP40I
 Q
 ;
 ;==========================================
SENDIM ;Send install message.
 N FROM,NODE,PARAM,SYSTEM,SUBJECT,TO,VALUE
 S NODE="PXRM*2.0*40"
 K ^TMP(NODE,$J)
 ;DBIA #1131 for ^XMB("NETNAME")
 S FROM="PXRM*2.0*40 Install@"_^XMB("NETNAME")
 ;DBIA #2541
 S SYSTEM=$$KSP^XUPARAM("WHERE")
 I $$PROD^XUPROD(1) S TO("G.CLINICAL REMINDERS SUPPORT@DOMAIN.EXT")=""
 E  D
 . N MGIEN,MGROUP
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . S MGROUP=$S(MGIEN'="":"G."_$$GET1^DIQ(3.8,MGIEN,.01),1:DUZ)
 . S TO(MGROUP)=""
 S SUBJECT="Install of PXRM*2.0*40"
 S ^TMP(NODE,$J,1,0)="PXRM*2.0*40 has been installed."
 S ^TMP(NODE,$J,2,0)="System is "_SYSTEM
 D SEND^PXRMMSG(NODE,SUBJECT,.TO,FROM)
 Q
 ;
