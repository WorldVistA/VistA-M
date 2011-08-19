XUSTERM ;SEA/AMF/WDE - DEACTIVATE USER ;5/5/09
 ;;8.0;KERNEL;**36,73,135,148,169,222,313,384,489,527**;Jul 10, 1995;Build 1
 ;;"Per VHA Directive 2004-038, this routine should not be modified".
LKUP N DIRUT,DIC,DIR,XUDA,DA
 S DIC=200,DIC("S")="I $L($P(^(0),U,3))",DIC(0)="AEQMZ",DIC("A")="Select USER to be deactivated: "
 D ^DIC K DIC G END:Y<0 S XUDA=+Y
 D INQ Q:$D(DIRUT)
 S DA=XUDA,DIE=200,DR="["_$$GET^XUPARAM("XUSERDEACT","N")_"]" D GET,XUDIE^XUS5
 S XUDT=$P(^VA(200,DA,0),U,11),XUACT=XUDT&(XUDT>DT) G END:'XUDT
 G:XUACT WHEN G NOW
 ;
WHEN W !!,XUNAM," will be deactivated on date specified."
 S ZTDTH=XUDT,ZTRTN="DQ1^XUSTERM1",ZTDESC="DEACTIVATE USER",ZTSAVE("XUDA")="",ZTIO="" D ^%ZTLOAD
 G END
 ;
NOW S DIR("A")=XUNAM_" will be deactivated now.  Do you wish to proceed",DIR("B")="YES",DIR("??")="XUUSER-DEACT",DIR(0)="Y"
 D ^DIR I "Yy"'[$E(X_U) S XUDT=$$NOW^XLFDT G WHEN
 W ! S XUVE=1 D ACT
 G END
 ;
INQ ;Ask to show User Inquiry
 N DIR,DIC,FLDS,BY,FR,TO,Y,L
 S DIR(0)="Y",DIR("A")="View/Print User Inquiry Data",DIR("B")="Yes" D ^DIR Q:$D(DIRUT)!('Y)
 S L=0,DIC=200,FLDS="[XUSERINQ]",BY="NUMBER",(TO,FR)=XUDA D EN1^DIP K DIC
 K DIR S DIR(0)="E" D ^DIR
 Q
 ;
GET ;XUGRP=mail group, XUKEY=keys, XUSUR=mail surrogates, XUJ=# baskets, XUK=# mail msg, XUIN=# in-basket msg
 ;XUTX1, XUTX2 used in edit templates
 K XUGRP,XUKEY,XUSUR,XUTX1,XUTX2 N %,XU10,XU11,XU20,XU21,XU30,XU31
 S (XU10,XU20)=0,(XU11,XU21,XU31)=""
 S DA=XUDA,XUNAM=$P(^VA(200,XUDA,0),U,1)
 F XUI=0:0 S XUI=$O(^XMB(3.8,"AB",XUDA,XUI)) Q:XUI'>0  D  ;Mail groups
 . S XUK=^XMB(3.8,XUI,0) S:'$L($P(XUK,U,2)) $P(XUK,U,2)="PU"
 . S XUGRP(XUI)=$P(XUK,U,1,2)_U_$S('$D(^XMB(3.8,XUI,3)):0,1:^(3)=XUDA)
 . S XU10=XU10+1 S:$L(XU11)<70 XU11=XU11_","_$P(XUK,U)
 F XUI=0:0 S XUI=$O(^VA(200,XUDA,51,XUI)) Q:XUI'>0  D  ;Get keys
 . S %=$G(^DIC(19.1,XUI,0)),XU20=XU20+1
 . S:$L(XU21)<70 XU21=XU21_","_$P(%,U)
 . Q:$P(%,U,4)="y"  ;Don't count keep at terminate keys
 . S XUKEY(XUI)=""
 F XUI=0:0 S XUI=$O(^XMB(3.7,"AB",XUDA,XUI)) Q:XUI'>0  D
 . S XUSUR(XUI)="" S:$L(XU31)<70 XU31=XU31_","_$P(^VA(200,XUI,0),U)
 S (XUJ,XUK,XUIN,XUNUM)=0
 F I=.9:0 S I=$O(^XMB(3.7,XUDA,2,I)) Q:I'>0  D
 . S XUJ=XUJ+1,XUNUM=$P($G(^XMB(3.7,XUDA,2,I,1,0)),U,4)
 . S:XUNUM>0 XUK=XUK+XUNUM S:I=1 XUIN=XUNUM
 . Q
 S XUTX1(1)="User has "_XUK_" messages in "_XUJ_" baskets, Member of "_XU10_" Mail Groups."
 S:XU10 XUTX1(2)="Mail Groups: "_$E(XU11,2,80) S:$L(XU31) XUTX1(3)="Surrogate for: "_$E(XU31,2,80)
 S XUTX2(1)="User has "_XU20_" keys" S:XU20 XUTX2(2)=$E(XU21,2,80)
 S XUEMP='($D(XUSUR)!$D(XUKEY)!$D(XUGRP)!XUJ!XUK!XUIN!$L($P(^VA(200,XUDA,0),U,3)))
 Q
ACT ;First let others clean-up, Then do our part.
 ;D ^XUSTERM2 ;Cleanup by other packages.
 N DIC,DA,DIE,DR
 L +^VA(200,XUDA,0):6
 ;Delete some fields first.
 ;Access;Verify;PAC;Last signon;SMD delegate;electronic signature,Primary menu,Hinq Employee #
 S DIE=200,DA=XUDA,DR="2///@;11///@;14///@;1.1///@;19///@;19.2///@;20.4///@;201///@;14.9///@" D ^DIE
 L -^VA(200,XUDA,0)
 D DEQUE^XUSERP(XUDA,3) ;Cleanup by other packages.
 ;
 K DIC S DA=XUDA,XUJ=^VA(200,XUDA,0),XUNAM=$P(XUJ,U,1),XUACT(19)=$S($D(^VA(200,XUDA,19)):^(19),1:"") F XUI=5,6,10 S XUACT(XUI)=$P(XUJ,U,XUI)
ACT1 K ^DISV(XUDA) ; WARNING: This only gets ^DISV entries on current CPU
 ;keys
 I XUACT(6)'="n" F XUI=0:0 S XUI=$O(^VA(200,XUDA,51,XUI)) Q:XUI'>0  I $P($G(^DIC(19.1,XUI,0)),U,4)'="y" S DA=XUI,DA(1)=XUDA,DIK="^VA(200,XUDA,51," D ^DIK W:XUVE "..."
 ;delegated keys
 I XUACT(6)'="n" F XUI=0:0 S XUI=$O(^VA(200,XUDA,52,XUI)) Q:XUI'>0  S DA=XUI,DA(1)=XUDA,DIK="^VA(200,XUDA,52," D ^DIK W:XUVE "..."
 ;Delegated options
 S DIK="^VA(200,XUDA,19.5,",DA(1)=XUDA F XUI=0:0 S XUI=$O(^VA(200,XUDA,19.5,XUI)) Q:XUI'>0  S DA=XUI D ^DIK
 ;Menu templates
 S DIK="^VA(200,XUDA,19.8,",DA(1)=XUDA F XUI=0:0 S XUI=$O(^VA(200,XUDA,19.8,XUI)) Q:XUI'>0  S DA=XUI D ^DIK
 ;Secondary Menus
 S DIK="^VA(200,XUDA,203,",DA(1)=XUDA F XUI=0:0 S XUI=$O(^VA(200,XUDA,203,XUI)) Q:XUI'>0  S DA=XUI D ^DIK
 S DA=0,DA(1)=XUDA D D2^XUFILE1 ;Remove all access to files.
 ;Terminate Person Class
 D TERM^XUA4A72(XUDA,XUDT)
 ;Remove all parameters for the user.
 D DELUSR^XPAR3(XUDA)
 ;
ACT2 ;XUACT(5) All Mail access,  Mail groups
 D MAIL
 D SEND^XUSTERM1
 W:XUVE "... DONE"
 Q
 ;
END K C,D,D0,DI,DR,DIC,DIE,DA,DIR,XUEMP,XUDA,XUI,XUJ,XUK,XUACT,XUKEY,XUGRP,XUSUR,XUNAM,XUF,XUDT,XUIN,DIC,XUDB,XUDC,XUDP,XUGP,XUNUM,XUVE,Y
 K XUTX1,XUTX2,DIRUT,DIR
 Q
MAIL ;Remove mail access
 I XUACT(5)'="n" D TERMINAT^XMUTERM1(XUDA)
 Q
