IBDEI1XG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32271,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,32271,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,32271,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,32272,0)
 ;;=T76.11XD^^143^1517^11
 ;;^UTILITY(U,$J,358.3,32272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32272,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Physical,Suspected,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,32272,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,32272,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,32273,0)
 ;;=Z69.11^^143^1517^4
 ;;^UTILITY(U,$J,358.3,32273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32273,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Abuse/Neglect
 ;;^UTILITY(U,$J,358.3,32273,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,32273,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,32274,0)
 ;;=Z91.410^^143^1517^5
 ;;^UTILITY(U,$J,358.3,32274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32274,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,32274,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,32274,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,32275,0)
 ;;=Z69.12^^143^1517^2
 ;;^UTILITY(U,$J,358.3,32275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32275,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,32275,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,32275,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,32276,0)
 ;;=T74.21XA^^143^1517^12
 ;;^UTILITY(U,$J,358.3,32276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32276,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,32276,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,32276,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,32277,0)
 ;;=T74.21XD^^143^1517^13
 ;;^UTILITY(U,$J,358.3,32277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32277,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,32277,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,32277,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,32278,0)
 ;;=T76.21XA^^143^1517^14
 ;;^UTILITY(U,$J,358.3,32278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32278,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,32278,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,32278,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,32279,0)
 ;;=T76.21XD^^143^1517^15
 ;;^UTILITY(U,$J,358.3,32279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32279,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Susequent Encounter
 ;;^UTILITY(U,$J,358.3,32279,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,32279,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,32280,0)
 ;;=Z69.81^^143^1517^3
 ;;^UTILITY(U,$J,358.3,32280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32280,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,32280,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,32280,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,32281,0)
 ;;=Z69.82^^143^1517^1
 ;;^UTILITY(U,$J,358.3,32281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32281,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,32281,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,32281,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,32282,0)
 ;;=T74.01XA^^143^1517^16
 ;;^UTILITY(U,$J,358.3,32282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32282,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Initial Encnter
