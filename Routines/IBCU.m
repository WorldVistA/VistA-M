IBCU ;ALB/MRL - BILLING UTILITY ROUTINE ;01 JUN 88 12:00
 ;;2.0;INTEGRATED BILLING;**52,106,51,191,232,323,320,384**;21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRU
 ;
ARSTAT ;find status of bill in file 430.3 (ar) return status number
 S IBARST=$$STA^PRCAFN(IBIFN)
 Q
 ;
ARCAT ;Trigger logic to set who's responsible in 399.3 from AR Category
 S X=$P($$CATN^PRCAFN($P(^DGCR(399.3,DA,0),"^",6)),"^",3)
 S:X'="" X=$S("PC"[X:"p",X="N":"o",X="T":"i",1:"")
 Q
 ;
PTF ;Screen for appropriate PTF records
 K IBDD1 S DFN=+$P(^DGCR(399,+DA,0),"^",2) Q:'$D(^DPT(+DFN,0))  S IB05=$P(^(0),"^",1),IB03=$P(^DGCR(399,+DA,0),"^",3)
 S IB01="",IB02=0 F IB02=0:0 S IB01=$O(^DD(45,0,"ID",IB01)) Q:'IB01  S IB02=IB02+1,IBDD(IB02)=^(IB01)
 F IB01=0:0 S IB01=$O(^DGPT("B",+DFN,IB01)) Q:'IB01  I $D(^DGPT(+IB01,0)) S IB04=$P(^(0),"^",2),Y=+IB01 I $P(IB03,".",1)=$P(IB04,".",1) S IBDD1(+Y)="" I $S('$D(X):0,X["?":1,1:0) D PTFW
 G PTFQ:X'["?" I '$O(IBDD1(0)) W !,"Patient has no ACTIVE PTF RECORDS for this event date.",!,"A 'PTF NUMBER' is required for inpatient billing records."
 E  W !!,"Select the appropriate billing record from the above listing by number."
PTFQ W ! K IB01,IB02,IB03,IB04,IB05,IBDD Q
PTFW W !,Y,?15,IB05 F IB02=0:0 S IB02=$O(IBDD(IB02)) Q:'IB02  X IBDD(IB02)
 Q
 ;
AGE ;Input Transform for Condition Code 17
 I X=18 G SEX
 I X=17 S IBC=X,DFN=$P(^DGCR(399,D0,0),"^",2) D DEM^VADPT I VADM(4)<100 W !!,"This patient is only ",VADM(4)," years old!!",!! K IBC Q
 I $D(IBC) S X=IBC
 Q
 ;
SEX ;Input Transform for Condition Code 18
 I X=18 S IBC=X,DFN=$P(^DGCR(399,D0,0),"^",2) D DEM^VADPT I $E(VADM(5))="M" W !!,"This patient is a MALE!! Condition code 18 applies only to FEMALES!!",!! K IBC,X
 I $D(IBC) S X=IBC
 Q
 ;
REV ;Input Transform for Revenue Code
 I X=-1 W !!,"Choose only ACTIVE Revenue Codes!!",!! S D="AC" ;S X="" S X=$O(^DGCR(399.2,"AC",X)) Q:X=""  W !,$P(^DGCR(399.2,X,0),"^",1),?30,$P(^(0),"^",2) K X Q
 I '$D(IBC) I $D(^DGCR(399.2,X,0)) I '$P(^DGCR(399.2,X,0),"^",3) W !!,"Only ACTIVE Revenue Codes may be selected!!",!! K X Q
 Q
 ;
YN S X=$E(X),X=$S(X=1:X,X=0:X,X="Y":1,X="y":1,X="n":0,X="N":0,1:2) I X'=2 D EN^DDIOL("  ("_$S(X:"YES",1:"NO")_")","","?0") Q
 D EN^DDIOL("NOT A VALID CHOICE!","","!?4") K X Q
 Q
 ;
NOPTF ; Input transform for file 399, field 159.5 (NON-VA ADMIT TIME)
 N %DT
 I X>24 K:X'=99 X Q
 I $P($G(^DGCR(399,DA,0)),U,8) K X Q  ; PTF pointer exists 
 S X=$TR(X,"M ") S:X=0 X="12A" S:X<12 X=$TR(X,"A")
 S:X?1N.N&($L(X)<3) Y="."_$E("0",$L(X))_X S:X'?1.2N %DT="TPR",X=DT_"@"_X D:$L(X)>2 ^%DT S X=$E($P(Y,".",2)_"00",1,2)#24 K:Y=-1 X
 Q
 ;
DIS ;Determine Billing Discharge status from PTF
 ;Called from triggers on fields .08 and 161
 N A
 I '$D(^DGCR(399,DA,0)) S X="" G DISQ
 S X=$P(^DGCR(399,DA,0),"^",6) I X=2!(X=3) S X=$O(^DGCR(399.1,"B","STILL PATIENT",0)) G DISQ
 S X=$P(^DGCR(399,DA,0),"^",8) I $S(X="":1,'$D(^DGPT(X)):1,1:0) S X="" G DISQ
 I '+$G(^DGPT(X,70)) S X=$O(^DGCR(399.1,"B","STILL PATIENT",0)) G DISQ
 S A=$P($G(^DGCR(399,DA,"U")),"^",2) I A,(A+.24)<+$G(^DGPT(X,70)) S X=$O(^DGCR(399.1,"B","STILL PATIENT",0)) G DISQ
 S X=+$P($G(^DGPT(X,70)),"^",3)
 I X=1 S X=$O(^DGCR(399.1,"B",$E("DISCHARGED TO HOME OR SELF CARE",1,30),0)) G DISQ
 I X=4 S X=$O(^DGCR(399.1,"B",$E("LEFT AGAINST MEDICAL ADVICE",1,30),0)) G DISQ
 I X=6!(X=7) S X=$O(^DGCR(399.1,"B","EXPIRED",0)) G DISQ
 I X=5!(X=2) S X=$O(^DGCR(399.1,"B",$E("DISCHARGED TO ANOTHER SHORT-TERM GENERAL HOSPITAL",1,30),0)) G DISQ
 S X=""
DISQ Q
 ;
INST ;Ask Institutution address info
 S DIC("DR")="1.01;1.02;1.03;.02;1.04" I $D(^XUSEC("IB SUPERVISOR",DUZ)) S DLAYGO=4
 Q
 ;
PTADD(DFN,MAXL) ; outputs patient address for the trigger on Patient Short Address (399,110)
 N IBX,IBY,IBI,IBDPT S (IBX,IBDPT)="" I $G(MAXL)="PSA" S MAXL=47
 I +$G(DFN) S IBDPT=$G(^DPT(DFN,.11)) F IBI=1:1:4 S IBY=$P(IBDPT,U,IBI) I IBY'="" S IBX=IBX_IBY_","
 I +$P(IBDPT,U,5) S IBY=$P($G(^DIC(5,+$P(IBDPT,U,5),0)),U,2),IBX=IBX_IBY
 I $P(IBDPT,U,12)'="" S IBX=IBX_" "_$P(IBDPT,U,12)
 I +$G(MAXL),$L(IBX)>+MAXL S IBX=""
 Q IBX
 ;
SM ;Flag for printing medicare statment on UB-82
 ;DGSM=0 means figure out which statement, DGSM=1 means no statements
 S DGSM=0 Q
 ;IBCU
 ;
CHGTYP(IBIFN,ARR) ; sets up array of all charge types defined on a bill:  ARR(TYPE, COMPONENT)=""
 N IBI,IBX,IBT K ARR
 I +$O(^DGCR(399,+$G(IBIFN),"RC",0)) S IBI=0 F  S IBI=$O(^DGCR(399,+IBIFN,"RC",IBI))  Q:'IBI  D
 . S IBX=$G(^DGCR(399,+IBIFN,"RC",IBI,0)),IBT=$P(IBX,U,10) I +IBT S ARR(IBT,+$P(IBX,U,12))=""
 Q
 ;
CHGTYPE(IBIFN) ; returns list of charge types on a bill: TYPE ^ TYPE ^ ... ; EXTERNAL TYPE , EXTERNAL TYPE , ...
 N IBAR,IBY,IBS,IBI,IBC,IBJ,IBX
 D CHGTYP($G(IBIFN),.IBAR)
 S (IBX,IBY,IBS)="",IBI=0 F  S IBI=$O(IBAR(IBI)) Q:'IBI  D
 . S IBX=IBX_IBI_U
 . S IBC="INPT" I IBI=1 S IBJ=$O(IBAR(IBI,0)),IBC=$S(IBJ=1:"INST",IBJ=2:"PF",1:"INPT") I +$O(IBAR(IBI,IBJ)) S IBC="INPT"
 . S IBY=IBY_IBS_$S(IBI=1:IBC,IBI=2:"VST",IBI=3:"RX",IBI=4:"CPT",IBI=5:"PI",IBI=6:"DRG",IBI=9:"UN",1:""),IBS=","
 S IBY=IBX_";"_IBY
 Q IBY
 ;
BCHGTYPE(IBIFN) ; returns type of bill and charges: (CLASS (.05): TYPE, TYPE, ...)
 N IBCLASS,IBTYPE,IBY S IBY=""
 S IBCLASS=$P($G(^DGCR(399,+$G(IBIFN),0)),U,5)
 S IBTYPE=$P($$CHGTYPE(+$G(IBIFN)),";",2) I IBTYPE="INPT" S IBTYPE=""
 I +IBCLASS S IBY=$S(IBCLASS<3:"Inpt",1:"Opt") I IBTYPE'="" S IBY=IBY_" ("_IBTYPE_")"
 Q IBY
 ;
CLNSCRN(IBDT,CLIFN) ; screen for a Procedures Associated Clinic  (399, 304, 6), returns true if clinic can be used
 ; clinic must be defined as a 'Clinic' and it must be active on date of procedure
 ;
 N IBCL0,IBCLI,IBX S IBX=0
 S IBCL0=$G(^SC(+$G(CLIFN),0)),IBCLI=$G(^SC(+$G(CLIFN),"I"))
 S IBX=$S($P(IBCL0,U,3)'="C":0,'$G(IBDT):0,'IBCLI:1,+IBCLI>+IBDT:1,'$P(IBCLI,U,2):0,1:$P(IBCLI,U,2)'>IBDT)
 Q IBX
 ;
PRVNUM(IBIFN,IBINS,COB) ; Trigger code (399:122,123,124)
 ; on Primary Secondary/Tertiary Carrier (399:101,102,103)
 ; returns the Provider Number for the Insurance Company
 ;         Hospital Provider Number for prov id in file 355.92
 ;         or Medicare A provider Number (psych/non-psych) if Medicare A
 ;
 ; Input   IBIFN - bill ifn
 ;         IBINS - insurance company ifn (opt)
 ;         COB   - 1 for primary, 2 for secondary, 3 for tertiary
 ;
 N IBX,IBB0,IBBF,IBFT,Z,Z0
 S:'$G(COB) COB=1
 S IBX=$P($G(^DGCR(399,+$G(IBIFN),"M1")),U,COB+1),IBB0=$G(^DGCR(399,+$G(IBIFN),0))
 I $G(IBINS)="" S IBINS=+$G(^DGCR(399,+$G(IBIFN),"I"_COB))
 G:'IBINS PRVNQ
 ;
 ; OEC - 12/21/05 - If an MRA is being processed into an MRA secondary
 ; claim and the billing provider # already exists, then leave it
 I $G(IBPRCOB),IBX'="" G PRVNQ
 ;
 I +$G(IBIFN),COB N DA S DA=IBIFN I $$MCRACK^IBCBB3(+IBIFN,$P($G(^DGCR(399,+IBIFN,"TX")),U,5),+COB) S IBX=$$MCRANUM^IBCBB3(+IBIFN) G PRVNQ
 ;
 ; WCJ - 1/17/06 - Some Insurances require certain electronic plan types to have no secondary ID
 ; Check if this plan type requires a blank sec id to go out for this insurance
 N NOSEC S NOSEC=0
 I $D(^DIC(36,IBINS,13)),$G(IBIFN) D
 . N PLAN,PLANTYPE
 . S PLAN=$P($G(^DGCR(399,IBIFN,"I"_COB)),U,18) Q:'PLAN
 . S PLANTYPE=$P($G(^IBA(355.3,PLAN,0)),U,15) Q:'PLANTYPE
 . Q:'$D(^DIC(36,IBINS,13,"B",PLANTYPE))
 . S NOSEC=1,IBX=""
 I NOSEC G PRVNQ
 ;
 ; If using attending/rendering secondary ID, don't do anything
 I $$FT^IBCEF(IBIFN)=2,$$GET1^DIQ(36,IBINS,4.06,"I") G PRVNQ
 I $$FT^IBCEF(IBIFN)=3,$$GET1^DIQ(36,IBINS,4.08,"I") G PRVNQ
 ;
 S IBX=$$FACNUM^IBCEP2B(IBIFN,COB)
 ;
 I IBX="" S IBX=$$GET1^DIQ(350.9,1,1.05)
 ;
PRVNQ Q IBX
 ;
BF() ; Returns ien of billing fac primary id type
 N Z,IBX
 S IBX="",Z=0 F  S Z=$O(^IBE(355.97,Z)) Q:'Z  I $P($G(^(Z,1)),U,9) S IBX=Z Q
 Q IBX
 ;
BILLPNS(IBIFN) ; Trigger Code that sets all Bill P/S/T Prov# and QUAL (399: .122,123,124,128,129,130)
 ; on Bill Form Type (399:.19)
 N IBDR
 ;
 I +$G(^DGCR(399,+$G(IBIFN),"I1")) S IBDR(399,IBIFN_",",122)=$$PRVNUM(IBIFN,"",1),IBDR(399,IBIFN_",",128)=$$PRVQUAL(IBIFN,"",1)
 I +$G(^DGCR(399,+$G(IBIFN),"I2")) S IBDR(399,IBIFN_",",123)=$$PRVNUM(IBIFN,"",2),IBDR(399,IBIFN_",",129)=$$PRVQUAL(IBIFN,"",2)
 I +$G(^DGCR(399,+$G(IBIFN),"I3")) S IBDR(399,IBIFN_",",124)=$$PRVNUM(IBIFN,"",3),IBDR(399,IBIFN_",",130)=$$PRVQUAL(IBIFN,"",3)
 ;
 I $O(IBDR(0)) D FILE^DIE("","IBDR")
 Q
 ;
PRVQUAL(IBIFN,IBINS,COB) ; Trigger code for Bill P/S/T Prov QUAL (399:128,129,130)
 ; on P/S/T Carrier (399: 101,102,103)
 ; returns the Provider ID QUALIFIER
 ;
 ; Input   IBIFN - bill ifn
 ;         IBINS - insurance company ifn (opt)
 ;         COB   - 1 for primary, 2 for secondary, 3 for tertiary
 ;
 N IBX,IBB0,IBBF,IBFT,Z,Z0
 S:'$G(COB) COB=1
 S IBX=$P($G(^DGCR(399,+$G(IBIFN),"M1")),U,COB+9),IBB0=$G(^DGCR(399,+$G(IBIFN),0))
 I $G(IBINS)="" S IBINS=+$G(^DGCR(399,+$G(IBIFN),"I"_COB))
 G:'IBINS PRVQUALQ
 ;
 ; If an MRA is being processed into an MRA secondary claim and the
 ; billing provider qualifier already exists, then leave it alone
 I $G(IBPRCOB),IBX'="" G PRVQUALQ
 ;
 I +$G(IBIFN),COB N DA S DA=IBIFN I $$MCRACK^IBCBB3(+IBIFN,$P($G(^DGCR(399,+IBIFN,"TX")),U,5),+COB) S IBX=$$FIND1^DIC(355.97,,"MX","MEDICARE PART A") G PRVQUALQ
 ;
 ; Some Insurances require certain electronic plan types to have no secondary ID
 ; If this is the case, there is no qualifier
 N NOSEC S NOSEC=0
 I $D(^DIC(36,IBINS,13)),$G(IBIFN) D
 . N PLAN,PLANTYPE
 . S PLAN=$P($G(^DGCR(399,IBIFN,"I"_COB)),U,18) Q:'PLAN
 . S PLANTYPE=$P($G(^IBA(355.3,PLAN,0)),U,15) Q:'PLANTYPE
 . Q:'$D(^DIC(36,IBINS,13,"B",PLANTYPE))
 . S NOSEC=1,IBX=""
 I NOSEC G PRVQUALQ
 ;
 ; Leave qualifer blank if sending REND/ATT ID
 I $$FT^IBCEF(IBIFN)=2,$$GET1^DIQ(36,IBINS,4.06,"I") G PRVQUALQ
 I $$FT^IBCEF(IBIFN)=3,$$GET1^DIQ(36,IBINS,4.08,"I") G PRVQUALQ
 ;
 S IBX=$$FACNUM^IBCEP2B(IBIFN,COB,1)
 ;
 I IBX="",$$GET1^DIQ(350.9,1,1.05)=$P($G(^DGCR(399,IBIFN,"M1")),U,COB+1) S IBX=$$FIND1^DIC(355.97,,"MX","1J")
 ;
PRVQUALQ Q IBX
