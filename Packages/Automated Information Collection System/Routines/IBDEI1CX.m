IBDEI1CX ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21687,0)
 ;;=F05.^^99^1104^5
 ;;^UTILITY(U,$J,358.3,21687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21687,1,3,0)
 ;;=3^Delirium d/t known physiological condition
 ;;^UTILITY(U,$J,358.3,21687,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,21687,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,21688,0)
 ;;=F03.90^^99^1104^9
 ;;^UTILITY(U,$J,358.3,21688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21688,1,3,0)
 ;;=3^Dementia w/o behavioral disturbance, unspec
 ;;^UTILITY(U,$J,358.3,21688,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,21688,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,21689,0)
 ;;=F03.91^^99^1104^8
 ;;^UTILITY(U,$J,358.3,21689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21689,1,3,0)
 ;;=3^Dementia w/ behavioral disturbances, unspec
 ;;^UTILITY(U,$J,358.3,21689,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,21689,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,21690,0)
 ;;=G30.9^^99^1104^3
 ;;^UTILITY(U,$J,358.3,21690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21690,1,3,0)
 ;;=3^Alzheimer's disease w/ behavioral disturance, unspec
 ;;^UTILITY(U,$J,358.3,21690,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,21690,2)
 ;;=^5003808^F02.81
 ;;^UTILITY(U,$J,358.3,21691,0)
 ;;=G30.9^^99^1104^4
 ;;^UTILITY(U,$J,358.3,21691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21691,1,3,0)
 ;;=3^Alzheimer's disease w/o behavioral disturbance, unspec
 ;;^UTILITY(U,$J,358.3,21691,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,21691,2)
 ;;=^5003808^F02.80
 ;;^UTILITY(U,$J,358.3,21692,0)
 ;;=G30.0^^99^1104^1
 ;;^UTILITY(U,$J,358.3,21692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21692,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,21692,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,21692,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,21693,0)
 ;;=G30.1^^99^1104^2
 ;;^UTILITY(U,$J,358.3,21693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21693,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,21693,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,21693,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,21694,0)
 ;;=F02.81^^99^1104^6
 ;;^UTILITY(U,$J,358.3,21694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21694,1,3,0)
 ;;=3^Dementia in Diseases Classd Elswhr w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,21694,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,21694,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,21695,0)
 ;;=F02.80^^99^1104^7
 ;;^UTILITY(U,$J,358.3,21695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21695,1,3,0)
 ;;=3^Dementia in Diseases Classd Elswhr w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,21695,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,21695,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,21696,0)
 ;;=F01.51^^99^1104^10
 ;;^UTILITY(U,$J,358.3,21696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21696,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,21696,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,21696,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,21697,0)
 ;;=F01.50^^99^1104^11
 ;;^UTILITY(U,$J,358.3,21697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21697,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,21697,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,21697,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,21698,0)
 ;;=F32.9^^99^1105^3
 ;;^UTILITY(U,$J,358.3,21698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21698,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspec
