USRP3INI ; SLC/PKR - Inits for patch USR*1.0*3 ;5/06/1998
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**3**;Jun 20, 1997
 ;======================================================================
POST ;Patch USR*1.0*2 post-inits.
 D XREF
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
