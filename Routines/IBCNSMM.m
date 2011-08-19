IBCNSMM ;ALB/CMS -MEDICARE INSURANCE INTAKE ; 18-OCT-98
 ;;2.0;INTEGRATED BILLING;**103,133,184**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
EN ; -- Entry point from Medicare Intake Standalone option
 N DIC,DIR,DA,%A,DFN,X,Y,IBQUIT,IBCNSP,IBSOURCE
 S (IBQUIT,IBCNSP)=0 D GETWNR I IBQUIT G ENQ
 ;
 ; - allow the user to enter the Source of Information for the policies
 W !!,"You may enter the 'Source of Information' that will be filed with all"
 W !,"Medicare insurance coverage policies that are created.",!
 ;
 S DIR(0)="2.312,1.09"
 S DIR("A")="Enter Source of Information"
 S DIR("B")="INTERVIEW"
 D ^DIR K DUOUT,DTOUT,DIRUT,DIROUT,DIR
 S IBSOURCE=+Y I Y<1 G ENQ
 W !
 ;
 ; - loop to select patients
ENA S DIC(0)="AEQMN",DIC="^DPT(" D ^DIC
 I +Y<1 G ENQ
 S DFN=+Y
 I $G(^DPT(DFN,.35)) W *7,!!,?10,"Patient Expired on ",$$FMTE^XLFDT($P(^DPT(DFN,.35),U))
 W ! D DISP^IBCNS W !,?3 S X="",$P(X,"=",76)="" W X
 D ENR(DFN,IBSOURCE,1) K DIC W !! G ENA
 ;
ENQ Q
 ;
 ;
ENR(DFN,IBSOUR,IBOPT) ; -- Entry point from IBCNBME Patient Registration or Pre-Registration
 ;    Input Variable DFN Required and IBSOUR =Source of Information
 ;                   IBOPT =1 if comming from MII Standalone Option
 ;
 N D,DIE,DA,DIR,DIC,E,IBCPOL,IBCNSP,IBCDFN,IBQUIT,IBOK,IBC0,IBAD,IBGRP,IBADPOL
 N IBNAME,IBHICN,IBAEFF,IBBEFF,IBCOVP,IBGNA,IBGNU,IBBUF,IBNEW,IBP,X,Y
 N IBPOLA,IBPOLB,IBARR,IBHIT,IBHITA,IBHITB,IBCOB,IBCOBI
 ;
 S (IBAEFF,IBBEFF,IBCNSP,IBCDFN,IBNEW,IBQUIT)=0,IBADPOL=1
 S (IBNAME,IBHICN)=""
 ;
 ; -- Get Standard Medicare Insurance Company and plans in IBCNSP
 D GETWNR I IBQUIT G ENRQ
 ;
 ; -- get the patient's Medicare policies
 S (IBPOLA,IBPOLB)=0
 S IBCDFN=0 F  S IBCDFN=$O(^DPT(DFN,.312,"B",+IBCNSP,IBCDFN)) Q:'IBCDFN  D
 .S IBCPOL=$G(^DPT(DFN,.312,IBCDFN,0))
 .;
 .; - is the policy for Part A?
 .I $P(IBCNSP,U,3)=$P(IBCPOL,U,18) D  Q
 ..S IBPOLA=IBPOLA+1,IBARR("A",IBPOLA)=IBCDFN_"^"_IBCPOL
 .;
 .; - is the policy for Part B?
 .I $P(IBCNSP,U,5)=$P(IBCPOL,U,18) D
 ..S IBPOLB=IBPOLB+1,IBARR("B",IBPOLB)=IBCDFN_"^"_IBCPOL
 ;
 ; - can't edit here if there is more than one policy
 I $D(IBARR("A",2)) K IBARR("A") D
 .W !!,"This patient has more than one Part A policy.  Please edit in Ins Mgmt."
 ;
 I $D(IBARR("B",2)) K IBARR("B") D
 .W !!,"This patient has more than one Part B policy.  Please edit in Ins Mgmt."
 ;
 I (IBPOLA!IBPOLB),'$D(IBARR) G ENRQ
 ;
 ; -- Ask for Medicare Insurance Card information
 ;    Return IBNAME, IBHICN, IBAEFF, IBBEFF, IBCOB/IBCOBI
 D MII^IBCNSMM2 I IBQUIT G ENRQ
 ;
 ; - if Part A or B exists, but no changes, quit
 I $D(IBARR("A",1)) D COM($P(IBARR("A",1),"^",2,99),"A") I IBHIT D
 .S IBHITA=1 W !,"  * No Part A changes made..."
 ;
 I $D(IBARR("B",1)) D COM($P(IBARR("B",1),"^",2,99),"B") I IBHIT D
 .S IBHITB=1 W !,"  * No Part B changes made..."
 ;
 I $G(IBHITA),$G(IBHITB) G ENRQ
 I $G(IBHITA),'$G(IBBEFF) G ENRQ
 I $G(IBHITB),'$G(IBAEFF) G ENRQ
 ;
 ; -- If user not holding key set data in Buffer File
 I '$D(^XUSEC("IB INSURANCE SUPERVISOR",DUZ)) D  G ENRQ
 .I IBAEFF,'$G(IBHITA) D BUFF^IBCNSMM1("A")
 .I IBBEFF,'$G(IBHITB) D BUFF^IBCNSMM1("B")
 ;
 ; -- Otherwise, set data into permanent files
 I IBAEFF,'$G(IBHITA) D
 .I IBPOLA,'$D(IBARR("A")) Q  ; can't update Part A policy
 .I '$D(IBARR("A",1)) D ADDP("A") Q
 .S IBCDFN=+IBARR("A",1) D SETP^IBCNSMM1("A")
 I IBBEFF,'$G(IBHITB) D
 .I IBPOLB,'$D(IBARR("B")) Q  ; can't update Part B policy
 .I '$D(IBARR("B",1)) D ADDP("B") Q
 .S IBCDFN=+IBARR("B",1) D SETP^IBCNSMM1("B")
 ;
ENRQ W ! Q
 ;
 ;
 ;
ADDP(IBP) ; -- Create a new patient policy
 ;    Input: DFN
 ;           IBCNSP=MED WNR INS IEN^MEDICARE (WNR)
 ;                  ^PART A IEN^PART A
 ;                  ^PART B IEN^PART A
 ;           IBP = "A" or "B" for medicare part
 ;           IBSOUR = Source of Information
 ;   Return: IBCDFN=-1 could not add OR Policy ien
 ;           IBCOVP= Covered by Health Insurance
 ;
 N X,Y,DO,DD,DA,DR,DIC,DIE,DIK,DIR,DIRUT,IBSPEC
 ; -- Create a New patient policy
 S IBCOVP=$P($G(^DPT(DFN,.31)),U,11)
 ;
 D FIELD^DID(2,.3121,"","SPECIFIER","IBSPEC")
 S DIC("DR")="1.09////"_IBSOUR_";1.05///NOW;1.06////"_DUZ,DIC("P")=$G(IBSPEC("SPECIFIER"))
 K DD,DO S DA(1)=DFN,DIC="^DPT("_DFN_",.312,",DIC(0)="L",X=+IBCNSP,DLAYGO=2.312
 D FILE^DICN K DD,DO,DLAYGO,DIC
 S IBCDFN=+Y
 I IBCDFN<1 W !!,*7,"  <Could not create new policy at this time.  Try Later!>",! G ADDPQ
 ;
 ; -- Set Medicare policy data
 D SETP^IBCNSMM1(IBP)
ADDPQ Q
 ;
 ;
GETWNR ;
 ; -- Get Medicare (WNR) insurance company and plan data
 ;    Returns IBCNSP or IBQUIT
 ;    IBCNSP="Error: Medicare (WNR) ... not setup properly" 
 ;           if Medicare WNR entry or plans not setup properly
 ;
 ;    IBCNSP=INS CO. (36) IEN^"MEDICARE (WNR)"
 ;           ^PLAN (355.3) PARTA IEN^"PART A"
 ;           ^PLAN (355.3) PARTB IEN^"PART B"
 ;
 I 'IBCNSP S IBCNSP=$$GETWNR^IBCNSMM1
 I 'IBCNSP W !!,*7,?3,IBCNSP S IBQUIT=1
 Q
 ;
VALHIC(X) ; Edits for validating HIC #
 ; X = the HIC # to be validated
 N VAL
 S VAL=1
 I X'?9N1A.1AN,X'?1.3A6N,X'?1.3A9N S VAL=0
 Q VAL
 ;
COM(X,Y) ; Compare X with the intake variables.
 ;    Input: X => 0th node of policy in file #2.312
 ;           Y => A (Part A) or B (part B)
 ;   Output: IBHIT=1 (no changes made)
 S IBHIT=0
 I $P(X,"^",17)'=IBNAME G COMQ
 I $P(X,"^",2)'=IBHICN G COMQ
 I $P(X,"^",8)'=$S(Y="A":IBAEFF,1:IBBEFF) G COMQ
 I $P(X,"^",20)'=IBCOBI G COMQ
 ;
 S IBHIT=1
COMQ Q
