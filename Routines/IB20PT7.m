IB20PT7 ;ALB/ARH - ADD NEW ENTRIES TO TABLE FILES ; 12/20/93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 D DS ;     Add new discharge statuses for bills
 D RT ;     Add new Rate Types to file #399.3 for CHAMPVA
 D RVC ;    Add new revenue codes to file #399.2
 D OSC ;    Adding new Occurrence Span Codes
 D VC ;     Adding new Value Codes
 Q
 ;
 ;
DS ; Add new discharge statuses for bills
 W !!,">>> Adding new discharge status for bills..."
 F IBI=1:1 S IBX=$P($T(DSF+IBI),";;",2,999) Q:IBX=""  D
 . S IBJ=0 F  S IBJ=$O(^DGCR(399.1,IBJ)) Q:'IBJ  S IBY=$G(^DGCR(399.1,IBJ,0)) I $P(IBX,U,1)=$P(IBY,U,1),$P(IBX,U,2)=$P(IBY,U,2),$P(IBY,U,6) S IBY=1 Q
 . Q:IBY  K DA,DO S DIC="^DGCR(399.1,",DIC(0)="L",X=$P(IBX,U,1) D FILE^DICN K DA,DO Q:Y<0!('$P(Y,U,3))
 . S DA=+Y,DIE=DIC,DR=".02////"_$P(IBX,U,2)_";.13////1" D ^DIE
 K DIC,DIE,DA,DR,Y
 Q
 ;
RT ; Add new Rate Types to file #399.3 for CHAMPVA
 W !!,">>> Adding new entries to the Rate Type File - CHAMPVA ..."
 F IBI=1:1 S IBX=$P($T(RTF+IBI),";;",2,999) Q:IBX=""  D
 . S IBY=$E($P(IBX,U,1),1,30) Q:$D(^DGCR(399.3,"B",IBY))
 . K DD,DO S DIC="^DGCR(399.3,",DIC(0)="L",X=IBY D FILE^DICN K DA,DO Q:Y<0
 . S DA=+Y,DIE=DIC,DR=".02////"_$P(IBX,U,2)_";.03////"_$P(IBX,U,3)_";.04////"_$P(IBX,U,4)_";.05////"_$P(IBX,U,5)_";.06////"_$P(IBX,U,6)_";.07////"_$P(IBX,U,7)_";.08////"_$P(IBX,U,8)_";.09////"_$P(IBX,U,9) D ^DIE
 K DIC,DIE,DA,DR,Y
 Q
 ;
RVC ; Add new revenue codes to file #399.2
 W !!,">>> Adding new revenue codes..."
 F IBI=1:1 S IBX=$P($T(RVCF+IBI),";;",2,999) Q:IBX=""  D
 . S IBY=$P(IBX,U,1),IBZ=$G(^DGCR(399.2,+IBY,0)) Q:(+IBY'=+IBZ)!($P(IBZ,U,2)'="*RESERVED")
 . S DA=+IBY,DIE="^DGCR(399.2,",DR="1////"_$P(IBX,U,2)_";3////"_$P(IBX,U,4) D ^DIE
 K DIC,DIE,DA,DR,Y
 Q
 ;
OSC ; Adding new Occurrence Span Codes
 W !!,">>> Adding Occurrence Span Codes..."
 F IBI=1:1 S IBX=$P($T(OSCF+IBI),";;",2,999) Q:IBX=""  D
 . S IBJ=0 F  S IBJ=$O(^DGCR(399.1,IBJ)) Q:'IBJ  S IBY=$G(^DGCR(399.1,IBJ,0)) I $P(IBX,U,1)=$P(IBY,U,1),$P(IBX,U,2)=$P(IBY,U,2),$P(IBY,U,10) S IBY=1 Q
 . Q:IBY  K DA,DO S DIC="^DGCR(399.1,",DIC(0)="L",X=$P(IBX,U,1) D FILE^DICN K DA,DO Q:Y<0!('$P(Y,U,3))
 . S DA=+Y,DIE=DIC,DR=".02////"_$P(IBX,U,2)_";.11////1;.17////1" D ^DIE
 K DIC,DIE,DA,DR,Y
 Q
 ;
VC ; Adding new Value Codes
 W !!,">>> Adding Value Codes..."
 F IBI=1:1 S IBX=$P($T(VCF+IBI),";;",2,999) Q:IBX=""  D
 . S IBJ=0 F  S IBJ=$O(^DGCR(399.1,IBJ)) Q:'IBJ  S IBY=$G(^DGCR(399.1,IBJ,0)) I $P(IBX,U,1)=$P(IBY,U,1),$P(IBX,U,2)=$P(IBY,U,2),$P(IBY,U,11) S IBY=1 Q
 . Q:IBY  K DA,DO S DIC="^DGCR(399.1,",DIC(0)="L",X=$P(IBX,U,1) D FILE^DICN K DA,DO Q:Y<0!('$P(Y,U,3))
 . S DA=+Y,DIE=DIC,DR=".02////"_$P(IBX,U,2)_";.18////1;.19////"_$P(IBX,U,3) D ^DIE
 K DIC,DIE,DA,DR,Y
 Q
 ;
 ;
DSF ; - new discharge status, 399.1
 ;;DISCHARGED TO HOME UNDER CARE OF A HOME IV PROVIDER^08
 ;
 ;
RTF ; - new rate type entries
 ;;CHAMPVA REIMB. INS.^REIMBURSABLE INS.^1^REIM INS^1^^i^1^1
 ;;CHAMPVA^CHAMPVA^1^CHAMPVA^1^^i^1^1
 ;
 ;
RVCF ; - new revenue codes
 ;;294^MED EQUIP/SUPPLIES/DRUGS^^SUPPLIES/DRUGS FOR DME EFFECTIVENESS HOME-HEALTH AGENCY ONLY
 ;;404^PET SCAN^^POSITRON EMMISSION TOMOGROPHY
 ;;547^AMBUL/PHARMACY^^PHARMACY
 ;;548^AMBUL/TELEPHONIC EKG^^TELEPHONE TRANSMISSION EKG
 ;;636^DRUGS/DETAIL CODE^^DRUGS REQUIRING DETAILED CODING
 ;;761^TREATMENT RM^^TREATMENT ROOM
 ;;762^OBSERVATION RM^^OBSERVATION ROOM
 ;;882^HOME DIALYSIS AID VISIT^^HOME DIALYSIS AID VISIT
 ;;947^CMPLX MED EQUIP-ANC^^COMPLEX MEDICAL EQUIPMENT - ANCILLARY
 ;
 ;
OSCF ; - add occurrence span codes
 ;;QUALIFYING STAY DATES FOR SNF USE ONLY^70
 ;;PRIOR STAY DATES^71
 ;;FIRST/LAST VISIT^72
 ;;BENEFIT ELIGIBILITY PERIOD^73
 ;;NONCOVERED LEVEL OF CARE^74
 ;;SNF LEVEL OF CARE^75
 ;;PATIENT LIABILITY^76
 ;;PROVIDER LIABILITY PERIOD^77
 ;;SNF PRIOR STAY DATES^78
 ;;PAYER CODE^79
 ;;PRO/UR APPROVED STAY DATES^M0
 ;
 ;
VCF ; - add value codes
 ;;INPATIENT PROFESSIONAL COMPONENT CHARGES, COMBINED BILLED^04
 ;;NO FAULT, INCLUDING AUTO/OTHER^14^1
 ;;WORKER'S COMPENSATION^15
 ;;ACCIDENT HOUR^45
 ;
