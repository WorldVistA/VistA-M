IBCA2 ;ALB/MRL - ADD NEW BILL  ;01 JUN 88 12:00
 ;;2.0;INTEGRATED BILLING;**106**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRA2
 ;
 W !,"Passing bill to Accounts Receivable Module..." D SETUP^PRCASVC3
 I $S($P(PRCASV("ARREC"),U)=-1:1,$P(PRCASV("ARBIL"),U)=-1:1,1:0) W *7,"  ",$P(PRCASV("ARREC"),"^",2),!,$$ETXT^IBEFUNC($P(PRCASV("ARBIL"),"^",2)) D Q G NREC^IBCA
 S IBIDS(.01)=$P(PRCASV("ARBIL"),"-",2),IBIDS(.17)=$S($D(IBIDS(.17)):IBIDS(.17),1:PRCASV("ARREC"))
 W !,"Billing Record #",IBIDS(.01)," being established for '",VADM(1),"'..." S IBIDS(.02)=DFN
 ;D SC^IBCU3 ;calculate if SC veteran
 S IBIDS(.18)=$$SC^IBCU3(DFN) ; calculate if SC veteran
 D SPEC^IBCU4 ;calculate discharge bedsection
 S X=$P($T(WHERE),";;",2) F I=0:0 S I=$O(IBIDS(I)) Q:'I  S X1=$P($E(X,$F(X,I)+1,999),";",1),$P(IBDR($P(X1,"^",1)),"^",$P(X1,"^",2))=IBIDS(I)
 S IBIFN=PRCASV("ARREC") F I=0,"C","M","M1","S","U","U1" I $D(IBDR(I)) S ^DGCR(399,IBIFN,I)=IBDR(I)
 S $P(^DGCR(399,0),"^",3)=IBIFN,$P(^(0),"^",4)=$P(^(0),"^",4)+1 W !,"Cross-referencing new billing entry..." S DIK="^DGCR(399,",DA=IBIFN D IX1^DIK K DA,DIK
 S IBYN=1 W !!,*7,"Billing Record #",$P(^DGCR(399,+IBIFN,0),"^",1)," established for '",VADM(1),"'..."
 K DGPTUPDT D ^IBCU6
Q K %,%DT,IBI,IBJ,IBDSDT,IBX,IB,IBA,IBNWBL,IBBT,IBIDS,I,J,VADM,X,X1,X2,X3,X4,Y,DGDIRA,DGDIRB,DGDIR0,DIR,DGRVRCAL Q
 ;
XREF F IBI1=0:0 S IBI1=$O(^DD(399,IBI,1,IBI1)) Q:'IBI1  I $D(^DD(399,IBI,1,IBI1,1)) S DA=IBIFN,X=IBIDS(IBI) X ^DD(399,IBI,1,IBI1,1)
 Q
 ;
WHERE ;;.01^0^1;.02^0^2;.03^0^3;.04^0^4;.05^0^5;.06^0^6;.07^0^7;.08^0^8;.11^0^11;.17^0^17;.16^0^16;.18^0^18;.19^0^19;.22^0^22;.27^0^27;112^M^12;151^U^1;152^U^2;155^U^5;101^M^1;158^U^8;159^U^9;160^U^10;161^U^11;162^U^12;
 ;
WHEREOLD ;.01^0^1;.02^0^2;.03^0^3;.04^0^4;.05^0^5;.06^0^6;.07^0^7;.08^0^8;.11^0^11;.17^0^17;.16^0^16;.18^0^18;104^M^4;105^M^5;106^M^6;107^M^7;108^M^8;109^M^9;121^M1^1;151^U^1;152^U^2;155^U^5;101^M^1;158^U^8;159^U^9;160^U^10;161^U^11;162^U^12;
 Q
