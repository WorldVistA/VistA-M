IBDEI06G ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2496,1,3,0)
 ;;=3^Hemochromatosis due to repeated red blood cell transfusions
 ;;^UTILITY(U,$J,358.3,2496,1,4,0)
 ;;=4^E83.111
 ;;^UTILITY(U,$J,358.3,2496,2)
 ;;=^5002994
 ;;^UTILITY(U,$J,358.3,2497,0)
 ;;=E83.10^^6^75^26
 ;;^UTILITY(U,$J,358.3,2497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2497,1,3,0)
 ;;=3^Disorder of iron metabolism, unspecified
 ;;^UTILITY(U,$J,358.3,2497,1,4,0)
 ;;=4^E83.10
 ;;^UTILITY(U,$J,358.3,2497,2)
 ;;=^5002993
 ;;^UTILITY(U,$J,358.3,2498,0)
 ;;=D64.9^^6^75^5
 ;;^UTILITY(U,$J,358.3,2498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2498,1,3,0)
 ;;=3^Anemia, unspecified
 ;;^UTILITY(U,$J,358.3,2498,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,2498,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,2499,0)
 ;;=K50.919^^6^75^24
 ;;^UTILITY(U,$J,358.3,2499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2499,1,3,0)
 ;;=3^Crohn's disease, unspecified, with unspecified complications
 ;;^UTILITY(U,$J,358.3,2499,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,2499,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,2500,0)
 ;;=K50.918^^6^75^22
 ;;^UTILITY(U,$J,358.3,2500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2500,1,3,0)
 ;;=3^Crohn's disease, unspecified, with other complication
 ;;^UTILITY(U,$J,358.3,2500,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,2500,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,2501,0)
 ;;=K50.914^^6^75^19
 ;;^UTILITY(U,$J,358.3,2501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2501,1,3,0)
 ;;=3^Crohn's disease, unspecified, with abscess
 ;;^UTILITY(U,$J,358.3,2501,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,2501,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,2502,0)
 ;;=K50.913^^6^75^20
 ;;^UTILITY(U,$J,358.3,2502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2502,1,3,0)
 ;;=3^Crohn's disease, unspecified, with fistula
 ;;^UTILITY(U,$J,358.3,2502,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,2502,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,2503,0)
 ;;=K50.912^^6^75^21
 ;;^UTILITY(U,$J,358.3,2503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2503,1,3,0)
 ;;=3^Crohn's disease, unspecified, with intestinal obstruction
 ;;^UTILITY(U,$J,358.3,2503,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,2503,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,2504,0)
 ;;=K50.90^^6^75^25
 ;;^UTILITY(U,$J,358.3,2504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2504,1,3,0)
 ;;=3^Crohn's disease, unspecified, without complications
 ;;^UTILITY(U,$J,358.3,2504,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,2504,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,2505,0)
 ;;=K50.911^^6^75^23
 ;;^UTILITY(U,$J,358.3,2505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2505,1,3,0)
 ;;=3^Crohn's disease, unspecified, with rectal bleeding
 ;;^UTILITY(U,$J,358.3,2505,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,2505,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,2506,0)
 ;;=K51.20^^6^75^56
 ;;^UTILITY(U,$J,358.3,2506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2506,1,3,0)
 ;;=3^Ulcerative (chronic) proctitis without complications
 ;;^UTILITY(U,$J,358.3,2506,1,4,0)
 ;;=4^K51.20
 ;;^UTILITY(U,$J,358.3,2506,2)
 ;;=^5008659
 ;;^UTILITY(U,$J,358.3,2507,0)
 ;;=K51.211^^6^75^54
 ;;^UTILITY(U,$J,358.3,2507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2507,1,3,0)
 ;;=3^Ulcerative (chronic) proctitis with rectal bleeding
 ;;^UTILITY(U,$J,358.3,2507,1,4,0)
 ;;=4^K51.211
 ;;^UTILITY(U,$J,358.3,2507,2)
 ;;=^5008660
 ;;^UTILITY(U,$J,358.3,2508,0)
 ;;=K51.212^^6^75^52
 ;;^UTILITY(U,$J,358.3,2508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2508,1,3,0)
 ;;=3^Ulcerative (chronic) proctitis with intestinal obstruction
 ;;^UTILITY(U,$J,358.3,2508,1,4,0)
 ;;=4^K51.212
