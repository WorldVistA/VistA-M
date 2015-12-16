IBDEI06I ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2521,1,3,0)
 ;;=3^Dvrtclos of intest, part unsp, w/o perf or abscess w/o bleed
 ;;^UTILITY(U,$J,358.3,2521,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,2521,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,2522,0)
 ;;=K57.50^^6^75^27
 ;;^UTILITY(U,$J,358.3,2522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2522,1,3,0)
 ;;=3^Dvrtclos of both sm and lg int w/o perf or abscs w/o bleed
 ;;^UTILITY(U,$J,358.3,2522,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,2522,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,2523,0)
 ;;=K57.30^^6^75^29
 ;;^UTILITY(U,$J,358.3,2523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2523,1,3,0)
 ;;=3^Dvrtclos of lg int w/o perforation or abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,2523,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,2523,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,2524,0)
 ;;=K57.20^^6^75^31
 ;;^UTILITY(U,$J,358.3,2524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2524,1,3,0)
 ;;=3^Dvtrcli of lg int w perforation and abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,2524,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,2524,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,2525,0)
 ;;=K57.92^^6^75^30
 ;;^UTILITY(U,$J,358.3,2525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2525,1,3,0)
 ;;=3^Dvtrcli of intest, part unsp, w/o perf or abscess w/o bleed
 ;;^UTILITY(U,$J,358.3,2525,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,2525,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,2526,0)
 ;;=K57.32^^6^75^32
 ;;^UTILITY(U,$J,358.3,2526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2526,1,3,0)
 ;;=3^Dvtrcli of lg int w/o perforation or abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,2526,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,2526,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,2527,0)
 ;;=K59.00^^6^75^18
 ;;^UTILITY(U,$J,358.3,2527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2527,1,3,0)
 ;;=3^Constipation, unspecified
 ;;^UTILITY(U,$J,358.3,2527,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,2527,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,2528,0)
 ;;=K58.0^^6^75^40
 ;;^UTILITY(U,$J,358.3,2528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2528,1,3,0)
 ;;=3^Irritable bowel syndrome with diarrhea
 ;;^UTILITY(U,$J,358.3,2528,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,2528,2)
 ;;=^5008739
 ;;^UTILITY(U,$J,358.3,2529,0)
 ;;=K58.9^^6^75^41
 ;;^UTILITY(U,$J,358.3,2529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2529,1,3,0)
 ;;=3^Irritable bowel syndrome without diarrhea
 ;;^UTILITY(U,$J,358.3,2529,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,2529,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,2530,0)
 ;;=K60.0^^6^75^1
 ;;^UTILITY(U,$J,358.3,2530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2530,1,3,0)
 ;;=3^Acute anal fissure
 ;;^UTILITY(U,$J,358.3,2530,1,4,0)
 ;;=4^K60.0
 ;;^UTILITY(U,$J,358.3,2530,2)
 ;;=^5008745
 ;;^UTILITY(U,$J,358.3,2531,0)
 ;;=K60.2^^6^75^3
 ;;^UTILITY(U,$J,358.3,2531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2531,1,3,0)
 ;;=3^Anal fissure, unspecified
 ;;^UTILITY(U,$J,358.3,2531,1,4,0)
 ;;=4^K60.2
 ;;^UTILITY(U,$J,358.3,2531,2)
 ;;=^5008747
 ;;^UTILITY(U,$J,358.3,2532,0)
 ;;=K62.5^^6^75^36
 ;;^UTILITY(U,$J,358.3,2532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2532,1,3,0)
 ;;=3^Hemorrhage of anus and rectum
 ;;^UTILITY(U,$J,358.3,2532,1,4,0)
 ;;=4^K62.5
 ;;^UTILITY(U,$J,358.3,2532,2)
 ;;=^5008755
 ;;^UTILITY(U,$J,358.3,2533,0)
 ;;=K55.20^^6^75^6
 ;;^UTILITY(U,$J,358.3,2533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2533,1,3,0)
 ;;=3^Angiodysplasia of colon without hemorrhage
 ;;^UTILITY(U,$J,358.3,2533,1,4,0)
 ;;=4^K55.20
 ;;^UTILITY(U,$J,358.3,2533,2)
 ;;=^5008707
 ;;^UTILITY(U,$J,358.3,2534,0)
 ;;=K74.3^^6^75^46
