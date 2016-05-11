IBDEI0ZN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16759,1,4,0)
 ;;=4^R06.00
 ;;^UTILITY(U,$J,358.3,16759,2)
 ;;=^5019180
 ;;^UTILITY(U,$J,358.3,16760,0)
 ;;=R13.10^^70^787^6
 ;;^UTILITY(U,$J,358.3,16760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16760,1,3,0)
 ;;=3^Dysphagia, unspec
 ;;^UTILITY(U,$J,358.3,16760,1,4,0)
 ;;=4^R13.10
 ;;^UTILITY(U,$J,358.3,16760,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,16761,0)
 ;;=R19.7^^70^787^3
 ;;^UTILITY(U,$J,358.3,16761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16761,1,3,0)
 ;;=3^Diarrhea, unspec
 ;;^UTILITY(U,$J,358.3,16761,1,4,0)
 ;;=4^R19.7
 ;;^UTILITY(U,$J,358.3,16761,2)
 ;;=^5019276
 ;;^UTILITY(U,$J,358.3,16762,0)
 ;;=F05.^^70^788^5
 ;;^UTILITY(U,$J,358.3,16762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16762,1,3,0)
 ;;=3^Delirium d/t known physiological condition
 ;;^UTILITY(U,$J,358.3,16762,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,16762,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,16763,0)
 ;;=F03.90^^70^788^9
 ;;^UTILITY(U,$J,358.3,16763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16763,1,3,0)
 ;;=3^Dementia w/o behavioral disturbance, unspec
 ;;^UTILITY(U,$J,358.3,16763,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,16763,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,16764,0)
 ;;=F03.91^^70^788^8
 ;;^UTILITY(U,$J,358.3,16764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16764,1,3,0)
 ;;=3^Dementia w/ behavioral disturbances, unspec
 ;;^UTILITY(U,$J,358.3,16764,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,16764,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,16765,0)
 ;;=G30.9^^70^788^3
 ;;^UTILITY(U,$J,358.3,16765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16765,1,3,0)
 ;;=3^Alzheimer's disease w/ behavioral disturance, unspec
 ;;^UTILITY(U,$J,358.3,16765,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,16765,2)
 ;;=^5003808^F02.81
 ;;^UTILITY(U,$J,358.3,16766,0)
 ;;=G30.9^^70^788^4
 ;;^UTILITY(U,$J,358.3,16766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16766,1,3,0)
 ;;=3^Alzheimer's disease w/o behavioral disturbance, unspec
 ;;^UTILITY(U,$J,358.3,16766,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,16766,2)
 ;;=^5003808^F02.80
 ;;^UTILITY(U,$J,358.3,16767,0)
 ;;=G30.0^^70^788^1
 ;;^UTILITY(U,$J,358.3,16767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16767,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,16767,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,16767,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,16768,0)
 ;;=G30.1^^70^788^2
 ;;^UTILITY(U,$J,358.3,16768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16768,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,16768,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,16768,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,16769,0)
 ;;=F02.81^^70^788^6
 ;;^UTILITY(U,$J,358.3,16769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16769,1,3,0)
 ;;=3^Dementia in Diseases Classd Elswhr w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,16769,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,16769,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,16770,0)
 ;;=F02.80^^70^788^7
 ;;^UTILITY(U,$J,358.3,16770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16770,1,3,0)
 ;;=3^Dementia in Diseases Classd Elswhr w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,16770,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,16770,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,16771,0)
 ;;=F32.9^^70^789^3
 ;;^UTILITY(U,$J,358.3,16771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16771,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspec
 ;;^UTILITY(U,$J,358.3,16771,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,16771,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,16772,0)
 ;;=F33.9^^70^789^2
 ;;^UTILITY(U,$J,358.3,16772,1,0)
 ;;=^358.31IA^4^2
