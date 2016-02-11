IBDEI2BR ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39035,0)
 ;;=M06.332^^180^1991^71
 ;;^UTILITY(U,$J,358.3,39035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39035,1,3,0)
 ;;=3^Rheumatoid nodule, left wrist
 ;;^UTILITY(U,$J,358.3,39035,1,4,0)
 ;;=4^M06.332
 ;;^UTILITY(U,$J,358.3,39035,2)
 ;;=^5010104
 ;;^UTILITY(U,$J,358.3,39036,0)
 ;;=M06.39^^180^1991^72
 ;;^UTILITY(U,$J,358.3,39036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39036,1,3,0)
 ;;=3^Rheumatoid nodule, multiple sites
 ;;^UTILITY(U,$J,358.3,39036,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,39036,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,39037,0)
 ;;=M06.371^^180^1991^73
 ;;^UTILITY(U,$J,358.3,39037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39037,1,3,0)
 ;;=3^Rheumatoid nodule, right ankle and foot
 ;;^UTILITY(U,$J,358.3,39037,1,4,0)
 ;;=4^M06.371
 ;;^UTILITY(U,$J,358.3,39037,2)
 ;;=^5010115
 ;;^UTILITY(U,$J,358.3,39038,0)
 ;;=M06.321^^180^1991^74
 ;;^UTILITY(U,$J,358.3,39038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39038,1,3,0)
 ;;=3^Rheumatoid nodule, right elbow
 ;;^UTILITY(U,$J,358.3,39038,1,4,0)
 ;;=4^M06.321
 ;;^UTILITY(U,$J,358.3,39038,2)
 ;;=^5010100
 ;;^UTILITY(U,$J,358.3,39039,0)
 ;;=M06.341^^180^1991^75
 ;;^UTILITY(U,$J,358.3,39039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39039,1,3,0)
 ;;=3^Rheumatoid nodule, right hand
 ;;^UTILITY(U,$J,358.3,39039,1,4,0)
 ;;=4^M06.341
 ;;^UTILITY(U,$J,358.3,39039,2)
 ;;=^5010106
 ;;^UTILITY(U,$J,358.3,39040,0)
 ;;=M06.351^^180^1991^76
 ;;^UTILITY(U,$J,358.3,39040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39040,1,3,0)
 ;;=3^Rheumatoid nodule, right hip
 ;;^UTILITY(U,$J,358.3,39040,1,4,0)
 ;;=4^M06.351
 ;;^UTILITY(U,$J,358.3,39040,2)
 ;;=^5010109
 ;;^UTILITY(U,$J,358.3,39041,0)
 ;;=M06.361^^180^1991^77
 ;;^UTILITY(U,$J,358.3,39041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39041,1,3,0)
 ;;=3^Rheumatoid nodule, right knee
 ;;^UTILITY(U,$J,358.3,39041,1,4,0)
 ;;=4^M06.361
 ;;^UTILITY(U,$J,358.3,39041,2)
 ;;=^5010112
 ;;^UTILITY(U,$J,358.3,39042,0)
 ;;=M06.311^^180^1991^78
 ;;^UTILITY(U,$J,358.3,39042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39042,1,3,0)
 ;;=3^Rheumatoid nodule, right shoulder
 ;;^UTILITY(U,$J,358.3,39042,1,4,0)
 ;;=4^M06.311
 ;;^UTILITY(U,$J,358.3,39042,2)
 ;;=^5010097
 ;;^UTILITY(U,$J,358.3,39043,0)
 ;;=M06.331^^180^1991^79
 ;;^UTILITY(U,$J,358.3,39043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39043,1,3,0)
 ;;=3^Rheumatoid nodule, right wrist
 ;;^UTILITY(U,$J,358.3,39043,1,4,0)
 ;;=4^M06.331
 ;;^UTILITY(U,$J,358.3,39043,2)
 ;;=^5010103
 ;;^UTILITY(U,$J,358.3,39044,0)
 ;;=M06.38^^180^1991^80
 ;;^UTILITY(U,$J,358.3,39044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39044,1,3,0)
 ;;=3^Rheumatoid nodule, vertebrae
 ;;^UTILITY(U,$J,358.3,39044,1,4,0)
 ;;=4^M06.38
 ;;^UTILITY(U,$J,358.3,39044,2)
 ;;=^5010118
 ;;^UTILITY(U,$J,358.3,39045,0)
 ;;=M05.572^^180^1991^81
 ;;^UTILITY(U,$J,358.3,39045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39045,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of left ank/ft
 ;;^UTILITY(U,$J,358.3,39045,1,4,0)
 ;;=4^M05.572
 ;;^UTILITY(U,$J,358.3,39045,2)
 ;;=^5009974
 ;;^UTILITY(U,$J,358.3,39046,0)
 ;;=M05.522^^180^1991^82
 ;;^UTILITY(U,$J,358.3,39046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39046,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of left elbow
 ;;^UTILITY(U,$J,358.3,39046,1,4,0)
 ;;=4^M05.522
 ;;^UTILITY(U,$J,358.3,39046,2)
 ;;=^5009959
 ;;^UTILITY(U,$J,358.3,39047,0)
 ;;=M05.542^^180^1991^83
 ;;^UTILITY(U,$J,358.3,39047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39047,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of left hand
