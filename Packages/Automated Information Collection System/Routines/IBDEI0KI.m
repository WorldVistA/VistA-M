IBDEI0KI ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9226,1,4,0)
 ;;=4^M20.41
 ;;^UTILITY(U,$J,358.3,9226,2)
 ;;=^5011051
 ;;^UTILITY(U,$J,358.3,9227,0)
 ;;=M48.061^^39^407^176
 ;;^UTILITY(U,$J,358.3,9227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9227,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/o Neurogenic Caludication
 ;;^UTILITY(U,$J,358.3,9227,1,4,0)
 ;;=4^M48.061
 ;;^UTILITY(U,$J,358.3,9227,2)
 ;;=^5151513
 ;;^UTILITY(U,$J,358.3,9228,0)
 ;;=M48.062^^39^407^175
 ;;^UTILITY(U,$J,358.3,9228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9228,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/ Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,9228,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,9228,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,9229,0)
 ;;=M79.10^^39^407^65
 ;;^UTILITY(U,$J,358.3,9229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9229,1,3,0)
 ;;=3^Myalgia,Unspec Site
 ;;^UTILITY(U,$J,358.3,9229,1,4,0)
 ;;=4^M79.10
 ;;^UTILITY(U,$J,358.3,9229,2)
 ;;=^5157394
 ;;^UTILITY(U,$J,358.3,9230,0)
 ;;=M54.50^^39^407^61
 ;;^UTILITY(U,$J,358.3,9230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9230,1,3,0)
 ;;=3^Low Back Pain,Unspec
 ;;^UTILITY(U,$J,358.3,9230,1,4,0)
 ;;=4^M54.50
 ;;^UTILITY(U,$J,358.3,9230,2)
 ;;=^5161215
 ;;^UTILITY(U,$J,358.3,9231,0)
 ;;=B02.0^^39^408^47
 ;;^UTILITY(U,$J,358.3,9231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9231,1,3,0)
 ;;=3^Zoster Encephalitis
 ;;^UTILITY(U,$J,358.3,9231,1,4,0)
 ;;=4^B02.0
 ;;^UTILITY(U,$J,358.3,9231,2)
 ;;=^5000488
 ;;^UTILITY(U,$J,358.3,9232,0)
 ;;=B02.29^^39^408^37
 ;;^UTILITY(U,$J,358.3,9232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9232,1,3,0)
 ;;=3^Postherpetic Nervous System Involvement,Other
 ;;^UTILITY(U,$J,358.3,9232,1,4,0)
 ;;=4^B02.29
 ;;^UTILITY(U,$J,358.3,9232,2)
 ;;=^5000492
 ;;^UTILITY(U,$J,358.3,9233,0)
 ;;=F03.90^^39^408^11
 ;;^UTILITY(U,$J,358.3,9233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9233,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,9233,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,9233,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,9234,0)
 ;;=F03.91^^39^408^10
 ;;^UTILITY(U,$J,358.3,9234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9234,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,9234,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,9234,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,9235,0)
 ;;=F01.50^^39^408^13
 ;;^UTILITY(U,$J,358.3,9235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9235,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,9235,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,9235,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,9236,0)
 ;;=F10.27^^39^408^12
 ;;^UTILITY(U,$J,358.3,9236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9236,1,3,0)
 ;;=3^Dementia,Alcohol-Induced/Persist w/ Alcohol Dependence
 ;;^UTILITY(U,$J,358.3,9236,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,9236,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,9237,0)
 ;;=F06.1^^39^408^7
 ;;^UTILITY(U,$J,358.3,9237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9237,1,3,0)
 ;;=3^Catatonic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,9237,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,9237,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,9238,0)
 ;;=F06.8^^39^408^22
 ;;^UTILITY(U,$J,358.3,9238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9238,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition,Other
 ;;^UTILITY(U,$J,358.3,9238,1,4,0)
 ;;=4^F06.8
