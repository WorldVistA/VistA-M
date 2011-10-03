XQSRV5 ;MJM/SEA - Check out a server option server;11/9/92  9:54 AM ;01/09/2001  13:32
 ;;8.0;KERNEL;**155**;Jul 10, 1995
 ;
 ;This routine is called by the option XQSCHK.  It does various
 ;checks on a server option whose name is stored in the first
 ;line of message that has activated this program.
 ;
 ;The variable X contains 4 "^" pieces: OPTION NAME ^ MESSAGE # ^
 ;SENDER ^ MESSAGE SUBJECT
 ;
 ;
START S XQX=X,XQHERE=^XMB("NETNAME"),XQI=0,XQSRV5="",XQAUDIT=0
 D ^XQDATE S XQDATE=%Y
 S XQSTXT(XQI)="This is a reply from: "_XQHERE,XQI=XQI+1
 S XQMSG=$P(XQX,U,2),XQSND=$P(XQX,U,3),XQSUB=$P(XQX,U,4,99)
 S:'$D(XMZ) XMZ=$P(XQX,U,2) F %=1:1:5 X XMREC S %X=XMRG D CNVT S XMRG=%X Q:XMRG]""!(XMER<0)
 S XQSOP=XMRG I XMER<0!(XQSOP']"") S XQSTXT(XQI)="Can't unload name of server from message: "_XQSUB,XQI=XQI+1 G OUT
 E  S XQSTXT(XQI)="Checking server option "_XQSOP_".",XQI=XQI+1
 S XQY=$O(^DIC(19,"B",XQSOP,0)) I XQY="" S XQSTXT(XQI)="The option "_XQSOP_" is not in the Option File.",XQI=XQI+1 G OUT
 S XQY0=^DIC(19,XQY,0)
 ;
DIC ;Look up option, check it's type and parameters
 I 'XQAUDIT S XQN="" F XQII=0:0 S XQN=$O(^XTV(8989.3,1,19.2,"B",XQN)) Q:XQN=""  S:($E(XQSOP,1,$L(XQN))=XQN) XQAUDIT=1 I XQAUDIT S XQSTART=^XTV(8989.3,1,19),XQEND=$P(XQSTART,U,3),XQSTART=$P(XQSTART,U,2) S:DT<XQSTART!(DT>XQEND) XQAUDIT=0
 I $P(XQY0,U,4)'["S" S %=$P(XQY0,U,4),XQSTXT(XQI)="Option "_XQSOP_" is not shown as a server-type option but an "_%_".  Should be 'S'.",XQI=XQI+1
 I $P(XQY0,U,3)'="" S XQSTXT(XQI)=XQSOP_" is marked Out Of Order with the message: "_$P(XQY0,U,3),XQI=XQI+1
 ;
XQ220 ;Get and check the variables in ^DIC(19,+XQY,220)
 S XQ220="" S:$D(^DIC(19,+XQY,220)) XQ220=^(220)
 I XQ220="" S XQSTXT(XQI)="The expected data in ^DIC(19,"_XQY_",220) is missing.",XQI=XQI+1
 S XQJ=100,XQSTXT(XQJ)=" ",XQJ=XQJ+1,XQSTXT(XQJ)="Fields 220 to 225 in the Option File:",XQJ=XQJ+1
 S XQB=$P(XQ220,U,1),XQSTXT(XQJ)=$S(XQB="":"   220 - No bulletin selected, will use default XQSERVER",1:"   220 - Bulletin "_$P(^XMB(3.6,XQB,0),U)_" is pointed to."),XQJ=XQJ+1
 S XQSA=$P(XQ220,U,2),XQSTXT(XQJ)="   221 - The server action code is "_$S(XQSA="R":"Run Immediately",XQSA="Q":"Queue Server",XQSA="N":"Notify Mail Group (do not run)",XQSA="I":"Ignore Requests",1:"Missing"),XQJ=XQJ+1
 S XQMG=$P(XQ220,U,3),XQSTXT(XQJ)="   222 - "_$S(XQMG="":"No mail group is pointed to.",1:"The mail group "_$P(^XMB(3.8,XQMG,0),U)_" is pointed to."),XQJ=XQJ+1
 S XQAUD=$P(XQ220,U,4),XQSTXT(XQJ)="   223 - Auditing is turned "_$S(XQAUD="Y":"on",1:"off")_".",XQJ=XQJ+1
 S XQSUP=$P(XQ220,U,5),XQSTXT(XQJ)="   224 - The server's bulletin is "_$S(XQSUP="Y":"",1:"not ")_"supressed.",XQJ=XQJ+1
 S XQRPL=$P(XQ220,U,6),XQSTXT(XQJ)="   225 - Reply mail is "_$S(XQRPL=""!XQRPL="N":"not sent.",XQRPL="E":"sent when an error is trapped.",1:"sent in all cases."),XQJ=XQJ+1
 ;
BULL ;Check out Bulletins an mail groups, etc.
 I XQB="" S XQB=$O(^XMB(3.6,"B","XQSERVER",0)) I XQB="" S XQSTXT(XQI)="No bulletin associated with this option.  Default XQSERVER missing from system.",XQI=XQI+1
 I XQB,'$D(^XMB(3.6,XQB,0))#2 S XQSTXT(XQI)="Option "_XQSOP_" points to a bulletin not in the Bulletin File.",XQI=XQI+1
 I XQMG,'$D(^XMB(3.8,XQMG,0))#2 S XQSTXT(XQI)="Option "_XQSOP_" points to a Mail Group not in Mail Group file."
 I XQMG="" F  S XQMG=$O(^XMB(3.6,XQB,2,"B",XQMG)) Q:XQMG=""  I $D(^XMB(3.8,XQMG,0))#2 S XQ(XQMG)=""
 I '$D(XQ),XQMG="" S XQSTXT(XQI)="There are no mail groups associated with the bulletin "_$P(^XMB(3.6,XQB,0),U)_"."
 S X=XQB D ^XQSRV4 I Y="" S XQSTXT(XQI)="There is no active user associated with the bulletin "_$P(^XMB(3.6,+XQB,0),U)_"."
 I 'XQAUDIT S:$D(^XTV(8989.3,1,19.1,"B",+XQY)) XQAUDIT=1 I XQAUDIT S XQSTART=^XTV(8989.3,1,19),XQEND=$P(XQSTART,U,3),XQSTART=$P(XQSTART,U,2) S:DT<XQSTART!(DT>XQEND) XQAUDIT=0
 ;
RTN ;Check out the program this server is supposed to run
 ;S XQMB=$S($D(^XMB(3.6,+XQBUL,0)):$P(^(0),U,1),1:"XQSERVER")
 S %="" S:$D(^DIC(19,+XQY,25)) %=^(25) I %="" S XQSTXT(XQI)="There is no routine in field 25 of the Option File for this option.",XQI=XQI+1
 I %'="" S X=$S(%[U:$P(%,U,2),1:%) X ^%ZOSF("TEST") I '$T S XQSTXT(XQI)="The routine "_X_" is not on the system.",XQI=XQI+1
 ;
MODE ;Load, check, and employ Server Action Code
 I XQSA="" S XQSTXT(XQI)="There is no Server Action code for this option.",XQI=XQI+1
 ;
OUT ;Send return message and quit
 D SETUP^XQSRV3
 K %,%X,X,XQ,XQ220,XQAUD,XQAUDIT,XQB,XQDATE,XQHERE,XQI,XQII,XQJ,XQMB,XQMG,XQMS,XQMSG,XQN,XQRPL,XQSA,XQSCH,XQSND,XQSRV5,XQSTXT,XQSUB,XQSUP,Y
 Q
 ;
CNVT ;Convert %X to uppercase and remove leading spaces
 I %X'?.PUN S %X=$$UP^XLFSTR(%X) ;F %I=1:1 Q:%X?.PUN  S %Y=$A(%X,%I) I %Y<123,%Y>96 S %X=$E(%X,1,%I-1)_$C(%Y-32)_$E(%X,%I+1,255)
 F  S %Y=$E(%X,1) Q:%Y'=" "  S %X=$E(%X,2,99)
 K %I,%Y
 Q
