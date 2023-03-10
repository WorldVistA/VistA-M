IBDEI0NB ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10501,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,10501,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,10502,0)
 ;;=Z69.81^^42^469^30
 ;;^UTILITY(U,$J,358.3,10502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10502,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,10502,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,10502,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,10503,0)
 ;;=Z69.82^^42^469^22
 ;;^UTILITY(U,$J,358.3,10503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10503,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,10503,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,10503,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,10504,0)
 ;;=T74.01XA^^42^469^1
 ;;^UTILITY(U,$J,358.3,10504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10504,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,10504,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,10504,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,10505,0)
 ;;=T74.01XD^^42^469^2
 ;;^UTILITY(U,$J,358.3,10505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10505,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,10505,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,10505,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,10506,0)
 ;;=T76.01XA^^42^469^3
 ;;^UTILITY(U,$J,358.3,10506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10506,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,10506,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,10506,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,10507,0)
 ;;=T76.01XD^^42^469^4
 ;;^UTILITY(U,$J,358.3,10507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10507,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,10507,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,10507,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,10508,0)
 ;;=Z91.412^^42^469^40
 ;;^UTILITY(U,$J,358.3,10508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10508,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,10508,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,10508,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,10509,0)
 ;;=T74.31XA^^42^469^9
 ;;^UTILITY(U,$J,358.3,10509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10509,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,10509,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,10509,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,10510,0)
 ;;=T74.31XD^^42^469^10
 ;;^UTILITY(U,$J,358.3,10510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10510,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,10510,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,10510,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,10511,0)
 ;;=T76.31XA^^42^469^11
 ;;^UTILITY(U,$J,358.3,10511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10511,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,10511,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,10511,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,10512,0)
 ;;=T76.31XD^^42^469^12
 ;;^UTILITY(U,$J,358.3,10512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10512,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,10512,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,10512,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,10513,0)
 ;;=Z91.411^^42^469^41
