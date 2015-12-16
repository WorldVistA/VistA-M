IBDEI07G ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2989,2)
 ;;=^5019542
 ;;^UTILITY(U,$J,358.3,2990,0)
 ;;=T74.11XA^^8^85^8
 ;;^UTILITY(U,$J,358.3,2990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2990,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,2990,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,2990,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,2991,0)
 ;;=T74.11XD^^8^85^9
 ;;^UTILITY(U,$J,358.3,2991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2991,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,2991,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,2991,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,2992,0)
 ;;=T76.11XA^^8^85^10
 ;;^UTILITY(U,$J,358.3,2992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2992,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,2992,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,2992,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,2993,0)
 ;;=T76.11XD^^8^85^11
 ;;^UTILITY(U,$J,358.3,2993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2993,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,2993,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,2993,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,2994,0)
 ;;=Z69.11^^8^85^4
 ;;^UTILITY(U,$J,358.3,2994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2994,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,2994,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,2994,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,2995,0)
 ;;=Z91.410^^8^85^5
 ;;^UTILITY(U,$J,358.3,2995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2995,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,2995,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,2995,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,2996,0)
 ;;=Z69.12^^8^85^2
 ;;^UTILITY(U,$J,358.3,2996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2996,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,2996,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,2996,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,2997,0)
 ;;=T74.21XA^^8^85^12
 ;;^UTILITY(U,$J,358.3,2997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2997,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,2997,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,2997,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,2998,0)
 ;;=T74.21XD^^8^85^13
 ;;^UTILITY(U,$J,358.3,2998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2998,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,2998,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,2998,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,2999,0)
 ;;=T76.21XA^^8^85^14
 ;;^UTILITY(U,$J,358.3,2999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2999,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,2999,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,2999,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,3000,0)
 ;;=T76.21XD^^8^85^15
 ;;^UTILITY(U,$J,358.3,3000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3000,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Susequent Encounter
 ;;^UTILITY(U,$J,358.3,3000,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,3000,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,3001,0)
 ;;=Z69.81^^8^85^3
