IBDEI02L ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,807,1,4,0)
 ;;=4^Otosclerosis NEC
 ;;^UTILITY(U,$J,358.3,807,2)
 ;;=^87766
 ;;^UTILITY(U,$J,358.3,808,0)
 ;;=387.9^^11^93^74
 ;;^UTILITY(U,$J,358.3,808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,808,1,3,0)
 ;;=3^387.9
 ;;^UTILITY(U,$J,358.3,808,1,4,0)
 ;;=4^Otosclerosis NOS
 ;;^UTILITY(U,$J,358.3,808,2)
 ;;=^88333
 ;;^UTILITY(U,$J,358.3,809,0)
 ;;=380.11^^11^93^14
 ;;^UTILITY(U,$J,358.3,809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,809,1,3,0)
 ;;=3^380.11
 ;;^UTILITY(U,$J,358.3,809,1,4,0)
 ;;=4^Acute Infection of Pinna
 ;;^UTILITY(U,$J,358.3,809,2)
 ;;=^269341
 ;;^UTILITY(U,$J,358.3,810,0)
 ;;=380.21^^11^93^27
 ;;^UTILITY(U,$J,358.3,810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,810,1,3,0)
 ;;=3^380.21
 ;;^UTILITY(U,$J,358.3,810,1,4,0)
 ;;=4^Cholesteatoma of External Ear
 ;;^UTILITY(U,$J,358.3,810,2)
 ;;=^269350
 ;;^UTILITY(U,$J,358.3,811,0)
 ;;=380.22^^11^93^65
 ;;^UTILITY(U,$J,358.3,811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,811,1,3,0)
 ;;=3^380.22
 ;;^UTILITY(U,$J,358.3,811,1,4,0)
 ;;=4^Oth Acute Otitis Externa
 ;;^UTILITY(U,$J,358.3,811,2)
 ;;=^269352
 ;;^UTILITY(U,$J,358.3,812,0)
 ;;=380.23^^11^93^67
 ;;^UTILITY(U,$J,358.3,812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,812,1,3,0)
 ;;=3^380.23
 ;;^UTILITY(U,$J,358.3,812,1,4,0)
 ;;=4^Oth Chr Otitis Externa
 ;;^UTILITY(U,$J,358.3,812,2)
 ;;=^269353
 ;;^UTILITY(U,$J,358.3,813,0)
 ;;=381.10^^11^93^37
 ;;^UTILITY(U,$J,358.3,813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,813,1,3,0)
 ;;=3^381.10
 ;;^UTILITY(U,$J,358.3,813,1,4,0)
 ;;=4^Chr Seroous Otitis Media
 ;;^UTILITY(U,$J,358.3,813,2)
 ;;=^269376
 ;;^UTILITY(U,$J,358.3,814,0)
 ;;=381.50^^11^93^46
 ;;^UTILITY(U,$J,358.3,814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,814,1,3,0)
 ;;=3^381.50
 ;;^UTILITY(U,$J,358.3,814,1,4,0)
 ;;=4^Eustachian Salping NOS
 ;;^UTILITY(U,$J,358.3,814,2)
 ;;=^269382
 ;;^UTILITY(U,$J,358.3,815,0)
 ;;=385.30^^11^93^25
 ;;^UTILITY(U,$J,358.3,815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,815,1,3,0)
 ;;=3^385.30
 ;;^UTILITY(U,$J,358.3,815,1,4,0)
 ;;=4^Cholesteatoma Unspec
 ;;^UTILITY(U,$J,358.3,815,2)
 ;;=^23487
 ;;^UTILITY(U,$J,358.3,816,0)
 ;;=385.31^^11^93^26
 ;;^UTILITY(U,$J,358.3,816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,816,1,3,0)
 ;;=3^385.31
 ;;^UTILITY(U,$J,358.3,816,1,4,0)
 ;;=4^Cholesteatoma of Attic
 ;;^UTILITY(U,$J,358.3,816,2)
 ;;=^269457
 ;;^UTILITY(U,$J,358.3,817,0)
 ;;=385.32^^11^93^28
 ;;^UTILITY(U,$J,358.3,817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,817,1,3,0)
 ;;=3^385.32
 ;;^UTILITY(U,$J,358.3,817,1,4,0)
 ;;=4^Cholesteatoma of Middle Ear
 ;;^UTILITY(U,$J,358.3,817,2)
 ;;=^269459
 ;;^UTILITY(U,$J,358.3,818,0)
 ;;=385.33^^11^93^29
 ;;^UTILITY(U,$J,358.3,818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,818,1,3,0)
 ;;=3^385.33
 ;;^UTILITY(U,$J,358.3,818,1,4,0)
 ;;=4^Cholestma Middle Ear/Mastoid
 ;;^UTILITY(U,$J,358.3,818,2)
 ;;=^23491
 ;;^UTILITY(U,$J,358.3,819,0)
 ;;=385.83^^11^93^82
 ;;^UTILITY(U,$J,358.3,819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,819,1,3,0)
 ;;=3^385.83
 ;;^UTILITY(U,$J,358.3,819,1,4,0)
 ;;=4^Retained FB of Middle Ear
 ;;^UTILITY(U,$J,358.3,819,2)
 ;;=^269466
 ;;^UTILITY(U,$J,358.3,820,0)
 ;;=380.14^^11^93^56
 ;;^UTILITY(U,$J,358.3,820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,820,1,3,0)
 ;;=3^380.14
 ;;^UTILITY(U,$J,358.3,820,1,4,0)
 ;;=4^Malignant Otitis Externa
 ;;^UTILITY(U,$J,358.3,820,2)
 ;;=^269347
 ;;^UTILITY(U,$J,358.3,821,0)
 ;;=380.16^^11^93^66
 ;;^UTILITY(U,$J,358.3,821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,821,1,3,0)
 ;;=3^380.16
 ;;^UTILITY(U,$J,358.3,821,1,4,0)
 ;;=4^Oth Chr Inf Otits Externa
