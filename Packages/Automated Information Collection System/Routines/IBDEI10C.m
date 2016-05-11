IBDEI10C ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17090,1,4,0)
 ;;=4^Z73.4
 ;;^UTILITY(U,$J,358.3,17090,2)
 ;;=^5063272
 ;;^UTILITY(U,$J,358.3,17091,0)
 ;;=Z79.2^^70^809^22
 ;;^UTILITY(U,$J,358.3,17091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17091,1,3,0)
 ;;=3^Long term (current) use of antibiotics
 ;;^UTILITY(U,$J,358.3,17091,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,17091,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,17092,0)
 ;;=Z79.01^^70^809^23
 ;;^UTILITY(U,$J,358.3,17092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17092,1,3,0)
 ;;=3^Long term (current) use of anticoagulants
 ;;^UTILITY(U,$J,358.3,17092,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,17092,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,17093,0)
 ;;=Z79.02^^70^809^24
 ;;^UTILITY(U,$J,358.3,17093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17093,1,3,0)
 ;;=3^Long term (current) use of antithrombtc/antipltlts
 ;;^UTILITY(U,$J,358.3,17093,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,17093,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,17094,0)
 ;;=Z79.82^^70^809^25
 ;;^UTILITY(U,$J,358.3,17094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17094,1,3,0)
 ;;=3^Long term (current) use of aspirin
 ;;^UTILITY(U,$J,358.3,17094,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,17094,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,17095,0)
 ;;=Z79.899^^70^809^21
 ;;^UTILITY(U,$J,358.3,17095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17095,1,3,0)
 ;;=3^Long term (current) drug therapy, oth
 ;;^UTILITY(U,$J,358.3,17095,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,17095,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,17096,0)
 ;;=Z79.51^^70^809^26
 ;;^UTILITY(U,$J,358.3,17096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17096,1,3,0)
 ;;=3^Long term (current) use of inhaled steroids
 ;;^UTILITY(U,$J,358.3,17096,1,4,0)
 ;;=4^Z79.51
 ;;^UTILITY(U,$J,358.3,17096,2)
 ;;=^5063335
 ;;^UTILITY(U,$J,358.3,17097,0)
 ;;=Z79.4^^70^809^27
 ;;^UTILITY(U,$J,358.3,17097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17097,1,3,0)
 ;;=3^Long term (current) use of insulin
 ;;^UTILITY(U,$J,358.3,17097,1,4,0)
 ;;=4^Z79.4
 ;;^UTILITY(U,$J,358.3,17097,2)
 ;;=^5063334
 ;;^UTILITY(U,$J,358.3,17098,0)
 ;;=Z79.1^^70^809^28
 ;;^UTILITY(U,$J,358.3,17098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17098,1,3,0)
 ;;=3^Long term (current) use of non-stroidl non-inflam (NSAID)
 ;;^UTILITY(U,$J,358.3,17098,1,4,0)
 ;;=4^Z79.1
 ;;^UTILITY(U,$J,358.3,17098,2)
 ;;=^5063332
 ;;^UTILITY(U,$J,358.3,17099,0)
 ;;=Z79.891^^70^809^29
 ;;^UTILITY(U,$J,358.3,17099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17099,1,3,0)
 ;;=3^Long term (current) use of opiate analgesic
 ;;^UTILITY(U,$J,358.3,17099,1,4,0)
 ;;=4^Z79.891
 ;;^UTILITY(U,$J,358.3,17099,2)
 ;;=^5063342
 ;;^UTILITY(U,$J,358.3,17100,0)
 ;;=Z79.52^^70^809^30
 ;;^UTILITY(U,$J,358.3,17100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17100,1,3,0)
 ;;=3^Long term (current) use of systemic steroids
 ;;^UTILITY(U,$J,358.3,17100,1,4,0)
 ;;=4^Z79.52
 ;;^UTILITY(U,$J,358.3,17100,2)
 ;;=^5063336
 ;;^UTILITY(U,$J,358.3,17101,0)
 ;;=Z91.19^^70^809^40
 ;;^UTILITY(U,$J,358.3,17101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17101,1,3,0)
 ;;=3^Pt's noncmplnc w oth med'l trmnt & regimen
 ;;^UTILITY(U,$J,358.3,17101,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,17101,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,17102,0)
 ;;=Z73.89^^70^809^32
 ;;^UTILITY(U,$J,358.3,17102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17102,1,3,0)
 ;;=3^Prblms related to life mngmt difficulty, oth
 ;;^UTILITY(U,$J,358.3,17102,1,4,0)
 ;;=4^Z73.89
 ;;^UTILITY(U,$J,358.3,17102,2)
 ;;=^5063280
 ;;^UTILITY(U,$J,358.3,17103,0)
 ;;=Z55.9^^70^809^31
