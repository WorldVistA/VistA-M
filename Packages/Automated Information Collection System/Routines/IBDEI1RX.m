IBDEI1RX ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31707,0)
 ;;=C92.10^^190^1943^45
 ;;^UTILITY(U,$J,358.3,31707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31707,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,31707,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,31707,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,31708,0)
 ;;=D47.1^^190^1943^46
 ;;^UTILITY(U,$J,358.3,31708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31708,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,31708,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,31708,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,31709,0)
 ;;=C82.69^^190^1943^47
 ;;^UTILITY(U,$J,358.3,31709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31709,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,31709,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,31709,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,31710,0)
 ;;=C82.60^^190^1943^48
 ;;^UTILITY(U,$J,358.3,31710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31710,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,31710,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,31710,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,31711,0)
 ;;=D56.2^^190^1943^49
 ;;^UTILITY(U,$J,358.3,31711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31711,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,31711,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,31711,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,31712,0)
 ;;=D75.9^^190^1943^50
 ;;^UTILITY(U,$J,358.3,31712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31712,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,31712,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,31712,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,31713,0)
 ;;=D59.0^^190^1943^53
 ;;^UTILITY(U,$J,358.3,31713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31713,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,31713,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,31713,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,31714,0)
 ;;=D59.2^^190^1943^54
 ;;^UTILITY(U,$J,358.3,31714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31714,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,31714,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,31714,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,31715,0)
 ;;=R59.9^^190^1943^57
 ;;^UTILITY(U,$J,358.3,31715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31715,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,31715,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,31715,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,31716,0)
 ;;=D47.3^^190^1943^58
 ;;^UTILITY(U,$J,358.3,31716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31716,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,31716,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,31716,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,31717,0)
 ;;=C82.09^^190^1943^59
 ;;^UTILITY(U,$J,358.3,31717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31717,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,31717,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,31717,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,31718,0)
 ;;=C82.00^^190^1943^60
 ;;^UTILITY(U,$J,358.3,31718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31718,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,31718,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,31718,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,31719,0)
 ;;=C82.19^^190^1943^61
 ;;^UTILITY(U,$J,358.3,31719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31719,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
