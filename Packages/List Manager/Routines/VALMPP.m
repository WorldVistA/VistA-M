VALMPP ; alb/mjk - Pre-Init for List Manager ;08:08 PM  30 Mar 1993
 ;;1;List Manager;;Aug 13, 1993
 ;
EN ; -- main entry point
 D USER G ENQ:'$D(DIFQ)
 D OERR G ENQ:'$D(DIFQ)
 D XQOR
ENQ Q
 ;
USER I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must equal '@' to initialize.",! K DIFQ
 Q
 ;
OERR ; -- is protocol file present
 I '$D(^ORD(101)) D
 .W !,">>> Protocol file not present in this account."
 .D STOP
 Q
 ;
XQOR ; -- Conditionally installs XQOR*
 N DIF,X,XCNP,DIR,Y,X,VALMXQ
 K ^UTILITY("VALMLOAD",$J) S VALMXQ=6.7
 W !!,">>> Checking the version of XQOR*..."
 S X="XQOR" X ^%ZOSF("TEST")
 I $T S XCNP=0,DIF="^UTILITY(""VALMLOAD"",$J," X ^%ZOSF("LOAD")
 S X=$G(^UTILITY("VALMLOAD",$J,2,0))
 I $P(X,";",3)'<VALMXQ W "ok." G XQORQ
 W !!?5,*7,"The current version of XQOR* is ",$P(X,";",3),"."
 W !?5,"List Manager requires version ",VALMXQ," or greater.",!
 W !?5,"As part of the post-init, version ",VALMXQ," will be installed."
 S DIR(0)="Y",DIR("A")="     Continue with the installation",DIR("B")="No" D ^DIR K DIR
 D:'Y STOP
 K ^UTILITY("VALMLOAD",$J)
XQORQ Q
 ;
STOP ; -- set flag and write message
 K DIFQ
 W !!,*7,">>> List Manager installation will not occur."
 Q
