FHADR4 ; HISC/NCA - Annual Nutrition Status Summary ;9/10/93  14:44
 ;;5.5;DIETETICS;;Jan 28, 2005
Q1 ; Process Screening
 K M,N,S,T1 S (TD,XX)=0
 F K=1:1:5 S S(K)=0,T1(K)=""
 F QR=1:1:4 S QTR=QR,PRE=FHYR_"0"_QTR_"00" D Q2^FHADRPT,Q11
 G EN2
Q11 ; T1(1-4) have tabulated statuses for the quarters
 ; T1(5) is final Total
 Q:'SDT!('EDT)
 S D1=SDT,(FIN,ND)=0,(M,N)="" F L1=0:0 D Q2 S X1=D1,X2=1 D C^%DTC Q:X>EDT  S D1=X
 Q:'FIN
 F K=1:1:5 S $P(T1(QTR),"^",K)=$J($S(ND:$P(N,"^",K)/ND,1:0),0,0),$P(T1(5),"^",QTR)=$P(T1(5),"^",QTR)+$P(T1(QTR),"^",K)
 F K=1:1:5 S $P(T1(QTR),"^",K+5)=$J($S($P(T1(5),"^",QTR):$P(T1(QTR),"^",K)/$P(T1(5),"^",QTR)*100,1:0),0,1)
 S:ND TD=TD+1
 Q
Q2 ; Tabulate status
 S TOT=0
 S X4=$G(^FH(117,D1,0)) Q:X4=""  S X5=$G(^(1))
 Q:X5=""
 S K=20 F L=1:1:5 S K=K+1,S(L)=$P(X5,"^",K),TOT=TOT+$S(S(L):S(L),1:0) S:'$D(N) N="" S $P(N,"^",L)=$P(N,"^",L)+$S(S(L):S(L),1:0)
 Q:'TOT  S ND=ND+1
 S X=$S(TOT:TOT,1:0),FIN=FIN+X
 F K=1:1:5 S X=S(K) S:'$D(M) M="" S $P(M,"^",K)=$P(M,"^",K)+$S(X:X,1:0)
 Q
EN2 ; Print Summary
 D HDR
 F K=1:1:5 F J=1:1:4 S $P(T1(K),"^",11)=$P(T1(K),"^",11)+$S($P(T1(J),"^",K):$P(T1(J),"^",K),1:0)
 F J=1:1:5 S XX=XX+$S($P(T1(J),"^",11):$P(T1(J),"^",11),1:0)
 F K=1:1:5 S TIT=$P("I,II,III,IV,UNC",",",K)_" "_$S(K<5:$P($G(^FH(115.4,K,0)),"^",3),1:"UNCLASSIFIED") D LP
 W !,?13,"TOTAL",?67 F I=1:1:4 W $J($S($P(T1(5),"^",I):$P(T1(5),"^",I),1:""),5)_$J("",7)
 W ?117,$J($S(XX:XX,1:""),5)
 K M,N,S,T1 Q
LP W !,?13,TIT,?67
 F I=1:1:4 W $S($P(T1(I),"^",K):$J($P(T1(I),"^",K),5),1:$J("",5))_$J("",7)
 W ?117,$S($P(T1(K),"^",11):$J($P(T1(K),"^",11),5,0),1:$J("",5))
 W !,?13,"%",?67 F I=1:1:4 W $S($P(T1(I),"^",K+5):$J($P(T1(I),"^",K+5),5,1),1:$J("",5))_$J("",7)
 S X6=$S(XX:$P(T1(K),"^",11)/XX*100,1:"")
 W ?117,$S(X6:$J(X6,5,1),1:$J("",5)),!
 Q
HDR ; Print Heading for Nutrition Statuses Summary
 D:$Y'<(LIN-22) HDR^FHADRPT,HDR2^FHADR3A
 W !!!,?14,"NUTRITION STATUS SUMMARY"
 W !!,?67,"Avg",?79,"Avg",?91,"Avg",?103,"Avg",?117,"YTD"
 W !?13,"Status",?65,"1st Qtr     2nd Qtr     3rd Qtr     4th Qtr       Tot Avg",! Q
