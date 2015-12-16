IBDEI067 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2376,1,3,0)
 ;;=3^Chronic tonsillitis
 ;;^UTILITY(U,$J,358.3,2376,1,4,0)
 ;;=4^J35.01
 ;;^UTILITY(U,$J,358.3,2376,2)
 ;;=^259089
 ;;^UTILITY(U,$J,358.3,2377,0)
 ;;=J36.^^5^70^18
 ;;^UTILITY(U,$J,358.3,2377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2377,1,3,0)
 ;;=3^Peritonsillar abscess
 ;;^UTILITY(U,$J,358.3,2377,1,4,0)
 ;;=4^J36.
 ;;^UTILITY(U,$J,358.3,2377,2)
 ;;=^92333
 ;;^UTILITY(U,$J,358.3,2378,0)
 ;;=J37.0^^5^70^4
 ;;^UTILITY(U,$J,358.3,2378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2378,1,3,0)
 ;;=3^Chronic laryngitis
 ;;^UTILITY(U,$J,358.3,2378,1,4,0)
 ;;=4^J37.0
 ;;^UTILITY(U,$J,358.3,2378,2)
 ;;=^269902
 ;;^UTILITY(U,$J,358.3,2379,0)
 ;;=J30.9^^5^70^2
 ;;^UTILITY(U,$J,358.3,2379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2379,1,3,0)
 ;;=3^Allergic rhinitis, unspecified
 ;;^UTILITY(U,$J,358.3,2379,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,2379,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,2380,0)
 ;;=J30.0^^5^70^22
 ;;^UTILITY(U,$J,358.3,2380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2380,1,3,0)
 ;;=3^Vasomotor rhinitis
 ;;^UTILITY(U,$J,358.3,2380,1,4,0)
 ;;=4^J30.0
 ;;^UTILITY(U,$J,358.3,2380,2)
 ;;=^5008201
 ;;^UTILITY(U,$J,358.3,2381,0)
 ;;=J34.3^^5^70^14
 ;;^UTILITY(U,$J,358.3,2381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2381,1,3,0)
 ;;=3^Hypertrophy of nasal turbinates
 ;;^UTILITY(U,$J,358.3,2381,1,4,0)
 ;;=4^J34.3
 ;;^UTILITY(U,$J,358.3,2381,2)
 ;;=^269909
 ;;^UTILITY(U,$J,358.3,2382,0)
 ;;=M95.0^^5^70^1
 ;;^UTILITY(U,$J,358.3,2382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2382,1,3,0)
 ;;=3^Acquired deformity of nose
 ;;^UTILITY(U,$J,358.3,2382,1,4,0)
 ;;=4^M95.0
 ;;^UTILITY(U,$J,358.3,2382,2)
 ;;=^5015367
 ;;^UTILITY(U,$J,358.3,2383,0)
 ;;=J38.00^^5^70^17
 ;;^UTILITY(U,$J,358.3,2383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2383,1,3,0)
 ;;=3^Paralysis of vocal cords and larynx, unspecified
 ;;^UTILITY(U,$J,358.3,2383,1,4,0)
 ;;=4^J38.00
 ;;^UTILITY(U,$J,358.3,2383,2)
 ;;=^5008219
 ;;^UTILITY(U,$J,358.3,2384,0)
 ;;=J38.1^^5^70^21
 ;;^UTILITY(U,$J,358.3,2384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2384,1,3,0)
 ;;=3^Polyp of vocal cord and larynx
 ;;^UTILITY(U,$J,358.3,2384,1,4,0)
 ;;=4^J38.1
 ;;^UTILITY(U,$J,358.3,2384,2)
 ;;=^5008222
 ;;^UTILITY(U,$J,358.3,2385,0)
 ;;=J38.7^^5^70^15
 ;;^UTILITY(U,$J,358.3,2385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2385,1,3,0)
 ;;=3^Larynx Diseases NEC
 ;;^UTILITY(U,$J,358.3,2385,1,4,0)
 ;;=4^J38.7
 ;;^UTILITY(U,$J,358.3,2385,2)
 ;;=^5008227
 ;;^UTILITY(U,$J,358.3,2386,0)
 ;;=K13.21^^5^70^16
 ;;^UTILITY(U,$J,358.3,2386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2386,1,3,0)
 ;;=3^Leukoplakia of oral mucosa, including tongue
 ;;^UTILITY(U,$J,358.3,2386,1,4,0)
 ;;=4^K13.21
 ;;^UTILITY(U,$J,358.3,2386,2)
 ;;=^270054
 ;;^UTILITY(U,$J,358.3,2387,0)
 ;;=R43.0^^5^70^3
 ;;^UTILITY(U,$J,358.3,2387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2387,1,3,0)
 ;;=3^Anosmia
 ;;^UTILITY(U,$J,358.3,2387,1,4,0)
 ;;=4^R43.0
 ;;^UTILITY(U,$J,358.3,2387,2)
 ;;=^7949
 ;;^UTILITY(U,$J,358.3,2388,0)
 ;;=R49.0^^5^70^12
 ;;^UTILITY(U,$J,358.3,2388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2388,1,3,0)
 ;;=3^Dysphonia
 ;;^UTILITY(U,$J,358.3,2388,1,4,0)
 ;;=4^R49.0
 ;;^UTILITY(U,$J,358.3,2388,2)
 ;;=^5019501
 ;;^UTILITY(U,$J,358.3,2389,0)
 ;;=R04.0^^5^70^13
 ;;^UTILITY(U,$J,358.3,2389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2389,1,3,0)
 ;;=3^Epistaxis
 ;;^UTILITY(U,$J,358.3,2389,1,4,0)
 ;;=4^R04.0
 ;;^UTILITY(U,$J,358.3,2389,2)
 ;;=^5019173
 ;;^UTILITY(U,$J,358.3,2390,0)
 ;;=H60.391^^5^71^31
 ;;^UTILITY(U,$J,358.3,2390,1,0)
 ;;=^358.31IA^4^2
