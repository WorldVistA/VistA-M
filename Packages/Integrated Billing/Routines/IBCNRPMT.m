IBCNRPMT ;DAOU/ALA - Match Group Plan to Pharmacy Plan ;14-NOV-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program select an insurance company and displays
 ;  all the active group plans for that insurance company
 ;
EN ;  Select an insurance company
 S DIR(0)="350.9,4.06"
 S DIR("A")="Select INSURANCE COMPANY",DIR("??")="^D ADH^IBCNSM3"
 S DIR("?")="Select the Insurance Company for the plan you are entering"
 D ^DIR K DIR S IBCNSP=+Y I Y<1 G EXIT
 I $P($G(^DIC(36,+IBCNSP,0)),"^",2)="N" W !,"This company does not reimburse.  "
 I $P($G(^DIC(36,+IBCNSP,0)),"^",5) W !,*7,"Warning: Inactive Company" H 3 K IBCNSP G EXIT
 ;
GRP NEW DIC,DTOUT,DUOUT,X,Y
 S (IBIND,IBMULT,IBW)=1
 S DIC(0)="BEFSXZ"
 S DIC("S")="S DNM=$NA(^(0)),DIEN=$QS(DNM,2),GST=$$GPS^IBCNRPMT(IBCNSP,DIEN),DIEN=$G(@DNM) I GST'=0"
 S DIC("W")="W $P(^(0),U,3),"" - "",$P(^(0),U,4)"
 S DIC="^IBA(355.3,"
 S D="B",X=IBCNSP
 D IX^DIC I Y<1 G EN
 S IBCNGP=+Y
 ;
 D EN^IBCNRP
 G EN
 ;
GPS(INIEN,GPIEN) ;  screen for valid GIPF
 ;W !,"***",GPIEN
 N GST1,GP0,IBCOV,LIM,IBCOV
 S GST1=1
 S GP0=$G(^IBA(355.3,GPIEN,0))
 ;chk insurance company
 I $P(GP0,U,1)'=INIEN S GST1=0 Q GST1
 ;chk for active group
 I $P(GP0,U,11)=1 S GST1=0 Q GST1
 ;chk for pharm plan coverage
 S IBCOV=$O(^IBE(355.31,"B","PHARMACY",""))
 S LIM="",IBCVRD=0
 F  S LIM=$O(^IBA(355.32,"B",GPIEN,LIM)) Q:LIM=""  D
 . I $P(^IBA(355.32,LIM,0),U,2)=IBCOV D
 .. ;chk covered status
 .. S IBCVRD=$P(^IBA(355.32,LIM,0),U,4)
 I IBCVRD=0 S GST1=0
 ;W !,"***",GPIEN," - ",GST1 ;
 Q GST1
 ;
EXIT K IBCNSP,IBCPOL,IBIND,IBMULT,IBSEL,IBW,IBALR,IBGRP,IBCNGP
 Q
