IBRCON2 ;ALB/RJS - PASSING CHARGES TO A/R BY DATE - 4/28/92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
INIT ;
 S (IBRCOUNT,IBRDONE)=0
 S IBFEE="DG FEE SERVICE (OPT) NEW",IBFEE=$O(^IBE(350.1,"B",IBFEE,0))
 S IBOPT="DG OPT COPAY NEW",IBOPT=$O(^IBE(350.1,"B",IBOPT,0))
 I IBFEE=""!(IBOPT="") W !,"Error finding entries in file 350.1" G END
START ;
 S %DT("A")="Enter beginning date: "
 D PROMPT G:Y=-1 END
 S IBBEG=Y
 W !
 S %DT("A")="Enter ending date: "
 D PROMPT G:Y=-1 END
 I (Y<IBBEG) W !,"Ending date must be > or = start date!",!
 I  G START
 S IBENDING=Y
 W !!
 S SUBROUT="LOAD1" D LOOP,PROMPT2
 G:IBRDONE=1 END
 D QUEUED,HOME^%ZIS
END ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K %DT,DFN,IBCUTOFF,IBDUZ,IBNOS,IBRRCNR,IBRXXX,IBSEQNO,Y,XMY
 K IBEND,IBRCOUNT,IBRDONE,IBSTART,SUBROUT,XMDUZ,XMSUB,XMTEXT
 K IBFEE,IBOPT,DIR,%,%ZIS,IBBEG,IBENDING
 Q
NEXT ;
 D NOW^%DTC S IBSTART=$$DAT2^IBOUTL(%)
 S SUBROUT="LOAD2" D LOOP
 D NOW^%DTC S IBEND=$$DAT2^IBOUTL(%)
 D MAIL
 Q
LOOP ;
 S IBSEQNO=1,IBDUZ=DUZ
 F IBRXXX=IBFEE,IBOPT D
 .S IBRRCNR=0
 .F  S IBRRCNR=$O(^IB("AE",IBRXXX,IBRRCNR)) Q:IBRRCNR=""  D @SUBROUT
 Q
LOAD1 ;
 Q:$P($G(^IB(IBRRCNR,0)),U,17)=""!($P($G(^(0)),U,17)>IBENDING)!($P($G(^(0)),U,17)<IBBEG)!($P($G(^(0)),U,5)'=99)
 S IBRCOUNT=IBRCOUNT+1
 W "."
 Q
LOAD2 ;
 Q:$P($G(^IB(IBRRCNR,0)),U,17)=""!($P($G(^(0)),U,17)>IBENDING)!($P($G(^(0)),U,17)<IBBEG)!($P($G(^(0)),U,5)'=99)
 S IBNOS=IBRRCNR,DFN=$P(^IB(IBRRCNR,0),U,2)
 D ^IBR,ERR:Y<1
 Q
PROMPT ;
 S %DT="AEX" D ^%DT
 Q
ERR ;
 W !,"Error encountered - a separate bulletin has been posted"
 Q
PROMPT2 ;
 I IBRCOUNT=0 W !,"   There are no outpatient or fee basis converted",!,"   charges in this date range" S IBRDONE=1 Q
 W !!,"There are [ ",IBRCOUNT," ] charges to be passed to accounts receivable",!
 S DIR(0)="YA"
 S DIR("A")="Do you wish to pass these charges to accounts receivable (Y/N): "
 D ^DIR
 I Y'=1 S IBRDONE=1 Q
 Q
QUEUED ;
 S ZTIO="",ZTRTN="NEXT^IBRCON2",ZTDESC="IBRCON2 JOB TO PASS TO AR CONVERTED CHARGES",ZTSAVE("IB*")="" D ^%ZTLOAD W !!,$S($D(ZTSK):"Request Queued",1:"Request Cancelled")
 Q
OPEN ;
 S %ZIS="QM" D ^%ZIS
 Q
MAIL ;
 S XMSUB="PASSED CONVERTED CHARGES"
 S XMDUZ="INTEGRATED BILLING PACKAGE"
 S XMTEXT="IBT("
 K IBT,XMY
 S XMY(IBDUZ)=""
 S IBT(1)="The job that passes converted charges to accounts receivable"
 S IBT(2)="is complete."
 S IBT(3)="[ "_IBRCOUNT_" ] charges have been passed to accounts receivable."
 S IBT(4)=""
 S IBT(5)="Job started on  "_$P(IBSTART,"@",1)_" at "_$P(IBSTART,"@",2)
 S IBT(6)="Job finished on "_$P(IBEND,"@",1)_" at "_$P(IBEND,"@",2)
 D ^XMD
 Q
