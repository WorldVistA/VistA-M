FHORE1 ; HISC/REL - Early/Late Trays ;8/8/96  13:57 ;
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
 S ALL=0 D ^FHDPA G:'DFN KIL G:'FHDFN KIL D F1 G:'$D(DFN) KIL G:'$D(FHDFN) KIL I 'FHWF S FHORN="" D ^FHORE1A G KIL
 ; Set HL7
 S FHORN="" D ^FHORE1A I FHDAY D EL^FHWOR3 D KIL I $D(MSG) D MSG^XQOR("FH EVSEND OR",.MSG) K MSG
 Q
F1 ; Process order
 D NOW^%DTC S NOW=%,DT=NOW\1 K %
 S X1=DT,X2=31 D C^%DTC S X31=X
F2 W ! D ALG^FHCLN W !,"Allergies: ",$S(ALG="":"None on file",1:ALG)
 S %DT="AEX",%DT("A")="Select Start Date: " D ^%DT K %DT G AB:U[X!$D(DTOUT),F2:Y<1 S SDT=+Y\1 I SDT<DT G F15
 I SDT>X31 W *7,!,"  [ Cannot schedule more than 31 days in the future ]" G F2
F3 S DTP=SDT D DTP^FH
 S %DT="AEX",%DT("A")="Select End Date: "_DTP_"// " D ^%DT K %DT G AB:X["^"!$D(DTOUT) S:X="" Y=SDT G F3:Y<1 S EDT=+Y\1
 S WKD="" G:SDT=EDT F6 I EDT<SDT W *7,"  [ End before Start? ] " G F2
 I EDT>X31 W *7,!,"  [ Cannot schedule for more than 31 days in the future ]" G F3
OK W !!?10,"Mon  Tues  Wed  Thur  Fri  Sat  Sun"
 W !?10," M     T    W     R    F    S    X"
 W !!,"Enter string of characters for desired days of week: e.g., MWF",!
F4 R !,"Days of Week: ",WKD:DTIME G:'$T!("^"[WKD) AB S X=WKD D TR^FH S WKD=X
 S X1="" F K=1:1 S Z=$E(WKD,K) Q:Z=""  G:X1[Z F16 S X1=X1_Z I "MTWRFSX"'[Z W !,"Please enter the desired days of the week." G OK
F6 R !,"Select Meal (B,N,E): ",MEAL:DTIME G:'$T!("^"[MEAL) AB S X=MEAL D TR^FH S MEAL=X
 I "BNE"'[MEAL!(MEAL'?1U) W *7,!,"Enter B for Breakfast, N for Noon , or E for Evening" G F6
 G:SDT'=EDT F7 F K=SDT:0 S K=$O(^FHPT(FHDFN,"A",ADM,"EL",K)) Q:K<1!(K\1'=SDT)  I $P(^(K,0),"^",2)=MEAL W *7,!!,"Early/Late Meal Already Ordered for this Date!" G AB
F7 R !,"Early or Late (E or L): ",X1:DTIME G AB:'$T!("^"[X1)
 I "el"[X1 S X=X1 D TR^FH S X1=X
 I X1'="E",X1'="L" W *7,!,"Enter E for early tray, L for late tray" G F7
 S SERV=X1 D DP S K=$S(MEAL="B":0,MEAL="N":6,1:12)+(X1="L"*3)
 K N S K2=0 F K1=K+1:1:K+3 S X2=$P(Y,"^",K1) I X2'="" S K2=K2+1,N(K2)=X2
 I 'K2 W *7,!!,"No Early/Late Delivery Times -- Notify Dietetics" G AB
 I K2=1 S K1=1 G F9
F8 W !,"Select Time: ( " F K1=1:1:K2 W K1,"=",N(K1)," "
 R ") ",K1:DTIME G AB:'$T!("^"[K1) I K1<1!(K1>K2)!(K1'?1N) W *7,!,"Enter the number of the desired time" G F8
F9 S TIM=N(K1),X=SDT_"@"_TIM,%DT="XT",NUM=K1 D ^%DT S (SDT,DTE)=Y,EDT=EDT+(SDT#1) G F10:SDT'=EDT,F15:DTE<NOW
 D CUR I FHLD'="" W *7,!!,"Patient is on a WITHHOLD ORDER at that time!" G AB
 I "^^^^"[FHOR W *7,!!,"Patient has NO DIET ORDER at that time!" G AB
F10 S BAG="N" I $P(FHPAR,"^",10)'="N" R !,"Bagged Meal: NO// ",BAG:DTIME G:'$T!(BAG=U) AB S:BAG="" BAG="N" S X=BAG D TR^FH S BAG=X I $P("YES",BAG,1)'="",$P("NO",BAG,1)'="" W *7," Enter Y or N" G F10
 S BAG=$E(BAG,1) W !?5 Q
DP S Y="" S W1=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8),DP=$P($G(^FH(119.6,+W1,0)),"^",8)
 S Y=$G(^FH(119.73,+DP,1)),FHPAR=$G(^FH(119.73,+DP,2)) Q
F15 W *7,!!,"Cannot Order a Meal for a Date/Time before now!" G AB
F16 W *7,!,"  Error - Illegal character or repeated day" G F4
DTP ; Printable Date
 Q:Y<1  S Y=$J(+$E(Y,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(Y,4,5))_"-"_$E(Y,2,3) Q
CUR S A1=0,(FHOR,FHLD)="" F KK=0:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1!(KK>DTE)  S A1=KK
 Q:'A1  S FHORD=$P(^FHPT(FHDFN,"A",ADM,"AC",A1,0),"^",2),X=^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),FHOR=$P(X,"^",2,6),FHLD=$P(X,"^",7) Q
AB W *7,!!,"Early/Late Tray operation TERMINATED - No change!"
KIL K %,%H,%I,%T,%DT,A1,ADM,ALL,BAG,C,DA,FHDFN,DFN,DP,DTE,DTP,EDT,FHDAY,FHLD,FHOR,FHPAR,FHWF,FHPV,I,K,K1,K2,KK,MEAL,N,NUM,NOW,FHORN,FHORD,SDT,SERV,TIM,WARD,WKD,X,X1,X2,X31,Y,Z Q
