XPDDPCK ;SFISC/RSD - Display a Package file information ;10/03/96  10:15
 ;;8.0;KERNEL;**44**;Jul 05, 1995
EN1 ;print all Patches for Package version
 N DIC,DIR,DIRUT,XPD,XPD0,XPDFL,XPDNM,XPDV,Y,Z
 S DIC="^DIC(9.4,",DIC(0)="AEMQZ" D ^DIC Q:Y'>0
 I '$D(^DIC(9.4,+Y,22,0)) W !!,"This Package has no VERSION multiple",! Q
 S XPD0=+Y,DIC=DIC_XPD0_",22," S:$G(^DIC(9.4,XPD0,"VERSION")) DIC("B")=$P(^("VERSION"),U)
 D ^DIC Q:Y'>0
 S XPDV=+Y,DIR(0)="Y",DIR("A")="Do you want to see the Descriptions",DIR("B")="NO"
 D ^DIR Q:$D(DIRUT)
 S XPDFL=Y,X="PNT^XPDDPCK",Z="Package File Print"
 F Y="XPD0","XPDFL","XPDV" S XPD(Y)=""
 D EN^XUTMDEVQ(X,Z,.XPD)
 Q
 ;
PNT ;print a package
 N DIRUT,I,J,K,X,XPD,XPDDT,XPDI,XPDPG,XPDUL,XPDV0
 Q:'$G(XPD0)!'$G(XPDV)!'$D(XPDFL)
 Q:'$D(^DIC(9.4,XPD0,0))  S XPDNM=$P(^(0),U) Q:'$D(^(22,XPDV,0))  S XPDV0=^(0)
 S XPDPG=1,$P(XPDUL,"-",IOM)="",XPDDT=$$HTE^XLFDT($H,"1PM")
 W:$E(IOST,1,2)="C-" @IOF D HDR
 W "VERSION: ",$P(XPDV0,U),?20,$$EXTERNAL^DILFD(9.49,2,"",$P(XPDV0,U,3)),?50,$$EXTERNAL^DILFD(9.49,3,"",$P(XPDV0,U,4))
 ;diplay version description
 I XPDFL W ! D DES("^DIC(9.4,"_XPD0_",22,"_XPDV_",1)") Q:$D(DIRUT)
 W ! S XPDI=0
 F  S XPDI=$O(^DIC(9.4,XPD0,22,XPDV,"PAH",XPDI)) Q:'XPDI  S XPD=$G(^(XPDI,0)) Q:$$CHK(4)  D  Q:$D(DIRUT)
 .;patch history
 .W !?3,$P(XPD,U),?20,$$EXTERNAL^DILFD(9.4901,.02,"",$P(XPD,U,2)),?50,$$EXTERNAL^DILFD(9.4901,.03,"",$P(XPD,U,3))
 .I XPDFL W ! D DES("^DIC(9.4,"_XPD0_",22,"_XPDV_",""PAH"","_XPDI_",1)") 
 W ! Q
 ;
CHK(Y) ;Y=excess lines, return 1 to exit & DIRUT is set
 Q:$Y<(IOSL-Y) 0
 I $E(IOST,1,2)="C-" D  Q:'Y 1
 .N DIR,I,J,K,X
 .S DIR(0)="E" D ^DIR
 S XPDPG=XPDPG+1
 W @IOF D HDR
 Q 0
 ;
DES(XPDGR) ;display description, XPDGR=global root
 N XPDI S XPDI=0
 F  S XPDI=$O(@XPDGR@(XPDI)) Q:'XPDI  I $D(^(XPDI,0)) W ^(0),! Q:$$CHK(4)
 Q
 ;
HDR W !,"PACKAGE: ",XPDNM,"     ",XPDDT,?70,"PAGE ",XPDPG,!,"PATCH #",?20,"INSTALLED",?50,"INSTALLED BY"
 W:XPDFL !?5,"DESCRIPTION"
 W !,XPDUL,!
 Q
