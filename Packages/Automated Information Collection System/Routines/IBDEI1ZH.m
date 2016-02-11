IBDEI1ZH ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33221,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,33221,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,33221,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,33222,0)
 ;;=Z69.11^^148^1631^4
 ;;^UTILITY(U,$J,358.3,33222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33222,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,33222,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,33222,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,33223,0)
 ;;=Z91.410^^148^1631^5
 ;;^UTILITY(U,$J,358.3,33223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33223,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,33223,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,33223,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,33224,0)
 ;;=Z69.12^^148^1631^2
 ;;^UTILITY(U,$J,358.3,33224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33224,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,33224,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,33224,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,33225,0)
 ;;=T74.21XA^^148^1631^12
 ;;^UTILITY(U,$J,358.3,33225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33225,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,33225,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,33225,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,33226,0)
 ;;=T74.21XD^^148^1631^13
 ;;^UTILITY(U,$J,358.3,33226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33226,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,33226,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,33226,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,33227,0)
 ;;=T76.21XA^^148^1631^14
 ;;^UTILITY(U,$J,358.3,33227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33227,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,33227,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,33227,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,33228,0)
 ;;=T76.21XD^^148^1631^15
 ;;^UTILITY(U,$J,358.3,33228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33228,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Susequent Encounter
 ;;^UTILITY(U,$J,358.3,33228,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,33228,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,33229,0)
 ;;=Z69.81^^148^1631^3
 ;;^UTILITY(U,$J,358.3,33229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33229,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,33229,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,33229,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,33230,0)
 ;;=Z69.82^^148^1631^1
 ;;^UTILITY(U,$J,358.3,33230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33230,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,33230,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,33230,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,33231,0)
 ;;=T74.01XA^^148^1631^16
 ;;^UTILITY(U,$J,358.3,33231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33231,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Initial Encnter
 ;;^UTILITY(U,$J,358.3,33231,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,33231,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,33232,0)
 ;;=T74.01XD^^148^1631^17
 ;;^UTILITY(U,$J,358.3,33232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33232,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Subsequent Encnter
