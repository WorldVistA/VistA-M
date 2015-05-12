IBCU4 ;ALB/AAS - BILLING UTILITY ROUTINE (CONTINUED) ;12-FEB-90
 ;;2.0;INTEGRATED BILLING;**109,122,137,245,349,371,399,461,532**;21-MAR-94;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRU4
 ;
DDAT ;Input transform for Statement Covers From field
 I '$D(DA) G TO
 S IB00=+$P(^DGCR(399,+DA,0),"^",3) I +X<$P(IB00,".",1) W !?4,"Cannot precede the 'EVENT DATE'!",*7 K X G DDAT4
 I +X>(DT_".2359") W !?4,"Cannot bill for future treatment!",*7 K X G DDAT4
 D PROCDT
 I DGPRDTB,X>DGPRDTB K X W !?4,"Can't be greater than date of specified Procedures!",*7 G DDAT4
 G DDAT4
DDAT1 ;Input transform for Statement covers to
 I '$D(DA) G FROM
 S IB00=$S($D(^DGCR(399,+DA,"U")):$P(^("U"),"^",1),1:"") I 'IB00 W !?4,"'Start Date' must be specified first!",*7 K X G DDAT4
 I +X>DT W !?4,"Cannot bill for future treatment!",*7 K X G DDAT4
 I +X<IB00 W !?4,"Cannot precede the 'Start Date'!",*7 K X G DDAT4
 I $P($G(^DGCR(399,+DA,0)),U,5)>2,$$ICD10S(+IB00,+X) W !?4,"Bill Statement dates cannot span ICD-10 activation date!",*7 K X G DDAT4
 ;I $S($E(IB00,4,5)<10:$E(IB00,2,3),1:$E(IB00,2,3)+1)'=$S($E(X,4,5)<10:$E(X,2,3),1:$E(X,2,3)+1) K X W !?4,"Must be in same fiscal year!",*7 G DDAT4
 ;I $$FY(+IB00)'=$$FY(X) K X W !?4,"Must be in same fiscal year!",*7 G DDAT4
 ;I $E(IB00,1,3)'=$E(X,1,3) K X W !?4,"Must be in same calendar year!",*7 G DDAT4
 D PROCDT
 I DGPRDTE,X<DGPRDTE K X W !?4,"Can't be less than date of specified Procedures!",*7 G DDAT4
 G DDAT4
 ;
 ;DDAT2   ;Input transform for OP VISITS DATE(S) field  REPLACED WITH IBCU41 6/15/93
 ;S IB00=$G(^DGCR(399,IBIFN,"U")) I $P(IB00,"^",1)']"" W !?4,*7,"No 'Start Date' on file...can't enter OP visit dates..." K X G DDAT4
 ;I $P(IB00,"^",2)']"" W !?4,*7,"No 'End Date' on file...can't enter OP visit dates..." K X G DDAT4
 ;I X<$P(IB00,"^",1) W !?4,*7,"Can't enter a visit date prior to 'Start Date'..." K X G DDAT4
 ;I X>$P(IB00,"^",2) W !?4,*7,"Can't enter a visit date later than 'End Date'..." K X G DDAT4
 ;I $P(^DGCR(399,IBIFN,0),"^",19)'=2,$D(^DGCR(399,"ASC2",IBIFN)),$O(^DGCR(399,IBIFN,"OP",0)) W !?4,*7,"Only 1 visit date allowed on bills with Amb. Surg. Codes!" K X G DDAT4
 ;D APPT^IBCU3,DUPCHK^IBCU3
 G DDAT4
 ;
DDAT3 ; - x-ref call for to and from dates, REPLACED BY TRIGGERS ON .08, 151, 152 ON 10/18/93
 ;if inpatient bill return DGNEWLOS to cause recalc of los in IBSC6
 G DDAT4:'$D(X)
 I $D(^DGCR(399,DA,0)),$P(^(0),"^",5)<3 S DGNEWLOS=1
 S IB00=$S($D(^DGCR(399,+DA,"U")):^("U"),1:"") I IB00']"" K X G DDAT4
 S IB02=$S(+$E(IB00,4,5)<10:$E(IB00,2,3),1:$E(IB00,2,3)+1),IB01=$E(IB00,1)_IB02_"0930",$P(^DGCR(399,DA,"U1"),"^",9)=IB02 ;,$P(^DGCR(399,DA,"U1"),"^",11)=$S($P(IB00,"^",2)>IB01:IB02+1,1:"")
 ;I $P(^DGCR(399,DA,"U1"),"^",11)="" S $P(^("U1"),"^",12)=""
 ;
DDAT4 K IB00,IB01,IB02,IB03,DGX,DGNOAP,DGJ,DGPROC,DGPRDT,DGPRDTE,DGPRDTB Q
 ;
OTDAT ; Input transform for Other Care Start Date (399,48,.02)
 I ('$G(DA(1)))!('$G(X)) Q
 N IBX S IBX=$G(^DGCR(399,DA(1),"U"))
 I +X<+IBX W !,?4,"Can Not Precede Bill Start Date!",!,*7 K X Q
 I +X>(+$P(IBX,U,2)+1) W !,?4,"Cannot be after Bill End Date!",!,*7 K X Q
 Q
 ;
CHDAT ; Input transform for chiropractic-related dates (399/245,246,247)
 ; Make sure that date entered is not after end date of the bill
 Q:'$D(X)
 N IBX,Y
 S IBX=$P($G(^DGCR(399,+DA,"U")),U,2)
 I IBX="" W !?4,*7,"No end date of the bill on file - can't enter chiropractic-related dates " K X Q
 I X>+IBX S Y=IBX D DD^%DT W !,?4,*7,"This date cannot be after the end date of the claim ("_Y_") " K X Q
 Q
 ;
TO ;151 pseudo input x-form
 I +X_.9<IBIDS(.03) W !?4,"Cannot precede the 'EVENT DATE'!",*7 K X Q
 I +X>(DT_".2359") W !?4,"Cannot bill for future treatment!",*7 K X
 Q
FROM ;152 pseudo input x-form
 I '$D(IBIDS(151)) W !?4,"'Start Date' must be specified first!",*7 K X Q
 I +X<IBIDS(151) W !?4,"Cannot precede the 'Start Date'!",*7 K X Q
 I IBIDS(.05)>2,$$ICD10S(+IBIDS(151),+X) W !?4,"Bill Statement dates cannot span ICD-10 activation date!",*7 K X Q
 ;I $S($E(IBIDS(151),4,5)<10:$E(IBIDS(151),2,3),1:$E(IBIDS(151),2,3)+1)'=$S($E(X,4,5)<10:$E(X,2,3),1:$E(X,2,3)+1) K X W !?4,"Must be in same fiscal year!",*7 Q
 ;I $$FY(IBIDS(151))'=$$FY(X) K X W !?4,"Must be in same fiscal year!",*7 Q
 ;I $E(IBIDS(151),1,3)'=$E(X,1,3) K X W !?4,"Must be in same calendar year!",*7 Q
 Q
 ;
FY(DATE) ; return a dates Fiscal Year
 N IBYR,IBFY S IBFY=""
 I $G(DATE)?7N.E S IBYR=$S($E(DATE,4,5)<10:$E(DATE,1,3),1:$E(DATE,1,3)+1),IBFY=$E(IBYR,2,3)
 Q IBFY
 ;
SPEC ;  - calculate discharge specialty
 ;  - input  IBids(.08) = ptf record number
 ;  - output IBids(161) = pointer to billing specialty in 399.1
 K IBIDS(161)
 Q:$S('$D(IBIDS(.08)):1,'$D(^DGPT(+IBIDS(.08),70)):1,'$P(^(70),"^",2):1,'$D(^DIC(42.4,+$P(^(70),"^",2),0)):1,1:0)  S IBIDS(161)=$P(^DGPT(IBIDS(.08),70),"^",2)
 S IBIDS(161)=$P($G(^DIC(42.4,+IBIDS(161),0)),"^",5) I IBIDS(161)="" K IBIDS(161) Q
 S IBIDS(161)=$O(^DGCR(399.1,"B",IBIDS(161),0))
 I '$D(^DGCR(399.1,+IBIDS(161),0)) K IBIDS(161)
 Q
 ;
PROCDT ;  - find first and last dates of procedures
 ;    can't set from and to date inside of this range
 S (DGPRDT,DGPROC,DGPRDTE,DGPRDTB)=0
 F  S DGPROC=$O(^DGCR(399,+DA,"CP",DGPROC)) Q:'DGPROC  S DGPRDT=$P($G(^DGCR(399,+DA,"CP",DGPROC,0)),"^",2) D
 . I DGPRDTB=0!(DGPRDTB>DGPRDT) S DGPRDTB=DGPRDT
 . I DGPRDTE=0!(DGPRDTE<DGPRDT) S DGPRDTE=DGPRDT
 . Q
 Q
 ;
ICD10S(BDT,EDT,IBIFN) ; return Code Version Date if bill dates span the ICD-10 activation date
 ; enter either the bill to check or the dates to check
 N IBS,IBV,IBU S IBS=""
 S IBV=$$CSVDATE^IBACSV(30)
 I +$G(IBIFN) S IBU=$G(^DGCR(399,+IBIFN,"U")) S:'$G(BDT) BDT=+IBU S:'$G(EDT) EDT=+$P(IBU,U,2)
 I $G(BDT)<IBV,$G(EDT)'<IBV S IBS=IBV
 Q IBS
 ;
TOBIN(Y,DA) ; Screen for UB-04 bill classification based on UB-04 location of care
 ; Y = internal value of code for field .25 (UB-04 BILL CLASSIFICATION)
 ; DA = bill ien in file 399
 N IB0
 S IB0=$P($G(^DGCR(399,DA,0)),U,24) ; Get UB-04 LOCATION OF CARE value
 Q $S('IB0:0,(","_$P($G(^DGCR(399.1,+Y,0)),U,24)_",")'[(","_IB0_","):0,1:1)
 ;
TRIG05(X,D0) ; Trigger executed on field .05 of file 399 to set field .25
 ; Find the correct entry in file 399.1 that corresponds to the value in .05
 ; X = value of field .05, location of care
 ; D0 = IEN of bill entry in file 399
 N Z,Z0,IEN,LOC
 S LOC=$P($G(^DGCR(399,D0,0)),U,4)
 S IEN="",Z=0
 ; *532 return the last entry (eg. #4-lab)
 I LOC'="" F  S Z=$O(^DGCR(399.1,"C",X,Z)) Q:'Z  S Z0=$P($G(^DGCR(399.1,Z,0)),U,23,24) I +Z0,(","_$P(Z0,U,2)_",")[(","_LOC_",") S IEN=Z
 Q IEN
 ;
TOB(IBIFN,POS) ;Function returns the 3 digit type of bill from UB-04
 ;  fields or the position (1-3) as determined by POS (optional)
 N Z
 S Z=$P($G(^DGCR(399,IBIFN,0)),U,24,26),Z=$P(Z,U)_$P($G(^DGCR(399.1,+$P(Z,U,2),0)),U,2)_$P(Z,U,3)
 Q $S('$G(POS):Z,1:$E(Z,+POS))
 ;
