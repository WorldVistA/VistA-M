IBDEI0PX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11875,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,11875,1,4,0)
 ;;=4^R40.2343
 ;;^UTILITY(U,$J,358.3,11875,2)
 ;;=^5019418
 ;;^UTILITY(U,$J,358.3,11876,0)
 ;;=R40.2342^^68^693^8
 ;;^UTILITY(U,$J,358.3,11876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11876,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,Emger Dept
 ;;^UTILITY(U,$J,358.3,11876,1,4,0)
 ;;=4^R40.2342
 ;;^UTILITY(U,$J,358.3,11876,2)
 ;;=^5019417
 ;;^UTILITY(U,$J,358.3,11877,0)
 ;;=R40.2341^^68^693^9
 ;;^UTILITY(U,$J,358.3,11877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11877,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,in the Field
 ;;^UTILITY(U,$J,358.3,11877,1,4,0)
 ;;=4^R40.2341
 ;;^UTILITY(U,$J,358.3,11877,2)
 ;;=^5019416
 ;;^UTILITY(U,$J,358.3,11878,0)
 ;;=R40.2340^^68^693^10
 ;;^UTILITY(U,$J,358.3,11878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11878,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,Unspec Time
 ;;^UTILITY(U,$J,358.3,11878,1,4,0)
 ;;=4^R40.2340
 ;;^UTILITY(U,$J,358.3,11878,2)
 ;;=^5019415
 ;;^UTILITY(U,$J,358.3,11879,0)
 ;;=R40.2324^^68^693^1
 ;;^UTILITY(U,$J,358.3,11879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11879,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,24+ Hrs
 ;;^UTILITY(U,$J,358.3,11879,1,4,0)
 ;;=4^R40.2324
 ;;^UTILITY(U,$J,358.3,11879,2)
 ;;=^5019409
 ;;^UTILITY(U,$J,358.3,11880,0)
 ;;=R40.2323^^68^693^4
 ;;^UTILITY(U,$J,358.3,11880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11880,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,11880,1,4,0)
 ;;=4^R40.2323
 ;;^UTILITY(U,$J,358.3,11880,2)
 ;;=^5019408
 ;;^UTILITY(U,$J,358.3,11881,0)
 ;;=R40.2322^^68^693^2
 ;;^UTILITY(U,$J,358.3,11881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11881,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Emger Dept
 ;;^UTILITY(U,$J,358.3,11881,1,4,0)
 ;;=4^R40.2322
 ;;^UTILITY(U,$J,358.3,11881,2)
 ;;=^5019407
 ;;^UTILITY(U,$J,358.3,11882,0)
 ;;=R40.2321^^68^693^5
 ;;^UTILITY(U,$J,358.3,11882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11882,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,in the Field
 ;;^UTILITY(U,$J,358.3,11882,1,4,0)
 ;;=4^R40.2321
 ;;^UTILITY(U,$J,358.3,11882,2)
 ;;=^5019406
 ;;^UTILITY(U,$J,358.3,11883,0)
 ;;=R40.2320^^68^693^3
 ;;^UTILITY(U,$J,358.3,11883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11883,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Unspec Time
 ;;^UTILITY(U,$J,358.3,11883,1,4,0)
 ;;=4^R40.2320
 ;;^UTILITY(U,$J,358.3,11883,2)
 ;;=^5019405
 ;;^UTILITY(U,$J,358.3,11884,0)
 ;;=R40.2314^^68^693^11
 ;;^UTILITY(U,$J,358.3,11884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11884,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,24+ Hrs
 ;;^UTILITY(U,$J,358.3,11884,1,4,0)
 ;;=4^R40.2314
 ;;^UTILITY(U,$J,358.3,11884,2)
 ;;=^5019404
 ;;^UTILITY(U,$J,358.3,11885,0)
 ;;=R40.2313^^68^693^14
 ;;^UTILITY(U,$J,358.3,11885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11885,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,11885,1,4,0)
 ;;=4^R40.2313
 ;;^UTILITY(U,$J,358.3,11885,2)
 ;;=^5019403
 ;;^UTILITY(U,$J,358.3,11886,0)
 ;;=R40.2312^^68^693^12
 ;;^UTILITY(U,$J,358.3,11886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11886,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Emerg Dept
 ;;^UTILITY(U,$J,358.3,11886,1,4,0)
 ;;=4^R40.2312
 ;;^UTILITY(U,$J,358.3,11886,2)
 ;;=^5019402
 ;;^UTILITY(U,$J,358.3,11887,0)
 ;;=R40.2311^^68^693^15
 ;;^UTILITY(U,$J,358.3,11887,1,0)
 ;;=^358.31IA^4^2
