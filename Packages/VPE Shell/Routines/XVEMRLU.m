XVEMRLU ;DJB/VRR**RTN LBRY - Utilities ;2017-08-15  2:03 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
ADD(RTN) ;Does user want to sign out current rtn?
 Q:$G(RTN)']""
 Q:'$$CHKLBRY(1,"L")
 Q:$D(^XVV(19200.11,"B",RTN))  ;...Already signed out
 ;
 W !!,"--- LIBRARY ---",!
 Q:$$ASK^XVEMKU("Sign out this routine")'="Y"
 ;
 NEW %,%Y,%DT,D,D0,DA,DDH,DI,DIC,DIE,DQ,DR,DZ,X,Y
 NEW CNT,XVVPKGI,XVVUSERI,XVVUSERN
 ;
 D GETID^XVEMRLI
 D GETUSER() Q:XVVUSERI'>0
 D CREATE^XVEMRLO(RTN)
 Q
 ;
CHKLBRY(NOMSG,MOD) ;Check Library environment
 ;Return: 0=Not ok
 ;        1=Ok
 ;NOMSG=1 Don't display messages
 ;MOD: L=Library, V=Versioning
 ;
 S NOMSG=$G(NOMSG)
 S MOD=$G(MOD)
 ;
 I '$G(XVV("ID")) D  Q 0 ;.....................VPE ID not defined
 . I 'NOMSG D MSG(3)
 I '$D(DUZ)!('$D(DUZ(0))) D  Q 0 ;.............DUZ/DUZ(0) not defined
 . I 'NOMSG D MSG(8)
 ;
 I MOD="L",'$D(^XVV(19200.11)) D  Q 0 ;........No Lbry file
 . I 'NOMSG D MSG(2)
 I MOD="L",$G(^XVV(19200.11,"A-STATUS"))'="ON" D  Q 0 ;Lbry inactive
 . I 'NOMSG D MSG(1)
 I MOD="V",'$D(^XVV(19200.112)) D  Q 0 ;.......No Ver file
 . I 'NOMSG D MSG(10)
 I MOD="V",$G(^XVV(19200.112,"A-STATUS"))'="ON" D  Q 0 ;Ver inactive
 . I 'NOMSG D MSG(9)
 Q 1
 ;
GETUSER(NOMSG) ;Identify current user
 ;Return: XVVUSERI=IEN
 ;        XVVUSERN=Name
 ;NOMSG=1 Don't display messages
 NEW Y
 S (XVVUSERI,XVVUSERN)=""
 S XVVUSERI=$O(^XVV(19200.111,"ID",XVV("ID"),""))
 I 'XVVUSERI D  Q
 . I '$G(NOMSG) D MSG(5)
 S XVVUSERN=$P($G(^XVV(19200.111,XVVUSERI,0)),U,1)
 Q
 ;
GETBY(IEN) ;Identify who signed out rtn
 ;Return: XVVBYI: IEN
 ;        XVVBYN: Name
 ;IEN=Internal number of VPE RTN LBRY entry
 S (XVVBYI,XVVBYN)=""
 Q:'$G(IEN)
 S XVVBYI=$P($G(^XVV(19200.11,IEN,0)),U,13)
 I XVVBYI S XVVBYN=$P($G(^XVV(19200.111,XVVBYI,0)),"^",1)
 Q
 ;====================================================================
LIBRARY(RTN) ;Check if Routine is signed out
 Q:'$$CHKLBRY(1)  Q:$G(RTN)']""  Q:'$D(^XVV(19200.11,"B",RTN))
 NEW FLAGQ,IEN,XVVBYI,XVVBYN,XVVUSERI,XVVUSERN
 S FLAGQ=0
 S IEN=$O(^XVV(19200.11,"B",RTN,""))
 D GETBY(IEN) Q:XVVBYI=""
 D GETUSER(1)
 I XVVUSERI=XVVBYI Q  ;...If user signed out rtn, don't display msg
 W $C(7),@XVV("IOF"),!,"*** WARNING ***"
 W !!,"This routine is currently SIGNED OUT of the Routine Library."
 I XVVBYN]"" W !,"Signed out by: ",XVVBYN
 D PAUSE^XVEMKU(2,"P")
 Q
 ;
ONOFF ;Turn Rtn Lbry/Versioning ON/OFF
 ;
 I '$D(^XVV(19200.11)) D  Q  ;...No Lbry file
 . W !,"The ROUTINE LBRY files are not in this UCI.",!
 ;
 I %1="ON" D  Q
 . I %2=""!(%2["L")!(%2["l") D  ;........Turn ON Library
 .. S ^XVV(19200.11,"A-STATUS")="ON"
 .. W !,"Routine Library is now ACTIVE!",!
 . I %2=""!(%2["V")!(%2["v") D  ;........Turn ON Versioning
 .. S ^XVV(19200.112,"A-STATUS")="ON"
 .. W !,"Routine Versioning is now ACTIVE!",!
 ;
 I %1="OFF" D  Q  ;..............Turn OFF
 . S ^XVV(19200.11,"A-STATUS")="OFF"
 . S ^XVV(19200.112,"A-STATUS")="OFF"
 . W !,"Routine Library/Versioning are NO LONGER ACTIVE!",!
 Q
 ;
INIT ;Initialize. Return XVVUSERI & XVVUSERN or FLAGQ
 S U="^"
 Q:'$$CHKLBRY()
 D GETUSER() Q:FLAGQ
 I '$D(IOST) D MSG(6) Q
 S U="^" D IO^XVEMKY
 Q
 ;
LOCK ;Lock file
 L +^XVV(19200.11):1
 E  D MSG(7) Q
 Q
 ;
ERROR ;Error trap
 NEW ZE
 S @("ZE="_XVV("$ZE"))
 L -^XVV(19200.11)
 W !!,"An error has occurred"
 W !,"ERROR: ",ZE
 D PAUSE^XVEMKU(2,"P")
 Q
 ;===================================================================
MSG(NUM) ;Messages. NUM=Subrtn #
 Q:$G(NUM)'>0
 Q:$G(NOMSG)
 S FLAGQ=1
 W $C(7),!!
 D @NUM
 D PAUSE^XVEMKU(2,"P")
 Q
1 W "The Routine Library is currently INACTIVE. See 'Help' option." Q
2 W "The ROUTINE LBRY files are not in this UCI." Q
3 W "Your VPE ID is not defined." Q
5 W "You must be entered in VPE RTN LBRY PERSON file, with VPE ID filled in." Q
6 W "Your IO variables are not defined. D ^XUP." Q
7 W "Someone else is editing the Routine Library. Try later." Q
8 W "DUZ or DUZ(0) is not defined." Q
9 W "Routine Versioning is currently INACTIVE. See 'Help' option." Q
10 W "The ROUTINE VERSION file is not in this UCI." Q
 Q
