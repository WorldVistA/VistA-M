IBDEI15R ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18619,1,3,0)
 ;;=3^Problems Related to Other Legal Circumstances
 ;;^UTILITY(U,$J,358.3,18619,1,4,0)
 ;;=4^Z65.3
 ;;^UTILITY(U,$J,358.3,18619,2)
 ;;=^5063182
 ;;^UTILITY(U,$J,358.3,18620,0)
 ;;=Z65.1^^91^952^2
 ;;^UTILITY(U,$J,358.3,18620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18620,1,3,0)
 ;;=3^Imprisonment or Other Incarceration
 ;;^UTILITY(U,$J,358.3,18620,1,4,0)
 ;;=4^Z65.1
 ;;^UTILITY(U,$J,358.3,18620,2)
 ;;=^5063180
 ;;^UTILITY(U,$J,358.3,18621,0)
 ;;=Z64.0^^91^953^6
 ;;^UTILITY(U,$J,358.3,18621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18621,1,3,0)
 ;;=3^Problems Related to Unwanted Pregnancy
 ;;^UTILITY(U,$J,358.3,18621,1,4,0)
 ;;=4^Z64.0
 ;;^UTILITY(U,$J,358.3,18621,2)
 ;;=^5063176
 ;;^UTILITY(U,$J,358.3,18622,0)
 ;;=Z64.1^^91^953^3
 ;;^UTILITY(U,$J,358.3,18622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18622,1,3,0)
 ;;=3^Problems Related to Multiparity
 ;;^UTILITY(U,$J,358.3,18622,1,4,0)
 ;;=4^Z64.1
 ;;^UTILITY(U,$J,358.3,18622,2)
 ;;=^5063177
 ;;^UTILITY(U,$J,358.3,18623,0)
 ;;=Z64.4^^91^953^1
 ;;^UTILITY(U,$J,358.3,18623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18623,1,3,0)
 ;;=3^Discord w/ Counselors
 ;;^UTILITY(U,$J,358.3,18623,1,4,0)
 ;;=4^Z64.4
 ;;^UTILITY(U,$J,358.3,18623,2)
 ;;=^5063178
 ;;^UTILITY(U,$J,358.3,18624,0)
 ;;=Z65.5^^91^953^2
 ;;^UTILITY(U,$J,358.3,18624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18624,1,3,0)
 ;;=3^Exposure to Disaster,War or Other Hostilities
 ;;^UTILITY(U,$J,358.3,18624,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,18624,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,18625,0)
 ;;=Z65.8^^91^953^4
 ;;^UTILITY(U,$J,358.3,18625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18625,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Other
 ;;^UTILITY(U,$J,358.3,18625,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,18625,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,18626,0)
 ;;=Z65.9^^91^953^5
 ;;^UTILITY(U,$J,358.3,18626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18626,1,3,0)
 ;;=3^Problems Related to Psychosocial Circumstances,Unspec
 ;;^UTILITY(U,$J,358.3,18626,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,18626,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,18627,0)
 ;;=Z65.4^^91^953^7
 ;;^UTILITY(U,$J,358.3,18627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18627,1,3,0)
 ;;=3^Victim of Terrorism or Torture
 ;;^UTILITY(U,$J,358.3,18627,1,4,0)
 ;;=4^Z65.4
 ;;^UTILITY(U,$J,358.3,18627,2)
 ;;=^5063183
 ;;^UTILITY(U,$J,358.3,18628,0)
 ;;=Z62.820^^91^954^3
 ;;^UTILITY(U,$J,358.3,18628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18628,1,3,0)
 ;;=3^Parent-Child Relational Problem
 ;;^UTILITY(U,$J,358.3,18628,1,4,0)
 ;;=4^Z62.820
 ;;^UTILITY(U,$J,358.3,18628,2)
 ;;=^5063157
 ;;^UTILITY(U,$J,358.3,18629,0)
 ;;=Z62.891^^91^954^6
 ;;^UTILITY(U,$J,358.3,18629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18629,1,3,0)
 ;;=3^Sibling Relational Problem
 ;;^UTILITY(U,$J,358.3,18629,1,4,0)
 ;;=4^Z62.891
 ;;^UTILITY(U,$J,358.3,18629,2)
 ;;=^5063161
 ;;^UTILITY(U,$J,358.3,18630,0)
 ;;=Z62.898^^91^954^4
 ;;^UTILITY(U,$J,358.3,18630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18630,1,3,0)
 ;;=3^Problems Related to Upbringing,Oth Spec
 ;;^UTILITY(U,$J,358.3,18630,1,4,0)
 ;;=4^Z62.898
 ;;^UTILITY(U,$J,358.3,18630,2)
 ;;=^5063162
 ;;^UTILITY(U,$J,358.3,18631,0)
 ;;=Z63.0^^91^954^5
 ;;^UTILITY(U,$J,358.3,18631,1,0)
 ;;=^358.31IA^4^2
