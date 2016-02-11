IBDEI2PP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45511,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,24+ Hrs
 ;;^UTILITY(U,$J,358.3,45511,1,4,0)
 ;;=4^R40.2344
 ;;^UTILITY(U,$J,358.3,45511,2)
 ;;=^5019419
 ;;^UTILITY(U,$J,358.3,45512,0)
 ;;=R40.2343^^200^2246^7
 ;;^UTILITY(U,$J,358.3,45512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45512,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,45512,1,4,0)
 ;;=4^R40.2343
 ;;^UTILITY(U,$J,358.3,45512,2)
 ;;=^5019418
 ;;^UTILITY(U,$J,358.3,45513,0)
 ;;=R40.2342^^200^2246^8
 ;;^UTILITY(U,$J,358.3,45513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45513,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,Emger Dept
 ;;^UTILITY(U,$J,358.3,45513,1,4,0)
 ;;=4^R40.2342
 ;;^UTILITY(U,$J,358.3,45513,2)
 ;;=^5019417
 ;;^UTILITY(U,$J,358.3,45514,0)
 ;;=R40.2341^^200^2246^9
 ;;^UTILITY(U,$J,358.3,45514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45514,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,in the Field
 ;;^UTILITY(U,$J,358.3,45514,1,4,0)
 ;;=4^R40.2341
 ;;^UTILITY(U,$J,358.3,45514,2)
 ;;=^5019416
 ;;^UTILITY(U,$J,358.3,45515,0)
 ;;=R40.2340^^200^2246^10
 ;;^UTILITY(U,$J,358.3,45515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45515,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,Unspec Time
 ;;^UTILITY(U,$J,358.3,45515,1,4,0)
 ;;=4^R40.2340
 ;;^UTILITY(U,$J,358.3,45515,2)
 ;;=^5019415
 ;;^UTILITY(U,$J,358.3,45516,0)
 ;;=R40.2324^^200^2246^1
 ;;^UTILITY(U,$J,358.3,45516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45516,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,24+ Hrs
 ;;^UTILITY(U,$J,358.3,45516,1,4,0)
 ;;=4^R40.2324
 ;;^UTILITY(U,$J,358.3,45516,2)
 ;;=^5019409
 ;;^UTILITY(U,$J,358.3,45517,0)
 ;;=R40.2323^^200^2246^4
 ;;^UTILITY(U,$J,358.3,45517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45517,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,45517,1,4,0)
 ;;=4^R40.2323
 ;;^UTILITY(U,$J,358.3,45517,2)
 ;;=^5019408
 ;;^UTILITY(U,$J,358.3,45518,0)
 ;;=R40.2322^^200^2246^2
 ;;^UTILITY(U,$J,358.3,45518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45518,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Emger Dept
 ;;^UTILITY(U,$J,358.3,45518,1,4,0)
 ;;=4^R40.2322
 ;;^UTILITY(U,$J,358.3,45518,2)
 ;;=^5019407
 ;;^UTILITY(U,$J,358.3,45519,0)
 ;;=R40.2321^^200^2246^5
 ;;^UTILITY(U,$J,358.3,45519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45519,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,in the Field
 ;;^UTILITY(U,$J,358.3,45519,1,4,0)
 ;;=4^R40.2321
 ;;^UTILITY(U,$J,358.3,45519,2)
 ;;=^5019406
 ;;^UTILITY(U,$J,358.3,45520,0)
 ;;=R40.2320^^200^2246^3
 ;;^UTILITY(U,$J,358.3,45520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45520,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Unspec Time
 ;;^UTILITY(U,$J,358.3,45520,1,4,0)
 ;;=4^R40.2320
 ;;^UTILITY(U,$J,358.3,45520,2)
 ;;=^5019405
 ;;^UTILITY(U,$J,358.3,45521,0)
 ;;=R40.2314^^200^2246^11
 ;;^UTILITY(U,$J,358.3,45521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45521,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,24+ Hrs
 ;;^UTILITY(U,$J,358.3,45521,1,4,0)
 ;;=4^R40.2314
 ;;^UTILITY(U,$J,358.3,45521,2)
 ;;=^5019404
 ;;^UTILITY(U,$J,358.3,45522,0)
 ;;=R40.2313^^200^2246^14
 ;;^UTILITY(U,$J,358.3,45522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45522,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,45522,1,4,0)
 ;;=4^R40.2313
 ;;^UTILITY(U,$J,358.3,45522,2)
 ;;=^5019403
 ;;^UTILITY(U,$J,358.3,45523,0)
 ;;=R40.2312^^200^2246^12
