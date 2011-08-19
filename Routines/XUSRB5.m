XUSRB5 ;SFISC/STAFF - FATKAT and KAJEE support ;09/08/2005
 ;;8.0;KERNEL;**361**;Jul 10, 1995;Build 1
 Q
 ;All this code is run under an APPLICATION PROXY user.
FATKAAT1(RET,AVCODE,CLIENTIP) ;Get division list via proxy
 ;Use AVcode to find user, Return data from VALIDAV plus DIVGET
 N DUZ ;Protect caller
 N %,X,CCOW,IEN,XUCI,XQVOL,XUVOL,XUTEXT,DIV
 S CLIENTIP=$G(CLIENTIP,$G(IO("IP"))) S:'$L(CLIENTIP) CLIENTIP="127.0.0.1" ;Use loopback if don't have real one.
 D XUVOL^XUS
 D VALIDAV(AVCODE,.DIV,CLIENTIP) ;DIVGET is done in here
 S %=RET(5)+6,CCOW=$D(DUZ("CCOW"))
 Q:'RET(0)
 I CCOW D  Q
 . S RET(%+1)=1,RET(%+2)=DUZ(2)_"^"_$$NS^XUAF4(DUZ(2))_"^1"
 . Q
 I 'CCOW F X=0:1:DIV D
 . S RET(%+X)=DIV(X)
 K DUZ("CCOW")
 Q
 ;
DIVGET(XUDIV,IEN) ;Get Division data
 N %,X
 S XUDIV=0,%=$$CHKDIV^XUS1(.XUDIV) ;Get users div.
 I 'XUDIV,(%>0)&($P(%,U,2)'>0) D
 . S DUZ(2)=+% ;Set users default div.
 . S XUDIV=1,XUDIV(1)=DUZ(2)_"^"_$$NS^XUAF4(DUZ(2))_"^1"
 I 'XUDIV,'% D
 . S DUZ(2)=+$$KSP^XUPARAM("INST")
 . S XUDIV=1,XUDIV(1)=DUZ(2)_"^"_$$NS^XUAF4(DUZ(2))_"^1"
 ;
 S %=0 D  S RESULT(0)=XUDIV
 . ;RET(%) is divison array eg. ien;station name;station#
 . F  S %=$O(XUDIV(%)) Q:(%'>0)  D
 .. S XUDIV(%)=$P(XUDIV(%),U,1,3)_U_(+$P(XUDIV(%),U,4))
 S XUDIV(0)=XUDIV
 Q
 ;
VALIDAV(AVCODE,DIV,CLIP) ;Check a users access
 ;Return R(0)=DUZ, R(1)=(0=OK, 1,2...=Can't sign-on for some reason)
 ; R(2)=verify needs changing, R(3)=Message, R(4)=0, R(5)=msg cnt, R(5+n)
 ; R(R(5)+6)=# div user must select from, R(R(5)+6+n)=div
 ;
 N X,XUSER,XUF,XUNOW,XUDEV,XUM,XUMSG,%1,VCCH
 S U="^",RET(0)=0,RET(1)=0,RET(2)=0,RET(3)="",RET(4)=0,RET(5)=0
 S XUF=$G(XUF,0),XUM=0,XUMSG=0,XUDEV=0
 S DUZ=0,DUZ(0)="",VCCH=0 D NOW
 D XOPT^XUS
 S XUMSG=$$INHIBIT^XUSRB() I XUMSG S XUM=1 G VAX ;Logon inhibited
 ;3 Strikes, Put J2EE server IP in as Terminal server.
 I $$LKCHECK^XUSTZIP($G(CLIP)) S XUMSG=7 G VAX ;IP locked
 ;Only allow A/V, CCOW sign-on code
 I $L(AVCODE) S DUZ=$$CHECKAV^XUS($$DECRYP^XUSRB1(AVCODE))
 D DIVGET(.DIV) ;Get DIV now
 I DUZ'>0 S XUM=1,XUMSG=4 D  H 2 G VAX ;Bad AV code
 . S X=$$FAIL^XUS3(CLIP) ;Check Lockout
 S XUMSG=$$UVALID^XUS() G:XUMSG VAX ;Check User
 S VCCH=$$VCVALID^XUSRB() ;Check VC
 I DUZ>0 S XUMSG=$$POST(1)
 I XUMSG>0 S DUZ=0,VCCH=0 ;If can't sign-on, don't tell need to change VC
 I 'XUMSG,VCCH S XUMSG=12 ;Need to change VC
VAX S:XUMSG>0 DUZ=0 ;Can't sign-on, Clear DUZ.
 S RET(0)=DUZ,RET(1)=XUM,RET(2)=VCCH,RET(3)=$S(XUMSG:$$TXT^XUS3(XUMSG),1:""),RET(4)=0
 Q
 ;
CVC(RET,XU1) ;change VC, Return 0 = success
 N XU2,XU3,XU4 S DUZ=$G(DUZ),RET(0)=99,XU4=$$STATE^XWBSEC("XUS DUZ") S:(DUZ=0)&(XU4>0) DUZ=XU4 Q:DUZ'>0
 S U="^",XU2=$P(XU1,U,2),XU3=$P(XU1,U,3),XU1=$P(XU1,U)
 S XU1=$$DECRYP^XUSRB1(XU1),XU2=$$DECRYP^XUSRB1(XU2),XU3=$$DECRYP^XUSRB1(XU3)
 S XU3=$$BRCVC^XUS2(XU1,XU2),RET(0)=+XU3,RET(1)=$P(XU3,U,2,9)
 I XU3>0 S DUZ=0 ;Clean-up if not changed.
 I 'XU3,XU4 D KILL^XWBSEC("XUS DUZ"),POST2
 Q
 ;
POST(CVC) ;Finish setup partition, I CVC don't log yet
 N X,XUM,XUDIV
 I '$D(XUSER(0)),DUZ D USER^XUS(DUZ)
 S XUM=$$USER Q:XUM>0 XUM ;User can't sign on for some reason.
 S RET(5)=0 ;The next line sends the post sign-on msg
 F %=1:1 Q:'$D(XUTEXT(%))  S RET(5+%)=$E(XUTEXT(%),2,256),RET(5)=%
 I '$$SHOWPOST^XUSRB S RET(5)=0 ;This line stops the send/display of the msg.
 D:'$G(CVC) POST2
 Q 0
 ;
POST2 D:'$D(XUNOW) NOW
 D DUZ^XUS1A,SAVE^XUS1,LOG^XUS1,ABT^XQ12
 D KILL^XWBSEC("XUS XOPT"),CLRFAC^XUS3($G(IO("IP"))) ;p265
 K XUTEXT,XOPT,XUEON,XUEOFF,XUTT,XUDEV,XUSER
 Q
 ;
NOW ;
 S U="^",XUNOW=$$NOW^XLFDT(),DT=$P(XUNOW,".")
 Q
USER() ;
 N %B,%E,%T,I1,X1,X2
 K XUTEXT
 S XUTEXT=0,DUZ(2)=$G(DUZ(2),0)
 F I=0:0 S I=$O(^XTV(8989.3,1,"POST",I)) Q:I'>0  D SET("!"_$G(^(I,0)))
 D SET("!"),XOPT^XUS
 S %H=$P($H,",",2)
 D SET("!Good "_$S(%H<43200:"morning ",%H<61200:"afternoon ",1:"evening ")_$S($P(XUSER(1),U,4)]"":$P(XUSER(1),U,4),1:$P(XUSER(0),U,1)))
 S I1=$G(^VA(200,DUZ,1.1)),X=(+I1_"0000")
 I X D SET("!     You last signed on "_$S(X\1=DT:"today",X\1+1=DT:"yesterday",1:$$FMTE^XLFDT(X,"1D"))_" at "_$E(X,9,10)_":"_$E(X,11,12))
 I $P(I1,"^",2) S I=$P(I1,"^",2) D SET("!There "_$S(I>1:"were ",1:"was ")_I_" unsuccessful attempt"_$S(I>1:"s",1:"")_" since you last signed on.")
 I $P(XUSER(0),U,12),$$PH(%H,$P(XUSER(0),U,12)) Q 17 ;Time frame
 I +$P(XOPT,U,15) S %=$P(XOPT,U,15)-($H-XUSER(1)) I %<6,%>0 D SET("!     Your Verify code will expire in "_%_" days")
 ;Report new Mail
 N XUXM S %=$$NU^XMGAPI4(1,1,"XUXM") I $G(XUXM) F %=0:0 S %=$O(XUXM(%)) Q:%'>0  D SET("!"_XUXM(%))
 ;S:$P(XOPT,"^",5) XUTT=1 S DTIME=$P(XOPT,U,10)
 ;Check Multiple Sign-on allowed, X1 signed on flag, X2 0=No,1=Yes,2=1IP
 ;S X1=$P($G(^VA(200,DUZ,1.1)),U,3),X2=$P(XOPT,U,4)
 ;I 'X2,X1 Q 9 ;Multi Sign-on not allowed
 ;I X2=2 D  Q:%B>0 %B ;Only from one IP
 ;. S %B=0 I '$D(IO("IP")) S:X1 %B=9 Q  ;Can't tell IP, 
 ;. S X1=$$COUNT(DUZ,IO("IP")),%B=$S(X1<0:9,(X1+1)>$P(XOPT,U,19):9,1:0)
USX ;S $P(^VA(200,DUZ,1.1),U,3)=1
 ;Call XQOR to handle SIGN-ON protocall.
 ;N XUSER,XUSQUIT ;Protect ourself.
 ;S DIC="^DIC(19,",X="XU USER SIGN-ON",XUSQUIT=0
 ;D EN^XQOR
 Q 0 ;If protocol set XUSQUIT will stop sign-on.
 ;
SET(V) ;Set into XUTEXT(XUTEXT), Also Called from XU USER SIGN-ON protocol.
 S XUTEXT=$G(XUTEXT)+1,XUTEXT(XUTEXT)=V
 Q
 ;
PH(%T,%R) ;Check Prohibited time for R/S
 N MSG S MSG=$$PROHIBIT(%T,%R)
 I MSG S XUM(0)=$P(MSG,U,2) Q 1
 D SET("!"),SET("! "_$$EZBLD^DIALOG(30810.62)_" "_$P(MSG,U,2))
 Q 0
 ;
PROHIBIT(%T,%R) ;See if a prohibited time, (Time from $H, restrict range)
 N XMSG,%B,%E
 S %T=%T\60#60+(%T\3600*100),%B=$P(%R,"-",1),%E=$P(%R,"-",2)
 S XMSG=$P($$FMTE^XLFDT(DT_"."_%B,"2P")," ",2,3)_" "_$$EZBLD^DIALOG(30810.61)_" "_$P($$FMTE^XLFDT(DT_"."_%E,"2P")," ",2,3)
 I $S(%E'<%B:%T'>%E&(%T'<%B),1:%T>%B!(%T<%E)) Q "1^"_XMSG ;No
 Q "0^"_XMSG
 ;
SET1(FLAG) ;Setup for FATKAAT
 N %
 S U="^"
 D XUVOL^XUS,XOPT^XUS
 S XUDEV=0,XUIOP=""
 D GETFAC^XUS3($G(IO("IP")))
 S %=$P(XOPT,U,14)
 Q
SET2() ;EF. Return error code
 N %,X
 S XUNOW=$$HTFM^XLFDT($H),DT=$P(XUNOW,".")
 K DUZ,XUSER
 S (DUZ,DUZ(2))=0,(DUZ(0),DUZ("AG"),XUSER(0),XUSER(1),XUTT,%UCI)=""
 S %=$$INHIBIT^XUSRB() I %>0 Q %
 S DTIME=600
 I '$P(XOPT,U,11),$D(^%ZIS(1,XUDEV,90)),^(90)>2800000,^(90)'>DT Q 8
 I $D(XRT0) S XRTN="XUS" D T1^%ZOSV
 Q 0
 ;
