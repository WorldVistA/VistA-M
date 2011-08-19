IBAREP ;ALB/AAS - INTEGRATED BILLING - REPOST IB ACTION TO FILER ; 1-APR-91
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBAREP" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBAREP-1" D T0^%ZOSV ;start rt clock
 ;
 S DIC="^IB(",DIC(0)="AEQMN" D ^DIC G:Y<1 END S IBN=+Y
 D CHK G %
 ;
CHK S IBND=$S($D(^IB(IBN,0)):^(0),1:"") I 'IBND W !,"ZEROTH NODE MISSING" D CANT Q
 I $P(IBND,"^",12) W !,"Transaction number already assigned" D CANT Q
 I $P(IBND,"^",5)>2&($P(IBND,"^",5)'=9) W !,"Status indicates it's complete" D CANT Q
 S DIR(0)="Y",DIR("A")="Are You SURE: ",DIR("B")="NO" D ^DIR K DIR I 'Y D CANT Q
 D POST
 Q
 ;
POST ;
 S IBND=^IB(IBN,0),DFN=$P(IBND,"^",2),IBATYP=$P(IBND,"^",3)
 S IBSEQNO=$S('IBATYP:"",$D(^IBE(350.1,IBATYP,0)):$P(^(0),"^",5),1:"")
 D NOW^%DTC S IBNOW=%
 S IBDUZ=DUZ
 S IBNOS=IBN
 I DFN,IBSEQNO,DUZ,IBNOS D ^IBAFIL W !,"Attempting to Repass!",!! Q
 E  W !,"Not enough data to repost"
 Q
 ;
CANT W !,"Nothing Passed!",!! Q
END K %,%I,DFN,DIC,X,Y,I,IBN,IBNOS,IBSEQNO,IBATYP,IBNOD,IBDUZ,IBAFY,IBARTYP,IBFAC,IBIL,IBND,IBNOW,IBSERV,IBSITE,IBTOTL,IBTRAN,IBWHER,DUOUT,DFN,IBHDT,IBOERR
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBAREP" D T1^%ZOSV ;stop rt clock
 Q
