IBDEI0LW ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9852,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,24+ Hrs
 ;;^UTILITY(U,$J,358.3,9852,1,4,0)
 ;;=4^R40.2324
 ;;^UTILITY(U,$J,358.3,9852,2)
 ;;=^5019409
 ;;^UTILITY(U,$J,358.3,9853,0)
 ;;=R40.2323^^39^419^4
 ;;^UTILITY(U,$J,358.3,9853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9853,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,9853,1,4,0)
 ;;=4^R40.2323
 ;;^UTILITY(U,$J,358.3,9853,2)
 ;;=^5019408
 ;;^UTILITY(U,$J,358.3,9854,0)
 ;;=R40.2322^^39^419^2
 ;;^UTILITY(U,$J,358.3,9854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9854,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Emger Dept
 ;;^UTILITY(U,$J,358.3,9854,1,4,0)
 ;;=4^R40.2322
 ;;^UTILITY(U,$J,358.3,9854,2)
 ;;=^5019407
 ;;^UTILITY(U,$J,358.3,9855,0)
 ;;=R40.2321^^39^419^5
 ;;^UTILITY(U,$J,358.3,9855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9855,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,in the Field
 ;;^UTILITY(U,$J,358.3,9855,1,4,0)
 ;;=4^R40.2321
 ;;^UTILITY(U,$J,358.3,9855,2)
 ;;=^5019406
 ;;^UTILITY(U,$J,358.3,9856,0)
 ;;=R40.2320^^39^419^3
 ;;^UTILITY(U,$J,358.3,9856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9856,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Unspec Time
 ;;^UTILITY(U,$J,358.3,9856,1,4,0)
 ;;=4^R40.2320
 ;;^UTILITY(U,$J,358.3,9856,2)
 ;;=^5019405
 ;;^UTILITY(U,$J,358.3,9857,0)
 ;;=R40.2314^^39^419^11
 ;;^UTILITY(U,$J,358.3,9857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9857,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,24+ Hrs
 ;;^UTILITY(U,$J,358.3,9857,1,4,0)
 ;;=4^R40.2314
 ;;^UTILITY(U,$J,358.3,9857,2)
 ;;=^5019404
 ;;^UTILITY(U,$J,358.3,9858,0)
 ;;=R40.2313^^39^419^14
 ;;^UTILITY(U,$J,358.3,9858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9858,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,9858,1,4,0)
 ;;=4^R40.2313
 ;;^UTILITY(U,$J,358.3,9858,2)
 ;;=^5019403
 ;;^UTILITY(U,$J,358.3,9859,0)
 ;;=R40.2312^^39^419^12
 ;;^UTILITY(U,$J,358.3,9859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9859,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Emerg Dept
 ;;^UTILITY(U,$J,358.3,9859,1,4,0)
 ;;=4^R40.2312
 ;;^UTILITY(U,$J,358.3,9859,2)
 ;;=^5019402
 ;;^UTILITY(U,$J,358.3,9860,0)
 ;;=R40.2311^^39^419^15
 ;;^UTILITY(U,$J,358.3,9860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9860,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,in the Field
 ;;^UTILITY(U,$J,358.3,9860,1,4,0)
 ;;=4^R40.2311
 ;;^UTILITY(U,$J,358.3,9860,2)
 ;;=^5019401
 ;;^UTILITY(U,$J,358.3,9861,0)
 ;;=R40.2310^^39^419^13
 ;;^UTILITY(U,$J,358.3,9861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9861,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Unspec Time
 ;;^UTILITY(U,$J,358.3,9861,1,4,0)
 ;;=4^R40.2310
 ;;^UTILITY(U,$J,358.3,9861,2)
 ;;=^5019400
 ;;^UTILITY(U,$J,358.3,9862,0)
 ;;=R40.4^^39^419^38
 ;;^UTILITY(U,$J,358.3,9862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9862,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,9862,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,9862,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,9863,0)
 ;;=V00.811A^^39^420^50
 ;;^UTILITY(U,$J,358.3,9863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9863,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Init Encntr
 ;;^UTILITY(U,$J,358.3,9863,1,4,0)
 ;;=4^V00.811A
 ;;^UTILITY(U,$J,358.3,9863,2)
 ;;=^5055937
