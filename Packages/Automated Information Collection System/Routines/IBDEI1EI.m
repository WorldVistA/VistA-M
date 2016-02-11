IBDEI1EI ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23382,1,3,0)
 ;;=3^Dizziness & giddiness
 ;;^UTILITY(U,$J,358.3,23382,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,23382,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,23383,0)
 ;;=R06.00^^113^1125^7
 ;;^UTILITY(U,$J,358.3,23383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23383,1,3,0)
 ;;=3^Dyspnea, unspec
 ;;^UTILITY(U,$J,358.3,23383,1,4,0)
 ;;=4^R06.00
 ;;^UTILITY(U,$J,358.3,23383,2)
 ;;=^5019180
 ;;^UTILITY(U,$J,358.3,23384,0)
 ;;=R13.10^^113^1125^6
 ;;^UTILITY(U,$J,358.3,23384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23384,1,3,0)
 ;;=3^Dysphagia, unspec
 ;;^UTILITY(U,$J,358.3,23384,1,4,0)
 ;;=4^R13.10
 ;;^UTILITY(U,$J,358.3,23384,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,23385,0)
 ;;=R19.7^^113^1125^3
 ;;^UTILITY(U,$J,358.3,23385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23385,1,3,0)
 ;;=3^Diarrhea, unspec
 ;;^UTILITY(U,$J,358.3,23385,1,4,0)
 ;;=4^R19.7
 ;;^UTILITY(U,$J,358.3,23385,2)
 ;;=^5019276
 ;;^UTILITY(U,$J,358.3,23386,0)
 ;;=F05.^^113^1126^5
 ;;^UTILITY(U,$J,358.3,23386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23386,1,3,0)
 ;;=3^Delirium d/t known physiological condition
 ;;^UTILITY(U,$J,358.3,23386,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,23386,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,23387,0)
 ;;=F03.90^^113^1126^9
 ;;^UTILITY(U,$J,358.3,23387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23387,1,3,0)
 ;;=3^Dementia w/o behavioral disturbance, unspec
 ;;^UTILITY(U,$J,358.3,23387,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,23387,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,23388,0)
 ;;=F03.91^^113^1126^8
 ;;^UTILITY(U,$J,358.3,23388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23388,1,3,0)
 ;;=3^Dementia w/ behavioral disturbances, unspec
 ;;^UTILITY(U,$J,358.3,23388,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,23388,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,23389,0)
 ;;=G30.9^^113^1126^3
 ;;^UTILITY(U,$J,358.3,23389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23389,1,3,0)
 ;;=3^Alzheimer's disease w/ behavioral disturance, unspec
 ;;^UTILITY(U,$J,358.3,23389,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,23389,2)
 ;;=^5003808^F02.81
 ;;^UTILITY(U,$J,358.3,23390,0)
 ;;=G30.9^^113^1126^4
 ;;^UTILITY(U,$J,358.3,23390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23390,1,3,0)
 ;;=3^Alzheimer's disease w/o behavioral disturbance, unspec
 ;;^UTILITY(U,$J,358.3,23390,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,23390,2)
 ;;=^5003808^F02.80
 ;;^UTILITY(U,$J,358.3,23391,0)
 ;;=G30.0^^113^1126^1
 ;;^UTILITY(U,$J,358.3,23391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23391,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,23391,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,23391,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,23392,0)
 ;;=G30.1^^113^1126^2
 ;;^UTILITY(U,$J,358.3,23392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23392,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,23392,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,23392,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,23393,0)
 ;;=F02.81^^113^1126^6
 ;;^UTILITY(U,$J,358.3,23393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23393,1,3,0)
 ;;=3^Dementia in Diseases Classd Elswhr w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,23393,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,23393,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,23394,0)
 ;;=F02.80^^113^1126^7
 ;;^UTILITY(U,$J,358.3,23394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23394,1,3,0)
 ;;=3^Dementia in Diseases Classd Elswhr w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,23394,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,23394,2)
 ;;=^5003048
