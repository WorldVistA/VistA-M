FHCMS1 ; HISC/NCA/RVD - Calculate Meals ;3/22/93  12:28
 ;;5.5;DIETETICS;;Jan 28, 2005
 S FHTOT=0 F LL=SDT:0 S LL=$O(^FH(117,LL)) Q:LL<1!($E(LL,1,5)>$E(EDT,1,5))  D N1
 Q
N1 S Y0=$G(^FH(117,LL,0)) Q:Y0=""
 I $P($G(^FH(119.9,1,0)),U,20)'="N" G ALL    ;multidivisional
 S Y1=$G(^FH(117,LL,1))
 S K=1 F L=1,2,4,5,7,8 S K=K+1,N(L)=$P(Y0,"^",K)
 S K=10 F L=1:3:16 S K=K+1,N(K)=$P(Y1,"^",L)+$P(Y1,"^",L+1)+$P(Y1,"^",L+2)
 S N(3)=N(1)-N(2)*3,N(6)=N(4)-N(5)*3,N(9)=N(7)-N(8)*3
 S N(10)=N(3)+N(6)+N(9)
 S N(16)=N(14)+N(15)+N(16),N(13)=N(12)+N(13),N(17)=N(11)+N(13)+N(16),N(18)=N(10)+N(17)
 S FHTOT=FHTOT+N(18) Q
 ;
ALL ;get all comm.
 S K=1 F L=1,2,4,5,7,8 S K=K+1,N(L)=$P(Y0,"^",K)
 F FHCOI=0:0 S FHCOI=$O(^FH(117,LL,2,FHCOI)) Q:FHCOI'>0  D
 .S Y0=$G(^FH(117,LL,2,FHCOI,1)) Q:Y0=""
 .S K=1 F L=1,2,4,5,7,8 S K=K+1,N(L)=$P(Y0,"^",K)
 .S Y1=$G(^FH(117,LL,2,FHCOI,0)) Q:Y1=""
 .S K=10 F L=2:4:17 S K=K+1,N(K)=$P(Y1,"^",L)+$P(Y1,"^",L+1)+$P(Y1,"^",L+2)
 .S N(3)=N(1)-N(4)*3,N(6)=N(6)-N(7)*3,N(9)=N(7)-N(8)*3
 .S N(10)=N(3)+N(6)+N(9)
 .S N(16)=N(14)+N(15)+N(16),N(13)=N(12)+N(13),N(17)=N(11)+N(13)+N(16),N(18)=N(10)+N(17)
 .S FHTOT=FHTOT+N(18)
 Q
