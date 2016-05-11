IBDEI28K ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37939,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,37939,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,37939,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,37940,0)
 ;;=T76.31XA^^145^1828^11
 ;;^UTILITY(U,$J,358.3,37940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37940,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,37940,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,37940,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,37941,0)
 ;;=T76.31XD^^145^1828^12
 ;;^UTILITY(U,$J,358.3,37941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37941,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,37941,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,37941,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,37942,0)
 ;;=Z91.411^^145^1828^30
 ;;^UTILITY(U,$J,358.3,37942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37942,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,37942,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,37942,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,37943,0)
 ;;=Z69.021^^145^1828^17
 ;;^UTILITY(U,$J,358.3,37943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37943,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,37943,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,37943,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,37944,0)
 ;;=Z69.021^^145^1828^18
 ;;^UTILITY(U,$J,358.3,37944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37944,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,37944,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,37944,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,37945,0)
 ;;=Z69.021^^145^1828^19
 ;;^UTILITY(U,$J,358.3,37945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37945,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,37945,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,37945,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,37946,0)
 ;;=Z69.021^^145^1828^20
 ;;^UTILITY(U,$J,358.3,37946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37946,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,37946,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,37946,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,37947,0)
 ;;=Z69.011^^145^1828^22
 ;;^UTILITY(U,$J,358.3,37947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37947,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,37947,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,37947,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,37948,0)
 ;;=Z69.011^^145^1828^23
 ;;^UTILITY(U,$J,358.3,37948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37948,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,37948,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,37948,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,37949,0)
 ;;=Z69.011^^145^1828^24
 ;;^UTILITY(U,$J,358.3,37949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37949,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,37949,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,37949,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,37950,0)
 ;;=Z69.011^^145^1828^25
 ;;^UTILITY(U,$J,358.3,37950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37950,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,37950,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,37950,2)
 ;;=^5063229
