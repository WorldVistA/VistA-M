PRSALVE ;HISC/REL-Edit Leave Request ;12-SEP-00
 ;;4.0;PAID;**61,114**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S DFN="",SSN=$P($G(^VA(200,DUZ,1)),"^",9) I SSN'="" S DFN=$O(^PRSPC("SSN",SSN,0))
 I 'DFN W !!,*7,"Your SSN was not found in both the New Person & Employee File!" G EX
 S TLE=$P($G(^PRSPC(DFN,0)),"^",8) S:TLE="" TLE="   " S TLI=+$O(^PRST(455.5,"B",TLE,0))
 D ^PRSAENT S ZENT="",Z1="30 31 31 31 32 33 28 35 35 34 30",Z2="AL SL CB AD NL WP CU AA DL ML RL"
 F K=1:1:11 I $E(ENT,$P(Z1," ",K)) S ZENT=ZENT_$P(Z2," ",K)_" "
 I ZENT="" W !!?5,"You are not entitled to any type of Leave." G EX
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM",!?30,"EDIT LEAVE REQUESTS"
 S X=$G(^PRSPC(DFN,0)) W !!,$P(X,"^",1) S X=$P(X,"^",9) I X W ?67,"XXX-XX-",$E(X,6,9)
 S X1=DT,X2=-5 D C^%DTC S EDT=9999999-X
 W ! D DISP
 G:'CNT EX
X1 R !!,"Edit Which Request #? ",X:DTIME G:'$T!("^"[X) EX I X'?1N.N!(X<1)!(X>CNT) W *7," Enter # of Request to Edit" G X1
 K DDS,DA,DR S X=+X,DA=R(X),ZOLD=$G(^PRST(458.1,DA,0)),Z1=$P(ZOLD,"^",3,6) D ED^PRSALVR G EX
DISP ; Display Leave Requests
 S LVT=";"_$P(^DD(458.1,6,0),"^",3),LVS=";"_$P(^DD(458.1,8,0),"^",3),CNT=0 K R
 F DTI=0:0 S DTI=$O(^PRST(458.1,"AD",DFN,DTI)) Q:DTI=""!(DTI>EDT)  F DA=0:0 S DA=$O(^PRST(458.1,"AD",DFN,DTI,DA)) Q:DA=""  D LST
 W:'CNT !,"No Requests to Edit." Q
LST ; Display Request
 S Z=$G(^PRST(458.1,DA,0)) Q:Z=""  S SCOM=$P($G(^(1)),"^",1)
 S Z1=$P(Z,"^",3)
 S Y=$G(^PRST(458,"AD",Z1)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2)
 I PPI,DAY,$D(^PRST(458,PPI,"E",DFN,"D",DAY,10)) Q
 S CNT=CNT+1 W !,$J(CNT,2)," " S R(CNT)=DA
 W $P(Z,"^",4)," " S X=$P(Z,"^",3) D DTP^PRSAPPU W Y," to ",$P(Z,"^",6)," "
 S X=$P(Z,"^",5) D DTP^PRSAPPU W Y," "
 S X=$P(Z,"^",15) I X W X," ",$S($P(Z,"^",16)="D":"days",1:"hrs")," "
 S X=$P(Z,"^",7),%=$F(LVT,";"_X_":") I %>0 W $P($E(LVT,%,999),";",1)," "
 S X=$P(Z,"^",9)
 S %=$F(LVS,";"_X_":") I %>0 W $P($E(LVS,%,999),";",1)
 S X=$P(Z,"^",8) W:X'="" !?5,X W:SCOM'="" !?5,"Supr: ",SCOM Q
EX G KILL^XUSCLEAN
