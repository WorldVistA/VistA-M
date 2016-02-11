IBDEI1WL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31878,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,31878,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,31878,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,31879,0)
 ;;=Z69.11^^141^1474^4
 ;;^UTILITY(U,$J,358.3,31879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31879,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,31879,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,31879,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,31880,0)
 ;;=Z91.410^^141^1474^5
 ;;^UTILITY(U,$J,358.3,31880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31880,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,31880,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,31880,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,31881,0)
 ;;=Z69.12^^141^1474^2
 ;;^UTILITY(U,$J,358.3,31881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31881,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,31881,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,31881,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,31882,0)
 ;;=T74.21XA^^141^1474^12
 ;;^UTILITY(U,$J,358.3,31882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31882,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,31882,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,31882,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,31883,0)
 ;;=T74.21XD^^141^1474^13
 ;;^UTILITY(U,$J,358.3,31883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31883,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,31883,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,31883,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,31884,0)
 ;;=T76.21XA^^141^1474^14
 ;;^UTILITY(U,$J,358.3,31884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31884,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,31884,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,31884,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,31885,0)
 ;;=T76.21XD^^141^1474^15
 ;;^UTILITY(U,$J,358.3,31885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31885,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Susequent Encounter
 ;;^UTILITY(U,$J,358.3,31885,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,31885,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,31886,0)
 ;;=Z69.81^^141^1474^3
 ;;^UTILITY(U,$J,358.3,31886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31886,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,31886,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,31886,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,31887,0)
 ;;=Z69.82^^141^1474^1
 ;;^UTILITY(U,$J,358.3,31887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31887,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,31887,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,31887,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,31888,0)
 ;;=T74.01XA^^141^1474^16
 ;;^UTILITY(U,$J,358.3,31888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31888,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Initial Encnter
 ;;^UTILITY(U,$J,358.3,31888,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,31888,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,31889,0)
 ;;=T74.01XD^^141^1474^17
 ;;^UTILITY(U,$J,358.3,31889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31889,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Subsequent Encnter
