IBCSC8 ;ALB/MJB/AAS - MCCR SCREEN 8 (BILLING - CLAIM INFORMATION SCREEN) ;27 MAY 88 10:15
 ;;2.0;INTEGRATED BILLING;**432,447,488,577,592**;21-MAR-94;Build 58
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
EN D ^IBCSCU S IBSR=8,IBSR1="" S IB("U2")=$G(^DGCR(399,IBIFN,"U2")),IB("U4")=$G(^DGCR(399,IBIFN,"U4")),IB("U5")=$G(^DGCR(399,IBIFN,"U5")),IB("U6")=$G(^DGCR(399,IBIFN,"U6")),IB("U8")=$G(^DGCR(399,IBIFN,"U8"))
 D H^IBCSCU
 ; DEM - IBV is set in EDI^IBCB => S IBAC=1,IBV=0 D EN G Q:'IBAC1,EDI
 ;       IBV=0, or IBV=1 as a flag if field on screen is required
 ;       or not. <Field #> indicates field is not required.
 ;       [Field #]
 ; Make some sections NOT available for UB04 form
 S IBT=$P($G(^DGCR(399,IBIFN,0)),U,19)
 ;S IBV1=$S(IBT=3:"001011",IBV:"111111",1:"000000")
 ;JWS;IB*2.0*592 US1108 - Dental
 S IBV1=$S(IBT=3:"001011111",IBT=7:"0000",IBV:"111111111",1:"000000000") ; IB*2.0*488 (vd)
 I IBT=7 D IBTEETH,DENTAL K IBTEETH ;G REV
 ;JWS;IB*2.0*592 -end
 ;JWS;IB*2.0*592 - US1108 add back Property Casualty Claim Number
 I IBT'=7 S Z=1,IBW=1 X IBWW W " COB Non-Covered Charge Amt: " S X=$P(IB("U4"),U),X2="2$" I X'="" D COMMA^%DTC W X
 S Z=$S(IBT=7:4,1:2) X IBWW W " Property Casualty Information"
 ;W !,?4,"Claim Number:  ",$P(IB("U4"),U,2),?41,"Contact Name:  ",$P(IB("U4"),U,9)  ;JRA IB*2.0*577 ';'
 W !,?4,"Claim Number:  ",$P(IB("U4"),U,2)  ;JRA IB*2.0*577
 I IBT=7 G REV
 ;JWS;IB*2.0*592 / end
 W !,?4,"Contact Name:  ",$P(IB("U4"),U,9)  ;JRA IB*2.0*577
 W !,?4,"Date of 1st Contact:  ",$$FMTE^XLFDT($P(IB("U4"),U,3)),?41,"Contact Phone:  ",$P(IB("U4"),U,10),"  ",$P(IB("U4"),U,11)
 ; Start IB*2.0*447 BI
 ;S Z=3 X IBWW W " Ambulance Information"
 ;W !,?41,"D/O Location: ",$P(IB("U6"),U)
 ;W !,?4,"P/U Address1:  ",$P(IB("U5"),U,2),?41,"D/O Address1:  ",$P(IB("U6"),U,2)
 ;W !,?4,"P/U Address2:  ",$P(IB("U5"),U,3),?41,"D/O Address2:  ",$P(IB("U6"),U,3)
 ;W !,?4,"P/U City:  ",$P(IB("U5"),U,4),?41,"D/O City:  ",$P(IB("U6"),U,4)
 ;W !,?4,"P/U State/Zip:  " W:$P(IB("U5"),U,5)'="" $P($G(^DIC(5,$P(IB("U5"),U,5),0)),U,2)
 ;W:$P(IB("U5"),U,6)]"" "/"_$P(IB("U5"),U,6)
 ;W ?41,"D/O State/Zip:  " W:$P(IB("U6"),U,5)'="" $P($G(^DIC(5,$P(IB("U6"),U,5),0)),U,2)
 ;W:$P(IB("U6"),U,6)]"" "/"_$P(IB("U6"),U,6)
 ;;W !,?4,"P/U Country/SubDiv:  ",$P(IB("U5"),U),?41,"D/O Country/SubDiv:  "
 S Z=3 X IBWW W " Surgical Codes for Anesthesia Claims"
 W !,?4,"Primary Code:  " W:$P(IB("U4"),U,7)'="" $P($G(^ICPT($P(IB("U4"),U,7),0)),U)
 W ?41,"Secondary Code:  " W:$P(IB("U4"),U,8)'="" $P($G(^ICPT($P(IB("U4"),U,8),0)),U)
 S Z=4 X IBWW W " Paperwork Attachment Information"
 W !,?4,"Report Type:  " W:$P(IB("U8"),U,2)'="" $P($G(^IBE(353.3,$P(IB("U8"),U,2),0)),U)
 W ?41,"Transmission Method:  ",$P(IB("U8"),U,3)
 W !,?4,"Attachment Control #:  ",$P(IB("U8"),U)
 S Z=5 X IBWW W " Disability Start Date:  ",$$FMTE^XLFDT($P(IB("U4"),U,4)),?41,"Disability End Date:  ",$$FMTE^XLFDT($P(IB("U4"),U,5))
 S Z=6 X IBWW W " Assumed Care Date:  ",$$FMTE^XLFDT($P(IB("U4"),U,13)),?41,"Relinquished Care Date:  ",$$FMTE^XLFDT($P(IB("U4"),U,14))
 ; End IB*2.0*447 BI
 ;
 ;/ Beginning of IB*2.0*488 - code moved from IBCSC10H (vd)
 S Z=7 X IBWW W " Special Program:  " I $P(IB("U2"),U,16)'="" S IBZ=$$EXPAND^IBTRE(399,238,$P(IB("U2"),U,16)) W $S(IBZ'="":IBZ,$$WNRBILL^IBEFUNC(IBIFN):"31",1:"")
 S Z=8 X IBWW W " Homebound:  ",$$EXPAND^IBTRE(399,236,$P(IB("U2"),U,14))
 S Z=9 X IBWW W " Date Last Seen:  ",$$EXPAND^IBTRE(399,237,$P(IB("U2"),U,15))
 ;/ End of IB*2.0*488 (vd)
REV G ^IBCSCP
 ;JWS;IB*2.0*592 US1108 - Dental
IBTEETH ;Create array of teeth status
 N TH
 K IBTEETH S IBTEETH=0
 S IBTEETH(0)=+$P($G(^DGCR(399,IBIFN,"DEN1",0)),U,4)
 S TH=0
 F  S TH=$O(^DGCR(399,IBIFN,"DEN1",TH)) Q:'TH  S IBTEETH(TH)=$G(^DGCR(399,IBIFN,"DEN1",TH,0))
 Q
 ;
DENTAL ;Dental Information for Form Type 7(J430D)
 S IB("DEN")=$G(^DGCR(399,IBIFN,"DEN"))
 S Z=1,IBW=1 X IBWW W ?4,"Tooth Status"
 D WRT:$D(IBTEETH)
 S Z=2,IBW=1 X IBWW W ?4,"Orthodontic Information"
 W !?4,"Banding Date: " I $P(IB("DEN"),U)'="" W $$FMTE^XLFDT($P(IB("DEN"),U),2)
 W !?4,"Treatment Months Count: ",$P(IB("DEN"),U,2)
 W !?4,"Treatment Months Remaining Count: ",$P(IB("DEN"),U,3)
 W !?4,"Treatment Indicator: ",$$GET1^DIQ(399,IBIFN_",",95,"E")
 S Z=3,IBW=1 X IBWW W ?4,"Dental Paperwork Attachment"
 W !?4,"Report Type: " I $P(IB("U8"),U,2)'="" W $$GET1^DIQ(353.3,$P(IB("U8"),U,2)_",",.01)," (",$E($$GET1^DIQ(353.3,$P(IB("U8"),U,2)_",",1),1,18),")"
 W ?41,"Trans Method: " I $P(IB("U8"),U,3)'="" W $$GET1^DIQ(399,IBIFN_",",286,"I")," (",$E($$GET1^DIQ(399,IBIFN_",",286,"E"),1,20),")"
 W !?4,"Attachment Control #: ",$P(IB("U8"),U)
 Q
 ;
WRT ;write out teeth status on screen
 N I,J
 S J=0 F I=1:1 S J=$O(IBTEETH(J)) Q:'J  D  I I>6 D MORE Q
 . W !?4,"Tooth Number: ",$P(IBTEETH(J),U),?41,"Status Code: ",$$GET1^DIQ(399.096,J_","_IBIFN_",",.02)
 Q
 ;
MORE ;
 W !?4,"***There are more teeth statuses associated with this bill.***" S I=0
 Q
 ;end - JWS;IB*2.0*592 US1108 - Dental
 ;IBCSC8
