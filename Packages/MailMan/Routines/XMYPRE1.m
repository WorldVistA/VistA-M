XMYPRE1 ;ISC-SF/GMB-Pre- & Post- Init ;08/22/2002  09:24
 ;;8.0;MailMan;**2**;Jun 28, 2002
POST ; Post-init
 D DIALOG
 Q
DIALOG ; Delete DIALOG file entries.  KIDS fails to do this.
 N DIK,DA
 S DIK="^DI(.84,"
 F DA=34230,34231,34232,34237,34238 D ^DIK
 Q
