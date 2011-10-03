XUSTERM1 ;SEA/WDE - DEACTIVATE USER ;06/08/09  15:06
 ;;8.0;KERNEL;**102,180,208,222,274,313,332,360,384,436,514**;Jul 10, 1995;Build 8
ENALL ;Interactive scan all
 S U="^",DTIME=$G(DTIME,60)
 W !!,"This option can purge all access & verify codes, mail baskets, messages,",!,"authorized senders access, keys, and electronic signature codes of users who have been terminated."
RD1 W !!,"Do you wish to proceed "
 S %=2 D YN^DICN G:%=2!(%=-1) END I %=0 S XQH="XUUSER-PURGEATT" D EN^XQH G RD1
RD2 W !,"Do you wish to verify each user "
 S %=2,XUVE=0 D YN^DICN S:%=1 XUVE=1 G:%=1 CHECK G:%=-1 END I %=0 S XQH="XUUSER-PURGEATT-VER" D EN^XQH G RD2
QUE W !,"Do you wish to have this queued for a later time "
 S %=1 D YN^DICN I %=1 D  Q
 . S ZTDESC="USER DEACTIVATION",ZTRTN="CHECK^XUSTERM1",ZTIO="",ZTSAVE("DUZ*")=""
 . D ^%ZTLOAD
 . Q
 I %=0 K X,XUVE Q
 ;Fall thru if user doesn't queue
CHECK ;Entry point for taskman.
 N XUDT540,XUDT90,XUDT30,FDA,XUDT,XUAAW
 S U="^",DT=$$DT^XLFDT(),XUDT90=$$HTFM^XLFDT($H-90,1),XUDT30=$$HTFM^XLFDT($H-30,1)
 S XUAAW=+$P($G(^XTV(8989.3,1,3)),U,4) ;Academic Waiver
 S XUDT540=$$HTFM^XLFDT($H-540,1) ;*p332
 S XUDA=.6,XUVE=$G(XUVE,0)
 F  S XUDA=$O(^VA(200,XUDA)) Q:XUDA'>0  S XUJ=$G(^(XUDA,0)) D
 . S XUDT=$P(XUJ,U,11)
 . I $P(XUJ,U,3)]"",$L(XUDT),(XUDT'>DT) D
 . . D GET
 . . I 'XUEMP K Y D:XUVE DISP Q:$D(Y)  D ACT ;XUEMP=any data to remove
 . . Q
 . I $P(XUJ,U,3)]"",'$P(XUJ,U,8),$$NOSIGNON D DISUSER(XUDA)
 . I $P(XUJ,U,7) D AUSER(XUDA) ;*p332
 . Q
 ;
END K XUEMP,XUDA,XUI,XUJ,XUK,XUACT,XUKEY,XUGRP,XUSUR,XUNAM,XUF,XUDT,XUIN,XUVE,X,DIC,XUDB,XUDC,XUDP
 Q
 ;
DISUSER(XUDA) ;Set DISUSER flag and reason, Remove last menu option
 Q:$P(XUJ,U,7)  ;DISUSER already set *p332
 N %,FDA S %=XUDA_","
 S FDA(200,%,7)=1,FDA(200,%,9.4)="User Inactive for too long"
 D FILE^DIE("","FDA"),CONTCL(XUDA) ;Set Disuser
 Q
 ;
AUSER(XUDA) ;If DISUSERed and Last Sign > 540[18Mo.*30] days, then remove"AUSER" xref
 I $D(^XUSEC("XUORES",XUDA)) Q  ;Owner of XUORES key ;p*436
 N Q S Q=$P($G(^VA(200,XUDA,1.1)),U) ;Get last sign-on
 I $L(Q),Q<XUDT540 K ^VA(200,"AUSER",$P(XUJ,U),XUDA) ;*p360;*p384
 Q
 ;
 ;If site has an Academic Affiliation Waiver the last sign-on moves to 90 days from 30.
NOSIGNON() ;Check last signon. Return 1 if should disable account
 N Q S Q=$P($G(^VA(200,XUDA,1.1)),U) ;Get last sign-on
 I $L(Q),Q>$S('XUAAW:XUDT30,1:XUDT90) Q 0 ;Last sign-on within 30/90 days VA Handbook 6500 ;p514
 S Q=$P($G(^VA(200,XUDA,1.1)),U,4) ;Get last Edit date
 I $L(Q),Q>XUDT30 Q 0 ;User edited in last 30 days
 S Q=$P($G(^VA(200,XUDA,1)),U,7) ;Create Date
 I $L(Q),Q>XUDT30 Q 0 ;User set up in last 30 days
 S Q=$P($G(^VA(200,XUDA,.1)),U) ;Get verify code change date
 I $L(Q),(Q+30)>$H Q 0 ;Verify code changed in last 30 days
 Q 1
 ;
CONTCL(XUDA) ;Clear the fields for Menu "Continue"
 N FDA
 S FDA(200,XUDA_",",202.1)="@",FDA(200,XUDA_",",202.2)="@"
 D FILE^DIE("","FDA") ;Clear 202.1 and 202.2
 Q
 ;
ACT ;
 D ACT^XUSTERM
 S XUJ=^VA(200,XUDA,0) ;Get new copy of zero node
 Q
 ;
GET ;Kill ^DISV entries each time, should get all CPUs at some point
 N XUJ
 D GET^XUSTERM K ^DISV(XUDA),Y
 Q
DISP ;Display info and get responses.
 N DA,DIE,DR,XUJ
 S DA=XUDA
 L +^VA(200,DA,0):6 D DISP2 L -^VA(200,DA,0)
 Q
DISP2 ;Do the work.
 W !!,$S(XUTX1(1)["User":XUNAM_$P(XUTX1(1),"User",2),1:XUTX1(1)) ;*p360
 S DR="9.21//YES",DIE=200 D ^DIE Q:$D(Y)  G:'$D(XUSUR) KEYS
 W !!,XUNAM," acts as surrogate for the following users:"
 S XUJ=0,XUI=3 F XUK=0:1 S XUJ=$O(XUSUR(XUJ)) Q:XUJ'>0  W:'(XUK#XUI) ! W ?(XUK#XUI*26),$P(^VA(200,XUJ,0),U,1) W !,"These surrogate privileges will be deleted on deactivation."
KEYS ;This section checks for authorized senders of mail groups and security keys.
 W !,"User will no longer be an authorized sender to any mail groups."
 I '$D(XUKEY) W !!,XUNAM," currently holds no keys." G KEYS1
 W !!,XUNAM," holds the following keys: "
 S XUJ=0,XUI=5 F XUK=0:1 S XUJ=$O(XUKEY(XUJ)) Q:XUJ'>0  W:'(XUK#XUI) ! W ?(XUK#XUI*15),$P($G(^DIC(19.1,XUJ,0)),U,1)
KEYS1 W ! S DR="9.22//YES" D ^DIE Q:$D(Y)
GROUP I '$D(XUGRP) W !!,XUNAM," currently is not a member of any MAIL GROUP." G GROUP1
 W !!,XUNAM," is a member of the following Mail Groups:"
 S XUI="" F XUI=0:0 S XUI=$O(XUGRP(XUI)) Q:XUI'>0  D
 . S XUJ=XUGRP(XUI)
 . I $P(XUJ,U,2)="PU"!$D(^XMB(3.8,"AB",XUDA,XUI)) W !?2,$P(XUJ,U,1) W:$P(XUJ,U,3) " (Organizer)" W ?40,$S(($P(XUJ,U,2)="PR"):"(Private)",1:"(Public)")
 . Q
GROUP1 W ! S DR="9.23//YES" D ^DIE Q:$D(Y)
 Q
 ;
DQ1 ;Terminate one person.
 N XUJ,XUDT,XUVE
 S XUJ=$G(^VA(200,XUDA,0)),XUDT=$P(XUJ,U,11) I XUDT,(XUDT'>DT) D
 . S XUVE=0 D GET I 'XUEMP D ACT
 . Q
 Q
 ;
SEND ; send deactivated message to assigned mail group
 K XMB,XMY
 S XMB(1)=$P(XUJ,"^",1)
 S XMB(2)=$$GET1^DIQ(200,XUDA,8)
 S XMB(3)=$$GET1^DIQ(200,XUDA,29)
 S XMB(4)=$$FMTE^XLFDT(XUDT)
 S XMB="XUSERDEAC" D ^XMB:$D(^XMB(3.6,"B",XMB))
 K XMB
 Q
