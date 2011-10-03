PRSRASOR ;HISC/JH-EMPLOYEE AUDIT SORT ;2/28/95
 ;;4.0;PAID;;Sep 21, 1995
PP I SW S DA(3)="" F I=0:0 S DA(3)=$O(^PRSPC("ATL"_TLE,DA(3))) Q:DA(3)=""  D
 .  S D0=0 F I=0:0 S D0=$O(^PRSPC("ATL"_TLE,DA(3),D0)) Q:D0'>0  S DA=0 F I=0:0 S DA=$O(^PRST(458,DA(1),"E",D0,"D",DA)) Q:DA'>0  D
 ..  Q:$G(^PRST(458,DA(1),"E",D0,"D",DA,2))=""  S TOUR=$G(^PRST(458,DA(1),"E",D0,"D",DA,2)) Q:TOUR=""  D CKTOUR^PRSRUT0(.TOUR) Q:TOUR=""
 ..  S SSN=$P($G(^PRSPC(D0,0)),U,9),SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9),CNT=CNT+1,^TMP($J,"USE",DA(2),$P(DATES,"^",DA),DA(3),SSN,D0,CNT)=TOUR W:$E(IOST)="C" "."
 ..  Q
 .  Q
 I 'SW S DA(2)="" F II=0:0 S DA(2)=$O(^PRST(458,"B",DA(2))) Q:DA(2)=""  D
 .  S DA(1)=0 F I=0:0 S DA(1)=$O(^PRST(458,"B",DA(2),DA(1))) Q:DA(1)'>0  S DATES=$G(^PRST(458,DA(1),1)) D
 ..  S DA=0 F I=0:0 S DA=$O(^PRST(458,DA(1),"E",D0,"D",DA)) Q:DA'>0  S DAY=$P($P(^PRST(458,DA(1),2),"^",DA)," ") D
 ...  Q:$G(^PRST(458,DA(1),"E",D0,"D",DA,2))=""!(($P(DATES,"^",DA)<FR)!($P(DATES,"^",DA)>TO))  S TOUR=$G(^PRST(458,DA(1),"E",D0,"D",DA,2)) Q:TOUR=""  D CKTOUR^PRSRUT0(.TOUR) Q:TOUR=""
 ...  S CNT=CNT+1,^TMP($J,"USE",CNT,DA(2),$P(DATES,"^",DA),DAY)=TOUR
 ...  Q
 ..  Q
 .  Q
 Q
