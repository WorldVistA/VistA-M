IBDEI2CT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39530,1,4,0)
 ;;=4^S02.402S
 ;;^UTILITY(U,$J,358.3,39530,2)
 ;;=^5020335
 ;;^UTILITY(U,$J,358.3,39531,0)
 ;;=F10.20^^183^2025^1
 ;;^UTILITY(U,$J,358.3,39531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39531,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,39531,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,39531,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,39532,0)
 ;;=F31.10^^183^2025^2
 ;;^UTILITY(U,$J,358.3,39532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39532,1,3,0)
 ;;=3^Bipolar disord, crnt episode manic w/o psych features, unsp
 ;;^UTILITY(U,$J,358.3,39532,1,4,0)
 ;;=4^F31.10
 ;;^UTILITY(U,$J,358.3,39532,2)
 ;;=^5003495
 ;;^UTILITY(U,$J,358.3,39533,0)
 ;;=F32.9^^183^2025^5
 ;;^UTILITY(U,$J,358.3,39533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39533,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,39533,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,39533,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,39534,0)
 ;;=F20.0^^183^2025^6
 ;;^UTILITY(U,$J,358.3,39534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39534,1,3,0)
 ;;=3^Paranoid schizophrenia
 ;;^UTILITY(U,$J,358.3,39534,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,39534,2)
 ;;=^5003469
 ;;^UTILITY(U,$J,358.3,39535,0)
 ;;=F06.0^^183^2025^7
 ;;^UTILITY(U,$J,358.3,39535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39535,1,3,0)
 ;;=3^Psychotic disorder w hallucin due to known physiol condition
 ;;^UTILITY(U,$J,358.3,39535,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,39535,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,39536,0)
 ;;=F20.9^^183^2025^8
 ;;^UTILITY(U,$J,358.3,39536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39536,1,3,0)
 ;;=3^Schizophrenia, unspecified
 ;;^UTILITY(U,$J,358.3,39536,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,39536,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,39537,0)
 ;;=F03.91^^183^2025^3
 ;;^UTILITY(U,$J,358.3,39537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39537,1,3,0)
 ;;=3^Dementia with behavioral disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,39537,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,39537,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,39538,0)
 ;;=F03.90^^183^2025^4
 ;;^UTILITY(U,$J,358.3,39538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39538,1,3,0)
 ;;=3^Dementia without behavioral disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,39538,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,39538,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,39539,0)
 ;;=M76.62^^183^2026^1
 ;;^UTILITY(U,$J,358.3,39539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39539,1,3,0)
 ;;=3^Achilles tendinitis, left leg
 ;;^UTILITY(U,$J,358.3,39539,1,4,0)
 ;;=4^M76.62
 ;;^UTILITY(U,$J,358.3,39539,2)
 ;;=^5013286
 ;;^UTILITY(U,$J,358.3,39540,0)
 ;;=M76.61^^183^2026^2
 ;;^UTILITY(U,$J,358.3,39540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39540,1,3,0)
 ;;=3^Achilles tendinitis, right leg
 ;;^UTILITY(U,$J,358.3,39540,1,4,0)
 ;;=4^M76.61
 ;;^UTILITY(U,$J,358.3,39540,2)
 ;;=^5013285
 ;;^UTILITY(U,$J,358.3,39541,0)
 ;;=M75.02^^183^2026^3
 ;;^UTILITY(U,$J,358.3,39541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39541,1,3,0)
 ;;=3^Adhesive capsulitis of left shoulder
 ;;^UTILITY(U,$J,358.3,39541,1,4,0)
 ;;=4^M75.02
 ;;^UTILITY(U,$J,358.3,39541,2)
 ;;=^5013240
 ;;^UTILITY(U,$J,358.3,39542,0)
 ;;=M75.01^^183^2026^4
 ;;^UTILITY(U,$J,358.3,39542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39542,1,3,0)
 ;;=3^Adhesive capsulitis of right shoulder
 ;;^UTILITY(U,$J,358.3,39542,1,4,0)
 ;;=4^M75.01
 ;;^UTILITY(U,$J,358.3,39542,2)
 ;;=^5013239
 ;;^UTILITY(U,$J,358.3,39543,0)
 ;;=M75.22^^183^2026^5
 ;;^UTILITY(U,$J,358.3,39543,1,0)
 ;;=^358.31IA^4^2
