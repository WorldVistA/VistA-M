IBDEI1S6 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28444,1,4,0)
 ;;=4^Z65.0
 ;;^UTILITY(U,$J,358.3,28444,2)
 ;;=^5063179
 ;;^UTILITY(U,$J,358.3,28445,0)
 ;;=Z65.2^^115^1400^4
 ;;^UTILITY(U,$J,358.3,28445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28445,1,3,0)
 ;;=3^Problems Related to Release from Prison
 ;;^UTILITY(U,$J,358.3,28445,1,4,0)
 ;;=4^Z65.2
 ;;^UTILITY(U,$J,358.3,28445,2)
 ;;=^5063181
 ;;^UTILITY(U,$J,358.3,28446,0)
 ;;=Z65.3^^115^1400^3
 ;;^UTILITY(U,$J,358.3,28446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28446,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,28446,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,28446,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,28447,0)
 ;;=Z65.1^^115^1400^2
 ;;^UTILITY(U,$J,358.3,28447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28447,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,28447,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,28447,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,28448,0)
 ;;=Z64.0^^115^1401^6
 ;;^UTILITY(U,$J,358.3,28448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28448,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,28448,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,28448,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,28449,0)
 ;;=Z64.1^^115^1401^3
 ;;^UTILITY(U,$J,358.3,28449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28449,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,28449,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,28449,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,28450,0)
 ;;=Z64.4^^115^1401^1
 ;;^UTILITY(U,$J,358.3,28450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28450,1,3,0)
 ;;=3^Discord w/ Counselors
 ;;^UTILITY(U,$J,358.3,28450,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,28450,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,28451,0)
 ;;=Z65.5^^115^1401^2
 ;;^UTILITY(U,$J,358.3,28451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28451,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,28451,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,28451,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,28452,0)
 ;;=Z65.8^^115^1401^4
 ;;^UTILITY(U,$J,358.3,28452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28452,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,28452,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,28452,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,28453,0)
 ;;=Z65.9^^115^1401^5
 ;;^UTILITY(U,$J,358.3,28453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28453,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,28453,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,28453,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,28454,0)
 ;;=Z65.4^^115^1401^7
 ;;^UTILITY(U,$J,358.3,28454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28454,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,28454,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,28454,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,28455,0)
 ;;=Z62.820^^115^1402^3
 ;;^UTILITY(U,$J,358.3,28455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28455,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,28455,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,28455,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,28456,0)
 ;;=Z62.891^^115^1402^6
 ;;^UTILITY(U,$J,358.3,28456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28456,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,28456,1,4,0)
 ;;=4^Z62.891
