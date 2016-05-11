IBDEI28J ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37927,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,37927,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,37927,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,37928,0)
 ;;=T74.21XD^^145^1828^14
 ;;^UTILITY(U,$J,358.3,37928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37928,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,37928,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,37928,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,37929,0)
 ;;=T76.21XA^^145^1828^15
 ;;^UTILITY(U,$J,358.3,37929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37929,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,37929,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,37929,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,37930,0)
 ;;=T76.21XD^^145^1828^16
 ;;^UTILITY(U,$J,358.3,37930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37930,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,37930,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,37930,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,37931,0)
 ;;=Z69.81^^145^1828^27
 ;;^UTILITY(U,$J,358.3,37931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37931,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,37931,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,37931,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,37932,0)
 ;;=Z69.82^^145^1828^21
 ;;^UTILITY(U,$J,358.3,37932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37932,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,37932,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,37932,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,37933,0)
 ;;=T74.01XA^^145^1828^1
 ;;^UTILITY(U,$J,358.3,37933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37933,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,37933,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,37933,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,37934,0)
 ;;=T74.01XD^^145^1828^2
 ;;^UTILITY(U,$J,358.3,37934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37934,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,37934,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,37934,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,37935,0)
 ;;=T76.01XA^^145^1828^3
 ;;^UTILITY(U,$J,358.3,37935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37935,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,37935,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,37935,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,37936,0)
 ;;=T76.01XD^^145^1828^4
 ;;^UTILITY(U,$J,358.3,37936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37936,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,37936,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,37936,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,37937,0)
 ;;=Z91.412^^145^1828^31
 ;;^UTILITY(U,$J,358.3,37937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37937,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,37937,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,37937,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,37938,0)
 ;;=T74.31XA^^145^1828^9
 ;;^UTILITY(U,$J,358.3,37938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37938,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,37938,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,37938,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,37939,0)
 ;;=T74.31XD^^145^1828^10
