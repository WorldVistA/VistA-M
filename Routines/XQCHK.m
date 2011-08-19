XQCHK ; SEA/MJM - Check security on option # XQCY ;5/20/08
 ;;8.0;KERNEL;**47,110,149,303,427,503**;Jul 10, 1995;Build 2
 ;;"Per VHA Directive 2004-038, this routine should not be modified".
 ;
 Q:'$D(XQCY)!(XQCY<1)  S:'$D(XQJMP) XQJMP=0
 I '$D(XQY0) S XQY0=^DIC(19,+XQCY,0)
 I '$D(XQCY0) S XQSAV=XQY0,XQY=XQCY D SET Q:XQCY<0  S XQCY0=XQY0,XQY0=XQSAV
CHK I XQCY0="" S XQCY=-1 G OUT
 I $P(XQCY0,U,3)'="" S XQCY=-1 G OUT
 N XQRT S XQRT=$$CHCKL^XQCHK2(XQCY0,DUZ) I +XQRT S XQCY=-2 G OUT  ; add this line to check all Locks
 I $L($P(XQCY0,U,6)) S %="" F %XQI=1:1 S %=$P($P(XQCY0,U,6),",",%XQI) Q:%=""  I '$D(^XUSEC(%,DUZ)) S XQCY=-2 G OUT  ; remove
 N XQRT S XQRT=$$CHCKRL^XQCHK2(XQCY0,DUZ) I +XQRT S XQCY=-3 G OUT  ; add this line to check all Reversed Locks
 I $L($P(XQCY0,U,16)) S %="" F %XQI=1:1 S %=$P($P(XQCY0,U,16),",",%XQI) Q:%=""  I $D(^XUSEC(%,DUZ)) S XQCY=-3 G OUT  ; remove
 I $L($P(XQCY0,U,9)) S XQZ=$P(XQCY0,U,9) D ^XQDATE S X=% D XQO^XQ92 I X="" S XQCY=-4 G OUT
 G:$P(XQCY0,U,10)'["y" OUT
 S %=0 F %XQI=1:1 S %=$O(^DIC(19,XQCY,3.96,%,0)) Q:%=""  I IOS=% G OUT
 S XQCY=-5 G OUT
 Q
 ;
OUT K %,%XQI,XQCY0,%Y,XQZ
 Q
 ;
JMP ;Check all options in jump path in %XQJP returned as "" if not OK
 S XQJMP=1
 F %XQCI=1:1 S XQCY=$P(%XQJP,",",%XQCI) Q:XQCY=""  S XQCY0=$G(^XUTL("XQO",XQDIC,"^",XQCY)),XQCY0=$P(XQCY0,U,2,99) D CHK S:XQCY<0 %XQJP=""
 K %XQCI,XQCY,XQCY0
 Q
 ;
SET ;Produce the same XQY0 as SET1^XQ7 without the synonym
 I '$D(^DIC(19,+XQY,0)) S XQY=-1 Q
S1 Q:XQY'>0  S XQY0=^DIC(19,+XQY,0),XQY0=$P(XQY0,U,1,2)_U_$S($P(XQY0,U,3)]"":1,1:"")_U_$P(XQY0,U,4)_U_U_$P(XQY0,U,6,99)
 S %="" I $D(^DIC(19,+XQY,3.91)) F %XQI=0:0 S %XQI=$O(^DIC(19,+XQY,3.91,%XQI)) Q:%XQI=""!(%XQI'=+%XQI)  I ^(%XQI,0)]"" S %=$S(%'="":%_";",1:"")_$P(^(0),U,1)_$P(^(0),U,2)
 I %]"" S XQY0=$P(XQY0,U,1,8)_U_%_U_$P(XQY0,U,10,99)
 I $P(XQY0,U,16),$D(^DIC(19,XQY,3)) S %=$P(^(3),U) I %'="" S XQY0=$P(XQY0,U,1,15)_U_%_U_$P(XQY0,U,17,99)
 K %,%XQI
 Q
 ;
MES ;Messages for rejected options from a call to XQCHK
 W $C(7)
 I XQCY=-1 W !!?5,"==> Sorry, ",$S($D(XQPRMN):"your Primary Menu",1:"this option")," is out of order with the message:",!?10,$P(^DIC(19,XQY,0),U,3)
 I XQCY=-2 W !!?5,"==> Sorry, ",$S($D(XQPRMN):"your Primary Menu",1:"this option")," is locked."
 I XQCY=-3 W !!?5,"==> Sorry, ",$S($D(XQPRMN):"your Primary Menu",1:"this option")," has a reverse lock on it."
 I XQCY=-4 W !!?5,"==> Sorry, ",$S($D(XQPRMN):"your Primary Menu",1:"this option")," not allowed right now."
 I XQCY=-5 W !!?5,"==> Sorry, ",$S($D(XQPRMN):"your Primary Menu",1:"this option")," not allowed on this device."
 Q
 ;
OP ;Find out what option or protocol is in charge right now
 ;Returns option or protocol name and text in XQOPT
 S U="^",%XQ=0
 I $D(XQORNOD) S %XQ=+XQORNOD,%XQ1=U_$P(XQORNOD,";",2),%XQ=@(%XQ1_%XQ_",0)"),XQOPT=$P(%XQ,U)_U_$P(%XQ,U,2)
 I '$D(XQORNOD) S %XQ=$S($D(XQY)#2:XQY,1:0) I %XQ S %XQ1=^DIC(19,+%XQ,0),XQOPT=$P(%XQ1,U)_U_$P(%XQ1,U,2)
 I '$D(XQOPT) S XQOPT="-1^Unknown"
 K %XQ,%XQ1
 Q
 ;
OP1() ;Extrinsic function call returns 3 pieces: 1. "P", "O", or "U" for
 ;Protocol, Option, or Unknown.  2: The Option or Protocol's name. 3:
 ;3: Text name of the Protocol or Option.  For example:
 ;
 ;           O^EVE^System Manager's Menu
 ;
 N %,%XQ,%XQ1
 S U="^",%XQ=0
 I $D(XQORNOD) S %XQ=+XQORNOD,%XQ1=U_$P(XQORNOD,";",2),%XQ=@(%XQ1_%XQ_",0)"),%="P"_U_$P(%XQ,U)_U_$P(%XQ,U,2)
 I '$D(XQORNOD) S %XQ=$S($D(XQY)#2:XQY,1:0) I %XQ S %XQ1=^DIC(19,+%XQ,0),%="O"_U_$P(%XQ1,U)_U_$P(%XQ1,U,2)
 I '$D(%) S %="U"_U_"Unknown"_U_"No option or protocol data available"
 Q %
 ;
ACCESS(%XQUSR,%XQOP) ;Find out if a user has access to a particular option
 Q $$ACCESS^XQCHK3(%XQUSR,%XQOP)
 ;
OPACCES ;Entry point for the option that checks to see if a user has
 ;access to a particular option by calling the above function.
 D OPACCES^XQCHK3
 Q
 ;
KEYSET(XQU) ;Collect users keys and set them into ^TMP($J)
 N %,XQI
 S %=0 F XQI=0:1 S %=$O(^VA(200,XQU,51,"B",%)) Q:%=""  S:$D(^DIC(19.1,%,0)) ^TMP($J,$P(^DIC(19.1,%,0),U),%)=""
 Q
