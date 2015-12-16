IBDEI06B ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2429,1,3,0)
 ;;=3^Acute/subacute allergic otitis media, r ear
 ;;^UTILITY(U,$J,358.3,2429,1,4,0)
 ;;=4^H65.111
 ;;^UTILITY(U,$J,358.3,2429,2)
 ;;=^5006577
 ;;^UTILITY(U,$J,358.3,2430,0)
 ;;=H65.112^^5^71^7
 ;;^UTILITY(U,$J,358.3,2430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2430,1,3,0)
 ;;=3^Acute/subacute allergic otitis media, left ear
 ;;^UTILITY(U,$J,358.3,2430,1,4,0)
 ;;=4^H65.112
 ;;^UTILITY(U,$J,358.3,2430,2)
 ;;=^5006578
 ;;^UTILITY(U,$J,358.3,2431,0)
 ;;=H66.001^^5^71^5
 ;;^UTILITY(U,$J,358.3,2431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2431,1,3,0)
 ;;=3^Acute suppr otitis media w/o spon rupt ear drum, right
 ;;^UTILITY(U,$J,358.3,2431,1,4,0)
 ;;=4^H66.001
 ;;^UTILITY(U,$J,358.3,2431,2)
 ;;=^5006613
 ;;^UTILITY(U,$J,358.3,2432,0)
 ;;=H66.002^^5^71^6
 ;;^UTILITY(U,$J,358.3,2432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2432,1,3,0)
 ;;=3^Acute suppr otitis media w/o spon rupt ear drum, left e
 ;;^UTILITY(U,$J,358.3,2432,1,4,0)
 ;;=4^H66.002
 ;;^UTILITY(U,$J,358.3,2432,2)
 ;;=^5006614
 ;;^UTILITY(U,$J,358.3,2433,0)
 ;;=H66.3X1^^5^71^18
 ;;^UTILITY(U,$J,358.3,2433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2433,1,3,0)
 ;;=3^Chronic suppurative otitis media, right ear NEC
 ;;^UTILITY(U,$J,358.3,2433,1,4,0)
 ;;=4^H66.3X1
 ;;^UTILITY(U,$J,358.3,2433,2)
 ;;=^5006633
 ;;^UTILITY(U,$J,358.3,2434,0)
 ;;=H66.3X2^^5^71^17
 ;;^UTILITY(U,$J,358.3,2434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2434,1,3,0)
 ;;=3^Chronic suppurative otitis media, left ear NEC
 ;;^UTILITY(U,$J,358.3,2434,1,4,0)
 ;;=4^H66.3X2
 ;;^UTILITY(U,$J,358.3,2434,2)
 ;;=^5133538
 ;;^UTILITY(U,$J,358.3,2435,0)
 ;;=H74.01^^5^71^57
 ;;^UTILITY(U,$J,358.3,2435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2435,1,3,0)
 ;;=3^Tympanosclerosis, right ear
 ;;^UTILITY(U,$J,358.3,2435,1,4,0)
 ;;=4^H74.01
 ;;^UTILITY(U,$J,358.3,2435,2)
 ;;=^5006796
 ;;^UTILITY(U,$J,358.3,2436,0)
 ;;=H74.02^^5^71^56
 ;;^UTILITY(U,$J,358.3,2436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2436,1,3,0)
 ;;=3^Tympanosclerosis, left ear
 ;;^UTILITY(U,$J,358.3,2436,1,4,0)
 ;;=4^H74.02
 ;;^UTILITY(U,$J,358.3,2436,2)
 ;;=^5006797
 ;;^UTILITY(U,$J,358.3,2437,0)
 ;;=H74.11^^5^71^10
 ;;^UTILITY(U,$J,358.3,2437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2437,1,3,0)
 ;;=3^Adhesive right middle ear disease
 ;;^UTILITY(U,$J,358.3,2437,1,4,0)
 ;;=4^H74.11
 ;;^UTILITY(U,$J,358.3,2437,2)
 ;;=^5006800
 ;;^UTILITY(U,$J,358.3,2438,0)
 ;;=H74.12^^5^71^9
 ;;^UTILITY(U,$J,358.3,2438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2438,1,3,0)
 ;;=3^Adhesive left middle ear disease
 ;;^UTILITY(U,$J,358.3,2438,1,4,0)
 ;;=4^H74.12
 ;;^UTILITY(U,$J,358.3,2438,2)
 ;;=^5006801
 ;;^UTILITY(U,$J,358.3,2439,0)
 ;;=H81.01^^5^71^38
 ;;^UTILITY(U,$J,358.3,2439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2439,1,3,0)
 ;;=3^Meniere's disease, right ear
 ;;^UTILITY(U,$J,358.3,2439,1,4,0)
 ;;=4^H81.01
 ;;^UTILITY(U,$J,358.3,2439,2)
 ;;=^5006860
 ;;^UTILITY(U,$J,358.3,2440,0)
 ;;=H81.02^^5^71^37
 ;;^UTILITY(U,$J,358.3,2440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2440,1,3,0)
 ;;=3^Meniere's disease, left ear
 ;;^UTILITY(U,$J,358.3,2440,1,4,0)
 ;;=4^H81.02
 ;;^UTILITY(U,$J,358.3,2440,2)
 ;;=^5006861
 ;;^UTILITY(U,$J,358.3,2441,0)
 ;;=H81.391^^5^71^49
 ;;^UTILITY(U,$J,358.3,2441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2441,1,3,0)
 ;;=3^Peripheral vertigo, right ear NEC
 ;;^UTILITY(U,$J,358.3,2441,1,4,0)
 ;;=4^H81.391
 ;;^UTILITY(U,$J,358.3,2441,2)
 ;;=^5006876
 ;;^UTILITY(U,$J,358.3,2442,0)
 ;;=H81.392^^5^71^48
 ;;^UTILITY(U,$J,358.3,2442,1,0)
 ;;=^358.31IA^4^2
