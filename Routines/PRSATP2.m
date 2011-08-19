PRSATP2 ; HISC/REL-Check For OT & LV on Posting Date ;11/29/94  15:35
 ;;4.0;PAID;;Sep 21, 1995
OT ; Check OT/CT Request
 I '$D(^PRST(458.2,"AD",DFN,DTI)) G LV
 I '$D(OTS) S OTS=";"_$P(^DD(458.2,10,0),"^",3)
 F DA=0:0 S DA=$O(^PRST(458.2,"AD",DFN,DTI,DA)) Q:DA<1  I "DX"'[$P($G(^PRST(458.2,DA,0)),"^",8) S CNT=0 D L1^PRSAOTL
LV ; Check Leave Request
 S DTIN=DTI I $P($G(^PRST(457.1,+TC,0)),"^",5)="Y" S X1=DTI,X2=1 D C^%DTC S DTIN=X
 S X2=9999999-DTI
 F KK=0:0 S KK=$O(^PRST(458.1,"AD",DFN,KK)) Q:KK=""!(KK>X2)  F DA=0:0 S DA=$O(^PRST(458.1,"AD",DFN,KK,DA)) Q:DA=""  I ^(DA)'>DTIN,"DX"'[$P($G(^PRST(458.1,DA,0)),"^",9) D L1
 Q
L1 I '$D(LVT) S LVT=";"_$P(^DD(458.1,6,0),"^",3),LVS=";"_$P(^DD(458.1,8,0),"^",3)
 S SRT="E" D L1^PRSALVL Q
