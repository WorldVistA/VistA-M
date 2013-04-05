XMYPRE ;ISC-SF/GMB-Pre- & Post- Init ;08/29/2002  09:03
 ;;8.0;MailMan;;Jun 28, 2002
PRE ; Pre-init
 K ^DD(4.21,2,3) ; Kill errant help node.
 K ^DD(3.7,2,1,1,1.2) ; Kill obsolete node.
 K ^DD(3.811,0,"NM","MEMBER GROUP") ; Kill errant name.
 Q:'$D(^DD(3.702,6,1,1,1))  ; Quit if the pre-init has run already
 D OPTION
 D DELFLDS
 D ACXREF
 Q
OPTION ; Clean up some MailMan options
 N XMOPT,XMIEN,XMFDA,XMIENS
 F XMOPT="XMQSHOW","XMSUBEDIT","XMDXPROT" D
 . S XMIEN=$O(^DIC(19,"B",XMOPT,0)) Q:'XMIEN
 . S XMIENS=XMIEN_","
 . S XMFDA(19,XMIENS,15)="@" ; EXIT ACTION
 . ;S XMFDA(19,XMIENS,20)="@" ; ENTRY ACTION
 . D FILE^DIE("","XMFDA")
 F XMOPT="XMMGR-IN-BASKET-PURGE" D
 . S XMIEN=$O(^DIC(19,"B",XMOPT,0)) Q:'XMIEN
 . S XMIENS=XMIEN_","
 . S XMFDA(19,XMIENS,3.7)="@" ; HELP FRAME
 . D FILE^DIE("","XMFDA")
 Q
DELFLDS ; Delete fields no longer used.
 S DIK="^DD(4.2999,",DA=7,DA(1)=4.2999 D ^DIK ; OUTGOING MESSAGE COUNT
 S DIK="^DD(4.2999,",DA=8,DA(1)=4.2999 D ^DIK ; CHARACTERS REC'D
 S DIK="^DD(4.2999,",DA=9,DA(1)=4.2999 D ^DIK ; INCOMING MESSAGE COUNT
 S DIK="^DD(4.2999,",DA=10,DA(1)=4.2999 D ^DIK ; CHARACTERS SENT
 N I
 S I=0
 F  S I=$O(^XMBS(4.2999,I)) Q:'I  S ^XMBS(4.2999,I,0)=I
 Q
ACXREF ; Delete old AC xref for NETWORK PRIORITY TRANSMISSION field.
 D DELIX^DDMOD(3.702,6,1)  ; delete the DD, leave the data
 N XMK,XMZ ; Reposition the xref to match the new definition.
 S XMK=0
 F  S XMK=$O(^XMB(3.7,.5,2,"AC",1,XMK)) Q:'XMK  D
 . S XMZ=0
 . F  S XMZ=$O(^XMB(3.7,.5,2,"AC",1,XMK,XMZ)) Q:'XMZ  D
 . . K ^XMB(3.7,.5,2,"AC",1,XMK,XMZ)
 . . S ^XMB(3.7,.5,2,XMK,1,"AC",1,XMZ)=""
 Q
POST ; Post-init
 D INIT^XMC
 D KEYS
 D DIALOG
 Q
KEYS ; Security Keys
 ; KIDS does not correctly transport the 'mutually exclusive' field,
 ; so we have to correct it.
 N XMSTAR,XMSTARL,XMFDA,I
 S XMSTAR=$$FIND1^DIC(19.1,"","QX","XMSTAR")
 S XMSTARL=$$FIND1^DIC(19.1,"","QX","XMSTAR LIMITED")
 S I=$O(^DIC(19.1,XMSTAR,5,0))
 S XMFDA(19.15,I_","_XMSTAR_",",.01)=XMSTARL
 D FILE^DIE("","XMFDA")
 S I=$O(^DIC(19.1,XMSTARL,5,0))
 S XMFDA(19.15,I_","_XMSTARL_",",.01)=XMSTAR
 D FILE^DIE("","XMFDA")
 Q
DIALOG ; Delete DIALOG file entries.  KIDS fails to do this.
 N DIK,DA
 S DIK="^DI(.84,"
 F DA=34425,34443,34443.1 D ^DIK
 Q
