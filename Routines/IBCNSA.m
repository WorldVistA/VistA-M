IBCNSA ;ALB/NLR - ANNUAL BENEFITS EDIT ; 21-MAY-1993
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBCNS ANNUAL BENEFITS
 K VALMQUIT,VALMEVL,XQORS,^TMP("XQORS",$J),DIC,%DT,IBCNS,IBCPOL,IBYR
 S IBCHANGE="OKAY"
 D EN^VALM("IBCNS ANNUAL BENEFITS")
 Q
 ;
HDR(SCR) ; -- joint header logic
 S Y=$E($E($P($G(^DIC(36,$P($G(^IBA(355.3,+IBCPOL,0)),U),0)),U),1,20)_" Ins. Co                    ",1,30)
 I $G(IBPAT) S Y=Y_"Patient: "_$E($P(^DPT(DFN,0),"^"),1,20)
 S VALMHDR(1)=SCR_" for: "_Y
 S VALMHDR(2)=$S($G(IBPAT):"           Policy: "_$E(IBCGN_"                             ",1,30)_" Ben Yr: "_IBYE,1:"             Policy: "_$E(IBCGN_"                             ",1,30)_" Ben Yr: "_IBYE)
 Q
 ;
INIT ; -- init variables and list array
 K VALMQUIT,IBCAB,IBPAT
 S VALMCNT=0,VALMBG=1
 I $G(IBYR)'?7N K IBYR
 I '$G(IBCPOL) D GETPOL Q:$D(VALMQUIT)
 I '$G(IBYR) D GETYR Q:$D(VALMQUIT)
 I '$D(IBCAB) S IBCAB=$$AB^IBCNSU(IBCPOL,IBYR)
 S IBCABD=$G(^IBA(355.4,IBCAB,0))
 S IBCABC=$G(^IBA(355.3,$P(IBCABD,U,2),0))
 S IBCGN=$$GRP^IBCNS(IBCPOL)
 K ^TMP("IBCNSA",$J)
 D BLD
 Q
BLD ; -- List builder
 S VALMCNT=47
 F I=1:1:56 D BLANK(.I)
 D EN^IBCNSA0,EN^IBCNSA1
 Q
 ;
GETPOL ;
 I '$G(IBCNS) D INSCO^IBCNSC I '$G(IBCNS) S VALMQUIT="" G GETPOLQ
 I '$G(IBCPOL) S IBCPOL=$$LK^IBCNSM31(IBCNS) ;D  G:$D(VALMQUIT) GETPOLQ
 ;.S DIC="^IBA(355.3,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U)=IBCNS"
 ;.D ^DIC K DIC
 ;.S IBCPOL=+Y
 I $G(IBCPOL)<1 S VALMQUIT=""
GETPOLQ Q
 ;
GETYR ;
 I '$G(IBCPOL) D GETPOL I $G(IBCPOL)<1 S VALMQUIT="" G GETYRQ
 I '$G(IBYR) D GY1 G:$D(VALMQUIT) GETYRQ
GETYRQ Q
 ;
GY1 N %DT
 S IBCNT=0
 S IBDT="" F  S IBDT=$O(^IBA(355.4,"APY",IBCPOL,IBDT)) Q:'IBDT  S IBDA=0 F  S IBDA=$O(^IBA(355.4,"APY",IBCPOL,IBDT,IBDA)) Q:'IBDA  D
 .S IBCNT=IBCNT+1
 .W:IBCNT=1 !!,"Current benefit years on file:"
 .W !?4,IBCNT,". ",?8,$$DAT1^IBOUTL(+$G(^IBA(355.4,IBDA,0)),2)
 .Q
 I 'IBCNT W !,"No Benefit Years Entered."
 ;
 ; -- get default date of most recent entry, change to positive value
 ;
 S X=+$O(^IBA(355.4,"APY",IBCPOL,"")) I X S:X<0 X=-X S:X>0 DIC("B")=$$DAT1^IBOUTL(X)
 S DIC="^IBA(355.4,",DIC(0)=$S($G(IBL):"AELQN",1:"AEQN"),DIC("A")="BENEFIT YEAR BEGINNING ON: "
 S DIC("S")="I $P(^(0),U,2)=IBCPOL"
 S DIC("W")=""
 S DIC("DR")=".02////"_IBCPOL
 S:$G(IBL) DLAYGO=355.4
 D ^DIC K DIC
 I +Y S IBYR=$P(Y,"^",2),IBCAB=+Y
 ;
 I $G(IBYR)<1 S VALMQUIT=""
 Q
 ;
GETYR2 ; -- get policy year from 355.4 from bu
 I '$G(IBCPOL) D GETPOL I $G(IBCPOL)<1 S VALMQUIT="" G GETYR2Q
 I '$G(IBYR) D  G:$D(VALMQUIT) GETYR2Q
 .N DIC,X,Y
 .; -- get default date of most recent entry, change to positive value
 .S IBEXP1="No Benefit Years Entered.  You Must First Enter a Benefit Year for This Policy"
 .S IBEXP2="No Benefit Years Entered Under Annual Benefits, Hence No Benefits Used to View."
 .S X=+$O(^IBA(355.4,"APY",IBCPOL,"")) I 'X W !,$S('$G(IBVIEW):IBEXP1,1:IBEXP2) S VALMQUIT="" D PAUSE^VALM1 Q
 .S:X<0 X=-X S:X>0 DIC("B")=$$FMTE^XLFDT(X,1)
 .S DIC=355.4,DIC(0)="AEQN",DIC("A")="Select BENEFIT YEAR BEGINNING ON: "
 .S DIC("S")="I $P(^(0),U,2)=IBCPOL"
 .D ^DIC K DIC
 .S IBYR=""
 .I +Y S IBYR=$P(Y,"^",2)
 I $G(IBYR)<1 S VALMQUIT=""
GETYR2Q Q
 ;
EXIT ;
 K VALMQUIT,IBCHANGE,IBCAB,IBCABC,IBCABD,IBYR,IBCABD1,IBCABD2,IBCABD3,IBCABD4,IBCABD5
 D CLEAN^VALM10
 Q
BLANK(LINE) ; -- Build blank line
 D SET^VALM10(.LINE,$J("",80))
 Q
 ;
HELP ; -- Help Code
 S X="?" D DISP^XQORM1 W !!
 Q
