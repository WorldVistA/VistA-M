IBTUTL ;ALB/AAS - CLAIMS TRACKING UTILITY ROUTINE ; 21-JUN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**23,62**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ADM(DGPMCA,VAINDT,RANDOM,IBVSIT) ; -- set up info for adding a current admission
 ; -- Input DGPMCA   = pointer for an admission to patient movement file
 ;          VAINDT   = optional date for admission (default is dt)
 ;          RANDOM   = whether or not this is a random sample
 ;          IBVSIT   = Pointer to visit file (optional)
 ;
 N DA,DIC,DIE,DR,X,VAIN,VA,IBSCHED,IBSCH
 I '$G(VAINDT) K VAINDT
 I '$G(DGPMCA) S VA200="" D INP^VADPT S DGPMCA=VAIN(1)
 Q:DGPMCA=""
 S RANDOM=$S($G(RANDOM):1,1:0)
 S X=$O(^IBT(356,"ADM",DFN,DGPMCA,0)) I X S IBTRN=X G ADMQ
 S IBADMDT=$P(^DGPM(DGPMCA,0),"^")
 ;S IBETYP=+$O(^IBE(356.6,"B","INPATIENT ADMISSION",0))
 S IBETYP=+$O(^IBE(356.6,"AC",1,0))
 S (IBSCH,IBTRN)=$O(^IBT(356,"ASCH",+$$SCH^IBTRKR2(DGPMCA),0))
 D:'IBTRN ADDT
 I IBTRN<1 G ADMQ
 S DA=IBTRN,DIE="^IBT(356,"
 L +^IBT(356,+IBTRN):10 I '$T G ADMQ
 S DR=$$ADMDR(IBADMDT,IBETYP,DGPMCA,RANDOM)
 D ^DIE K DA,DR,DIE
 I $P($G(^IBT(356,IBTRN,0)),"^",32) S DA=IBTRN,DR=".32///@",DIE="^IBT(356," D ^DIE K DA,DR,DIE
 L -^IBT(356,+IBTRN)
 ;
 S IBSCHED=$S($P(^DGPM(DGPMCA,0),U,25):10,1:20)
 ;
 ; -- if random sample add hospital review
 I $P(^IBT(356,IBTRN,0),U,25) D PRE^IBTUTL2(DT,IBTRN,IBSCHED)
 ;
 ; -- if scheduled admission entry converted to admission, don't add
 ;    second insurance review
 I $G(IBSCH) G ADMQ
 ;
 ; -- if insured add ins review
 I $P(^IBT(356,IBTRN,0),U,24) D COM^IBTUTL3(DT,IBTRN,IBSCHED,$G(IBTRV))
 ;
ADMQ Q
 ;
ADDT ; -- add new entry to tracking, ibt(356
 ;
 N %DT,DD,DO,DIC,DR,DIE,DLAYGO,IBTR1,DINUM
 L +^IBT(356,0):0 ;I '$T S Y="-1^IB085" G ADDTQ
 ;I $G(^IBT(356,0))="" S Y="-1^IB086" G ADDTQ
 S X=$P($G(^IBT(356,0)),"^",3)+1 L -^IBT(356,0)
 S DIC="^IBT(356,",DIC(0)="L",DLAYGO=356
 F X=X:1 L:$D(IBTR1) -^IBT(356,IBTR1) I X>0,'$D(^IBT(356,X)) S IBTR1=X L +^IBT(356,IBTR1):1 I $T,'$D(^IBT(356,X)) S DINUM=X,X=($$IBSITE())_X D FILE^DICN I +Y>0 Q
 L -^IBT(356,IBTR1)
 I +Y<1  S Y="-1^IB087"
ADDTQ ;I +Y<0 D ^IBTERR
 S IBTRN=+Y,IBNEW=1
 Q
 ;
OTH(DFN,IBETYP,IBTDT) ; -- add miscellaneous entries, care may not be in data base
 ; -- input   dfn  := patient pointer to 2
 ;          ibetyp := pointer to type entry in 356.6
 ;          ibtdt  := episode date
 ;
 N X,Y,DA,DR,DIE,DIC
 S X=$O(^IBT(356,"APTY",DFN,IBETYP,IBTDT,0)) I X S IBTRN=X G OTHQ
 D ADDT
 I IBTRN<1 G OTHQ
 S DA=IBTRN,DIE="^IBT(356,"
 S DR=".02////"_$G(DFN)_";.06////"_+$G(IBTDT)_";.18////"_IBETYP_";.2////1;.24////"_$$INSURED^IBCNS1(DFN)_";1.01///NOW;1.02////"_DUZ_";.17////"_$$EABD(IBETYP,IBTDT)
 L +^IBT(356,+IBTRN):10 I '$T G OTHQ
 D ^DIE K DA,DR,DIE
 L -^IBT(356,+IBTRN)
OTHQ Q
 ;
IBSITE() ; -- calculate site from site parameters
 ; --  output ibsite = station number
 ;
 N IBFAC,IBSITE
 D SITE^IBAUTL
 Q IBSITE
 ;
ADMDR(IBADMDT,IBETYP,DGPMCA,RANDOM) ; -- set up dr string for admissions
 S DR=""
 I '$G(IBETYP)!'$G(IBADMDT) G ADMDRQ
 S DR=".02////"_$G(DFN)_";.03////"_$G(IBVSIT)_";.05////"_$G(DGPMCA)_";.06////"_+$G(IBADMDT)_";.18////"_$G(IBETYP)_";.2////1;.24////"_$$INSURED^IBCNS1(DFN)_";1.01///NOW;1.02////"_DUZ_";.17////"_$$EABD(IBETYP,$G(IBADMDT)) D
 .I $G(DGPMCA),$G(RANDOM) S DR=DR_";.25////1" Q
ADMDRQ Q DR
 ;
EABD(IBETYP,IBTDT) ; -- compute earliest auto bill date: date entered plus days delay for event type
 ; -- input   IBETYPE = pointer to type of entry file
 ;            IBTDT   = episode date, if not passed in uses DT
 ;
 N X,X1,X2,Y,IBETYPD S Y="" I '$G(IBETYP) G EABDQ
 S IBETYPD=$G(^IBE(356.6,+IBETYP,0)) I '$G(IBTDT) S IBTDT=DT
 I '$P(IBETYPD,"^",4) G EABDQ ; automated billing turned off
 S X2=+$P(IBETYPD,"^",6) ;set earliest autobill date to entered date plus days delay
 S X1=IBTDT D C^%DTC S Y=X\1
EABDQ Q Y
 ;
BILL(IBTRN) ;check if event is billable, return EABD if it is
 N X,Y,Z,IBTRND S (X,Y)="" S IBTRND=$G(^IBT(356,+$G(IBTRN),0)) I IBTRND="" G BILLQ
 ;
 ; -- billed and bill not cancelled and not inpt interim first or continuous
 I +$P(IBTRND,U,11) S Z=$$BILLED^IBCU8(IBTRN),Y=$P(Z,U,2) I +Z,'Y G BILLQ
 ;
 ; -- special type (not riem. ins), not billable, inactive
 I +$P(IBTRND,U,12)!(+$P(IBTRND,U,19))!('$P(IBTRND,U,20)) G BILLQ
 I 'Y S Y=+$G(^IBT(356,+$G(IBTRN),1)) I 'Y S Y=DT
 S X=$$EABD(+$P(IBTRND,U,18),Y)
BILLQ Q X
 ;
STOBIL Q
KTOBIL Q
