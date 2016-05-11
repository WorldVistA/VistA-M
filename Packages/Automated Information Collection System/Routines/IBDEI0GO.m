IBDEI0GO ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7710,1,4,0)
 ;;=4^R40.2212
 ;;^UTILITY(U,$J,358.3,7710,2)
 ;;=^5019377
 ;;^UTILITY(U,$J,358.3,7711,0)
 ;;=R40.2344^^30^414^6
 ;;^UTILITY(U,$J,358.3,7711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7711,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,24+ Hrs
 ;;^UTILITY(U,$J,358.3,7711,1,4,0)
 ;;=4^R40.2344
 ;;^UTILITY(U,$J,358.3,7711,2)
 ;;=^5019419
 ;;^UTILITY(U,$J,358.3,7712,0)
 ;;=R40.2343^^30^414^7
 ;;^UTILITY(U,$J,358.3,7712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7712,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,7712,1,4,0)
 ;;=4^R40.2343
 ;;^UTILITY(U,$J,358.3,7712,2)
 ;;=^5019418
 ;;^UTILITY(U,$J,358.3,7713,0)
 ;;=R40.2342^^30^414^8
 ;;^UTILITY(U,$J,358.3,7713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7713,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,Emger Dept
 ;;^UTILITY(U,$J,358.3,7713,1,4,0)
 ;;=4^R40.2342
 ;;^UTILITY(U,$J,358.3,7713,2)
 ;;=^5019417
 ;;^UTILITY(U,$J,358.3,7714,0)
 ;;=R40.2341^^30^414^9
 ;;^UTILITY(U,$J,358.3,7714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7714,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,in the Field
 ;;^UTILITY(U,$J,358.3,7714,1,4,0)
 ;;=4^R40.2341
 ;;^UTILITY(U,$J,358.3,7714,2)
 ;;=^5019416
 ;;^UTILITY(U,$J,358.3,7715,0)
 ;;=R40.2340^^30^414^10
 ;;^UTILITY(U,$J,358.3,7715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7715,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,Unspec Time
 ;;^UTILITY(U,$J,358.3,7715,1,4,0)
 ;;=4^R40.2340
 ;;^UTILITY(U,$J,358.3,7715,2)
 ;;=^5019415
 ;;^UTILITY(U,$J,358.3,7716,0)
 ;;=R40.2324^^30^414^1
 ;;^UTILITY(U,$J,358.3,7716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7716,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,24+ Hrs
 ;;^UTILITY(U,$J,358.3,7716,1,4,0)
 ;;=4^R40.2324
 ;;^UTILITY(U,$J,358.3,7716,2)
 ;;=^5019409
 ;;^UTILITY(U,$J,358.3,7717,0)
 ;;=R40.2323^^30^414^4
 ;;^UTILITY(U,$J,358.3,7717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7717,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,7717,1,4,0)
 ;;=4^R40.2323
 ;;^UTILITY(U,$J,358.3,7717,2)
 ;;=^5019408
 ;;^UTILITY(U,$J,358.3,7718,0)
 ;;=R40.2322^^30^414^2
 ;;^UTILITY(U,$J,358.3,7718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7718,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Emger Dept
 ;;^UTILITY(U,$J,358.3,7718,1,4,0)
 ;;=4^R40.2322
 ;;^UTILITY(U,$J,358.3,7718,2)
 ;;=^5019407
 ;;^UTILITY(U,$J,358.3,7719,0)
 ;;=R40.2321^^30^414^5
 ;;^UTILITY(U,$J,358.3,7719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7719,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,in the Field
 ;;^UTILITY(U,$J,358.3,7719,1,4,0)
 ;;=4^R40.2321
 ;;^UTILITY(U,$J,358.3,7719,2)
 ;;=^5019406
 ;;^UTILITY(U,$J,358.3,7720,0)
 ;;=R40.2320^^30^414^3
 ;;^UTILITY(U,$J,358.3,7720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7720,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Unspec Time
 ;;^UTILITY(U,$J,358.3,7720,1,4,0)
 ;;=4^R40.2320
 ;;^UTILITY(U,$J,358.3,7720,2)
 ;;=^5019405
 ;;^UTILITY(U,$J,358.3,7721,0)
 ;;=R40.2314^^30^414^11
 ;;^UTILITY(U,$J,358.3,7721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7721,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,24+ Hrs
 ;;^UTILITY(U,$J,358.3,7721,1,4,0)
 ;;=4^R40.2314
 ;;^UTILITY(U,$J,358.3,7721,2)
 ;;=^5019404
 ;;^UTILITY(U,$J,358.3,7722,0)
 ;;=R40.2313^^30^414^14
 ;;^UTILITY(U,$J,358.3,7722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7722,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,7722,1,4,0)
 ;;=4^R40.2313
