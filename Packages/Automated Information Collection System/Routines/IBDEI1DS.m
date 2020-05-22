IBDEI1DS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22071,1,3,0)
 ;;=3^Inadqute social skills, not elswhr classified
 ;;^UTILITY(U,$J,358.3,22071,1,4,0)
 ;;=4^Z73.4
 ;;^UTILITY(U,$J,358.3,22071,2)
 ;;=^5063272
 ;;^UTILITY(U,$J,358.3,22072,0)
 ;;=Z79.2^^99^1125^22
 ;;^UTILITY(U,$J,358.3,22072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22072,1,3,0)
 ;;=3^Long term (current) use of antibiotics
 ;;^UTILITY(U,$J,358.3,22072,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,22072,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,22073,0)
 ;;=Z79.01^^99^1125^23
 ;;^UTILITY(U,$J,358.3,22073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22073,1,3,0)
 ;;=3^Long term (current) use of anticoagulants
 ;;^UTILITY(U,$J,358.3,22073,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,22073,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,22074,0)
 ;;=Z79.02^^99^1125^24
 ;;^UTILITY(U,$J,358.3,22074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22074,1,3,0)
 ;;=3^Long term (current) use of antithrombtc/antipltlts
 ;;^UTILITY(U,$J,358.3,22074,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,22074,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,22075,0)
 ;;=Z79.82^^99^1125^25
 ;;^UTILITY(U,$J,358.3,22075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22075,1,3,0)
 ;;=3^Long term (current) use of aspirin
 ;;^UTILITY(U,$J,358.3,22075,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,22075,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,22076,0)
 ;;=Z79.899^^99^1125^21
 ;;^UTILITY(U,$J,358.3,22076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22076,1,3,0)
 ;;=3^Long term (current) drug therapy, oth
 ;;^UTILITY(U,$J,358.3,22076,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,22076,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,22077,0)
 ;;=Z79.51^^99^1125^26
 ;;^UTILITY(U,$J,358.3,22077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22077,1,3,0)
 ;;=3^Long term (current) use of inhaled steroids
 ;;^UTILITY(U,$J,358.3,22077,1,4,0)
 ;;=4^Z79.51
 ;;^UTILITY(U,$J,358.3,22077,2)
 ;;=^5063335
 ;;^UTILITY(U,$J,358.3,22078,0)
 ;;=Z79.4^^99^1125^27
 ;;^UTILITY(U,$J,358.3,22078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22078,1,3,0)
 ;;=3^Long term (current) use of insulin
 ;;^UTILITY(U,$J,358.3,22078,1,4,0)
 ;;=4^Z79.4
 ;;^UTILITY(U,$J,358.3,22078,2)
 ;;=^5063334
 ;;^UTILITY(U,$J,358.3,22079,0)
 ;;=Z79.1^^99^1125^28
 ;;^UTILITY(U,$J,358.3,22079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22079,1,3,0)
 ;;=3^Long term (current) use of non-stroidl non-inflam (NSAID)
 ;;^UTILITY(U,$J,358.3,22079,1,4,0)
 ;;=4^Z79.1
 ;;^UTILITY(U,$J,358.3,22079,2)
 ;;=^5063332
 ;;^UTILITY(U,$J,358.3,22080,0)
 ;;=Z79.891^^99^1125^29
 ;;^UTILITY(U,$J,358.3,22080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22080,1,3,0)
 ;;=3^Long term (current) use of opiate analgesic
 ;;^UTILITY(U,$J,358.3,22080,1,4,0)
 ;;=4^Z79.891
 ;;^UTILITY(U,$J,358.3,22080,2)
 ;;=^5063342
 ;;^UTILITY(U,$J,358.3,22081,0)
 ;;=Z79.52^^99^1125^31
 ;;^UTILITY(U,$J,358.3,22081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22081,1,3,0)
 ;;=3^Long term (current) use of systemic steroids
 ;;^UTILITY(U,$J,358.3,22081,1,4,0)
 ;;=4^Z79.52
 ;;^UTILITY(U,$J,358.3,22081,2)
 ;;=^5063336
 ;;^UTILITY(U,$J,358.3,22082,0)
 ;;=Z91.19^^99^1125^41
 ;;^UTILITY(U,$J,358.3,22082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22082,1,3,0)
 ;;=3^Pt's noncmplnc w oth med'l trmnt & regimen
 ;;^UTILITY(U,$J,358.3,22082,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,22082,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,22083,0)
 ;;=Z73.89^^99^1125^33
