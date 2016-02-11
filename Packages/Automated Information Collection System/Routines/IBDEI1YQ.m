IBDEI1YQ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32867,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,32867,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,32868,0)
 ;;=G20.^^146^1585^29
 ;;^UTILITY(U,$J,358.3,32868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32868,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,32868,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,32868,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,32869,0)
 ;;=G23.1^^146^1585^34
 ;;^UTILITY(U,$J,358.3,32869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32869,1,3,0)
 ;;=3^Progressive Supranuclear Palsy
 ;;^UTILITY(U,$J,358.3,32869,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,32869,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,32870,0)
 ;;=F03.91^^146^1585^15
 ;;^UTILITY(U,$J,358.3,32870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32870,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,32870,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,32870,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,32871,0)
 ;;=F03.90^^146^1585^17
 ;;^UTILITY(U,$J,358.3,32871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32871,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,32871,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,32871,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,32872,0)
 ;;=F06.30^^146^1586^2
 ;;^UTILITY(U,$J,358.3,32872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32872,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,32872,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,32872,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,32873,0)
 ;;=F06.31^^146^1586^3
 ;;^UTILITY(U,$J,358.3,32873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32873,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,32873,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,32873,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,32874,0)
 ;;=F06.32^^146^1586^4
 ;;^UTILITY(U,$J,358.3,32874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32874,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,32874,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,32874,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,32875,0)
 ;;=F32.9^^146^1586^14
 ;;^UTILITY(U,$J,358.3,32875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32875,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,32875,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,32875,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,32876,0)
 ;;=F32.0^^146^1586^15
 ;;^UTILITY(U,$J,358.3,32876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32876,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,32876,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,32876,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,32877,0)
 ;;=F32.1^^146^1586^16
 ;;^UTILITY(U,$J,358.3,32877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32877,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,32877,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,32877,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,32878,0)
 ;;=F32.2^^146^1586^17
 ;;^UTILITY(U,$J,358.3,32878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32878,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,32878,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,32878,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,32879,0)
 ;;=F32.3^^146^1586^18
 ;;^UTILITY(U,$J,358.3,32879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32879,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode w Psychotic Features
