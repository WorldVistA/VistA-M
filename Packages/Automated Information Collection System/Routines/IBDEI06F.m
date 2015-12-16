IBDEI06F ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2482,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,2482,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,2483,0)
 ;;=D12.4^^6^75^13
 ;;^UTILITY(U,$J,358.3,2483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2483,1,3,0)
 ;;=3^Benign neoplasm of descending colon
 ;;^UTILITY(U,$J,358.3,2483,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,2483,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,2484,0)
 ;;=D12.2^^6^75^10
 ;;^UTILITY(U,$J,358.3,2484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2484,1,3,0)
 ;;=3^Benign neoplasm of ascending colon
 ;;^UTILITY(U,$J,358.3,2484,1,4,0)
 ;;=4^D12.2
 ;;^UTILITY(U,$J,358.3,2484,2)
 ;;=^5001965
 ;;^UTILITY(U,$J,358.3,2485,0)
 ;;=D12.3^^6^75^17
 ;;^UTILITY(U,$J,358.3,2485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2485,1,3,0)
 ;;=3^Benign neoplasm of transverse colon
 ;;^UTILITY(U,$J,358.3,2485,1,4,0)
 ;;=4^D12.3
 ;;^UTILITY(U,$J,358.3,2485,2)
 ;;=^5001966
 ;;^UTILITY(U,$J,358.3,2486,0)
 ;;=K62.0^^6^75^4
 ;;^UTILITY(U,$J,358.3,2486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2486,1,3,0)
 ;;=3^Anal polyp
 ;;^UTILITY(U,$J,358.3,2486,1,4,0)
 ;;=4^K62.0
 ;;^UTILITY(U,$J,358.3,2486,2)
 ;;=^5008753
 ;;^UTILITY(U,$J,358.3,2487,0)
 ;;=K62.1^^6^75^47
 ;;^UTILITY(U,$J,358.3,2487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2487,1,3,0)
 ;;=3^Rectal polyp
 ;;^UTILITY(U,$J,358.3,2487,1,4,0)
 ;;=4^K62.1
 ;;^UTILITY(U,$J,358.3,2487,2)
 ;;=^104099
 ;;^UTILITY(U,$J,358.3,2488,0)
 ;;=K63.5^^6^75^45
 ;;^UTILITY(U,$J,358.3,2488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2488,1,3,0)
 ;;=3^Polyp of colon
 ;;^UTILITY(U,$J,358.3,2488,1,4,0)
 ;;=4^K63.5
 ;;^UTILITY(U,$J,358.3,2488,2)
 ;;=^5008765
 ;;^UTILITY(U,$J,358.3,2489,0)
 ;;=D12.6^^6^75^12
 ;;^UTILITY(U,$J,358.3,2489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2489,1,3,0)
 ;;=3^Benign neoplasm of colon, unspecified
 ;;^UTILITY(U,$J,358.3,2489,1,4,0)
 ;;=4^D12.6
 ;;^UTILITY(U,$J,358.3,2489,2)
 ;;=^5001969
 ;;^UTILITY(U,$J,358.3,2490,0)
 ;;=D12.1^^6^75^9
 ;;^UTILITY(U,$J,358.3,2490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2490,1,3,0)
 ;;=3^Benign neoplasm of appendix
 ;;^UTILITY(U,$J,358.3,2490,1,4,0)
 ;;=4^D12.1
 ;;^UTILITY(U,$J,358.3,2490,2)
 ;;=^5001964
 ;;^UTILITY(U,$J,358.3,2491,0)
 ;;=D12.0^^6^75^11
 ;;^UTILITY(U,$J,358.3,2491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2491,1,3,0)
 ;;=3^Benign neoplasm of cecum
 ;;^UTILITY(U,$J,358.3,2491,1,4,0)
 ;;=4^D12.0
 ;;^UTILITY(U,$J,358.3,2491,2)
 ;;=^5001963
 ;;^UTILITY(U,$J,358.3,2492,0)
 ;;=D12.7^^6^75^14
 ;;^UTILITY(U,$J,358.3,2492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2492,1,3,0)
 ;;=3^Benign neoplasm of rectosigmoid junction
 ;;^UTILITY(U,$J,358.3,2492,1,4,0)
 ;;=4^D12.7
 ;;^UTILITY(U,$J,358.3,2492,2)
 ;;=^5001970
 ;;^UTILITY(U,$J,358.3,2493,0)
 ;;=D12.8^^6^75^15
 ;;^UTILITY(U,$J,358.3,2493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2493,1,3,0)
 ;;=3^Benign neoplasm of rectum
 ;;^UTILITY(U,$J,358.3,2493,1,4,0)
 ;;=4^D12.8
 ;;^UTILITY(U,$J,358.3,2493,2)
 ;;=^5001971
 ;;^UTILITY(U,$J,358.3,2494,0)
 ;;=D12.9^^6^75^8
 ;;^UTILITY(U,$J,358.3,2494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2494,1,3,0)
 ;;=3^Benign neoplasm of anus and anal canal
 ;;^UTILITY(U,$J,358.3,2494,1,4,0)
 ;;=4^D12.9
 ;;^UTILITY(U,$J,358.3,2494,2)
 ;;=^5001972
 ;;^UTILITY(U,$J,358.3,2495,0)
 ;;=E83.110^^6^75^38
 ;;^UTILITY(U,$J,358.3,2495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2495,1,3,0)
 ;;=3^Hereditary hemochromatosis
 ;;^UTILITY(U,$J,358.3,2495,1,4,0)
 ;;=4^E83.110
 ;;^UTILITY(U,$J,358.3,2495,2)
 ;;=^339602
 ;;^UTILITY(U,$J,358.3,2496,0)
 ;;=E83.111^^6^75^35
 ;;^UTILITY(U,$J,358.3,2496,1,0)
 ;;=^358.31IA^4^2
