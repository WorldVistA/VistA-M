FHADR6 ; HISC/NCA - Modified Diet Percentage ;1/23/98  16:06
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter Snapshot Date
 S (MD,N)=0 D QR^FHADR1 G:'PRE KIL
 S (ANS,XX)="",TIM=$P($G(^FH(117.3,PRE,1)),"^",12) I TIM'="" S Y=TIM X ^DD("DD") S XX=Y
F1 K %DT W !,"Select SUNDAY Date: ",$S(XX'="":XX_"// ",1:"") R X:DTIME G:'$T!(X["^") KIL
 S:X="" X=XX
 S %DT="EXP" D ^%DT G KIL:$D(DTOUT),F1:Y<1
 S (TIM,X)=Y D H^%DTC G:%Y<0 F1 I %Y W *7,"  .. Not a Sunday" G F1
 S TS=$E(TIM,4,5),TS=$S(TS<4:2,TS<7:3,TS<10:4,1:1) I TS'=$E(PRE,5) W *7,"  .. Date Not Within Qtr" G F1
 I TS>1,$E(PRE,1,3)'=$E(TIM,1,3) W *7,"..Date Not Within Qtr" G F1
 I TS=1,$E(PRE,1,3)-1'=$E(TIM,1,3) W *7,"..Date Not Within Qtr" G F1
 S $P(^FH(117.3,PRE,1),"^",12)=TIM\1
DISP ; Display the numbers of the seven days for validation
 K DC,M,TM S D1=TIM\1 F L=1:1:7 S DC(L)=D1,X1=D1,X2=1 D C^%DTC S D1=X
 F K=1:1:7 S R=$G(^FH(117,DC(K),1)),N=$P(R,"^",26,27) D
 .S M(K)=$P(N,"^",1)
 .I '$P(N,"^",2) D
 ..F LP=21:1:25 S $P(N,"^",2)=$P(N,"^",2)+$P(R,"^",LP)
 ..S $P(^FH(117,DC(K),1),"^",27)=$P(N,"^",2)
 ..Q
 .S TM(K)=$P(N,"^",2)
 .Q
 ; Display Data for the seven dates
 W !!?25 S Y=DC(1) X ^DD("DD") W Y," - " S Y=DC(7) X ^DD("DD") W Y
 W !!?12,"|   X   |   M   |   T   |   W   |   R   |   F   |   S   |"
 W !?12,"|  Sun  |  Mon  |  Tues |  Wed  |  Thur |  Fri  |  Sat  |   Total"
 W !,"_____________________________________________________________________________"
 W !,"# Mod. Diets" S TOT=0 F L=1:1:7 W "|",$J($S(M(L):M(L),1:""),7) S TOT=TOT+M(L)
 W "|",$J($S(TOT:TOT,1:""),8) S TOT=0
 W !,"Total Diets",?12 F L=1:1:7 W "|",$J($S(TM(L):TM(L),1:""),7) S TOT=TOT+TM(L)
 W "|",$J($S(TOT:TOT,1:""),8)
F2 R !!,"Change Numbers of Modified Diets and Total Diets for that week? Y// ",X:DTIME G:'$T!(X="^") KIL S:X="" X="Y" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G F2
 S X=$E(X,1) G:X="N" KIL
OK W !!?10,"Sun  Mon  Tues  Wed  Thur  Fri  Sat"
 W !?10," X    M     T    W     R    F    S"
 W !!,"Enter string of characters for desired days of week: e.g., MWF",!
OK1 R !!,"Select the Day of Week you wish to change the data on: ",WKDS:DTIME G:'$T!("^"[WKDS) KIL S X=WKDS D TR^FH S WKDS=X
 S X1="" F K=1:1 S Z=$E(WKDS,K) Q:Z=""  G:X1[Z MSG S X1=X1_Z I "XMTWRFS"'[Z W !,"Please enter the desired days of the week." G OK
 F K=1:1 S Y=$E(WKDS,K) Q:Y=""  S DAY=$F("XMTWRFS",Y),DAY=DAY-1,WK=$P("Sun Mon Tues Wed Thur Fri Sat"," ",DAY) D E1 Q:ANS="^"
 G KIL:ANS="^",DISP
E1 W !!,"Change # of Modified Diets for ",WK," from ",$S(M(DAY):M(DAY),1:""),"  to: " R Y:DTIME I '$T!(Y["^") S ANS="^" Q
 I Y="",M(DAY) S Y=M(DAY) W "  ",M(DAY)
 I Y'?1N.N!(Y'>0)!(Y>999999999) W *7,!,"  Enter an amount greater than 0 but less than 999999999" G E1
 S M(DAY)=Y
E2 W !!,"Change # of Total Diets for ",WK," from ",$S(TM(DAY):TM(DAY),1:""),"  to: " R Y:DTIME I '$T!(Y["^") S ANS="^" Q
 I Y="",TM(DAY) S Y=TM(DAY) W "  ",TM(DAY)
 I Y'?1N.N!(Y'>0)!(Y>9999999999) W *7,!,"  Enter an amount greater than 0 but less than 9999999999" G E2
 S TM(DAY)=Y
 S $P(^FH(117,DC(DAY),1),"^",26,27)=M(DAY)_"^"_TM(DAY)
 Q
MSG W *7,!,"  Error - Illegal Character or Repeated Day." G OK1
KIL G KILL^XUSCLEAN
EN2 ; Print the % Modified Diet and Number of Patients
 K M,N,TD,TM S (TOT,TQ)=0 F K=1:1:4 S (M(K),TD(K),TM(K))=""
 D:$Y'<(LIN-7) HDR^FHADRPT,HDR2^FHADR3A
 W !!!!,"MODIFIED DIET SUMMARY"
 W !!?35,"1st Qtr",?55,"2nd Qtr",?75,"3rd Qtr",?95,"4th Qtr",?115,"YTD Avg",!
P1 ; Build List of dates and add the Modified Diets for the seven days
 F QR=1:1:4 S QTR=QR,PRE=FHYR_"0"_QTR_"00" D
 .S TIM=$P($G(^FH(117.3,PRE,1)),"^",12) Q:'TIM
 .K DC S D1=TIM\1 F L=1:1:7 S DC(L)=D1,X1=D1,X2=1 D C^%DTC S D1=X
 .F K=1:1:7 S R=$G(^FH(117,DC(K),1)),N=$P(R,"^",26,27) I N'="" D
 ..Q:'$P(N,"^",1)  S M(QTR)=M(QTR)+$P(N,"^",1)
 ..I '$P(N,"^",2) D
 ...F LP=21:1:25 S $P(N,"^",2)=$P(N,"^",2)+$P(R,"^",LP)
 ...S $P(^FH(117,DC(K),1),"^",27)=$P(N,"^",2)
 ...Q
 ..Q:'$P(N,"^",2)  S TM(QTR)=TM(QTR)+$P(N,"^",2)
 ..S TD(QTR)=TD(QTR)+1
 ..Q
 .S:TD(QTR)'="" TQ=TQ+1
 .Q
 W !,"Week Average Modified Diet",?35 F QTR=1:1:4 S X=$S(+TM(QTR)'<1:M(QTR)/TM(QTR)*100,1:""),TOT=TOT+X W $S(X:$J(X,7,1),1:$J("",7))_$J("",13)
 W $S(TQ:$J(TOT/TQ,7,1),1:$J("",7))
 K LP,M,N,R,TD,TM Q
