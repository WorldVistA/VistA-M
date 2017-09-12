USRP2INI ; SLC/PKR - Inits for patch USR*1.0*2 ;1/23/1998
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**2**;Jun 20, 1997
 ;======================================================================
CFTERM ;Check for terminated users and set expiration dates.
 N USRDUZ,XUIFN
 S USRDUZ=""
 F  S USRDUZ=$O(^USR(8930.3,"B",USRDUZ)) Q:USRDUZ=""  D
 . I $$ISTERM^USRLM(USRDUZ) D
 .. S XUIFN=USRDUZ
 .. D TERM^USRLM
 Q
 ;
 ;======================================================================
DDDUSCM ;Delete the data dictionary for file 8930.3
 N DIU
 S DIU="^USR(8930.3,"
 S DIU(0)=""
 D EN^DIU2
 Q
 ;
 ;======================================================================
POST ;Patch USR*1.0*2 post-inits.
 D XREF
 D CFTERM
 Q
 ;
 ;======================================================================
PRE ;Patch USR*1.0*2 pre-inits.
 D DDDUSCM
 Q
 ;
 ;======================================================================
XREF ;Rebuild the cross-references for file 8930.3.
 N DIK
 ;First delete all the old cross-references.
 K ^USR(8930.3,"ACU")
 K ^USR(8930.3,"AUC")
 K ^USR(8930.3,"AUHX")
 K ^USR(8930.3,"B")
 ;Now rebuild them.
 S DIK="^USR(8930.3,"
 D IXALL^DIK
 Q
