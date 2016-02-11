IBDEI01W ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,113,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,113,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,113,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,114,0)
 ;;=T74.21XD^^3^23^13
 ;;^UTILITY(U,$J,358.3,114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,114,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,114,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,114,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,115,0)
 ;;=T76.21XA^^3^23^14
 ;;^UTILITY(U,$J,358.3,115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,115,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,115,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,115,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,116,0)
 ;;=T76.21XD^^3^23^15
 ;;^UTILITY(U,$J,358.3,116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,116,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Susequent Encounter
 ;;^UTILITY(U,$J,358.3,116,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,116,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,117,0)
 ;;=Z69.81^^3^23^3
 ;;^UTILITY(U,$J,358.3,117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,117,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,117,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,117,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,118,0)
 ;;=Z69.82^^3^23^1
 ;;^UTILITY(U,$J,358.3,118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,118,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,118,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,118,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,119,0)
 ;;=T74.01XA^^3^23^16
 ;;^UTILITY(U,$J,358.3,119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,119,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Initial Encnter
 ;;^UTILITY(U,$J,358.3,119,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,119,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,120,0)
 ;;=T74.01XD^^3^23^17
 ;;^UTILITY(U,$J,358.3,120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,120,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,120,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,120,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,121,0)
 ;;=T76.01XA^^3^23^18
 ;;^UTILITY(U,$J,358.3,121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,121,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Initial Encnter
 ;;^UTILITY(U,$J,358.3,121,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,121,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,122,0)
 ;;=T76.01XD^^3^23^19
 ;;^UTILITY(U,$J,358.3,122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,122,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,122,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,122,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,123,0)
 ;;=Z91.412^^3^23^7
 ;;^UTILITY(U,$J,358.3,123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,123,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,123,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,123,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,124,0)
 ;;=T74.31XA^^3^23^20
 ;;^UTILITY(U,$J,358.3,124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,124,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Initial Encnter
 ;;^UTILITY(U,$J,358.3,124,1,4,0)
 ;;=4^T74.31XA
