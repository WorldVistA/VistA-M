IBDEI0WM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15309,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,15309,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,15310,0)
 ;;=T76.11XD^^58^658^8
 ;;^UTILITY(U,$J,358.3,15310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15310,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,15310,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,15310,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,15311,0)
 ;;=Z69.11^^58^658^28
 ;;^UTILITY(U,$J,358.3,15311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15311,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,15311,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,15311,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,15312,0)
 ;;=Z91.410^^58^658^29
 ;;^UTILITY(U,$J,358.3,15312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15312,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,15312,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,15312,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,15313,0)
 ;;=Z69.12^^58^658^26
 ;;^UTILITY(U,$J,358.3,15313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15313,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,15313,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,15313,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,15314,0)
 ;;=T74.21XA^^58^658^13
 ;;^UTILITY(U,$J,358.3,15314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15314,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,15314,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,15314,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,15315,0)
 ;;=T74.21XD^^58^658^14
 ;;^UTILITY(U,$J,358.3,15315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15315,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,15315,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,15315,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,15316,0)
 ;;=T76.21XA^^58^658^15
 ;;^UTILITY(U,$J,358.3,15316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15316,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,15316,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,15316,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,15317,0)
 ;;=T76.21XD^^58^658^16
 ;;^UTILITY(U,$J,358.3,15317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15317,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,15317,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,15317,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,15318,0)
 ;;=Z69.81^^58^658^27
 ;;^UTILITY(U,$J,358.3,15318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15318,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,15318,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,15318,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,15319,0)
 ;;=Z69.82^^58^658^21
 ;;^UTILITY(U,$J,358.3,15319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15319,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,15319,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,15319,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,15320,0)
 ;;=T74.01XA^^58^658^1
 ;;^UTILITY(U,$J,358.3,15320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15320,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,15320,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,15320,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,15321,0)
 ;;=T74.01XD^^58^658^2
 ;;^UTILITY(U,$J,358.3,15321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15321,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
