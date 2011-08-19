PRSAPPQ ; HISC/REL-Display Time Data for Prior Pay Periods ;11/29/95  13:44
 ;;4.0;PAID;**6**;Sep 21, 1995
DIS W !!,?7,"Date",?21,"Scheduled Tour",?46,"Tour Exceptions"
F0 ; Display Frames
 K Y1,Y2 S Y1=AUR(2),Y2=AUR(3),Y3=AUR(5),Y4=AUR(6),TC=$P(AUR(1),"^",2)
 I Y1="" S Y1=$S(TC=1:"Day Off",TC=2:"Day Tour",TC=3!(TC=4):"Intermittent",1:"")
 I " 1 3 4 "'[TC,$P(AUR(4),"^",1)="" S Y2(1)="Unposted"
 I TC=3,$P(AUR(4),"^",4)=1 S Y2(1)="Day Worked"
 W !?3,DTE S (L3,L4)=0 I Y1="",Y2="" G EX
 D S1
 F K=1:1 Q:'$D(Y1(K))&'$D(Y2(K))  W:K>1 ! W:$D(Y1(K)) ?21,Y1(K) W:$D(Y2(K)) ?45,$P(Y2(K),"^",1),?63,$P(Y2(K),"^",2)
 W:Y3'="" !?10,Y3
EX Q
S1 ; Set Schedule Array
 F L1=1:3:19 S A1=$P(Y1,"^",L1) Q:A1=""  S L3=L3+1,Y1(L3)=A1 S:$P(Y1,"^",L1+1)'="" Y1(L3)=Y1(L3)_"-"_$P(Y1,"^",L1+1) I $P(Y1,"^",L1+2)'="" S L3=L3+1,Y1(L3)="  "_$P($G(^PRST(457.2,+$P(Y1,"^",L1+2),0)),"^",1)
 G:Y4="" S2
 F L1=1:3:19 S A1=$P(Y4,"^",L1) Q:A1=""  S L3=L3+1,Y1(L3)=A1 S:$P(Y4,"^",L1+1)'="" Y1(L3)=Y1(L3)_"-"_$P(Y4,"^",L1+1) I $P(Y4,"^",L1+2)'="" S L3=L3+1,Y1(L3)="  "_$P($G(^PRST(457.2,+$P(Y4,"^",L1+2),0)),"^",1)
S2 ; Set Worked Array
 F L1=1:4:25 D  I A1="" G S3
 .S A1=$P(Y2,"^",L1+2) Q:A1=""  S L4=L4+1
 .S A2=$P(Y2,"^",L1) I A2'="" S Y2(L4)=A2_"-"_$P(Y2,"^",L1+1)
 .S K=$O(^PRST(457.3,"B",A1,0)) S $P(Y2(L4),"^",2)=A1_" "_$P($G(^PRST(457.3,+K,0)),"^",2)
 .I $P(Y2,"^",L1+3)'="" S L4=L4+1,Y2(L4)="  "_$P($G(^PRST(457.4,+$P(Y2,"^",L1+3),0)),"^",1)
 .Q
S3 Q
VCS ; Display VCS Sales/Fee Basis
 S PAYP=$P($G(^PRSPC(DFN,0)),"^",21) W !!?30,$S(PAYP="F":"Fee Basis Appointee",1:"VCS Commission Sales")
 W !?11,"Sun     Mon     Tue     Wed     Thu     Fri     Sat     Total",!
 W !,"Week 1" S VS=0,L1=1 F K=1:1:7 S L1=L1+8,Z1=$P(Z,"^",K) I Z1'="" S VS=VS+Z1 W ?L1,$J(Z1,7,2)
 W ?63,$J(VS,9,2)
 W !,"Week 2" S VS=0,L1=1 F K=8:1:14 S L1=L1+8,Z1=$P(Z,"^",K) I Z1'="" S VS=VS+Z1 W ?L1,$J(Z1,7,2)
 W ?63,$J(VS,9,2)
 I PAYP="F" W !! F K=19:1:21 S Z1=$P(Z,"^",K) W "Total ",$P("Hours Days Procedures"," ",K-18),": ",Z1,"    "
 Q
ED ; Display Envir. Diff.
 W !!?26,"Environmental Differentials",!
 S Y="" F K=1:2:5 S Z1=$P(Z,"^",K) Q:'Z1  S:Y'="" Y=Y_"; " S Y=Y_$P($G(^PRST(457.6,+Z1,0)),"^",1)_" ( "_$P($G(^(0)),"^",3)_" % ) "_$P(Z,"^",K+1)_" Hrs."
 I Y'="" W !,"Week 1: ",Y
 S Y="" F K=7:2:11 S Z1=$P(Z,"^",K) Q:'Z1  S:Y'="" Y=Y_"; " S Y=Y_$P($G(^PRST(457.6,+Z1,0)),"^",1)_" ( "_$P($G(^(0)),"^",3)_" % ) "_$P(Z,"^",K+1)_" Hrs."
 I Y'="" W !,"Week 2: ",Y
 Q
