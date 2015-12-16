IBDEI04B ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1489,2)
 ;;=^5008367
 ;;^UTILITY(U,$J,358.3,1490,0)
 ;;=K76.81^^3^43^10
 ;;^UTILITY(U,$J,358.3,1490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1490,1,3,0)
 ;;=3^Hepatopulmonary syndrome
 ;;^UTILITY(U,$J,358.3,1490,1,4,0)
 ;;=4^K76.81
 ;;^UTILITY(U,$J,358.3,1490,2)
 ;;=^340555
 ;;^UTILITY(U,$J,358.3,1491,0)
 ;;=Z77.090^^3^43^6
 ;;^UTILITY(U,$J,358.3,1491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1491,1,3,0)
 ;;=3^Contact with and (suspected) exposure to asbestos
 ;;^UTILITY(U,$J,358.3,1491,1,4,0)
 ;;=4^Z77.090
 ;;^UTILITY(U,$J,358.3,1491,2)
 ;;=^5063312
 ;;^UTILITY(U,$J,358.3,1492,0)
 ;;=F03.90^^3^44^11
 ;;^UTILITY(U,$J,358.3,1492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1492,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,1492,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,1492,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,1493,0)
 ;;=F02.80^^3^44^9
 ;;^UTILITY(U,$J,358.3,1493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1493,1,3,0)
 ;;=3^Dementia in oth diseases classd elswhr w/o behavrl disturb
 ;;^UTILITY(U,$J,358.3,1493,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,1493,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,1494,0)
 ;;=F02.81^^3^44^10
 ;;^UTILITY(U,$J,358.3,1494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1494,1,3,0)
 ;;=3^Dementia in oth diseases classd elswhr w behavioral disturb
 ;;^UTILITY(U,$J,358.3,1494,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,1494,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,1495,0)
 ;;=F20.9^^3^44^25
 ;;^UTILITY(U,$J,358.3,1495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1495,1,3,0)
 ;;=3^Schizophrenia, unspecified
 ;;^UTILITY(U,$J,358.3,1495,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,1495,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,1496,0)
 ;;=F31.9^^3^44^7
 ;;^UTILITY(U,$J,358.3,1496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1496,1,3,0)
 ;;=3^Bipolar disorder, unspecified
 ;;^UTILITY(U,$J,358.3,1496,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,1496,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,1497,0)
 ;;=F41.9^^3^44^6
 ;;^UTILITY(U,$J,358.3,1497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1497,1,3,0)
 ;;=3^Anxiety disorder, unspecified
 ;;^UTILITY(U,$J,358.3,1497,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,1497,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,1498,0)
 ;;=F42.^^3^44^17
 ;;^UTILITY(U,$J,358.3,1498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1498,1,3,0)
 ;;=3^Obsessive-compulsive disorder
 ;;^UTILITY(U,$J,358.3,1498,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,1498,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,1499,0)
 ;;=F34.1^^3^44^12
 ;;^UTILITY(U,$J,358.3,1499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1499,1,3,0)
 ;;=3^Dysthymic disorder
 ;;^UTILITY(U,$J,358.3,1499,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,1499,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,1500,0)
 ;;=F45.0^^3^44^27
 ;;^UTILITY(U,$J,358.3,1500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1500,1,3,0)
 ;;=3^Somatization disorder
 ;;^UTILITY(U,$J,358.3,1500,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,1500,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,1501,0)
 ;;=F60.9^^3^44^22
 ;;^UTILITY(U,$J,358.3,1501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1501,1,3,0)
 ;;=3^Personality disorder, unspecified
 ;;^UTILITY(U,$J,358.3,1501,1,4,0)
 ;;=4^F60.9
 ;;^UTILITY(U,$J,358.3,1501,2)
 ;;=^5003639
 ;;^UTILITY(U,$J,358.3,1502,0)
 ;;=F52.21^^3^44^15
 ;;^UTILITY(U,$J,358.3,1502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1502,1,3,0)
 ;;=3^Male erectile disorder
 ;;^UTILITY(U,$J,358.3,1502,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,1502,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,1503,0)
 ;;=F10.20^^3^44^4
