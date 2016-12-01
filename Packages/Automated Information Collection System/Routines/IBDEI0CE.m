IBDEI0CE ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15703,0)
 ;;=Z82.49^^47^704^24
 ;;^UTILITY(U,$J,358.3,15703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15703,1,3,0)
 ;;=3^Family hx of ischem heart dis and oth dis of the circ sys
 ;;^UTILITY(U,$J,358.3,15703,1,4,0)
 ;;=4^Z82.49
 ;;^UTILITY(U,$J,358.3,15703,2)
 ;;=^5063369
 ;;^UTILITY(U,$J,358.3,15704,0)
 ;;=I50.9^^47^704^25
 ;;^UTILITY(U,$J,358.3,15704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15704,1,3,0)
 ;;=3^Heart failure, unspecified
 ;;^UTILITY(U,$J,358.3,15704,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,15704,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,15705,0)
 ;;=I25.2^^47^704^27
 ;;^UTILITY(U,$J,358.3,15705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15705,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,15705,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,15705,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,15706,0)
 ;;=I42.8^^47^704^12
 ;;^UTILITY(U,$J,358.3,15706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15706,1,3,0)
 ;;=3^Cardiomyopathies NEC
 ;;^UTILITY(U,$J,358.3,15706,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,15706,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,15707,0)
 ;;=I42.2^^47^704^26
 ;;^UTILITY(U,$J,358.3,15707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15707,1,3,0)
 ;;=3^Hypertrophic cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,15707,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,15707,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,15708,0)
 ;;=I42.5^^47^704^32
 ;;^UTILITY(U,$J,358.3,15708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15708,1,3,0)
 ;;=3^Restrictive cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,15708,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,15708,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,15709,0)
 ;;=Z95.1^^47^704^29
 ;;^UTILITY(U,$J,358.3,15709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15709,1,3,0)
 ;;=3^Presence of aortocoronary bypass graft
 ;;^UTILITY(U,$J,358.3,15709,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,15709,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,15710,0)
 ;;=Z95.0^^47^704^30
 ;;^UTILITY(U,$J,358.3,15710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15710,1,3,0)
 ;;=3^Presence of cardiac pacemaker
 ;;^UTILITY(U,$J,358.3,15710,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,15710,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,15711,0)
 ;;=Z95.5^^47^704^31
 ;;^UTILITY(U,$J,358.3,15711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15711,1,3,0)
 ;;=3^Presence of coronary angioplasty implant and graft
 ;;^UTILITY(U,$J,358.3,15711,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,15711,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,15712,0)
 ;;=I21.3^^47^704^33
 ;;^UTILITY(U,$J,358.3,15712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15712,1,3,0)
 ;;=3^ST elevation (STEMI) myocardial infarction of unsp site
 ;;^UTILITY(U,$J,358.3,15712,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,15712,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,15713,0)
 ;;=J43.0^^47^704^35
 ;;^UTILITY(U,$J,358.3,15713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15713,1,3,0)
 ;;=3^Unilateral pulmonary emphysema [MacLeod's syndrome]
 ;;^UTILITY(U,$J,358.3,15713,1,4,0)
 ;;=4^J43.0
 ;;^UTILITY(U,$J,358.3,15713,2)
 ;;=^5008235
 ;;^UTILITY(U,$J,358.3,15714,0)
 ;;=I50.40^^47^704^19
 ;;^UTILITY(U,$J,358.3,15714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15714,1,3,0)
 ;;=3^Combined systolic and diastolic (congestive) hrt fail,Unspec
 ;;^UTILITY(U,$J,358.3,15714,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,15714,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,15715,0)
 ;;=I50.30^^47^704^21
 ;;^UTILITY(U,$J,358.3,15715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15715,1,3,0)
 ;;=3^Diastolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,15715,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,15715,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,15716,0)
 ;;=I50.20^^47^704^34
 ;;^UTILITY(U,$J,358.3,15716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15716,1,3,0)
 ;;=3^Systolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,15716,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,15716,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,15717,0)
 ;;=T84.81XA^^47^705^4
 ;;^UTILITY(U,$J,358.3,15717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15717,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,15717,1,4,0)
 ;;=4^T84.81XA
 ;;^UTILITY(U,$J,358.3,15717,2)
 ;;=^5055454
 ;;^UTILITY(U,$J,358.3,15718,0)
 ;;=T84.81XS^^47^705^5
 ;;^UTILITY(U,$J,358.3,15718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15718,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,15718,1,4,0)
 ;;=4^T84.81XS
 ;;^UTILITY(U,$J,358.3,15718,2)
 ;;=^5055456
 ;;^UTILITY(U,$J,358.3,15719,0)
 ;;=T84.81XD^^47^705^6
 ;;^UTILITY(U,$J,358.3,15719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15719,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,15719,1,4,0)
 ;;=4^T84.81XD
 ;;^UTILITY(U,$J,358.3,15719,2)
 ;;=^5055455
 ;;^UTILITY(U,$J,358.3,15720,0)
 ;;=T84.82XA^^47^705^7
 ;;^UTILITY(U,$J,358.3,15720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15720,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,15720,1,4,0)
 ;;=4^T84.82XA
 ;;^UTILITY(U,$J,358.3,15720,2)
 ;;=^5055457
 ;;^UTILITY(U,$J,358.3,15721,0)
 ;;=T84.82XD^^47^705^8
 ;;^UTILITY(U,$J,358.3,15721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15721,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,15721,1,4,0)
 ;;=4^T84.82XD
 ;;^UTILITY(U,$J,358.3,15721,2)
 ;;=^5055458
 ;;^UTILITY(U,$J,358.3,15722,0)
 ;;=T84.82XS^^47^705^9
 ;;^UTILITY(U,$J,358.3,15722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15722,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,15722,1,4,0)
 ;;=4^T84.82XS
 ;;^UTILITY(U,$J,358.3,15722,2)
 ;;=^5055459
 ;;^UTILITY(U,$J,358.3,15723,0)
 ;;=T84.83XA^^47^705^10
 ;;^UTILITY(U,$J,358.3,15723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15723,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,15723,1,4,0)
 ;;=4^T84.83XA
 ;;^UTILITY(U,$J,358.3,15723,2)
 ;;=^5055460
 ;;^UTILITY(U,$J,358.3,15724,0)
 ;;=T84.83XD^^47^705^11
 ;;^UTILITY(U,$J,358.3,15724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15724,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,15724,1,4,0)
 ;;=4^T84.83XD
 ;;^UTILITY(U,$J,358.3,15724,2)
 ;;=^5055461
 ;;^UTILITY(U,$J,358.3,15725,0)
 ;;=T84.83XS^^47^705^12
 ;;^UTILITY(U,$J,358.3,15725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15725,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,15725,1,4,0)
 ;;=4^T84.83XS
 ;;^UTILITY(U,$J,358.3,15725,2)
 ;;=^5055462
 ;;^UTILITY(U,$J,358.3,15726,0)
 ;;=T84.89XA^^47^705^1
 ;;^UTILITY(U,$J,358.3,15726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15726,1,3,0)
 ;;=3^Comp of internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,15726,1,4,0)
 ;;=4^T84.89XA
 ;;^UTILITY(U,$J,358.3,15726,2)
 ;;=^5055472
 ;;^UTILITY(U,$J,358.3,15727,0)
 ;;=T84.89XD^^47^705^2
 ;;^UTILITY(U,$J,358.3,15727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15727,1,3,0)
 ;;=3^Comp of internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,15727,1,4,0)
 ;;=4^T84.89XD
 ;;^UTILITY(U,$J,358.3,15727,2)
 ;;=^5055473
 ;;^UTILITY(U,$J,358.3,15728,0)
 ;;=T84.89XS^^47^705^3
 ;;^UTILITY(U,$J,358.3,15728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15728,1,3,0)
 ;;=3^Comp of internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,15728,1,4,0)
 ;;=4^T84.89XS
 ;;^UTILITY(U,$J,358.3,15728,2)
 ;;=^5055474
 ;;^UTILITY(U,$J,358.3,15729,0)
 ;;=T84.84XA^^47^705^13
 ;;^UTILITY(U,$J,358.3,15729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15729,1,3,0)
 ;;=3^Pain due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,15729,1,4,0)
 ;;=4^T84.84XA
 ;;^UTILITY(U,$J,358.3,15729,2)
 ;;=^5055463
 ;;^UTILITY(U,$J,358.3,15730,0)
 ;;=T84.84XD^^47^705^14
 ;;^UTILITY(U,$J,358.3,15730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15730,1,3,0)
 ;;=3^Pain due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,15730,1,4,0)
 ;;=4^T84.84XD
 ;;^UTILITY(U,$J,358.3,15730,2)
 ;;=^5055464
 ;;^UTILITY(U,$J,358.3,15731,0)
 ;;=T84.84XS^^47^705^15
 ;;^UTILITY(U,$J,358.3,15731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15731,1,3,0)
 ;;=3^Pain due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,15731,1,4,0)
 ;;=4^T84.84XS
 ;;^UTILITY(U,$J,358.3,15731,2)
 ;;=^5055465
 ;;^UTILITY(U,$J,358.3,15732,0)
 ;;=T84.85XA^^47^705^16
 ;;^UTILITY(U,$J,358.3,15732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15732,1,3,0)
 ;;=3^Stenosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,15732,1,4,0)
 ;;=4^T84.85XA
 ;;^UTILITY(U,$J,358.3,15732,2)
 ;;=^5055466
 ;;^UTILITY(U,$J,358.3,15733,0)
 ;;=T84.85XD^^47^705^17
 ;;^UTILITY(U,$J,358.3,15733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15733,1,3,0)
 ;;=3^Stenosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,15733,1,4,0)
 ;;=4^T84.85XD
 ;;^UTILITY(U,$J,358.3,15733,2)
 ;;=^5055467
 ;;^UTILITY(U,$J,358.3,15734,0)
 ;;=T84.85XS^^47^705^18
 ;;^UTILITY(U,$J,358.3,15734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15734,1,3,0)
 ;;=3^Stenosis due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,15734,1,4,0)
 ;;=4^T84.85XS
 ;;^UTILITY(U,$J,358.3,15734,2)
 ;;=^5055468
 ;;^UTILITY(U,$J,358.3,15735,0)
 ;;=T84.86XA^^47^705^20
 ;;^UTILITY(U,$J,358.3,15735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15735,1,3,0)
 ;;=3^Thrombosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,15735,1,4,0)
 ;;=4^T84.86XA
 ;;^UTILITY(U,$J,358.3,15735,2)
 ;;=^5055469
 ;;^UTILITY(U,$J,358.3,15736,0)
 ;;=T84.86XD^^47^705^21
 ;;^UTILITY(U,$J,358.3,15736,1,0)
 ;;=^358.31IA^4^2
