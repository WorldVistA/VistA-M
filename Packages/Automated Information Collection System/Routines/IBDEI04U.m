IBDEI04U ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11710,1,4,0)
 ;;=4^I25.111
 ;;^UTILITY(U,$J,358.3,11710,2)
 ;;=^5007109
 ;;^UTILITY(U,$J,358.3,11711,0)
 ;;=I25.118^^50^539^8
 ;;^UTILITY(U,$J,358.3,11711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11711,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w oth ang pctrs
 ;;^UTILITY(U,$J,358.3,11711,1,4,0)
 ;;=4^I25.118
 ;;^UTILITY(U,$J,358.3,11711,2)
 ;;=^5007110
 ;;^UTILITY(U,$J,358.3,11712,0)
 ;;=I25.119^^50^539^9
 ;;^UTILITY(U,$J,358.3,11712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11712,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w unsp ang pctrs
 ;;^UTILITY(U,$J,358.3,11712,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,11712,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,11713,0)
 ;;=I25.110^^50^539^10
 ;;^UTILITY(U,$J,358.3,11713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11713,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w unstable ang pctrs
 ;;^UTILITY(U,$J,358.3,11713,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,11713,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,11714,0)
 ;;=I25.10^^50^539^11
 ;;^UTILITY(U,$J,358.3,11714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11714,1,3,0)
 ;;=3^Athscl hrt disease of native cor art w/o ang pctrs
 ;;^UTILITY(U,$J,358.3,11714,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,11714,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,11715,0)
 ;;=I48.0^^50^539^28
 ;;^UTILITY(U,$J,358.3,11715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11715,1,3,0)
 ;;=3^Paroxysmal atrial fibrillation
 ;;^UTILITY(U,$J,358.3,11715,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,11715,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,11716,0)
 ;;=I42.9^^50^539^13
 ;;^UTILITY(U,$J,358.3,11716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11716,1,3,0)
 ;;=3^Cardiomyopathy, unspecified
 ;;^UTILITY(U,$J,358.3,11716,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,11716,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,11717,0)
 ;;=I50.42^^50^539^14
 ;;^UTILITY(U,$J,358.3,11717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11717,1,3,0)
 ;;=3^Chronic combined systolic and diastolic hrt fail
 ;;^UTILITY(U,$J,358.3,11717,1,4,0)
 ;;=4^I50.42
 ;;^UTILITY(U,$J,358.3,11717,2)
 ;;=^5007249
 ;;^UTILITY(U,$J,358.3,11718,0)
 ;;=I50.32^^50^539^15
 ;;^UTILITY(U,$J,358.3,11718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11718,1,3,0)
 ;;=3^Chronic diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,11718,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,11718,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,11719,0)
 ;;=J44.1^^50^539^16
 ;;^UTILITY(U,$J,358.3,11719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11719,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease w (acute) exacerbation
 ;;^UTILITY(U,$J,358.3,11719,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,11719,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,11720,0)
 ;;=J44.9^^50^539^17
 ;;^UTILITY(U,$J,358.3,11720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11720,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease, unspecified
 ;;^UTILITY(U,$J,358.3,11720,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,11720,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,11721,0)
 ;;=I50.22^^50^539^18
 ;;^UTILITY(U,$J,358.3,11721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11721,1,3,0)
 ;;=3^Chronic systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,11721,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,11721,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,11722,0)
 ;;=Z98.61^^50^539^20
 ;;^UTILITY(U,$J,358.3,11722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11722,1,3,0)
 ;;=3^Coronary angioplasty status
 ;;^UTILITY(U,$J,358.3,11722,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,11722,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,11723,0)
 ;;=I42.0^^50^539^22
 ;;^UTILITY(U,$J,358.3,11723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11723,1,3,0)
 ;;=3^Dilated cardiomyopathy
 ;;^UTILITY(U,$J,358.3,11723,1,4,0)
 ;;=4^I42.0
 ;;^UTILITY(U,$J,358.3,11723,2)
 ;;=^5007194
 ;;^UTILITY(U,$J,358.3,11724,0)
 ;;=J43.9^^50^539^23
 ;;^UTILITY(U,$J,358.3,11724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11724,1,3,0)
 ;;=3^Emphysema, unspecified
 ;;^UTILITY(U,$J,358.3,11724,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,11724,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,11725,0)
 ;;=Z82.49^^50^539^24
 ;;^UTILITY(U,$J,358.3,11725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11725,1,3,0)
 ;;=3^Family hx of ischem heart dis and oth dis of the circ sys
 ;;^UTILITY(U,$J,358.3,11725,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,11725,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,11726,0)
 ;;=I50.9^^50^539^25
 ;;^UTILITY(U,$J,358.3,11726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11726,1,3,0)
 ;;=3^Heart failure, unspecified
 ;;^UTILITY(U,$J,358.3,11726,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,11726,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,11727,0)
 ;;=I25.2^^50^539^27
 ;;^UTILITY(U,$J,358.3,11727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11727,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,11727,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,11727,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,11728,0)
 ;;=I42.8^^50^539^12
 ;;^UTILITY(U,$J,358.3,11728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11728,1,3,0)
 ;;=3^Cardiomyopathies NEC
 ;;^UTILITY(U,$J,358.3,11728,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,11728,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,11729,0)
 ;;=I42.2^^50^539^26
 ;;^UTILITY(U,$J,358.3,11729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11729,1,3,0)
 ;;=3^Hypertrophic cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,11729,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,11729,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,11730,0)
 ;;=I42.5^^50^539^32
 ;;^UTILITY(U,$J,358.3,11730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11730,1,3,0)
 ;;=3^Restrictive cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,11730,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,11730,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,11731,0)
 ;;=Z95.1^^50^539^29
 ;;^UTILITY(U,$J,358.3,11731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11731,1,3,0)
 ;;=3^Presence of aortocoronary bypass graft
 ;;^UTILITY(U,$J,358.3,11731,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,11731,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,11732,0)
 ;;=Z95.0^^50^539^30
 ;;^UTILITY(U,$J,358.3,11732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11732,1,3,0)
 ;;=3^Presence of cardiac pacemaker
 ;;^UTILITY(U,$J,358.3,11732,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,11732,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,11733,0)
 ;;=Z95.5^^50^539^31
 ;;^UTILITY(U,$J,358.3,11733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11733,1,3,0)
 ;;=3^Presence of coronary angioplasty implant and graft
 ;;^UTILITY(U,$J,358.3,11733,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,11733,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,11734,0)
 ;;=I21.3^^50^539^33
 ;;^UTILITY(U,$J,358.3,11734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11734,1,3,0)
 ;;=3^ST elevation (STEMI) myocardial infarction of unsp site
 ;;^UTILITY(U,$J,358.3,11734,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,11734,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,11735,0)
 ;;=J43.0^^50^539^35
 ;;^UTILITY(U,$J,358.3,11735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11735,1,3,0)
 ;;=3^Unilateral pulmonary emphysema [MacLeod's syndrome]
 ;;^UTILITY(U,$J,358.3,11735,1,4,0)
 ;;=4^J43.0
 ;;^UTILITY(U,$J,358.3,11735,2)
 ;;=^5008235
 ;;^UTILITY(U,$J,358.3,11736,0)
 ;;=I50.40^^50^539^19
 ;;^UTILITY(U,$J,358.3,11736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11736,1,3,0)
 ;;=3^Combined systolic and diastolic (congestive) hrt fail,Unspec
 ;;^UTILITY(U,$J,358.3,11736,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,11736,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,11737,0)
 ;;=I50.30^^50^539^21
 ;;^UTILITY(U,$J,358.3,11737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11737,1,3,0)
 ;;=3^Diastolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,11737,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,11737,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,11738,0)
 ;;=I50.20^^50^539^34
 ;;^UTILITY(U,$J,358.3,11738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11738,1,3,0)
 ;;=3^Systolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,11738,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,11738,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,11739,0)
 ;;=T84.81XD^^50^540^2
 ;;^UTILITY(U,$J,358.3,11739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11739,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,11739,1,4,0)
 ;;=4^T84.81XD
 ;;^UTILITY(U,$J,358.3,11739,2)
 ;;=^5055455
 ;;^UTILITY(U,$J,358.3,11740,0)
 ;;=T84.82XD^^50^540^3
 ;;^UTILITY(U,$J,358.3,11740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11740,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,11740,1,4,0)
 ;;=4^T84.82XD
 ;;^UTILITY(U,$J,358.3,11740,2)
 ;;=^5055458
 ;;^UTILITY(U,$J,358.3,11741,0)
 ;;=T84.83XD^^50^540^4
 ;;^UTILITY(U,$J,358.3,11741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11741,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,11741,1,4,0)
 ;;=4^T84.83XD
 ;;^UTILITY(U,$J,358.3,11741,2)
 ;;=^5055461
 ;;^UTILITY(U,$J,358.3,11742,0)
 ;;=T84.89XD^^50^540^1
 ;;^UTILITY(U,$J,358.3,11742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11742,1,3,0)
 ;;=3^Comp of internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,11742,1,4,0)
 ;;=4^T84.89XD
 ;;^UTILITY(U,$J,358.3,11742,2)
 ;;=^5055473
 ;;^UTILITY(U,$J,358.3,11743,0)
 ;;=T84.84XD^^50^540^5
 ;;^UTILITY(U,$J,358.3,11743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11743,1,3,0)
 ;;=3^Pain due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,11743,1,4,0)
 ;;=4^T84.84XD
 ;;^UTILITY(U,$J,358.3,11743,2)
 ;;=^5055464
 ;;^UTILITY(U,$J,358.3,11744,0)
 ;;=T84.85XD^^50^540^6
 ;;^UTILITY(U,$J,358.3,11744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11744,1,3,0)
 ;;=3^Stenosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,11744,1,4,0)
 ;;=4^T84.85XD
 ;;^UTILITY(U,$J,358.3,11744,2)
 ;;=^5055467
 ;;^UTILITY(U,$J,358.3,11745,0)
 ;;=T84.86XD^^50^540^7
 ;;^UTILITY(U,$J,358.3,11745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11745,1,3,0)
 ;;=3^Thrombosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,11745,1,4,0)
 ;;=4^T84.86XD
 ;;^UTILITY(U,$J,358.3,11745,2)
 ;;=^5055470
 ;;^UTILITY(U,$J,358.3,11746,0)
 ;;=M76.62^^50^541^1
 ;;^UTILITY(U,$J,358.3,11746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11746,1,3,0)
 ;;=3^Achilles tendinitis, left leg
 ;;^UTILITY(U,$J,358.3,11746,1,4,0)
 ;;=4^M76.62
 ;;^UTILITY(U,$J,358.3,11746,2)
 ;;=^5013286
 ;;^UTILITY(U,$J,358.3,11747,0)
 ;;=M76.61^^50^541^2
 ;;^UTILITY(U,$J,358.3,11747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11747,1,3,0)
 ;;=3^Achilles tendinitis, right leg
 ;;^UTILITY(U,$J,358.3,11747,1,4,0)
 ;;=4^M76.61
 ;;^UTILITY(U,$J,358.3,11747,2)
 ;;=^5013285
 ;;^UTILITY(U,$J,358.3,11748,0)
 ;;=M75.02^^50^541^3
 ;;^UTILITY(U,$J,358.3,11748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11748,1,3,0)
 ;;=3^Adhesive capsulitis of left shoulder
 ;;^UTILITY(U,$J,358.3,11748,1,4,0)
 ;;=4^M75.02
 ;;^UTILITY(U,$J,358.3,11748,2)
 ;;=^5013240
 ;;^UTILITY(U,$J,358.3,11749,0)
 ;;=M75.01^^50^541^4
 ;;^UTILITY(U,$J,358.3,11749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11749,1,3,0)
 ;;=3^Adhesive capsulitis of right shoulder
 ;;^UTILITY(U,$J,358.3,11749,1,4,0)
 ;;=4^M75.01
 ;;^UTILITY(U,$J,358.3,11749,2)
 ;;=^5013239
 ;;^UTILITY(U,$J,358.3,11750,0)
 ;;=M81.0^^50^541^5
 ;;^UTILITY(U,$J,358.3,11750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11750,1,3,0)
 ;;=3^Age-related osteoporosis w/o current pathological fracture
 ;;^UTILITY(U,$J,358.3,11750,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,11750,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,11751,0)
 ;;=M75.22^^50^541^6
 ;;^UTILITY(U,$J,358.3,11751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11751,1,3,0)
 ;;=3^Bicipital tendinitis, left shoulder
 ;;^UTILITY(U,$J,358.3,11751,1,4,0)
 ;;=4^M75.22
 ;;^UTILITY(U,$J,358.3,11751,2)
 ;;=^5013252
 ;;^UTILITY(U,$J,358.3,11752,0)
 ;;=M75.21^^50^541^7
 ;;^UTILITY(U,$J,358.3,11752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11752,1,3,0)
 ;;=3^Bicipital tendinitis, right shoulder
 ;;^UTILITY(U,$J,358.3,11752,1,4,0)
 ;;=4^M75.21
 ;;^UTILITY(U,$J,358.3,11752,2)
 ;;=^5013251
 ;;^UTILITY(U,$J,358.3,11753,0)
 ;;=M17.0^^50^541^77
 ;;^UTILITY(U,$J,358.3,11753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11753,1,3,0)
 ;;=3^Prim Osteoarth,Knee,Bilateral
 ;;^UTILITY(U,$J,358.3,11753,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,11753,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,11754,0)
 ;;=M75.52^^50^541^10
 ;;^UTILITY(U,$J,358.3,11754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11754,1,3,0)
 ;;=3^Bursitis of left shoulder
 ;;^UTILITY(U,$J,358.3,11754,1,4,0)
 ;;=4^M75.52
 ;;^UTILITY(U,$J,358.3,11754,2)
 ;;=^5133691
 ;;^UTILITY(U,$J,358.3,11755,0)
 ;;=M75.51^^50^541^11
 ;;^UTILITY(U,$J,358.3,11755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11755,1,3,0)
 ;;=3^Bursitis of right shoulder
 ;;^UTILITY(U,$J,358.3,11755,1,4,0)
 ;;=4^M75.51
 ;;^UTILITY(U,$J,358.3,11755,2)
 ;;=^5133690
 ;;^UTILITY(U,$J,358.3,11756,0)
 ;;=M75.32^^50^541^12
 ;;^UTILITY(U,$J,358.3,11756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11756,1,3,0)
 ;;=3^Calcific tendinitis of left shoulder
 ;;^UTILITY(U,$J,358.3,11756,1,4,0)
 ;;=4^M75.32
 ;;^UTILITY(U,$J,358.3,11756,2)
 ;;=^5013255
 ;;^UTILITY(U,$J,358.3,11757,0)
 ;;=M75.31^^50^541^13
 ;;^UTILITY(U,$J,358.3,11757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11757,1,3,0)
 ;;=3^Calcific tendinitis of right shoulder
 ;;^UTILITY(U,$J,358.3,11757,1,4,0)
 ;;=4^M75.31
 ;;^UTILITY(U,$J,358.3,11757,2)
 ;;=^5013254
 ;;^UTILITY(U,$J,358.3,11758,0)
 ;;=M22.42^^50^541^14
 ;;^UTILITY(U,$J,358.3,11758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11758,1,3,0)
 ;;=3^Chondromalacia patellae, left knee
 ;;^UTILITY(U,$J,358.3,11758,1,4,0)
 ;;=4^M22.42
 ;;^UTILITY(U,$J,358.3,11758,2)
 ;;=^5011187
 ;;^UTILITY(U,$J,358.3,11759,0)
 ;;=M22.41^^50^541^15
 ;;^UTILITY(U,$J,358.3,11759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11759,1,3,0)
 ;;=3^Chondromalacia patellae, right knee
 ;;^UTILITY(U,$J,358.3,11759,1,4,0)
 ;;=4^M22.41
 ;;^UTILITY(U,$J,358.3,11759,2)
 ;;=^5011186
 ;;^UTILITY(U,$J,358.3,11760,0)
 ;;=M62.472^^50^541^16
 ;;^UTILITY(U,$J,358.3,11760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11760,1,3,0)
 ;;=3^Contracture of muscle, left ankle and foot
 ;;^UTILITY(U,$J,358.3,11760,1,4,0)
 ;;=4^M62.472
 ;;^UTILITY(U,$J,358.3,11760,2)
 ;;=^5012651
 ;;^UTILITY(U,$J,358.3,11761,0)
 ;;=M62.432^^50^541^17
 ;;^UTILITY(U,$J,358.3,11761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11761,1,3,0)
 ;;=3^Contracture of muscle, left forearm
 ;;^UTILITY(U,$J,358.3,11761,1,4,0)
 ;;=4^M62.432
 ;;^UTILITY(U,$J,358.3,11761,2)
 ;;=^5012639
 ;;^UTILITY(U,$J,358.3,11762,0)
 ;;=M62.442^^50^541^18
 ;;^UTILITY(U,$J,358.3,11762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11762,1,3,0)
 ;;=3^Contracture of muscle, left hand
 ;;^UTILITY(U,$J,358.3,11762,1,4,0)
 ;;=4^M62.442
 ;;^UTILITY(U,$J,358.3,11762,2)
 ;;=^5012642
 ;;^UTILITY(U,$J,358.3,11763,0)
 ;;=M62.462^^50^541^19
 ;;^UTILITY(U,$J,358.3,11763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11763,1,3,0)
 ;;=3^Contracture of muscle, left lower leg
 ;;^UTILITY(U,$J,358.3,11763,1,4,0)
 ;;=4^M62.462
 ;;^UTILITY(U,$J,358.3,11763,2)
 ;;=^5012648
 ;;^UTILITY(U,$J,358.3,11764,0)
 ;;=M62.412^^50^541^20
 ;;^UTILITY(U,$J,358.3,11764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11764,1,3,0)
 ;;=3^Contracture of muscle, left shoulder
 ;;^UTILITY(U,$J,358.3,11764,1,4,0)
 ;;=4^M62.412
 ;;^UTILITY(U,$J,358.3,11764,2)
 ;;=^5012633
 ;;^UTILITY(U,$J,358.3,11765,0)
 ;;=M62.452^^50^541^21
 ;;^UTILITY(U,$J,358.3,11765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11765,1,3,0)
 ;;=3^Contracture of muscle, left thigh
 ;;^UTILITY(U,$J,358.3,11765,1,4,0)
 ;;=4^M62.452
 ;;^UTILITY(U,$J,358.3,11765,2)
 ;;=^5012645
 ;;^UTILITY(U,$J,358.3,11766,0)
 ;;=M62.422^^50^541^22
 ;;^UTILITY(U,$J,358.3,11766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11766,1,3,0)
 ;;=3^Contracture of muscle, left upper arm
 ;;^UTILITY(U,$J,358.3,11766,1,4,0)
 ;;=4^M62.422
 ;;^UTILITY(U,$J,358.3,11766,2)
 ;;=^5012636
 ;;^UTILITY(U,$J,358.3,11767,0)
 ;;=M62.49^^50^541^23
 ;;^UTILITY(U,$J,358.3,11767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11767,1,3,0)
 ;;=3^Contracture of muscle, multiple sites
 ;;^UTILITY(U,$J,358.3,11767,1,4,0)
 ;;=4^M62.49
 ;;^UTILITY(U,$J,358.3,11767,2)
 ;;=^5012654
 ;;^UTILITY(U,$J,358.3,11768,0)
 ;;=M62.48^^50^541^24
 ;;^UTILITY(U,$J,358.3,11768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11768,1,3,0)
 ;;=3^Contracture of muscle, other site
 ;;^UTILITY(U,$J,358.3,11768,1,4,0)
 ;;=4^M62.48
 ;;^UTILITY(U,$J,358.3,11768,2)
 ;;=^5012653
 ;;^UTILITY(U,$J,358.3,11769,0)
 ;;=M62.471^^50^541^25
 ;;^UTILITY(U,$J,358.3,11769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11769,1,3,0)
 ;;=3^Contracture of muscle, right ankle and foot
 ;;^UTILITY(U,$J,358.3,11769,1,4,0)
 ;;=4^M62.471
 ;;^UTILITY(U,$J,358.3,11769,2)
 ;;=^5012650
 ;;^UTILITY(U,$J,358.3,11770,0)
 ;;=M62.431^^50^541^26
 ;;^UTILITY(U,$J,358.3,11770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11770,1,3,0)
 ;;=3^Contracture of muscle, right forearm
 ;;^UTILITY(U,$J,358.3,11770,1,4,0)
 ;;=4^M62.431
 ;;^UTILITY(U,$J,358.3,11770,2)
 ;;=^5012638
 ;;^UTILITY(U,$J,358.3,11771,0)
 ;;=M62.441^^50^541^27
 ;;^UTILITY(U,$J,358.3,11771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11771,1,3,0)
 ;;=3^Contracture of muscle, right hand
 ;;^UTILITY(U,$J,358.3,11771,1,4,0)
 ;;=4^M62.441
 ;;^UTILITY(U,$J,358.3,11771,2)
 ;;=^5012641
 ;;^UTILITY(U,$J,358.3,11772,0)
 ;;=M62.461^^50^541^28
 ;;^UTILITY(U,$J,358.3,11772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11772,1,3,0)
 ;;=3^Contracture of muscle, right lower leg
 ;;^UTILITY(U,$J,358.3,11772,1,4,0)
 ;;=4^M62.461
 ;;^UTILITY(U,$J,358.3,11772,2)
 ;;=^5012647
 ;;^UTILITY(U,$J,358.3,11773,0)
 ;;=M62.411^^50^541^29
 ;;^UTILITY(U,$J,358.3,11773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11773,1,3,0)
 ;;=3^Contracture of muscle, right shoulder
 ;;^UTILITY(U,$J,358.3,11773,1,4,0)
 ;;=4^M62.411
 ;;^UTILITY(U,$J,358.3,11773,2)
 ;;=^5012632
 ;;^UTILITY(U,$J,358.3,11774,0)
 ;;=M62.451^^50^541^30
 ;;^UTILITY(U,$J,358.3,11774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11774,1,3,0)
 ;;=3^Contracture of muscle, right thigh
 ;;^UTILITY(U,$J,358.3,11774,1,4,0)
 ;;=4^M62.451
 ;;^UTILITY(U,$J,358.3,11774,2)
 ;;=^5012644
 ;;^UTILITY(U,$J,358.3,11775,0)
 ;;=M62.421^^50^541^31
 ;;^UTILITY(U,$J,358.3,11775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11775,1,3,0)
 ;;=3^Contracture of muscle, right upper arm
 ;;^UTILITY(U,$J,358.3,11775,1,4,0)
 ;;=4^M62.421
 ;;^UTILITY(U,$J,358.3,11775,2)
 ;;=^5012635
 ;;^UTILITY(U,$J,358.3,11776,0)
 ;;=M25.262^^50^541^38
 ;;^UTILITY(U,$J,358.3,11776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11776,1,3,0)
 ;;=3^Flail joint, left knee
 ;;^UTILITY(U,$J,358.3,11776,1,4,0)
 ;;=4^M25.262
 ;;^UTILITY(U,$J,358.3,11776,2)
 ;;=^5011544
 ;;^UTILITY(U,$J,358.3,11777,0)
 ;;=M25.212^^50^541^39
 ;;^UTILITY(U,$J,358.3,11777,1,0)
 ;;=^358.31IA^4^2
