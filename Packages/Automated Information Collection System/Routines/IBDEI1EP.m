IBDEI1EP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23917,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,23917,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,23917,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,23918,0)
 ;;=T74.21XD^^90^1035^14
 ;;^UTILITY(U,$J,358.3,23918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23918,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,23918,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,23918,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,23919,0)
 ;;=T76.21XA^^90^1035^15
 ;;^UTILITY(U,$J,358.3,23919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23919,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,23919,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,23919,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,23920,0)
 ;;=T76.21XD^^90^1035^16
 ;;^UTILITY(U,$J,358.3,23920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23920,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,23920,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,23920,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,23921,0)
 ;;=Z69.81^^90^1035^27
 ;;^UTILITY(U,$J,358.3,23921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23921,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,23921,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,23921,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,23922,0)
 ;;=Z69.82^^90^1035^21
 ;;^UTILITY(U,$J,358.3,23922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23922,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,23922,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,23922,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,23923,0)
 ;;=T74.01XA^^90^1035^1
 ;;^UTILITY(U,$J,358.3,23923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23923,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,23923,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,23923,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,23924,0)
 ;;=T74.01XD^^90^1035^2
 ;;^UTILITY(U,$J,358.3,23924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23924,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,23924,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,23924,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,23925,0)
 ;;=T76.01XA^^90^1035^3
 ;;^UTILITY(U,$J,358.3,23925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23925,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,23925,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,23925,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,23926,0)
 ;;=T76.01XD^^90^1035^4
 ;;^UTILITY(U,$J,358.3,23926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23926,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,23926,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,23926,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,23927,0)
 ;;=Z91.412^^90^1035^31
 ;;^UTILITY(U,$J,358.3,23927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23927,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,23927,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,23927,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,23928,0)
 ;;=T74.31XA^^90^1035^9
 ;;^UTILITY(U,$J,358.3,23928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23928,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,23928,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,23928,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,23929,0)
 ;;=T74.31XD^^90^1035^10
