FHORE1A ; HISC/REL - File Early/Late Order ;6/21/96  10:14
 ;;5.5;DIETETICS;;Jan 28, 2005
PROC ; File complete order
 S FHDAY=0,DTE=SDT I SDT=EDT D FIL G F13
F11 G:DTE<NOW F12
 S X=DTE\1 D DOW^%DTC G:WKD'[$E("XMTWRFS",Y+1) F12
 F K=X:0 S K=$O(^FHPT(FHDFN,"A",ADM,"EL",K)) Q:K<1!(K\1'=X)  I $P(^(K,0),"^",2)=MEAL W:FHWF'=2 *7,!,"Early/Late Meal Already Ordered for ",$E(X,4,5),"/",$E(X,6,7),"/",$E(X,2,3),! G F12
 D FIL W:FHWF'=2 "."
F12 S X1=DTE\1,X2=1 D C^%DTC G:X>EDT F13
 S X=X_"@"_TIM,%DT="XT" D ^%DT S DTE=Y G F11
F13 W:FHWF'=2 "... done" Q
FIL ; File daily order
 I '$D(^FHPT(FHDFN,"A",ADM,"EL",0)) S ^(0)="^115.05D^^"
 S %=$P(^FHPT(FHDFN,"A",ADM,"EL",0),"^",4)+1,$P(^(0),"^",3,4)=DTE_"^"_%
 S ^FHPT(FHDFN,"A",ADM,"EL",DTE,0)=DTE_"^"_MEAL_"^"_TIM_"^"_BAG_"^"_DUZ_"^"_NOW_"^"_+FHORN,FHDAY=1
 S ^FHPT("ADLT",DTE,FHDFN,ADM)="" Q
