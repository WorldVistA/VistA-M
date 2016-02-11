IBDEI1YI ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32771,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,32771,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,32771,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,32772,0)
 ;;=T76.11XA^^146^1581^10
 ;;^UTILITY(U,$J,358.3,32772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32772,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,32772,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,32772,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,32773,0)
 ;;=T76.11XD^^146^1581^11
 ;;^UTILITY(U,$J,358.3,32773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32773,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,32773,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,32773,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,32774,0)
 ;;=Z69.11^^146^1581^4
 ;;^UTILITY(U,$J,358.3,32774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32774,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,32774,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,32774,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,32775,0)
 ;;=Z91.410^^146^1581^5
 ;;^UTILITY(U,$J,358.3,32775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32775,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,32775,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,32775,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,32776,0)
 ;;=Z69.12^^146^1581^2
 ;;^UTILITY(U,$J,358.3,32776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32776,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,32776,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,32776,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,32777,0)
 ;;=T74.21XA^^146^1581^12
 ;;^UTILITY(U,$J,358.3,32777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32777,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,32777,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,32777,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,32778,0)
 ;;=T74.21XD^^146^1581^13
 ;;^UTILITY(U,$J,358.3,32778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32778,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,32778,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,32778,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,32779,0)
 ;;=T76.21XA^^146^1581^14
 ;;^UTILITY(U,$J,358.3,32779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32779,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,32779,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,32779,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,32780,0)
 ;;=T76.21XD^^146^1581^15
 ;;^UTILITY(U,$J,358.3,32780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32780,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Susequent Encounter
 ;;^UTILITY(U,$J,358.3,32780,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,32780,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,32781,0)
 ;;=Z69.81^^146^1581^3
 ;;^UTILITY(U,$J,358.3,32781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32781,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,32781,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,32781,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,32782,0)
 ;;=Z69.82^^146^1581^1
