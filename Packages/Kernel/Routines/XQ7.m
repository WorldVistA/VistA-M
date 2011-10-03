XQ7 ;SF-ISC..SEA/JLI - MICROSURGERY OF XUTL MENU TREES ;01/09/2001  13:29
 ;;8.0;KERNEL;**44,60,155**;Jul 10, 1995
REDO ; All changes to an option come here, i.e., menu text, locks, prohibited times, etc.
 S XQFLAG=DA
 S %H=$H F %=0:0 S %=$O(^DIC(19,"AD",DA,%)) Q:%'>0  S ^DIC(19,%,99)=%H I '$D(^DIC(19,%,0)) K ^DIC(19,%),^DIC(19,"AD",DA,%)
 F %=0:0 S %=$O(^VA(200,"AD",DA,%)) Q:%'>0  S ^VA(200,%,203.1)=%H
 ;
FLAG ;
 S ^DIC(19,"AT",$$NOW^XLFDT(),XQFLAG)=""
 K %,%H,XQFLAG
 Q
 ;
REDOX ;
 S %H=$H,^DIC(19,DA(1),99)=%H
 F %=0:0 S %=$O(^VA(200,"AD",DA(1),%)) Q:%'>0  S ^VA(200,%,203.1)=%H
 Q
 ;
REDOXI ; Insertion of an item on a menu
 D REDOX
 S XQFLAG=DA(1)_"I"_X G FLAG
 ;
REDOXD ; Deletion of an item from a menu
 D REDOX
 S XQFLAG=DA(1)_"D"_X G FLAG
 ;
REDOXS ; Change or addition of a synonym
 D REDOX
 S XQFLAG=DA(1)_"S"_(+^DIC(19,DA(1),10,DA,0)) G FLAG
 ;
REDOXZ ; Change in display order, does not affect trees
 D REDOX K %,%H
 Q
REDOXP ; Check for new primary menu added to user file
 Q:$D(^XUTL("XQO","P"_X))
 S XQFLAG=X_"P"_X G FLAG
 ;
CK ;Called from several places in ^DD(19,
 I $D(DIFROM) Q
 S %=$P(^DIC(19,D0,0),U,6),%Y=$P(^DIC(19,D0,0),U,1) I $S($L(%):$D(^XUSEC(%,DUZ)),1:1)
 Q:'$T
 I DUZ(0)="@"!$D(^XUSEC("XUMGR",DUZ))!$D(^VA(200,DUZ,19.5,Y,0))
 Q:'$T
CK1 S %=$P(^DIC(19,D0,0),U,4),%Y=$P(^DIC(19,Y,0),U,4) I $S((%'="O"&(%'="Q"))&(%Y'="Q"):1,(%="O"&(%Y="O")):1,(%="Q"&((%Y="O")!(%Y="Q"))):1,1:0)
 Q
DEV ;See if device is legit for this option. Called by CHK1+5^XQ71.
 S (%,XQSJ)=0 Q:'$D(^DIC(19,+XQW,3.96,0))
 F XQSL=1:1 S %=$O(^DIC(19,+XQW,3.96,%)) Q:%=""!(%'=+%)  S:XQSIO=^(%,0) XQSJ=1
 Q
UP S X=$$UP^XLFSTR(X) ;F XQSA=1:1 Q:X?.NUP  S %=$A(X,XQSA) I %<123,%>96 S X=$E(X,1,XQSA-1)_$C(%-32)_$E(X,XQSA+1,255)
 Q
 ;
KICK ;Kick off microsurgery here and all compute servers
 D CHEK^XQ83
 Q:'$D(^%ZIS(14.5))
 N XQ,XQVOL,XQTIM,ZTCPU
 S XQTIM=$P($H,",")-1_","_$P($H,",",2)
 S XQ=0 F  S XQ=$O(^%ZIS(14.5,XQ)) Q:XQ=""!(XQ'=+XQ)  I $P(^(XQ,0),U,11) D
 .S ZTCPU=$P(^%ZIS(14.5,XQ,0),U) D CHEK^XQ83
 Q
