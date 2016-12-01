IBDEI0SA ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37358,1,3,0)
 ;;=3^Chronic diastolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,37358,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,37358,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,37359,0)
 ;;=J44.1^^106^1588^16
 ;;^UTILITY(U,$J,358.3,37359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37359,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease w (acute) exacerbation
 ;;^UTILITY(U,$J,358.3,37359,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,37359,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,37360,0)
 ;;=J44.9^^106^1588^17
 ;;^UTILITY(U,$J,358.3,37360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37360,1,3,0)
 ;;=3^Chronic obstructive pulmonary disease, unspecified
 ;;^UTILITY(U,$J,358.3,37360,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,37360,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,37361,0)
 ;;=I50.22^^106^1588^18
 ;;^UTILITY(U,$J,358.3,37361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37361,1,3,0)
 ;;=3^Chronic systolic (congestive) heart failure
 ;;^UTILITY(U,$J,358.3,37361,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,37361,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,37362,0)
 ;;=Z98.61^^106^1588^20
 ;;^UTILITY(U,$J,358.3,37362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37362,1,3,0)
 ;;=3^Coronary angioplasty status
 ;;^UTILITY(U,$J,358.3,37362,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,37362,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,37363,0)
 ;;=I42.0^^106^1588^22
 ;;^UTILITY(U,$J,358.3,37363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37363,1,3,0)
 ;;=3^Dilated cardiomyopathy
 ;;^UTILITY(U,$J,358.3,37363,1,4,0)
 ;;=4^I42.0
 ;;^UTILITY(U,$J,358.3,37363,2)
 ;;=^5007194
 ;;^UTILITY(U,$J,358.3,37364,0)
 ;;=J43.9^^106^1588^23
 ;;^UTILITY(U,$J,358.3,37364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37364,1,3,0)
 ;;=3^Emphysema, unspecified
 ;;^UTILITY(U,$J,358.3,37364,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,37364,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,37365,0)
 ;;=Z82.49^^106^1588^24
 ;;^UTILITY(U,$J,358.3,37365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37365,1,3,0)
 ;;=3^Family hx of ischem heart dis and oth dis of the circ sys
 ;;^UTILITY(U,$J,358.3,37365,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,37365,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,37366,0)
 ;;=I50.9^^106^1588^25
 ;;^UTILITY(U,$J,358.3,37366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37366,1,3,0)
 ;;=3^Heart failure, unspecified
 ;;^UTILITY(U,$J,358.3,37366,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,37366,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,37367,0)
 ;;=I25.2^^106^1588^27
 ;;^UTILITY(U,$J,358.3,37367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37367,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,37367,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,37367,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,37368,0)
 ;;=I42.8^^106^1588^12
 ;;^UTILITY(U,$J,358.3,37368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37368,1,3,0)
 ;;=3^Cardiomyopathies NEC
 ;;^UTILITY(U,$J,358.3,37368,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,37368,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,37369,0)
 ;;=I42.2^^106^1588^26
 ;;^UTILITY(U,$J,358.3,37369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37369,1,3,0)
 ;;=3^Hypertrophic cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,37369,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,37369,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,37370,0)
 ;;=I42.5^^106^1588^32
 ;;^UTILITY(U,$J,358.3,37370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37370,1,3,0)
 ;;=3^Restrictive cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,37370,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,37370,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,37371,0)
 ;;=Z95.1^^106^1588^29
 ;;^UTILITY(U,$J,358.3,37371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37371,1,3,0)
 ;;=3^Presence of aortocoronary bypass graft
 ;;^UTILITY(U,$J,358.3,37371,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,37371,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,37372,0)
 ;;=Z95.0^^106^1588^30
 ;;^UTILITY(U,$J,358.3,37372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37372,1,3,0)
 ;;=3^Presence of cardiac pacemaker
 ;;^UTILITY(U,$J,358.3,37372,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,37372,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,37373,0)
 ;;=Z95.5^^106^1588^31
 ;;^UTILITY(U,$J,358.3,37373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37373,1,3,0)
 ;;=3^Presence of coronary angioplasty implant and graft
 ;;^UTILITY(U,$J,358.3,37373,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,37373,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,37374,0)
 ;;=I21.3^^106^1588^33
 ;;^UTILITY(U,$J,358.3,37374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37374,1,3,0)
 ;;=3^ST elevation (STEMI) myocardial infarction of unsp site
 ;;^UTILITY(U,$J,358.3,37374,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,37374,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,37375,0)
 ;;=J43.0^^106^1588^35
 ;;^UTILITY(U,$J,358.3,37375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37375,1,3,0)
 ;;=3^Unilateral pulmonary emphysema [MacLeod's syndrome]
 ;;^UTILITY(U,$J,358.3,37375,1,4,0)
 ;;=4^J43.0
 ;;^UTILITY(U,$J,358.3,37375,2)
 ;;=^5008235
 ;;^UTILITY(U,$J,358.3,37376,0)
 ;;=I50.40^^106^1588^19
 ;;^UTILITY(U,$J,358.3,37376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37376,1,3,0)
 ;;=3^Combined systolic and diastolic (congestive) hrt fail,Unspec
 ;;^UTILITY(U,$J,358.3,37376,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,37376,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,37377,0)
 ;;=I50.30^^106^1588^21
 ;;^UTILITY(U,$J,358.3,37377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37377,1,3,0)
 ;;=3^Diastolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,37377,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,37377,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,37378,0)
 ;;=I50.20^^106^1588^34
 ;;^UTILITY(U,$J,358.3,37378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37378,1,3,0)
 ;;=3^Systolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,37378,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,37378,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,37379,0)
 ;;=T84.81XA^^106^1589^4
 ;;^UTILITY(U,$J,358.3,37379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37379,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,37379,1,4,0)
 ;;=4^T84.81XA
 ;;^UTILITY(U,$J,358.3,37379,2)
 ;;=^5055454
 ;;^UTILITY(U,$J,358.3,37380,0)
 ;;=T84.81XS^^106^1589^5
 ;;^UTILITY(U,$J,358.3,37380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37380,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,37380,1,4,0)
 ;;=4^T84.81XS
 ;;^UTILITY(U,$J,358.3,37380,2)
 ;;=^5055456
 ;;^UTILITY(U,$J,358.3,37381,0)
 ;;=T84.81XD^^106^1589^6
 ;;^UTILITY(U,$J,358.3,37381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37381,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,37381,1,4,0)
 ;;=4^T84.81XD
 ;;^UTILITY(U,$J,358.3,37381,2)
 ;;=^5055455
 ;;^UTILITY(U,$J,358.3,37382,0)
 ;;=T84.82XA^^106^1589^7
 ;;^UTILITY(U,$J,358.3,37382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37382,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,37382,1,4,0)
 ;;=4^T84.82XA
 ;;^UTILITY(U,$J,358.3,37382,2)
 ;;=^5055457
 ;;^UTILITY(U,$J,358.3,37383,0)
 ;;=T84.82XD^^106^1589^8
 ;;^UTILITY(U,$J,358.3,37383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37383,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,37383,1,4,0)
 ;;=4^T84.82XD
 ;;^UTILITY(U,$J,358.3,37383,2)
 ;;=^5055458
 ;;^UTILITY(U,$J,358.3,37384,0)
 ;;=T84.82XS^^106^1589^9
 ;;^UTILITY(U,$J,358.3,37384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37384,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,37384,1,4,0)
 ;;=4^T84.82XS
 ;;^UTILITY(U,$J,358.3,37384,2)
 ;;=^5055459
 ;;^UTILITY(U,$J,358.3,37385,0)
 ;;=T84.83XA^^106^1589^10
 ;;^UTILITY(U,$J,358.3,37385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37385,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,37385,1,4,0)
 ;;=4^T84.83XA
 ;;^UTILITY(U,$J,358.3,37385,2)
 ;;=^5055460
 ;;^UTILITY(U,$J,358.3,37386,0)
 ;;=T84.83XD^^106^1589^11
 ;;^UTILITY(U,$J,358.3,37386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37386,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,37386,1,4,0)
 ;;=4^T84.83XD
 ;;^UTILITY(U,$J,358.3,37386,2)
 ;;=^5055461
 ;;^UTILITY(U,$J,358.3,37387,0)
 ;;=T84.83XS^^106^1589^12
 ;;^UTILITY(U,$J,358.3,37387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37387,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,37387,1,4,0)
 ;;=4^T84.83XS
 ;;^UTILITY(U,$J,358.3,37387,2)
 ;;=^5055462
 ;;^UTILITY(U,$J,358.3,37388,0)
 ;;=T84.89XA^^106^1589^1
 ;;^UTILITY(U,$J,358.3,37388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37388,1,3,0)
 ;;=3^Comp of internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,37388,1,4,0)
 ;;=4^T84.89XA
 ;;^UTILITY(U,$J,358.3,37388,2)
 ;;=^5055472
 ;;^UTILITY(U,$J,358.3,37389,0)
 ;;=T84.89XD^^106^1589^2
 ;;^UTILITY(U,$J,358.3,37389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37389,1,3,0)
 ;;=3^Comp of internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,37389,1,4,0)
 ;;=4^T84.89XD
 ;;^UTILITY(U,$J,358.3,37389,2)
 ;;=^5055473
 ;;^UTILITY(U,$J,358.3,37390,0)
 ;;=T84.89XS^^106^1589^3
 ;;^UTILITY(U,$J,358.3,37390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37390,1,3,0)
 ;;=3^Comp of internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,37390,1,4,0)
 ;;=4^T84.89XS
 ;;^UTILITY(U,$J,358.3,37390,2)
 ;;=^5055474
 ;;^UTILITY(U,$J,358.3,37391,0)
 ;;=T84.84XA^^106^1589^13
 ;;^UTILITY(U,$J,358.3,37391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37391,1,3,0)
 ;;=3^Pain due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,37391,1,4,0)
 ;;=4^T84.84XA
 ;;^UTILITY(U,$J,358.3,37391,2)
 ;;=^5055463
