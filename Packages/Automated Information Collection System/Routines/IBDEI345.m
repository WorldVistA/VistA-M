IBDEI345 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52259,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,52259,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,52260,0)
 ;;=Z91.410^^237^2588^5
 ;;^UTILITY(U,$J,358.3,52260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52260,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,52260,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,52260,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,52261,0)
 ;;=Z69.12^^237^2588^2
 ;;^UTILITY(U,$J,358.3,52261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52261,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,52261,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,52261,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,52262,0)
 ;;=T74.21XA^^237^2588^12
 ;;^UTILITY(U,$J,358.3,52262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52262,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,52262,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,52262,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,52263,0)
 ;;=T74.21XD^^237^2588^13
 ;;^UTILITY(U,$J,358.3,52263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52263,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,52263,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,52263,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,52264,0)
 ;;=T76.21XA^^237^2588^14
 ;;^UTILITY(U,$J,358.3,52264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52264,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,52264,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,52264,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,52265,0)
 ;;=T76.21XD^^237^2588^15
 ;;^UTILITY(U,$J,358.3,52265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52265,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Susequent Encounter
 ;;^UTILITY(U,$J,358.3,52265,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,52265,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,52266,0)
 ;;=Z69.81^^237^2588^3
 ;;^UTILITY(U,$J,358.3,52266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52266,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,52266,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,52266,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,52267,0)
 ;;=Z69.82^^237^2588^1
 ;;^UTILITY(U,$J,358.3,52267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52267,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,52267,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,52267,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,52268,0)
 ;;=T74.01XA^^237^2588^16
 ;;^UTILITY(U,$J,358.3,52268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52268,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Initial Encnter
 ;;^UTILITY(U,$J,358.3,52268,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,52268,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,52269,0)
 ;;=T74.01XD^^237^2588^17
 ;;^UTILITY(U,$J,358.3,52269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52269,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,52269,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,52269,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,52270,0)
 ;;=T76.01XA^^237^2588^18
 ;;^UTILITY(U,$J,358.3,52270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52270,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Initial Encnter
 ;;^UTILITY(U,$J,358.3,52270,1,4,0)
 ;;=4^T76.01XA
