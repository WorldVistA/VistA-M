IBDEI07H ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3001,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,3001,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,3001,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,3002,0)
 ;;=Z69.82^^8^85^1
 ;;^UTILITY(U,$J,358.3,3002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3002,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,3002,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,3002,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,3003,0)
 ;;=T74.01XA^^8^85^16
 ;;^UTILITY(U,$J,358.3,3003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3003,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Initial Encnter
 ;;^UTILITY(U,$J,358.3,3003,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,3003,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,3004,0)
 ;;=T74.01XD^^8^85^17
 ;;^UTILITY(U,$J,358.3,3004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3004,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,3004,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,3004,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,3005,0)
 ;;=T76.01XA^^8^85^18
 ;;^UTILITY(U,$J,358.3,3005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3005,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Initial Encnter
 ;;^UTILITY(U,$J,358.3,3005,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,3005,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,3006,0)
 ;;=T76.01XD^^8^85^19
 ;;^UTILITY(U,$J,358.3,3006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3006,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,3006,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,3006,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,3007,0)
 ;;=Z91.412^^8^85^7
 ;;^UTILITY(U,$J,358.3,3007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3007,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,3007,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,3007,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,3008,0)
 ;;=T74.31XA^^8^85^20
 ;;^UTILITY(U,$J,358.3,3008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3008,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Initial Encnter
 ;;^UTILITY(U,$J,358.3,3008,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,3008,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,3009,0)
 ;;=T74.31XD^^8^85^21
 ;;^UTILITY(U,$J,358.3,3009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3009,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,3009,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,3009,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,3010,0)
 ;;=T76.31XA^^8^85^22
 ;;^UTILITY(U,$J,358.3,3010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3010,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Initial Encnter
 ;;^UTILITY(U,$J,358.3,3010,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,3010,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,3011,0)
 ;;=T76.31XD^^8^85^23
 ;;^UTILITY(U,$J,358.3,3011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3011,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,3011,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,3011,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,3012,0)
 ;;=Z91.411^^8^85^6
 ;;^UTILITY(U,$J,358.3,3012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3012,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
