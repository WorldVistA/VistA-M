IBDEI1KR ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25531,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,25531,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,25532,0)
 ;;=Z65.1^^92^1164^2
 ;;^UTILITY(U,$J,358.3,25532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25532,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,25532,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,25532,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,25533,0)
 ;;=Z64.0^^92^1165^6
 ;;^UTILITY(U,$J,358.3,25533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25533,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,25533,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,25533,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,25534,0)
 ;;=Z64.1^^92^1165^3
 ;;^UTILITY(U,$J,358.3,25534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25534,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,25534,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,25534,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,25535,0)
 ;;=Z64.4^^92^1165^1
 ;;^UTILITY(U,$J,358.3,25535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25535,1,3,0)
 ;;=3^Discord w/ Counselors
 ;;^UTILITY(U,$J,358.3,25535,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,25535,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,25536,0)
 ;;=Z65.5^^92^1165^2
 ;;^UTILITY(U,$J,358.3,25536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25536,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,25536,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,25536,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,25537,0)
 ;;=Z65.8^^92^1165^4
 ;;^UTILITY(U,$J,358.3,25537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25537,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,25537,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,25537,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,25538,0)
 ;;=Z65.9^^92^1165^5
 ;;^UTILITY(U,$J,358.3,25538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25538,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,25538,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,25538,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,25539,0)
 ;;=Z65.4^^92^1165^7
 ;;^UTILITY(U,$J,358.3,25539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25539,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,25539,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,25539,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,25540,0)
 ;;=Z62.820^^92^1166^3
 ;;^UTILITY(U,$J,358.3,25540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25540,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,25540,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,25540,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,25541,0)
 ;;=Z62.891^^92^1166^6
 ;;^UTILITY(U,$J,358.3,25541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25541,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,25541,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,25541,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,25542,0)
 ;;=Z62.898^^92^1166^4
 ;;^UTILITY(U,$J,358.3,25542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25542,1,3,0)
 ;;=3^Problems Related to Upbringing,Oth Spec
 ;;^UTILITY(U,$J,358.3,25542,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,25542,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,25543,0)
 ;;=Z63.0^^92^1166^5
 ;;^UTILITY(U,$J,358.3,25543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25543,1,3,0)
 ;;=3^Relationship Distress w/ Spouse/Partner
 ;;^UTILITY(U,$J,358.3,25543,1,4,0)
 ;;=4^Z63.0
