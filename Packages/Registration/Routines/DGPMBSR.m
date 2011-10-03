DGPMBSR ;ALB/LM - BED STATUS REPORT RECALCULATION; 16 JAN 91
 ;;5.3;Registration;;Aug 13, 1993
 ;
A I $S('$D(RC):1,'RC:1,1:0) Q  ;  RC=ReCalc from Date
 D CLEAN^DGPMGLG
 ;D UP43 ;  Update file 43
 S DGP("RD")=RD,DGP("PD")=PD,DGP("GL")=GL,DGP("BS")=BS,DGP("TSR")=TSR,DGP("REM")=REM
 S X1=DT,X2=-1 D C^%DTC S YD=X ;  YD=YesterDay
 S X1=PD,X2=-1 D C^%DTC S TSRIPD=X ;  TSR initialization previous date
 S (BS,GL,TSR)=0,DAYC=-1
 ;  Steps thru days to do Recalc
 F PP=1:1 S X1=RC,DAYC=DAYC+1,X2=DAYC D C^%DTC S (RD,X1)=X,X2=-1 D C^%DTC S PD=X Q:RD>YD!('PD)  D ^DGPMBSR1,^DGPMBSR2,^DGPMBSR3,^DGPMBSR4 I $D(^DGS(43.5,"AGL")) D DELETE
 ;  Deletes ReCalc started and ReCalc up to from file 43
 S DIE="^DG(43,",DA=1,DR="52///@;53///@" D ^DIE K DA,DIE,DR
 S RD=DGP("RD"),PD=DGP("PD"),GL=DGP("GL"),BS=DGP("BS"),TSR=DGP("TSR"),REM=DGP("REM"),RC=0
 ;
Q K PP,BD,C,D,DAYC,DGP,I,I1,T,W,X,X1,X2,DGI,DR,DA,DIE Q
 ;
UP43 I $D(ZTSK),ZTSK]"",$D(^%ZTSK(ZTSK)) S DGX=$P(^%ZTSK(ZTSK,0),"^",6),%H=$P(DGX,",") D YMD^%DTC S DGX=$P(DGX,",",2),Z=X_((DGX#3600\60)/100+(DGX\3600)/100) K DGX ;  Find time queued
 S Y="" S:$D(^%ZOSF("VOL")) Y=^("VOL") S:'$D(ZTSK) ZTSK="" S:'$D(Z) Z="N" S DIE="^DG(43,",DA=1,DR="52///N;54///"_ZTSK_";55///"_$S(Z'="N":"/",1:"")_Z_";56///"_Y D ^DIE K ZTSK,IO("Q"),DA,DIE,DR ;  Update file 43
 Q
 ;
DELETE ; Nulls earliest date to correct in the G&L Corrections file once that date has been recalculated and set recalculation date
 F I=0:0 S I=$O(^DGS(43.5,"AGL",I)) Q:'I  F DGI=0:0 S DGI=$O(^DGS(43.5,"AGL",I,DGI)) Q:'DGI  S DR=".08///@;10////"_DT,DA=DGI,DIE="^DGS(43.5," D ^DIE ; S $P(^DGS(43.5,DA,10),"^")=DT
 Q
 ;
VAR ;  RC=ReCalc from date  ;  YD=YesterDay  ;  RD=Report Date  ;
 ;  BS=Bed Status  ;  GL=G&L  ;  REM=Recalc patient days  ;
 ;  PD=Previous Day  ;  W=Ward  ;  D=Division  ;  T=Treating Speciality
