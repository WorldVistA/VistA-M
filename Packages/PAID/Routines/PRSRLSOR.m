PRSRLSOR ;HISC/JH,WIRMFO/JAH-LEAVE REPORT SORTS ;7/8/97
 ;;4.0;PAID;**16,17,26**;Sep 21, 1995
REQ ; find employee leave requests within specified period
 ; input
 ;   D0 - employee ien (file 450)
 ;   NAM - employee name
 ;   FR  - specified FR date
 ;   TO  - specified TO date
 ;   CNT
 ; output
 ;   ^TMP($J,"REQ",request from date, employee name, request ien)=data
 ;   CNT
 ; get cost center/org code (ccoc) from employee record
 S ORG=$$CCORG^PRSRUTL(PRSRY1)
 ; send bulletin to G.PAD if ORG description missing, but continue.
 I +ORG>0 D CCORGBUL^PRSRUTL(ORG,PRSRDUZ,1,$P(PRSRY,"^",2))
 ; loop thru employee requests in reverse chrono by request's TO DATE
 ;   quit loop when earlier than specified FROM DATE
 S DTI("Q")=9999999-FR
 S DTI=0 F  S DTI=$O(^PRST(458.1,"AD",D0,DTI)) Q:DTI>DTI("Q")!(DTI="")  D
 . S DA=0 F  S DA=$O(^PRST(458.1,"AD",D0,DTI,DA)) Q:'DA  D
 . . S Z=$G(^PRST(458.1,DA,0)) Q:Z=""
 . . Q:$P(Z,U,3)>TO!($P(Z,U,3)="")  ; exclude: after specified date range
 . . Q:"DX"[$P(Z,U,9)  ; exclude: status disapproved or canceled
 . . S X=$P(Z,U,7),%=$F(LVT,";"_X_":"),X(1)=$S(%>0:$P($E(LVT,%,999),";"),1:"")
 . . S X=$P(Z,U,9),%=$F(LVS,";"_X_":"),X(2)=$S(%>0:$P($E(LVS,%,999),";"),1:"")
 . . S ^TMP($J,"REQ",$P(Z,U,3),NAM,DA)=$P(Z,U,4)_U_$P(Z,U,6)_U_$P(Z,U,5)_U_X(1)_U_X(2)_U_$P(Z,U,11)_U_$P(Z,U,13)_U_$P(Z,U,12)_U_$P(Z,U,15,16)
 . . S CNT=CNT+1 I '(CNT#30),$E(IOST,1,2)="C-",'$D(ZTQUEUED) W "."
 Q
 ;
USE I SW S DA(4)=0 F I=0:0 S DA(4)=$O(TLE(DA(4))) Q:DA(4)'>0  S DA(3)=0 F  S DA(3)=$O(TLE(DA(4),DA(3))) Q:DA(3)'>0  S D0=$P(TLE(DA(4),DA(3)),U) D
 .  Q:$G(^PRST(458,DA(1),"E",D0,"D",DA,2))=""  S TOUR=$G(^PRST(458,DA(1),"E",D0,"D",DA,2)) Q:TOUR=""  D CKTOUR^PRSRUT0(.TOUR) Q:TOUR=""
 .  S SSN=$P($G(^PRSPC(D0,0)),U,9),SSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9),CNT=CNT+1,^TMP($J,"USE",DA(2),$P(DATES,"^",DA),$P(TLE(DA(4),DA(3)),U,2),SSN,D0,CNT)=TOUR W:'$D(ZTSK)&($E(IOST)'="P")&($R(30)) "."
 .  Q
 I 'SW S DAY=$P($G(^PRST(458,DA(1),2)),"^",DA) Q:DAY=""  D
 .  Q:$G(^PRST(458,DA(1),"E",D0,"D",DA,2))=""!(($P(DATES,"^",DA)<FR)!($P(DATES,"^",DA)>TO))  S TOUR=$G(^PRST(458,DA(1),"E",D0,"D",DA,2)) Q:TOUR=""  D CKTOUR^PRSRUT0(.TOUR) Q:TOUR=""
 .  S CNT=CNT+1,^TMP($J,"USE",CNT,$P(DA(2),"-",2),$P(DATES,"^",DA),DAY)=TOUR W:'$D(ZTSK)&($E(IOST)'="P")&($R(30)) "."
 .  Q
 Q
