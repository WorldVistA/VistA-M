IBDEI17K ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19623,1,3,0)
 ;;=3^Presence of cardiac pacemaker
 ;;^UTILITY(U,$J,358.3,19623,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,19623,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,19624,0)
 ;;=Z95.5^^67^878^31
 ;;^UTILITY(U,$J,358.3,19624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19624,1,3,0)
 ;;=3^Presence of coronary angioplasty implant and graft
 ;;^UTILITY(U,$J,358.3,19624,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,19624,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,19625,0)
 ;;=I21.3^^67^878^33
 ;;^UTILITY(U,$J,358.3,19625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19625,1,3,0)
 ;;=3^ST elevation (STEMI) myocardial infarction of unsp site
 ;;^UTILITY(U,$J,358.3,19625,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,19625,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,19626,0)
 ;;=J43.0^^67^878^35
 ;;^UTILITY(U,$J,358.3,19626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19626,1,3,0)
 ;;=3^Unilateral pulmonary emphysema [MacLeod's syndrome]
 ;;^UTILITY(U,$J,358.3,19626,1,4,0)
 ;;=4^J43.0
 ;;^UTILITY(U,$J,358.3,19626,2)
 ;;=^5008235
 ;;^UTILITY(U,$J,358.3,19627,0)
 ;;=I50.40^^67^878^19
 ;;^UTILITY(U,$J,358.3,19627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19627,1,3,0)
 ;;=3^Combined systolic and diastolic (congestive) hrt fail,Unspec
 ;;^UTILITY(U,$J,358.3,19627,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,19627,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,19628,0)
 ;;=I50.30^^67^878^21
 ;;^UTILITY(U,$J,358.3,19628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19628,1,3,0)
 ;;=3^Diastolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,19628,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,19628,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,19629,0)
 ;;=I50.20^^67^878^34
 ;;^UTILITY(U,$J,358.3,19629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19629,1,3,0)
 ;;=3^Systolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,19629,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,19629,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,19630,0)
 ;;=T84.81XA^^67^879^4
 ;;^UTILITY(U,$J,358.3,19630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19630,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,19630,1,4,0)
 ;;=4^T84.81XA
 ;;^UTILITY(U,$J,358.3,19630,2)
 ;;=^5055454
 ;;^UTILITY(U,$J,358.3,19631,0)
 ;;=T84.81XS^^67^879^5
 ;;^UTILITY(U,$J,358.3,19631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19631,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,19631,1,4,0)
 ;;=4^T84.81XS
 ;;^UTILITY(U,$J,358.3,19631,2)
 ;;=^5055456
 ;;^UTILITY(U,$J,358.3,19632,0)
 ;;=T84.81XD^^67^879^6
 ;;^UTILITY(U,$J,358.3,19632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19632,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,19632,1,4,0)
 ;;=4^T84.81XD
 ;;^UTILITY(U,$J,358.3,19632,2)
 ;;=^5055455
 ;;^UTILITY(U,$J,358.3,19633,0)
 ;;=T84.82XA^^67^879^7
 ;;^UTILITY(U,$J,358.3,19633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19633,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,19633,1,4,0)
 ;;=4^T84.82XA
 ;;^UTILITY(U,$J,358.3,19633,2)
 ;;=^5055457
 ;;^UTILITY(U,$J,358.3,19634,0)
 ;;=T84.82XD^^67^879^8
 ;;^UTILITY(U,$J,358.3,19634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19634,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,19634,1,4,0)
 ;;=4^T84.82XD
