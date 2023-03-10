IBDEI13K ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17813,0)
 ;;=R40.2323^^61^793^4
 ;;^UTILITY(U,$J,358.3,17813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17813,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,17813,1,4,0)
 ;;=4^R40.2323
 ;;^UTILITY(U,$J,358.3,17813,2)
 ;;=^5019408
 ;;^UTILITY(U,$J,358.3,17814,0)
 ;;=R40.2322^^61^793^2
 ;;^UTILITY(U,$J,358.3,17814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17814,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Emger Dept
 ;;^UTILITY(U,$J,358.3,17814,1,4,0)
 ;;=4^R40.2322
 ;;^UTILITY(U,$J,358.3,17814,2)
 ;;=^5019407
 ;;^UTILITY(U,$J,358.3,17815,0)
 ;;=R40.2321^^61^793^5
 ;;^UTILITY(U,$J,358.3,17815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17815,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,in the Field
 ;;^UTILITY(U,$J,358.3,17815,1,4,0)
 ;;=4^R40.2321
 ;;^UTILITY(U,$J,358.3,17815,2)
 ;;=^5019406
 ;;^UTILITY(U,$J,358.3,17816,0)
 ;;=R40.2320^^61^793^3
 ;;^UTILITY(U,$J,358.3,17816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17816,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,Unspec Time
 ;;^UTILITY(U,$J,358.3,17816,1,4,0)
 ;;=4^R40.2320
 ;;^UTILITY(U,$J,358.3,17816,2)
 ;;=^5019405
 ;;^UTILITY(U,$J,358.3,17817,0)
 ;;=R40.2314^^61^793^11
 ;;^UTILITY(U,$J,358.3,17817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17817,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,24+ Hrs
 ;;^UTILITY(U,$J,358.3,17817,1,4,0)
 ;;=4^R40.2314
 ;;^UTILITY(U,$J,358.3,17817,2)
 ;;=^5019404
 ;;^UTILITY(U,$J,358.3,17818,0)
 ;;=R40.2313^^61^793^14
 ;;^UTILITY(U,$J,358.3,17818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17818,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,17818,1,4,0)
 ;;=4^R40.2313
 ;;^UTILITY(U,$J,358.3,17818,2)
 ;;=^5019403
 ;;^UTILITY(U,$J,358.3,17819,0)
 ;;=R40.2312^^61^793^12
 ;;^UTILITY(U,$J,358.3,17819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17819,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Emerg Dept
 ;;^UTILITY(U,$J,358.3,17819,1,4,0)
 ;;=4^R40.2312
 ;;^UTILITY(U,$J,358.3,17819,2)
 ;;=^5019402
 ;;^UTILITY(U,$J,358.3,17820,0)
 ;;=R40.2311^^61^793^15
 ;;^UTILITY(U,$J,358.3,17820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17820,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,in the Field
 ;;^UTILITY(U,$J,358.3,17820,1,4,0)
 ;;=4^R40.2311
 ;;^UTILITY(U,$J,358.3,17820,2)
 ;;=^5019401
 ;;^UTILITY(U,$J,358.3,17821,0)
 ;;=R40.2310^^61^793^13
 ;;^UTILITY(U,$J,358.3,17821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17821,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,None,Unspec Time
 ;;^UTILITY(U,$J,358.3,17821,1,4,0)
 ;;=4^R40.2310
 ;;^UTILITY(U,$J,358.3,17821,2)
 ;;=^5019400
 ;;^UTILITY(U,$J,358.3,17822,0)
 ;;=R40.4^^61^793^38
 ;;^UTILITY(U,$J,358.3,17822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17822,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,17822,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,17822,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,17823,0)
 ;;=V00.811A^^61^794^50
 ;;^UTILITY(U,$J,358.3,17823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17823,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Init Encntr
 ;;^UTILITY(U,$J,358.3,17823,1,4,0)
 ;;=4^V00.811A
 ;;^UTILITY(U,$J,358.3,17823,2)
 ;;=^5055937
 ;;^UTILITY(U,$J,358.3,17824,0)
 ;;=V00.811D^^61^794^51
 ;;^UTILITY(U,$J,358.3,17824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17824,1,3,0)
 ;;=3^Fall from Moving Wheelchair (pwered),Subs Encntr
