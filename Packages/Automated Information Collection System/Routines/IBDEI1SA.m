IBDEI1SA ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31481,0)
 ;;=F10.20^^180^1958^1
 ;;^UTILITY(U,$J,358.3,31481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31481,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,31481,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,31481,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,31482,0)
 ;;=F31.10^^180^1958^2
 ;;^UTILITY(U,$J,358.3,31482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31482,1,3,0)
 ;;=3^Bipolar disord, crnt episode manic w/o psych features, unsp
 ;;^UTILITY(U,$J,358.3,31482,1,4,0)
 ;;=4^F31.10
 ;;^UTILITY(U,$J,358.3,31482,2)
 ;;=^5003495
 ;;^UTILITY(U,$J,358.3,31483,0)
 ;;=F32.9^^180^1958^5
 ;;^UTILITY(U,$J,358.3,31483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31483,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,31483,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,31483,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,31484,0)
 ;;=F20.0^^180^1958^6
 ;;^UTILITY(U,$J,358.3,31484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31484,1,3,0)
 ;;=3^Paranoid schizophrenia
 ;;^UTILITY(U,$J,358.3,31484,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,31484,2)
 ;;=^5003469
 ;;^UTILITY(U,$J,358.3,31485,0)
 ;;=F06.0^^180^1958^7
 ;;^UTILITY(U,$J,358.3,31485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31485,1,3,0)
 ;;=3^Psychotic disorder w hallucin due to known physiol condition
 ;;^UTILITY(U,$J,358.3,31485,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,31485,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,31486,0)
 ;;=F20.9^^180^1958^8
 ;;^UTILITY(U,$J,358.3,31486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31486,1,3,0)
 ;;=3^Schizophrenia, unspecified
 ;;^UTILITY(U,$J,358.3,31486,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,31486,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,31487,0)
 ;;=F03.91^^180^1958^3
 ;;^UTILITY(U,$J,358.3,31487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31487,1,3,0)
 ;;=3^Dementia with behavioral disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,31487,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,31487,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,31488,0)
 ;;=F03.90^^180^1958^4
 ;;^UTILITY(U,$J,358.3,31488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31488,1,3,0)
 ;;=3^Dementia without behavioral disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,31488,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,31488,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,31489,0)
 ;;=M76.62^^180^1959^1
 ;;^UTILITY(U,$J,358.3,31489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31489,1,3,0)
 ;;=3^Achilles tendinitis, left leg
 ;;^UTILITY(U,$J,358.3,31489,1,4,0)
 ;;=4^M76.62
 ;;^UTILITY(U,$J,358.3,31489,2)
 ;;=^5013286
 ;;^UTILITY(U,$J,358.3,31490,0)
 ;;=M76.61^^180^1959^2
 ;;^UTILITY(U,$J,358.3,31490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31490,1,3,0)
 ;;=3^Achilles tendinitis, right leg
 ;;^UTILITY(U,$J,358.3,31490,1,4,0)
 ;;=4^M76.61
 ;;^UTILITY(U,$J,358.3,31490,2)
 ;;=^5013285
 ;;^UTILITY(U,$J,358.3,31491,0)
 ;;=M75.02^^180^1959^3
 ;;^UTILITY(U,$J,358.3,31491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31491,1,3,0)
 ;;=3^Adhesive capsulitis of left shoulder
 ;;^UTILITY(U,$J,358.3,31491,1,4,0)
 ;;=4^M75.02
 ;;^UTILITY(U,$J,358.3,31491,2)
 ;;=^5013240
 ;;^UTILITY(U,$J,358.3,31492,0)
 ;;=M75.01^^180^1959^4
 ;;^UTILITY(U,$J,358.3,31492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31492,1,3,0)
 ;;=3^Adhesive capsulitis of right shoulder
 ;;^UTILITY(U,$J,358.3,31492,1,4,0)
 ;;=4^M75.01
 ;;^UTILITY(U,$J,358.3,31492,2)
 ;;=^5013239
 ;;^UTILITY(U,$J,358.3,31493,0)
 ;;=Z47.1^^180^1959^5
 ;;^UTILITY(U,$J,358.3,31493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31493,1,3,0)
 ;;=3^Aftercare following joint replacement surgery
