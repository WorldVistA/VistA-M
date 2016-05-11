IBDEI1EQ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23929,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,23929,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,23929,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,23930,0)
 ;;=T76.31XA^^90^1035^11
 ;;^UTILITY(U,$J,358.3,23930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23930,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,23930,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,23930,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,23931,0)
 ;;=T76.31XD^^90^1035^12
 ;;^UTILITY(U,$J,358.3,23931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23931,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,23931,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,23931,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,23932,0)
 ;;=Z91.411^^90^1035^30
 ;;^UTILITY(U,$J,358.3,23932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23932,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,23932,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,23932,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,23933,0)
 ;;=Z69.021^^90^1035^17
 ;;^UTILITY(U,$J,358.3,23933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23933,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,23933,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,23933,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,23934,0)
 ;;=Z69.021^^90^1035^18
 ;;^UTILITY(U,$J,358.3,23934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23934,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,23934,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,23934,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,23935,0)
 ;;=Z69.021^^90^1035^19
 ;;^UTILITY(U,$J,358.3,23935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23935,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,23935,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,23935,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,23936,0)
 ;;=Z69.021^^90^1035^20
 ;;^UTILITY(U,$J,358.3,23936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23936,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,23936,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,23936,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,23937,0)
 ;;=Z69.011^^90^1035^22
 ;;^UTILITY(U,$J,358.3,23937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23937,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,23937,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,23937,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,23938,0)
 ;;=Z69.011^^90^1035^23
 ;;^UTILITY(U,$J,358.3,23938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23938,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,23938,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,23938,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,23939,0)
 ;;=Z69.011^^90^1035^24
 ;;^UTILITY(U,$J,358.3,23939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23939,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,23939,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,23939,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,23940,0)
 ;;=Z69.011^^90^1035^25
 ;;^UTILITY(U,$J,358.3,23940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23940,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,23940,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,23940,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,23941,0)
 ;;=F06.4^^90^1036^6
