FSCLMPS ;SLC/STAFF-NOIS List Manager Protocol Save and SaveAs ;9/6/98  21:09
 ;;1.1;NOIS;;Sep 06, 1998
 ;
ASLD ; from FSCLMP
 I "AMS"'[$P(^FSC("LIST",FSCLNUM,0),U,3) W !,"You cannot copy this list.",$C(7) H 2 Q
 N DA,DIC,DIK,DLAYGO,NAME,NEWLNUM,OK,OWNER,X,Y K DIC
 D NAME^FSCMU("",.NAME,.OK) I 'OK Q
 D OWNER^FSCMU(+$P($G(^FSC("LIST",FSCLNUM,0)),U,2),.OWNER,.OK) I 'OK Q
 W ! D ASK^FSCLD(.OK) I 'OK Q
 I '$G(OWNER) S OWNER=DUZ
 S (DIC,DLAYGO)=7107.1,DIC(0)="L",X=NAME
 D ^DIC I '$P(Y,U,3) K DIC W !,"Not defined.",$C(7) H 2 Q
 S NEWLNUM=+Y
 W !,"A copy of ",FSCLNAME," is being saved as ",NAME,".",!
 M ^FSC("LIST",NEWLNUM)=^FSC("LIST",FSCLNUM)
 S $P(^FSC("LIST",NEWLNUM,0),U)=NAME,$P(^(0),U,2)=OWNER
 S DIK=DIC,DA=NEWLNUM D IX1^DIK K DIC
 S FSCLNAME=NAME,FSCLNUM=NEWLNUM
 L +^XTMP("FSC LIST DEF",FSCLNUM):20 I '$T D BAD^FSCLDS
 E  D BUILD^FSCLDU(FSCLNUM,.OK) I 'OK D BAD^FSCLDS
 L -^XTMP("FSC LIST DEF",FSCLNUM)
 D ENTRY^FSCLMM,HEADER^FSCLMM
 H 1
 Q
 ;
ASLIST ; from FSCLMP
 N DEFAULT,DIC,LISTNAME,LISTNUM,NUM,X,Y K DIC,^TMP("FSC SELECT",$J,"VALUES")
 S DIC=7107.1,DIC(0)="AEMOQ"
 I $P($G(^FSC("LIST",FSCLNUM,0)),U,3)="S",$P(^(0),U,2)=DUZ!'$P(^(0),U,2) S DIC("B")=$P(FSCLNAME," (MODIFIED)")
 I '$D(DIC("B")) S NUM=0 F  S NUM=$O(^FSC("LIST","C",DUZ,NUM))  Q:NUM<1  I $P(^FSC("LIST",NUM,0),U,3)="S" S DIC("B")=$P(^(0),U) Q
 I '$D(DIC("B")) D
 .W !,"You do not own any STORAGE-ONLY type lists."
 .W !,"You can define this type of list using the Define List action (DL)"
 .W !,"for temporarily storing calls.  You can still store calls under any"
 .W !,"public lists."
 S DIC("S")="I $P(^(0),U,3)=""S"",$P(^(0),U,2)=DUZ!'$P(^(0),U,2)"
 S DIC("A")="Save to list: "
 D ^DIC K DIC I Y<1 Q
 S LISTNUM=+Y,LISTNAME=$P(Y,U,2),DEFAULT="1-"_+^TMP("FSC LIST CALLS",$J)
 I DEFAULT="1-0" D  Q
 .N DIR,X,Y K DIR
 .S DIR(0)="YAO",DIR("A")="Save this list with all calls removed? ",DIR("B")="YES"
 .S DIR("?",1)="Enter YES to save this as an empty list."
 .S DIR("?",2)="Enter NO or '^' to exit without saving."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .D ^DIR K DIR
 .I Y'=1 Q
 .D SAVE(LISTNUM,"REPLACE")
 D SELECT^FSCUL(DEFAULT,"",DEFAULT,"VALUES",.OK) I 'OK Q
 N DIR,X,Y K DIR
 S DIR(0)="SAMO^ADD:ADD;REPLACE:REPLACE",DIR("A")="(A)dd calls to "_LISTNAME_" or (R)eplace "_LISTNAME_" with these calls? ",DIR("B")="ADD"
 S DIR("?",1)="Enter ADD to add these calls to the list."
 S DIR("?",2)="Enter REPLACE to have the list only have these calls."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 D SAVE(LISTNUM,Y)
 Q
 ;
SAVE(LISTNUM,SAVETYPE) ;
 N CALL,CALLLINE,LISTSNUM,NUM
 I SAVETYPE="REPLACE" S CALL=0 F  S CALL=$O(^FSCD("LISTS","ALC",LISTNUM,CALL)) Q:CALL<1  S LISTSNUM=+$O(^(CALL,0)) I LISTSNUM D DELETE(LISTSNUM)
 I SAVETYPE="ADD"!(SAVETYPE="REPLACE") D
 .S NUM=0 F  S NUM=$O(^TMP("FSC SELECT",$J,"VALUES",NUM)) Q:NUM<1  D
 ..S CALLLINE=+$O(^TMP("FSC LIST CALLS",$J,"IDX",NUM,0))
 ..S CALL=+$O(^TMP("FSC LIST CALLS",$J,"ICX",CALLLINE,0)) D ADD(CALL,LISTNUM)
 K ^TMP("FSC SELECT",$J,"VALUES")
 Q
 ;
ADD(CALL,LIST,OK) ; from FSCLP, FSCRPCLO, FSCRPCSL
 S OK=1 I $D(^FSCD("LISTS","ALC",LIST,CALL)) S OK=0 Q
 N LISTSNUM S LISTSNUM=1+$P(^FSCD("LISTS",0),U,3)
 L +^FSCD("LISTS",0):30 I '$T Q  ; *** skip
 F  Q:'$D(^FSCD("LISTS",LISTSNUM,0))  S LISTSNUM=LISTSNUM+1
 S ^FSCD("LISTS",LISTSNUM,0)=CALL_U_LIST
 S $P(^FSCD("LISTS",0),U,3)=LISTSNUM,$P(^(0),U,4)=$P(^(0),U,4)+1
 L -^FSCD("LISTS",0)
 S ^FSCD("LISTS","B",CALL,LISTSNUM)=""
 S ^FSCD("LISTS","L",LIST,LISTSNUM)=""
 S ^FSCD("LISTS","ALC",LIST,CALL,LISTSNUM)=""
 Q
 ;
DELETE(DA) ; from FSCLDR, FSCLP, FSCRPCLO, FSCRPCSL
 I 'DA Q
 N DIK
 S DIK="^FSCD(""LISTS"","
 D ^DIK
 Q
