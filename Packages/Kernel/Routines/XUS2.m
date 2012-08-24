XUS2 ;SF/RWF - TO CHECK OR RETURN USER ATTRIBUTES ;2/1/2012
 ;;8.0;KERNEL;**59,180,313,419,437,574**;Jul 10, 1995;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
ACCED ; ACCESS CODE EDIT from DD
 I "Nn"[$E(X,1) S X="" Q
 I "Yy"'[$E(X,1) K X Q
 N DIR,DIR0,XUAUTO,XUK
 S XUAUTO=($P($G(^XTV(8989.3,1,3)),U,1)="y"),XUH=""
AC1 D CLR,AAUTO:XUAUTO,AASK:'XUAUTO G OUT:$D(DIRUT) D REASK G OUT:$D(DIRUT),AC1:'XUK D CLR,AST(XUH)
 G OUT
 ;
AASK ;Ask for Access code
 N X,XUU,XUEX X ^%ZOSF("EOFF")
 S XUEX=0
 F  D AASK1 Q:XUEX!($D(DIRUT))
 Q
 ;
AASK1 ;
 W "Enter a new ACCESS CODE <Hidden>: " D GET Q:$D(DIRUT)
 I X="@" D DEL D:Y'=1 DIRUT S XUH="",XUEX=1 Q
 I X[$C(34)!(X[";")!(X["^")!(X[":")!(X'?.UNP)!($L(X)>20)!($L(X)<6)!(X="MAIL-BOX") D CLR W $C(7),$$AVHLPTXT(1) D AHELP Q
 I 'XUAUTO,((X?6.20A)!(X?6.20N)) D CLR W $C(7),$$AVHLPTXT(1),! Q
 S XUU=X,X=$$EN^XUSHSH(X),XUH=X,XMB(1)=$O(^VA(200,"A",XUH,0)) I XMB(1),XMB(1)'=DA S XMB="XUS ACCESS CODE VIOLATION",XMB(1)=$P(^VA(200,XMB(1),0),"^"),XMDUN="Security" D ^XMB
 I $D(^VA(200,"AOLD",XUH))!$D(^VA(200,"A",XUH)) D CLR W $C(7),"This has been used previously as an ACCESS CODE.",! Q
 S XUEX=1 ;Now we can quit
 Q
 ;
REASK S XUK=1 Q:XUH=""  D CLR X ^%ZOSF("EOFF")
 F XUK=3:-1:1 W "Please re-type the new code to show that I have it right: " D GET G:$D(DIRUT) DIRUT D ^XUSHSH Q:(XUH=X)  D CLR W "This doesn't match.  Try again!",!,$C(7)
 S:XUH'=X XUK=0
 Q
 ;
AST(XUH) ;Change ACCESS CODE and index.
 W "OK, Access code has been changed!"
 N FDA,IEN,ERR
 S IEN=DA_","
 S FDA(200,IEN,2)=XUH D FILE^DIE("","FDA","ERR")
 W !,"The VERIFY CODE has been deleted as a security measure.",!,"You will need to enter a new VERIFY code so the user can sign-on.",$C(7)
 D VST("",1)
 I $D(^XMB(3.7,DA,0))[0 S Y=DA D NEW^XM ;Make sure has a Mailbox
 Q
 ;
GET ;Get the user input and convert case.
 S X=$$ACCEPT^XUS I (X["^")!('$L(X)) D DIRUT
 S X=$$UP^XLFSTR(X)
 Q
 ;
DIRUT S DIRUT=1
 Q
 ;
CLR ;New line or Clear screenman area
 I '$D(DDS) W ! Q
 N DX,DY
 D CLRMSG^DDS S DX=0,DY=DDSHBX+1 X IOXY
 Q
 ;
NEWCODE D REASK I XUK W !,"OK, remember this code for next time!"
 G OUT
 ;
CVC ;From XUS1
 N DA,X
 S DA=DUZ,X="Y"
 W !,"You must change your VERIFY CODE at this time."
 ;Fall into next code
VERED ; VERIFY CODE EDIT From DD
 N DIR,DIR0,XUAUTO,XUSVCMIN,XUSVCACCT S XUSVCACCT=$$SVCACCT(DA),XUSVCMIN=$S(+XUSVCACCT:12,1:8)
 I "Nn"[$E(X,1) S X="" Q
 I "Yy"'[$E(X,1) K X Q
 S XUH="",XUAUTO=($P($G(^XTV(8989.3,1,3)),U,3)="y") S:DUZ=DA XUAUTO="n" ;Auto only for admin
VC1 D CLR,VASK:'XUAUTO,VAUTO:XUAUTO G OUT:$D(DIRUT) D REASK G OUT:$D(DIRUT),VC1:'XUK D CLR,VST(XUH,1)
 D CALL^XUSERP(DA,2)
 G OUT
 ;
VASK ;Ask for Verify Code
 N X,XUU X ^%ZOSF("EOFF") G:'$$CHKCUR() DIRUT D CLR
VASK1 W "Enter a new VERIFY CODE: " D GET Q:$D(DIRUT)
 I '$D(XUNC),(X="@") D DEL G:Y'=1 DIRUT S XUH="" Q
 D CLR S XUU=X,X=$$EN^XUSHSH(X),XUH=X,Y=$$VCHK(XUU,XUH) I +Y W $C(7),$P(Y,U,2,9),! D:+Y=1 VHELP G VASK1
 Q
 ;
VCHK(S,EC) ;Call with String and Encrypted versions
 ;Updated per VHA directive 6210 Strong Passwords
 N PUNC,NA,XUPAT S PUNC="~`!@#$%&*()_-+=|\{}[]'<>,.?/"
 S NA("FILE")=200,NA("FIELD")=.01,NA("IENS")=DA_",",NA=$$HLNAME^XLFNAME(.NA),XUPAT=XUSVCMIN_".20"
 I ($L(S)<XUSVCMIN)!($L(S)>20)!(S'?.UNP)!(S[";")!(S["^")!(S[":") Q "1^"_$$AVHLPTXT
 I (S?@(XUPAT_"A"))!(S?@(XUPAT_"N"))!(S?@(XUPAT_"P"))!(S?@(XUPAT_"AN"))!(S?@(XUPAT_"AP"))!(S?@(XUPAT_"NP")) Q "2^VERIFY CODE must be a mix of alpha and numerics and punctuation."
 I $D(^VA(200,DA,.1)),EC=$P(^(.1),U,2) Q "3^This code is the same as the current one."
 I $D(^VA(200,DA,"VOLD",EC)) Q "4^This has been used previously as the VERIFY CODE."
 I EC=$P(^VA(200,DA,0),U,3) Q "5^VERIFY CODE must be different than the ACCESS CODE."
 I S[$P(NA,"^")!(S[$P(NA,"^",2)) Q "6^Name cannot be part of code."
 Q 0
 ;
VST(XUH,%) ;
 W:$L(XUH)&% !,"OK, Verify code has been changed!"
 N FDA,IEN,ERR S IEN=DA_","
 S:XUH="" XUH="@" ;11.2 get triggerd
 S FDA(200,IEN,11)=XUH D FILE^DIE("","FDA","ERR")
 I $D(ERR) D ^%ZTER
 I (DUZ'=(+IEN))&$$SVCACCT(+IEN)&(XUH'="@") D  ;override trigger of 11.2 by 11 for svc accts
 .K FDA,ERR S FDA(200,IEN,11.2)=$H D FILE^DIE("","FDA","ERR")
 .I $D(ERR) D ^%ZTER
 S:DA=DUZ DUZ("NEWCODE")=XUH Q
 ;
DEL ;
 X ^%ZOSF("EON") W $C(7) S DIR(0)="Y",DIR("A")="Sure you want to delete" D ^DIR I Y'=1 W:$X>55 !?9 W $C(7),"  <Nothing Deleted>"
 Q
 ;
AAUTO ;Auto-get Access codes
 N XUK,Y
 X ^%ZOSF("EON") F XUK=1:1:3 D AGEN Q:(Y=1)!($D(DIRUT))
 Q
 ;
AGEN ;Generate a ACCESS code
 S XUU=$$AC^XUS4 S (X,XUH)=$$EN^XUSHSH(XUU) I $D(^VA(200,"A",X))!$D(^VA(200,"AOLD",X)) G AGEN
 D CLR W "The new ACCESS CODE is: ",XUU,"   This is ",XUK," of 3 tries."
 D YN
 Q
 ;
AHELP S XUU=$$AC^XUS4 S X=$$EN^XUSHSH(XUU) I $D(^VA(200,"A",X))!$D(^VA(200,"AOLD",X)) G AHELP
 W !,"Here is an example of an acceptable Access Code: ",XUU,!
 Q
 ;
VHELP S XUU=$$VC^XUS4 S X=$$EN^XUSHSH(XUU) I ($P($G(^VA(200,DA,0)),U,3)=X)!$D(^VA(200,DA,"VOLD",X)) G VHELP
 W !,"Here is an example of an acceptable Verify Code: ",XUU,!
 Q
 ;
VAUTO ;Auto-get Access codes
 N XUK
 X ^%ZOSF("EON") F XUK=1:1:3 D VGEN Q:(Y=1)!($D(DIRUT))
 Q
 ;
VGEN ;Generate a VERIFY code
 S XUU=$$VC^XUS4 S (X,XUH)=$$EN^XUSHSH(XUU) I ($P($G(^VA(200,DA,0)),U,3)=X)!$D(^VA(200,DA,"VOLD",X)) G VGEN
 D CLR W "The new VERIFY CODE is: ",XUU,"   This is ",XUK," of 3 tries."
 D YN
 Q
YN ;Ask if want to keep
 N DIR
 S Y=1,DIR(0)="YA",DIR("A")=" Do you want to keep this one? ",DIR("B")="YES",DIR("?",1)="If you don't like this code, we can auto-generate another.",DIR("?")="Remember you only get 3 tries!"
 S:XUK=3 DIR("A")="This is your final choice. "_DIR("A")
 D ^DIR Q:(Y=1)!$D(DIRUT)  I XUK=2 W !,"O.K. You'll have to keep the next one!",! H 2
 I (XUK=3)&(Y'=1) W !,"Lets stop and you can try later." H 3 D DIRUT
 D CLR
 Q
 ;
OUT ;
 K DUOUT S:$D(DIRUT) DUOUT=1
 X ^%ZOSF("EON") W !
 K DIR,DIRUT,XUKO,XUAUTO,XUU,XUH,XUK,XUI S X=""
 Q
 ;
CHKCUR() ;Check user knows current code, Return 1 if OK to continue
 Q:DA'=DUZ 1 ;Only ask user
 Q:$P($G(^VA(200,DA,.1)),U,2)="" 1 ;Must have an old one
 S XUK=0 D CLR
CHK1 W "Please enter your CURRENT verify code: " D GET Q:$D(DIRUT) 0
 I $P(^VA(200,DA,.1),U,2)=$$EN^XUSHSH(X) Q 1
 D CLR W "Sorry that is not correct!",!
 S XUK=XUK+1 G:XUK<3 CHK1
 Q 0
 ;
BRCVC(XV1,XV2) ;Broker change VC, return 0 if good, '1^msg' if bad.
 N XUU,XUH,XUSVCMIN S XUSVCMIN=8
 Q:$G(DUZ)'>0 "1^Bad DUZ" S DA=DUZ,XUH=$$EN^XUSHSH(XV2)
 I $P($G(^VA(200,DUZ,.1)),"^",2)'=$$EN^XUSHSH(XV1) Q "1^Sorry that isn't the correct current code"
 S Y=$$VCHK(XV2,XUH) Q:Y Y
 D VST(XUH,0),CALL^XUSERP(DA,2)
 Q 0
 ;
SVCACCT(XUSDUZ) ;return 1^CONNECTOR PROXY if CP svc acct; 0 if not svc acct
 Q:$$ISUSERCP^XUSAP1(XUSDUZ) "1^CONNECTOR PROXY"
 Q 0
 ;
AVHLPTXT(%) ;
 Q "Enter "_$S($G(%):"6-20",+$G(XUSVCMIN):XUSVCMIN_"-20",1:"8-20")_" characters mixed alphanumeric and punctuation (except '^', ';', ':')"
 ;
 ;Left over code, Don't think it is called anymore.
 G XUS2^XUVERIFY ;All check or return user attributes moved to XUVERIFY
USER G USER^XUVERIFY
EDIT G EDIT^XUVERIFY
