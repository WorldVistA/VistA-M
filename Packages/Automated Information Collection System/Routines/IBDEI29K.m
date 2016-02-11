IBDEI29K ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38022,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,38022,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,38022,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,38023,0)
 ;;=T76.21XA^^177^1914^14
 ;;^UTILITY(U,$J,358.3,38023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38023,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,38023,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,38023,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,38024,0)
 ;;=T76.21XD^^177^1914^15
 ;;^UTILITY(U,$J,358.3,38024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38024,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Susequent Encounter
 ;;^UTILITY(U,$J,358.3,38024,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,38024,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,38025,0)
 ;;=Z69.81^^177^1914^3
 ;;^UTILITY(U,$J,358.3,38025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38025,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,38025,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,38025,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,38026,0)
 ;;=Z69.82^^177^1914^1
 ;;^UTILITY(U,$J,358.3,38026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38026,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,38026,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,38026,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,38027,0)
 ;;=T74.01XA^^177^1914^16
 ;;^UTILITY(U,$J,358.3,38027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38027,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Initial Encnter
 ;;^UTILITY(U,$J,358.3,38027,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,38027,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,38028,0)
 ;;=T74.01XD^^177^1914^17
 ;;^UTILITY(U,$J,358.3,38028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38028,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,38028,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,38028,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,38029,0)
 ;;=T76.01XA^^177^1914^18
 ;;^UTILITY(U,$J,358.3,38029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38029,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Initial Encnter
 ;;^UTILITY(U,$J,358.3,38029,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,38029,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,38030,0)
 ;;=T76.01XD^^177^1914^19
 ;;^UTILITY(U,$J,358.3,38030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38030,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,38030,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,38030,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,38031,0)
 ;;=Z91.412^^177^1914^7
 ;;^UTILITY(U,$J,358.3,38031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38031,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,38031,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,38031,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,38032,0)
 ;;=T74.31XA^^177^1914^20
 ;;^UTILITY(U,$J,358.3,38032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38032,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Initial Encnter
 ;;^UTILITY(U,$J,358.3,38032,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,38032,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,38033,0)
 ;;=T74.31XD^^177^1914^21
 ;;^UTILITY(U,$J,358.3,38033,1,0)
 ;;=^358.31IA^4^2
