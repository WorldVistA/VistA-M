IBDEI1F7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23711,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,23711,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,23712,0)
 ;;=Z79.02^^113^1147^24
 ;;^UTILITY(U,$J,358.3,23712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23712,1,3,0)
 ;;=3^Long term (current) use of antithrombtc/antipltlts
 ;;^UTILITY(U,$J,358.3,23712,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,23712,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,23713,0)
 ;;=Z79.82^^113^1147^25
 ;;^UTILITY(U,$J,358.3,23713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23713,1,3,0)
 ;;=3^Long term (current) use of aspirin
 ;;^UTILITY(U,$J,358.3,23713,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,23713,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,23714,0)
 ;;=Z79.899^^113^1147^21
 ;;^UTILITY(U,$J,358.3,23714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23714,1,3,0)
 ;;=3^Long term (current) drug therapy, oth
 ;;^UTILITY(U,$J,358.3,23714,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,23714,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,23715,0)
 ;;=Z79.51^^113^1147^26
 ;;^UTILITY(U,$J,358.3,23715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23715,1,3,0)
 ;;=3^Long term (current) use of inhaled steroids
 ;;^UTILITY(U,$J,358.3,23715,1,4,0)
 ;;=4^Z79.51
 ;;^UTILITY(U,$J,358.3,23715,2)
 ;;=^5063335
 ;;^UTILITY(U,$J,358.3,23716,0)
 ;;=Z79.4^^113^1147^27
 ;;^UTILITY(U,$J,358.3,23716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23716,1,3,0)
 ;;=3^Long term (current) use of insulin
 ;;^UTILITY(U,$J,358.3,23716,1,4,0)
 ;;=4^Z79.4
 ;;^UTILITY(U,$J,358.3,23716,2)
 ;;=^5063334
 ;;^UTILITY(U,$J,358.3,23717,0)
 ;;=Z79.1^^113^1147^28
 ;;^UTILITY(U,$J,358.3,23717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23717,1,3,0)
 ;;=3^Long term (current) use of non-stroidl non-inflam (NSAID)
 ;;^UTILITY(U,$J,358.3,23717,1,4,0)
 ;;=4^Z79.1
 ;;^UTILITY(U,$J,358.3,23717,2)
 ;;=^5063332
 ;;^UTILITY(U,$J,358.3,23718,0)
 ;;=Z79.891^^113^1147^29
 ;;^UTILITY(U,$J,358.3,23718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23718,1,3,0)
 ;;=3^Long term (current) use of opiate analgesic
 ;;^UTILITY(U,$J,358.3,23718,1,4,0)
 ;;=4^Z79.891
 ;;^UTILITY(U,$J,358.3,23718,2)
 ;;=^5063342
 ;;^UTILITY(U,$J,358.3,23719,0)
 ;;=Z79.52^^113^1147^30
 ;;^UTILITY(U,$J,358.3,23719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23719,1,3,0)
 ;;=3^Long term (current) use of systemic steroids
 ;;^UTILITY(U,$J,358.3,23719,1,4,0)
 ;;=4^Z79.52
 ;;^UTILITY(U,$J,358.3,23719,2)
 ;;=^5063336
 ;;^UTILITY(U,$J,358.3,23720,0)
 ;;=Z91.19^^113^1147^40
 ;;^UTILITY(U,$J,358.3,23720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23720,1,3,0)
 ;;=3^Pt's noncmplnc w oth med'l trmnt & regimen
 ;;^UTILITY(U,$J,358.3,23720,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,23720,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,23721,0)
 ;;=Z73.89^^113^1147^32
 ;;^UTILITY(U,$J,358.3,23721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23721,1,3,0)
 ;;=3^Prblms related to life mngmt difficulty, oth
 ;;^UTILITY(U,$J,358.3,23721,1,4,0)
 ;;=4^Z73.89
 ;;^UTILITY(U,$J,358.3,23721,2)
 ;;=^5063280
 ;;^UTILITY(U,$J,358.3,23722,0)
 ;;=Z55.9^^113^1147^31
 ;;^UTILITY(U,$J,358.3,23722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23722,1,3,0)
 ;;=3^Prblms related to educ & literacy, unspec
 ;;^UTILITY(U,$J,358.3,23722,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,23722,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,23723,0)
 ;;=Z63.8^^113^1147^33
 ;;^UTILITY(U,$J,358.3,23723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23723,1,3,0)
 ;;=3^Prblms related to prim support grp, oth, unspec
 ;;^UTILITY(U,$J,358.3,23723,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,23723,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,23724,0)
 ;;=Z63.9^^113^1147^34
