IBDEI2BN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38985,1,4,0)
 ;;=4^M06.052
 ;;^UTILITY(U,$J,358.3,38985,2)
 ;;=^5010061
 ;;^UTILITY(U,$J,358.3,38986,0)
 ;;=M06.062^^180^1991^21
 ;;^UTILITY(U,$J,358.3,38986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38986,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, left knee
 ;;^UTILITY(U,$J,358.3,38986,1,4,0)
 ;;=4^M06.062
 ;;^UTILITY(U,$J,358.3,38986,2)
 ;;=^5010064
 ;;^UTILITY(U,$J,358.3,38987,0)
 ;;=M06.012^^180^1991^22
 ;;^UTILITY(U,$J,358.3,38987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38987,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, left shoulder
 ;;^UTILITY(U,$J,358.3,38987,1,4,0)
 ;;=4^M06.012
 ;;^UTILITY(U,$J,358.3,38987,2)
 ;;=^5010049
 ;;^UTILITY(U,$J,358.3,38988,0)
 ;;=M06.032^^180^1991^23
 ;;^UTILITY(U,$J,358.3,38988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38988,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, left wrist
 ;;^UTILITY(U,$J,358.3,38988,1,4,0)
 ;;=4^M06.032
 ;;^UTILITY(U,$J,358.3,38988,2)
 ;;=^5010055
 ;;^UTILITY(U,$J,358.3,38989,0)
 ;;=M06.09^^180^1991^24
 ;;^UTILITY(U,$J,358.3,38989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38989,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, multiple sites
 ;;^UTILITY(U,$J,358.3,38989,1,4,0)
 ;;=4^M06.09
 ;;^UTILITY(U,$J,358.3,38989,2)
 ;;=^5010070
 ;;^UTILITY(U,$J,358.3,38990,0)
 ;;=M06.071^^180^1991^25
 ;;^UTILITY(U,$J,358.3,38990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38990,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right ank/ft
 ;;^UTILITY(U,$J,358.3,38990,1,4,0)
 ;;=4^M06.071
 ;;^UTILITY(U,$J,358.3,38990,2)
 ;;=^5010066
 ;;^UTILITY(U,$J,358.3,38991,0)
 ;;=M06.021^^180^1991^26
 ;;^UTILITY(U,$J,358.3,38991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38991,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right elbow
 ;;^UTILITY(U,$J,358.3,38991,1,4,0)
 ;;=4^M06.021
 ;;^UTILITY(U,$J,358.3,38991,2)
 ;;=^5010051
 ;;^UTILITY(U,$J,358.3,38992,0)
 ;;=M06.041^^180^1991^27
 ;;^UTILITY(U,$J,358.3,38992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38992,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right hand
 ;;^UTILITY(U,$J,358.3,38992,1,4,0)
 ;;=4^M06.041
 ;;^UTILITY(U,$J,358.3,38992,2)
 ;;=^5010057
 ;;^UTILITY(U,$J,358.3,38993,0)
 ;;=M06.051^^180^1991^28
 ;;^UTILITY(U,$J,358.3,38993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38993,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right hip
 ;;^UTILITY(U,$J,358.3,38993,1,4,0)
 ;;=4^M06.051
 ;;^UTILITY(U,$J,358.3,38993,2)
 ;;=^5010060
 ;;^UTILITY(U,$J,358.3,38994,0)
 ;;=M06.061^^180^1991^29
 ;;^UTILITY(U,$J,358.3,38994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38994,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right knee
 ;;^UTILITY(U,$J,358.3,38994,1,4,0)
 ;;=4^M06.061
 ;;^UTILITY(U,$J,358.3,38994,2)
 ;;=^5010063
 ;;^UTILITY(U,$J,358.3,38995,0)
 ;;=M06.011^^180^1991^30
 ;;^UTILITY(U,$J,358.3,38995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38995,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right shoulder
 ;;^UTILITY(U,$J,358.3,38995,1,4,0)
 ;;=4^M06.011
 ;;^UTILITY(U,$J,358.3,38995,2)
 ;;=^5010048
 ;;^UTILITY(U,$J,358.3,38996,0)
 ;;=M06.031^^180^1991^31
 ;;^UTILITY(U,$J,358.3,38996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38996,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, right wrist
 ;;^UTILITY(U,$J,358.3,38996,1,4,0)
 ;;=4^M06.031
 ;;^UTILITY(U,$J,358.3,38996,2)
 ;;=^5010054
 ;;^UTILITY(U,$J,358.3,38997,0)
 ;;=M06.08^^180^1991^32
 ;;^UTILITY(U,$J,358.3,38997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38997,1,3,0)
 ;;=3^Rheum arthritis w/o rheumatoid factor, vertebrae
