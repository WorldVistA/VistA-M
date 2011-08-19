XUS3 ;SF-ISC/STAFF - SIGNON ;5/31/2006
 ;;8.0;KERNEL;**32,149,265,419**;Jul 10, 1995;Build 5
TT ;Terminal Type select
 Q:$D(XUIOP(1))
 S DIC("B")=$S($P(XUIOP,";",2)]"":$P(XUIOP,";",2),$D(^%ZIS(1,XUDEV,"SUBTYPE")):+^("SUBTYPE"),1:"C-VT100")
 S DIC="^%ZIS(2,",DIC(0)="AEMQO",DIC("S")="I $P(^(0),U,2)" D ^DIC K DIC Q:Y<1
 ;M/11 & M/VX sites may want to remove the ; from the next line.
 ;S J=$P(Y,U,2) I $D(^%IS(0,"SUB",J)) S $P(^%IS($I,1),U,3)=J
 S ^VA(200,DUZ,1.2)=+Y,$P(XUIOP,";",2)=$P(Y,U,2) Q
 ;
WAIT ;** doesn't work with virtual device
 Q:'$L(IO("ZIO"))
 S X=XUT,XUT=0,H=$P(^DISV("XU",XUDEV),U,2),T=$P(H,",",2)+$P(XOPT,U,3),H=T\86400+H,T=T#86400 Q:H<$H  I +$H=H Q:$P($H,",",2)'<T
LOCK S XUT=X,XMB="XUSLOCK",XMB(1)=$I,XMB(2)=+XUT,XMB(3)=$P(XUVOL,U,1)_","_XUCI D ^XMB
Q Q
 ;
SEC ;Check device's security and time lock.
 Q:$P(XOPT,"^",11)  ;Bypass device lockout
 N %A,%B,%H,Y
 S %A=$P(XUSER(0),U,4),%B=0
 I $G(^%ZIS(1,XUDEV,95))]"",%A'="@" D
 . S %H=$P(^(95),U),%B=1 F Y=1:1:$L(%H) I %A[$E(%H,Y) S %B=0
 I %B D  Q
 . S XMB="XUSECURITY",XMB(1)=$P(XUSER(0),U,1),XMB(2)=$I,XMB(3)=^(95),XMB(4)=%A D ^XMB
 . S XUM=10
 . Q
 S %A=$P($G(^%ZIS(1,XUDEV,"TIME")),U) Q:%A=""
 S Y=$P($H,",",2),%H=Y\60#60+(Y\3600*100),Y=$P(%A,"-",2)
 I Y'<%A G NOPE:%H'>Y&(%H'<%A) Q
 Q:%H'>%A&(%H'<Y)
NOPE S XMB="XUSTIME",XMB(1)=$I,XMB(2)=$P(XUSER(0),U,1),XMB(4)=%A D ^XMB
 S XUM=13,XUM(0)=%A
 Q
 ;
H3(%) ;Convert $H to seconds.
 Q 86400*%+$P(%,",",2)
 ;
GETFAC(IP) ;Set XUFAC from saved value,  Failed Access Count
 I $D(XUFAC) Q
 S XUFAC=0 ;Use default.
 Q:'$L(IP)
 N X,R
 S X=$$FINDFAC(IP)
 ;Clear count if lockout time has passed
 I X>0 D
 . L +^XUSEC(4,X,0):5
 . S R=$G(^XUSEC(4,X,0))
 . L -^XUSEC(4,X,0)
 . ;Use 30 seconds as a balance. Not lock user out, stop scripts.
 . I ($$H3($P(R,"^",3))+30)<$$H3($H) D CLRFAC(IP) Q  ;Exit without changing XUFAC
 . S XUFAC=$P(R,U,2)
 . Q
 ;If IP is a TS, if should lock return 4 else 0.
 I $$TS S XUFAC=$S($$IPCHECK^XUSTZIP(IP):4,1:0)
 Q
 ;
TS() ;Is IP a Terminal Server (check TSCHK in XUSTZIP).
 Q $L($O(^XTV(8989.3,1,405.2,"B",IP,0)))
 ;
FINDFAC(IP) ;Find the entry
 N I
 I $G(XUFAC(1))>0,$D(^XUSEC(4,XUFAC(1),0)) Q XUFAC(1)
 K XUFAC(1)
 Q:'$L(IP) 0
 S I=$O(^XUSEC(4,"B",IP,0))
 I I>0 S XUFAC(1)=I
 Q I
SETFAC(IP) ;Set the value of Failed Access atempts
 N FDA,IEN,I
 I $G(XUFAC(1)),'$D(^XUSEC(4,XUFAC(1),0)) K XUFAC(1)
 S I=$S($G(XUFAC(1)):XUFAC(1),1:"?+1")_","
 S FDA(3.084,I,.01)=IP,FDA(3.084,I,2)=XUFAC,FDA(3.084,I,3)=$H
 D UPDATE^DIE("S","FDA","IEN")
 I $G(IEN(1))>0 S XUFAC(1)=IEN(1)
 Q
 ;
CLRFAC(IP) ;Clear FAC from the global
 N DA,DIK,I
 S I=$$FINDFAC(IP) Q:I'>0
 S DA=I,DIK="^XUSEC(4," D ^DIK
 Q
 ;
FAIL(IP) ;If user fails logon, Call to inc XUFAC
 ; and check if time to lock.  IP is optional.
 S IP=$$IP^XUSTZIP
 D GETFAC(IP) I '$L($G(XOPT)) D XOPT^XUS
 S XUFAC=XUFAC+1 D SETFAC(IP) ;Fail count
 Q XUFAC'<$P(XOPT,U,2)
 ;
NO() ;Fail, R/S entry. Reference to XGWIN has been removed.
 N XUEXIT,% ;Gets set in $$TXT, If 1 halt process.
 W !,"Device: ",$I,!!,$$TXT(XUM),!
 S %=$$FAIL($G(IO("IP"))),XUEXIT=XUEXIT!$D(XUHALT)
 I ('XUEXIT)&'% Q 0 ;Continue to try
 I 'XUEXIT&(XUM-7) W !,$$TXT(7) ;Tell user we are locking device
 ;XUF handled in XUSTZ
 I 'XUEXIT D ^XUSTZ
 H 4
 Q XUEXIT
 ;
TXT(%) ;Call by R/S and Broker
 N XU1
 ;This string tells if a error code should HALT process.
 S:'$D(XUEXIT) XUEXIT=$E("111000010100100000000",%)
 S XU1=30810+(%/100)
 S %=$$EZBLD^DIALOG(XU1) I %["|" S %=$P(%,"|",1)_$G(XUM(0))_$P(%,"|",2)
 K XUM(0)
 Q %
 ;All error messages are now in the DIALOG file.
 ;Message numbers are 30810.01 to 30810.99
ZZ ;;Halt;Error Messages
1 ;;1;No Signons.
2 ;;1;Maximum users.
3 ;;1;Bad device.
4 ;;0;Invalid A/V code.
5 ;;0;No Access for User.
6 ;;0;Invalid device password.
7 ;;0;Device locked.
8 ;;1;This device is out of service.
9 ;;0;*** MULTIPLE SIGN-ONS NOT ALLOWED ***
10 ;;1;You don't have access to this device!
11 ;;0;Access code terminated.
12 ;;0;Change VERIFY code.
13 ;;1;Time limited device.
14 ;;0;Bad UCI!
15 ;;0;Bad Routine.
16 ;;0;No PRIMARY MENU.
17 ;;0;User Time limited.
18 ;;0;User lockout
19 ;;0;Signon not allowed as you have required forms to sign in terminal mode.
20 ;;0;Client IP address not setup.
21 ;;0;Null Verify code
