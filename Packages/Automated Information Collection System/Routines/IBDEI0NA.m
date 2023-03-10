IBDEI0NA ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10490,0)
 ;;=H0038^^41^468^1^^^^1
 ;;^UTILITY(U,$J,358.3,10490,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10490,1,2,0)
 ;;=2^H0038
 ;;^UTILITY(U,$J,358.3,10490,1,3,0)
 ;;=3^Peer Support,per 15 min
 ;;^UTILITY(U,$J,358.3,10491,0)
 ;;=T74.11XA^^42^469^5
 ;;^UTILITY(U,$J,358.3,10491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10491,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,10491,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,10491,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,10492,0)
 ;;=T74.11XD^^42^469^6
 ;;^UTILITY(U,$J,358.3,10492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10492,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,10492,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,10492,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,10493,0)
 ;;=T76.11XA^^42^469^7
 ;;^UTILITY(U,$J,358.3,10493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10493,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,10493,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,10493,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,10494,0)
 ;;=T76.11XD^^42^469^8
 ;;^UTILITY(U,$J,358.3,10494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10494,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,10494,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,10494,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,10495,0)
 ;;=Z69.11^^42^469^31
 ;;^UTILITY(U,$J,358.3,10495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10495,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,10495,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,10495,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,10496,0)
 ;;=Z91.410^^42^469^35
 ;;^UTILITY(U,$J,358.3,10496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10496,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,10496,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,10496,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,10497,0)
 ;;=Z69.12^^42^469^27
 ;;^UTILITY(U,$J,358.3,10497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10497,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,10497,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,10497,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,10498,0)
 ;;=T74.21XA^^42^469^13
 ;;^UTILITY(U,$J,358.3,10498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10498,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,10498,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,10498,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,10499,0)
 ;;=T74.21XD^^42^469^14
 ;;^UTILITY(U,$J,358.3,10499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10499,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,10499,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,10499,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,10500,0)
 ;;=T76.21XA^^42^469^15
 ;;^UTILITY(U,$J,358.3,10500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10500,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,10500,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,10500,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,10501,0)
 ;;=T76.21XD^^42^469^16
 ;;^UTILITY(U,$J,358.3,10501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10501,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
