XUP ;SFISC/RWF - Setup enviroment for programmers ;1/30/08  11:12
 ;;8.0;KERNEL;**208,258,284,432,469**;Jul 10, 1995;Build 7
 ;Per VHA Directive 2004-038, this routine should not be modified.
 W !,"Setting up programmer environment"
 S U="^",$ECODE="",$ETRAP="" ;Clear error and error trap
 X ^%ZOSF("TYPE-AHEAD")
 ;Check if Production and report
 W !,"This is a "_$S($$PROD^XUPROD(1):"PRODUCTION",1:"TEST")_" account.",!
 ;
 K ^UTILITY($J),^XUTL("XQ",$J) D KILL1^XUSCLEAN
 S U="^",DT=$$DT^XLFDT
 S XUEOFF=^%ZOSF("EOFF"),XUEON=^%ZOSF("EON"),U="^",XUTT=0,XUIOP=""
 D GETENV^%ZOSV S XUENV=Y,XUVOL=$P(Y,U,2),XUCI=$P(Y,U,1)
 ;Reset DUZ if user "Switched Identities".
 I $D(DUZ("SAV")) S DUZ=+DUZ("SAV"),DUZ(0)=$P(DUZ("SAV"),U,2) K DUZ("SAV")
 ;Get user info
 I $G(DUZ)>.5,$D(^VA(200,DUZ,0))[0 K DUZ W !,"DUZ Must point to a real user." G EXIT ;p432
 I $G(DUZ)>0 D DUZ(DUZ)
 I $G(DUZ)'>0!('$D(DUZ(0))) D ASKDUZ G:Y'>0 EXIT
 I '$D(XQUSER) S XQUSER=$S($D(^VA(200,DUZ,20)):$P(^(20),"^",2),1:"Unk")
 S DTIME=600 ;Set a temp DTIME
 S DILOCKTM=+$G(^DD("DILOCKTM"),1) ;p432
 ;Getting Terminal Type
ZIS I XUTT D ENQ^XUS1 G:$D(XUIOP(1)) ZIS2 S Y=0 D TT^XUS3 I Y>0 S XUIOP(1)=$P(XUIOP,";",2) G ZIS2
 S X="`"_+$G(^VA(200,DUZ,1.2)),DIC="^%ZIS(2,",DIC(0)="MQ"_$S(X]"`0":"",1:"AE") D ^DIC G:Y'>0 EXIT
 S XUIOP(1)=$P(Y,U,2) I DIC(0)["A",$G(^VA(200,+DUZ,0))]"" S $P(^VA(200,DUZ,1.2),U,1)=+Y
ZIS2 S %ZIS="L",IOP="HOME;"_XUIOP(1) D ^%ZIS G EXIT:POP W !,"Terminal Type set to: ",IOST,!
 S DTIME=$$DTIME(DUZ,IOS),DUZ("BUF")=1,XUDEV=IOS
 S %=+$G(^VA(200,DUZ,.1)) I %>0 S %=$P(^XTV(8989.3,1,"XUS"),U,15)-($H-%) I %<14,%>0 W !!,"Your VERIFY code will expire in "_%_" days",!!
 ;Save info, Set last sign-on
 D SAVE^XUS1 S $P(^VA(200,DUZ,1.1),"^",1)=$$NOW^XLFDT
 ;Check Mail
 S Y=$P($G(^XMB(3.7,DUZ,0)),U,6) I Y W !,"You have "_Y_" new message"_$S(Y=1:"",1:"s")_"."
 ;Setup error trap
 I $$GET^XPAR("USR^SYS","XUS-XUP SET ERROR TRAP",1,"Q") S $ETRAP="D ERR^XUP"
 D KILL1^XUSCLEAN S $P(XQXFLG,U,3)="XUP" D ^XQ1
EXIT ;Clean-up and exit
 D KILL1^XUSCLEAN K XQY,XQY0
 I $G(DUZ)>0,$$GET^XPAR("USR^SYS","XUS-XUP VPE",1,"Q"),$D(^%ZVEMS) X ^%ZVEMS ;Run VPE
 Q
 ;
ASKDUZ ;Ask for Access Code
 N X
 ;X XUEOFF S DIR(0)="FO",DIR("A")="Access Code" D ^DIR W ! X XUEON I $D(DIRUT) S Y=-1 Q
 X XUEOFF W !,"Access Code: " S X=$$ACCEPT^XUS() X XUEON
 I X["^"!('$L(X)) S Y=-1 Q
 S X=$$UP^XLFSTR(X) S:X[":" XUTT=1,X=$P(X,":",1)_$P(X,":",2)
 D ^XUSHSH S Y=$O(^VA(200,"A",X,0))
 K DUZ D DUZ(+Y)
 Q
 ;
DUZ(DA) ;Build DUZ for a user.  Used by Mailman.
 ;(p284) Make the setting of several DUZ parts conditional.
 N Y
 S Y(0)=$G(^VA(200,+DA,0)),Y("XUS")=$G(^XTV(8989.3,1,"XUS"))
 S DUZ=DA
 S:$G(DUZ(0))'="@" DUZ(0)=$P(Y(0),"^",4)
 S DUZ(1)="",DUZ("AG")=$P($G(^XTV(8989.3,1,0)),"^",8)
 S:'$G(DUZ(2)) DUZ(2)=$O(^VA(200,DUZ,2,0))
 S:'DUZ(2) DUZ(2)=+$P(Y("XUS"),"^",17)
 S:'$L($G(DUZ("LANG"))) DUZ("LANG")=$P(Y("XUS"),"^",7)
 Q
 ;
DTIME(E,D) ;Return DTIME value for user E, device D.
 N P
 S P=$P($G(^VA(200,+$G(E),200)),"^",10) S:P="" P=$P($G(^%ZIS(1,+$G(D),"XUS")),"^",10) S:P="" P=$P($G(^XTV(8989.3,1,"XUS")),"^",10)
 Q $S(P]"":P,1:300)
 ;
ERR ;
 N %XUP U $P
 W !,"$ECODE=",$ECODE,"   $STACK=",$STACK
 W !,"Location: ",$STACK($STACK-1,"PLACE")
 R !!,"Want to record the error: No// ",%XUP:600 I "Yy"[$E(%XUP_"N") D ^%ZTER
 D UNWIND^%ZTER ;S:'$ESTACK $ECODE="" S $ETRAP="" Q:$QUIT "" Q
