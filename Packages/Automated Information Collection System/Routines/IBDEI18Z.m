IBDEI18Z ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21204,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,21204,1,4,0)
 ;;=4^R40.2343
 ;;^UTILITY(U,$J,358.3,21204,2)
 ;;=^5019418
 ;;^UTILITY(U,$J,358.3,21205,0)
 ;;=R40.2342^^84^947^8
 ;;^UTILITY(U,$J,358.3,21205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21205,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,Emger Dept
 ;;^UTILITY(U,$J,358.3,21205,1,4,0)
 ;;=4^R40.2342
 ;;^UTILITY(U,$J,358.3,21205,2)
 ;;=^5019417
 ;;^UTILITY(U,$J,358.3,21206,0)
 ;;=R40.2341^^84^947^9
 ;;^UTILITY(U,$J,358.3,21206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21206,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,in the Field
 ;;^UTILITY(U,$J,358.3,21206,1,4,0)
 ;;=4^R40.2341
 ;;^UTILITY(U,$J,358.3,21206,2)
 ;;=^5019416
 ;;^UTILITY(U,$J,358.3,21207,0)
 ;;=R40.2340^^84^947^10
 ;;^UTILITY(U,$J,358.3,21207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21207,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,Unspec Time
 ;;^UTILITY(U,$J,358.3,21207,1,4,0)
 ;;=4^R40.2340
 ;;^UTILITY(U,$J,358.3,21207,2)
 ;;=^5019415
 ;;^UTILITY(U,$J,358.3,21208,0)
 ;;=R40.2324^^84^947^1
 ;;^UTILITY(U,$J,358.3,21208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21208,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,24+ Hrs
 ;;^UTILITY(U,$J,358.3,21208,1,4,0)
 ;;=4^R40.2324
 ;;^UTILITY(U,$J,358.3,21208,2)
 ;;=^5019409
 ;;^UTILITY(U,$J,358.3,21209,0)
 ;;=R40.2323^^84^947^4
 ;;^UTILITY(U,$J,358.3,21209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21209,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,21209,1,4,0)
 ;;=4^R40.2323
 ;;^UTILITY(U,$J,358.3,21209,2)
 ;;=^5019408
 ;;^UTILITY(U,$J,358.3,21210,0)
 ;;=R40.2322^^84^947^2
 ;;^UTILITY(U,$J,358.3,21210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21210,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Emger Dept
 ;;^UTILITY(U,$J,358.3,21210,1,4,0)
 ;;=4^R40.2322
 ;;^UTILITY(U,$J,358.3,21210,2)
 ;;=^5019407
 ;;^UTILITY(U,$J,358.3,21211,0)
 ;;=R40.2321^^84^947^5
 ;;^UTILITY(U,$J,358.3,21211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21211,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,in the Field
 ;;^UTILITY(U,$J,358.3,21211,1,4,0)
 ;;=4^R40.2321
 ;;^UTILITY(U,$J,358.3,21211,2)
 ;;=^5019406
 ;;^UTILITY(U,$J,358.3,21212,0)
 ;;=R40.2320^^84^947^3
 ;;^UTILITY(U,$J,358.3,21212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21212,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Unspec Time
 ;;^UTILITY(U,$J,358.3,21212,1,4,0)
 ;;=4^R40.2320
 ;;^UTILITY(U,$J,358.3,21212,2)
 ;;=^5019405
 ;;^UTILITY(U,$J,358.3,21213,0)
 ;;=R40.2314^^84^947^11
 ;;^UTILITY(U,$J,358.3,21213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21213,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,24+ Hrs
 ;;^UTILITY(U,$J,358.3,21213,1,4,0)
 ;;=4^R40.2314
 ;;^UTILITY(U,$J,358.3,21213,2)
 ;;=^5019404
 ;;^UTILITY(U,$J,358.3,21214,0)
 ;;=R40.2313^^84^947^14
 ;;^UTILITY(U,$J,358.3,21214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21214,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,21214,1,4,0)
 ;;=4^R40.2313
 ;;^UTILITY(U,$J,358.3,21214,2)
 ;;=^5019403
 ;;^UTILITY(U,$J,358.3,21215,0)
 ;;=R40.2312^^84^947^12
 ;;^UTILITY(U,$J,358.3,21215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21215,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Emerg Dept
 ;;^UTILITY(U,$J,358.3,21215,1,4,0)
 ;;=4^R40.2312
 ;;^UTILITY(U,$J,358.3,21215,2)
 ;;=^5019402
 ;;^UTILITY(U,$J,358.3,21216,0)
 ;;=R40.2311^^84^947^15
 ;;^UTILITY(U,$J,358.3,21216,1,0)
 ;;=^358.31IA^4^2
