XMVVITA ;ISC-SF/GMB-Edit User's MailMan Variables ;04/29/2003  07:49
 ;;8.0;MailMan;**18**;Jun 28, 2002
 ; Replaces ^XMGAPI1,FWD^XMA21FWD,BANNER^XMA6,EDIT^XMA7 (ISC-WASH/CAP)
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; BANNER   XMBANNER       - Edit user's banner
 ; EDIT     XMEDITUSER     - Edit user's preferences
 ; FILTER   XM FILTER EDIT - Edit user's message filters
 ; BASKET   XM DELIVERY BASKET EDIT - Edit user's delivery basket preferences
 ; FORWARD  XMEDITFWD      - Edit user's forwarding address
 ; SURR     XMEDITSURR     - Edit user's surrogates
FORWARD ; Edit forwarding address
 N XMIA
 S XMIA=1
 N DIE,DA,DR
 S DIE=3.7
 S DA=DUZ
 S DR="2;2.1"
 D ^DIE
 Q
XMFWD(XMADDR,XMIA) ; Serves as input transform for 'forwarding address'
 N XMERROR,XMRESTR,XMINSTR,XMFULL,XMFWDADD
 I XMADDR'["@",".D.d.H.h.S.s."'[("."_$E(XMADDR,1,2)) K XMADDR Q
 S XMINSTR("ADDR FLAGS")="X" ; do not create ^TMP(, just check.
 S XMFWDADD=DUZ ; editing forwarding address
 D ADDRESS^XMXADDR(DUZ,XMADDR,.XMFULL,.XMERROR)
 I $D(XMERROR) K XMADDR Q
 I XMFULL'["@" D
 . ; Remote address is really local.  OK if device or server.
 . I ".D.H.S."[("."_$E(XMFULL,1,2)) S XMFULL=XMFULL_"@"_^XMB("NETNAME")
 I XMFULL'["@" D  Q
 . ; Remote address is really local
 . K XMADDR
 . D EN^DDIOL($$EZBLD^DIALOG(38130)) ; You can't have your mail forwarded to a local address.
 S XMADDR=XMFULL
 Q
DELFWD(XMUSER,XMFWD,XMERROR) ; Delete a user's invalid forwarding address.
 S XMFDA(3.7,XMUSER_",",2)="@"
 D FILE^DIE("","XMFDA")
 N XMPARM,XMINSTR,XMTEXT,XMAPPEND
 S XMINSTR("FROM")=.5
 S XMPARM(1)=XMFWD
 I +XMERROR=XMERROR D
 . D BLD^DIALOG(XMERROR,.XMERROR,"","XMTEXT","F")
 . D MSG^DIALOG("AE",.XMAPPEND,"","","XMTEXT")
 E  D
 . S XMPARM(2)=XMERROR
 . S XMAPPEND=""
 D TASKBULL^XMXBULL(.5,"XM FWD ADDRESS DELETE",.XMPARM,"XMAPPEND",XMUSER,.XMINSTR)
 Q
BANNER ; Edit banner
 N DIE,DA,DR
 S DIE=3.7
 S (XMDUZ,DA)=$G(XMDUZ,DUZ)
 S DR=4
 D ^DIE
 D SETBAN^XMVVITAE(XMDUZ,.XMV)
 Q
FILTER ; Edit filters
 N DIE,DA,DR,XMIA
 S XMIA=1
 S DIE=3.7
 S DA=DUZ
 S DR="16;15"     ; Message filters flag ; Message filters
 D ^DIE
 Q:$D(^XMB(3.7,DUZ,15,"AF"))
 W !!,$C(7),$$EZBLD^DIALOG(38131) ; Note that you have no active filters.
 Q
BASKET ; Edit delivery baskets
 N DIE,DA,DR
 S DIE=3.7
 S DA=DUZ
 S DR="16.2;S:X'=""S"" Y=0;1"     ; Accept delivery basket? ; Select basket.
 S DR(2,3.701)="3" ; Is this a delivery basket?
 D ^DIE
 Q
SURR ; Edit Surrogates
 N DIE,DA,DR
 S DIE="^XMB(3.7,"
 S DA=DUZ
 S DR="8"         ; surrogate
 D ^DIE
 Q
EDIT ; Edit User Preferences
 N DIE,DA,DR
 D CHECK^XMVVITAE
 W !!,$$EZBLD^DIALOG(38132,$$GET1^DID(3.7,"","","NAME")) ; Editing data in the MAILBOX file:
 S DIE="^XMB(3.7,"
 S DA=DUZ
 S DR=""
 S DR=DR_";4"         ; banner
 S DR=DR_";17"        ; message display order
 S DR=DR_";21"        ; new message read order
 S DR=DR_";18"        ; message reader default
 S DR=DR_";19"        ; message reader prompt
 S DR=DR_";20"        ; new messages default option
 S DR=DR_";6"         ; show message preview
 S DR=DR_";11"        ; message action default
 S DR=DR_";12"        ; ask basket
 S DR=DR_";13"        ; show titles
 S DR=DR_";14"        ; priority responses flag
 S DR=DR_";14.1"      ; priority responses prompt
 S DR=DR_";16.3"      ; p-message queued from
 S DR=DR_";9"         ; mailman institution
 S DR=DR_";2.21:2.23" ; network signature lines
 S DR=DR_";4.5"       ; introduction
 S DR=$E(DR,2,99)
 D ^DIE
 D NEWORDER
 W !!,$$EZBLD^DIALOG(38132,$$GET1^DID(200,"","","NAME")) ; Editing data in the NEW PERSON file:
 S DIE="^VA(200,"
 S DA=DUZ
 S DR=""
 S DR=DR_";31.3"      ; preferred editor
 S DR=DR_";.111"      ; street address 1
 S DR=DR_";.112"      ; street address 2
 S DR=DR_";.113"      ; street address 3
 S DR=DR_";.114"      ; city
 S DR=DR_";.115"      ; state
 S DR=DR_";.116"      ; zip
 S DR=DR_";.132"      ; office phone
 S DR=DR_";.136"      ; fax #
 S DR=DR_";.137"      ; voice pager
 S DR=DR_";.138"      ; digital pager
 S DR=DR_";.133"_$$EZBLD^DIALOG(38133,1) ; ADD'L PHONE 1  phone #3
 S DR=DR_";.134"_$$EZBLD^DIALOG(38133,2) ; ADD'L PHONE 2  phone #4
 S DR=$E(DR,2,99)
 D ^DIE
 D PREFER^XMVVITAE(DUZ,.XMV,.XMDISPI)
 D SETBAN^XMVVITAE(XMDUZ,.XMV)
 D SETNET^XMVVITAE(XMDUZ,.XMV)
 Q
NEWORDER ;
 N XMDIC,XMK
 I $D(^XMB(3.7,DUZ,2,"AP")) D
 . N I,XMKN,XMTEXT
 . W !
 . ;Current priority order for reading baskets with new messages:
 . D BLD^DIALOG(38140,"","","XMTEXT","F")
 . D MSG^DIALOG("WM","","","","XMTEXT")
 . S (I,XMK)=0
 . F  S I=$O(^XMB(3.7,DUZ,2,"AP",I)) Q:'I  D
 . . F  S XMK=$O(^XMB(3.7,DUZ,2,"AP",I,XMK)) Q:'XMK  D
 . . . S ^TMP("XM",$J,"AP",I,$$BSKTNAME^XMXUTIL(DUZ,XMK))=""
 . S I=0,XMKN=""
 . F  S I=$O(^TMP("XM",$J,"AP",I)) Q:'I  D
 . . F  S XMKN=$O(^TMP("XM",$J,"AP",I,XMKN)) Q:XMKN=""  D
 . . . W !,$J(I,4),?8,XMKN
 . K ^TMP("XM",$J,"AP")
 W !
 ;Editing the priority order for reading baskets with new messages.
 ;Note:  You don't need priority ordering unless you want to change the
 ;default 'read new messages' basket from IN to other basket(s).
 D BLD^DIALOG(38141,"","","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 F  D  Q:XMK=U
 . S XMDIC("B")="@" ; no default basket
 . S XMDIC("S")="I Y>1" ; can't select IN or WASTE baskets
 . S XMDIC("W")="W ?40,$P(^(0),U,4)"
 . W !
 . D SELBSKT^XMJBU(DUZ,"","",.XMDIC,.XMK) Q:XMK=U
 . N DA,DR,DIE
 . S DIE="^XMB(3.7,"_DUZ_",2,"
 . S DA(1)=DUZ,DA=XMK
 . S DR="4T"    ; Read new messages basket priority
 . D ^DIE
 Q
GOTNS(XMDUZ) ; Function: Does the user have a network signature? (1=yes; 0=no)
 Q "^^"'[$G(^XMB(3.7,XMDUZ,"NS1"))
CRE8NS ; The user does not have a network signature.
 ; Does the user want to create a network signature now?
 ; If the user creates one, routine sets $T to true; else false
 N DIR,X,Y
 S DIR(0)="Y",DIR("B")=$$EZBLD^DIALOG(39054) ; Yes
 S DIR("A")=$$EZBLD^DIALOG(37309.5) ; Would you like to create a Network Signature now
 D ^DIR Q:'Y
 K DIR
 D EDITNS
 I $$GOTNS(DUZ)
 Q
EDITNS ; Edit network signature
 N DIE,DA,DR
 S DIE="^XMB(3.7,",DA=DUZ,DR="2.21:2.23" D ^DIE
 Q
