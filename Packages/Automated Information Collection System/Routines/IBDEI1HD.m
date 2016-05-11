IBDEI1HD ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25134,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,25134,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,25135,0)
 ;;=T74.31XD^^95^1139^10
 ;;^UTILITY(U,$J,358.3,25135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25135,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25135,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,25135,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,25136,0)
 ;;=T76.31XA^^95^1139^11
 ;;^UTILITY(U,$J,358.3,25136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25136,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,25136,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,25136,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,25137,0)
 ;;=T76.31XD^^95^1139^12
 ;;^UTILITY(U,$J,358.3,25137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25137,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25137,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,25137,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,25138,0)
 ;;=Z91.411^^95^1139^30
 ;;^UTILITY(U,$J,358.3,25138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25138,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25138,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,25138,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,25139,0)
 ;;=Z69.021^^95^1139^17
 ;;^UTILITY(U,$J,358.3,25139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25139,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,25139,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25139,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25140,0)
 ;;=Z69.021^^95^1139^18
 ;;^UTILITY(U,$J,358.3,25140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25140,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,25140,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25140,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25141,0)
 ;;=Z69.021^^95^1139^19
 ;;^UTILITY(U,$J,358.3,25141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25141,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25141,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25141,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25142,0)
 ;;=Z69.021^^95^1139^20
 ;;^UTILITY(U,$J,358.3,25142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25142,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,25142,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25142,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25143,0)
 ;;=Z69.011^^95^1139^22
 ;;^UTILITY(U,$J,358.3,25143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25143,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,25143,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25143,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25144,0)
 ;;=Z69.011^^95^1139^23
 ;;^UTILITY(U,$J,358.3,25144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25144,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,25144,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25144,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25145,0)
 ;;=Z69.011^^95^1139^24
 ;;^UTILITY(U,$J,358.3,25145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25145,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25145,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25145,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25146,0)
 ;;=Z69.011^^95^1139^25
 ;;^UTILITY(U,$J,358.3,25146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25146,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
