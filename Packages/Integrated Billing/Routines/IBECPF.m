IBECPF ;ALB/RLW - IB FLAG/UNFLAG CONTINUOUS PATIENTS ; 1-JAN-92
 ;;2.0; INTEGRATED BILLING ;**199**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBECPF-1" D T0^%ZOSV ;start rt clock
 D DT^DICRW S IBDATE=%
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC="^IBE(351.1,",DIC(0)="AELMQZ",DLAYGO=351.1,DIC("A")="Select PATIENT: " D ^DIC K DIC
 G:+Y<0 ENQ
 I $P(Y,"^",3)=1 S DR=".02;.03////"_DUZ_";.04////"_IBDATE
 E  S DR=".01;.02;.05////"_DUZ_";.06////"_IBDATE
 S DIE="^IBE(351.1,",DA=+Y,DIDEL=351.1 D ^DIE K DIE,DA,DR,Y,DIDEL
ENQ ;
 K IBDATE
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBECPF" D T1^%ZOSV ;stop rt clock
 Q
