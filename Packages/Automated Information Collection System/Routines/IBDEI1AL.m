IBDEI1AL ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20668,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,20668,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,20668,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,20669,0)
 ;;=T76.01XD^^95^1020^4
 ;;^UTILITY(U,$J,358.3,20669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20669,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,20669,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,20669,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,20670,0)
 ;;=Z91.412^^95^1020^40
 ;;^UTILITY(U,$J,358.3,20670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20670,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,20670,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,20670,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,20671,0)
 ;;=T74.31XA^^95^1020^9
 ;;^UTILITY(U,$J,358.3,20671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20671,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,20671,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,20671,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,20672,0)
 ;;=T74.31XD^^95^1020^10
 ;;^UTILITY(U,$J,358.3,20672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20672,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,20672,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,20672,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,20673,0)
 ;;=T76.31XA^^95^1020^11
 ;;^UTILITY(U,$J,358.3,20673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20673,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,20673,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,20673,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,20674,0)
 ;;=T76.31XD^^95^1020^12
 ;;^UTILITY(U,$J,358.3,20674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20674,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,20674,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,20674,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,20675,0)
 ;;=Z91.411^^95^1020^41
 ;;^UTILITY(U,$J,358.3,20675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20675,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,20675,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,20675,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,20676,0)
 ;;=Z69.021^^95^1020^18
 ;;^UTILITY(U,$J,358.3,20676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20676,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,20676,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,20676,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,20677,0)
 ;;=Z69.021^^95^1020^19
 ;;^UTILITY(U,$J,358.3,20677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20677,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,20677,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,20677,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,20678,0)
 ;;=Z69.021^^95^1020^20
 ;;^UTILITY(U,$J,358.3,20678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20678,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,20678,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,20678,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,20679,0)
 ;;=Z69.021^^95^1020^21
 ;;^UTILITY(U,$J,358.3,20679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20679,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
