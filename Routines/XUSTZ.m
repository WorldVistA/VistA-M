XUSTZ ;SF/RWF - Security Twilight Zone ;11/25/08  15:21
 ;;8.0;KERNEL;**36,180,265,514**;Jul 10, 1995;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;Called from XUS3 for R/S
 N XUSTZ,DUOUT,SETLK,TMOUT
 ;Only send the bulletin once.
 I '$D(XUSTZ) S XUSTZ=1 D SB
 ;Set the lockout time
 S TMOUT=$$LKTME
 ;Check and Lock
 W !!,?10,$$RA
 ;If because device is locked only lock till "Lock till time"
 I $$LKCHECK^XUSTZIP() S TMOUT=$$LKWAIT^XUSTZIP(TMOUT)
 ;
 ;Make user wait for timeout.
 F  D ASK Q:$D(DUOUT)
 D CLEAN^XUSTZIP
 I XUF D FILE
 W !!,$$EZBLD^DIALOG(30810.41)
 K ^DISV("XU",IOS)
 Q  ;Back to XUS3
 ;
RA(IP) ;EF. Entry point for Remote Access (Broker/Vistalink) and R/S
 ;This is used to Lock the User or IP.  Returns Text.
 N TXT,TMOUT
 S TXT="",TMOUT=$$LKTME,IP=$$IP^XUSTZIP,XUFAC=+$G(XUFAC)
 D FILE ;File in FAA, Do now before user can disconnect
 D CLEAN^XUSTZIP
 ;Check if Lock the user
 I $G(XUF(.3))>0,$$LKUSER(XUF(.3)) S TXT=$$EZBLD^DIALOG(30810.43,TMOUT)
 ;Check and LOCK the IP.
 I '$T,$$IPCHECK^XUSTZIP(IP) D
 . S SETLK=$$LKSET^XUSTZIP(IP)
 . I SETLK>0 S TXT=$$EZBLD^DIALOG(30810.44)
 . Q
 Q TXT
 ;
ASK N XUM
 W !!!,$$EZBLD^DIALOG(30810.42)
 X XUEOFF S %="",XUM=4,XUEXIT=0,XUC="",TMOUT=$S(TMOUT>10:TMOUT,1:10)
A1 ;Let user keep trying
 W !,XUSTMP(51) S X=$$ACCEPT^XUS(TMOUT) ;Access
 Q:$D(DUOUT)  G A1:X="" ;,OK:'$D(^DISV("XU",IOS)),A1:X=""
 I X[U W "  '^' not allowed in Access Code, Use EDIT USER option." Q
 S:X[";" %=$P(X,";",2),X=$P(X,";") I XUF S %1="Access: "_X D FAC
 HANG 2
 ;
 S %1="" I %="" W !,XUSTMP(52) S X=$$ACCEPT^XUS(60),%="" ;Verify
 I XUF S %1="Verify: "_X D FAC
 HANG 2
 I XUF,XUF(.2)>50 D FILE S XUF(.2)=0,XUFAC=0
 ;I XUF,XUF(.2)>2 D FILE S XUF(.2)=0,XUFAC=0 ;used for testing
 S XUFAC=XUFAC+1,%=$$NO^XUS3
 Q
 ;
FAC G FAC^XUS
 ;
FILE ;File data into Access Atempt Log
 ;Call needs, IOS,XUVOL,XUF(.1),(.2),(.3),XUT,XUCI,IO("ZIO"),XUNOW
 ;Want to use IO("IP") in place of IO("ZIO") if we have it.
 Q:'$G(XUF)
 N XUT,ZIO S ZIO=$G(IO("ZIO")) S:$D(IO("IP")) IO("ZIO")=IO("IP")
 S X1=IOS,X2=DT F I=1:1:XUF(.2) S X=XUF(I) D EN^XUSHSHP S XUF(I)=X
 S XUT=XUFAC
 ;S XUSLNT=1,XQZ="FAAL^ZUA[MGR]" D DO^%XUCI
 D FAAL^ZUA
 F I=1:1:XUF(.2) K XUF(I)
 S XUF(.2)=0,XUFAC=0 S:$L(ZIO) IO("ZIO")=ZIO
 Q
 ;
SB ;Send the XUSLOCK bulletin
 S XMB="XUSLOCK",XMB(1)=$S($D(IO("IP")):IO("IP"),$D(IO("ZIO")):IO("ZIO"),1:$I),XMB(2)=+XUFAC,XMB(3)=ION
 D ^XMB
 Q
LKTME() ;Get Lock-out time
 I $D(XOPT) Q $P(XOPT,U,3)
 Q $P(^XTV(8989.3,1,"XUS"),U,3)
 ;
LKUSER(IEN) ;Lock user, Return: 0 not locked, 1 locked
 Q:$P($G(^XTV(8989.3,1,405)),U,4)'="y" 0
 N FDA
 ;If already locked don't change time
 S FDA=$$GET1^DIQ(200,IEN_",",202.05,"I")
 I FDA>XUNOW Q 0 ;Still Locked.
 ;If locking user clear XUFAC.
 D CLRFAC^XUS3($G(IO("IP")))
 K FDA ;Add d,h,m,s
 S FDA(200,IEN_",",202.05)=$$HTFM^XLFDT($$HADD^XLFDT($H,0,0,0,TMOUT))
 D UPDATE^DIE("","FDA")
 Q 1
