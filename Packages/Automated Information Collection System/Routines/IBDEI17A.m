IBDEI17A ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19283,1,4,0)
 ;;=4^M75.01
 ;;^UTILITY(U,$J,358.3,19283,2)
 ;;=^5013239
 ;;^UTILITY(U,$J,358.3,19284,0)
 ;;=M81.0^^93^992^5
 ;;^UTILITY(U,$J,358.3,19284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19284,1,3,0)
 ;;=3^Age-related osteoporosis w/o current pathological fracture
 ;;^UTILITY(U,$J,358.3,19284,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,19284,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,19285,0)
 ;;=M75.22^^93^992^6
 ;;^UTILITY(U,$J,358.3,19285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19285,1,3,0)
 ;;=3^Bicipital tendinitis, left shoulder
 ;;^UTILITY(U,$J,358.3,19285,1,4,0)
 ;;=4^M75.22
 ;;^UTILITY(U,$J,358.3,19285,2)
 ;;=^5013252
 ;;^UTILITY(U,$J,358.3,19286,0)
 ;;=M75.21^^93^992^7
 ;;^UTILITY(U,$J,358.3,19286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19286,1,3,0)
 ;;=3^Bicipital tendinitis, right shoulder
 ;;^UTILITY(U,$J,358.3,19286,1,4,0)
 ;;=4^M75.21
 ;;^UTILITY(U,$J,358.3,19286,2)
 ;;=^5013251
 ;;^UTILITY(U,$J,358.3,19287,0)
 ;;=M17.0^^93^992^77
 ;;^UTILITY(U,$J,358.3,19287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19287,1,3,0)
 ;;=3^Prim Osteoarth,Knee,Bilateral
 ;;^UTILITY(U,$J,358.3,19287,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,19287,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,19288,0)
 ;;=M75.52^^93^992^10
 ;;^UTILITY(U,$J,358.3,19288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19288,1,3,0)
 ;;=3^Bursitis of left shoulder
 ;;^UTILITY(U,$J,358.3,19288,1,4,0)
 ;;=4^M75.52
 ;;^UTILITY(U,$J,358.3,19288,2)
 ;;=^5133691
 ;;^UTILITY(U,$J,358.3,19289,0)
 ;;=M75.51^^93^992^11
 ;;^UTILITY(U,$J,358.3,19289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19289,1,3,0)
 ;;=3^Bursitis of right shoulder
 ;;^UTILITY(U,$J,358.3,19289,1,4,0)
 ;;=4^M75.51
 ;;^UTILITY(U,$J,358.3,19289,2)
 ;;=^5133690
 ;;^UTILITY(U,$J,358.3,19290,0)
 ;;=M75.32^^93^992^12
 ;;^UTILITY(U,$J,358.3,19290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19290,1,3,0)
 ;;=3^Calcific tendinitis of left shoulder
 ;;^UTILITY(U,$J,358.3,19290,1,4,0)
 ;;=4^M75.32
 ;;^UTILITY(U,$J,358.3,19290,2)
 ;;=^5013255
 ;;^UTILITY(U,$J,358.3,19291,0)
 ;;=M75.31^^93^992^13
 ;;^UTILITY(U,$J,358.3,19291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19291,1,3,0)
 ;;=3^Calcific tendinitis of right shoulder
 ;;^UTILITY(U,$J,358.3,19291,1,4,0)
 ;;=4^M75.31
 ;;^UTILITY(U,$J,358.3,19291,2)
 ;;=^5013254
 ;;^UTILITY(U,$J,358.3,19292,0)
 ;;=M22.42^^93^992^14
 ;;^UTILITY(U,$J,358.3,19292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19292,1,3,0)
 ;;=3^Chondromalacia patellae, left knee
 ;;^UTILITY(U,$J,358.3,19292,1,4,0)
 ;;=4^M22.42
 ;;^UTILITY(U,$J,358.3,19292,2)
 ;;=^5011187
 ;;^UTILITY(U,$J,358.3,19293,0)
 ;;=M22.41^^93^992^15
 ;;^UTILITY(U,$J,358.3,19293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19293,1,3,0)
 ;;=3^Chondromalacia patellae, right knee
 ;;^UTILITY(U,$J,358.3,19293,1,4,0)
 ;;=4^M22.41
 ;;^UTILITY(U,$J,358.3,19293,2)
 ;;=^5011186
 ;;^UTILITY(U,$J,358.3,19294,0)
 ;;=M62.472^^93^992^16
 ;;^UTILITY(U,$J,358.3,19294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19294,1,3,0)
 ;;=3^Contracture of muscle, left ankle and foot
 ;;^UTILITY(U,$J,358.3,19294,1,4,0)
 ;;=4^M62.472
 ;;^UTILITY(U,$J,358.3,19294,2)
 ;;=^5012651
 ;;^UTILITY(U,$J,358.3,19295,0)
 ;;=M62.432^^93^992^17
 ;;^UTILITY(U,$J,358.3,19295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19295,1,3,0)
 ;;=3^Contracture of muscle, left forearm
 ;;^UTILITY(U,$J,358.3,19295,1,4,0)
 ;;=4^M62.432
