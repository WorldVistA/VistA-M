IBDEI1AK ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20656,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,20656,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,20657,0)
 ;;=Z69.11^^95^1020^31
 ;;^UTILITY(U,$J,358.3,20657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20657,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,20657,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,20657,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,20658,0)
 ;;=Z91.410^^95^1020^35
 ;;^UTILITY(U,$J,358.3,20658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20658,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,20658,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,20658,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,20659,0)
 ;;=Z69.12^^95^1020^27
 ;;^UTILITY(U,$J,358.3,20659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20659,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,20659,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,20659,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,20660,0)
 ;;=T74.21XA^^95^1020^13
 ;;^UTILITY(U,$J,358.3,20660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20660,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,20660,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,20660,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,20661,0)
 ;;=T74.21XD^^95^1020^14
 ;;^UTILITY(U,$J,358.3,20661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20661,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,20661,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,20661,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,20662,0)
 ;;=T76.21XA^^95^1020^15
 ;;^UTILITY(U,$J,358.3,20662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20662,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,20662,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,20662,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,20663,0)
 ;;=T76.21XD^^95^1020^16
 ;;^UTILITY(U,$J,358.3,20663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20663,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,20663,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,20663,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,20664,0)
 ;;=Z69.81^^95^1020^30
 ;;^UTILITY(U,$J,358.3,20664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20664,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,20664,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,20664,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,20665,0)
 ;;=Z69.82^^95^1020^22
 ;;^UTILITY(U,$J,358.3,20665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20665,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,20665,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,20665,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,20666,0)
 ;;=T74.01XA^^95^1020^1
 ;;^UTILITY(U,$J,358.3,20666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20666,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,20666,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,20666,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,20667,0)
 ;;=T74.01XD^^95^1020^2
 ;;^UTILITY(U,$J,358.3,20667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20667,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,20667,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,20667,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,20668,0)
 ;;=T76.01XA^^95^1020^3
