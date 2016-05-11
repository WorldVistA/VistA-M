IBDEI02T ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,854,2)
 ;;=^5009026
 ;;^UTILITY(U,$J,358.3,855,0)
 ;;=M54.2^^6^99^12
 ;;^UTILITY(U,$J,358.3,855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,855,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,855,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,855,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,856,0)
 ;;=R07.9^^6^99^13
 ;;^UTILITY(U,$J,358.3,856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,856,1,3,0)
 ;;=3^Chest Pain,Unspec
 ;;^UTILITY(U,$J,358.3,856,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,856,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,857,0)
 ;;=N20.0^^6^99^4
 ;;^UTILITY(U,$J,358.3,857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,857,1,3,0)
 ;;=3^Calculus of Kidney
 ;;^UTILITY(U,$J,358.3,857,1,4,0)
 ;;=4^N20.0
 ;;^UTILITY(U,$J,358.3,857,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,858,0)
 ;;=C15.9^^6^100^5
 ;;^UTILITY(U,$J,358.3,858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,858,1,3,0)
 ;;=3^Malig Neop Esophagus,Unspec
 ;;^UTILITY(U,$J,358.3,858,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,858,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,859,0)
 ;;=C18.9^^6^100^4
 ;;^UTILITY(U,$J,358.3,859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,859,1,3,0)
 ;;=3^Malig Neop Colon,Unspec
 ;;^UTILITY(U,$J,358.3,859,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,859,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,860,0)
 ;;=C32.9^^6^100^6
 ;;^UTILITY(U,$J,358.3,860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,860,1,3,0)
 ;;=3^Malig Neop Larynx,Unspec
 ;;^UTILITY(U,$J,358.3,860,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,860,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,861,0)
 ;;=C34.91^^6^100^11
 ;;^UTILITY(U,$J,358.3,861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,861,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,861,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,861,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,862,0)
 ;;=C34.92^^6^100^7
 ;;^UTILITY(U,$J,358.3,862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,862,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,862,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,862,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,863,0)
 ;;=C44.91^^6^100^1
 ;;^UTILITY(U,$J,358.3,863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,863,1,3,0)
 ;;=3^Basal Cell Carcinoma Skin,Unspec
 ;;^UTILITY(U,$J,358.3,863,1,4,0)
 ;;=4^C44.91
 ;;^UTILITY(U,$J,358.3,863,2)
 ;;=^5001092
 ;;^UTILITY(U,$J,358.3,864,0)
 ;;=C44.99^^6^100^14
 ;;^UTILITY(U,$J,358.3,864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,864,1,3,0)
 ;;=3^Malig Neop Skin,Other Spec
 ;;^UTILITY(U,$J,358.3,864,1,4,0)
 ;;=4^C44.99
 ;;^UTILITY(U,$J,358.3,864,2)
 ;;=^5001094
 ;;^UTILITY(U,$J,358.3,865,0)
 ;;=C50.912^^6^100^8
 ;;^UTILITY(U,$J,358.3,865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,865,1,3,0)
 ;;=3^Malig Neop Left Female Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,865,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,865,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,866,0)
 ;;=C50.911^^6^100^12
 ;;^UTILITY(U,$J,358.3,866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,866,1,3,0)
 ;;=3^Malig Neop Right Female Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,866,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,866,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,867,0)
 ;;=C61.^^6^100^10
 ;;^UTILITY(U,$J,358.3,867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,867,1,3,0)
 ;;=3^Malig Neop Prostate
 ;;^UTILITY(U,$J,358.3,867,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,867,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,868,0)
 ;;=C67.9^^6^100^3
 ;;^UTILITY(U,$J,358.3,868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,868,1,3,0)
 ;;=3^Malig Neop Bladder,Unspec
 ;;^UTILITY(U,$J,358.3,868,1,4,0)
 ;;=4^C67.9
