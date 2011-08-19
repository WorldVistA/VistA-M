IBCCC1 ;ALB/AAS - CANCEL AND CLONE A BILL - CONTINUED ;25-JAN-90
 ;;2.0;INTEGRATED BILLING;**80,109,106,51,320,358,433**;21-MAR-94;Build 36
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRCC1
 ;
 ;STEP 1 - cancel bill
 ;STEP 1.5 - entry to clone previously cancelled bill.  (must be cancell)
 ;STEP 2 - build array of IBIDS call screen that asks ok
 ;STEP 3 - pass stub entry to ar
 ;STEP 4 - store stub data in MCCR then x-ref
 ;STEP 4.5 - store claim clone info on "S1" node.
 ;STEP 5 - get remainder of data to move and store in MCCR then x-ref
 ;STEP 6 - go to screens, come out to IBB1 or something like that
 ;
STEP4 S X=$P($T(WHERE),";;",2) F I=0:0 S I=$O(IBIDS(I)) Q:'I  S X1=$P($E(X,$F(X,I)+1,999),";",1),$P(IBDR($P(X1,"^",1)),"^",$P(X1,"^",2))=IBIDS(I)
 S IBIFN=PRCASV("ARREC") F I=0,"C","M","M1","S","U","U1" I $D(IBDR(I)) S ^DGCR(399,IBIFN,I)=IBDR(I)
 D  ; Protect variables;index entry;replace FT if copy/clone and it chngs
 . N IBHOLD,DIE,DR,DA,X,Y
 . S IBHOLD("FT")=$P($G(^DGCR(399,IBIFN,0)),U,19)
 . S $P(^DGCR(399,0),"^",3)=IBIFN,$P(^(0),"^",4)=$P(^(0),"^",4)+1 W !,"Cross-referencing new billing entry..." D INDEX^IBCCC2
 .; I $G(IBCNCOPY),IBHOLD("FT"),IBHOLD("FT")'=$P($G(^DGCR(399,IBIFN,0)),U,19) S DA=IBIFN,DIE="^DGCR(399,",DR=".19////"_IBHOLD("FT") D ^DIE
 . I $G(IBCNCOPY)!$G(IBCNCRD),IBHOLD("FT"),IBHOLD("FT")'=$P($G(^DGCR(399,IBIFN,0)),U,19) S DA=IBIFN,DIE="^DGCR(399,",DR=".19////"_IBHOLD("FT") D ^DIE
 S IBYN=1 W !!,*7,"Billing Record #",$P(^DGCR(399,+IBIFN,0),"^",1)," established for '",VADM(1),"'..."
 S:$G(IBCE("EDI")) IBCE("EDI","NEW")=IBIFN
 I $G(IBCE("EDI"))!($G(IBCTCOPY)=1) S IBHV("IBIFN1")=IBIFN ; New bill #
 S IBBCT=IBIFN   ;bill the old claim was cloned TO.
END K %,%DT,IB,IBA,IBNWBL,IBBT,IBIDS,I,J,VADM,X,X1,X2,X3,X4,Y
 ;
STEP4P5 ;added in patch 320
 ;first, put the TO data on the FROM bill
 ; Skip if not a CLON or CRD claim
 ;
 I '$G(IBCNCOPY)&('$G(IBCNCRD)) G STEP45X
 S DIE="^DGCR(399,",DA=IBBCF,DR="29////"_$G(IBBCT) D ^DIE
 S DIE="^DGCR(399,",DA=IBBCF,DR="31////"_$G(IBDBC) D ^DIE
 S DIE="^DGCR(399,",DA=IBBCF,DR="32////"_$G(IBBCB) D ^DIE
 ;
 ; esg - 8/23/06 - IB*2*358 - fix semi-colon in free text field
 S DIE="^DGCR(399,",DA=IBBCF,DR="33////^S X=$G(IBCCR)" D ^DIE
 ;
 ;now, put the FROM data on the TO bill
 ;
 S DIE="^DGCR(399,",DA=IBBCT,DR="30////"_$G(IBBCF) D ^DIE
 ;
STEP45X G ^IBCCC2 ;go to step 5
 ;
XREF F IBI1=0:0 S IBI1=$O(^DD(399,IBI,1,IBI1)) Q:'IBI1  I $D(^DD(399,IBI,1,IBI1,1)) S DA=IBIFN,X=IBIDS(IBI) I X]"" X ^DD(399,IBI,1,IBI1,1)
 Q
 ;
WHERE ;;.01^0^1;.02^0^2;.03^0^3;.04^0^4;.05^0^5;.06^0^6;.07^0^7;.08^0^8;.09^0^9;.11^0^11;.12^0^12;.17^0^17;.18^0^18;.19^0^19;.15^0^15;.16^0^16;.21^0^21;.22^0^22;.23^0^23;.24^0^24;.25^0^25;.26^0^26;.27^0^27;151^U^1;152^U^2;155^U^5;159.5^U^20;
 ;
