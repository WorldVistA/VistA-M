FSCLMPO ;SLC/STAFF-NOIS List Manager Protocol Other ;11/9/97  11:44
 ;;1.1;NOIS;;Sep 06, 1998
 ;
USER ; from FSCLMP
 N DA,DIC,DR,DIE,OK,SPEC,USER,Y K DIC
 S OK=1
 I '$$ACCESS^FSCU(DUZ,"SPEC") D  Q:'OK
 .N DIR,X,Y K DIR
 .S DIR(0)="YA0",DIR("A")="Do you want to edit pacakage affiliations? ",DIR("B")="YES"
 .S DIR("?",1)="Enter YES to enter or edit package affiliations."
 .S DIR("?",2)="Enter NO to simply review user defaults."
 .S DIR("?",3)="Enter '^' or '??' for more help."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .D ^DIR K DIR
 .I Y'=1 Q
 .D NONSPEC^FSCLMPOD(DUZ) S OK=0 Q
 W ! S DIC=7105.2,DIC(0)="AEMQ",USER=$$VALUE^FSCGET($P($G(^FSC("SPEC",DUZ,0)),U),7105.2,.01) S:$L(USER) DIC("B")=USER D ^DIC
 I Y<0 S OK=0
 I OK D
 .S (DA,SPEC)=+Y D EN^DIQ
 .I '$$ACCESS^FSCU(DUZ,"SPEC") D PAUSE^FSCU(.OK) Q
 .I '(SPEC=DUZ&$D(DIC("B"))!$$ACCESS^FSCU(DUZ,"SUPER")) D PAUSE^FSCU(.OK) Q
 .W ! S DIE=DIC,DR=$S($$ACCESS^FSCU(DUZ,"SUPER"):".02:999",1:".02;3:6;8:999")
 .L +^FSC("SPEC",SPEC):30 I '$T W !,"Unable to edit." Q
 .D ^DIE
 .L -^FSC("SPEC",SPEC)
 K DIC
 S VALMBCK=$S($G(FSCEXIT):"Q",1:"R")
 Q
 ;
EXIT ; from FSCLMP
 S FSCEXIT=1,VALMBCK="Q"
 Q
 ;
OTHER ; from FSCLMP
 N ACTION,CALL,DIR,X,Y K DIR
 S DIR(0)="SAMO^EDITS:EDITS;NOTIFICATION:NOTIFICATION;CONTACTS:CONTACTS;WORKLOAD:WORKLOAD"
 S DIR("A")="Select (E)dits, (N)otification, (C)ontacts, or (W)orkload: "
 S DIR("?",1)="Enter EDITS to review status history and audit trail."
 S DIR("?",2)="Enter NOTIFICATION to review lists and automatic alerts."
 S DIR("?",3)="Enter CONTACTS to review phone numbers."
 S DIR("?",4)="Enter WORKLOAD to review workload entries."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 S ACTION=Y
 S CALL=$$CALL^FSCLMPE1(FSCCNT)
 W !!,$$SHORT^FSCGETS(CALL,"  ")
 I ACTION="EDITS" D EDITS^FSCLMPOE(CALL) Q
 I ACTION="NOTIFICATION" D NOTIFY^FSCLMPON(CALL) Q
 I ACTION="CONTACTS" D CONTACTS^FSCLMPOC(CALL) Q
 I ACTION="WORKLOAD" D WKLD^FSCLMPOW(CALL) Q
 Q
 ;
DL ; from FSCLMP
 I $G(VALMAR)["FSC MODIFY LIST" W !,"You are already using this option.",$C(7) H 2 Q
 I $G(VALMAR)["FSC INSTALLS" W !,"Unable to use this option from this screen.",$C(7) H 2 Q
 N DIC,DLAYGO,DEFLIST,FSCQEDIT,OK,Y K DIC,Y
 I $D(FSCLNAME),$D(FSCLNUM) S DEFLIST=FSCLNUM_U_$P(FSCLNAME," (MODIFIED)")
 I '$D(FSCLNAME)!'$D(FSCLNUM)!'$D(DEFLIST)!'$D(^FSC("LIST",+$G(FSCLNUM),0)) D
 .S (DIC,DLAYGO)=7107.1,DIC(0)="AELMOQ",DIC("A")="Select List: " S:$D(FSCLNAME)&($D(^FSC("LIST",+$G(FSCLNUM),0))) DIC("B")=FSCLNAME D ^DIC K DIC Q:Y<1
 .S DEFLIST=Y,FSCLNAME=$P(Y,U,2),FSCLNUM=+Y
 .I $P(DEFLIST,U,3) D BROWSE^FSCQB("",$P(DEFLIST,U,2),0,.OK)
 I '$D(FSCLNAME) Q
 I '$G(FSCLNUM) Q
 I $D(DEFLIST) D MODIFY^FSCLM($P(DEFLIST,U,2),+DEFLIST)
 I $D(FSCQEDIT) D ASKLIST^FSCLMPD
 S VALMBCK=$S($G(FSCEXIT):"Q",1:"R")
 Q
