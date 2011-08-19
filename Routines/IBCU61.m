IBCU61 ;ALB/AAS - DELETE ENTRIES IN REVENUE CODE MULT. ; 4-MAY-90
 ;;2.0;INTEGRATED BILLING;**153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRU61
 ;
ALL ;delete all revenue codes that may have been set up automatically
 ;ie = $d(^IB(399.5,"d",code ifn))
 K DA S DA(1)=IBIFN,DA=0 I '$G(IBAUTO) W !,"Removing old Revenue Codes."
 F DGII=0:0 S DA=$O(^DGCR(399,IBIFN,"RC",DA)) Q:DA<1  S X=$G(^DGCR(399,IBIFN,"RC",DA,0)) D
 . ;remove revenue codes pre-defined for automatic use AND revenue codes for BASC charges (are automatically created)
 . I $D(^DGCR(399.5,"D",+$P(X,"^")))!($D(^DGCR(399,"ASC1",+$P(X,U,6),IBIFN)))!(+$P(X,U,8)) W:'$G(IBAUTO) "." D DEL
 Q
DEL S DIK="^DGCR(399,"_DA(1)_",""RC""," D ^DIK L ^DGCR(399,IBIFN):1
 Q
 ;
GVAR ;I $D(PTF),PTF]"",$D(^DGPT(PTF,0)),'$P(^DGPT(PTF,0),"^",6),$D(DGPTUPDT) D UPDT^DGPTUTL S DGPTUPDT="" ;if open, update ptf record
 S IBND0=$S('$D(^DGCR(399,IBIFN,0)):"",1:^(0))
 S IBNDU=$S('$D(^DGCR(399,IBIFN,"U")):"",1:^("U"))
 I '$D(IBIDS(.03)) S IBIDS(.03)=$P(IBND0,"^",3)
 I '$D(IBIDS(.05)) S IBIDS(.05)=$P(IBND0,"^",5)
 I '$D(IBIDS(.06)) S IBIDS(.06)=$P(IBND0,"^",6)
 I '$D(IBIDS(.11)) S IBIDS(.11)=$P(IBND0,"^",11)
 I '$D(IBIDS(.19)) S IBIDS(.19)=$P(IBND0,"^",19)
 I '$D(IBIDS(151)) S IBIDS(151)=$S(+IBNDU:+IBNDU,1:IBIDS(.03))
 I '$D(IBIDS(152)) S IBIDS(152)=$S(+$P(IBNDU,"^",2):$P(IBNDU,"^",2),1:IBIDS(.03))
 I '$D(IBIDS(101)),IBIDS(.11)="i",$D(^DGCR(399,IBIFN,"M")),+^("M"),$D(^DIC(36,+^("M"),0)) S IBIDS(101)=+^DGCR(399,IBIFN,"M")
 I IBIDS(.11)="i",'$D(IBIDS(101)) S IBQUIT=1 Q
 ;I IBIDS(.11)="i" S DGINPAR=$S('$D(^DIC(36,+IBIDS(101),0)):"",1:$P(^(0),"^",6,10))
 I IBIDS(.11)="i" S DGINPAR=$S('$D(^DIC(36,+IBIDS(101),0)):"",1:$P(^(0),"^",6,15))
 ;
CAT ;check patient bills to see if Means Test. set IBIDS(.11)="y" (yes)
 ;I IBIDS(.11)="p",$P(^PRCA(430.2,$P(^DGCR(399.3,$P(^DGCR(399,IBIFN,0),"^",7),0),"^",6),0),"^",6)="C" S IBIDS(.11)="c"
 I IBIDS(.11)="p",$P($$CATN^PRCAFN(+$P(^DGCR(399.3,+$P(^DGCR(399,IBIFN,0),"^",7),0),"^",6)),"^",3)="C" S IBIDS(.11)="y"
 Q
