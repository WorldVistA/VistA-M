IBARXEX ;ALB/AAS - RX COPAY INCOME EXEMPTION ROUTINE - MANUAL UPDATE OPTION ; 16-NOV-92
 ;;2.0; INTEGRATED BILLING ;**199**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% I '$D(DT) D DT^DICRW
 D HOME^%ZIS
PAT W @IOF,"Medication Copayment Exemption Update Option",!!
 S DIC("W")="N IBX S IBX=$G(^IBA(354,+Y,0)) W ?32,"" "",$P($G(^DPT(+IBX,0)),U,9),?46,"" "",$$TEXT^IBARXEU0($P(IBX,U,4)),?59,"" "",$P($G(^IBE(354.2,+$P(IBX,U,5),0)),U)"
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC="^DPT(",DIC("S")="I $D(^IBA(354,+Y,0))",DIC(0)="AEQM",DIC("A")="Select BILLING PATIENT: " D ^DIC G:+Y<1 END S DFN=+Y K DIC I $P(Y,"^",3) S IBNEW=""
 ;
EN ; -- entry point from alert processing , dfn defined
 S IBQUIT=0,IBTALK=1,IBJOB=13
 D DISP
 D STAT
 I $D(IBNEW)!(IBSTATR'=$P(IBPBN,"^",5))!($P(IBSTAT,"^",4)'=$P(IBPBN,"^",4)) D AUTO^IBARXEX1 G PATQ ;ask if autoupdate
 I $P(IBSTAT,"^",4)=$P(IBPBN,"^",4) D MANUAL^IBARXEX1 ; ask if want to change
PATQ I 'IBQUIT D:$D(IBCHANGE) DISP,STAT,PAUSE^IBOUTL
 ;
 D END
 G PAT
 ;
DISP ; -- single screen display of Pharmacy co-pay income exemption status
 S IBP=$$PT^IBEFUNC(DFN),IBPBN=$G(^IBA(354,DFN,0))
 D HDR
 S IBCNT=0
 ;
 S IBDT=-(DT+.000001)
 F  S IBDT=$O(^IBA(354.1,"AIVDT",1,DFN,IBDT)) Q:'IBDT  S IBDA=0 F  S IBDA=$O(^IBA(354.1,"AIVDT",1,DFN,IBDT,IBDA)) Q:'IBDA  D SHOWONE S IBCNT=IBCNT+1
 I 'IBCNT W !,"None"
 Q
 ;
SHOWONE ; -- write display line for one entry
 S X=$G(^IBA(354.1,IBDA,0)) Q:X=""
 W !,$$DAT1^IBOUTL(+X),?12,$S($P(X,"^",3)=1:"RX COPAY",1:"")
 W ?22,$$TEXT^IBARXEU0($P(X,"^",4))
 W ?34,$E($P($G(^IBE(354.2,+$P(X,"^",5),0)),"^"),1,22)
 W ?56,$S($P(X,"^",6)=1:"SYSTEM",$G(^VA(200,+$P(X,"^",7),0))]"":$E($P(^(0),U),1,14),1:"Unknown"),"/ ",$$DAT1^IBOUTL($P(X,"^",8))
 Q
 ;
STAT ; -- show current status
 S IBSTATR=+$$STATUS^IBARXEU1(DFN,DT)
 S IBSTAT=$G(^IBE(354.2,+IBSTATR,0))
 ;
 W !!,"Medication Copayment Exemption Status Currently computes to: ",$$TEXT^IBARXEU0($P(IBSTAT,"^",4))
 W !,$P(IBSTAT,"^",2),!!
 Q
 ;
SELCY ; -- select calendar year to work with
 ;
 W !!
 S Y=+$$LST^IBARXEU0(DFN) I Y?7N D D^DIQ S DIR("B")=Y
 S DIR("?")="Enter the effective date you wish to add a new exemption record for.  If the exemption is computed from income data then the effective date will be the date of the income test.  It cannot be in the future."
 S DIR(0)="DO^"_$$STDATE^IBARXEU_":"_DT,DIR("A")="Select Effective Date" D ^DIR K DIR
 I $D(DIRUT)!(Y'?7N) S IBQUIT=1 G SELCYQ
 S IBDT=Y
 I '$D(^IBA(354.1,"APIDT",DFN,1,-IBDT))&(IBDT'=DT) K IBDT W !!?4,$C(7),"The DATE selected must be the date of an exemption or today!",!?4,"This is the same date as the date of a Means Test or Copay Test.",! G SELCY
SELCYQ Q
 ;
 ;
HDR W @IOF,"Medication Copayment Income Exemption Status"
 W !,$E($P(IBP,"^"),1,20),"   ",$P(IBP,"^",3),?27," Currently: ",$$TEXT^IBARXEU0($P(IBPBN,"^",4))_"-"_$P($G(^IBE(354.2,+$P(IBPBN,"^",5),0)),"^"),?65," ",$$DAT1^IBOUTL($P(IBPBN,"^",3))
 W !!,"EFFECTIVE   TYPE      STATUS      REASON                ADDED BY/ON"
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
END K C,I,J,DA,DIC,DIE,DR,DFN,IBACTIVE,IBADDE,IBALERT,IBCHANGE,IBCNT,IBCODA,IBCODP,IBEXDA,IBDA,IBDT,IBEXREA,IBJ,IBJOB,IBNEW,IBP,IBPBN,DIRUT,IBQUIT,IBSTAT,IBSTATR,IBTALK,IBWHER,X,X1,XCNP,XMZ,Y
 Q
