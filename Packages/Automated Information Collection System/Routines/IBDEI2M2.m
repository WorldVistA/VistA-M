IBDEI2M2 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41697,0)
 ;;=I21.3^^155^2062^33
 ;;^UTILITY(U,$J,358.3,41697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41697,1,3,0)
 ;;=3^ST elevation (STEMI) myocardial infarction of unsp site
 ;;^UTILITY(U,$J,358.3,41697,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,41697,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,41698,0)
 ;;=J43.0^^155^2062^35
 ;;^UTILITY(U,$J,358.3,41698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41698,1,3,0)
 ;;=3^Unilateral pulmonary emphysema [MacLeod's syndrome]
 ;;^UTILITY(U,$J,358.3,41698,1,4,0)
 ;;=4^J43.0
 ;;^UTILITY(U,$J,358.3,41698,2)
 ;;=^5008235
 ;;^UTILITY(U,$J,358.3,41699,0)
 ;;=I50.40^^155^2062^19
 ;;^UTILITY(U,$J,358.3,41699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41699,1,3,0)
 ;;=3^Combined systolic and diastolic (congestive) hrt fail,Unspec
 ;;^UTILITY(U,$J,358.3,41699,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,41699,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,41700,0)
 ;;=I50.30^^155^2062^21
 ;;^UTILITY(U,$J,358.3,41700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41700,1,3,0)
 ;;=3^Diastolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,41700,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,41700,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,41701,0)
 ;;=I50.20^^155^2062^34
 ;;^UTILITY(U,$J,358.3,41701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41701,1,3,0)
 ;;=3^Systolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,41701,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,41701,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,41702,0)
 ;;=T84.81XA^^155^2063^4
 ;;^UTILITY(U,$J,358.3,41702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41702,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,41702,1,4,0)
 ;;=4^T84.81XA
 ;;^UTILITY(U,$J,358.3,41702,2)
 ;;=^5055454
 ;;^UTILITY(U,$J,358.3,41703,0)
 ;;=T84.81XS^^155^2063^5
 ;;^UTILITY(U,$J,358.3,41703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41703,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,41703,1,4,0)
 ;;=4^T84.81XS
 ;;^UTILITY(U,$J,358.3,41703,2)
 ;;=^5055456
 ;;^UTILITY(U,$J,358.3,41704,0)
 ;;=T84.81XD^^155^2063^6
 ;;^UTILITY(U,$J,358.3,41704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41704,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,41704,1,4,0)
 ;;=4^T84.81XD
 ;;^UTILITY(U,$J,358.3,41704,2)
 ;;=^5055455
 ;;^UTILITY(U,$J,358.3,41705,0)
 ;;=T84.82XA^^155^2063^7
 ;;^UTILITY(U,$J,358.3,41705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41705,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,41705,1,4,0)
 ;;=4^T84.82XA
 ;;^UTILITY(U,$J,358.3,41705,2)
 ;;=^5055457
 ;;^UTILITY(U,$J,358.3,41706,0)
 ;;=T84.82XD^^155^2063^8
 ;;^UTILITY(U,$J,358.3,41706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41706,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,41706,1,4,0)
 ;;=4^T84.82XD
 ;;^UTILITY(U,$J,358.3,41706,2)
 ;;=^5055458
 ;;^UTILITY(U,$J,358.3,41707,0)
 ;;=T84.82XS^^155^2063^9
 ;;^UTILITY(U,$J,358.3,41707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41707,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,41707,1,4,0)
 ;;=4^T84.82XS
 ;;^UTILITY(U,$J,358.3,41707,2)
 ;;=^5055459
 ;;^UTILITY(U,$J,358.3,41708,0)
 ;;=T84.83XA^^155^2063^10
 ;;^UTILITY(U,$J,358.3,41708,1,0)
 ;;=^358.31IA^4^2
