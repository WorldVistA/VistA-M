IBDEI1KB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26507,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,26507,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,26507,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,26508,0)
 ;;=T74.31XA^^100^1265^9
 ;;^UTILITY(U,$J,358.3,26508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26508,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,26508,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,26508,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,26509,0)
 ;;=T74.31XD^^100^1265^10
 ;;^UTILITY(U,$J,358.3,26509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26509,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,26509,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,26509,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,26510,0)
 ;;=T76.31XA^^100^1265^11
 ;;^UTILITY(U,$J,358.3,26510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26510,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,26510,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,26510,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,26511,0)
 ;;=T76.31XD^^100^1265^12
 ;;^UTILITY(U,$J,358.3,26511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26511,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,26511,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,26511,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,26512,0)
 ;;=Z91.411^^100^1265^30
 ;;^UTILITY(U,$J,358.3,26512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26512,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,26512,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,26512,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,26513,0)
 ;;=Z69.021^^100^1265^17
 ;;^UTILITY(U,$J,358.3,26513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26513,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,26513,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,26513,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,26514,0)
 ;;=Z69.021^^100^1265^18
 ;;^UTILITY(U,$J,358.3,26514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26514,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,26514,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,26514,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,26515,0)
 ;;=Z69.021^^100^1265^19
 ;;^UTILITY(U,$J,358.3,26515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26515,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,26515,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,26515,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,26516,0)
 ;;=Z69.021^^100^1265^20
 ;;^UTILITY(U,$J,358.3,26516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26516,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,26516,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,26516,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,26517,0)
 ;;=Z69.011^^100^1265^22
 ;;^UTILITY(U,$J,358.3,26517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26517,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,26517,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,26517,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,26518,0)
 ;;=Z69.011^^100^1265^23
 ;;^UTILITY(U,$J,358.3,26518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26518,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,26518,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,26518,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,26519,0)
 ;;=Z69.011^^100^1265^24
