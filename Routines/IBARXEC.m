IBARXEC ;ALB/AAS -RX CO-PAY INCOME EXEMPTION CONVERSION ; 2-NOV-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% Q:'$D(^IBE(350.9,1,0))
 ;
EN ; -- Entry Point to run conversion from start date of exemption to 
 ;    today
 ;
USER I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must equal '@' to run the conversion.",! G END
 ;
 S IBDT=$$STDATE^IBARXEU,IBEDT=DT
 S IBCONVER=1,IBQUIT=0
 ;
 ; -- make sure variable set
 D DT^DICRW,HOME^%ZIS W @IOF,?15,"IB Medication Copayment Exemption Conversion",!!!
 I $P($G(^IBE(350.9,1,3)),"^",3)="" D HELP^IBARXEC0
 G:IBQUIT END
 ;
 ; -- make sure environment is set
 I '$D(^IBA(354,0)) W !,"You must first install patch IB*1.5*9!" G END
 S X="PRCAX" X ^%ZOSF("TEST") I '$T W !,"You must first install patch PRCA*3.7*8!" G END
 S X="DGMTCOU1" X ^%ZOSF("TEST") I '$T W !,"You must first install MAS patch DG*5.2*??!" G END
 I $D(^DGMT(408.31,"AID",1))'=10 W !,"You must re-run the Post-Init to the DGYGINIT routines, missing cross-referece" G END
 ;
REFUND ; -- make sure AR set up for refunds
 D  I IBQUIT G END
 .I '$D(^DIC(49,"D","04")) S IBQUIT=1
 .I '$D(^DIC(49,"B","FISCAL")) S IBQUIT=1
 .I IBQUIT W !,"In order to do refunds a service of 'FISCAL' with a mail symbol of 04 must ",!,"be defined",!
 .Q
 ;
 ; -- make sure not already done
 K IBDONE
 S Y=$P($G(^IBE(350.9,1,3)),"^",14) I Y S IBDONE=1 W !!,"Conversion already finished on " D DT^DIQ W !!,"Reprinting the Report...",! G DEV
 ;
 ; -- check if running alread running
 I $D(IBCONVER) S IBARXJOB=+$P($G(^IBE(350.9,1,3)),"^",3) D
 .;
 .S IBARXJOB=IBARXJOB+1
 .I IBARXJOB=1 D NOW^%DTC S $P(^IBE(350.9,1,3),"^",13)=% Q  ; -- first time to run conversion
 .;
 .W !,*7,"WARNING: Conversion May Already be Running!",!,"Check your system status if you are unsure.",!!
 .D RESTART^IBARXEC0
 .S DIR(0)="Y",DIR("A")="Are You Sure you Want to Restart",DIR("B")="NO"
 .D ^DIR K DIR I 'Y!($D(DIRUT)) K IBARXJOB Q
 .Q
 ;
 I '$D(IBARXJOB) G END
 S $P(^IBE(350.9,1,3),"^",3)=IBARXJOB
 ;
DEV W !!,"You will need a 132 column printer for this report!",!
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBARXEC3",ZTSAVE("IB*")="",ZTDESC="IB Medication Copayment Exemption Conversion" D ^%ZTLOAD D HOME^%ZIS G END
 ;
 G DQ^IBARXEC3
 ;
END K ^TMP("IBCONV",$J)
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K DIC,DIE,DA,DR,D0,DGT,DIR,DIRUT,ERR,I,J,LINE,XMZ
 K IBAFY,IBARXJOB,IBCANDT,IBCBCNT,IBCEAMT,IBCECNT,IBCONVER,IBDONE,IBEAMT,IBECNT,IBEFAC,IBL,IBLAST,IBLDT,IBNAMT,IBNCNT,IBND,IBNECNT,IBNOW,IBPARDT,IBPARNT,IBPARNT1,IBQUIT,IBJOB,IBWHER,IBEXERR
 K IBDT,IBEDT,IBJ,IBSITE,IBSTAT,IBTBCNT,IBTCBCNT,IBTCEAMT,IBTCECNT,IBTEAMT,IBTECNT,IBTNAMT,IBTNCNT,IBTNECNT,IBADD,IBADDE,IBDATA,IBDEPEN,IBERR,IBEXREA,IBFAC
 D ^%ZISC
 Q
