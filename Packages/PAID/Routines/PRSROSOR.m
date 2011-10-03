PRSROSOR ;HISC/JH-SORT FOR OT/CT & EXPENDITURE REPORTS ;11/18/98
 ;;4.0;PAID;**2,26,46**;Sep 21, 1995
OTCT ;Over Time & Comp Time Sort
 S X=$E($P($G(^PRST(458,DA(3),"E",D0,5)),"^"),22,24) D:$P(TLE(1),"^")=X
 .  S TLUNIT=$P($G(^PRSPC(D0,0)),U,7),SSN=$P($G(^(0)),U,9) I SSN'="" S SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 .  S COMP=$P($G(^PRST(459,DA(1),"P",D0,4)),"^",3),COMPU=$P($G(^PRST(459,DA(1),"P",D0,4)),"^",4),OTH=$P($G(^PRST(459,DA(1),"P",D0,5)),"^",15)
 .  S SAL=$P($G(^PRST(459,DA(1),"P",D0,5)),"^"),OTP=$P($G(^(5)),"^",14),DA(4)=$P(DA(2),"-",2)
 .  Q:'(COMP!(OTH))  S ^TMP($J,"OT/CP",DA(2),DATE,$P(TLE(1),"^"),NAM,D0)=SSN_"^"_SAL_"^"_COMP_"^"_COMPU_"^"_OTH_"^"_OTP,CNT=CNT+1 W:'$D(ZTSK)&($E(IOST)'="P")&($R(30)) "."
 .  Q
 Q
EXP ;Expenditure Sort
 S (TL,GOV,STOT,TOT)=0,U="^",TLE=$P(TLE(1),U)
 S DA(3)=$O(^PRST(458,"B",DA(1),0)) Q:DA(3)'>0  D
 .  S D0=0 F  S D0=$O(^PRST(458,DA(3),"E",D0)) Q:D0'>0  S X=$E($P($G(^PRST(458,DA(3),"E",D0,5)),U),22,24) D:TLE=X
 ..;
 ..; skip employee if there is no expenditure data for them
 ..  Q:'($G(^PRST(459,DA,"P",D0,5))!$G(^(8)))
 ..;
 ..  S NAM=$P($G(^PRSPC(D0,0)),U),TOT(1)=$P($G(^PRST(459,DA,"P",D0,5)),U,5),TOT(2)=$P($G(^(5)),U,10),TOT(3)=$P($G(^(5)),U,8),TOT(4)=$P($G(^(5)),U,14)
 ..  S TOT(5)=$P($G(^PRST(459,DA,"P",D0,5)),U,19),TOT(6)=$P($G(^(5)),U,13),TOT(7)=$P($G(^(5)),U,24)+$P($G(^(5)),U,25)+$P($G(^(5)),U,31),TOT(8)=$P($G(^(5)),U,4),TOT(9)=$P($G(^(5)),U,17)
 ..  F I=1:1:9 S TOTAL(I)=TOTAL(I)+TOT(I),$P(STOT,U,I)=$P(STOT,U,I)+TOT(I)
 ..  S TOT=$P($G(^PRST(459,DA,"P",D0,5)),U)
 ..  S GOV(1)=$P($G(^PRST(459,DA,"P",D0,8)),U),GOV=GOV(1)-TOT
 ..  S TOTAL=TOTAL+TOT,TGOV=TGOV+GOV,$P(STOT,U,10)=$P(STOT,U,10)+TOT,$P(STOT,U,11)=$P(STOT,U,11)+GOV,$P(STOT,U,12)=$P(STOT,U,12)+(TOT+GOV)
 ..  S ^TMP($J,"EXP",+$P(DA(1),"-",2),TLE,NAM,D0)=TOT(1)_U_TOT(2)_U_TOT(3)_U_TOT(4)_U_TOT(5)_U_TOT(6)_U_TOT(7)_U_TOT(8)_U_TOT(9)_U_TOT_U_GOV_U_(TOT+GOV)
 .. S CNT=CNT+1,(GOV,TOT)=0
 .. I '(CNT#30),$E(IOST,1,2)="C-",'$D(ZTQUEUED) W "."
 ..  Q
 .  S ^TMP($J,"EXP1",+$P(DA(1),"-",2),TLE)=STOT,STOT=0
 .  Q
 Q
