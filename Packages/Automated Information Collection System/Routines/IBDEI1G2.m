IBDEI1G2 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24541,0)
 ;;=T74.01XD^^93^1090^2
 ;;^UTILITY(U,$J,358.3,24541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24541,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24541,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,24541,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,24542,0)
 ;;=T76.01XA^^93^1090^3
 ;;^UTILITY(U,$J,358.3,24542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24542,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24542,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,24542,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,24543,0)
 ;;=T76.01XD^^93^1090^4
 ;;^UTILITY(U,$J,358.3,24543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24543,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,24543,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,24543,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,24544,0)
 ;;=Z91.412^^93^1090^31
 ;;^UTILITY(U,$J,358.3,24544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24544,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,24544,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,24544,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,24545,0)
 ;;=T74.31XA^^93^1090^9
 ;;^UTILITY(U,$J,358.3,24545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24545,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24545,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,24545,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,24546,0)
 ;;=T74.31XD^^93^1090^10
 ;;^UTILITY(U,$J,358.3,24546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24546,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24546,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,24546,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,24547,0)
 ;;=T76.31XA^^93^1090^11
 ;;^UTILITY(U,$J,358.3,24547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24547,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,24547,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,24547,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,24548,0)
 ;;=T76.31XD^^93^1090^12
 ;;^UTILITY(U,$J,358.3,24548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24548,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24548,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,24548,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,24549,0)
 ;;=Z91.411^^93^1090^30
 ;;^UTILITY(U,$J,358.3,24549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24549,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24549,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,24549,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,24550,0)
 ;;=Z69.021^^93^1090^17
 ;;^UTILITY(U,$J,358.3,24550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24550,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,24550,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24550,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24551,0)
 ;;=Z69.021^^93^1090^18
 ;;^UTILITY(U,$J,358.3,24551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24551,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,24551,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24551,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,24552,0)
 ;;=Z69.021^^93^1090^19
 ;;^UTILITY(U,$J,358.3,24552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24552,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,24552,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,24552,2)
 ;;=^5063231
