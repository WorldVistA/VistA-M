XUSRB ;ISCSF/RWF - Request Broker ;02/03/10  16:07
 ;;8.0;KERNEL;**11,16,28,32,59,70,82,109,115,165,150,180,213,234,238,265,337,395,404,437,523**;Jul 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified
 Q  ;No entry from top
 ;
 ;RPC BROKER calls, First parameter is always call-by-reference
VALIDAV(RET,AVCODE) ;Check a users access
 ;Return R(0)=DUZ, R(1)=(0=OK, 1,2...=Can't sign-on for some reason)
 ; R(2)=verify needs changing, R(3)=Message, R(4)=0, R(5)=msg cnt, R(5+n)
 ; R(R(5)+6)=# div user must select from, R(R(5)+6+n)=div
 ;
 N X,XUSER,XUNOW,XUDEV,XUM,XUMSG,%1,VCCH K DUZ
 S U="^",RET(0)=0,RET(5)=0,XUF=$G(XUF,0),XUM=0,XUMSG=0,XUDEV=0
 S DUZ=0,DUZ(0)="",VCCH=0 D NOW
 S XOPT=$$STATE^XWBSEC("XUS XOPT")
 S XUMSG=$$INHIBIT() I XUMSG S XUM=1 G VAX ;Logon inhibited
 ;3 Strikes
 I $$LKCHECK^XUSTZIP($G(IO("IP"))) S XUMSG=7 G VAX ;IP locked
 ;Check type of sign-on code
 I $L(AVCODE) D
 . I $E(AVCODE,1,2)="~1" S DUZ=$$CHKASH^XUSRB4(AVCODE) Q
 . I $E(AVCODE,1,2)="~2" S DUZ=$$CHKCCOW^XUSRB4(AVCODE) Q
 . S DUZ=$$CHECKAV^XUS($$DECRYP^XUSRB1(AVCODE))
 . Q
 I DUZ'>0,$$FAIL^XUS3 D  G VAX
 . S XUM=1,XUMSG=7,X=$$RA^XUSTZ H 5 ;3 Strikes
 S XUMSG=$$UVALID^XUS() G:XUMSG VAX ;Check User
 S VCCH=$$VCVALID() ;Check VC
 I DUZ>0 S XUMSG=$$POST(1)
 I XUMSG>0 S DUZ=0,VCCH=0 ;If can't sign-on, don't tell need to change VC
 I 'XUMSG,VCCH S XUMSG=12 D SET^XWBSEC("XUS DUZ",DUZ) ;Need to change VC
VAX S:XUMSG>0 DUZ=0 ;Can't sign-on, Clear DUZ.
 D:DUZ>0 POST2
 S RET(0)=DUZ,RET(1)=XUM,RET(2)=VCCH,RET(3)=$S(XUMSG:$$TXT^XUS3(XUMSG),1:""),RET(4)=0
 K DUZ("CCOW")
 Q
 ;
NOW S U="^",XUNOW=$$NOW^XLFDT(),DT=$P(XUNOW,".")
 Q
 ;
INTRO(RET) ;Return INTRO TEXT.
 D INTRO^XUS1A("RET")
 Q
 ;
VCVALID() ;Return 1 if the Verify code needs changing.
 Q:'$G(DUZ) 1
 Q:$P($G(^VA(200,DUZ,.1)),U,2)="" 1 ;VC is empty
 Q:$P(^VA(200,DUZ,0),U,8)=1 0 ;VC never expires
 N XUSER D USER^XUS(DUZ)
 Q $$VCHG^XUS1
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
SHOWPOST() ;EF. Check if should send the POST SIGN-ON msg.
 Q +$P($G(^XTV(8989.3,1,"XWB")),"^",2)
 ;
POST(CVC) ;Finish setup partition, I CVC don't log yet
 N X,XUM,XUDIV S:$D(IO)[0 IO=$I S IO(0)=IO
 K ^UTILITY($J),^TMP($J)
 I '$D(XUSER(0)),DUZ D USER^XUS(DUZ)
 S XUM=$$USER^XUS1A Q:XUM>0 XUM ;User can't sign on for some reason.
 S RET(5)=0 ;The next line sends the post sign-on msg
 F %=1:1 Q:'$D(XUTEXT(%))  S RET(5+%)=$E(XUTEXT(%),2,256),RET(5)=%
 I '$$SHOWPOST S RET(5)=0 ;This line stops the sending/display of the msg.
 D:'$G(CVC) POST2
 Q 0
 ;
POST2 ;Finish User Setup for silent log-on
 D:'$D(XUNOW) NOW
 D DUZ^XUS1A,SAVE^XUS1,LOG^XUS1,ABT^XQ12
 D KILL^XWBSEC("XUS XOPT"),CLRFAC^XUS3($G(IO("IP"))) ;p265
 D SETTIME^XWBTCPM() ;Set normal Broker time-out
 S DTIME=$$DTIME^XUP(DUZ) ;See DTIME set for user
 K:$G(XWBVER)<1.106 XQY,XQY0 ;Delete the sign-on context.
 K XUTEXT,XOPT,XUEON,XUEOFF,XUTT,XUDEV,XUSER
 Q
 ;
INHIBIT() ;Is Logon to this system Inhibited?
 I $$INHIB1() Q 1
 I $$INHIB2() Q 2
 Q 0
 ;
INHIB1() ;The LOGON check
 I $G(^%ZIS(14.5,"LOGON",XQVOL)) Q 1
 Q 0
 ;
INHIB2() ;The Max User Check
 I $D(^%ZOSF("ACTJ")) X ^("ACTJ") I $P(XUVOL,U,3),($P(XUVOL,U,3)'>Y) Q 2
 Q 0
 ;
LOGOUT ;Finish logout of user.
 N XU1
 D CLEARALL^XWBDRPC(.XU1)
 ;Remove CCOW sign-on data
 S HDL=$G(^XUTL("XQ",$J,"HDL")) I $L(HDL) D
 . K ^XTMP(HDL,"JOB",$J)
 . I $O(^XTMP(HDL,"JOB",0))="" K ^XTMP(HDL)
 ;
 D BYE^XUSCLEAN,XUTL^XUSCLEAN ;Mark the sign-on log, File cleanup.
 Q
 ;D1,D2 are place holders for now
SETUP(RET,XWBUSRNM,ASOSKIP,D2) ;sets up environment for GUI signon
 N X1 K DUZ
 S XWBUSRNM=$G(XWBUSRNM),ASOSKIP=$G(ASOSKIP)
 I $L($G(XWBTIP)) S IO("IP")=XWBTIP
 S IO("CLNM")=$$LOW^XLFSTR($G(XWBCLMAN)) D ZIO^%ZIS4
 ;Setup needed variables
 D SET1^XUS(0),SET^XWBSEC("XUS XOPT",XOPT) ;p265
 ;I '$D(IO("HOME")) S %ZIS="0H",IOP="NULL" D ^%ZIS ;Setup NULL as the home device
 D SAVE^XUS1 ;save the home device
 ;0=server name, 1=volume, 2=uci, 3=device, 4=# attempts, 5=skip signon-screen,6=Domain Name, 7=Production (0=no, 1=Yes)
 S RET(0)=$P(XUENV,U,3),RET(1)=$P(XUVOL,U),RET(2)=XUCI
 S RET(3)=$I,RET(4)=$P(XOPT,U,2),RET(5)=0
 S RET(6)=$G(^XMB("NETNAME")) ;DBIA #1131
 S RET(7)=$$PROD^XUPROD ;Tell if production.
 S X1=$$INHIBIT() I X1 S XWBERR=$S(X1=1:"Logons Inhibited",1:"Max Users") Q  ;p523
 ; Code for DBA Capri Type Program
 I (+XWBUSRNM<-30),$$CHKUSER^XUSBSE1(XWBUSRNM) S RET(5)=1 D POST2 Q  ;p523 BSE CHANGE
 ; End of Code for DBA Capri Program
 ;Auto sign-on check only for Broker v1.1
 I $G(ASOSKIP) S XQXFLG("ASO")=1 ;Skip the ASO check, Not for VISITORS p523
 I $G(XWBVER)<1.1 S XQXFLG("ZEBRA")=-1 ;Disable for v1.0
 I $L(IO("CLNM")),'$G(DUZ) S DUZ=$$AUTOXWB^XUS1B() ;Only check when 1.1 CL.
 I $G(DUZ)>0 D  ;p523
 . I '$D(XUSER(0)),DUZ D USER^XUS(DUZ)
 . N %T S %T=$$USER^XUS1A I %T S DUZ=0 Q
 . D NOW,POST2 S RET(5)=1
 Q
 ;
OWNSKEY(RET,LIST,IEN) ;Does user have Key
 N I,K S I=""
 I $G(IEN)'>0 S IEN=$G(DUZ)
 I $G(IEN)'>0 S RET(0)=0 Q
 I $O(LIST(""))="" S RET(0)=$$KCHK(LIST,IEN) Q
 F  S I=$O(LIST(I)) Q:I=""  S RET(I)=$$KCHK(LIST(I),IEN)
 Q
 ;
KCHK(%,IEN) ;Key Check
 S:$G(IEN)'>0 IEN=$G(DUZ) Q $S($G(IEN)>0:$D(^XUSEC(%,IEN)),1:0)
 ;
ALLKEYS(RET,IEN,FLG) ;Return ALL or most KEYS that a user has.
 N I,J,K,L K ^TMP("XU",$J)
 S RET=$NA(^TMP("XU",$J))
 S:'$D(IEN) IEN=DUZ I IEN'>0 S @RET@(0)=-1 Q
 S I=0,L=0
 F  S I=$O(^VA(200,IEN,51,I)) Q:I'>0  S K=$G(^DIC(19.1,I,0)) D
 . Q:'$P(K,U,5)  ;Check 'Send to J2EE' field.
 . S L=L+1,@RET@(L,0)=$P(K,U,1)
 . Q
 Q
 ;
AVHELP(RET) ; send access/verify code instructions.
 S RET(0)=$$AVHLPTXT^XUS2()
 Q
 ;
OPTACCES(RET,USER,OPTIONS,MODE) ;Checks or sets user's access for passed in options
 S MODE="CHECK" ;only CHECK mode supported for now
 N I S I=""
 I $G(USER)'>0 S RET(0)=0 Q
 F  S I=$O(OPTIONS(I)) Q:I=""  S RET(I)=$$CHK^XQCS(USER,OPTIONS(I))=1
 Q
 ;
CHECKAV(AVC) ;SR. EF. to check an A/V code, Separate w/ ";", return IEN or 0
 N XUF,XUSER S XUF=0,U="^"
 Q $$CHECKAV^XUS(AVC)
