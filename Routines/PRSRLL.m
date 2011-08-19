PRSRLL ;HISC/JH-CALCULATE LENGTH OF TIME ;7-AUG-2000
 ;;4.0;PAID;**2,6,21,61,115**;Sep 21, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;This routine is called by ^PRSRL11,^PRSRL12,^PRSRL41.
H ; Calculate Hours
 N %,DAY,X,X1,X2,D1,PPE,Y,K S TYL="H",D1=$P(Z,"^",3) D PP^PRSAPPU
 I D1=$P(Z,"^",5) G 1
 ; Calculate first day
 D TC S X1=$G(^PRST(457.1,+TC,1))
 S X2="MID" F K=1:3 Q:$P(X1,"^",K)=""  S %=$P(X1,"^",K+2) I $S('%:1,1:$P($G(^PRST(457.2,%,0)),"^",2)="RG") S X2=$P(X1,"^",K+1)
 S X=$P(Z,"^",4)_"^"_X2 D CNV S TIM=$P(Y,"^",2)-$P(Y,"^",1)/60 S:TIM<0 TIM=0
 D RG I TIM>RG S TIM=RG
 E  S X1=$P(X1,"^",3) I X1,TIM>4.75 S TIM=TIM-(X1/60)
 ; Calculate intermediate days
0 S DAY=DAY+1 S:DAY=15 DAY=1,PPI=$S('PPI:PPI,$D(^PRST(458,PPI+1)):PPI+1,1:"")
 S X1=D1,X2=1 D C^%DTC S D1=X I X'<$P(Z,"^",5) G L
 D TC,RG S TIM=TIM+RG G 0
L ; Calculate last day
 D TC S X1=$G(^PRST(457.1,+TC,1))
 S X2="MID" F K=1:3 Q:$P(X1,"^",K)=""  S %=$P(X1,"^",K+2) I $S('%:1,1:$P($G(^PRST(457.2,%,0)),"^",2)="RG") S X2=$P(X1,"^",K) Q
 S X=X2_"^"_$P(Z,"^",6) D CNV S T1=$P(Y,"^",2)-$P(Y,"^",1)/60 S:T1<0 T1=0
 D RG I T1>RG S T1=RG
 E  S X1=$P(X1,"^",3) I X1,T1>4.75 S T1=T1-(X1/60)
 S TIM=TIM+T1 K AC,FLX,NH,T1 Q
1 ; One Day
 S X=$P(Z,"^",4)_"^"_$P(Z,"^",6) D CNV
 I $P(Z,"^",4)["P"&($P(Z,"^",6)["A") S TIM=((1440-$P(Y,U))/60)+($P(Y,U,2)/60)
 E  S TIM=$P(Y,"^",2)-$P(Y,"^",1)/60
 S:TIM'>0 TIM=TIM+24 ;This line of code relocated to correct miscalculation - refer to Patch PRS*4*61
 D TC,RG I (TIM-(LUN/60))>RG&($P(X4,"^",13)'="") D SEC I TIM>RG S TIM=RG Q
 I TIM>RG S TIM=RG
 ;Algorithm to determine whether to deduct lunch.  Deduct lunch from 
 ;leave only when leave taken is >= length of tour + meal time.
 I $P(TOUR,"^",5)'="" D
 .  S LEN=$P($G(^PRST(458,PPI,"E",D0,"D",DAY,0)),"^",8)
 .  I (LEN+LUN)<TIM S TIM=(TIM-(LUN/60))
 Q
TC ; Get tour
 I PPI S X1=$G(^PRST(458,PPI,"E",D0,"D",DAY,0)),X4=X1,TC=$P(X1,"^",2)
 E  S PPI=$P(^PRST(458,0),"^",3),X1=$G(^PRST(458,PPI,"E",D0,"D",DAY,0)),X4=X1,TC=$P(X1,"^",2) I $P(X1,"^",3),$P(X1,"^",4) S TC=$P(X1,"^",4)
 Q
RG ; Get X1,RG
 S X1=$G(^PRST(457.1,+TC,0)),LUN=$P(X1,"^",3),RG=$P(X1,"^",6) Q:RG'=""  I TC<5 S RG=0 Q
 I $E(AC,2)=1,NH=48 S RG=12 Q
 S RG=$S(NH>80:24,NH<80:8,FLX="C":10,1:8) Q
D ; Calculate Days
 N %,K S X2=$P(Z,"^",3),X1=$P(Z,"^",5) I 'X1!('X2) Q
 D ^%DTC S TIM=X+1,TYL="D"
 Q
CNV ; Convert Start/Stop to minutes
 ; X=start_"^"_stop  Output: Y=start(min)_"^"_stop(min)
 S CNX=X,X=$P(CNX,"^",1),Y=0 D MIL S Y=Y\100*60+(Y#100),$P(CNX,"^",1)=Y
 S X=$P(CNX,"^",2),Y=1 D MIL S Y=Y\100*60+(Y#100)
 S Y=$P(CNX,"^",1)_"^"_Y K CNX Q
MIL ; Convert from AM/PM to 2400
 ; X=time Y: 0=Mid=0,1=Mid=2400 Output: Y=time in 2400
 I X="MID"!(X="NOON") S Y=$S(X="NOON":1200,Y:2400,1:0) Q
 S Y=$P(X,":",1)_$P(X,":",2),Y=+Y Q:X["A"
 S:Y<1200 Y=Y+1200 Q
SEC S TC=$P(X4,"^",13) D RG Q
