IBDEI10N ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17237,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,17237,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,17238,0)
 ;;=F03.90^^73^828^9
 ;;^UTILITY(U,$J,358.3,17238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17238,1,3,0)
 ;;=3^Dementia w/o behavioral disturbance, unspec
 ;;^UTILITY(U,$J,358.3,17238,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,17238,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,17239,0)
 ;;=F03.91^^73^828^8
 ;;^UTILITY(U,$J,358.3,17239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17239,1,3,0)
 ;;=3^Dementia w/ behavioral disturbances, unspec
 ;;^UTILITY(U,$J,358.3,17239,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,17239,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,17240,0)
 ;;=G30.9^^73^828^3
 ;;^UTILITY(U,$J,358.3,17240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17240,1,3,0)
 ;;=3^Alzheimer's disease w/ behavioral disturance, unspec
 ;;^UTILITY(U,$J,358.3,17240,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,17240,2)
 ;;=^5003808^F02.81
 ;;^UTILITY(U,$J,358.3,17241,0)
 ;;=G30.9^^73^828^4
 ;;^UTILITY(U,$J,358.3,17241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17241,1,3,0)
 ;;=3^Alzheimer's disease w/o behavioral disturbance, unspec
 ;;^UTILITY(U,$J,358.3,17241,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,17241,2)
 ;;=^5003808^F02.80
 ;;^UTILITY(U,$J,358.3,17242,0)
 ;;=G30.0^^73^828^1
 ;;^UTILITY(U,$J,358.3,17242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17242,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,17242,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,17242,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,17243,0)
 ;;=G30.1^^73^828^2
 ;;^UTILITY(U,$J,358.3,17243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17243,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,17243,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,17243,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,17244,0)
 ;;=F02.81^^73^828^6
 ;;^UTILITY(U,$J,358.3,17244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17244,1,3,0)
 ;;=3^Dementia in Diseases Classd Elswhr w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,17244,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,17244,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,17245,0)
 ;;=F02.80^^73^828^7
 ;;^UTILITY(U,$J,358.3,17245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17245,1,3,0)
 ;;=3^Dementia in Diseases Classd Elswhr w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,17245,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,17245,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,17246,0)
 ;;=F32.9^^73^829^3
 ;;^UTILITY(U,$J,358.3,17246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17246,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspec
 ;;^UTILITY(U,$J,358.3,17246,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,17246,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,17247,0)
 ;;=F33.9^^73^829^2
 ;;^UTILITY(U,$J,358.3,17247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17247,1,3,0)
 ;;=3^Major depressive disorder, recurrent, unspec
 ;;^UTILITY(U,$J,358.3,17247,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,17247,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,17248,0)
 ;;=F34.1^^73^829^1
 ;;^UTILITY(U,$J,358.3,17248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17248,1,3,0)
 ;;=3^Dysthymic disorder
 ;;^UTILITY(U,$J,358.3,17248,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,17248,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,17249,0)
 ;;=E87.70^^73^830^19
 ;;^UTILITY(U,$J,358.3,17249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17249,1,3,0)
 ;;=3^Fluid overload, unspec
 ;;^UTILITY(U,$J,358.3,17249,1,4,0)
 ;;=4^E87.70
 ;;^UTILITY(U,$J,358.3,17249,2)
 ;;=^5003023
 ;;^UTILITY(U,$J,358.3,17250,0)
 ;;=J43.9^^73^830^2
 ;;^UTILITY(U,$J,358.3,17250,1,0)
 ;;=^358.31IA^4^2
