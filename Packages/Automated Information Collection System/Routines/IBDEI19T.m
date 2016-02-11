IBDEI19T ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21244,0)
 ;;=I50.22^^101^1028^18
 ;;^UTILITY(U,$J,358.3,21244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21244,1,3,0)
 ;;=3^Chronic systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,21244,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,21244,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,21245,0)
 ;;=Z98.61^^101^1028^20
 ;;^UTILITY(U,$J,358.3,21245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21245,1,3,0)
 ;;=3^Coronary angioplasty status
 ;;^UTILITY(U,$J,358.3,21245,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,21245,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,21246,0)
 ;;=I42.0^^101^1028^22
 ;;^UTILITY(U,$J,358.3,21246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21246,1,3,0)
 ;;=3^Dilated cardiomyopathy
 ;;^UTILITY(U,$J,358.3,21246,1,4,0)
 ;;=4^I42.0
 ;;^UTILITY(U,$J,358.3,21246,2)
 ;;=^5007194
 ;;^UTILITY(U,$J,358.3,21247,0)
 ;;=J43.9^^101^1028^23
 ;;^UTILITY(U,$J,358.3,21247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21247,1,3,0)
 ;;=3^Emphysema, unspecified
 ;;^UTILITY(U,$J,358.3,21247,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,21247,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,21248,0)
 ;;=Z82.49^^101^1028^24
 ;;^UTILITY(U,$J,358.3,21248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21248,1,3,0)
 ;;=3^Family hx of ischem heart dis and oth dis of the circ sys
 ;;^UTILITY(U,$J,358.3,21248,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,21248,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,21249,0)
 ;;=I50.9^^101^1028^25
 ;;^UTILITY(U,$J,358.3,21249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21249,1,3,0)
 ;;=3^Heart failure, unspecified
 ;;^UTILITY(U,$J,358.3,21249,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,21249,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,21250,0)
 ;;=I25.2^^101^1028^27
 ;;^UTILITY(U,$J,358.3,21250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21250,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,21250,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,21250,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,21251,0)
 ;;=I42.8^^101^1028^12
 ;;^UTILITY(U,$J,358.3,21251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21251,1,3,0)
 ;;=3^Cardiomyopathies NEC
 ;;^UTILITY(U,$J,358.3,21251,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,21251,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,21252,0)
 ;;=I42.2^^101^1028^26
 ;;^UTILITY(U,$J,358.3,21252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21252,1,3,0)
 ;;=3^Hypertrophic cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,21252,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,21252,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,21253,0)
 ;;=I42.5^^101^1028^32
 ;;^UTILITY(U,$J,358.3,21253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21253,1,3,0)
 ;;=3^Restrictive cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,21253,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,21253,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,21254,0)
 ;;=Z95.1^^101^1028^29
 ;;^UTILITY(U,$J,358.3,21254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21254,1,3,0)
 ;;=3^Presence of aortocoronary bypass graft
 ;;^UTILITY(U,$J,358.3,21254,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,21254,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,21255,0)
 ;;=Z95.0^^101^1028^30
 ;;^UTILITY(U,$J,358.3,21255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21255,1,3,0)
 ;;=3^Presence of cardiac pacemaker
 ;;^UTILITY(U,$J,358.3,21255,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,21255,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,21256,0)
 ;;=Z95.5^^101^1028^31
 ;;^UTILITY(U,$J,358.3,21256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21256,1,3,0)
 ;;=3^Presence of coronary angioplasty implant and graft
 ;;^UTILITY(U,$J,358.3,21256,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,21256,2)
 ;;=^5063673
