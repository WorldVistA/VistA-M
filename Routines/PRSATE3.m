PRSATE3 ; HISC/REL-Display Detailed Tour ;12/8/92  08:33
 ;;4.0;PAID;;Sep 21, 1995
F0 ; Display Frames
 K Y1,Y2 S TD=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",2),Y1=$G(^(1)),Y4=$G(^(4)) I SRT="N" S Y4="" I $P($G(^(0)),"^",3) S TD=$P(^(0),"^",4),Y1=$G(^PRST(457.1,+TD,1))
 I Y1="" S Y1=$S(TD=1:"Day Off",TD=2:"Day Tour",TD=3!(TD=4):"Intermittent",1:"")
 S TD=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY+7,0)),"^",2),Y2=$G(^(1)),Y5=$G(^(4)) I SRT="N" S Y5="" I $P($G(^(0)),"^",3) S TD=$P(^(0),"^",4),Y2=$G(^PRST(457.1,+TD,1))
 I Y2="" S Y2=$S(TD=1:"Day Off",TD=2:"Day Tour",TD=3!(TD=4):"Intermittent",1:"")
 S DTE=$P("Sun Mon Tue Wed Thu Fri Sat"," ",DAY)
 W !?3,DTE S (L2,L3)=0 I Y1="",Y2="" G EX
S0 ; Set Schedule Array
 F L1=1:3:19 S A1=$P(Y1,"^",L1) Q:A1=""  S L2=L2+1,Y1(L2)=A1 S:$P(Y1,"^",L1+1)'="" Y1(L2)=Y1(L2)_"-"_$P(Y1,"^",L1+1) I $P(Y1,"^",L1+2)'="" S L2=L2+1,Y1(L2)="  "_$P($G(^PRST(457.2,+$P(Y1,"^",L1+2),0)),"^",1)
 G:Y4="" S1
 F L1=1:3:19 S A1=$P(Y4,"^",L1) Q:A1=""  S L2=L2+1,Y1(L2)=A1 S:$P(Y4,"^",L1+1)'="" Y1(L2)=Y1(L2)_"-"_$P(Y4,"^",L1+1) I $P(Y4,"^",L1+2)'="" S L2=L2+1,Y1(L2)="  "_$P($G(^PRST(457.2,+$P(Y4,"^",L1+2),0)),"^",1)
S1 ; Set Schedule Array
 F L1=1:3:19 S A1=$P(Y2,"^",L1) Q:A1=""  S L3=L3+1,Y2(L3)=A1 S:$P(Y2,"^",L1+1)'="" Y2(L3)=Y2(L3)_"-"_$P(Y2,"^",L1+1) I $P(Y2,"^",L1+2)'="" S L3=L3+1,Y2(L3)="  "_$P($G(^PRST(457.2,+$P(Y2,"^",L1+2),0)),"^",1)
 G:Y5="" S2
 F L1=1:3:19 S A1=$P(Y5,"^",L1) Q:A1=""  S L3=L3+1,Y2(L3)=A1 S:$P(Y5,"^",L1+1)'="" Y2(L3)=Y2(L3)_"-"_$P(Y5,"^",L1+1) I $P(Y5,"^",L1+2)'="" S L3=L3+1,Y2(L3)="  "_$P($G(^PRST(457.2,+$P(Y5,"^",L1+2),0)),"^",1)
S2 F K=1:1 Q:'$D(Y1(K))&'$D(Y2(K))  W:K>1 ! W:$D(Y1(K)) ?11,Y1(K) W:$D(Y2(K)) ?45,Y2(K)
EX Q
