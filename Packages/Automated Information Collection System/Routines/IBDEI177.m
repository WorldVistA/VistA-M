IBDEI177 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19248,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,19248,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,19249,0)
 ;;=I42.2^^93^990^26
 ;;^UTILITY(U,$J,358.3,19249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19249,1,3,0)
 ;;=3^Hypertrophic cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,19249,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,19249,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,19250,0)
 ;;=I42.5^^93^990^32
 ;;^UTILITY(U,$J,358.3,19250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19250,1,3,0)
 ;;=3^Restrictive cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,19250,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,19250,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,19251,0)
 ;;=Z95.1^^93^990^29
 ;;^UTILITY(U,$J,358.3,19251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19251,1,3,0)
 ;;=3^Presence of aortocoronary bypass graft
 ;;^UTILITY(U,$J,358.3,19251,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,19251,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,19252,0)
 ;;=Z95.0^^93^990^30
 ;;^UTILITY(U,$J,358.3,19252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19252,1,3,0)
 ;;=3^Presence of cardiac pacemaker
 ;;^UTILITY(U,$J,358.3,19252,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,19252,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,19253,0)
 ;;=Z95.5^^93^990^31
 ;;^UTILITY(U,$J,358.3,19253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19253,1,3,0)
 ;;=3^Presence of coronary angioplasty implant and graft
 ;;^UTILITY(U,$J,358.3,19253,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,19253,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,19254,0)
 ;;=I21.3^^93^990^33
 ;;^UTILITY(U,$J,358.3,19254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19254,1,3,0)
 ;;=3^ST elevation (STEMI) myocardial infarction of unsp site
 ;;^UTILITY(U,$J,358.3,19254,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,19254,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,19255,0)
 ;;=J43.0^^93^990^35
 ;;^UTILITY(U,$J,358.3,19255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19255,1,3,0)
 ;;=3^Unilateral pulmonary emphysema [MacLeod's syndrome]
 ;;^UTILITY(U,$J,358.3,19255,1,4,0)
 ;;=4^J43.0
 ;;^UTILITY(U,$J,358.3,19255,2)
 ;;=^5008235
 ;;^UTILITY(U,$J,358.3,19256,0)
 ;;=I50.40^^93^990^19
 ;;^UTILITY(U,$J,358.3,19256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19256,1,3,0)
 ;;=3^Combined systolic and diastolic (congestive) hrt fail,Unspec
 ;;^UTILITY(U,$J,358.3,19256,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,19256,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,19257,0)
 ;;=I50.30^^93^990^21
 ;;^UTILITY(U,$J,358.3,19257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19257,1,3,0)
 ;;=3^Diastolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,19257,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,19257,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,19258,0)
 ;;=I50.20^^93^990^34
 ;;^UTILITY(U,$J,358.3,19258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19258,1,3,0)
 ;;=3^Systolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,19258,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,19258,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,19259,0)
 ;;=T84.81XA^^93^991^4
 ;;^UTILITY(U,$J,358.3,19259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19259,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,19259,1,4,0)
 ;;=4^T84.81XA
 ;;^UTILITY(U,$J,358.3,19259,2)
 ;;=^5055454
 ;;^UTILITY(U,$J,358.3,19260,0)
 ;;=T84.81XS^^93^991^5
 ;;^UTILITY(U,$J,358.3,19260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19260,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, sequela
