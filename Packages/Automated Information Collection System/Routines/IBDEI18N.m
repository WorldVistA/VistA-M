IBDEI18N ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20710,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,20711,0)
 ;;=Z69.12^^99^981^2
 ;;^UTILITY(U,$J,358.3,20711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20711,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Abuse-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,20711,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,20711,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,20712,0)
 ;;=T74.21XA^^99^981^12
 ;;^UTILITY(U,$J,358.3,20712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20712,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Initial Encounter
 ;;^UTILITY(U,$J,358.3,20712,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,20712,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,20713,0)
 ;;=T74.21XD^^99^981^13
 ;;^UTILITY(U,$J,358.3,20713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20713,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Confirmed,Subsequent Encounter
 ;;^UTILITY(U,$J,358.3,20713,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,20713,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,20714,0)
 ;;=T76.21XA^^99^981^14
 ;;^UTILITY(U,$J,358.3,20714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20714,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Initial Encounter
 ;;^UTILITY(U,$J,358.3,20714,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,20714,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,20715,0)
 ;;=T76.21XD^^99^981^15
 ;;^UTILITY(U,$J,358.3,20715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20715,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Violence,Sexual Suspected,Susequent Encounter
 ;;^UTILITY(U,$J,358.3,20715,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,20715,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,20716,0)
 ;;=Z69.81^^99^981^3
 ;;^UTILITY(U,$J,358.3,20716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20716,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,20716,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,20716,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,20717,0)
 ;;=Z69.82^^99^981^1
 ;;^UTILITY(U,$J,358.3,20717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20717,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse,Physical or Sexual
 ;;^UTILITY(U,$J,358.3,20717,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,20717,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,20718,0)
 ;;=T74.01XA^^99^981^16
 ;;^UTILITY(U,$J,358.3,20718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20718,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Initial Encnter
 ;;^UTILITY(U,$J,358.3,20718,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,20718,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,20719,0)
 ;;=T74.01XD^^99^981^17
 ;;^UTILITY(U,$J,358.3,20719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20719,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Confirmed,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,20719,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,20719,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,20720,0)
 ;;=T76.01XA^^99^981^18
 ;;^UTILITY(U,$J,358.3,20720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20720,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Initial Encnter
 ;;^UTILITY(U,$J,358.3,20720,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,20720,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,20721,0)
 ;;=T76.01XD^^99^981^19
 ;;^UTILITY(U,$J,358.3,20721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20721,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Neglect Suspected,Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,20721,1,4,0)
 ;;=4^T76.01XD
