IBDEI1HC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25122,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,25122,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,25123,0)
 ;;=T74.21XA^^95^1139^13
 ;;^UTILITY(U,$J,358.3,25123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25123,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,25123,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,25123,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,25124,0)
 ;;=T74.21XD^^95^1139^14
 ;;^UTILITY(U,$J,358.3,25124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25124,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25124,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,25124,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,25125,0)
 ;;=T76.21XA^^95^1139^15
 ;;^UTILITY(U,$J,358.3,25125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25125,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,25125,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,25125,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,25126,0)
 ;;=T76.21XD^^95^1139^16
 ;;^UTILITY(U,$J,358.3,25126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25126,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,25126,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,25126,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,25127,0)
 ;;=Z69.81^^95^1139^27
 ;;^UTILITY(U,$J,358.3,25127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25127,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,25127,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,25127,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,25128,0)
 ;;=Z69.82^^95^1139^21
 ;;^UTILITY(U,$J,358.3,25128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25128,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,25128,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,25128,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,25129,0)
 ;;=T74.01XA^^95^1139^1
 ;;^UTILITY(U,$J,358.3,25129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25129,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,25129,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,25129,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,25130,0)
 ;;=T74.01XD^^95^1139^2
 ;;^UTILITY(U,$J,358.3,25130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25130,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25130,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,25130,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,25131,0)
 ;;=T76.01XA^^95^1139^3
 ;;^UTILITY(U,$J,358.3,25131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25131,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,25131,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,25131,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,25132,0)
 ;;=T76.01XD^^95^1139^4
 ;;^UTILITY(U,$J,358.3,25132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25132,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,25132,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,25132,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,25133,0)
 ;;=Z91.412^^95^1139^31
 ;;^UTILITY(U,$J,358.3,25133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25133,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,25133,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,25133,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,25134,0)
 ;;=T74.31XA^^95^1139^9
 ;;^UTILITY(U,$J,358.3,25134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25134,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
