IBDEI1XS ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34008,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,34008,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,34009,0)
 ;;=I50.9^^183^2014^25
 ;;^UTILITY(U,$J,358.3,34009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34009,1,3,0)
 ;;=3^Heart failure, unspecified
 ;;^UTILITY(U,$J,358.3,34009,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,34009,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,34010,0)
 ;;=I25.2^^183^2014^27
 ;;^UTILITY(U,$J,358.3,34010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34010,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,34010,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,34010,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,34011,0)
 ;;=I42.8^^183^2014^12
 ;;^UTILITY(U,$J,358.3,34011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34011,1,3,0)
 ;;=3^Cardiomyopathies NEC
 ;;^UTILITY(U,$J,358.3,34011,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,34011,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,34012,0)
 ;;=I42.2^^183^2014^26
 ;;^UTILITY(U,$J,358.3,34012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34012,1,3,0)
 ;;=3^Hypertrophic cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,34012,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,34012,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,34013,0)
 ;;=I42.5^^183^2014^32
 ;;^UTILITY(U,$J,358.3,34013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34013,1,3,0)
 ;;=3^Restrictive cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,34013,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,34013,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,34014,0)
 ;;=Z95.1^^183^2014^29
 ;;^UTILITY(U,$J,358.3,34014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34014,1,3,0)
 ;;=3^Presence of aortocoronary bypass graft
 ;;^UTILITY(U,$J,358.3,34014,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,34014,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,34015,0)
 ;;=Z95.0^^183^2014^30
 ;;^UTILITY(U,$J,358.3,34015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34015,1,3,0)
 ;;=3^Presence of cardiac pacemaker
 ;;^UTILITY(U,$J,358.3,34015,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,34015,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,34016,0)
 ;;=Z95.5^^183^2014^31
 ;;^UTILITY(U,$J,358.3,34016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34016,1,3,0)
 ;;=3^Presence of coronary angioplasty implant and graft
 ;;^UTILITY(U,$J,358.3,34016,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,34016,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,34017,0)
 ;;=I21.3^^183^2014^33
 ;;^UTILITY(U,$J,358.3,34017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34017,1,3,0)
 ;;=3^ST elevation (STEMI) myocardial infarction of unsp site
 ;;^UTILITY(U,$J,358.3,34017,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,34017,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,34018,0)
 ;;=J43.0^^183^2014^35
 ;;^UTILITY(U,$J,358.3,34018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34018,1,3,0)
 ;;=3^Unilateral pulmonary emphysema [MacLeod's syndrome]
 ;;^UTILITY(U,$J,358.3,34018,1,4,0)
 ;;=4^J43.0
 ;;^UTILITY(U,$J,358.3,34018,2)
 ;;=^5008235
 ;;^UTILITY(U,$J,358.3,34019,0)
 ;;=I50.40^^183^2014^19
 ;;^UTILITY(U,$J,358.3,34019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34019,1,3,0)
 ;;=3^Combined systolic and diastolic (congestive) hrt fail,Unspec
 ;;^UTILITY(U,$J,358.3,34019,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,34019,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,34020,0)
 ;;=I50.30^^183^2014^21
 ;;^UTILITY(U,$J,358.3,34020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34020,1,3,0)
 ;;=3^Diastolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,34020,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,34020,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,34021,0)
 ;;=I50.20^^183^2014^34
 ;;^UTILITY(U,$J,358.3,34021,1,0)
 ;;=^358.31IA^4^2
