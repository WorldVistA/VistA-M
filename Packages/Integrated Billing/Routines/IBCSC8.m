IBCSC8 ;ALB/MJB/AAS - MCCR SCREEN 8 (BILLING - CLAIM INFORMATION SCREEN) ;27 MAY 88 10:15
 ;;2.0;INTEGRATED BILLING;**432**;21-MAR-94;Build 192
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
EN D ^IBCSCU S IBSR=8,IBSR1="" S IB("U4")=$G(^DGCR(399,IBIFN,"U4")),IB("U5")=$G(^DGCR(399,IBIFN,"U5")),IB("U6")=$G(^DGCR(399,IBIFN,"U6")),IB("U8")=$G(^DGCR(399,IBIFN,"U8"))
 D H^IBCSCU
 ; DEM - IBV is set in EDI^IBCB => S IBAC=1,IBV=0 D EN G Q:'IBAC1,EDI
 ;       IBV=0, or IBV=1 as a flag if field on screen is required
 ;       or not. <Field #> indicates field is not required.
 ;       [Field #]
 ; Make some sections NOT available for UB04 form
 S IBT=$P($G(^DGCR(399,IBIFN,0)),U,19)
 S IBV1=$S(IBT=3:"0011011",IBV:"1111111",1:"0000000")
 ;
 S Z=1,IBW=1 X IBWW W " COB Non-Covered Charge Amt: " S X=$P(IB("U4"),U),X2="2$" I X'="" D COMMA^%DTC W X
 S Z=2 X IBWW W " Property Casualty Information"
 W !,?4,"Claim Number:  ",$P(IB("U4"),U,2),?41,"Contact Name:  ",$P(IB("U4"),U,9)
 W !,?4,"Date of 1st Contact:  ",$$FMTE^XLFDT($P(IB("U4"),U,3)),?41,"Contact Phone:  ",$P(IB("U4"),U,10),"  ",$P(IB("U4"),U,11)
 S Z=3 X IBWW W " Ambulance Information"
 W !,?41,"D/O Location: ",$P(IB("U6"),U)
 W !,?4,"P/U Address1:  ",$P(IB("U5"),U,2),?41,"D/O Address1:  ",$P(IB("U6"),U,2)
 W !,?4,"P/U Address2:  ",$P(IB("U5"),U,3),?41,"D/O Address2:  ",$P(IB("U6"),U,3)
 W !,?4,"P/U City:  ",$P(IB("U5"),U,4),?41,"D/O City:  ",$P(IB("U6"),U,4)
 W !,?4,"P/U State/Zip:  " W:$P(IB("U5"),U,5)'="" $P($G(^DIC(5,$P(IB("U5"),U,5),0)),U,2)
 W:$P(IB("U5"),U,6)]"" "/"_$P(IB("U5"),U,6)
 W ?41,"D/O State/Zip:  " W:$P(IB("U6"),U,5)'="" $P($G(^DIC(5,$P(IB("U6"),U,5),0)),U,2)
 W:$P(IB("U6"),U,6)]"" "/"_$P(IB("U6"),U,6)
 ;W !,?4,"P/U Country/SubDiv:  ",$P(IB("U5"),U),?41,"D/O Country/SubDiv:  "
 S Z=4 X IBWW W " Surgical Codes for Anesthesia Claims"
 W !,?4,"Primary Code:  " W:$P(IB("U4"),U,7)'="" $P($G(^ICPT($P(IB("U4"),U,7),0)),U)
 W ?41,"Secondary Code:  " W:$P(IB("U4"),U,8)'="" $P($G(^ICPT($P(IB("U4"),U,8),0)),U)
 S Z=5 X IBWW W " Paperwork Attachment Information"
 W !,?4,"Report Type:  " W:$P(IB("U8"),U,2)'="" $P($G(^IBE(353.3,$P(IB("U8"),U,2),0)),U)
 W ?41,"Transmission Method:  ",$P(IB("U8"),U,3)
 W !,?4,"Attachment Control #:  ",$P(IB("U8"),U)
 S Z=6 X IBWW W " Disability Start Date:  ",$$FMTE^XLFDT($P(IB("U4"),U,4)),?41,"Disability End Date:  ",$$FMTE^XLFDT($P(IB("U4"),U,5))
 S Z=7 X IBWW W " Assumed Care Date:  ",$$FMTE^XLFDT($P(IB("U4"),U,13)),?41,"Relinquished Care Date:  ",$$FMTE^XLFDT($P(IB("U4"),U,14))
 W !
REV G ^IBCSCP
 ;IBCSC8
