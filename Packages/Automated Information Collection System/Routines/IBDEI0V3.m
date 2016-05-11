IBDEI0V3 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14578,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,14578,1,4,0)
 ;;=4^R40.2343
 ;;^UTILITY(U,$J,358.3,14578,2)
 ;;=^5019418
 ;;^UTILITY(U,$J,358.3,14579,0)
 ;;=R40.2342^^53^611^8
 ;;^UTILITY(U,$J,358.3,14579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14579,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,Emger Dept
 ;;^UTILITY(U,$J,358.3,14579,1,4,0)
 ;;=4^R40.2342
 ;;^UTILITY(U,$J,358.3,14579,2)
 ;;=^5019417
 ;;^UTILITY(U,$J,358.3,14580,0)
 ;;=R40.2341^^53^611^9
 ;;^UTILITY(U,$J,358.3,14580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14580,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,in the Field
 ;;^UTILITY(U,$J,358.3,14580,1,4,0)
 ;;=4^R40.2341
 ;;^UTILITY(U,$J,358.3,14580,2)
 ;;=^5019416
 ;;^UTILITY(U,$J,358.3,14581,0)
 ;;=R40.2340^^53^611^10
 ;;^UTILITY(U,$J,358.3,14581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14581,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,Unspec Time
 ;;^UTILITY(U,$J,358.3,14581,1,4,0)
 ;;=4^R40.2340
 ;;^UTILITY(U,$J,358.3,14581,2)
 ;;=^5019415
 ;;^UTILITY(U,$J,358.3,14582,0)
 ;;=R40.2324^^53^611^1
 ;;^UTILITY(U,$J,358.3,14582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14582,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,24+ Hrs
 ;;^UTILITY(U,$J,358.3,14582,1,4,0)
 ;;=4^R40.2324
 ;;^UTILITY(U,$J,358.3,14582,2)
 ;;=^5019409
 ;;^UTILITY(U,$J,358.3,14583,0)
 ;;=R40.2323^^53^611^4
 ;;^UTILITY(U,$J,358.3,14583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14583,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,14583,1,4,0)
 ;;=4^R40.2323
 ;;^UTILITY(U,$J,358.3,14583,2)
 ;;=^5019408
 ;;^UTILITY(U,$J,358.3,14584,0)
 ;;=R40.2322^^53^611^2
 ;;^UTILITY(U,$J,358.3,14584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14584,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Emger Dept
 ;;^UTILITY(U,$J,358.3,14584,1,4,0)
 ;;=4^R40.2322
 ;;^UTILITY(U,$J,358.3,14584,2)
 ;;=^5019407
 ;;^UTILITY(U,$J,358.3,14585,0)
 ;;=R40.2321^^53^611^5
 ;;^UTILITY(U,$J,358.3,14585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14585,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,in the Field
 ;;^UTILITY(U,$J,358.3,14585,1,4,0)
 ;;=4^R40.2321
 ;;^UTILITY(U,$J,358.3,14585,2)
 ;;=^5019406
 ;;^UTILITY(U,$J,358.3,14586,0)
 ;;=R40.2320^^53^611^3
 ;;^UTILITY(U,$J,358.3,14586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14586,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Unspec Time
 ;;^UTILITY(U,$J,358.3,14586,1,4,0)
 ;;=4^R40.2320
 ;;^UTILITY(U,$J,358.3,14586,2)
 ;;=^5019405
 ;;^UTILITY(U,$J,358.3,14587,0)
 ;;=R40.2314^^53^611^11
 ;;^UTILITY(U,$J,358.3,14587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14587,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,24+ Hrs
 ;;^UTILITY(U,$J,358.3,14587,1,4,0)
 ;;=4^R40.2314
 ;;^UTILITY(U,$J,358.3,14587,2)
 ;;=^5019404
 ;;^UTILITY(U,$J,358.3,14588,0)
 ;;=R40.2313^^53^611^14
 ;;^UTILITY(U,$J,358.3,14588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14588,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,14588,1,4,0)
 ;;=4^R40.2313
 ;;^UTILITY(U,$J,358.3,14588,2)
 ;;=^5019403
 ;;^UTILITY(U,$J,358.3,14589,0)
 ;;=R40.2312^^53^611^12
 ;;^UTILITY(U,$J,358.3,14589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14589,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Emerg Dept
 ;;^UTILITY(U,$J,358.3,14589,1,4,0)
 ;;=4^R40.2312
 ;;^UTILITY(U,$J,358.3,14589,2)
 ;;=^5019402
 ;;^UTILITY(U,$J,358.3,14590,0)
 ;;=R40.2311^^53^611^15
 ;;^UTILITY(U,$J,358.3,14590,1,0)
 ;;=^358.31IA^4^2
