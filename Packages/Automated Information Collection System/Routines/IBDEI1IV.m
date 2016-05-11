IBDEI1IV ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25840,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25840,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,25840,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,25841,0)
 ;;=T76.21XA^^98^1209^15
 ;;^UTILITY(U,$J,358.3,25841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25841,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,25841,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,25841,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,25842,0)
 ;;=T76.21XD^^98^1209^16
 ;;^UTILITY(U,$J,358.3,25842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25842,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,25842,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,25842,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,25843,0)
 ;;=Z69.81^^98^1209^27
 ;;^UTILITY(U,$J,358.3,25843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25843,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,25843,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,25843,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,25844,0)
 ;;=Z69.82^^98^1209^21
 ;;^UTILITY(U,$J,358.3,25844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25844,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,25844,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,25844,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,25845,0)
 ;;=T74.01XA^^98^1209^1
 ;;^UTILITY(U,$J,358.3,25845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25845,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,25845,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,25845,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,25846,0)
 ;;=T74.01XD^^98^1209^2
 ;;^UTILITY(U,$J,358.3,25846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25846,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25846,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,25846,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,25847,0)
 ;;=T76.01XA^^98^1209^3
 ;;^UTILITY(U,$J,358.3,25847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25847,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,25847,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,25847,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,25848,0)
 ;;=T76.01XD^^98^1209^4
 ;;^UTILITY(U,$J,358.3,25848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25848,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,25848,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,25848,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,25849,0)
 ;;=Z91.412^^98^1209^31
 ;;^UTILITY(U,$J,358.3,25849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25849,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,25849,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,25849,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,25850,0)
 ;;=T74.31XA^^98^1209^9
 ;;^UTILITY(U,$J,358.3,25850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25850,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,25850,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,25850,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,25851,0)
 ;;=T74.31XD^^98^1209^10
 ;;^UTILITY(U,$J,358.3,25851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25851,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25851,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,25851,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,25852,0)
 ;;=T76.31XA^^98^1209^11
 ;;^UTILITY(U,$J,358.3,25852,1,0)
 ;;=^358.31IA^4^2
