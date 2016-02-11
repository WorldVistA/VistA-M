IBDEI2BB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38834,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,38834,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,38834,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,38835,0)
 ;;=F31.10^^180^1987^2
 ;;^UTILITY(U,$J,358.3,38835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38835,1,3,0)
 ;;=3^Bipolar disord, crnt episode manic w/o psych features, unsp
 ;;^UTILITY(U,$J,358.3,38835,1,4,0)
 ;;=4^F31.10
 ;;^UTILITY(U,$J,358.3,38835,2)
 ;;=^5003495
 ;;^UTILITY(U,$J,358.3,38836,0)
 ;;=F32.9^^180^1987^5
 ;;^UTILITY(U,$J,358.3,38836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38836,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,38836,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,38836,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,38837,0)
 ;;=F20.0^^180^1987^6
 ;;^UTILITY(U,$J,358.3,38837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38837,1,3,0)
 ;;=3^Paranoid schizophrenia
 ;;^UTILITY(U,$J,358.3,38837,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,38837,2)
 ;;=^5003469
 ;;^UTILITY(U,$J,358.3,38838,0)
 ;;=F06.0^^180^1987^7
 ;;^UTILITY(U,$J,358.3,38838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38838,1,3,0)
 ;;=3^Psychotic disorder w hallucin due to known physiol condition
 ;;^UTILITY(U,$J,358.3,38838,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,38838,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,38839,0)
 ;;=F20.9^^180^1987^8
 ;;^UTILITY(U,$J,358.3,38839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38839,1,3,0)
 ;;=3^Schizophrenia, unspecified
 ;;^UTILITY(U,$J,358.3,38839,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,38839,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,38840,0)
 ;;=F03.91^^180^1987^3
 ;;^UTILITY(U,$J,358.3,38840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38840,1,3,0)
 ;;=3^Dementia with behavioral disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,38840,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,38840,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,38841,0)
 ;;=F03.90^^180^1987^4
 ;;^UTILITY(U,$J,358.3,38841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38841,1,3,0)
 ;;=3^Dementia without behavioral disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,38841,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,38841,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,38842,0)
 ;;=M76.62^^180^1988^1
 ;;^UTILITY(U,$J,358.3,38842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38842,1,3,0)
 ;;=3^Achilles tendinitis, left leg
 ;;^UTILITY(U,$J,358.3,38842,1,4,0)
 ;;=4^M76.62
 ;;^UTILITY(U,$J,358.3,38842,2)
 ;;=^5013286
 ;;^UTILITY(U,$J,358.3,38843,0)
 ;;=M76.61^^180^1988^2
 ;;^UTILITY(U,$J,358.3,38843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38843,1,3,0)
 ;;=3^Achilles tendinitis, right leg
 ;;^UTILITY(U,$J,358.3,38843,1,4,0)
 ;;=4^M76.61
 ;;^UTILITY(U,$J,358.3,38843,2)
 ;;=^5013285
 ;;^UTILITY(U,$J,358.3,38844,0)
 ;;=M75.02^^180^1988^3
 ;;^UTILITY(U,$J,358.3,38844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38844,1,3,0)
 ;;=3^Adhesive capsulitis of left shoulder
 ;;^UTILITY(U,$J,358.3,38844,1,4,0)
 ;;=4^M75.02
 ;;^UTILITY(U,$J,358.3,38844,2)
 ;;=^5013240
 ;;^UTILITY(U,$J,358.3,38845,0)
 ;;=M75.01^^180^1988^4
 ;;^UTILITY(U,$J,358.3,38845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38845,1,3,0)
 ;;=3^Adhesive capsulitis of right shoulder
 ;;^UTILITY(U,$J,358.3,38845,1,4,0)
 ;;=4^M75.01
 ;;^UTILITY(U,$J,358.3,38845,2)
 ;;=^5013239
 ;;^UTILITY(U,$J,358.3,38846,0)
 ;;=M75.22^^180^1988^5
 ;;^UTILITY(U,$J,358.3,38846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38846,1,3,0)
 ;;=3^Bicipital tendinitis, left shoulder
 ;;^UTILITY(U,$J,358.3,38846,1,4,0)
 ;;=4^M75.22
