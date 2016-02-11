IBDEI1VO ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31454,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,31454,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,31455,0)
 ;;=T76.21XA^^138^1425^14
 ;;^UTILITY(U,$J,358.3,31455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31455,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,31455,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,31455,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,31456,0)
 ;;=T76.21XD^^138^1425^15
 ;;^UTILITY(U,$J,358.3,31456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31456,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Susequent Encounter
 ;;^UTILITY(U,$J,358.3,31456,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,31456,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,31457,0)
 ;;=Z69.81^^138^1425^3
 ;;^UTILITY(U,$J,358.3,31457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31457,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,31457,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,31457,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,31458,0)
 ;;=Z69.82^^138^1425^1
 ;;^UTILITY(U,$J,358.3,31458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31458,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,31458,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,31458,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,31459,0)
 ;;=T74.01XA^^138^1425^16
 ;;^UTILITY(U,$J,358.3,31459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31459,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Initial Encnter
 ;;^UTILITY(U,$J,358.3,31459,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,31459,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,31460,0)
 ;;=T74.01XD^^138^1425^17
 ;;^UTILITY(U,$J,358.3,31460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31460,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,31460,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,31460,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,31461,0)
 ;;=T76.01XA^^138^1425^18
 ;;^UTILITY(U,$J,358.3,31461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31461,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Initial Encnter
 ;;^UTILITY(U,$J,358.3,31461,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,31461,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,31462,0)
 ;;=T76.01XD^^138^1425^19
 ;;^UTILITY(U,$J,358.3,31462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31462,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,31462,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,31462,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,31463,0)
 ;;=Z91.412^^138^1425^7
 ;;^UTILITY(U,$J,358.3,31463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31463,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,31463,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,31463,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,31464,0)
 ;;=T74.31XA^^138^1425^20
 ;;^UTILITY(U,$J,358.3,31464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31464,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Initial Encnter
 ;;^UTILITY(U,$J,358.3,31464,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,31464,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,31465,0)
 ;;=T74.31XD^^138^1425^21
 ;;^UTILITY(U,$J,358.3,31465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31465,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,31465,1,4,0)
 ;;=4^T74.31XD
