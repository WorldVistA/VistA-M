IBDEI1FI ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23857,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,23857,2)
 ;;=^5003808^F02.80
 ;;^UTILITY(U,$J,358.3,23858,0)
 ;;=G30.0^^116^1166^1
 ;;^UTILITY(U,$J,358.3,23858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23858,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,23858,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,23858,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,23859,0)
 ;;=G30.1^^116^1166^2
 ;;^UTILITY(U,$J,358.3,23859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23859,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,23859,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,23859,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,23860,0)
 ;;=F02.81^^116^1166^6
 ;;^UTILITY(U,$J,358.3,23860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23860,1,3,0)
 ;;=3^Dementia in Diseases Classd Elswhr w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,23860,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,23860,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,23861,0)
 ;;=F02.80^^116^1166^7
 ;;^UTILITY(U,$J,358.3,23861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23861,1,3,0)
 ;;=3^Dementia in Diseases Classd Elswhr w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,23861,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,23861,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,23862,0)
 ;;=F32.9^^116^1167^3
 ;;^UTILITY(U,$J,358.3,23862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23862,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspec
 ;;^UTILITY(U,$J,358.3,23862,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,23862,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,23863,0)
 ;;=F33.9^^116^1167^2
 ;;^UTILITY(U,$J,358.3,23863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23863,1,3,0)
 ;;=3^Major depressive disorder, recurrent, unspec
 ;;^UTILITY(U,$J,358.3,23863,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,23863,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,23864,0)
 ;;=F34.1^^116^1167^1
 ;;^UTILITY(U,$J,358.3,23864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23864,1,3,0)
 ;;=3^Dysthymic disorder
 ;;^UTILITY(U,$J,358.3,23864,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,23864,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,23865,0)
 ;;=E87.70^^116^1168^19
 ;;^UTILITY(U,$J,358.3,23865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23865,1,3,0)
 ;;=3^Fluid overload, unspec
 ;;^UTILITY(U,$J,358.3,23865,1,4,0)
 ;;=4^E87.70
 ;;^UTILITY(U,$J,358.3,23865,2)
 ;;=^5003023
 ;;^UTILITY(U,$J,358.3,23866,0)
 ;;=J43.9^^116^1168^2
 ;;^UTILITY(U,$J,358.3,23866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23866,1,3,0)
 ;;=3^Emphysema, unspec
 ;;^UTILITY(U,$J,358.3,23866,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,23866,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,23867,0)
 ;;=K20.9^^116^1168^7
 ;;^UTILITY(U,$J,358.3,23867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23867,1,3,0)
 ;;=3^Esophagitis, unspec
 ;;^UTILITY(U,$J,358.3,23867,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,23867,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,23868,0)
 ;;=K22.10^^116^1168^9
 ;;^UTILITY(U,$J,358.3,23868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23868,1,3,0)
 ;;=3^Esophagus Ulcer w/o Bleeding
 ;;^UTILITY(U,$J,358.3,23868,1,4,0)
 ;;=4^K22.10
 ;;^UTILITY(U,$J,358.3,23868,2)
 ;;=^329929
 ;;^UTILITY(U,$J,358.3,23869,0)
 ;;=K22.11^^116^1168^8
 ;;^UTILITY(U,$J,358.3,23869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23869,1,3,0)
 ;;=3^Esophagus Ulcer w/ Bleeding
 ;;^UTILITY(U,$J,358.3,23869,1,4,0)
 ;;=4^K22.11
 ;;^UTILITY(U,$J,358.3,23869,2)
 ;;=^329930
 ;;^UTILITY(U,$J,358.3,23870,0)
 ;;=K22.2^^116^1168^6
 ;;^UTILITY(U,$J,358.3,23870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23870,1,3,0)
 ;;=3^Esophageal obstruction
