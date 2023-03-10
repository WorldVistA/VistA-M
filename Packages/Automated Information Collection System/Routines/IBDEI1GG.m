IBDEI1GG ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23534,0)
 ;;=F17.213^^78^1015^2
 ;;^UTILITY(U,$J,358.3,23534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23534,1,3,0)
 ;;=3^Nicotine Dependence w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,23534,1,4,0)
 ;;=4^F17.213
 ;;^UTILITY(U,$J,358.3,23534,2)
 ;;=^5003367
 ;;^UTILITY(U,$J,358.3,23535,0)
 ;;=F17.218^^78^1015^1
 ;;^UTILITY(U,$J,358.3,23535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23535,1,3,0)
 ;;=3^Nicotine Dependence w/ Oth Disorders
 ;;^UTILITY(U,$J,358.3,23535,1,4,0)
 ;;=4^F17.218
 ;;^UTILITY(U,$J,358.3,23535,2)
 ;;=^5003368
 ;;^UTILITY(U,$J,358.3,23536,0)
 ;;=F17.220^^78^1015^6
 ;;^UTILITY(U,$J,358.3,23536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23536,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,Uncomp
 ;;^UTILITY(U,$J,358.3,23536,1,4,0)
 ;;=4^F17.220
 ;;^UTILITY(U,$J,358.3,23536,2)
 ;;=^5003370
 ;;^UTILITY(U,$J,358.3,23537,0)
 ;;=F17.221^^78^1015^5
 ;;^UTILITY(U,$J,358.3,23537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23537,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco,In Remission
 ;;^UTILITY(U,$J,358.3,23537,1,4,0)
 ;;=4^F17.221
 ;;^UTILITY(U,$J,358.3,23537,2)
 ;;=^5003371
 ;;^UTILITY(U,$J,358.3,23538,0)
 ;;=F17.223^^78^1015^3
 ;;^UTILITY(U,$J,358.3,23538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23538,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,23538,1,4,0)
 ;;=4^F17.223
 ;;^UTILITY(U,$J,358.3,23538,2)
 ;;=^5003372
 ;;^UTILITY(U,$J,358.3,23539,0)
 ;;=F17.228^^78^1015^4
 ;;^UTILITY(U,$J,358.3,23539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23539,1,3,0)
 ;;=3^Nicotine Dependence,Chewing Tobacco w/ Oth Disorders
 ;;^UTILITY(U,$J,358.3,23539,1,4,0)
 ;;=4^F17.228
 ;;^UTILITY(U,$J,358.3,23539,2)
 ;;=^5003373
 ;;^UTILITY(U,$J,358.3,23540,0)
 ;;=Z51.81^^78^1016^19
 ;;^UTILITY(U,$J,358.3,23540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23540,1,3,0)
 ;;=3^Therapeutic Drug Monitoring
 ;;^UTILITY(U,$J,358.3,23540,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,23540,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,23541,0)
 ;;=Z79.01^^78^1016^6
 ;;^UTILITY(U,$J,358.3,23541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23541,1,3,0)
 ;;=3^Long Term Current Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,23541,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,23541,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,23542,0)
 ;;=Z79.02^^78^1016^7
 ;;^UTILITY(U,$J,358.3,23542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23542,1,3,0)
 ;;=3^Long Term Current Use of Antithrombotics/Antiplatelets
 ;;^UTILITY(U,$J,358.3,23542,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,23542,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,23543,0)
 ;;=Z79.1^^78^1016^10
 ;;^UTILITY(U,$J,358.3,23543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23543,1,3,0)
 ;;=3^Long Term Current Use of NSAIDs
 ;;^UTILITY(U,$J,358.3,23543,1,4,0)
 ;;=4^Z79.1
 ;;^UTILITY(U,$J,358.3,23543,2)
 ;;=^5063332
 ;;^UTILITY(U,$J,358.3,23544,0)
 ;;=Z79.2^^78^1016^5
 ;;^UTILITY(U,$J,358.3,23544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23544,1,3,0)
 ;;=3^Long Term Current Use of Antibiotics
 ;;^UTILITY(U,$J,358.3,23544,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,23544,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,23545,0)
 ;;=Z79.82^^78^1016^8
 ;;^UTILITY(U,$J,358.3,23545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23545,1,3,0)
 ;;=3^Long Term Current Use of Aspirin
 ;;^UTILITY(U,$J,358.3,23545,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,23545,2)
 ;;=^5063340
