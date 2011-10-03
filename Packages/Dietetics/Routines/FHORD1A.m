FHORD1A ; HISC/REL/NCA - Diet Order Window ;7/11/96  12:21 ;
 ;;5.5;DIETETICS;;Jan 28, 2005
WIN Q:$P(D1,".",1)'=$P(NOW,".",1)  S X1=+$E($P(D1,".",2)_"0000",1,4)
 S X2=+$E($P(NOW,".",2)_"0000",1,4),K1=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8)
 S DP=$P($G(^FH(119.6,+K1,0)),"^",8)
 S X=$G(^FH(119.73,+DP,2))
 F K=1:2:5 S A1=$P(X,"^",K),A2=$P(X,"^",K+1) I A1,A2,X1'<A1,X1'>A2,X2'<A1,X2'>A2 G W1
 Q
W1 S MEAL=$S(K=1:"B",K=3:"N",1:"E"),A1=$P(D1,".",1)
 F K=A1:0 S K=$O(^FHPT(FHDFN,"A",ADM,"EL",K)) Q:K<1!(K\1'=A1)  I $P(^(K,0),"^",2)=MEAL G W5
 W *7,!!,"You have missed the ",$S(MEAL="B":"BREAKFAST",MEAL="N":"NOON",1:"EVENING")," cut-off."
W2 R !!,"Do you wish to order a LATE TRAY? (Y/N): ",YN:DTIME Q:'$T!(YN["^")  S:YN="" YN="^" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G W2
 Q:YN?1"N".E
 S A1=$G(^FH(119.73,+DP,1)),K=$S(MEAL="B":3,MEAL="N":9,1:15)
 K N S %DT="XT",K2=0 F K1=K+1:1:K+3 S X2=$P(A1,"^",K1) I X2'="" S X=$P(D1,".",1)_"@"_X2 D ^%DT I Y'<NOW S K2=K2+1,N(K2)=X2_"^"_Y
 I 'K2 W *7,!!,"No Late Tray Delivery Times -- Notify Dietetics" Q
 I K2=1 S K1=1 G W4
W3 W !,"Select Time ( " F K1=1:1:K2 W K1,"=",$P(N(K1),"^",1)," "
 R "): ",K1:DTIME Q:'$T!(K1["^")  I K1<1!(K1>K2)!(K1'?1N) W *7,!,"Enter the number of the desired time" G W3
W4 S TIM=$P(N(K1),"^",1),DTE=$P(N(K1),"^",2) N FHORN S FHORN="",NUM=K1
 S BAG="N" D FIL^FHORE1A W "  .. done" Q
W5 Q
