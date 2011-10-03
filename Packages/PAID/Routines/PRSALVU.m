PRSALVU ; HISC/REL-Leave Length ;5/31/95  12:21
 ;;4.0;PAID;;Sep 21, 1995
 S Z=$G(^PRST(458.1,DA,0)) I $E(ENT,1,2)["D" G D
 I $P(Z,"^",7)="ML" G D
H ; Calculate Hours
 S TYL="H",D1=$P(Z,"^",3) D PP^PRSAPPU
 I D1=$P(Z,"^",5) G 1
 ; Calculate first day
 D TC S X1=$G(^PRST(457.1,+TC,1))
 S X2="MID" F K=1:3 Q:$P(X1,"^",K)=""  S %=$P(X1,"^",K+2) I $S('%:1,1:$P($G(^PRST(457.2,%,0)),"^",2)="RG") S X2=$P(X1,"^",K+1)
 S X=$P(Z,"^",4)_"^"_X2 D CNV^PRSATIM S TIM=$P(Y,"^",2)-$P(Y,"^",1)/60 S:TIM<0 TIM=0
 D RG I TIM>RG S TIM=RG
 E  S X1=$P(X1,"^",3) I X1,TIM>4.75 S TIM=TIM-(X1/60)
 ; Calculate intermediate days
0 S DAY=DAY+1 S:DAY=15 DAY=1,PPI=$S('PPI:PPI,$D(^PRST(458,PPI+1)):PPI+1,1:"")
 S X1=D1,X2=1 D C^%DTC S D1=X I X'<$P(Z,"^",5) G L
 D TC,RG S TIM=TIM+RG G 0
L ; Calculate last day
 D TC S X1=$G(^PRST(457.1,+TC,1))
 S X2="MID" F K=1:3 Q:$P(X1,"^",K)=""  S %=$P(X1,"^",K+2) I $S('%:1,1:$P($G(^PRST(457.2,%,0)),"^",2)="RG") S X2=$P(X1,"^",K) Q
 S X=X2_"^"_$P(Z,"^",6) D CNV^PRSATIM S T1=$P(Y,"^",2)-$P(Y,"^",1)/60 S:T1<0 T1=0
 D RG I T1>RG S T1=RG
 E  S X1=$P(X1,"^",3) I X1,T1>4.75 S T1=T1-(X1/60)
 S TIM=TIM+T1 G S
1 ; One Day
 S X=$P(Z,"^",4)_"^"_$P(Z,"^",6) D CNV^PRSATIM S TIM=$P(Y,"^",2)-$P(Y,"^",1)/60
 D TC,RG I TIM>RG S TIM=RG G S
 S X1=$P(X1,"^",3) I X1,TIM>4.75 S TIM=TIM-(X1/60)
 G S
TC ; Get tour
 I PPI S X1=$G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),TC=$P(X1,"^",2)
 E  S PPI=$P(^PRST(458,0),"^",3),X1=$G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),TC=$P(X1,"^",2) I $P(X1,"^",3),$P(X1,"^",4) S TC=$P(X1,"^",4)
 Q
RG ; Get X1,RG
 S X1=$G(^PRST(457.1,+TC,0)),RG=$P(X1,"^",6) Q:RG'=""  I TC<5 S RG=0 Q
 I $E(AC,2)=1,NH=48 S RG=12 Q
 S RG=$S(NH>80:24,NH<80:NH\10,1:8) Q
D ; Calculate Days
 S X2=$P(Z,"^",3),X1=$P(Z,"^",5) I 'X1!('X2) Q
 D ^%DTC S TIM=X+1,TYL="D" G S
S ; Store length
 S $P(^PRST(458.1,DA,0),"^",15,16)=TIM_"^"_TYL Q
