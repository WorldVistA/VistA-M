XQSRV ;SEA/MJM - Server message processor ;06/13/2003  09:27
 ;;8.0;KERNEL;**155,308**;Jul 10, 1995
 Q:'$D(X)#2
 ;
 ; 'X' to contain 4 pieces: 1. Name of option, 2. Message number
 ;  3. Name of sender, and 4-99 The subject of message.
 ;
 I $P(X,U)="XQSCHK" D ^XQSRV5 Q  ;Server to check out server options
 I $P(X,U)="XQSPING" S XQSUB=$P(X,U,4,99),XMFROM=$P(X,U,3) D ^XTSPING Q  ;PING server
 ;
 S U="^",XQX=X,(XQY,XQMSG,XQSND,XQSUB)="Unknown",XQMB="XQSERVER",(XQER,XQER1,XQ220,XQMB6,XQRES)="",(XQAUDIT,XQNOUSR)=0,(XQSUP,XQREPLY,XQMD)="N"
 S:'$D(DUZ) DUZ=.5 S:(DUZ<.5) DUZ=.5
 D GETENV^%ZOSV S XQVOL=$P(Y,U,2)
 S X="ERROR^XQSRV2",@^%ZOSF("TRAP")
 D ^XQDATE S DT=$P(%,"."),(XQLTL,ZTDTH)=%,XQDATE=%Y
 S:$D(^XTV(8989.3,1,19.3,"B",+DUZ)) XQAUDIT=1
 S XQSOP="",XQSOP=$P(XQX,U),XQMSG=$P(XQX,U,2),XQSND=$P(XQX,U,3),XQSUB=$P(XQX,U,4,99) I '$D(XMFROM) S XMFROM=XQSND
 I XQSOP'?.PUN S XQSOP=$$UP^XLFSTR(XQSOP) ;F XQI=1:1 Q:XQSOP?.PUN  S XQX=$A(XQSOP,XQI) I XQX<123,XQX>96 S XQSOP=$E(XQSOP,1,XQI-1)_$C(XQX-32)_$E(XQSOP,XQI+1,255)
 I XQSOP="?" S XQER=$T(7)_" "_$P(X,U)
 I 'XQAUDIT S XQCHK="XQSRV",XQN="" D
 .F  S XQN=$O(^XTV(8989.3,1,19.2,"B",XQN)) Q:XQN=""  S:($E(XQCHK,1,$L(XQN))=XQN) XQAUDIT=1 I XQAUDIT S XQSTART=^XTV(8989.3,1,19),XQEND=$P(XQSTART,U,3),XQSTART=$P(XQSTART,U,2) S:DT<XQSTART!(DT>XQEND) XQAUDIT=0
 .Q
 I '$L(XQSOP)!(XQSOP'?3.30UNP) S XQER=$T(1)_" "_XQSOP,XQAUDIT=1 G OUT
 ;
DIC ;Look up option, check it's type and parameters
 S X=XQSOP,DIC=19,DIC(0)="MFXZ" D ^DIC I Y<0 S XQER=$T(4)_" "_XQSOP,XQAUDIT=1 G OUT
 I 'XQAUDIT S XQN="" F XQI=0:0 S XQN=$O(^XTV(8989.3,1,19.2,"B",XQN)) Q:XQN=""  S:($E(XQSOP,1,$L(XQN))=XQN) XQAUDIT=1 I XQAUDIT S XQSTART=^XTV(8989.3,1,19),XQEND=$P(XQSTART,U,3),XQSTART=$P(XQSTART,U,2) S:DT<XQSTART!(DT>XQEND) XQAUDIT=0
 S XQY=+Y,XQY0=Y(0) I $P(XQY0,U,4)'["S" S XQER=$T(5)_" "_XQSOP G OUT
 I $P(XQY0,U,3)'="" S XQER="Out of Order: "_$P(XQY0,U,3) G OUT
 S XQ220="" S:$D(^DIC(19,+XQY,220)) XQ220=^(220)
 S XQSUP=$P(XQ220,U,5),XQREPLY=$P(XQ220,U,6)
 I XQSUP'="Y" S X=$P(XQ220,U,1) D ^XQSRV4 I Y="" S (XQAUDIT,XQNOUSR)=1,XQER=$T(10)_" "_XQMB
 S XQBUL=$S(XQNOUSR:0,1:XQMB)
 I 'XQAUDIT S:$D(^XTV(8989.3,1,19.1,"B",+XQY)) XQAUDIT=1 I XQAUDIT S XQSTART=^XTV(8989.3,1,19),XQEND=$P(XQSTART,U,3),XQSTART=$P(XQSTART,U,2) S:DT<XQSTART!(DT>XQEND) XQAUDIT=0
 S:$P(XQ220,U,4)["Y" XQAUDIT=1
 ;
CHK ;Finish checking this request out
 I '$L(XQMSG)!(XQMSG'=+XQMSG) S XQER=$T(2)_" "_XQMSG G OUT
 I '$D(^XMB(3.9,+XQMSG)) S XQER=$T(6)_" "_XQMSG G OUT
 ;
MODE ;Load, check, and employ Server Action Code
 S XQMD=$P(XQ220,U,2) I XQMD="" S XQER=$T(9)_XQSOP G OUT
 I XQMD="I" S XQER="Request for "_XQSOP_" ignored.",XQER1="  No action taken." G OUT
 G:$L(XQER) OUT
 ;
 G ^XQSRV1
 ;
OUT ;Do audit, bulletin (& reply mail), and no-user bulletin.
 D:XQAUDIT AUDIT^XQSRV1,AUDIT^XQSRV2
 G OUT^XQSRV2
 Q
 ;
MESS ;Returned in bulletins with bad parameters
1 ;;Invalid server option name specified:
2 ;;Invalid message number specified:
3 ;;Invalid message subject field specified:
4 ;;No such server option in the Option File:
5 ;;Requested option is not a server option:
6 ;;No such message number in the Message File (^XMB(3.9)):
7 ;;Invalid option name, imbedded control characters in option:
8 ;;The bulletin pointed to by this server is not in the Bulletin File (^XMB(3.6)):
9 ;;No server action code in Option File for:
10 ;;Security Violation: No active user or mail group connected to bulletin:
 Q
